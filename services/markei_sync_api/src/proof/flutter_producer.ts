import { spawn } from "node:child_process";
import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import Fastify from "fastify";
import { exportJWK, generateKeyPair, SignJWT } from "jose";
import pg from "pg";
import { Auth0JwtVerifier } from "../application/jwt_verifier.js";
import {
  HostedIdentityService,
  HostedTransactionAuthorizer,
} from "../application/hosted_authorization.js";
import { systemClock } from "../application/hosted_contracts.js";
import { noopAuthorizationBarrier } from "../application/authorization_barrier.js";
import { buildApp } from "../http/app.js";
import type { Database } from "../postgres/database.js";
import {
  makeProducerResult,
  REQUIRED_PROOF_CASES,
  type ProofCaseResult,
} from "./producer.js";
import { emitProducer } from "./scenario_result.js";

const proofDir = dirname(fileURLToPath(import.meta.url));
const repositoryRoot = resolve(proofDir, "../../../..");
const flutterRoot = resolve(repositoryRoot, "clients/markei_flutter");
const serverRoot = resolve(repositoryRoot, "services/markei_sync_api");
const containerName = "markei-c10-mcg02-r05-flutter-pg";
const port = 55456;
const dbName = "markei_r05_flutter";
const adminUrl = `postgres://postgres@127.0.0.1:${port}/postgres`;
const migratorUrl = `postgres://lab_migrator@127.0.0.1:${port}/${dbName}`;
const runtimeUrl = `postgres://lab_runtime@127.0.0.1:${port}/${dbName}`;
const subject = "auth0|r05-flutter-principal";
const accountId = "11111111-1111-4111-8111-111111111111";
const identityId = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";

let app: Awaited<ReturnType<typeof buildHostedApp>> | undefined;
let jwks: Awaited<ReturnType<typeof createSyntheticJwks>> | undefined;
let migratorPool: pg.Pool | undefined;

try {
  await startContainer();
  await provision();
  migratorPool = new pg.Pool({ connectionString: migratorUrl, max: 2 });
  await migrate(migratorPool);
  jwks = await createSyntheticJwks();
  await seed(migratorPool, jwks.issuer);
  app = await buildHostedApp(jwks.issuer, jwks.audience);
  const tokenA = await jwks.token("r05-a");
  const tokenB = await jwks.token("r05-b");
  const output = await runFlutterProof(app.origin, tokenA, tokenB);
  const parsed = parseCaseResults(output);
  const producer = makeProducerResult("flutter-http-file-backed", parsed);
  const counts = await hostedCounts(migratorPool);
  process.stdout.write(
    `R05_HOSTED_COUNTS devices=${counts.devices} enrollmentRequests=${counts.enrollmentRequests} securityEvents=${counts.securityEvents}\n`,
  );
  emitProducer("flutter-http-file-backed", producer);
  process.stdout.write(
    `FLUTTER_HTTP_FILE_BACKED_CASES_TRUE=${
      Object.values(producer.resultsByCase).filter((result) => result.passed)
        .length
    }\n`,
  );
  process.stdout.write(
    `FLUTTER_HTTP_FILE_BACKED_PRODUCER=${producer.passed ? "true" : "false"}\n`,
  );
  if (!producer.passed) process.exitCode = 1;
} catch (error) {
  process.stdout.write(`FLUTTER_PRODUCER_ERROR=${safeDiagnostic(error)}\n`);
  const producer = makeProducerResult("flutter-http-file-backed", {});
  emitProducer("flutter-http-file-backed", producer);
  process.stdout.write("FLUTTER_HTTP_FILE_BACKED_CASES_TRUE=0\n");
  process.stdout.write("FLUTTER_HTTP_FILE_BACKED_PRODUCER=false\n");
  process.exitCode = 1;
} finally {
  await app?.close().catch(() => undefined);
  await jwks?.close().catch(() => undefined);
  await migratorPool?.end().catch(() => undefined);
  await run("docker", ["rm", "-f", containerName], repositoryRoot, [0, 1]);
}

function parseCaseResults(output: string) {
  const required = new Set(REQUIRED_PROOF_CASES["flutter-http-file-backed"]);
  const results: Record<string, ProofCaseResult> = {};
  for (const line of output.split(/\r?\n/u)) {
    const markerIndex = line.indexOf("R05_CASE ");
    if (markerIndex < 0) continue;
    const parsed = JSON.parse(line.slice(markerIndex + "R05_CASE ".length)) as {
      caseId?: unknown;
      passed?: unknown;
      blocker?: unknown;
    };
    if (typeof parsed.caseId !== "string" || !required.has(parsed.caseId)) {
      throw new Error("invalid flutter case id");
    }
    if (Object.hasOwn(results, parsed.caseId)) {
      throw new Error("duplicate flutter case result");
    }
    results[parsed.caseId] =
      parsed.passed === true
        ? { passed: true }
        : {
            passed: false,
            blocker:
              typeof parsed.blocker === "string"
                ? parsed.blocker
                : "case-failed",
          };
  }
  for (const caseId of required) {
    if (!Object.hasOwn(results, caseId)) {
      results[caseId] = { passed: false, blocker: "missing-case-result" };
    }
  }
  return results;
}

async function buildHostedApp(issuer: string, audience: string) {
  const runtimePool = new pg.Pool({ connectionString: runtimeUrl, max: 4 });
  const database: Database = { pool: runtimePool };
  const verifier = new Auth0JwtVerifier({
    issuer,
    audience,
    jwksUri: `${issuer}.well-known/jwks.json`,
    clock: systemClock,
  });
  const identityService = new HostedIdentityService(
    database,
    verifier,
    systemClock,
    noopAuthorizationBarrier,
  );
  const fastify = buildApp({
    authorization: {
      kind: "hosted",
      identityService,
      transactionAuthorizer: new HostedTransactionAuthorizer(
        database,
        verifier,
        noopAuthorizationBarrier,
      ),
    },
    database,
  });
  await fastify.listen({ host: "127.0.0.1", port: 0 });
  return {
    origin: `http://127.0.0.1:${(fastify.server.address() as { port: number }).port}`,
    close: async () => {
      await fastify.close();
      await runtimePool.end();
    },
  };
}

async function createSyntheticJwks() {
  const keys = await generateKeyPair("RS256", { extractable: true });
  const publicJwk = await exportJWK(keys.publicKey);
  publicJwk.kid = "r05-local-key";
  publicJwk.alg = "RS256";
  publicJwk.use = "sig";
  const server = Fastify({ logger: false });
  server.get("/.well-known/jwks.json", async () => ({ keys: [publicJwk] }));
  await server.listen({ host: "127.0.0.1", port: 0 });
  const issuer = `http://127.0.0.1:${(server.server.address() as { port: number }).port}/`;
  const audience = "markei-sync-api";
  return {
    issuer,
    audience,
    token: (nonce: string) =>
      new SignJWT({ nonce })
        .setProtectedHeader({ alg: "RS256", kid: "r05-local-key" })
        .setIssuer(issuer)
        .setAudience(audience)
        .setSubject(subject)
        .setIssuedAt()
        .setExpirationTime("10m")
        .sign(keys.privateKey),
    close: () => server.close(),
  };
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
      "007_account_cursor_provisioning",
    ]) {
      const path = resolve(serverRoot, "migrations", `${id}.sql`);
      await client.query(readFileSync(path, "utf8"));
    }
  } finally {
    client.release();
  }
}

async function seed(pool: pg.Pool, issuer: string) {
  await pool.query("insert into accounts(account_id) values($1)", [accountId]);
  await pool.query(
    `insert into external_identities(identity_id, issuer, subject, status)
     values($1,$2,$3,'active')`,
    [identityId, issuer, subject],
  );
  await pool.query(
    `insert into account_memberships(account_id, identity_id, role, status)
     values($1,$2,'owner','active')`,
    [accountId, identityId],
  );
}

async function hostedCounts(pool: pg.Pool) {
  const row = await pool.query(
    `select
       (select count(*)::int from devices) as devices,
       (select count(*)::int from device_enrollment_requests) as enrollment_requests,
       (select count(*)::int from device_security_events) as security_events`,
  );
  return {
    devices: Number(row.rows[0]?.devices ?? 0),
    enrollmentRequests: Number(row.rows[0]?.enrollment_requests ?? 0),
    securityEvents: Number(row.rows[0]?.security_events ?? 0),
  };
}

async function startContainer() {
  await run("docker", ["rm", "-f", containerName], repositoryRoot, [0, 1]);
  const code = await run(
    "docker",
    [
      "run",
      "--name",
      containerName,
      "-e",
      "POSTGRES_HOST_AUTH_METHOD=trust",
      "-p",
      `127.0.0.1:${port}:5432`,
      "-d",
      "postgres:18-alpine",
    ],
    repositoryRoot,
    [0],
  );
  if (code !== 0) throw new Error("postgres unavailable");
  for (let attempt = 0; attempt < 30; attempt++) {
    if (
      (await run(
        "docker",
        ["exec", containerName, "pg_isready", "-U", "postgres"],
        repositoryRoot,
        [0, 1],
      )) === 0
    ) {
      await waitForSql();
      return;
    }
    await new Promise((resolve) => setTimeout(resolve, 1000));
  }
  await waitForSql();
}

async function waitForSql() {
  for (let attempt = 0; attempt < 30; attempt++) {
    const code = await run(
      "docker",
      [
        "exec",
        containerName,
        "psql",
        "-U",
        "postgres",
        "-d",
        "postgres",
        "-c",
        "select 1",
      ],
      repositoryRoot,
      [0, 1],
    );
    if (code === 0) return;
    await new Promise((resolve) => setTimeout(resolve, 1000));
  }
  throw new Error("postgres unavailable");
}

async function provision() {
  const admin = new pg.Pool({ connectionString: adminUrl, max: 1 });
  try {
    await admin.query("create role markei_runtime");
    await admin.query("create role lab_migrator login createrole createdb");
    await admin.query("create role lab_runtime login");
    await admin.query("grant markei_runtime to lab_runtime");
    await admin.query(`create database ${dbName} owner lab_migrator`);
  } finally {
    await admin.end();
  }
}

function runFlutterProof(origin: string, tokenA: string, tokenB: string) {
  return runText(
    "flutter",
    ["test", "test/infrastructure/flutter_http_file_backed_proof_test.dart"],
    flutterRoot,
    {
      R05_HOSTED_ORIGIN: origin,
      R05_ACCESS_TOKEN_A: tokenA,
      R05_ACCESS_TOKEN_B: tokenB,
    },
  );
}

function run(
  command: string,
  args: readonly string[],
  cwd: string,
  allowed: readonly number[],
) {
  return new Promise<number>((resolveCode) => {
    const child = spawn(command, [...args], {
      cwd,
      shell: process.platform === "win32",
      stdio: "ignore",
      windowsHide: true,
    });
    const timeout = setTimeout(() => {
      child.kill();
      resolveCode(124);
    }, 120000);
    child.on("error", () => {
      clearTimeout(timeout);
      resolveCode(127);
    });
    child.on("exit", (code) => {
      clearTimeout(timeout);
      const exit = code ?? 1;
      resolveCode(allowed.includes(exit) ? 0 : exit);
    });
  });
}

function runText(
  command: string,
  args: readonly string[],
  cwd: string,
  env: Record<string, string>,
) {
  return new Promise<string>((resolveText, reject) => {
    const child = spawn(command, [...args], {
      cwd,
      env: { ...process.env, ...env },
      shell: process.platform === "win32",
      stdio: ["ignore", "pipe", "pipe"],
      windowsHide: true,
    });
    const stdout: Buffer[] = [];
    const stderr: Buffer[] = [];
    child.stdout.on("data", (chunk: Buffer) => stdout.push(chunk));
    child.stderr.on("data", (chunk: Buffer) => stderr.push(chunk));
    const timeout = setTimeout(() => {
      child.kill();
      reject(new Error("flutter proof timeout"));
    }, 300000);
    child.on("error", (error) => {
      clearTimeout(timeout);
      reject(error);
    });
    child.on("exit", (code) => {
      clearTimeout(timeout);
      const output = Buffer.concat(stdout).toString("utf8");
      if (code !== 0) {
        if (output.includes("R05_CASE ")) {
          resolveText(output);
          return;
        }
        const detail = [
          ...output.split(/\r?\n/u),
          ...Buffer.concat(stderr).toString("utf8").split(/\r?\n/u),
        ]
          .map((line) => line.trim())
          .filter(
            (line) =>
              line.length > 0 &&
              !line.includes(": loading ") &&
              !line.startsWith("00:"),
          )
          .slice(0, 5)
          .join(" ");
        reject(
          new Error(
            `flutter proof failed ${code ?? "unknown"} ${
              detail || "no-detail"
            }`,
          ),
        );
        return;
      }
      resolveText(output);
    });
  });
}

function safeDiagnostic(error: unknown) {
  const message = error instanceof Error ? error.message : "unknown";
  return message
    .replace(/Bearer [A-Za-z0-9._-]+/gu, "Bearer redacted")
    .replace(/postgres:\/\/[^\s]+/gu, "postgres://redacted")
    .replace(/[^a-zA-Z0-9 .:_-]/gu, "")
    .slice(0, 240);
}
