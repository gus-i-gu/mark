import { readFileSync } from "node:fs";
import Fastify from "fastify";
import pg from "pg";
import { exportJWK, generateKeyPair, SignJWT } from "jose";
import { canonicalHash } from "./domain/protocol.js";
import { buildApp } from "./http/app.js";
import { Auth0JwtVerifier } from "./application/jwt_verifier.js";
import {
  HostedIdentityService,
  HostedTransactionAuthorizer,
} from "./application/hosted_authorization.js";
import { systemClock } from "./application/hosted_contracts.js";

const labMigratorUrl = process.env.LAB_MIGRATOR_URL;
const labRuntimeUrl = process.env.LAB_RUNTIME_URL;
if (!labMigratorUrl || !labRuntimeUrl) {
  throw new Error(
    "LAB_MIGRATOR_URL and LAB_RUNTIME_URL are required for hosted-local proof",
  );
}

const accountA = "11111111-1111-4111-8111-111111111111";
const accountB = "22222222-2222-4222-8222-222222222222";
const identityA = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";
const identityB = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb";
const installationA1 = "33333333-3333-4333-8333-333333333333";
const installationA2 = "44444444-4444-4444-8444-444444444444";
const installationB1 = "55555555-5555-4555-8555-555555555555";
const enrollmentA1 = "66666666-6666-4666-8666-666666666666";
const enrollmentA2 = "77777777-7777-4777-8777-777777777777";
const enrollmentB1 = "88888888-8888-4888-8888-888888888888";
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

const migratorPool = new pg.Pool({ connectionString: labMigratorUrl, max: 1 });
const pool = new pg.Pool({ connectionString: labRuntimeUrl, max: 4 });
try {
  await migrate(migratorPool);
  await seed(migratorPool);
  await migratorPool.end();
  const database = { pool };
  const verifier = new Auth0JwtVerifier({
    issuer,
    audience,
    jwksUri: `${issuer}.well-known/jwks.json`,
    clock: systemClock,
  });
  const hosted = new HostedIdentityService(database, verifier, systemClock);
  const app = buildApp({
    authorization: {
      kind: "hosted",
      identityService: hosted,
      transactionAuthorizer: new HostedTransactionAuthorizer(
        database,
        verifier,
      ),
    },
    database,
  });
  await app.listen({ host: "127.0.0.1", port: 0 });
  const apiPort = (app.server.address() as { port: number }).port;
  const origin = `http://127.0.0.1:${apiPort}`;
  const tokenA = await token("auth0|principal-a");
  const tokenB = await token("auth0|principal-b");
  const identityAResult = await get(`${origin}/v1/identity`, tokenA);
  const identityBResult = await get(`${origin}/v1/identity`, tokenB);
  if (identityAResult.accountId !== accountA) {
    throw new Error("principal A resolved outside Account A");
  }
  if (identityBResult.accountId !== accountB) {
    throw new Error("principal B resolved outside Account B");
  }
  const enrollA = await post(`${origin}/v1/devices/enroll`, tokenA, {
    contractVersion: 1,
    installationId: installationA1,
    enrollmentRequestId: enrollmentA1,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  const replayA = await post(`${origin}/v1/devices/enroll`, tokenA, {
    contractVersion: 1,
    installationId: installationA1,
    enrollmentRequestId: enrollmentA1,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  if (enrollA.deviceId !== replayA.deviceId)
    throw new Error("replay changed DeviceId");
  const conflict = await postRaw(`${origin}/v1/devices/enroll`, tokenA, {
    contractVersion: 1,
    installationId: installationA2,
    enrollmentRequestId: enrollmentA1,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  if (conflict.status !== 409 || conflict.body.code !== "conflict") {
    throw new Error("conflicting replay was not denied");
  }
  const enrollA2 = await post(`${origin}/v1/devices/enroll`, tokenA, {
    contractVersion: 1,
    installationId: installationA2,
    enrollmentRequestId: enrollmentA2,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  if (enrollA2.deviceId === enrollA.deviceId) {
    throw new Error("A1 and A2 did not create distinct Devices");
  }
  const enrollB = await post(`${origin}/v1/devices/enroll`, tokenB, {
    contractVersion: 1,
    installationId: installationB1,
    enrollmentRequestId: enrollmentB1,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
  if (enrollB.accountId !== accountB) {
    throw new Error("B1 enrollment resolved outside Account B");
  }
  const event = purchaseEvent(accountA, enrollA.deviceId);
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
    tokenA,
    enrollA2.deviceId,
  );
  if (page.events.length !== 1) throw new Error("download did not converge");
  const crossAccount = await getRaw(
    `${origin}/v1/sync/events?after=c10b:0&limit=10`,
    tokenB,
    enrollA.deviceId,
  );
  if (crossAccount.status !== 403) {
    throw new Error("cross-Account Device use was not denied");
  }
  await post(
    `${origin}/v1/sync/acknowledgements`,
    tokenA,
    {
      greatestContiguousCursor: page.nextCursor,
    },
    enrollA2.deviceId,
  );
  await post(
    `${origin}/v1/devices/${enrollA2.deviceId}/revoke`,
    tokenA,
    {},
    enrollA.deviceId,
  );
  const denied = await getRaw(
    `${origin}/v1/sync/events?after=c10b:0`,
    tokenA,
    enrollA2.deviceId,
  );
  if (denied.status !== 403) throw new Error("revoked Device was not denied");
  await app.close();
  await proveLeastPrivilege(pool);
  process.stdout.write("AUTHORIZATION_RACE_MATRIX=partial\n");
  process.stdout.write("ROUTE_AUTHORIZATION_INVENTORY=true\n");
  process.stdout.write("LEAST_PRIVILEGE_HTTP=true\n");
  process.stdout.write("R3_LOCAL_SECURITY_PROVED=false\n");
} finally {
  await pool.end().catch(() => undefined);
  await migratorPool.end().catch(() => undefined);
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
      "005_hosted_authorization_fence",
      "006_hosted_authorization_r3",
    ]) {
      const path = new URL(`../migrations/${id}.sql`, import.meta.url);
      await client.query(readFileSync(path, "utf8"));
    }
  } finally {
    client.release();
  }
}

async function seed(pool: pg.Pool) {
  for (const accountId of [accountA, accountB]) {
    await pool.query(
      `insert into accounts(account_id) values($1) on conflict do nothing`,
      [accountId],
    );
    await pool.query(
      `insert into account_cursor_state(account_id, next_cursor)
       values($1,1) on conflict do nothing`,
      [accountId],
    );
  }
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
      [id === identityA ? accountA : accountB, id, "owner"],
    );
  }
}

async function proveLeastPrivilege(pool: pg.Pool) {
  const user = await pool.query("select current_user");
  if (user.rows[0].current_user !== "lab_runtime") {
    throw new Error("runtime current_user was not isolated");
  }
  const ready = await pool.query(
    "select public.markei_hosted_runtime_ready() as ready",
  );
  if (ready.rows[0].ready !== true) {
    throw new Error("runtime readiness function failed");
  }
  await expectDenied(pool, "select count(*) from migration_ledger");
  await expectDenied(
    pool,
    "select markei_required_migration_present('005_hosted_authorization_fence')",
  );
  await expectDenied(pool, "create table runtime_must_not_create(id int)");
  await expectDenied(pool, "update external_identities set status='disabled'");
  await expectDenied(pool, "update account_memberships set status='disabled'");
}

async function expectDenied(pool: pg.Pool, sql: string) {
  try {
    await pool.query(sql);
  } catch {
    return;
  }
  throw new Error("runtime privilege denial probe unexpectedly succeeded");
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

function purchaseEvent(accountId: string, deviceId: string) {
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
