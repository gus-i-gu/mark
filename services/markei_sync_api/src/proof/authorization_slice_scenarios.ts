import Fastify from "fastify";
import pg from "pg";
import { exportJWK, generateKeyPair, SignJWT } from "jose";
import { canonicalHash } from "../domain/protocol.js";
import { buildApp } from "../http/app.js";
import { Auth0JwtVerifier } from "../application/jwt_verifier.js";
import {
  HostedIdentityService,
  HostedTransactionAuthorizer,
} from "../application/hosted_authorization.js";
import { systemClock } from "../application/hosted_contracts.js";
import type { Database } from "../postgres/database.js";
import {
  observeAccountState,
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
