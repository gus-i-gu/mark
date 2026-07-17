# F_DSN_STAGE — C10-MCG02-R04B Design Materialization Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04B_20260717T133814Z
> Staged at UTC: 2026-07-17T13:38:14Z
> Staged at America/Sao_Paulo: 2026-07-17T10:38:14-03:00
> Controlling reconciliation: 0765255c07e3381f74cd9b4e90bc2f9ddd3b13dc
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Selected topology

~~~text
synthetic identity/Account/Device fixtures
        ↓
loopback Fastify route
        ↓
production authorization application service
        ↓
PostgreSQL transaction fence
        ↕
lab-only deterministic barrier
        ↓
protected mutation or denial
        ↓
Account-scoped observer
        ↓
ScenarioResult
        ↓
closed authorization producer
        ↓
R04B aggregate
~~~

Production modules must not depend on proof modules.

## 2. Environment boundary

Docker/PostgreSQL availability is a prerequisite, not an implementation responsibility.

The preflight owns one disposable loopback PostgreSQL 18 container and must prove start, readiness,
query, removal and empty inventory before source edits.

Host configuration remains human-owned.

## 3. Barrier port

Use a small application/lab seam equivalent to:

~~~text
AuthorizationBarrier.reach(phase, context)
~~~

Production default is immediate no-op.

Lab implementation:

- signals phase reached;
- waits for explicit release;
- supports bounded participants;
- rejects unknown phases;
- times out safely;
- releases in finally;
- carries only safe synthetic identifiers.

Normal hosted composition must construct only the inert implementation. Prove containment through a
composition or structural test.

## 4. Barrier phases

Allowed phases:

- before identity/membership fence;
- after membership lock;
- before actor Device lock;
- before target transition;
- before protected mutation;
- before commit.

Use the narrowest phase for the scenario. Do not expose barriers through HTTP or provider
configuration.

## 5. Transaction fence order

Equivalent required order:

1. verify authenticated external identity input;
2. begin transaction;
3. lock/recheck external identity active;
4. lock/recheck Account membership and role;
5. lock/recheck actor Device Account/identity/active state;
6. validate target authorization;
7. perform protected mutation;
8. emit required security event;
9. commit.

The barrier observes ordering without weakening the fence.

## 6. State observer

The test-only observer returns one canonical Account snapshot with:

- event/fact stable identities and stream high-water;
- acknowledgements;
- recovery session and verified-chunk state;
- Device state;
- enrollment identity/hash/result;
- security-event identity/type/subject.

It excludes payloads and credentials.

Use a separate connection for committed-view observation. Support exact unchanged, one-transition,
one-event and duplicate-equivalent comparisons.

## 7. Scenario architecture

Prefer one reusable scenario runner:

~~~text
arrange valid fixture
→ capture before
→ reach barrier
→ commit control transition
→ release
→ capture response
→ capture after
→ assert case invariant
→ return ScenarioResult
~~~

Focused tests and producer execution should call the same scenario functions where practical.

Do not parse Node test-runner output.

## 8. Route scenarios

Use real loopback HTTP for actor-Device route denials.

Recovery routes require a compatible available snapshot and Device-bound session/chunk state so the
response tests authorization rather than recovery availability.

Direct service calls may supplement but cannot replace the route proof.

## 9. Target transition

Target revoke remains one atomic operation:

~~~text
lock target Device
→ authorize actor
→ active-to-revoked transition if active
→ insert one security event
→ return transition or duplicate-equivalent truth
~~~

Concurrent operations may serialize but cannot create two transition events.

## 10. Enrollment concurrency

Use existing contract version 1, request identity and canonical request hash.

Equivalent concurrent requests converge on one durable result. A different hash under the same
request identity fails closed and preserves the original.

Do not add a new enrollment protocol or merge unrelated installations.

## 11. Response loss and restart

Inject response loss after transaction commit at the lab transport boundary.

Restart topology:

~~~text
first composition commits
→ delivery suppressed
→ first composition closes
→ second composition opens the same database
→ same identity query/replay
→ equivalent result
~~~

No first-process cache may be required.

## 12. Serialization exhaustion

Exercise the existing bounded retry wrapper with deterministic conflict injection.

Do not:

- raise retry limits merely to pass;
- use an unbounded loop;
- substitute a pre-transaction generic exception;
- retain partial state between attempts.

## 13. Producer architecture

Retain:

- producer schema version 1;
- exact 28 authorization case IDs;
- makeProducerResult-derived blockers;
- fail-closed parsing and aggregation.

Preferred flow:

~~~text
scenario
→ ScenarioResult
→ exact case map
→ makeProducerResult
→ emitProducer
~~~

The producer owns Fastify, pools, barriers, temporary files and container cleanup in finally.

## 14. Aggregation

R04B orchestration accepts only:

- migration, JWKS, route, static and authorization producers true;
- Flutter valid and false only for not-yet-r05;
- global aggregate false only because Flutter remains deferred;
- proof-pipeline integrity true.

Missing/malformed output, infrastructure failure or unexpected blocker fails R04B.

## 15. Versions retained

- migrations 001–006;
- event payload v3;
- cursor c10b:*;
- recovery format 1;
- hosted enrollment contract v1;
- Drift v7;
- JWT RS256;
- producer schema v1;
- current dependencies/lockfiles.

No version increment is selected.

## 16. Security and resources

- loopback and synthetic fixtures only;
- generated local signing keys only;
- no provider/private helper access;
- no secret/fact logging;
- least-privilege disposable database roles;
- barriers absent from public composition;
- close every server, pool, waiter, file and container in finally;
- require empty exact filtered inventory.

## 17. Change boundary

Expected changes:

- hosted lab/scenario support;
- barrier and observer test seams;
- proof producer/orchestration;
- focused tests;
- G/H/I.

Production correction requires a retained failing scenario and must preserve existing contracts and
versions.

Rollback is one bounded R04B commit. Migrations remain unchanged.

## 18. Stop conditions

Stop if completion needs:

- provider behavior/credentials;
- host Docker reconfiguration;
- new dependency or lockfile edit;
- migration 007 or migration rewrite;
- Drift v8;
- public debug/barrier controls;
- authorization/enrollment/JWT redesign;
- full Flutter R05 work;
- UI, deployment, MCG-03 or MCG-04.

## 19. Required I evidence

I records:

- dependency direction;
- environment preflight;
- barrier interface/phases/containment;
- transaction fence ordering;
- observer scope;
- concurrency/replay/restart/retry mechanisms;
- producer/aggregate truth;
- resource ownership;
- retained versions;
- every production deviation;
- R05/provider deferrals.
