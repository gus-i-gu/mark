# D_OPS_STAGE — R04C01 Operational Materialization Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C01_20260717T143908Z
> Controlling reconciliation: 2d85523952a3606ec80a3769817cb4ad8e647cb9
> Required ancestry: fab9357224cd6e4fb532f02e0c1e33f161a4e615
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Objective

Produce one successful reusable authorization-proof vertical slice:

~~~text
working lab barrier controller
+ corrected phase placement
+ canonical Account observer
+ membership-disabled upload denial
~~~

The full authorization producer must remain false.

## 2. Safety and preflight

Confirm branch, fast-forward remote, ancestry and clean/non-overlapping worktree. Preserve private
local files without reading them.

Before mutation prove:

- Docker client/server Linux engine;
- disposable loopback postgres:18-alpine startup;
- pg_isready and SELECT version();
- container removal;
- empty filtered inventory.

Stop without source mutation if preflight fails.

## 3. Correct the existing seam

Retain the production no-op barrier. Correct phase semantics:

- membership phases must surround actual current membership resolution/locking;
- actor Device phase must precede its FOR UPDATE;
- target-transition phase must occur after authorization/locks and before update;
- protected-mutation phase must precede the first durable write;
- before-commit must carry operation/participant context.

In enrollment, move protected-mutation signaling before Device, enrollment, security-event and
request-result writes.

Replace or narrow the context-free Database beforeCommit callback. Do not leave a global hook that
cannot distinguish concurrent operations.

## 4. Lab barrier controller

Add test/proof infrastructure with:

- scenario and participant key;
- waitUntilReached;
- explicit release;
- bounded timeout;
- unknown-phase rejection;
- waiter cleanup and close;
- safe synthetic context only.

No sleeps may determine ordering. No public HTTP route or provider setting may control it. Normal
hosted composition remains inert and gets a containment test.

## 5. Account observer

Add a test-only canonical Account snapshot containing:

- submissions and sync-event identities;
- stream high-water/cursor state;
- acknowledgements;
- recovery session/chunk progress;
- Device state;
- enrollment request identity/hash/result;
- security-event identity/type/subject.

Sort stable identifiers and omit payloads, tokens and credentials. Use a separate committed-view
connection. Support exact comparison with an explicit allowance for the expected membership-status
transition.

## 6. Reusable scenario runner

Implement a bounded flow:

~~~text
arrange
→ capture before
→ start participant
→ wait at phase
→ commit control intervention
→ release
→ capture response
→ capture after
→ compare
→ cleanup
→ ScenarioResult
~~~

The runner must own and close waiters, Fastify, pools, temporary resources and its disposable
PostgreSQL container.

## 7. Representative scenario

Prove membership-disabled-before-fence using a valid upload:

1. seed active external identity, Account membership and Device;
2. construct a valid purchase submission;
3. capture Account state;
4. pause inside the upload transaction before membership resolution;
5. disable membership and commit through a control connection;
6. release upload;
7. require the existing typed 403 authorization result;
8. capture Account state;
9. prove no submission, event, cursor, acknowledgement, recovery, Device or security-event state
   advanced.

The membership status change is expected and excluded explicitly from the unchanged comparison.

Map this executed result to membership-disabled-before-fence. Do not mark the global
denied-no-state-advance case true yet.

## 8. Tests

Required focused tests:

- controller reaches/releases the intended participant;
- controller rejects unknown phase/key;
- timeout and close release resources;
- normal composition uses no-op barrier;
- enrollment phase precedes its first durable write;
- before-commit signal is context-aware;
- observer ordering is canonical;
- observer excludes payload/credential data;
- real Fastify/PostgreSQL representative scenario passes;
- producer remains false for unimplemented cases.

## 9. Validation

Run:

- Docker/PostgreSQL preflight;
- server format, lint, typecheck, full tests and build;
- focused R04C01 tests;
- authorization producer to confirm one new true case and remaining safe blockers;
- npm audit --omit=dev;
- git diff --check;
- tracked/staged secret scan;
- final exact container inventory.

Do not run full Flutter/platform/proof-matrix validation unless shared contracts outside the server
changed. Record any exclusion.

## 10. Change boundary

Expected paths:

- authorization barrier/application transaction seams;
- test/proof controller, observer and scenario support;
- focused tests;
- G/H/I.

No migrations, dependencies, lockfiles, Drift, provider, UI, methodology, permanent memory, A/B/C
or J/D/E/F changes.

Production correction requires a retained failing test and must be narrow.

## 11. Reports

Replace only G/H/I. Include authority marker, start/end times, baseline, exact changed paths, phase
placement, controller lifecycle, observer fields, scenario response/state comparison, tests,
remaining blockers, secret scan and teardown.

## 12. Terminal

Success:

~~~text
R04C01_BARRIER_CONTROLLER=true
R04C01_ACCOUNT_OBSERVER=true
R04C01_MEMBERSHIP_DENIAL_SLICE=true
AUTHORIZATION_RACE_PRODUCER=false
R04_REMAINING_CASES_PENDING
C10-MCG02-R04C01_PROVED
~~~

If any of the three vertical-slice claims fails, report C10-MCG02-R04C01_PARTIAL with exact blockers.
Do not begin R04C02.
