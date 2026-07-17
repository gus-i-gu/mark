import Fastify from "fastify";
import { Buffer } from "node:buffer";
import pg from "pg";
import { exportJWK, generateKeyPair, SignJWT } from "jose";
import { canonicalHash } from "../domain/protocol.js";
import { encodeCursor } from "../domain/cursor.js";
import { buildApp } from "../http/app.js";
import { Auth0JwtVerifier } from "../application/jwt_verifier.js";
import {
  HostedIdentityService,
  HostedTransactionAuthorizer,
} from "../application/hosted_authorization.js";
import { systemClock } from "../application/hosted_contracts.js";
import type { RecoveryComposition } from "../application/recovery_service.js";
import type { Database } from "../postgres/database.js";
import {
  observeAccountState,
  type AccountStateSnapshot,
  protectedStateMatchesExceptMembership,
  stableJson,
} from "./account_state_observer.js";
import { AuthorizationBarrierController } from "./authorization_barrier_controller.js";

export type ScenarioResult = {
  caseId: string;
  passed: boolean;
  blocker?: string;
  responseStatus?: number;
  responseCode?: string;
  operation?: string;
  route?: string;
  participant?: string;
  phase?: string;
  stateInvariant?: boolean;
  transitionCount?: number;
  eventCount?: number;
  enrollmentResultCount?: number;
  deviceCount?: number;
  before?: string;
  after?: string;
};

export const membershipSliceIds = {
  account: "11111111-1111-4111-8111-111111111111",
  identity: "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa",
  installation: "33333333-3333-4333-8333-333333333333",
  enrollment: "66666666-6666-4666-8666-666666666666",
  submission: "77777777-7777-4777-8777-777777777777",
  event: "88888888-8888-4888-8888-888888888888",
  purchase: "99999999-9999-4999-8999-999999999999",
  store: "12121212-1212-4212-8212-121212121212",
} as const;

const pendingR04C04Cases = new Set([
  "response-loss-query-replay",
  "process-restart-replay",
  "serialization-retry-exhaustion-fails-closed",
  "denied-no-state-advance",
]);

export const coreCaseIds = [
  "membership-disabled-before-fence",
  "membership-removed-before-fence",
  "external-identity-disabled-before-mutation",
  "actor-device-revoked-before-upload",
  "actor-device-revoked-before-download",
  "actor-device-revoked-before-acknowledgement",
  "actor-device-revoked-before-capabilities",
  "actor-device-revoked-before-rebootstrap-start",
  "actor-device-revoked-before-rebootstrap-status",
  "actor-device-revoked-before-rebootstrap-chunk",
  "actor-device-revoked-before-rebootstrap-complete",
  "actor-device-revoked-before-device-status",
  "actor-device-revoked-before-device-revoke",
  "owner-target-status",
  "owner-target-revoke",
  "member-self-status",
  "member-self-revoke",
  "foreign-target-denial",
  "cross-account-target-denial",
  "concurrent-target-revoke-one-transition-one-event",
  "independent-repeat-revoke-duplicate-equivalent",
  "self-revoked-actor-denied-later",
  "equivalent-concurrent-enrollment",
  "conflicting-enrollment-request-hash",
] as const;

export type CoreCaseId = (typeof coreCaseIds)[number];

type ScenarioOptions = {
  migratorPool: pg.Pool;
  runtimePool: pg.Pool;
  issuer: string;
  audience: string;
  token: (subject: string) => Promise<string>;
};

type ActorRoute = {
  caseId: CoreCaseId;
  operation: string;
  route: (
    origin: string,
    deviceId: string,
    recovery?: RecoveryFixture,
  ) => string;
  method: "GET" | "POST";
  body?: (deviceId: string, recovery?: RecoveryFixture) => unknown;
  prepare?: (
    env: ScenarioEnvironment,
    token: string,
    deviceId: string,
  ) => Promise<RecoveryFixture | undefined>;
};

type RecoveryFixture = {
  sessionId: string;
  snapshotId: string;
  manifestHash: string;
  coveredCursor: string;
};

type ScenarioEnvironment = {
  origin: string;
  app: ReturnType<typeof buildApp>;
  barrier: AuthorizationBarrierController;
  database: Database;
  migratorPool: pg.Pool;
  recovery: RecoveryComposition;
};

const deviceCaseIds = new Map<string, string>();

export async function runMembershipDisabledBeforeFenceScenario(options: {
  migratorPool: pg.Pool;
  runtimePool: pg.Pool;
  issuer: string;
  audience: string;
  token: (subject: string) => Promise<string>;
}): Promise<ScenarioResult> {
  const scenario = "membership-disabled-before-fence";
  const participant = "upload";
  const barrier = new AuthorizationBarrierController(
    [{ scenario, participant, phase: "before-identity-membership-fence" }],
    10000,
  );
  const database: Database = {
    pool: options.runtimePool,
    beforeCommit: (context) =>
      barrier.reach("before-commit", {
        operation: context.operation ?? "unknown",
        scenario: context.scenario,
        participant: context.participant,
        accountId: context.accountId,
        identityId: context.identityId,
        actorDeviceId: context.actorDeviceId,
        targetDeviceId: context.targetDeviceId,
      }),
  };
  const verifier = new Auth0JwtVerifier({
    issuer: options.issuer,
    audience: options.audience,
    jwksUri: `${options.issuer}.well-known/jwks.json`,
    clock: systemClock,
  });
  const hosted = new HostedIdentityService(
    database,
    verifier,
    systemClock,
    barrier,
  );
  const app = buildApp({
    authorization: {
      kind: "hosted",
      identityService: hosted,
      transactionAuthorizer: new HostedTransactionAuthorizer(
        database,
        verifier,
        barrier,
      ),
    },
    database,
  });
  try {
    await app.listen({ host: "127.0.0.1", port: 0 });
    const origin = `http://127.0.0.1:${(app.server.address() as { port: number }).port}`;
    const token = await options.token("auth0|principal-a");
    const enrollment = await post(`${origin}/v1/devices/enroll`, token, {
      contractVersion: 1,
      installationId: membershipSliceIds.installation,
      enrollmentRequestId: membershipSliceIds.enrollment,
      platform: "test",
      applicationId: "markei.hosted.local",
      applicationVersion: "1.0.0",
    });
    const before = await observeAccountState(
      options.migratorPool,
      membershipSliceIds.account,
    );
    const upload = postRaw(
      `${origin}/v1/sync/submissions`,
      token,
      uploadBody(enrollment.deviceId),
      enrollment.deviceId,
      {
        "x-markei-proof-scenario": scenario,
        "x-markei-proof-participant": participant,
      },
    );
    await barrier.waitUntilReached(
      scenario,
      participant,
      "before-identity-membership-fence",
    );
    await options.migratorPool.query(
      `update account_memberships
          set status='disabled', updated_at=now()
        where account_id=$1 and identity_id=$2`,
      [membershipSliceIds.account, membershipSliceIds.identity],
    );
    barrier.release(scenario, participant, "before-identity-membership-fence");
    const response = await upload;
    const after = await observeAccountState(
      options.migratorPool,
      membershipSliceIds.account,
    );
    const protectedUnchanged = protectedStateMatchesExceptMembership(
      before,
      after,
    );
    const passed =
      response.status === 403 &&
      response.body.code === "membership-required" &&
      protectedUnchanged;
    return {
      caseId: scenario,
      passed,
      blocker: passed ? undefined : "membership-denial-slice-failed",
      responseStatus: response.status,
      responseCode:
        typeof response.body.code === "string" ? response.body.code : undefined,
      before: stableJson(before),
      after: stableJson(after),
    };
  } catch (error) {
    return {
      caseId: scenario,
      passed: false,
      blocker:
        error instanceof Error && error.message.includes("timeout")
          ? "barrier-timeout"
          : "membership-denial-slice-failed",
    };
  } finally {
    barrier.close();
    await app.close().catch(() => undefined);
  }
}

export async function runR04C02CoreAuthorizationScenarios(
  options: ScenarioOptions,
): Promise<ScenarioResult[]> {
  const results: ScenarioResult[] = [];
  results.push(
    await runTracked("membership-removed-before-fence", () =>
      runMembershipRemovedBeforeFenceScenario(options),
    ),
  );
  results.push(
    await runTracked("external-identity-disabled-before-mutation", () =>
      runExternalIdentityDisabledScenario(options),
    ),
  );
  for (const route of actorRoutes()) {
    results.push(
      await runTracked(route.caseId, () =>
        runActorDeviceRevokedScenario(options, route),
      ),
    );
  }
  for (const caseId of [
    "owner-target-status",
    "owner-target-revoke",
    "member-self-status",
    "member-self-revoke",
    "foreign-target-denial",
    "cross-account-target-denial",
    "concurrent-target-revoke-one-transition-one-event",
    "independent-repeat-revoke-duplicate-equivalent",
    "self-revoked-actor-denied-later",
    "equivalent-concurrent-enrollment",
    "conflicting-enrollment-request-hash",
  ] as const) {
    results.push(
      await runTracked(caseId, () =>
        runTargetOrEnrollmentScenario(options, caseId),
      ),
    );
  }
  return results;
}

async function runTracked(
  caseId: string,
  action: () => Promise<ScenarioResult>,
) {
  process.stdout.write(`R04C02_START ${caseId}\n`);
  const result = await action();
  process.stdout.write(
    `R04C02_DONE ${caseId}=${result.passed ? "true" : "false"}\n`,
  );
  return result;
}

export function authorizationCaseMapFromResults(results: ScenarioResult[]) {
  const byCase: Record<string, boolean | { passed: boolean; blocker: string }> =
    {};
  for (const result of results) {
    byCase[result.caseId] = result.passed
      ? true
      : { passed: false, blocker: result.blocker ?? "case-failed" };
  }
  for (const caseId of pendingR04C04Cases) {
    byCase[caseId] = { passed: false, blocker: "pending-r04c04" };
  }
  return byCase;
}

export function coreCheckpointSummary(results: ScenarioResult[]) {
  const passed = new Set(
    results.filter((result) => result.passed).map((result) => result.caseId),
  );
  return {
    cpA: [
      "membership-disabled-before-fence",
      "membership-removed-before-fence",
      "external-identity-disabled-before-mutation",
      ...actorRoutes().map((route) => route.caseId),
    ].every((caseId) => passed.has(caseId)),
    cpB: [
      "owner-target-status",
      "owner-target-revoke",
      "member-self-status",
      "member-self-revoke",
      "foreign-target-denial",
      "cross-account-target-denial",
      "concurrent-target-revoke-one-transition-one-event",
      "independent-repeat-revoke-duplicate-equivalent",
      "self-revoked-actor-denied-later",
    ].every((caseId) => passed.has(caseId)),
    cpC: [
      "equivalent-concurrent-enrollment",
      "conflicting-enrollment-request-hash",
    ].every((caseId) => passed.has(caseId)),
    trueCount: coreCaseIds.filter((caseId) => passed.has(caseId)).length,
    pendingCount: pendingR04C04Cases.size,
  };
}

async function runMembershipRemovedBeforeFenceScenario(
  options: ScenarioOptions,
) {
  return runMembershipAuthorityScenario(
    options,
    "membership-removed-before-fence",
    "removed",
  );
}

async function runMembershipAuthorityScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
  status: "disabled" | "removed",
): Promise<ScenarioResult> {
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, [
    {
      scenario: caseId,
      participant: "upload",
      phase: "before-identity-membership-fence",
    },
  ]);
  try {
    const token = await options.token(subjectFor(caseId, "owner"));
    const enrollment = await enrollDevice(
      env.origin,
      token,
      ids(caseId, "owner-install"),
      ids(caseId, "owner-enroll"),
    );
    deviceCaseIds.set(enrollment.deviceId, caseId);
    const before = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const upload = postRaw(
      `${env.origin}/v1/sync/submissions`,
      token,
      uploadBodyFor(caseId, enrollment.deviceId),
      enrollment.deviceId,
      proofHeaders(caseId, "upload"),
    );
    await env.barrier.waitUntilReached(
      caseId,
      "upload",
      "before-identity-membership-fence",
    );
    await options.migratorPool.query(
      "update account_memberships set status=$3, updated_at=now() where account_id=$1 and identity_id=$2",
      [accountId(caseId), identityId(caseId, "owner"), status],
    );
    env.barrier.release(caseId, "upload", "before-identity-membership-fence");
    const response = await upload;
    const after = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const invariant = protectedStateMatchesExceptMembership(before, after);
    return scenarioResult(caseId, response, invariant, {
      operation: "upload-submission",
      route: "POST /v1/sync/submissions",
      participant: "upload",
      phase: "before-identity-membership-fence",
      before,
      after,
      expectedCode: "membership-required",
    });
  } finally {
    await env.close();
  }
}

async function runExternalIdentityDisabledScenario(options: ScenarioOptions) {
  const caseId = "external-identity-disabled-before-mutation";
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, [
    {
      scenario: caseId,
      participant: "upload",
      phase: "before-identity-membership-fence",
    },
  ]);
  try {
    const token = await options.token(subjectFor(caseId, "owner"));
    const enrollment = await enrollDevice(
      env.origin,
      token,
      ids(caseId, "owner-install"),
      ids(caseId, "owner-enroll"),
    );
    deviceCaseIds.set(enrollment.deviceId, caseId);
    const before = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const upload = postRaw(
      `${env.origin}/v1/sync/submissions`,
      token,
      uploadBodyFor(caseId, enrollment.deviceId),
      enrollment.deviceId,
      proofHeaders(caseId, "upload"),
    );
    await env.barrier.waitUntilReached(
      caseId,
      "upload",
      "before-identity-membership-fence",
    );
    await options.migratorPool.query(
      "update external_identities set status='disabled', updated_at=now() where identity_id=$1",
      [identityId(caseId, "owner")],
    );
    env.barrier.release(caseId, "upload", "before-identity-membership-fence");
    const response = await upload;
    const after = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const invariant = protectedStateMatchesExceptMembership(before, after);
    return scenarioResult(caseId, response, invariant, {
      operation: "upload-submission",
      route: "POST /v1/sync/submissions",
      participant: "upload",
      phase: "before-identity-membership-fence",
      before,
      after,
      expectedCode: "membership-required",
    });
  } finally {
    await env.close();
  }
}

async function runActorDeviceRevokedScenario(
  options: ScenarioOptions,
  route: ActorRoute,
): Promise<ScenarioResult> {
  const caseId = route.caseId;
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, [
    {
      scenario: caseId,
      participant: "actor",
      phase: "before-identity-membership-fence",
    },
    { scenario: caseId, participant: "actor", phase: "after-membership-lock" },
    {
      scenario: caseId,
      participant: "actor",
      phase: "before-actor-device-lock",
    },
  ]);
  try {
    env.barrier.release(caseId, "actor", "before-identity-membership-fence");
    env.barrier.release(caseId, "actor", "after-membership-lock");
    const token = await options.token(subjectFor(caseId, "owner"));
    const enrollment = await enrollDevice(
      env.origin,
      token,
      ids(caseId, "actor-install"),
      ids(caseId, "actor-enroll"),
    );
    deviceCaseIds.set(enrollment.deviceId, caseId);
    await maybeCreateUpload(env.origin, token, enrollment.deviceId, caseId);
    const recovery = await route.prepare?.(env, token, enrollment.deviceId);
    const before = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const request = http(
      route.method,
      route.route(env.origin, enrollment.deviceId, recovery),
      token,
      enrollment.deviceId,
      route.body?.(enrollment.deviceId, recovery),
      proofHeaders(caseId, "actor"),
    );
    await env.barrier.waitUntilReached(
      caseId,
      "actor",
      "before-actor-device-lock",
    );
    await revokeDeviceDirect(options.migratorPool, caseId, enrollment.deviceId);
    env.barrier.release(caseId, "actor", "before-actor-device-lock");
    const response = await request;
    const after = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const invariant = syncStateMatches(before, after);
    return scenarioResult(caseId, response, invariant, {
      operation: route.operation,
      route: `${route.method} ${route.route("/origin", ":deviceId", recovery).replace("/origin", "")}`,
      participant: "actor",
      phase: "before-actor-device-lock",
      before,
      after,
      expectedCode: "device-revoked",
    });
  } finally {
    await env.close();
  }
}

async function runTargetOrEnrollmentScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
): Promise<ScenarioResult> {
  if (caseId.startsWith("owner-target") || caseId.startsWith("member-self")) {
    return runAllowedTargetScenario(options, caseId);
  }
  if (
    caseId === "foreign-target-denial" ||
    caseId === "cross-account-target-denial"
  ) {
    return runDeniedTargetScenario(options, caseId);
  }
  if (caseId === "concurrent-target-revoke-one-transition-one-event") {
    return runConcurrentRevokeScenario(options, caseId);
  }
  if (caseId === "independent-repeat-revoke-duplicate-equivalent") {
    return runRepeatRevokeScenario(options, caseId);
  }
  if (caseId === "self-revoked-actor-denied-later") {
    return runSelfRevokedLaterScenario(options, caseId);
  }
  if (caseId === "equivalent-concurrent-enrollment") {
    return runEquivalentEnrollmentScenario(options, caseId);
  }
  return runConflictingEnrollmentScenario(options, caseId);
}

async function runAllowedTargetScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
): Promise<ScenarioResult> {
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, []);
  try {
    const ownerToken = await options.token(subjectFor(caseId, "owner"));
    const memberToken = await options.token(subjectFor(caseId, "member"));
    const owner = await enrollDevice(
      env.origin,
      ownerToken,
      ids(caseId, "owner-install"),
      ids(caseId, "owner-enroll"),
    );
    const member = await enrollDevice(
      env.origin,
      memberToken,
      ids(caseId, "member-install"),
      ids(caseId, "member-enroll"),
    );
    deviceCaseIds.set(owner.deviceId, caseId);
    deviceCaseIds.set(member.deviceId, caseId);
    const isStatus = caseId.endsWith("status");
    const actorToken = caseId.startsWith("owner") ? ownerToken : memberToken;
    const actorDevice = caseId.startsWith("owner")
      ? owner.deviceId
      : member.deviceId;
    const targetDevice = caseId.startsWith("owner")
      ? member.deviceId
      : member.deviceId;
    const before = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const response = await http(
      isStatus ? "GET" : "POST",
      `${env.origin}/v1/devices/${targetDevice}/${isStatus ? "status" : "revoke"}`,
      actorToken,
      actorDevice,
      isStatus ? undefined : {},
    );
    const after = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const expectedStatus = isStatus ? 200 : 200;
    const expectedCode = undefined;
    const invariant = response.status === expectedStatus;
    const securityEvents = await securityEventCount(
      options.migratorPool,
      caseId,
      "device-revoked",
    );
    return scenarioResult(caseId, response, invariant, {
      operation: isStatus ? "device-status" : "device-revoke",
      route: `GET/POST /v1/devices/:deviceId/${isStatus ? "status" : "revoke"}`,
      participant: caseId.startsWith("owner") ? "owner" : "member",
      before,
      after,
      expectedCode,
      eventCount: securityEvents,
      transitionCount: isStatus ? 0 : 1,
    });
  } finally {
    await env.close();
  }
}

async function runDeniedTargetScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
): Promise<ScenarioResult> {
  await resetAndSeed(options.migratorPool, options.issuer, caseId, {
    includeForeignAccount: caseId === "cross-account-target-denial",
  });
  const env = await startScenarioEnvironment(options, []);
  try {
    const ownerToken = await options.token(subjectFor(caseId, "owner"));
    const memberToken = await options.token(subjectFor(caseId, "member"));
    const owner = await enrollDevice(
      env.origin,
      ownerToken,
      ids(caseId, "owner-install"),
      ids(caseId, "owner-enroll"),
    );
    const member = await enrollDevice(
      env.origin,
      memberToken,
      ids(caseId, "member-install"),
      ids(caseId, "member-enroll"),
    );
    deviceCaseIds.set(owner.deviceId, caseId);
    deviceCaseIds.set(member.deviceId, caseId);
    const targetDevice =
      caseId === "cross-account-target-denial"
        ? await seedForeignDevice(options.migratorPool, caseId)
        : owner.deviceId;
    const before = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const response = await http(
      "GET",
      `${env.origin}/v1/devices/${targetDevice}/status`,
      memberToken,
      member.deviceId,
    );
    const after = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    return scenarioResult(caseId, response, syncStateMatches(before, after), {
      operation: "device-status",
      route: "GET /v1/devices/:deviceId/status",
      participant: "member",
      before,
      after,
      expectedCode: "forbidden",
    });
  } finally {
    await env.close();
  }
}

async function runConcurrentRevokeScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
): Promise<ScenarioResult> {
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, []);
  try {
    const ownerToken = await options.token(subjectFor(caseId, "owner"));
    const actor = await enrollDevice(
      env.origin,
      ownerToken,
      ids(caseId, "actor-install"),
      ids(caseId, "actor-enroll"),
    );
    const target = await enrollDevice(
      env.origin,
      ownerToken,
      ids(caseId, "target-install"),
      ids(caseId, "target-enroll"),
    );
    deviceCaseIds.set(actor.deviceId, caseId);
    deviceCaseIds.set(target.deviceId, caseId);
    const beforeEvents = await securityEventCount(
      options.migratorPool,
      caseId,
      "device-revoked",
    );
    const responses = await Promise.all([
      http(
        "POST",
        `${env.origin}/v1/devices/${target.deviceId}/revoke`,
        ownerToken,
        actor.deviceId,
        {},
      ),
      http(
        "POST",
        `${env.origin}/v1/devices/${target.deviceId}/revoke`,
        ownerToken,
        actor.deviceId,
        {},
      ),
    ]);
    const afterEvents = await securityEventCount(
      options.migratorPool,
      caseId,
      "device-revoked",
    );
    const targetStatus = await deviceStatus(
      options.migratorPool,
      caseId,
      target.deviceId,
    );
    const eventCount = afterEvents - beforeEvents;
    const statuses = responses.map((response) => response.body.status).sort();
    const invariant =
      responses.every((response) => response.status === 200) &&
      targetStatus === "revoked" &&
      eventCount === 1 &&
      JSON.stringify(statuses) ===
        JSON.stringify(["duplicate-equivalent", "revoked"]);
    return {
      caseId,
      passed: invariant,
      blocker: invariant ? undefined : "concurrent-revoke-failed",
      operation: "device-revoke",
      route: "POST /v1/devices/:deviceId/revoke",
      participant: "owner",
      responseStatus: responses[0]?.status,
      stateInvariant: invariant,
      transitionCount: targetStatus === "revoked" ? 1 : 0,
      eventCount,
    };
  } finally {
    await env.close();
  }
}

async function runRepeatRevokeScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
): Promise<ScenarioResult> {
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, []);
  try {
    const ownerToken = await options.token(subjectFor(caseId, "owner"));
    const actor = await enrollDevice(
      env.origin,
      ownerToken,
      ids(caseId, "actor-install"),
      ids(caseId, "actor-enroll"),
    );
    const target = await enrollDevice(
      env.origin,
      ownerToken,
      ids(caseId, "target-install"),
      ids(caseId, "target-enroll"),
    );
    deviceCaseIds.set(actor.deviceId, caseId);
    deviceCaseIds.set(target.deviceId, caseId);
    const first = await http(
      "POST",
      `${env.origin}/v1/devices/${target.deviceId}/revoke`,
      ownerToken,
      actor.deviceId,
      {},
    );
    const beforeEvents = await securityEventCount(
      options.migratorPool,
      caseId,
      "device-revoked",
    );
    const second = await http(
      "POST",
      `${env.origin}/v1/devices/${target.deviceId}/revoke`,
      ownerToken,
      actor.deviceId,
      {},
    );
    const afterEvents = await securityEventCount(
      options.migratorPool,
      caseId,
      "device-revoked",
    );
    const invariant =
      first.status === 200 &&
      first.body.status === "revoked" &&
      second.status === 200 &&
      second.body.status === "duplicate-equivalent" &&
      afterEvents === beforeEvents;
    return {
      caseId,
      passed: invariant,
      blocker: invariant ? undefined : "repeat-revoke-failed",
      operation: "device-revoke",
      route: "POST /v1/devices/:deviceId/revoke",
      participant: "owner",
      responseStatus: second.status,
      stateInvariant: invariant,
      transitionCount: 1,
      eventCount: afterEvents,
    };
  } finally {
    await env.close();
  }
}

async function runSelfRevokedLaterScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
): Promise<ScenarioResult> {
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, []);
  try {
    const ownerToken = await options.token(subjectFor(caseId, "owner"));
    const actor = await enrollDevice(
      env.origin,
      ownerToken,
      ids(caseId, "actor-install"),
      ids(caseId, "actor-enroll"),
    );
    deviceCaseIds.set(actor.deviceId, caseId);
    await http(
      "POST",
      `${env.origin}/v1/devices/${actor.deviceId}/revoke`,
      ownerToken,
      actor.deviceId,
      {},
    );
    const before = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    const response = await http(
      "POST",
      `${env.origin}/v1/sync/submissions`,
      ownerToken,
      actor.deviceId,
      uploadBodyFor(caseId, actor.deviceId),
    );
    const after = await observeAccountState(
      options.migratorPool,
      accountId(caseId),
    );
    return scenarioResult(caseId, response, syncStateMatches(before, after), {
      operation: "upload-submission",
      route: "POST /v1/sync/submissions",
      participant: "actor",
      before,
      after,
      expectedCode: "device-revoked",
    });
  } finally {
    await env.close();
  }
}

async function runEquivalentEnrollmentScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
): Promise<ScenarioResult> {
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, []);
  try {
    const token = await options.token(subjectFor(caseId, "owner"));
    const body = enrollmentBody(
      ids(caseId, "same-install"),
      ids(caseId, "same-request"),
    );
    const [first, second] = await Promise.all([
      postRaw(`${env.origin}/v1/devices/enroll`, token, body),
      postRaw(`${env.origin}/v1/devices/enroll`, token, body),
    ]);
    const deviceCountValue = await countRows(
      options.migratorPool,
      "devices",
      caseId,
    );
    const resultCount = await countRows(
      options.migratorPool,
      "device_enrollment_requests",
      caseId,
    );
    const invariant =
      first.status === 200 &&
      second.status === 200 &&
      first.body.deviceId === second.body.deviceId &&
      deviceCountValue === 1 &&
      resultCount === 1;
    return {
      caseId,
      passed: invariant,
      blocker: invariant ? undefined : "equivalent-enrollment-failed",
      operation: "enroll-device",
      route: "POST /v1/devices/enroll",
      participant: "enrollment",
      responseStatus: second.status,
      stateInvariant: invariant,
      deviceCount: deviceCountValue,
      enrollmentResultCount: resultCount,
    };
  } finally {
    await env.close();
  }
}

async function runConflictingEnrollmentScenario(
  options: ScenarioOptions,
  caseId: CoreCaseId,
): Promise<ScenarioResult> {
  await resetAndSeed(options.migratorPool, options.issuer, caseId);
  const env = await startScenarioEnvironment(options, []);
  try {
    const token = await options.token(subjectFor(caseId, "owner"));
    const requestId = ids(caseId, "same-request");
    const first = await postRaw(
      `${env.origin}/v1/devices/enroll`,
      token,
      enrollmentBody(ids(caseId, "install-a"), requestId),
    );
    const second = await postRaw(
      `${env.origin}/v1/devices/enroll`,
      token,
      enrollmentBody(ids(caseId, "install-b"), requestId),
    );
    const deviceCountValue = await countRows(
      options.migratorPool,
      "devices",
      caseId,
    );
    const resultCount = await countRows(
      options.migratorPool,
      "device_enrollment_requests",
      caseId,
    );
    const invariant =
      first.status === 200 &&
      second.status === 409 &&
      second.body.code === "conflict" &&
      deviceCountValue === 1 &&
      resultCount === 1;
    return {
      caseId,
      passed: invariant,
      blocker: invariant ? undefined : "conflicting-enrollment-failed",
      operation: "enroll-device",
      route: "POST /v1/devices/enroll",
      participant: "enrollment",
      responseStatus: second.status,
      responseCode: second.body.code,
      stateInvariant: invariant,
      deviceCount: deviceCountValue,
      enrollmentResultCount: resultCount,
    };
  } finally {
    await env.close();
  }
}

export async function createSyntheticJwks() {
  const keys = await generateKeyPair("RS256", { extractable: true });
  const publicJwk = await exportJWK(keys.publicKey);
  publicJwk.kid = "local-key-1";
  publicJwk.alg = "RS256";
  publicJwk.use = "sig";
  const jwks = Fastify({ logger: false });
  jwks.get("/.well-known/jwks.json", async () => ({ keys: [publicJwk] }));
  await jwks.listen({ host: "127.0.0.1", port: 0 });
  const issuer = `http://127.0.0.1:${(jwks.server.address() as { port: number }).port}/`;
  const audience = "markei-sync-api";
  return {
    issuer,
    audience,
    token: (subject: string) =>
      new SignJWT({})
        .setProtectedHeader({ alg: "RS256", kid: "local-key-1" })
        .setIssuer(issuer)
        .setAudience(audience)
        .setSubject(subject)
        .setIssuedAt()
        .setExpirationTime("10m")
        .sign(keys.privateKey),
    close: () => jwks.close(),
  };
}

function actorRoutes(): ActorRoute[] {
  return [
    {
      caseId: "actor-device-revoked-before-upload",
      operation: "upload-submission",
      method: "POST",
      route: (origin) => `${origin}/v1/sync/submissions`,
      body: (deviceId) =>
        uploadBodyFor("actor-device-revoked-before-upload", deviceId),
    },
    {
      caseId: "actor-device-revoked-before-download",
      operation: "download-events",
      method: "GET",
      route: (origin) => `${origin}/v1/sync/events?after=c10b:0&limit=10`,
    },
    {
      caseId: "actor-device-revoked-before-acknowledgement",
      operation: "acknowledgement",
      method: "POST",
      route: (origin) => `${origin}/v1/sync/acknowledgements`,
      body: () => ({ greatestContiguousCursor: encodeCursor(1) }),
    },
    {
      caseId: "actor-device-revoked-before-capabilities",
      operation: "capabilities",
      method: "GET",
      route: (origin) => `${origin}/v1/sync/capabilities`,
      prepare: prepareRecoveryFixture,
    },
    {
      caseId: "actor-device-revoked-before-rebootstrap-start",
      operation: "start-rebootstrap",
      method: "POST",
      route: (origin) => `${origin}/v1/sync/rebootstrap`,
      body: (_deviceId, recovery) => {
        const request = {
          recoverySessionId:
            recovery?.sessionId ??
            ids("actor-device-revoked-before-rebootstrap-start", "session"),
          supportedSnapshotFormats: [1],
        };
        return { ...request, requestHash: canonicalHash(request) };
      },
      prepare: prepareRecoveryFixture,
    },
    {
      caseId: "actor-device-revoked-before-rebootstrap-status",
      operation: "query-rebootstrap",
      method: "GET",
      route: (origin, _deviceId, recovery) =>
        `${origin}/v1/sync/rebootstrap/${recovery?.sessionId}`,
      prepare: prepareStartedRecoveryFixture,
    },
    {
      caseId: "actor-device-revoked-before-rebootstrap-chunk",
      operation: "download-rebootstrap-chunk",
      method: "GET",
      route: (origin, _deviceId, recovery) =>
        `${origin}/v1/sync/rebootstrap/${recovery?.sessionId}/chunks/0`,
      prepare: prepareStartedRecoveryFixture,
    },
    {
      caseId: "actor-device-revoked-before-rebootstrap-complete",
      operation: "complete-rebootstrap",
      method: "POST",
      route: (origin, _deviceId, recovery) =>
        `${origin}/v1/sync/rebootstrap/${recovery?.sessionId}/complete`,
      body: (_deviceId, recovery) => ({
        snapshotId: recovery?.snapshotId,
        manifestHash: recovery?.manifestHash,
        committedCatchUpCursor: recovery?.coveredCursor,
      }),
      prepare: prepareStartedRecoveryFixture,
    },
    {
      caseId: "actor-device-revoked-before-device-status",
      operation: "device-status",
      method: "GET",
      route: (origin, deviceId) => `${origin}/v1/devices/${deviceId}/status`,
    },
    {
      caseId: "actor-device-revoked-before-device-revoke",
      operation: "device-revoke",
      method: "POST",
      route: (origin, deviceId) => `${origin}/v1/devices/${deviceId}/revoke`,
      body: () => ({}),
    },
  ];
}

async function startScenarioEnvironment(
  options: ScenarioOptions,
  keys: ConstructorParameters<typeof AuthorizationBarrierController>[0],
): Promise<ScenarioEnvironment & { close: () => Promise<void> }> {
  const barrier = new AuthorizationBarrierController(keys, 10000);
  const database: Database = {
    pool: options.runtimePool,
    beforeCommit: (context) =>
      barrier.reach("before-commit", {
        operation: context.operation,
        scenario: context.scenario,
        participant: context.participant,
        accountId: context.accountId,
        identityId: context.identityId,
        actorDeviceId: context.actorDeviceId,
        targetDeviceId: context.targetDeviceId,
      }),
  };
  const verifier = new Auth0JwtVerifier({
    issuer: options.issuer,
    audience: options.audience,
    jwksUri: `${options.issuer}.well-known/jwks.json`,
    clock: systemClock,
  });
  const recovery = {
    policy: {
      policyVersion: 1002,
      minimumEventRetentionMs: 1000,
      recentContactMs: 60000,
      snapshotChunkMaxBytes: 512,
      cleanupBatchMaxRows: 100,
      recoverySessionLifetimeMs: 600000,
      supportedSnapshotFormats: [1],
      supportedEventPayloadVersions: [3],
      compatibleSchemaVersion: 6,
    },
    clock: systemClock,
  };
  const identityService = new HostedIdentityService(
    database,
    verifier,
    systemClock,
    barrier,
  );
  const app = buildApp({
    authorization: {
      kind: "hosted",
      identityService,
      transactionAuthorizer: new HostedTransactionAuthorizer(
        database,
        verifier,
        barrier,
      ),
    },
    database,
    recovery,
  });
  await app.listen({ host: "127.0.0.1", port: 0 });
  const origin = `http://127.0.0.1:${(app.server.address() as { port: number }).port}`;
  return {
    origin,
    app,
    barrier,
    database,
    migratorPool: options.migratorPool,
    recovery,
    close: async () => {
      barrier.close();
      await app.close().catch(() => undefined);
    },
  };
}

async function resetAndSeed(
  pool: pg.Pool,
  issuer: string,
  caseId: string,
  options: { includeForeignAccount?: boolean } = {},
) {
  await pool.query(
    "truncate device_security_events, device_enrollment_requests, device_enrollments, rebootstrap_sessions, recovery_snapshot_chunks, recovery_snapshots, account_retention_state, cleanup_runs, device_acknowledgements, submissions, sync_events, devices, account_memberships, external_identities, account_cursor_state, accounts cascade",
  );
  for (const id of [
    accountId(caseId),
    ...(options.includeForeignAccount ? [foreignAccountId(caseId)] : []),
  ]) {
    await pool.query("insert into accounts(account_id) values($1)", [id]);
    await pool.query(
      "insert into account_cursor_state(account_id, next_cursor) values($1,1)",
      [id],
    );
  }
  for (const role of ["owner", "member"] as const) {
    await pool.query(
      `insert into external_identities(identity_id, issuer, subject, status)
       values($1,$2,$3,'active')`,
      [identityId(caseId, role), issuer, subjectFor(caseId, role)],
    );
    await pool.query(
      `insert into account_memberships(account_id, identity_id, role, status)
       values($1,$2,$3,'active')`,
      [accountId(caseId), identityId(caseId, role), role],
    );
  }
}

async function enrollDevice(
  origin: string,
  token: string,
  installationId: string,
  enrollmentRequestId: string,
) {
  return post(`${origin}/v1/devices/enroll`, token, {
    contractVersion: 1,
    installationId,
    enrollmentRequestId,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  });
}

async function maybeCreateUpload(
  origin: string,
  token: string,
  deviceId: string,
  caseId: string,
) {
  if (
    [
      "actor-device-revoked-before-download",
      "actor-device-revoked-before-acknowledgement",
      "actor-device-revoked-before-capabilities",
      "actor-device-revoked-before-rebootstrap-start",
      "actor-device-revoked-before-rebootstrap-status",
      "actor-device-revoked-before-rebootstrap-chunk",
      "actor-device-revoked-before-rebootstrap-complete",
    ].includes(caseId)
  ) {
    await post(
      `${origin}/v1/sync/submissions`,
      token,
      uploadBodyFor(caseId, deviceId),
      deviceId,
    );
  }
}

async function prepareRecoveryFixture(
  env: ScenarioEnvironment,
  token: string,
  deviceId: string,
): Promise<RecoveryFixture> {
  const caseId = currentCaseFromDevice(deviceId);
  await seedRecoverySnapshot(env.migratorPool, caseId);
  return {
    sessionId: ids(caseId, "session"),
    snapshotId: ids(caseId, "snapshot"),
    manifestHash: "",
    coveredCursor: encodeCursor(1),
  };
}

async function prepareStartedRecoveryFixture(
  env: ScenarioEnvironment,
  token: string,
  deviceId: string,
): Promise<RecoveryFixture> {
  const fixture = await prepareRecoveryFixture(env, token, deviceId);
  const start = {
    recoverySessionId: fixture.sessionId,
    supportedSnapshotFormats: [1],
  };
  await post(
    `${env.origin}/v1/sync/rebootstrap`,
    token,
    { ...start, requestHash: canonicalHash(start) },
    deviceId,
  );
  fixture.manifestHash = await recoveryManifestHash(
    env.origin,
    token,
    deviceId,
    currentCaseFromDevice(deviceId),
    fixture.sessionId,
  );
  return fixture;
}

async function seedRecoverySnapshot(pool: pg.Pool, caseId: string) {
  const snapshotId = ids(caseId, "snapshot");
  const bytes = Buffer.from("{}", "utf8");
  const hash = canonicalHash({});
  await pool.query(
    `insert into recovery_snapshots(
       account_id, snapshot_id, state, covered_through_cursor,
       captured_high_water_cursor, recovery_format_version,
       compatible_event_version, compatible_schema_version, chunk_count,
       total_bytes, manifest_hash, total_hash, fact_counts, built_at,
       validated_at, published_at
     ) values($1,$2,'available',1,1,1,3,6,1,$3,$4,$4,$5,now(),now(),now())
     on conflict do nothing`,
    [
      accountId(caseId),
      snapshotId,
      bytes.byteLength,
      hash,
      {
        accounts: 1,
        stores: 0,
        products: 0,
        people: 0,
        paymentMethods: 0,
        purchases: 0,
        purchaseItems: 0,
      },
    ],
  );
  await pool.query(
    `insert into recovery_snapshot_chunks(
       account_id, snapshot_id, chunk_index, byte_length, content_hash, chunk_bytes
     ) values($1,$2,0,$3,$4,$5)
     on conflict do nothing`,
    [accountId(caseId), snapshotId, bytes.byteLength, hash, bytes],
  );
}

async function recoveryManifestHash(
  origin: string,
  token: string,
  deviceId: string,
  caseId: string,
  sessionId = ids(caseId, "session"),
) {
  const response = await http(
    "GET",
    `${origin}/v1/sync/rebootstrap/${sessionId}`,
    token,
    deviceId,
  );
  return canonicalHash(response.body.manifest);
}

async function revokeDeviceDirect(
  pool: pg.Pool,
  caseId: string,
  deviceId: string,
) {
  await pool.query(
    "update devices set status='revoked' where account_id=$1 and device_id=$2",
    [accountId(caseId), deviceId],
  );
}

async function seedForeignDevice(pool: pg.Pool, caseId: string) {
  const deviceId = ids(caseId, "foreign-device");
  await pool.query(
    "insert into accounts(account_id) values($1) on conflict do nothing",
    [foreignAccountId(caseId)],
  );
  await pool.query(
    "insert into devices(account_id, device_id, status, next_expected_sequence) values($1,$2,'active',1)",
    [foreignAccountId(caseId), deviceId],
  );
  return deviceId;
}

async function deviceStatus(pool: pg.Pool, caseId: string, deviceId: string) {
  const result = await pool.query(
    "select status from devices where account_id=$1 and device_id=$2",
    [accountId(caseId), deviceId],
  );
  return result.rows[0]?.status as string | undefined;
}

async function securityEventCount(
  pool: pg.Pool,
  caseId: string,
  eventType: string,
) {
  const result = await pool.query(
    "select count(*)::int as count from device_security_events where account_id=$1 and event_type=$2",
    [accountId(caseId), eventType],
  );
  return Number(result.rows[0]?.count ?? 0);
}

async function countRows(pool: pg.Pool, table: string, caseId: string) {
  const result = await pool.query(
    `select count(*)::int as count from ${table} where account_id=$1`,
    [accountId(caseId)],
  );
  return Number(result.rows[0]?.count ?? 0);
}

function scenarioResult(
  caseId: string,
  response: { status: number; body: Record<string, unknown> },
  invariant: boolean,
  values: {
    operation: string;
    route: string;
    participant: string;
    phase?: string;
    before?: AccountStateSnapshot;
    after?: AccountStateSnapshot;
    expectedCode?: string;
    transitionCount?: number;
    eventCount?: number;
  },
): ScenarioResult {
  const code =
    typeof response.body.code === "string" ? response.body.code : undefined;
  const passed =
    invariant &&
    (values.expectedCode
      ? response.status === 403 && code === values.expectedCode
      : response.status < 400);
  return {
    caseId,
    passed,
    blocker: passed ? undefined : "scenario-failed",
    responseStatus: response.status,
    responseCode: code,
    operation: values.operation,
    route: values.route,
    participant: values.participant,
    phase: values.phase,
    stateInvariant: invariant,
    transitionCount: values.transitionCount,
    eventCount: values.eventCount,
    before: values.before ? stableJson(values.before) : undefined,
    after: values.after ? stableJson(values.after) : undefined,
  };
}

function syncStateMatches(
  before: AccountStateSnapshot,
  after: AccountStateSnapshot,
) {
  const trim = (snapshot: AccountStateSnapshot) => ({
    acknowledgements: snapshot.acknowledgements,
    cursorState: snapshot.cursorState,
    recoveryChunks: snapshot.recoveryChunks,
    recoverySessions: snapshot.recoverySessions,
    submissions: snapshot.submissions,
    syncEvents: snapshot.syncEvents,
  });
  return stableJson(trim(before)) === stableJson(trim(after));
}

async function http(
  method: "GET" | "POST",
  url: string,
  token: string,
  deviceId?: string,
  body?: unknown,
  extraHeaders: Record<string, string> = {},
) {
  const response = await fetch(url, {
    method,
    headers: {
      authorization: `Bearer ${token}`,
      "content-type": "application/json",
      ...extraHeaders,
      ...(deviceId ? { "x-markei-device-id": deviceId } : {}),
    },
    ...(method === "POST" ? { body: JSON.stringify(body ?? {}) } : {}),
  });
  return {
    status: response.status,
    body: (await response.json()) as Record<string, unknown>,
  };
}

function proofHeaders(scenario: string, participant: string) {
  return {
    "x-markei-proof-scenario": scenario,
    "x-markei-proof-participant": participant,
  };
}

function enrollmentBody(installationId: string, enrollmentRequestId: string) {
  return {
    contractVersion: 1,
    installationId,
    enrollmentRequestId,
    platform: "test",
    applicationId: "markei.hosted.local",
    applicationVersion: "1.0.0",
  };
}

function uploadBodyFor(caseId: string, deviceId: string) {
  const event = {
    eventId: ids(caseId, "event"),
    accountId: accountId(caseId),
    deviceId,
    deviceSequence: 1,
    eventType: "purchase.registered",
    payloadVersion: 3,
    occurrenceTime: "2026-07-15T00:00:00.000Z",
    payload: {
      purchase: {
        id: ids(caseId, "purchase"),
        store: {
          id: ids(caseId, "store"),
          displayName: "Synthetic",
        },
        items: [],
      },
      productSnapshots: [],
    },
  };
  const eventWithHash = { ...event, contentHash: canonicalHash(event) };
  return {
    submissionId: ids(caseId, "submission"),
    deviceId,
    requestHash: canonicalHash({
      submissionId: ids(caseId, "submission"),
      deviceId,
      events: [eventWithHash],
    }),
    events: [eventWithHash],
  };
}

const caseIndexes = new Map<string, number>();

function caseIndex(caseId: string) {
  if (!caseIndexes.has(caseId)) caseIndexes.set(caseId, caseIndexes.size + 1);
  return caseIndexes.get(caseId)!;
}

function ids(caseId: string, label: string) {
  const index = caseIndex(caseId).toString(16).padStart(4, "0");
  const code = hashCode(label).toString(16).padStart(8, "0").slice(0, 8);
  return `${code.slice(0, 8)}-${index}-4${index.slice(1)}-8${index.slice(1)}-${code}${index}`;
}

function accountId(caseId: string) {
  const index = caseIndex(caseId).toString().padStart(12, "0");
  return `10000000-0000-4000-8000-${index}`;
}

function foreignAccountId(caseId: string) {
  const index = (caseIndex(caseId) + 500).toString().padStart(12, "0");
  return `20000000-0000-4000-8000-${index}`;
}

function identityId(caseId: string, role: "owner" | "member") {
  const index = (caseIndex(caseId) + (role === "owner" ? 1000 : 2000))
    .toString()
    .padStart(12, "0");
  return `30000000-0000-4000-8000-${index}`;
}

function subjectFor(caseId: string, role: "owner" | "member") {
  return `auth0|${caseId}-${role}`;
}

function currentCaseFromDevice(deviceId: string) {
  return (
    deviceCaseIds.get(deviceId) ?? "actor-device-revoked-before-capabilities"
  );
}

function hashCode(value: string) {
  let hash = 0;
  for (const char of value) hash = (hash * 31 + char.charCodeAt(0)) >>> 0;
  return hash;
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

async function postRaw(
  url: string,
  token: string,
  body: unknown,
  deviceId?: string,
  extraHeaders: Record<string, string> = {},
) {
  const response = await fetch(url, {
    method: "POST",
    headers: {
      authorization: `Bearer ${token}`,
      "content-type": "application/json",
      ...extraHeaders,
      ...(deviceId ? { "x-markei-device-id": deviceId } : {}),
    },
    body: JSON.stringify(body),
  });
  return { status: response.status, body: await response.json() };
}

function uploadBody(deviceId: string) {
  const event = {
    eventId: membershipSliceIds.event,
    accountId: membershipSliceIds.account,
    deviceId,
    deviceSequence: 1,
    eventType: "purchase.registered",
    payloadVersion: 3,
    occurrenceTime: "2026-07-15T00:00:00.000Z",
    payload: {
      purchase: {
        id: membershipSliceIds.purchase,
        store: {
          id: membershipSliceIds.store,
          displayName: "Synthetic",
        },
        items: [],
      },
      productSnapshots: [],
    },
  };
  const eventWithHash = { ...event, contentHash: canonicalHash(event) };
  return {
    submissionId: membershipSliceIds.submission,
    deviceId,
    requestHash: canonicalHash({
      submissionId: membershipSliceIds.submission,
      deviceId,
      events: [eventWithHash],
    }),
    events: [eventWithHash],
  };
}
