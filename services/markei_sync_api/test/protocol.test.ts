import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";
import { canonicalHash } from "../src/domain/protocol.js";
import {
  FixtureAuthVerifier,
  RefusingAuthVerifier,
} from "../src/application/auth.js";
import { buildApp, type LifecycleLogEvent } from "../src/http/app.js";
import type { PoolClient } from "pg";

const accountId = "11111111-1111-4111-8111-111111111111";
const deviceId = "22222222-2222-4222-8222-222222222222";

function submissionEvent(sequence: number) {
  const event = {
    eventId: `33333333-3333-4333-8333-33333333333${sequence}`,
    accountId,
    deviceId,
    deviceSequence: sequence,
    eventType: "purchase.registered",
    payloadVersion: 3,
    occurrenceTime: "2026-07-22T00:00:00.000Z",
    payload: { fixture: sequence },
  };
  return { ...event, contentHash: canonicalHash(event) };
}

function submissionBody() {
  const events = [submissionEvent(1), submissionEvent(2)];
  return {
    submissionId: "44444444-4444-4444-8444-444444444444",
    deviceId,
    requestHash: canonicalHash({ events }),
    events,
  };
}

function databaseWithoutCursorState() {
  const queries: string[] = [];
  const client = {
    query: async (sql: string) => {
      queries.push(sql);
      if (sql.startsWith("select request_hash")) {
        return { rows: [], rowCount: 0 };
      }
      if (sql.startsWith("select content_hash")) {
        return { rows: [], rowCount: 0 };
      }
      if (sql.startsWith("select next_expected_sequence")) {
        return { rows: [{ next_expected_sequence: 1 }], rowCount: 1 };
      }
      if (sql.startsWith("update account_cursor_state")) {
        return { rows: [], rowCount: 0 };
      }
      return { rows: [], rowCount: 0 };
    },
    release: () => undefined,
  } as unknown as PoolClient;
  return {
    queries,
    pool: {
      connect: async () => client,
    } as never,
  };
}

function databaseThatThrowsDuringSubmission() {
  const client = {
    query: async (sql: string) => {
      if (sql.startsWith("select request_hash")) {
        throw new Error("redacted fixture failure");
      }
      return { rows: [], rowCount: 0 };
    },
    release: () => undefined,
  } as unknown as PoolClient;
  return {
    pool: {
      connect: async () => client,
    } as never,
  };
}

test("v3 fixture hash matches TypeScript canonical serialization", () => {
  const event = JSON.parse(
    readFileSync(
      "../../contracts/shared_beta/v3/fixtures/purchase_registered.valid.json",
      "utf8",
    ),
  );
  const { contentHash, ...content } = event;
  assert.equal(contentHash, canonicalHash(content));
});

test("recovery format 1 fixture hash is independent from v3 event payload", () => {
  const manifest = JSON.parse(
    readFileSync(
      "../../contracts/shared_beta/recovery_v1/fixtures/recovery_manifest.valid.json",
      "utf8",
    ),
  );
  assert.equal(manifest.formatVersion, 1);
  assert.equal(manifest.compatibleEventTypes[0].payloadVersion, 3);
  assert.equal(canonicalHash(manifest).length, 64);
});

test("normal runtime auth verifier refuses fixture escape", async () => {
  await assert.rejects(new RefusingAuthVerifier().verify());
});

test("fixture auth is injectable only by direct test construction", async () => {
  const app = buildApp({
    authorization: {
      kind: "fixture",
      verifier: new FixtureAuthVerifier({
        accountId: "11111111-1111-4111-8111-111111111111",
        deviceId: "22222222-2222-4222-8222-222222222222",
      }),
    },
  });
  const response = await app.inject({ method: "GET", url: "/health/live" });
  assert.equal(response.statusCode, 200);
});

test("recovery routes are unavailable without explicit recovery composition", async () => {
  const app = buildApp({
    authorization: {
      kind: "fixture",
      verifier: new FixtureAuthVerifier({
        accountId: "11111111-1111-4111-8111-111111111111",
        deviceId: "22222222-2222-4222-8222-222222222222",
      }),
    },
  });
  const response = await app.inject({
    method: "GET",
    url: "/v1/sync/capabilities",
  });
  assert.equal(response.statusCode, 503);
  const body = response.json() as { code: string; operation: string };
  assert.equal(body.code, "service-unavailable");
  assert.equal(body.operation, "capabilities");
});

test("health lifecycle logs are sanitized and correlated by fingerprint", async () => {
  const events: LifecycleLogEvent[] = [];
  const app = buildApp({
    authorization: { kind: "disabled" },
    lifecycleObserver: (event) => events.push(event),
  });

  const response = await app.inject({
    method: "GET",
    url: "/health/live",
    headers: { "x-correlation-id": "abc\r\nx-secret: value" },
  });

  assert.equal(response.statusCode, 200);
  assert.deepEqual(
    events.map((event) => event.event),
    ["request-received", "operation-validation-started", "response-completed"],
  );
  for (const event of events) {
    assert.equal(event.routeClass, "/health/live");
    assert.equal(event.operation, "health-live");
    assert.equal(event.method, "GET");
    assert.match(event.correlationFingerprint, /^[a-f0-9]{8}$/);
    assert.equal(JSON.stringify(event).includes("x-secret"), false);
    assert.equal(JSON.stringify(event).includes("abc\r\n"), false);
  }
});

test("lifecycle observer failure does not alter health response", async () => {
  const app = buildApp({
    authorization: { kind: "disabled" },
    lifecycleObserver: () => {
      throw new Error("redacted");
    },
  });

  const response = await app.inject({ method: "GET", url: "/health/live" });

  assert.equal(response.statusCode, 200);
  assert.deepEqual(response.json(), { status: "live" });
});

test("protected route authentication rejection is lifecycle logged", async () => {
  const events: LifecycleLogEvent[] = [];
  const app = buildApp({
    authorization: { kind: "disabled" },
    database: {
      pool: {
        query: async () => ({ rows: [], rowCount: 0 }),
      } as never,
    },
    lifecycleObserver: (event) => events.push(event),
  });

  const response = await app.inject({
    method: "GET",
    url: "/v1/sync/events",
  });

  assert.equal(response.statusCode, 401);
  assert.equal(
    events.some(
      (event) =>
        event.event === "authentication-rejected" &&
        event.operation === "download-events" &&
        event.result === "authentication-required",
    ),
    true,
  );
  for (const event of events) {
    const serialized = JSON.stringify(event);
    assert.equal(serialized.includes("/v1/sync/events?"), false);
    assert.equal(serialized.includes("authorization"), false);
  }
});

test("protected submission fails closed when account cursor state is missing", async () => {
  const events: LifecycleLogEvent[] = [];
  const database = databaseWithoutCursorState();
  const app = buildApp({
    authorization: {
      kind: "fixture",
      verifier: new FixtureAuthVerifier({ accountId, deviceId }),
    },
    database,
    lifecycleObserver: (event) => events.push(event),
  });

  const response = await app.inject({
    method: "POST",
    url: "/v1/sync/submissions",
    headers: { "x-correlation-id": "submission-500-diagnosis" },
    payload: submissionBody(),
  });

  assert.equal(response.statusCode, 503);
  assert.deepEqual(response.json(), {
    code: "service-unavailable",
    operation: "upload-submission",
    outcome: "not-applied",
    retryable: false,
    safeAction: "stop and preserve evidence",
    correlationId: "submission-500-diagnosis",
  });
  assert.equal(
    database.queries.some((sql) => sql.startsWith("insert into sync_events")),
    false,
  );
  assert.equal(
    database.queries.some((sql) => sql.startsWith("insert into submissions")),
    false,
  );
  assert.equal(database.queries.includes("rollback"), false);
  assert.equal(database.queries.includes("commit"), true);
  assert.equal(
    events.some(
      (event) => event.event === "response-completed" && event.status === 503,
    ),
    true,
  );
  assert.equal(
    events.some(
      (event) =>
        event.event === "request-failed" &&
        event.status !== undefined &&
        event.status < 400,
    ),
    false,
  );
});

test("unexpected protected submission failures do not log successful request-failed status", async () => {
  const events: LifecycleLogEvent[] = [];
  const app = buildApp({
    authorization: {
      kind: "fixture",
      verifier: new FixtureAuthVerifier({ accountId, deviceId }),
    },
    database: databaseThatThrowsDuringSubmission(),
    lifecycleObserver: (event) => events.push(event),
  });

  const response = await app.inject({
    method: "POST",
    url: "/v1/sync/submissions",
    headers: { "x-correlation-id": "submission-500-lifecycle" },
    payload: submissionBody(),
  });

  assert.equal(response.statusCode, 500);
  assert.equal(response.json().code, "service-unavailable");
  const failed = events.filter((event) => event.event === "request-failed");
  assert.equal(failed.length, 1);
  assert.notEqual(failed[0].status, 200);
  assert.equal(failed[0].result, "unexpected-server-error");
  assert.equal(
    events.some(
      (event) => event.event === "response-completed" && event.status === 500,
    ),
    true,
  );
  for (const event of events) {
    const serialized = JSON.stringify(event);
    assert.equal(serialized.includes("redacted fixture failure"), false);
    assert.equal(serialized.includes("submission-500-lifecycle"), false);
  }
});
