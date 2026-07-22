import { createHash } from "node:crypto";
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { cp, readdir } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { spawn } from "node:child_process";
import pg from "pg";
import { FixtureAuthVerifier } from "../application/auth.js";
import { canonicalHash } from "../domain/protocol.js";
import { buildApp } from "../http/app.js";
import { makeProducerResult, type ProofCaseResult } from "./producer.js";
import { emitProducer } from "./scenario_result.js";

const proofDir = dirname(fileURLToPath(import.meta.url));
const repositoryRoot = resolve(proofDir, "../../../..");
const migrationsDir = resolve(
  repositoryRoot,
  "services/markei_sync_api/migrations",
);
const containerName = "markei-c10-mcg02-cursor-pg";
const port = 55439;
const adminUrl = `postgres://postgres@127.0.0.1:${port}/postgres`;
const pre007MigrationIds = [
  "001_init",
  "002_coordination_hardening",
  "003_retention_snapshot_recovery",
  "004_hosted_identity_enrollment",
  "005_hosted_authorization_fence",
  "006_hosted_authorization_r3",
] as const;
const migrationIds = [
  ...pre007MigrationIds,
  "007_account_cursor_provisioning",
] as const;

const accountA = "11111111-1111-4111-8111-111111111111";
const accountB = "11111111-1111-4111-8111-111111111112";
const accountC = "11111111-1111-4111-8111-111111111113";
const deviceA = "22222222-2222-4222-8222-222222222221";
const deviceB = "22222222-2222-4222-8222-222222222222";

const results: Record<string, ProofCaseResult> = {};
let tempDir: string | null = null;

try {
  const beforeHashes = await migrationHashes(migrationsDir);
  await startContainer();
  await provisionRoles();

  const pre007 = await scenario("pre007");
  results["pre007-account-can-commit-without-cursor"] = await capture(
    async () => {
      await applyMigrations(pre007.migrator, pre007MigrationIds);
      await insertAccount(pre007.migrator, accountA);
      await assertCursor(pre007.migrator, accountA, null);
    },
  );
  results["pre007-incomplete-account-remains-incomplete"] = await capture(
    async () => {
      await assertCursor(pre007.migrator, accountA, null);
    },
  );
  results["pre007-old-readiness-true"] = await capture(async () => {
    await assertReadyV1(pre007.runtime, true);
  });
  results["pre007-runtime-cursor-insert-allowed"] = await capture(async () => {
    await insertAccount(pre007.migrator, accountB);
    await withRuntimeContext(pre007.runtime, accountB, "", async (client) => {
      await client.query(
        "insert into public.account_cursor_state(account_id, next_cursor) values($1, 1)",
        [accountB],
      );
    });
    await assertCursor(pre007.migrator, accountB, 1);
  });
  await pre007.close();

  const fresh = await scenario("fresh");
  results["fresh-001-to-007"] = await capture(async () => {
    await applyMigrations(fresh.migrator, migrationIds);
    await assertReadyV2(fresh.runtime, true);
  });
  results["duplicate-007-idempotent"] = await capture(async () => {
    await applyMigrations(fresh.migrator, ["007_account_cursor_provisioning"]);
    const rows = await fresh.migrator.query(
      `select count(*)::int as count
         from public.migration_ledger
        where migration_id='007_account_cursor_provisioning'`,
    );
    assertBool(rows.rows[0].count === 1);
  });
  results["old-readiness-remains-available"] = await capture(async () => {
    await assertReadyV1(fresh.runtime, true);
  });
  results["concurrent-account-creation-provisions-cursors"] = await capture(
    async () => {
      await Promise.all([
        insertAccount(fresh.migrator, accountA),
        insertAccount(fresh.migrator, accountB),
      ]);
      await assertCursor(fresh.migrator, accountA, 1);
      await assertCursor(fresh.migrator, accountB, 1);
      await assertOneCursorPerAccount(fresh.migrator);
    },
  );
  results["account-insert-rollback-removes-cursor"] = await capture(
    async () => {
      const client = await fresh.migrator.connect();
      try {
        await client.query("begin");
        await client.query(
          "insert into public.accounts(account_id) values($1)",
          [accountC],
        );
        await client.query("rollback");
      } finally {
        client.release();
      }
      await assertCursor(fresh.migrator, accountC, null);
    },
  );
  await fillCatalogResults(fresh.migrator, fresh.runtime, results);
  await fresh.close();

  const upgrade = await scenario("upgrade");
  results["upgrade-001-to-006-then-007-no-accounts"] = await capture(
    async () => {
      await applyMigrations(upgrade.migrator, pre007MigrationIds);
      await applyMigrations(upgrade.migrator, [
        "007_account_cursor_provisioning",
      ]);
      const count = await cursorCount(upgrade.migrator);
      assertBool(count === 0);
      await assertReadyV2(upgrade.runtime, true);
    },
  );
  await upgrade.close();

  results["missing-row-no-events-next-cursor-1"] = await runBackfillScenario(
    "backfill_no_events",
    async (pool) => {
      await insertAccount(pool, accountA);
    },
    async (pool) => {
      await assertCursor(pool, accountA, 1);
    },
  );
  results["missing-row-existing-events-high-water-plus-1"] =
    await runBackfillScenario(
      "backfill_with_events",
      async (pool) => {
        await seedAcceptedEvent(pool, accountA, deviceA, 1, 7);
      },
      async (pool) => {
        await assertCursor(pool, accountA, 8);
      },
    );
  results["existing-cursor-row-preserved"] = await runBackfillScenario(
    "preserve_existing",
    async (pool) => {
      await seedAcceptedEvent(pool, accountA, deviceA, 1, 7);
      await pool.query(
        "insert into public.account_cursor_state(account_id, next_cursor) values($1, 99)",
        [accountA],
      );
    },
    async (pool) => {
      await assertCursor(pool, accountA, 99);
    },
  );
  results["mixed-complete-incomplete-accounts"] = await runBackfillScenario(
    "mixed",
    async (pool) => {
      await insertAccount(pool, accountA);
      await insertAccount(pool, accountB);
      await pool.query(
        "insert into public.account_cursor_state(account_id, next_cursor) values($1, 42)",
        [accountA],
      );
    },
    async (pool) => {
      await assertCursor(pool, accountA, 42);
      await assertCursor(pool, accountB, 1);
      await assertOneCursorPerAccount(pool);
    },
  );

  results["migration-failure-rolls-back-all-007-effects"] = await capture(
    async () => {
      tempDir = mkdtempSync(join(tmpdir(), "markei-007-migrations-"));
      await cp(migrationsDir, tempDir, { recursive: true });
      const copy007 = join(tempDir, "007_account_cursor_provisioning.sql");
      const original = readFileSync(copy007, "utf8");
      writeFileSync(
        copy007,
        original.replace(
          /\ncommit;\s*$/u,
          "\nselect c10_mcg02_missing_failure();\ncommit;\n",
        ),
      );
      assertBool(
        readFileSync(
          resolve(migrationsDir, "007_account_cursor_provisioning.sql"),
          "utf8",
        ) === original,
      );
      const failure = await scenario("failure");
      try {
        await applyMigrations(failure.migrator, pre007MigrationIds);
        await insertAccount(failure.migrator, accountA);
        await assertRejects(() => applySqlFile(failure.migrator, copy007));
        const ledger = await failure.migrator.query(
          `select count(*)::int as count
             from public.migration_ledger
            where migration_id='007_account_cursor_provisioning'`,
        );
        assertBool(ledger.rows[0].count === 0);
        await assertCursor(failure.migrator, accountA, null);
        assertBool((await triggerCount(failure.migrator)) === 0);
        assertBool(
          (await functionCount(
            failure.migrator,
            "markei_hosted_runtime_ready_v2",
          )) === 0,
        );
      } finally {
        await failure.close();
      }
    },
  );

  const afterHashes = await migrationHashes(migrationsDir);
  assertBool(JSON.stringify(beforeHashes) === JSON.stringify(afterHashes));
} catch {
  for (const caseId of [
    "pre007-account-can-commit-without-cursor",
    "pre007-incomplete-account-remains-incomplete",
    "pre007-old-readiness-true",
    "pre007-runtime-cursor-insert-allowed",
    "fresh-001-to-007",
    "duplicate-007-idempotent",
    "old-readiness-remains-available",
    "concurrent-account-creation-provisions-cursors",
    "account-insert-rollback-removes-cursor",
    "upgrade-001-to-006-then-007-no-accounts",
    "missing-row-no-events-next-cursor-1",
    "missing-row-existing-events-high-water-plus-1",
    "existing-cursor-row-preserved",
    "mixed-complete-incomplete-accounts",
    "migration-failure-rolls-back-all-007-effects",
  ]) {
    results[caseId] ??= { passed: false, blocker: "scenario-failed" };
  }
} finally {
  if (tempDir) rmSync(tempDir, { recursive: true, force: true });
  await stopContainer();
}

const producer = makeProducerResult(
  "migration-007-account-cursor-provisioning",
  results,
);
emitProducer("migration-007-account-cursor-provisioning", producer);
process.stdout.write(
  `MIGRATION_007_ACCOUNT_CURSOR_PROVISIONING=${
    producer.passed ? "true" : "partial"
  }\n`,
);
if (!producer.passed) process.exitCode = 1;

async function fillCatalogResults(
  migrator: pg.Pool,
  runtime: pg.Pool,
  output: Record<string, ProofCaseResult>,
) {
  output["trigger-function-owner-is-migrator"] = await capture(async () => {
    assertBool((await singleFunction(migrator)).owner === "lab_migrator");
  });
  output["trigger-function-security-definer"] = await capture(async () => {
    assertBool((await singleFunction(migrator)).prosecdef === true);
  });
  output["trigger-function-fixed-search-path"] = await capture(async () => {
    const config = (await singleFunction(migrator)).proconfig as string[];
    assertBool(
      Array.isArray(config) &&
        config.includes("search_path=pg_catalog, public"),
    );
  });
  output["trigger-function-qualified-no-dynamic-sql"] = await capture(
    async () => {
      const definition = await functionDefinition(
        migrator,
        "markei_provision_account_cursor_state",
      );
      assertBool(definition.includes("public.account_cursor_state"));
      assertBool(!/\bexecute\s+/iu.test(definition));
    },
  );
  output["public-runtime-trigger-function-denied"] = await capture(async () => {
    const result = await migrator.query(
      `select
         has_function_privilege('public', 'public.markei_provision_account_cursor_state()', 'execute') as public_allowed,
         has_function_privilege('lab_runtime', 'public.markei_provision_account_cursor_state()', 'execute') as runtime_allowed`,
    );
    assertBool(
      result.rows[0].public_allowed === false &&
        result.rows[0].runtime_allowed === false,
    );
  });
  output["runtime-account-and-cursor-insert-denied"] = await capture(
    async () => {
      await assertDenied(
        runtime,
        "insert into public.accounts(account_id) values('11111111-1111-4111-8111-111111111199')",
      );
      await withRuntimeContext(runtime, accountA, deviceA, async (client) => {
        await assertRejects(() =>
          client.query(
            "insert into public.account_cursor_state(account_id, next_cursor) values($1, 1)",
            [accountA],
          ),
        );
      });
    },
  );
  output["runtime-cursor-delete-denied"] = await capture(async () => {
    await withRuntimeContext(runtime, accountA, deviceA, async (client) => {
      await assertRejects(() =>
        client.query(
          "delete from public.account_cursor_state where account_id=$1",
          [accountA],
        ),
      );
    });
  });
  output["runtime-scoped-cursor-select-update-allowed"] = await capture(
    async () => {
      await withRuntimeContext(runtime, accountB, deviceA, async (client) => {
        const selected = await client.query(
          "select next_cursor from public.account_cursor_state where account_id=$1",
          [accountB],
        );
        assertBool(selected.rowCount === 1);
        const updated = await client.query(
          "update public.account_cursor_state set next_cursor=next_cursor+1 where account_id=$1 returning next_cursor",
          [accountB],
        );
        assertBool(updated.rowCount === 1);
      });
    },
  );
  output["runtime-ledger-ddl-role-denied"] = await capture(async () => {
    await assertDenied(runtime, "select count(*) from public.migration_ledger");
    await assertDenied(
      runtime,
      "create table public.runtime_probe_denied(id int)",
    );
    await assertDenied(runtime, "create role runtime_probe_denied");
  });
  output["object-shadowing-resistant"] = await capture(async () => {
    await runtime.query(
      "create temp table migration_ledger(migration_id text, checksum text)",
    );
    await runtime.query(
      `insert into pg_temp.migration_ledger values('006_hosted_authorization_r3','wrong')`,
    );
    await assertReadyV2(runtime, true);
  });
  output["readiness-v2-true-false-absent"] = await capture(async () => {
    await assertReadyV2(runtime, true);
    await migrator.query(
      `update public.migration_ledger
          set checksum='tampered'
        where migration_id='007_account_cursor_provisioning'`,
    );
    await assertReadyV2(runtime, false);
    await migrator.query(
      `update public.migration_ledger
          set checksum='c10-mcg02-account-cursor-provisioning-v1'
        where migration_id='007_account_cursor_provisioning'`,
    );
    const absent = await scenario("v2_absent");
    try {
      await applyMigrations(absent.migrator, pre007MigrationIds);
      await assertRejects(() =>
        absent.runtime.query(
          "select public.markei_hosted_runtime_ready_v2() as ready",
        ),
      );
    } finally {
      await absent.close();
    }
  });
  output["first-submission-after-provisioning-allocates-cursor"] =
    await capture(async () => {
      await insertDevice(migrator, accountA, deviceA, 1);
      const app = buildApp({
        authorization: {
          kind: "fixture",
          verifier: new FixtureAuthVerifier({
            accountId: accountA,
            deviceId: deviceA,
          }),
        },
        database: { pool: runtime },
      });
      const response = await app.inject({
        method: "POST",
        url: "/v1/sync/submissions",
        payload: submissionBody(accountA, deviceA),
      });
      assertBool(response.statusCode === 200);
      await assertCursor(migrator, accountA, 3);
      const eventCount = await migrator.query(
        "select count(*)::int as count from public.sync_events where account_id=$1",
        [accountA],
      );
      const submissionCount = await migrator.query(
        "select count(*)::int as count from public.submissions where account_id=$1",
        [accountA],
      );
      assertBool(eventCount.rows[0].count === 2);
      assertBool(submissionCount.rows[0].count === 1);
    });
  output["missing-state-503-defense-in-depth"] = await capture(async () => {
    await insertAccount(migrator, accountC);
    await insertDevice(migrator, accountC, deviceB, 1);
    await migrator.query(
      "delete from public.account_cursor_state where account_id=$1",
      [accountC],
    );
    const app = buildApp({
      authorization: {
        kind: "fixture",
        verifier: new FixtureAuthVerifier({
          accountId: accountC,
          deviceId: deviceB,
        }),
      },
      database: { pool: runtime },
    });
    const response = await app.inject({
      method: "POST",
      url: "/v1/sync/submissions",
      payload: submissionBody(accountC, deviceB),
    });
    assertBool(response.statusCode === 503);
    assertBool(response.json().code === "service-unavailable");
  });
  output["missing-state-503-no-partial-sync"] = await capture(async () => {
    const counts = await migrator.query(
      `select
         (select count(*)::int from public.sync_events where account_id=$1) as events,
         (select count(*)::int from public.submissions where account_id=$1) as submissions`,
      [accountC],
    );
    assertBool(counts.rows[0].events === 0 && counts.rows[0].submissions === 0);
  });
}

async function runBackfillScenario(
  name: string,
  seed: (pool: pg.Pool) => Promise<void>,
  verify: (pool: pg.Pool) => Promise<void>,
) {
  return capture(async () => {
    const target = await scenario(name);
    try {
      await applyMigrations(target.migrator, pre007MigrationIds);
      await seed(target.migrator);
      await applyMigrations(target.migrator, [
        "007_account_cursor_provisioning",
      ]);
      await verify(target.migrator);
    } finally {
      await target.close();
    }
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
    ) {
      await waitForSql();
      return;
    }
    await new Promise((resolve) => setTimeout(resolve, 1000));
  }
  throw new Error("postgres unavailable");
}

async function waitForSql() {
  for (let attempt = 0; attempt < 30; attempt++) {
    if (
      (await run(
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
        [0, 1],
      )) === 0
    ) {
      return;
    }
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
  const dbName = `markei_007_${name}`;
  const admin = new pg.Pool({ connectionString: adminUrl, max: 1 });
  await admin.query(`create database ${dbName} owner lab_migrator`);
  await admin.end();
  const migrator = new pg.Pool({
    connectionString: `postgres://lab_migrator@127.0.0.1:${port}/${dbName}`,
    max: 4,
  });
  const runtime = new pg.Pool({
    connectionString: `postgres://lab_runtime@127.0.0.1:${port}/${dbName}`,
    max: 4,
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

async function insertAccount(pool: pg.Pool, accountId: string) {
  await pool.query("insert into public.accounts(account_id) values($1)", [
    accountId,
  ]);
}

async function insertDevice(
  pool: pg.Pool,
  accountId: string,
  deviceId: string,
  nextExpectedSequence: number,
) {
  await pool.query(
    `insert into public.devices(account_id, device_id, status, next_expected_sequence)
     values($1, $2, 'active', $3)
     on conflict(account_id, device_id) do nothing`,
    [accountId, deviceId, nextExpectedSequence],
  );
}

async function seedAcceptedEvent(
  pool: pg.Pool,
  accountId: string,
  deviceId: string,
  deviceSequence: number,
  serverCursor: number,
) {
  await insertAccount(pool, accountId);
  await insertDevice(pool, accountId, deviceId, deviceSequence + 1);
  await pool.query(
    `insert into public.sync_events(
       event_id, account_id, device_id, device_sequence, server_cursor,
       event_type, payload_version, occurrence_time, payload, content_hash
     ) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)`,
    [
      `33333333-3333-4333-8333-33333333333${deviceSequence}`,
      accountId,
      deviceId,
      deviceSequence,
      serverCursor,
      "purchase.registered",
      3,
      "2026-07-22T00:00:00.000Z",
      {},
      "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    ],
  );
}

function submissionBody(accountId: string, deviceId: string) {
  const events = [1, 2].map((sequence) => {
    const event = {
      eventId: `33333333-3333-4333-8333-33333333334${sequence}`,
      accountId,
      deviceId,
      deviceSequence: sequence,
      eventType: "purchase.registered",
      payloadVersion: 3,
      occurrenceTime: "2026-07-22T00:00:00.000Z",
      payload: { fixture: sequence },
    };
    return { ...event, contentHash: canonicalHash(event) };
  });
  return {
    submissionId: "44444444-4444-4444-8444-444444444444",
    deviceId,
    requestHash: canonicalHash({ events }),
    events,
  };
}

async function cursorCount(pool: pg.Pool) {
  const result = await pool.query(
    "select count(*)::int as count from public.account_cursor_state",
  );
  return Number(result.rows[0].count);
}

async function assertCursor(
  pool: pg.Pool,
  accountId: string,
  expected: number | null,
) {
  const result = await pool.query(
    "select next_cursor from public.account_cursor_state where account_id=$1",
    [accountId],
  );
  if (expected === null) {
    assertBool(result.rowCount === 0);
  } else {
    assertBool(
      result.rowCount === 1 && Number(result.rows[0].next_cursor) === expected,
    );
  }
}

async function assertOneCursorPerAccount(pool: pg.Pool) {
  const result = await pool.query(
    `select
       (select count(*)::int from public.accounts) as accounts,
       (select count(*)::int from public.account_cursor_state) as cursors,
       (select count(*)::int
          from public.account_cursor_state
         group by account_id
        having count(*) > 1
        limit 1) as duplicates`,
  );
  assertBool(
    result.rows[0].accounts === result.rows[0].cursors &&
      result.rows[0].duplicates === null,
  );
}

async function triggerCount(pool: pg.Pool) {
  const result = await pool.query(
    `select count(*)::int as count
       from pg_trigger
      where tgname='accounts_provision_cursor_state_after_insert'`,
  );
  return Number(result.rows[0].count);
}

async function functionCount(pool: pg.Pool, name: string) {
  const result = await pool.query(
    `select count(*)::int as count
       from pg_proc p
       join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public'
        and p.proname=$1`,
    [name],
  );
  return Number(result.rows[0].count);
}

async function singleFunction(pool: pg.Pool) {
  const result = await pool.query(
    `select p.*, r.rolname as owner
       from pg_proc p
       join pg_namespace n on n.oid=p.pronamespace
       join pg_roles r on r.oid=p.proowner
      where n.nspname='public'
        and p.proname='markei_provision_account_cursor_state'`,
  );
  assertBool(result.rowCount === 1);
  return result.rows[0];
}

async function functionDefinition(pool: pg.Pool, name: string) {
  const result = await pool.query(
    `select pg_get_functiondef(p.oid) as definition
       from pg_proc p
       join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public'
        and p.proname=$1`,
    [name],
  );
  assertBool(result.rowCount === 1);
  return String(result.rows[0].definition);
}

async function assertReadyV1(pool: pg.Pool, expected: boolean) {
  const result = await pool.query(
    "select public.markei_hosted_runtime_ready() as ready",
  );
  assertBool(result.rows[0].ready === expected);
}

async function assertReadyV2(pool: pg.Pool, expected: boolean) {
  const result = await pool.query(
    "select public.markei_hosted_runtime_ready_v2() as ready",
  );
  assertBool(result.rows[0].ready === expected);
}

async function withRuntimeContext(
  pool: pg.Pool,
  accountId: string,
  deviceId: string,
  action: (client: pg.PoolClient) => Promise<void>,
) {
  const client = await pool.connect();
  try {
    await client.query("begin");
    await client.query("select set_config('markei.account_id', $1, true)", [
      accountId,
    ]);
    await client.query("select set_config('markei.device_id', $1, true)", [
      deviceId,
    ]);
    await action(client);
    await client.query("commit");
  } catch (error) {
    await client.query("rollback").catch(() => undefined);
    throw error;
  } finally {
    client.release();
  }
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
