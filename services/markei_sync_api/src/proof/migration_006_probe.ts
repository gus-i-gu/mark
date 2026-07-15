import { createHash } from "node:crypto";
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { cp, readdir } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { spawn } from "node:child_process";
import pg from "pg";
import { makeProducerResult, type ProofCaseResult } from "./producer.js";
import { emitProducer } from "./scenario_result.js";

const proofDir = dirname(fileURLToPath(import.meta.url));
const repositoryRoot = resolve(proofDir, "../../../..");
const migrationsDir = resolve(
  repositoryRoot,
  "services/markei_sync_api/migrations",
);
const containerName = "markei-c10-s03a-r3d1-pg";
const port = 55438;
const adminUrl = `postgres://postgres@127.0.0.1:${port}/postgres`;
const migrationIds = [
  "001_init",
  "002_coordination_hardening",
  "003_retention_snapshot_recovery",
  "004_hosted_identity_enrollment",
  "005_hosted_authorization_fence",
  "006_hosted_authorization_r3",
] as const;

const results: Record<string, ProofCaseResult> = {};
let tempDir: string | null = null;

try {
  const beforeHashes = await migrationHashes(migrationsDir);
  await startContainer();
  await provisionRoles();
  const fresh = await scenario("fresh");
  const upgrade = await scenario("upgrade");
  const failure = await scenario("failure");

  results["fresh-001-to-006"] = await capture(async () => {
    await applyMigrations(fresh.migrator, migrationIds);
    await assertReady(fresh.runtime, true);
  });
  results["upgrade-001-to-005-then-006"] = await capture(async () => {
    await applyMigrations(upgrade.migrator, migrationIds.slice(0, 5));
    await upgrade.migrator.query(
      "insert into accounts(account_id) values('11111111-1111-4111-8111-111111111111')",
    );
    await applyMigrations(upgrade.migrator, ["006_hosted_authorization_r3"]);
    await assertReady(upgrade.runtime, true);
  });
  results["duplicate-006-one-ledger-row"] = await capture(async () => {
    await applyMigrations(fresh.migrator, ["006_hosted_authorization_r3"]);
    const ledger = await fresh.migrator.query(
      `select count(*)::int as count
         from public.migration_ledger
        where migration_id='006_hosted_authorization_r3'`,
    );
    assertBool(ledger.rows[0].count === 1);
  });
  results["failure-copy-only"] = await capture(async () => {
    tempDir = mkdtempSync(join(tmpdir(), "markei-r3d1-migrations-"));
    await cp(migrationsDir, tempDir, { recursive: true });
    const copy006 = join(tempDir, "006_hosted_authorization_r3.sql");
    const original = readFileSync(copy006, "utf8");
    writeFileSync(
      copy006,
      original.replace(
        /\ncommit;\s*$/u,
        "\nselect r3d1_missing_failure();\ncommit;\n",
      ),
    );
    assertBool(
      readFileSync(
        resolve(migrationsDir, "006_hosted_authorization_r3.sql"),
        "utf8",
      ) === original,
    );
  });
  results["failure-rollback-ledger-function-acl"] = await capture(async () => {
    if (!tempDir) throw new Error("missing failure copy");
    await applyMigrations(failure.migrator, migrationIds.slice(0, 5));
    await assertRejects(() =>
      applySqlFile(
        failure.migrator,
        join(tempDir!, "006_hosted_authorization_r3.sql"),
      ),
    );
    const ledger = await failure.migrator.query(
      `select count(*)::int as count
         from public.migration_ledger
        where migration_id='006_hosted_authorization_r3'`,
    );
    const proc = await functionRow(failure.migrator);
    assertBool(ledger.rows[0].count === 0 && proc.rowCount === 0);
  });
  results["canonical-migration-hashes-unchanged"] = await capture(async () => {
    const afterHashes = await migrationHashes(migrationsDir);
    assertBool(JSON.stringify(beforeHashes) === JSON.stringify(afterHashes));
  });

  await fillCatalogResults(fresh.migrator, fresh.runtime, results);
  await fresh.close();
  await upgrade.close();
  await failure.close();
} catch {
  for (const caseId of [
    "fresh-001-to-006",
    "upgrade-001-to-005-then-006",
    "duplicate-006-one-ledger-row",
    "failure-copy-only",
    "failure-rollback-ledger-function-acl",
    "canonical-migration-hashes-unchanged",
  ]) {
    results[caseId] ??= { passed: false, blocker: "scenario-failed" };
  }
} finally {
  if (tempDir) rmSync(tempDir, { recursive: true, force: true });
  await stopContainer();
}

const producer = makeProducerResult("migration-006-lifecycle-acl", results);
emitProducer("migration-006-lifecycle-acl", producer);
process.stdout.write(
  `MIGRATION_006_LIFECYCLE_ACL=${producer.passed ? "true" : "partial"}\n`,
);
if (!producer.passed) process.exitCode = 1;

async function fillCatalogResults(
  migrator: pg.Pool,
  runtime: pg.Pool,
  output: Record<string, ProofCaseResult>,
) {
  output["exact-ledger-identity-checksum"] = await capture(async () => {
    const result = await migrator.query(
      `select checksum from public.migration_ledger
        where migration_id='006_hosted_authorization_r3'`,
    );
    assertBool(
      result.rowCount === 1 &&
        result.rows[0].checksum === "c10-s03a-r3-hosted-authorization-v1",
    );
  });
  output["no-argument-readiness-function"] = await capture(async () => {
    const row = await singleFunction(migrator);
    assertBool(Number(row.pronargs) === 0);
  });
  output["function-owner-is-migrator"] = await capture(async () => {
    const row = await singleFunction(migrator);
    assertBool(row.owner === "lab_migrator");
  });
  output["security-definer"] = await capture(async () => {
    assertBool((await singleFunction(migrator)).prosecdef === true);
  });
  output["stable-function"] = await capture(async () => {
    assertBool((await singleFunction(migrator)).provolatile === "s");
  });
  output["fixed-safe-search-path"] = await capture(async () => {
    const config = (await singleFunction(migrator)).proconfig as string[];
    assertBool(
      Array.isArray(config) &&
        config.includes("search_path=pg_catalog, public"),
    );
  });
  output["qualified-ledger-reference"] = await capture(async () => {
    assertBool(
      (await functionDefinition(migrator)).includes("public.migration_ledger"),
    );
  });
  output["no-dynamic-sql"] = await capture(async () => {
    assertBool(!/\bexecute\b/i.test(await functionDefinition(migrator)));
  });
  output["public-execute-denied"] = await capture(async () => {
    const result = await migrator.query(
      `select has_function_privilege('public', 'public.markei_hosted_runtime_ready()', 'execute') as allowed`,
    );
    assertBool(result.rows[0].allowed === false);
  });
  output["runtime-can-execute-readiness"] = await capture(async () => {
    await assertReady(runtime, true);
  });
  output["no-unintended-runtime-function-capability"] = await capture(
    async () => {
      const result = await migrator.query(
        `select p.proname,
              has_function_privilege('lab_runtime', p.oid, 'execute') as allowed
         from pg_proc p
         join pg_namespace n on n.oid=p.pronamespace
        where n.nspname='public'
        order by p.proname`,
      );
      const allowed = result.rows
        .filter((row) => row.allowed)
        .map((row) => row.proname);
      assertBool(
        JSON.stringify(allowed) ===
          JSON.stringify([
            "markei_authorize_identity_membership",
            "markei_hosted_runtime_ready",
          ]),
      );
    },
  );
  output["runtime-old-probe-denied"] = await capture(async () => {
    await assertDenied(
      runtime,
      "select public.markei_required_migration_present('006_hosted_authorization_r3')",
    );
  });
  output["runtime-direct-ledger-denied"] = await capture(async () => {
    await assertDenied(runtime, "select count(*) from public.migration_ledger");
  });
  output["runtime-ddl-denied"] = await capture(async () => {
    await assertDenied(runtime, "create table runtime_probe_denied(id int)");
  });
  output["runtime-role-admin-denied"] = await capture(async () => {
    await assertDenied(runtime, "create role runtime_probe_denied");
  });
  output["migrator-owner-authority"] = await capture(async () => {
    await migrator.query(
      "create table if not exists migrator_authority_probe(id int)",
    );
    await migrator.query("drop table migrator_authority_probe");
  });
  output["hostile-shadowing-resistant"] = await capture(async () => {
    await runtime.query(
      "create temp table migration_ledger(migration_id text, checksum text)",
    );
    await runtime.query(
      `insert into pg_temp.migration_ledger values('006_hosted_authorization_r3','wrong')`,
    );
    await assertReady(runtime, true);
  });
  output["absent-ledger-not-ready"] = await capture(async () => {
    await migrator.query(
      "delete from public.migration_ledger where migration_id='006_hosted_authorization_r3'",
    );
    await assertReady(runtime, false);
    await migrator.query(
      `insert into public.migration_ledger(migration_id, checksum)
       values('006_hosted_authorization_r3', 'c10-s03a-r3-hosted-authorization-v1')`,
    );
  });
  output["tampered-ledger-not-ready"] = await capture(async () => {
    await migrator.query(
      `update public.migration_ledger
          set checksum='tampered'
        where migration_id='006_hosted_authorization_r3'`,
    );
    await assertReady(runtime, false);
  });
}

async function startContainer() {
  await run("docker", ["rm", "-f", containerName], [0, 1]);
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
    [0],
  );
  assertBool(code === 0);
  for (let attempt = 0; attempt < 30; attempt++) {
    if (
      (await run(
        "docker",
        ["exec", containerName, "pg_isready", "-U", "postgres"],
        [0, 1],
      )) === 0
    )
      return;
    await new Promise((resolve) => setTimeout(resolve, 1000));
  }
  throw new Error("postgres unavailable");
}

async function stopContainer() {
  await run("docker", ["rm", "-f", containerName], [0, 1]).catch(() => 1);
}

async function provisionRoles() {
  const admin = new pg.Pool({ connectionString: adminUrl, max: 1 });
  try {
    await admin.query("create role markei_runtime");
    await admin.query("create role lab_migrator login createrole createdb");
    await admin.query("create role lab_runtime login");
    await admin.query("grant markei_runtime to lab_runtime");
  } finally {
    await admin.end();
  }
}

async function scenario(name: string) {
  const dbName = `markei_r3d1_${name}`;
  const admin = new pg.Pool({ connectionString: adminUrl, max: 1 });
  await admin.query(`create database ${dbName} owner lab_migrator`);
  await admin.end();
  const migrator = new pg.Pool({
    connectionString: `postgres://lab_migrator@127.0.0.1:${port}/${dbName}`,
    max: 1,
  });
  const runtime = new pg.Pool({
    connectionString: `postgres://lab_runtime@127.0.0.1:${port}/${dbName}`,
    max: 1,
  });
  return {
    migrator,
    runtime,
    close: async () => {
      await runtime.end().catch(() => undefined);
      await migrator.end().catch(() => undefined);
    },
  };
}

async function applyMigrations(pool: pg.Pool, ids: readonly string[]) {
  for (const id of ids) {
    await applySqlFile(pool, resolve(migrationsDir, `${id}.sql`));
  }
}

async function applySqlFile(pool: pg.Pool, path: string) {
  await pool.query(readFileSync(path, "utf8"));
}

async function migrationHashes(directory: string) {
  const files = (await readdir(directory))
    .filter((file) => file.endsWith(".sql"))
    .sort();
  return Object.fromEntries(
    files.map((file) => [
      file,
      createHash("sha256")
        .update(readFileSync(resolve(directory, file)))
        .digest("hex"),
    ]),
  );
}

async function functionRow(pool: pg.Pool) {
  return pool.query(
    `select p.*, r.rolname as owner
       from pg_proc p
       join pg_namespace n on n.oid=p.pronamespace
       join pg_roles r on r.oid=p.proowner
      where n.nspname='public'
        and p.proname='markei_hosted_runtime_ready'`,
  );
}

async function singleFunction(pool: pg.Pool) {
  const result = await functionRow(pool);
  assertBool(result.rowCount === 1);
  return result.rows[0];
}

async function functionDefinition(pool: pg.Pool) {
  const result = await pool.query(
    `select pg_get_functiondef(p.oid) as definition
       from pg_proc p
       join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public'
        and p.proname='markei_hosted_runtime_ready'`,
  );
  assertBool(result.rowCount === 1);
  return String(result.rows[0].definition);
}

async function assertReady(pool: pg.Pool, expected: boolean) {
  const result = await pool.query(
    "select public.markei_hosted_runtime_ready() as ready",
  );
  assertBool(result.rows[0].ready === expected);
}

async function assertDenied(pool: pg.Pool, sql: string) {
  await assertRejects(() => pool.query(sql));
}

async function assertRejects(action: () => Promise<unknown>) {
  try {
    await action();
  } catch {
    return;
  }
  throw new Error("expected denial");
}

async function capture(action: () => Promise<void>): Promise<ProofCaseResult> {
  try {
    await action();
    return { passed: true };
  } catch {
    return { passed: false, blocker: "scenario-failed" };
  }
}

function assertBool(value: boolean) {
  if (!value) throw new Error("assertion failed");
}

function run(
  command: string,
  args: readonly string[],
  allowed: readonly number[],
) {
  return new Promise<number>((resolve) => {
    const child = spawn(command, [...args], {
      cwd: repositoryRoot,
      shell: false,
      stdio: "ignore",
      windowsHide: true,
    });
    const timeout = setTimeout(() => {
      child.kill();
      resolve(124);
    }, 120000);
    child.on("error", () => {
      clearTimeout(timeout);
      resolve(127);
    });
    child.on("exit", (code) => {
      clearTimeout(timeout);
      const exit = code ?? 1;
      resolve(allowed.includes(exit) ? 0 : exit);
    });
  });
}
