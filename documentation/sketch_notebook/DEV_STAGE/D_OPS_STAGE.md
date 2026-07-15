# D_OPS_STAGE — C10-S03A-R3C Operational Materialization Authority

> Sequence: FLX-ORD-01
> Branch: `intermid-cycle-recovery`
> Controlling Main reconciliation: `51e1db09e9c00bf2650d1cf791b571cfa4f6a0c6`
> Accepted implementation baseline: `d95d3a2a94935b850f10b9e4b0228ba128b3e728`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: decisive local proof completion

## 1. Objective

Complete the four missing local proof producers without reopening accepted R3B contracts:

```text
authorization/revocation race matrix
+ migration-006 lifecycle and ACL proof
+ real Flutter HTTP/file-backed Drift proof
+ closed multi-producer aggregation
```

Success requires:

```text
R3_LOCAL_SECURITY_PROVED=true
C10-S03A_R3C_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

If any required case is missing, skipped, partial, unavailable, host-unvalidated or false:

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3C_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Name the exact producer/case. Never infer proof from compilation, builds or total test counts.

## 2. Safety and authority boot

Before editing:

1. read root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, then
   `METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL`;
2. read current J and this D/E/F together;
3. fetch and pull `intermid-cycle-recovery` fast-forward-only;
4. confirm the published D/E/F authority is an ancestor of HEAD;
5. inspect status and stop on divergence, conflict or dirty overlap;
6. preserve unrelated and untracked work;
7. never stash, reset, clean, discard, overwrite or force-push.

Never read or modify:

```text
.vscode/settings.json
documentation/NEON_DOC.md
documentation/NEON_SESSION.ps1
secret-bearing provider files
```

No Auth0, Neon, Render, deployment, public endpoint or provider credential use is authorized.

## 3. Accepted contracts are frozen

Retain:

- per-attempt owned Flutter HTTP client and one absolute deadline;
- distinct `device-enrolled` and `duplicate-equivalent` outcomes;
- durable replay conflict/unavailable/unknown outcomes;
- normalized one-refresh JWKS state machine;
- Fastify readiness-time route inventory;
- Device-row active/revoked status projection;
- hosted/fixture/disabled composition and transaction authorizer;
- actor/target policy and scoped repeat revoke;
- migrations 001–006 and Drift schema v7.

R3C is proof-first. Production source may change only when a named decisive test demonstrates a
defect in these contracts. Record the failing case before the correction and retain a regression
test. Stop if correction requires a new architecture, dependency, migration or schema.

## 4. CP1 — Deterministic authorization/race producer

Extend the disposable PostgreSQL/Fastify harness with explicit barriers. Do not use sleeps or
probabilistic timing.

Cover every protected operation class:

```text
upload
download
acknowledgement
capabilities
rebootstrap start
rebootstrap status
rebootstrap chunk
rebootstrap complete
Device status
Device revoke
```

Required cases:

- membership disabled before the transaction authorization fence;
- membership removed before the fence;
- external identity disabled before protected mutation;
- actor Device revoked before each operation class;
- owner status/revoke of same-Account target;
- member status/revoke of self only;
- foreign and cross-Account target denial;
- concurrent target revoke results in one transition and one security event;
- repeat by an independently active authorized actor returns duplicate-equivalent;
- self-revoked actor is denied on later work;
- equivalent concurrent enrollment identities converge;
- conflicting request hash/identity rejects;
- response loss supports query/replay with the same request identity;
- process restart preserves replay meaning;
- bounded serialization/deadlock retry and exhaustion fail closed.

Use named test-only hooks at transaction phases. Hooks must not enter normal hosted composition.

For every denied case capture Account-scoped before/after state:

```text
fact/event count and stable IDs
cursor and acknowledgement positions
rebootstrap sessions and chunk progress
Device rows
enrollment rows
security-event count
```

All must remain unchanged. Avoid logging payload content.

Emit a machine-readable producer record with version, exact required case set and booleans.

## 5. CP2 — Migration-006 lifecycle/ACL producer

Do not edit migrations 001–006 and do not add migration 007.

Run isolated disposable PostgreSQL scenarios:

1. fresh `001→006`;
2. upgrade `001→005`, then 006;
3. duplicate migration runner/ledger attempt;
4. failure rollback using only a disposable copied migration set;
5. canonical migration hashes unchanged before/after;
6. exact migration identity/checksum row;
7. exact no-argument function shape;
8. expected owner, `SECURITY DEFINER`, `STABLE` and fixed search path;
9. qualified ledger lookup and no dynamic SQL;
10. `PUBLIC` execute denied;
11. runtime execute allowed only on `public.markei_hosted_runtime_ready()`;
12. runtime denied on old parameterized probe and direct ledger;
13. migrator/owner expected authority;
14. hostile temporary/public shadow objects cannot change result;
15. absent or tampered ledger state returns false or fails closed;
16. runtime remains unable to perform DDL or role administration.

Failure injection must alter only a temporary copy outside tracked source. Original hashes and a
previous 001–005 database must remain intact.

Emit a closed machine-readable producer record. Tear down all databases, roles and containers.

If canonical migration 006 fails, report the contradiction; do not repair SQL in R3C.

## 6. CP3 — Real Flutter HTTP/file-backed producer

Complete the existing lab-gated proof using:

```text
temporary file-backed Drift v7
→ real HostedIdentityRepository/coordinator
→ real HttpDeviceEnrollmentTransport
→ loopback Fastify routes
→ disposable PostgreSQL where required
```

Seed through real repositories/application workflows where possible:

- one synthetic Account and identity;
- authoritative local Store/Product/Purchase/Item facts;
- one real pending outbox event;
- one durable enrollment request identity/state.

Required cases:

- `device-enrolled` persists and returns applied;
- `duplicate-equivalent` remains distinct;
- conflict persists and leaves facts/outbox unchanged;
- unavailable persists and leaves facts/outbox unchanged;
- malformed/oversized/redirect responses fail closed;
- response loss persists unknown outcome;
- query/replay uses the same request identity;
- close/reopen preserves facts, outbox, identity and result;
- normal response completes before absolute deadline;
- stalled headers time out;
- slow body trickle exceeds the total deadline despite progress;
- owned client/request resources close on timeout;
- borrowed client remains usable after failure;
- late response cannot mutate durable state;
- local registration succeeds while API is unavailable;
- tokens are neither persisted nor logged.

Use deterministic loopback barriers and bounded waits. Fakes and in-memory-only Drift do not satisfy
this producer. Delete temporary files and close clients/databases/servers in `finally` paths.

Emit a closed machine-readable producer record with all required cases.

## 7. CP4 — Truthful aggregator

Create one orchestrator consuming closed producer records for:

```text
authorization-race
migration-006-lifecycle-acl
jwks-state-machine
route-inventory
flutter-http-file-backed
static-regression
```

The accepted R3B JWKS/route/static tests may provide their own machine-readable producers or be
wrapped without duplicating test logic.

Aggregator requirements:

- validate producer name and schema version;
- require the exact exported case set for every producer;
- reject missing, duplicate or unknown producers/cases;
- reject malformed, skipped, partial, unavailable or false results;
- print safe exact blockers;
- never infer truth from process exit alone;
- emit the success diagnostic only when every required boolean is true.

Add aggregator self-tests for all failure modes and the complete-success fixture. The complete
fixture does not replace running real producers.

## 8. Validation floor

Run and record exact commands, environment, counts, results and exclusions:

- server format, lint, typecheck, complete tests and build;
- `npm audit --omit=dev`;
- complete migration producer;
- complete authorization/race producer;
- Dart format, Flutter analysis and complete tests;
- real HTTP/file-backed producer with no lab skip;
- Android debug and Windows release builds when host-supported;
- protected Python regressions;
- final aggregator over real producer outputs;
- `git diff --check`;
- tracked/staged secret scan without reading excluded files;
- disposable-resource teardown verification.

Do not convert a build into runtime acceptance. Host-unvalidated remains explicit.

## 9. Reports

Replace only:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

G must derive baseline/final SHA and changed paths from Git; list every producer/case, database and
HTTP/Drift evidence, counts, teardown, validation and exclusions. H must record semantic meanings,
named tests and privacy/local-first evidence. I must record proof architecture, test-only hooks,
resource ownership, producer schemas, versions and any narrow defect correction.

## 10. File and publication discipline

- Keep production changes minimal and evidence-driven.
- Test/lab helpers may be split by responsibility.
- Do not modify methodology, permanent memory, A/B/C, J, D/E/F, Main-root continuity, migrations,
  dependency/lockfiles or private helpers.
- Do not include unrelated cleanup.
- Review the complete diff and ensure no disposable artifact or secret is tracked.
- Commit one bounded R3C unit and push only `intermid-cycle-recovery` without force.

## 11. Stop conditions

Stop and report partial if:

- a required host/tool cannot run a decisive producer;
- a dependency, migration or Drift schema change is required;
- provider/private data becomes necessary;
- deterministic barriers cannot establish a required race;
- a proof exposes an architectural contradiction beyond a narrow correction;
- any producer/case remains skipped, partial or unavailable.

Do not proceed to provider proof, MCG-03, MCG-04, permanent promotion or Cycle closure.
