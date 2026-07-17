# F_DSN_STAGE — R04C01 Design Materialization Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C01_20260717T143908Z
> Controlling reconciliation: 2d85523952a3606ec80a3769817cb4ad8e647cb9
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Selected topology

~~~text
valid upload fixture
→ production Fastify route
→ authorization transaction
↔ participant-aware lab barrier
→ control membership transition
→ typed denial
→ Account snapshot comparison
→ ScenarioResult
~~~

Production depends only on a small inert-by-default interface. Proof infrastructure depends on
production components, never the reverse.

## 2. Barrier contract

The active lab controller belongs in test/proof infrastructure. It needs equivalent operations:

~~~text
reach(phase, context)
waitUntilReached(scenario, participant, phase)
release(scenario, participant, phase)
close()
~~~

Context must distinguish concurrent participants using safe request/scenario identity. Each waiter
has a bounded timeout. Close rejects/releases outstanding waiters and prevents reuse.

The production default remains noop. No HTTP route or environment variable exposes the controller.

## 3. Phase placement

| Phase | Required position |
| --- | --- |
| before-identity-membership-fence | transaction open, before current identity/membership query |
| after-membership-lock | after verified locking query |
| before-actor-device-lock | directly before actor Device locking query |
| before-target-transition | after authorization/locks, before transition write |
| before-protected-mutation | before operation's first durable write |
| before-commit | after writes, before COMMIT, with participant context |

Enrollment currently violates protected-mutation meaning and must be corrected.

The current Database beforeCommit seam must become operation/participant-aware or be replaced by a
transaction-lifecycle interface. Avoid global cross-talk between concurrent operations.

## 4. Membership locking

Verify that resolveOneMembership actually locks the relevant identity/membership rows before
after-membership-lock is emitted. If it does not, use a correct locking query or correct the phase
name/placement. Do not claim a lock that did not occur.

## 5. Observer contract

The observer is test-only and uses a separate committed-view connection. Its snapshot contains
sorted safe representations of:

- submissions/events/high-water;
- acknowledgements;
- recovery sessions/chunks;
- Devices;
- enrollment request/hash/result;
- security events.

It excludes bodies, facts, JWTs and credentials. Comparison accepts an explicit expected membership
transition while requiring all protected state to remain equal.

## 6. Scenario runner

The reusable runner owns:

- scenario/participant keys;
- fixture arrangement;
- before/after snapshots;
- barrier wait/release;
- control transaction;
- response capture;
- cleanup;
- safe ScenarioResult.

It must use explicit ordering, not sleeps. Scenario functions should be callable by focused tests and
later producers.

## 7. Vertical-slice route

Use the real upload route with:

- generated local RS256 identity fixture;
- active Account membership;
- enrolled active Device;
- valid purchase.registered v3 submission;
- disposable PostgreSQL 18;
- loopback Fastify.

Disable membership through a control connection while upload waits before membership resolution.
Expect existing 403 semantics and no protected state advance.

## 8. Producer behavior

After the scenario:

- membership-disabled-before-fence may become true;
- the other unimplemented cases remain false with safe pending blockers;
- denied-no-state-advance remains false;
- authorization-race remains false.

Do not alter schema version or case inventory.

## 9. Resource model

The lab owns PostgreSQL container/database/roles, Fastify/JWKS servers, pools, waiters and temporary
files. Close all in finally and prove empty exact filtered inventory.

## 10. Versions and scope

Retain migrations 001–006, event v3, cursor c10b:*, recovery format 1, enrollment contract v1,
Drift v7, JWT RS256, producer schema v1 and current dependencies.

No provider, migration, dependency, lockfile, Flutter, UI or permanent-memory work is authorized.

## 11. Rollback and report

R04C01 is one bounded commit. Production corrections require a retained failing test. I must report
final dependency direction, exact phase placement, controller lifecycle, observer schema,
representative sequence, resource ownership, retained versions and deviations.
