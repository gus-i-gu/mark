import { readFileSync } from "node:fs";
import Fastify from "fastify";
import pg from "pg";
import { exportJWK, generateKeyPair, SignJWT } from "jose";
import { canonicalHash } from "./domain/protocol.js";
import { buildApp } from "./http/app.js";
import { Auth0JwtVerifier } from "./application/jwt_verifier.js";
import {
  HostedAuthVerifier,
  HostedIdentityService,
} from "./application/hosted_authorization.js";
import { systemClock } from "./application/hosted_contracts.js";

const databaseUrl = process.env.MARKEI_SYNC_DATABASE_URL;
if (!databaseUrl) {
  throw new Error(
    "MARKEI_SYNC_DATABASE_URL is required for hosted-local proof",
  );
}

const accountId = "11111111-1111-4111-8111-111111111111";
const identityA = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";
const identityB = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb";
const installationA = "33333333-3333-4333-8333-333333333333";
const installationB = "44444444-4444-4444-8444-444444444444";
const enrollmentA = "55555555-5555-4555-8555-555555555555";
const enrollmentB = "66666666-6666-4666-8666-666666666666";
const submissionId = "77777777-7777-4777-8777-777777777777";

const keys = await generateKeyPair("RS256", { extractable: true });
const publicJwk = await exportJWK(keys.publicKey);
publicJwk.kid = "local-key-1";
publicJwk.alg = "RS256";
publicJwk.use = "sig";

const jwks = Fastify({ logger: false });
jwks.get("/.well-known/jwks.json", async () => ({ keys: [publicJwk] }));
await jwks.listen({ host: "127.0.0.1", port: 0 });
const jwksPort = (jwks.server.address() as { port: number }).port;
const issuer = `http://127.0.0.1:${jwksPort}/`;
const audience = "markei-sync-api";

const pool = new pg.Pool({ connectionString: databaseUrl, max: 4 });
try {
  await migrate(pool);
  await seed(pool);
  const database = { pool };
  const verifier = new Auth0JwtVerifier({
    issuer,
    audience,
    jwksUri: `${issuer}.well-known/jwks.json`,
    clock: systemClock,
  });
  const hosted = new HostedIdentityService(database, verifier, systemClock);
  const app = buildApp({
    auth: new HostedAuthVerifier(database, verifier),
    database,
    hosted,
  });
  await app.listen({ host: "127.0.0.1", port: 0 });
  const apiPort = (app.server.address() as { port: number }).port;
  const origin = `http://127.0.0.1:${apiPort}`;
  const tokenA = await token("auth0|principal-a");
  const tokenB = await token("auth0|principal-b");
  const enrollA = await post(`${origin}/v1/devices/enroll`, tokenA, {
    contractVersion: 1,
    installationId: installationA,
    enrollmentRequestId: enrollmentA,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  const replayA = await post(`${origin}/v1/devices/enroll`, tokenA, {
    contractVersion: 1,
    installationId: installationA,
    enrollmentRequestId: enrollmentA,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  if (enrollA.deviceId !== replayA.deviceId)
    throw new Error("replay changed DeviceId");
  const conflict = await postRaw(`${origin}/v1/devices/enroll`, tokenA, {
    contractVersion: 1,
    installationId: installationB,
    enrollmentRequestId: enrollmentA,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  if (conflict.status !== 200 || conflict.body.code !== "conflict") {
    throw new Error("conflicting replay was not denied");
  }
  const enrollB = await post(`${origin}/v1/devices/enroll`, tokenB, {
    contractVersion: 1,
    installationId: installationB,
    enrollmentRequestId: enrollmentB,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  const event = purchaseEvent(enrollA.deviceId);
  const upload = await post(
    `${origin}/v1/sync/submissions`,
    tokenA,
    {
      submissionId,
      deviceId: enrollA.deviceId,
      requestHash: canonicalHash({
        submissionId,
        deviceId: enrollA.deviceId,
        events: [event],
      }),
      events: [event],
    },
    enrollA.deviceId,
  );
  if (upload.status !== "server-accepted") throw new Error("upload failed");
  const page = await get(
    `${origin}/v1/sync/events?after=c10b:0&limit=10`,
    tokenB,
    enrollB.deviceId,
  );
  if (page.events.length !== 1) throw new Error("download did not converge");
  await post(
    `${origin}/v1/sync/acknowledgements`,
    tokenB,
    {
      greatestContiguousCursor: page.nextCursor,
    },
    enrollB.deviceId,
  );
  await post(
    `${origin}/v1/devices/${enrollB.deviceId}/revoke`,
    tokenA,
    {},
    enrollA.deviceId,
  );
  const denied = await getRaw(
    `${origin}/v1/sync/events?after=c10b:0`,
    tokenB,
    enrollB.deviceId,
  );
  if (denied.status !== 403) throw new Error("revoked Device was not denied");
  await app.close();
  process.stdout.write("HOSTED_AUTH_READY=true\n");
} finally {
  await pool.end().catch(() => undefined);
  await jwks.close().catch(() => undefined);
}

async function migrate(pool: pg.Pool) {
  const client = await pool.connect();
  try {
    for (const id of [
      "001_init",
      "002_coordination_hardening",
      "003_retention_snapshot_recovery",
      "004_hosted_identity_enrollment",
    ]) {
      const path = new URL(`../migrations/${id}.sql`, import.meta.url);
      await client.query(readFileSync(path, "utf8"));
    }
  } finally {
    client.release();
  }
}

async function seed(pool: pg.Pool) {
  await pool.query(
    `insert into accounts(account_id) values($1) on conflict do nothing`,
    [accountId],
  );
  await pool.query(
    `insert into account_cursor_state(account_id, next_cursor)
     values($1,1) on conflict do nothing`,
    [accountId],
  );
  for (const [id, subject] of [
    [identityA, "auth0|principal-a"],
    [identityB, "auth0|principal-b"],
  ]) {
    await pool.query(
      `insert into external_identities(identity_id, issuer, subject, status)
       values($1,$2,$3,'active') on conflict do nothing`,
      [id, issuer, subject],
    );
    await pool.query(
      `insert into account_memberships(account_id, identity_id, role, status)
       values($1,$2,$3,'active') on conflict do nothing`,
      [accountId, id, id === identityA ? "owner" : "member"],
    );
  }
}

async function token(subject: string) {
  return new SignJWT({})
    .setProtectedHeader({ alg: "RS256", kid: "local-key-1" })
    .setIssuer(issuer)
    .setAudience(audience)
    .setSubject(subject)
    .setIssuedAt()
    .setExpirationTime("10m")
    .sign(keys.privateKey);
}

async function post(
  url: string,
  token: string,
  body: unknown,
  deviceId?: string,
) {
  const response = await postRaw(url, token, body, deviceId);
  if (response.status >= 400) throw new Error(`POST failed ${response.status}`);
  return response.body;
}

async function get(url: string, token: string, deviceId?: string) {
  const response = await getRaw(url, token, deviceId);
  if (response.status >= 400) throw new Error(`GET failed ${response.status}`);
  return response.body;
}

async function postRaw(
  url: string,
  token: string,
  body: unknown,
  deviceId?: string,
) {
  const response = await fetch(url, {
    method: "POST",
    headers: headers(token, deviceId),
    body: JSON.stringify(body),
  });
  return { status: response.status, body: await response.json() };
}

async function getRaw(url: string, token: string, deviceId?: string) {
  const response = await fetch(url, { headers: headers(token, deviceId) });
  return { status: response.status, body: await response.json() };
}

function headers(token: string, deviceId?: string) {
  return {
    authorization: `Bearer ${token}`,
    "content-type": "application/json",
    ...(deviceId ? { "x-markei-device-id": deviceId } : {}),
  };
}

function purchaseEvent(deviceId: string) {
  const event = {
    eventId: "88888888-8888-4888-8888-888888888888",
    accountId,
    deviceId,
    deviceSequence: 1,
    eventType: "purchase.registered",
    payloadVersion: 3,
    occurrenceTime: "2026-07-15T00:00:00.000Z",
    payload: {
      purchase: {
        id: "99999999-9999-4999-8999-999999999999",
        store: {
          id: "12121212-1212-4212-8212-121212121212",
          displayName: "Synthetic",
        },
        items: [],
      },
      productSnapshots: [],
    },
  };
  return { ...event, contentHash: canonicalHash(event) };
}
