# D_OPS_STAGE — C10-MCG02-R04B Operational Materialization Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04B_20260717T133814Z
> Staged at UTC: 2026-07-17T13:38:14Z
> Staged at America/Sao_Paulo: 2026-07-17T10:38:14-03:00
> Controlling reconciliation: 0765255c07e3381f74cd9b4e90bc2f9ddd3b13dc
> Required implementation ancestry: 42e4a8375ed8c51765b0a440b2130a31a098c36c
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Unit: R04 authorization lab completion

## 1. Objective

Complete the still-open R04 authorization proof:

~~~text
Docker/PostgreSQL preflight
→ deterministic authorization barriers
→ Account-scoped state observer
→ 28 executed scenarios
→ authorization producer true
→ R04 aggregate with Flutter still deferred
~~~

R04B is continuation, not R05 and not provider proof.

## 2. Repository safety

Before work:

1. confirm branch intermid-cycle-recovery;
2. fetch and fast-forward only;
3. confirm 0765255 and 42e4a83 are ancestors of HEAD;
4. inspect staged, unstaged and untracked files;
5. preserve unrelated work and private local helper files;
6. stop on divergence, conflict or dirty overlap.

Do not stash, reset, clean, discard or force-push. Do not read provider/private helper files.

## 3. Gate 0 — Environment before mutation

Run before editing source:

- docker version;
- start postgres:18-alpine on a loopback-only disposable port;
- wait for pg_isready;
- execute a trivial SELECT version();
- remove the container;
- query the exact filtered inventory and require empty stdout.

If this gate fails:

- make no source/report commit;
- do not repeat the earlier evidence corrections;
- report C10-MCG02-R04B_ENVIRONMENT_BLOCKED with the redacted command failure;
- stop.

Codex must not install, reconfigure or start Docker Desktop through host mutation. The human owns
host availability.

## 4. Accepted baseline

Preserve the corrections at 42e4a83:

- teardown means exit zero plus empty inventory;
- JWKS metadata case proves preserved cooldown/fetch behavior;
- Flutter token logging stays false/not-yet-r05;
- authorization wrapper accepts only a passed record;
- R04 orchestration requires authorization true.

Do not reopen these corrections unless a focused regression fails.

## 5. CP1 — Barrier infrastructure

Add a lab-only deterministic barrier controller supporting:

- before identity/membership fence;
- after membership lock;
- before actor Device lock;
- before target transition;
- before protected mutation;
- before commit.

It must:

- signal phase reached;
- await explicit release;
- reject unknown phases;
- time out safely;
- release waiters in finally;
- use no credentials or fact payloads;
- be unreachable from public routes and normal hosted composition.

No sleep may determine transaction ordering.

## 6. CP2 — Account state observer

Add a test-only canonical observer for one Account covering:

- authoritative fact/event identities;
- stream high-water/cursors;
- Device acknowledgements;
- recovery sessions and verified chunk progress;
- Device state;
- enrollment request identity/hash/result;
- security-event identity/type/subject.

Use stable sorted identifiers and safe counts/hashes. Exclude JWTs, claims, credentials and payloads.
Use a separate committed-view connection where concurrency requires it.

Support:

- exact unchanged assertion;
- one transition/one event assertion;
- duplicate-equivalent assertion;
- no-state-advance assertion.

## 7. CP3 — Exact case inventory

Execute every existing schema-version-1 authorization case:

1. membership-disabled-before-fence;
2. membership-removed-before-fence;
3. external-identity-disabled-before-mutation;
4. actor-device-revoked-before-upload;
5. actor-device-revoked-before-download;
6. actor-device-revoked-before-acknowledgement;
7. actor-device-revoked-before-capabilities;
8. actor-device-revoked-before-rebootstrap-start;
9. actor-device-revoked-before-rebootstrap-status;
10. actor-device-revoked-before-rebootstrap-chunk;
11. actor-device-revoked-before-rebootstrap-complete;
12. actor-device-revoked-before-device-status;
13. actor-device-revoked-before-device-revoke;
14. owner-target-status;
15. owner-target-revoke;
16. member-self-status;
17. member-self-revoke;
18. foreign-target-denial;
19. cross-account-target-denial;
20. concurrent-target-revoke-one-transition-one-event;
21. independent-repeat-revoke-duplicate-equivalent;
22. self-revoked-actor-denied-later;
23. equivalent-concurrent-enrollment;
24. conflicting-enrollment-request-hash;
25. response-loss-query-replay;
26. process-restart-replay;
27. serialization-retry-exhaustion-fails-closed;
28. denied-no-state-advance.

The four old broad-harness observations must be executed through the same case-addressable scenario
system. Do not set them true by inheritance.

## 8. CP4 — Route validity

Actor-revocation cases must invoke the real loopback Fastify route with:

- valid JWT fixture;
- active identity and membership before the race;
- active actor Device;
- valid request body/cursor;
- valid snapshot/session/chunk state for recovery routes.

Then pause, commit the authority change from a control connection, release and require the existing
typed authorization denial.

A malformed, unavailable, missing-fixture or wrong-route response does not satisfy a case.

## 9. CP5 — Target, concurrency and replay

Prove:

- owner may inspect/revoke an Account Device;
- ordinary member may inspect/revoke only their own Device;
- foreign and cross-Account targets fail without disclosure;
- concurrent revoke produces one transition and one security event;
- equivalent later revoke is duplicate-equivalent;
- self-revoked actor cannot perform later protected work;
- equivalent enrollment concurrency converges;
- conflicting request hash preserves the first truth;
- response loss occurs after commit and same-identity replay recovers it;
- restart replay uses a new app composition over persisted PostgreSQL;
- serialization retry exhaustion is bounded and produces no state.

## 10. CP6 — Producer and aggregation

Each case must be generated from its executed ScenarioResult. Do not parse test-runner prose or use a
broad command exit as case evidence.

R04B acceptance requires:

- migration-006-lifecycle-acl true;
- jwks-state-machine true;
- route-inventory true;
- static-regression true;
- authorization-race true for all 28 cases;
- Flutter valid and false only for not-yet-r05;
- proof-pipeline integrity true;
- global R3 local security false.

Rename the orchestrator file only if needed for clarity; preserve one authoritative entrypoint.

## 11. Production correction rule

R04B is proof-first. Production code may change only when:

1. a case first fails against the current implementation;
2. the failing scenario remains;
3. the correction is narrow and version-preserving;
4. G/I identify the deviation.

Do not redesign production architecture for test convenience.

## 12. Validation

Record exact commands, counts and exclusions:

- format, lint, typecheck, full server tests and build;
- all focused barrier/observer/scenario tests;
- all six proof producers;
- R04B orchestrator;
- production dependency audit;
- Flutter format, analysis, full tests and supported builds;
- protected Python regressions;
- migration 001–006 hash comparison;
- git diff --check;
- tracked/staged secret scan;
- final exact disposable-resource inventory.

Expected partial Flutter exit must be distinguished from failure.

## 13. Scope exclusions

Do not:

- contact Auth0, Neon, Render or public services;
- read provider credentials/private helpers;
- add dependencies or edit lockfiles;
- add migration 007 or edit 001–006;
- add Drift v8;
- implement R05 Flutter cases;
- modify UI, methodology, permanent memory, A/B/C or J/D/E/F;
- begin MCG-03, MCG-04, deployment or Cycle 10 closure.

## 14. Reports and temporal evidence

Replace only G/H/I.

Every report header must include:

- authority marker C10-MCG02-R04B_20260717T133814Z;
- controlling J and D/E/F commit SHAs;
- baseline remote SHA;
- actual UTC/local start and end;
- implementation tree SHA before commit;
- final commit status resolved by Git/Main;
- evidence environment and result.

G must report all 28 cases, response classes, state comparisons, transition/event/retry counts,
commands, resource inventory and exact changed paths.

## 15. Terminal contract

On success:

~~~text
PROOF_PIPELINE_INTEGRITY=true
MIGRATION_006_LIFECYCLE_ACL=true
JWKS_STATE_MACHINE_PRODUCER=true
ROUTE_INVENTORY_PRODUCER=true
STATIC_REGRESSION_PRODUCER=true
AUTHORIZATION_RACE_PRODUCER=true
FLUTTER_HTTP_FILE_BACKED_PRODUCER=false
R3_LOCAL_SECURITY_PROVED=false
C10-MCG02-R04_AUTHORIZATION_PROVED
R05_FLUTTER_PENDING
MCG-02_PROVIDER_PROOF_PENDING
~~~

Otherwise report R04B environment-blocked or partial with exact false cases. Do not advance to R05.
