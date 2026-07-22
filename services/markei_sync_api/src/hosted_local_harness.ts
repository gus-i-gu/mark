import { readFileSync } from "node:fs";
import pg from "pg";
import {
  authorizationCaseMapFromResults,
  createSyntheticJwks,
  coreCheckpointSummary,
  membershipSliceIds,
  runR04C02CoreAuthorizationScenarios,
  runR04C04CompletionScenarios,
  runMembershipDisabledBeforeFenceScenario,
} from "./proof/authorization_slice_scenarios.js";
import { makeProducerResult } from "./proof/producer.js";

const labMigratorUrl = process.env.LAB_MIGRATOR_URL;
const labRuntimeUrl = process.env.LAB_RUNTIME_URL;
if (!labMigratorUrl || !labRuntimeUrl) {
  throw new Error(
    "LAB_MIGRATOR_URL and LAB_RUNTIME_URL are required for hosted-local proof",
  );
}

const migratorPool = new pg.Pool({ connectionString: labMigratorUrl, max: 2 });
const runtimePool = new pg.Pool({ connectionString: labRuntimeUrl, max: 4 });
const jwks = await createSyntheticJwks();

try {
  await migrate(migratorPool);
  await seed(migratorPool, jwks.issuer);
  const r04c01 = await runMembershipDisabledBeforeFenceScenario({
    migratorPool,
    runtimePool,
    issuer: jwks.issuer,
    audience: jwks.audience,
    token: jwks.token,
  });
  const r04c02Scenarios = await runR04C02CoreAuthorizationScenarios({
    migratorPool,
    runtimePool,
    issuer: jwks.issuer,
    audience: jwks.audience,
    token: jwks.token,
  });
  const scenarios = [
    r04c01,
    ...r04c02Scenarios,
    ...(await runR04C04CompletionScenarios(
      {
        migratorPool,
        runtimePool,
        issuer: jwks.issuer,
        audience: jwks.audience,
        token: jwks.token,
      },
      [r04c01, ...r04c02Scenarios],
    )),
  ];
  const summary = coreCheckpointSummary(scenarios);
  const authorizationProducer = makeProducerResult(
    "authorization-race",
    authorizationCaseMapFromResults(scenarios),
    "authorization-proof-complete",
  );
  process.stdout.write(
    `R04C01_CASE membership-disabled-before-fence=${r04c01.passed ? "true" : "false"} status=${r04c01.responseStatus ?? "none"} code=${r04c01.responseCode ?? "none"}\n`,
  );
  for (const scenario of scenarios) {
    process.stdout.write(
      `AUTHORIZATION_CASE ${scenario.caseId}=${scenario.passed ? "true" : "false"} status=${scenario.responseStatus ?? "none"} code=${scenario.responseCode ?? "none"} state=${scenario.stateInvariant === true ? "true" : "false"} blocker=${scenario.blocker ?? "none"}\n`,
    );
  }
  process.stdout.write(`R04C02_CP_A=${summary.cpA ? "true" : "false"}\n`);
  process.stdout.write(`R04C02_CP_B=${summary.cpB ? "true" : "false"}\n`);
  process.stdout.write(`R04C02_CP_C=${summary.cpC ? "true" : "false"}\n`);
  process.stdout.write(
    `R04C04_COMPLETE=${summary.r04c04 ? "true" : "false"}\n`,
  );
  process.stdout.write(`AUTHORIZATION_CASES_TRUE=${summary.trueCount}\n`);
  process.stdout.write(`AUTHORIZATION_CASES_PENDING=${summary.pendingCount}\n`);
  process.stdout.write(
    `R04C01_MEMBERSHIP_DENIAL_SLICE=${r04c01.passed ? "true" : "false"}\n`,
  );
  process.stdout.write(
    `AUTHORIZATION_RACE_PRODUCER=${authorizationProducer.passed ? "true" : "false"}\n`,
  );
  process.stdout.write("R3_LOCAL_SECURITY_PROVED=false\n");
  process.stdout.write(
    `PROOF_PRODUCER authorization-race ${JSON.stringify(authorizationProducer)}\n`,
  );
  if (!authorizationProducer.passed) process.exitCode = 1;
} finally {
  await runtimePool.end().catch(() => undefined);
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
      "007_account_cursor_provisioning",
    ]) {
      const path = new URL(`../migrations/${id}.sql`, import.meta.url);
      await client.query(readFileSync(path, "utf8"));
    }
  } finally {
    client.release();
  }
}

async function seed(pool: pg.Pool, issuer: string) {
  await pool.query(
    "insert into accounts(account_id) values($1) on conflict do nothing",
    [membershipSliceIds.account],
  );
  await pool.query(
    `insert into external_identities(identity_id, issuer, subject, status)
     values($1,$2,'auth0|principal-a','active') on conflict do nothing`,
    [membershipSliceIds.identity, issuer],
  );
  await pool.query(
    `insert into account_memberships(account_id, identity_id, role, status)
     values($1,$2,'owner','active') on conflict do nothing`,
    [membershipSliceIds.account, membershipSliceIds.identity],
  );
}
