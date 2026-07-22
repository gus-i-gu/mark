# A_OPERATIONAL — Protected Submission Cursor-State Reconciliation

> Sequence: FLX-PRM-04 domain reconciliation staging
> Role: Operational Chat [O]
> Branch: `intermid-cycle-recovery`
> Inspected HEAD: `75dc7bed0789d693af93abb3ed15e107fd77433a`
> Controlling stage commit: `22261751f2ef86a4a494a7748886d27211044fc0`
> Runtime observability ancestor: `5b364216375514f9e43bd58c265fbabf8000c2f8`
> Evidence date: 2026-07-22
> Status: **STAGED RECONCILIATION ONLY; LOCAL CAUSE CORRECTED; HOSTED PREREQUISITE UNRESOLVED; GCM02 OPEN**

## 1. Scope and authority boundary

This report reconciles the Operational meaning of D, G, current J and implementation evidence after
`C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722`. It is a complete functional stage for Main's next
synthesis. It does not promote or edit permanent Operational memory and is not direct Codex authority.

The current permanent Operational checkpoint and TODO are stale relative to this sequence: they still
describe an earlier C10-S03A corrective stop and provider-preparation boundary. That drift is recorded
here rather than corrected while GCM02 remains open.

No source, permanent domain file, D/E/F/G/H/I/J, provider, credential, local human database or Git state
was modified through this reconciliation. Existing uncommitted J work was preserved.

## 2. Verified lineage and achievements

Verified repository lineage:

```text
5b364216  Implement transport observability diagnostics
  -> 22261751  Stage submission 500 diagnosis
  -> 75dc7bed  Diagnose protected submission cursor-state failure
```

Accepted bounded achievements:

- the non-mutating Windows Closure health check correlated `/health/live` and `/health/ready` with
  fingerprint `500a78db`; both returned HTTP 200;
- the controlled exact-identity retry reached `POST /v1/sync/submissions`; Render correlated it as
  `46e9a131`, returned final HTTP 500 in under one second, and the client timed out without observing
  response headers at its 1000 ms boundary;
- the post-attempt sanitized provider counts stayed Account 1, Device 1, and zero cursor-state,
  submissions, Sync events and acknowledgements; no hosted commit or duplication was evidenced;
- local synthetic reproduction proved that a valid Account/Device without `account_cursor_state`
  caused a zero-row cursor update followed by an unsafe missing-row dereference;
- `75dc7be` now fails that condition closed as `service-unavailable`, `upload-submission`,
  `not-applied`, mapped to HTTP 503;
- the server lifecycle no longer reports a misleading successful status on unexpected request failure;
- Flutter preserves an observed `service-unavailable` result distinctly from timeout/unknown outcome;
- migrations 001–006 were unchanged, the client deadline was not extended, and no provider or human
  synchronization state was accessed by Codex.

## 3. PRC-01 classification records

### OPR-01 — Missing cursor state caused the reproducible protected-route crash

```text
Claim: An absent account_cursor_state row for a valid Account/Device reproduces the protected submission 500.
Source: G_OPS_CODEX, protocol regression and 75dc7be implementation diff.
Current state: validated.
Evidence: failing-before/passing-after synthetic protected-submission regression.
Evidence boundary: disposable local fixtures; provider internals were not inspected.
Contradictions: none in current implementation evidence.
Semantic owner: Operational execution evidence; Design owns lifecycle responsibility.
Target role: Main synthesis and later permanent Operational record/checkpoint.
History disposition: preserve the provider 500 and local reproduction as distinct observations.
Confidence: high locally; medium-high correlation to the provider failure shape.
Human/Main authority: Main accepted the bounded diagnosis in current J.
Required regeneration: Operational record, TODO and checkpoint after GCM02 closure permits promotion.
Result: accept as locally validated; do not describe it as provider-internal proof.
```

### OPR-02 — Missing-row handling is corrected safely

```text
Claim: 75dc7be converts the missing cursor-state path from an unhandled 500 to a non-applied HTTP 503.
Source: G_OPS_CODEX and source diff.
Current state: implemented and locally validated.
Evidence: focused and complete API tests plus Flutter transport/classification tests.
Evidence boundary: repository/local disposable environments; not deployed after correction.
Contradictions: none.
Semantic owner: Operational model for execution semantics; Design for mapping boundaries.
Target role: Main synthesis and later permanent domain reconciliation.
History disposition: retain the prior 500 and anomalous status-200 lifecycle event historically.
Confidence: high.
Human/Main authority: current J accepts only the stated local correction.
Required regeneration: Operational checkpoint after provider follow-up evidence.
Result: accept locally; hosted success remains unproved.
```

### OPR-03 — Hosted cursor-state prerequisite remains unresolved

```text
Claim: The required hosted account_cursor_state row is absent and no canonical initialization owner is established.
Source: sanitized Neon baseline, G residual risk and current J.
Current state: blocked / further investigation required.
Evidence: provider count for account_cursor_state was zero; fixtures explicitly seed it; protected enrollment visibly creates Device/enrollment state without establishing the Account cursor row.
Evidence boundary: last sanitized provider snapshot and inspected current call path; no new provider query or mutation.
Contradictions: local success harnesses contain pre-seeded cursor state and therefore do not prove provisioning.
Semantic owner: Design must decide lifecycle responsibility; Operational must define repair/deployment proof.
Target role: next A/B/C synthesis and bounded D/E/F stage.
History disposition: preserve as the active GCM02 blocker.
Confidence: high that the row was absent; initialization ownership is unresolved.
Human/Main authority: current J explicitly blocks provider retry.
Required regeneration: new implementation evidence and later provider gate evidence.
Result: no promotion to readiness; stage a bounded initialization/repair investigation.
```

### OPR-04 — GCM02 and real Sync remain open

```text
Claim: GCM02 is not closed and another real Sync/retry is not authorized.
Source: current J, G residual risks and unchanged provider counts.
Current state: blocked.
Evidence: no post-correction deployment, no proved cursor row and no successful protected submission.
Evidence boundary: current repository and last sanitized provider evidence.
Contradictions: none.
Semantic owner: Main global gate; Operational records execution blockers.
Target role: Main synthesis.
History disposition: append later closure evidence; do not rewrite the earlier unknown outcomes.
Confidence: high.
Human/Main authority: explicit current stop.
Required regeneration: Main J append and permanent checkpoint only after later authorized proof.
Result: preserve stop.
```

## 4. Validation ledger

Accepted at commit `75dc7be` within the reported host/environment boundaries:

| Check | Result | Boundary |
| --- | --- | --- |
| Pre-fix focused regression | Failed as expected with HTTP 500 | Demonstrates the reproduced defect |
| Post-fix focused and protected-route API tests | Passed; 51 total | Synthetic/local API behavior |
| API format, lint, typecheck and build | Passed | Project source/toolchain |
| Flutter focused transport test | 2 passed | Observed service-unavailable mapping |
| Flutter analysis and complete suite | Passed; 178 tests, 4 lab-gated skips | Existing Drift warnings retained |
| Disposable convergence harness | 3 passed | Explicitly enabled local PostgreSQL/HTTP lab |
| Disposable recovery harness | 1 passed | Explicitly enabled local recovery lab |
| Python release configuration | 5 passed with `unittest` | `pytest` unavailable; not a product failure |
| Android debug build | Passed | Build evidence, not device/release acceptance |
| Windows release build | Passed | Build evidence, not post-deployment hosted proof |
| `git diff --check` | Passed | Line-ending warnings only |

Existing Kotlin/Gradle and Boost/CMake warnings remain non-blocking observations. None of the checks
prove that the hosted prerequisite exists or that protected Sync now succeeds.

## 5. Unresolved operational questions

1. Which trusted server-side lifecycle owns exactly-once creation of
   `account_cursor_state(account_id, next_cursor = 1)`: Account provisioning, enrollment, or a separate
   controlled repair/bootstrap operation?
2. How is an already provisioned Account with a missing row repaired without allowing a distributed
   client to manufacture Account-wide coordination state?
3. Must initialization occur in the same transaction as Account creation, and what deployment-order
   compatibility is required for existing Accounts?
4. What runtime/migrator identity may perform initialization under current RLS and least-privilege
   grants, and can it do so without broadening ordinary Sync authority?
5. How are idempotent and concurrent initializers proved to yield exactly one row and preserve
   `next_cursor = 1` until the first accepted event?
6. What rollback/restart evidence proves that partial enrollment/provisioning cannot leave ambiguous
   Account/Device/cursor state?
7. Does the existing hosted Account require one explicit administrative repair before deployment, or
   can a corrected trusted provisioning path reconcile it safely and observably?

These questions require Design ownership plus Operational proof planning. They must not be answered by
silently inserting the row from the protected submission route.

## 6. Required next evidence plan

### Phase A — Read-only ownership and path inventory

- trace Account creation/provisioning, membership creation, Device enrollment and first submission;
- inventory every code/test/migration location that seeds or assumes `account_cursor_state`;
- identify current table ownership, grants, RLS policies and transaction boundaries from migrations
  001–006;
- classify whether the gap is application provisioning, migration/backfill, deployment procedure or a
  combination; do not infer schema change merely because a row is absent.

### Phase B — Main-approved local correction proof

After new D/E/F authority only, require deterministic disposable tests for:

- fresh Account receives exactly one cursor-state row at the selected lifecycle boundary;
- an existing valid Account missing cursor state is repaired through the explicitly authorized path;
- repeated and concurrent initialization is idempotent and yields no duplicate cursor allocation;
- failure rolls back Account/membership/Device/cursor changes coherently;
- runtime and migrator permissions remain least-privilege and RLS remains fail-closed;
- a first protected submission advances cursor state once, and identical retry remains safe;
- cross-Account, unauthorized Device and ordinary distributed-client attempts cannot initialize or
  repair Account coordination state;
- fresh and upgrade migration/deployment paths pass if an additive migration is justified;
- all existing API, Flutter, convergence, recovery and platform-build checks remain green.

The local terminal must distinguish `cursor lifecycle corrected` from `provider repaired`.

### Phase C — Deferred provider verification

Only after local materialization, G/H/I reconciliation and new Main authorization:

1. deploy the bounded server/client correction in the approved order;
2. run one harmless live/ready fingerprint correlation;
3. obtain sanitized counts and prove the expected cursor row exists before Sync;
4. verify no unexpected submission/event/acknowledgement rows appeared;
5. authorize at most one exact-identity unresolved retry;
6. correlate Closure, Render lifecycle and post-attempt Neon counts without exposing secrets or raw
   identifiers.

No part of Phase C is authorized by this A stage.

## 7. Risks and stop conditions

- **Incorrect ownership:** lazy creation in `acceptSubmission` could let an ordinary protected request
  conceal incomplete provisioning and mix repair with business mutation.
- **Duplicate allocation:** non-atomic or non-idempotent initialization can violate Account-wide cursor
  monotonicity under concurrency.
- **Privilege expansion:** solving the row gap by granting runtime broad insert/DDL authority would
  weaken the established least-privilege boundary.
- **False closure:** deploying `75dc7be` alone should yield a classified 503 while the row remains absent;
  it does not make Sync ready.
- **Historical erasure:** the client-observed `provider-evidence-unavailable`, server-observed 500 and
  unchanged database snapshot are complementary observations and must all remain recorded.
- **Human data risk:** events 1–2 must not be deleted, resequenced, replaced, locally edited or retried
  outside a later exact authorization.

Stop on unclear lifecycle ownership, migration edits to 001–006, privilege broadening, nondeterministic
concurrency tests, provider dependency during local proof, secret exposure, dirty overlap, or any test
that reports success when its decisive producer was skipped.

## 8. Recommended Main stage

Main should synthesize A/B/C into one bounded investigation/materialization unit provisionally named:

```text
C10-MCG02-CURSOR-STATE-LIFECYCLE-CORRECTION
```

Its order should be:

```text
inventory ownership and current assumptions
  -> decide trusted initialization and existing-Account repair boundary
  -> create failing deterministic regressions
  -> materialize the smallest correction
  -> validate fresh, missing-row, concurrent, rollback, ACL/RLS and first-submission paths
  -> replace G/H/I
  -> reconcile before any deployment
```

Current Operational terminals:

```text
C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED
C10_MCG02_CURSOR_STATE_PREREQUISITE_UNRESOLVED
GCM02_NOT_CLOSED
REAL_SYNC_AND_RETRY_NOT_AUTHORIZED
```
