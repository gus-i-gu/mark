import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";
import { canonicalHash } from "../src/domain/protocol.js";
import {
  FixtureAuthVerifier,
  RefusingAuthVerifier,
} from "../src/application/auth.js";
import { buildApp, type LifecycleLogEvent } from "../src/http/app.js";

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
