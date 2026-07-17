import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";
import { noopAuthorizationBarrier } from "../src/application/authorization_barrier.js";
import { inTransactionWithContext } from "../src/postgres/database.js";
import {
  protectedStateMatchesExceptMembership,
  stableJson,
  type AccountStateSnapshot,
} from "../src/proof/account_state_observer.js";
import { AuthorizationBarrierController } from "../src/proof/authorization_barrier_controller.js";
import { makeProducerResult } from "../src/proof/producer.js";

test("R04C01 controller reaches and releases the intended participant", async () => {
  const controller = new AuthorizationBarrierController(
    [
      {
        scenario: "membership-disabled-before-fence",
        participant: "upload",
        phase: "before-identity-membership-fence",
      },
    ],
    1000,
  );
  const reached = controller.waitUntilReached(
    "membership-disabled-before-fence",
    "upload",
    "before-identity-membership-fence",
  );
  const paused = controller.reach("before-identity-membership-fence", {
    operation: "upload-submission",
    scenario: "membership-disabled-before-fence",
    participant: "upload",
  });
  assert.equal((await reached).operation, "upload-submission");
  controller.release(
    "membership-disabled-before-fence",
    "upload",
    "before-identity-membership-fence",
  );
  await paused;
  controller.close();
});

test("R04C01 controller rejects unknown phase and participant keys", async () => {
  const controller = new AuthorizationBarrierController([], 1000);
  assert.throws(
    () =>
      controller.release(
        "unknown",
        "upload",
        "before-identity-membership-fence",
      ),
    /unknown authorization barrier participant/,
  );
  await assert.rejects(
    controller.reach("not-a-phase" as never, {
      operation: "upload-submission",
      scenario: "membership-disabled-before-fence",
      participant: "upload",
    }),
    /unknown authorization barrier phase/,
  );
  controller.close();
});

test("R04C01 controller times out and close rejects waiters", async () => {
  const timeoutController = new AuthorizationBarrierController(
    [
      {
        scenario: "membership-disabled-before-fence",
        participant: "upload",
        phase: "before-identity-membership-fence",
      },
    ],
    10,
  );
  await assert.rejects(
    timeoutController.waitUntilReached(
      "membership-disabled-before-fence",
      "upload",
      "before-identity-membership-fence",
    ),
    /barrier-reach-timeout-before-identity-membership-fence/,
  );
  timeoutController.close();

  const closeController = new AuthorizationBarrierController(
    [
      {
        scenario: "membership-disabled-before-fence",
        participant: "upload",
        phase: "before-identity-membership-fence",
      },
    ],
    1000,
  );
  const waiter = closeController.waitUntilReached(
    "membership-disabled-before-fence",
    "upload",
    "before-identity-membership-fence",
  );
  closeController.close();
  await assert.rejects(waiter, /authorization barrier controller closed/);
  assert.throws(
    () =>
      closeController.release(
        "membership-disabled-before-fence",
        "upload",
        "before-identity-membership-fence",
      ),
    /authorization barrier controller closed/,
  );
});

test("normal hosted composition remains no-op for authorization barriers", async () => {
  await noopAuthorizationBarrier.reach("before-commit", {
    operation: "upload-submission",
    scenario: "membership-disabled-before-fence",
    participant: "upload",
  });
});

test("R04C01 enrollment protected-mutation signal precedes first durable write", () => {
  const source = readFileSync(
    "src/application/hosted_authorization.ts",
    "utf8",
  );
  const mutation = source.indexOf('"before-protected-mutation"');
  const firstDeviceWrite = source.indexOf("insert into devices");
  assert.ok(mutation > 0);
  assert.ok(firstDeviceWrite > 0);
  assert.ok(mutation < firstDeviceWrite);
});

test("R04C01 before-commit hook receives operation and participant context", async () => {
  const contexts: unknown[] = [];
  const client = {
    query: async () => ({ rows: [], rowCount: 0 }),
    release: () => undefined,
  };
  const database = {
    pool: { connect: async () => client },
    beforeCommit: async (context: unknown) => {
      contexts.push(context);
    },
  };
  await inTransactionWithContext(
    database as never,
    {
      operation: "upload-submission",
      scenario: "membership-disabled-before-fence",
      participant: "upload",
    },
    async () => "ok",
  );
  assert.deepEqual(contexts, [
    {
      operation: "upload-submission",
      scenario: "membership-disabled-before-fence",
      participant: "upload",
    },
  ]);
});

test("R04C01 observer comparison is canonical and excludes payload data", () => {
  const before = snapshot({
    memberships: [{ status: "active", identity_id: "b" }],
    syncEvents: [
      { event_id: "2", event_type: "purchase.registered" },
      { event_id: "1", event_type: "purchase.registered" },
    ],
  });
  const after = snapshot({
    memberships: [{ status: "disabled", identity_id: "b" }],
    syncEvents: [
      { event_type: "purchase.registered", event_id: "1" },
      { event_type: "purchase.registered", event_id: "2" },
    ],
  });
  assert.equal(protectedStateMatchesExceptMembership(before, after), true);
  const serialized = stableJson(after);
  assert.equal(serialized.includes("payload"), false);
  assert.equal(serialized.includes("credential"), false);
});

test("R04C01 producer marks only the measured case true and remains false", () => {
  const producer = makeProducerResult(
    "authorization-race",
    { "membership-disabled-before-fence": true },
    "pending-r04c",
  );
  assert.equal(
    producer.resultsByCase["membership-disabled-before-fence"].passed,
    true,
  );
  assert.equal(producer.resultsByCase["denied-no-state-advance"].passed, false);
  assert.equal(producer.passed, false);
});

function snapshot(
  values: Partial<AccountStateSnapshot> = {},
): AccountStateSnapshot {
  return {
    memberships: [],
    submissions: [],
    syncEvents: [],
    cursorState: [],
    acknowledgements: [],
    recoverySessions: [],
    recoveryChunks: [],
    devices: [],
    enrollmentRequests: [],
    securityEvents: [],
    ...values,
  };
}
