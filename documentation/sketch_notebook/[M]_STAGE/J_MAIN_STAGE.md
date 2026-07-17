# J_MAIN_STAGE — Cycle 10 MCG-02 R04 Partial Reconciliation

> Sequence: FLX-ORD-01
> Reconciliation marker: C10-MCG02-R04B_20260717T133814Z
> Staged at UTC: 2026-07-17T13:38:14Z
> Staged at America/Sao_Paulo: 2026-07-17T10:38:14-03:00
> Reconciled implementation: 42e4a8375ed8c51765b0a440b2130a31a098c36c
> Controlling R04 authority: cb177621db82cde6be6d658c58daef590e5b9548
> Prior reconciliation: fd73da6fddf3cc308655c41e0640b045d710d983
> Status: **R04 PARTIAL ACCEPTED; R04B CONTINUATION SELECTED**
> Active next unit: **C10-MCG02-R04B — Authorization Lab Completion**

## 1. Methodology retained

Main retains:

- J reconciles cross-domain evidence and selects the next unit.
- D/E/F jointly provide Codex materialization authority.
- G/H/I are observational reports and cannot promote themselves.
- Git owns ancestry, final commit identity and exact changed paths.
- implementation, local validation, provider acceptance and production readiness remain distinct;
- a named proof case passes only when its exact scenario executed;
- environmental inability is not product failure or proof success;
- partial work must remain fail-closed.

No permanent project memory is promoted by this staging operation.

## 2. Temporal and Git reconciliation

The R04 implementation began from:

~~~text
cb177621db82cde6be6d658c58daef590e5b9548
~~~

Git proves one direct implementation commit:

~~~text
cb17762
→ 42e4a8375ed8c51765b0a440b2130a31a098c36c
~~~

Commit time:

~~~text
2026-07-17T10:34:13-03:00
~~~

G/H/I correctly carry the authority and implementation start/end markers, but report:

~~~text
Final commit SHA: pending before commit
No commit was created
~~~

Those statements were true at report-authoring time and are now superseded by Git. The final
materialized commit is 42e4a83. This is report chronology drift, not source contradiction.

## 3. Exact R04 delta

Twelve paths changed:

- G/H/I;
- hosted_local_harness.ts;
- authorization_producer.ts;
- flutter_producer.ts;
- jwks_producer.ts;
- r3d1_orchestrator.ts;
- static_regression_producer.ts;
- new static_regression_support.ts;
- hosted_auth.test.ts;
- proof_aggregate.test.ts.

No migration, dependency, lockfile, Drift schema, UI, provider configuration, methodology,
permanent memory, A/B/C, J or D/E/F path changed.

The commit passes Git diff whitespace validation.

## 4. Accepted R04 progress

The following narrow corrections are accepted as implemented:

### 4.1 Teardown meaning

The static teardown predicate now requires:

~~~text
exit code = 0
AND trimmed resource inventory is empty
~~~

A focused regression proves that successful non-empty output fails.

### 4.2 JWKS metadata meaning

The metadata-only JWKS scenario now:

- installs an unknown-kid cooldown;
- changes only irrelevant provider metadata;
- retries the same unknown kid;
- proves fetch count does not advance.

The matching focused server test passed. Production JWKS internals remain opaque.

### 4.3 Flutter evidence correction

token-not-persisted-or-logged is returned to false with blocker not-yet-r05. The current focused
Flutter suite is no longer used to overclaim that meaning.

### 4.4 Fail-closed wrappers

The authorization wrapper reports true only when the parsed authorization producer record passes.
The orchestration rule now requires authorization true, Flutter false only for R05 blockers and the
global aggregate false.

These are accepted as implemented orchestration changes. The R04 orchestrator itself did not run.

### 4.5 Focused validation

Reported local evidence:

- npm typecheck passed;
- 36 server tests passed;
- format initially found two touched files, then passed after formatting;
- lint passed;
- corrected JWKS producer passed;
- Flutter producer emitted the expected structurally valid false record.

## 5. R04 success conflict

R04 is not successful.

The authorization producer stopped before PostgreSQL startup because the Docker Desktop Linux engine
was unavailable. Therefore:

- none of the 28 R04 authorization scenarios executed;
- no authorization before/after state snapshot exists;
- no deterministic barrier evidence exists;
- no concurrency, replay, restart or retry-exhaustion count exists;
- final disposable-resource inventory could not be queried;
- migration, route, static and R04 aggregate producers did not run in this round;
- broad Flutter and repository validation did not run after the blocker.

The correct terminal classification remains:

~~~text
C10-MCG02-R04_PARTIAL
AUTHORIZATION_RACE_PRODUCER=false
R3_LOCAL_SECURITY_PROVED=false
~~~

## 6. Source-inspection conflict

The Docker failure is not the only remaining gate.

Direct source inspection shows:

- no authorization barrier port or phase controller was added;
- no Account-scoped state observer was added;
- transaction fence ordering was not instrumented for deterministic races;
- the hosted harness still emits true for only four previously observed cases:
  - owner-target-revoke;
  - foreign-target-denial;
  - cross-account-target-denial;
  - conflicting-enrollment-request-hash;
- every other declared authorization case still receives not-yet-r04.

Consequently, merely restarting Docker and rerunning the current producer cannot complete R04.
R04B must first materialize the missing scenario architecture and then run it with PostgreSQL
available.

## 7. Accepted versus pending classification

Accepted locally:

~~~text
R04_EVIDENCE_CORRECTIONS_IMPLEMENTED=true
JWKS_METADATA_COOLDOWN_FOCUSED_TEST=true
TEARDOWN_EMPTY_INVENTORY_FOCUSED_TEST=true
FLUTTER_LOGGING_OVERCLAIM_REMOVED=true
AUTHORIZATION_WRAPPER_FAILS_CLOSED=true
~~~

Not validated in this round:

~~~text
AUTHORIZATION_RACE_PRODUCER=false
R04_AUTHORIZATION_MATRIX=false
R3_LOCAL_SECURITY_PROVED=false
MCG-02_PROVIDER_PROOF_PENDING
~~~

## 8. R04B selected objective

R04B completes the same authorization unit. It is not a new feature round and does not advance to
R05.

Required result:

~~~text
deterministic barriers
+ Account-scoped state observer
+ 28 executed authorization scenarios
+ corrected producer set
+ R04 fail-closed aggregate
~~~

## 9. Environmental preflight

Before any R04B source mutation, Codex must prove:

1. Docker client can reach the Linux engine;
2. postgres:18-alpine can start on loopback;
3. pg_isready succeeds;
4. the disposable container can be removed;
5. final filtered inventory is empty.

If preflight fails, stop without another implementation commit and report:

~~~text
C10-MCG02-R04B_ENVIRONMENT_BLOCKED
AUTHORIZATION_RACE_PRODUCER=false
~~~

The human may start or repair Docker Desktop, but Codex must not change host configuration.

## 10. Required R04B architecture

R04B must add lab-only:

- explicit transaction barriers;
- a canonical Account state observer;
- valid route fixtures for every protected operation;
- deterministic concurrent identity, membership and Device transitions;
- response-loss injection after server commit;
- new-process/application replay over persisted PostgreSQL;
- controlled serialization retry exhaustion;
- exact case-to-scenario production.

No sleep may determine race ordering.

Production source may change only after a preserved failing scenario proves a direct contract defect.

## 11. Authorization matrix retained

All 28 schema-version-1 authorization cases remain required. They cover:

- identity and membership fences;
- actor Device revocation before every protected route;
- owner/member/foreign/cross-Account target rules;
- concurrent and repeated revocation;
- equivalent and conflicting enrollment;
- response-loss and restart replay;
- serialization exhaustion;
- denied-no-state-advance.

The four previously observed cases must be re-expressed through the same case-addressable R04B
scenario system; prior broad harness success alone is insufficient for the final producer.

## 12. R04B aggregation

R04B acceptance requires:

- migration producer true;
- corrected JWKS producer true;
- route producer true;
- corrected static producer true;
- authorization producer true for all exact cases;
- Flutter producer valid and false only for not-yet-r05;
- proof-pipeline integrity true;
- global R3 local security false.

Unexpected missing, malformed, skipped, partial or unavailable evidence fails R04B.

## 13. Exclusions

R04B does not authorize:

- Auth0, Neon, Render or public provider access;
- private provider helper access;
- dependency or lockfile changes;
- migration 007 or edits to migrations 001–006;
- Drift v8;
- full Flutter R05 work;
- UI or Cycle 11 work;
- MCG-03, MCG-04, deployment, permanent promotion or Cycle 10 closure.

## 14. Terminal contract

On complete R04B proof:

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

Otherwise report the exact environmental or scenario blockers and keep R04 open.

## 15. Cycle 10 forward boundary

After R04B reconciliation:

1. R05 completes Flutter HTTP/file-backed proof and final local aggregation.
2. Human/provider MCG-02 proves Auth0, Neon and Render integration.
3. Domain promotion records accepted Cycle 10 evidence.
4. Main closes Cycle 10 only when local and provider gates are reconciled.

R05 is not active until R04B succeeds and Main reconciles its G/H/I.
