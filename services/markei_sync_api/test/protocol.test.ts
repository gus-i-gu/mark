import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";
import { canonicalHash } from "../src/domain/protocol.js";
import {
  FixtureAuthVerifier,
  RefusingAuthVerifier,
} from "../src/application/auth.js";
import { buildApp } from "../src/http/app.js";

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
