# J_MAIN_STAGE — Protected Submission Cursor-State Reconciliation

> Sequence: FLX-ORD-01 post-materialization reconciliation
> Authority marker: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722
> Materialization commit: `75dc7bed0789d693af93abb3ed15e107fd77433a`
> Status: **LOCAL CAUSE CORRECTED; HOSTED CURSOR-STATE PREREQUISITE UNRESOLVED; REAL SYNC BLOCKED**

## 1. Reconciled result

Codex reproduced the protected-submission failure locally with synthetic identity and disposable
database fixtures. The proved project-owned cause was an absent `account_cursor_state` row for an
otherwise valid Account/Device. `acceptSubmission` updated zero cursor rows and then dereferenced the
missing returned row, producing the provider-observed HTTP `500` before any synchronization fact was
committed.

Commit `75dc7be` materialized a bounded fail-closed correction:

- a zero-row cursor update returns `service-unavailable`, `upload-submission`, `not-applied`;
- hosted protocol failures are mapped through the existing HTTP result mapper;
- `service-unavailable` maps to HTTP `503` and remains distinct in Flutter;
- Closure treats the observed response as Sync unavailable rather than an unknown transport outcome;
- unexpected server exceptions no longer emit `request-failed` with a misleading successful status;
- no client deadline extension or database migration was introduced.

The correction makes the failure safe, classified and observable. It does not initialize or repair the
missing hosted cursor-state row.

## 2. PRC-01 classification

| Claim | Classification and boundary |
| --- | --- |
| Missing Account cursor state locally reproduces the protected `500` | Validated with synthetic regression evidence |
| The historical provider failure is consistent with that reproduced path | Accepted diagnosis by correlated shape; provider internals were not inspected |
| Zero-row cursor handling is corrected | Implemented and locally validated at `75dc7be` |
| Misleading `request-failed status 200` is corrected | Implemented and locally validated |
| Flutter preserves an observed `service-unavailable` result | Implemented and locally validated |
| The historical client timeout should be rewritten | Rejected; preserve client-observed history |
| The hosted cursor-state prerequisite now exists | Rejected; last sanitized Neon baseline showed zero rows |
| Deploying `75dc7be` alone will make Sync succeed | Rejected; the same missing prerequisite should yield bounded HTTP `503` |
| MCG-02 or provider Sync is closed | Rejected; no post-correction hosted proof exists |
| Events 1–2 may be replaced, resequenced or retried now | Rejected |

## 3. Validation accepted

Accepted local evidence reported in G/H/I:

- failing-before/passing-after protected-submission regression;
- API format, lint, typecheck, build and all 51 tests passed;
- Flutter formatting and analysis passed;
- Flutter suite passed: 178 tests with four lab-gated skips;
- disposable convergence and recovery harnesses passed when explicitly enabled;
- Windows release and Android debug builds passed;
- protected Python release-configuration regressions passed through `unittest`;
- migrations 001–006 remained unchanged;
- no provider, credential, human database or human unresolved submission was accessed.

`pytest` itself was unavailable, but the owned five-test Python module passed with the standard-library
runner. Existing Drift, Kotlin and Boost/CMake warnings remain non-blocking observational evidence.

## 4. Preserved boundary

The following remain unchanged:

- local events 1–2 remain `Unknown` with their exact identities and ordering;
- next local Device sequence remains 3;
- last provider baseline remains Account 1, Device 1 and zero cursor/submission/event/acknowledgement rows;
- no hosted commit or duplication is evidenced;
- JWT/JWKS, enrollment authorization, RLS, runtime/migrator separation and migrations 001–006 are preserved;
- real Sync, unresolved retry, re-enrollment, local-data mutation and provider-data mutation remain blocked.

## 5. Reconciliation consequence

The materialization terminal is accepted only in its stated sense:

```text
C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED
```

This is not a hosted-readiness terminal. Before another provider retry, Main must resolve the missing
cursor-state lifecycle:

```text
Account creation/provisioning
  -> account_cursor_state(account_id, next_cursor = 1)
  -> enrollment and protected authorization
  -> first exact-identity submission
```

Current source fixtures and harnesses explicitly seed the cursor row, while the protected enrollment
path creates Device/enrollment records without visibly owning Account cursor initialization. The human
provider baseline therefore exposes a provisioning-policy gap, not merely a transient request error.

## 6. Next authorized sequence

1. Run FLX-PRM-04 in Operational, Didactic and Design chats so G/H/I are absorbed into their permanent
   domain memory and checkpoints.
2. Main reconciles those domain updates and stages one bounded cursor-state initialization/repair unit.
3. That unit must decide and test the canonical owner of cursor initialization, including fresh Account,
   existing Account missing state, concurrency, idempotency, transaction, RLS and least-privilege behavior.
4. Only after local materialization and reconciliation may `75dc7be` plus the cursor-state correction be
   deployed to Render.
5. After deployment: run one harmless health correlation and obtain a fresh sanitized Neon baseline.
6. Authorize at most one exact-identity retry only if the cursor-state row is proved present and all
   other counts remain consistent.

Until a new D/E/F authority marker exists, no further implementation or provider mutation is authorized.

```text
C10_MCG02_CURSOR_STATE_PREREQUISITE_UNRESOLVED
```

---

## Append-only reconciliation entry — 2026-07-22 — A/B/C cursor-state lifecycle staging

> Sequence: FLX-PRM-04 functional reconciliation → Main synthesis
> Inspected HEAD: `75dc7bed0789d693af93abb3ed15e107fd77433a`
> Inputs: `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`
> Persistence boundary: staging only; permanent domain files intentionally unchanged while GCM02 remains open
> Status: **A/B/C COMPLETE; NEXT CHECK-GATHERING UNIT IDENTIFIED; NO MATERIALIZATION OR PROVIDER AUTHORITY YET**

### Achievements and repository track record retained

The functional reconciliation accepts the following bounded lineage and achievements:

```text
5b364216  transport observability diagnostics
  -> 22261751  protected-submission 500 diagnosis staging
  -> 75dc7bed  missing cursor-state reproduction and fail-closed correction
```

- Windows Closure correlated `/health/live` and `/health/ready` under fingerprint `500a78db`; both
  returned HTTP 200.
- One previously authorized exact-identity retry reached `POST /v1/sync/submissions` under Render
  fingerprint `46e9a131`; Render returned final HTTP 500 while Closure crossed its 1000 ms observation
  boundary without response headers.
- The post-attempt provider snapshot remained Account 1, Device 1, and zero cursor-state,
  submissions, Sync events and acknowledgements; no hosted commit or duplication was evidenced.
- Local synthetic reproduction proved the missing `account_cursor_state` row caused a zero-row update
  followed by the unsafe failure.
- `75dc7be` converts that path to sanitized HTTP 503 `service-unavailable` / `not-applied`, fixes the
  misleading successful status on `request-failed`, and preserves timeout/unknown-outcome semantics.
- API format, lint, typecheck, build and 51 tests passed; Flutter formatting, analysis and 178 tests
  passed with four gated skips; disposable convergence and recovery harnesses passed; Windows release
  and Android debug builds passed; five protected Python checks passed through `unittest`.
- Migrations 001–006, provider state, credentials, human local data and events 1–2 were not modified.

These are implementation and validation claims within their stated local/build boundaries. They do
not prove that the correction is deployed, that cursor state exists in the hosted environment, that
protected Sync succeeds, or that GCM02 is closed.

### Cross-domain reconciliation

Operational stages a three-part evidence route: read-only ownership inventory, Main-authorized local
correction proof, and only later a separately authorized provider verification. It requires fresh and
existing-Account cases, idempotency, concurrency, rollback, first-submission behavior, RLS and
least-privilege evidence.

Didactic preserves the distinctions:

```text
schema permits a row
!= lifecycle creates the row
!= runtime may safely assume the row exists

observed 503 not-applied
!= timeout/no trustworthy response
!= successful Sync
```

No KANBAN maturity or learner status changes are inferred from implementation evidence.

Design provisionally recommends the responsibility boundary:

```text
Account provisioning owns atomic Account + account_cursor_state initialization
Enrollment consumes/verifies the provisioned Account
Sync advances existing cursor state or fails closed
Existing incomplete Accounts use a controlled forward-only repair path
```

Main accepts this as the preferred direction for the next investigation, not yet as permanent canon or
implementation authority. Enrollment repair, first-Sync lazy initialization, re-enrollment, ad hoc
provider SQL and edits to migrations 001–006 remain rejected.

### Provisional physical candidates and unresolved decision

The next unit must inspect and prove the narrowest enforcement mechanism before Main freezes it:

1. preferred candidate: additive post-006 migration with database-enforced future Account
   initialization plus idempotent existing-Account backfill;
2. enforcement alternative: a narrowly owned Account-insert trigger;
3. acceptable only if comprehensively exclusive: a provisioning procedure with all direct Account
   inserts revoked or removed.

Repair must preserve existing cursor rows and derive a missing row's `next_cursor` from the Account's
immutable hosted high-water (`max(server_cursor) + 1`, or 1 when no events exist). The next unit must
prove locking, concurrency, rollback, safe ownership/search path, ACL/RLS, runtime denial, fresh and
upgrade paths, and first-submission monotonicity. These are staged design requirements, not authority
to create migration 007 yet.

### Next staging boundary

The next provisional unit name is:

```text
C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR
```

Before D/E/F become active, Main must use the A/B/C evidence to freeze:

1. trigger-backed invariant versus exclusive provisioning procedure;
2. additive migration identity/checksum policy after 006, if the inventory confirms migration need;
3. high-water repair query and lock/transaction strategy;
4. exact producer matrix and ACL/RLS/object-shadowing probes;
5. separation between local materialization, later deployment, provider repair verification, and the
   still-later exact-identity retry gate.

### Active stop and continuation gate

No permanent Operational, Didactic or Design files are edited by this reconciliation. No D/E/F unit is
activated in this entry. No deployment, migration application, Neon mutation, Auth0/Render change,
enrollment, ordinary Sync or unresolved-submission retry is authorized.

```text
A_B_C_RECONCILIATION_COMPLETE
C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED
C10_MCG02_CURSOR_STATE_PREREQUISITE_UNRESOLVED
C10_MCG02_ACCOUNT_CURSOR_PROVISIONING_REPAIR_PROVISIONAL
GCM02_OPEN
REAL_SYNC_RETRY_UNAUTHORIZED
```
