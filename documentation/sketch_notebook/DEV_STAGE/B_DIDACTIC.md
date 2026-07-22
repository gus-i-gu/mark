# B_DIDACTIC — MCG-02 Cursor-State Prerequisite Reconciliation

> Sequence: FLX-PRM-04 domain reconciliation into A/B/C staging
> Role: Didactic Chat
> Branch: `intermid-cycle-recovery`
> Inspected HEAD: `75dc7bed0789d693af93abb3ed15e107fd77433a`
> Authority marker: `C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722`
> Evidence sources: `08_CONCEPT_MAP.md`, `E_DDC_STAGE.md`, `H_DDC_CODEX.md`, current J and bounded materialization evidence
> Writable surface: this file only
> Status: **RECONCILED STAGING — GCM02 OPEN; PERMANENT PROMOTION AND REAL RETRY BLOCKED**

## 1. Recovery and reconciliation boundary

The Didactic domain was recovered through the complete methodology route:

```text
AGENTS → INDEX → sketch_notebook/AGENTS
→ METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
→ didactics/08_CONCEPT_MAP
→ E_DDC_STAGE → H_DDC_CODEX → current J
```

This report reconciles implementation evidence into the Didactic staging surface for the next
check-gathering phase. It does not edit permanent Didactic memory, alter KANBAN status, create a
Lecture Register event, infer learner maturity, authorize Codex, contact providers or authorize a
real Sync/retry. GCM02 remains open.

## 2. Reconciled learning result

The protected-submission incident now teaches two separate lessons which must not be collapsed:

1. **Failure classification was corrected.** An absent Account cursor-state prerequisite no longer
   becomes an opaque unexpected `500`; the locally reproduced path fails closed as a sanitized,
   observed `503 service-unavailable`, with the submission classified `not-applied`.
2. **Prerequisite ownership remains unresolved.** The correction detects the missing
   `account_cursor_state` row safely, but does not establish which lifecycle operation must create or
   repair that row. Deploying the classification correction alone therefore does not establish Sync
   readiness.

The conceptual dependency is:

```text
Account provisioned
→ account_cursor_state exists with valid initial cursor
→ Device enrollment/authorization
→ first protected submission
→ cursor update and event acceptance
```

The first arrow is presently a policy gap. Existing fixtures and disposable harnesses seed the row;
the hosted human baseline contained one Account and one Device but zero Account cursor-state rows.

## 3. PRC-01 classification record

| Claim | State | Semantic destination | Evidence and boundary | Reconciliation action |
| --- | --- | --- | --- | --- |
| Missing `account_cursor_state` locally reproduced the protected-submission crash | validated | Didactic staging candidate and later derived/checkpoint relationship | Synthetic regression and disposable PostgreSQL evidence at `75dc7be`; no provider internals inspected | accept within local evidence boundary |
| The historical hosted `500` is consistent with the reproduced missing-row path | accepted diagnosis | checkpoint-oriented explanation | Correlated request shape plus sanitized hosted counts; consistency is not direct provider-internal proof | preserve qualified wording |
| Missing-row handling now yields `service-unavailable`, HTTP `503`, `not-applied` | implemented and validated | terminology/concept relationship candidate | API and Flutter tests; local/disposable scope | stage for later permanent reconciliation |
| Unexpected failure logging no longer reports `request-failed` with status `200` | implemented and validated | observational support for bounded diagnostic vocabulary | Structured lifecycle tests | stage as evidence, not a separate learner concept |
| A client deadline and a server response are separate observation boundaries | accepted relationship | terminology/concept dependency candidate | Historical client saw no response before 1000 ms; Render later recorded final `500`; new tests preserve observed `503` | retain without rewriting history |
| The existing hosted cursor-state prerequisite has been repaired | rejected | none | Last sanitized hosted count was zero | keep explicit blocker |
| Account provisioning canonically owns cursor initialization | proposed, unresolved | next-phase design/didactic investigation | Suggested lifecycle order only; no accepted ownership decision | request evidence and decision |
| Enrollment canonically owns cursor initialization | proposed, unresolved | next-phase design/didactic investigation | Possible alternative; current evidence does not select it | request evidence and decision |
| A one-time repair is sufficient as the durable lifecycle rule | rejected as unproved | none yet | Repair may restore one environment but would not define fresh-Account behavior | prevent workaround/canon confusion |
| Deploying `75dc7be` alone makes Sync succeed | rejected | none | It safely converts the same prerequisite failure to `503` | keep retry blocked |
| Learner maturity changed | rejected | canonical KANBAN unchanged | No direct learner explanation, prediction, comparison or transfer evidence | do not edit maturity |
| GCM02 is closed | rejected | none | Cursor initialization and post-correction hosted proof remain absent | retain open terminal |

No canonical concept identity or KANBAN numbering is changed by this staging pass.

## 4. Terminology and concept candidates

### 4.1 Prerequisite row

A prerequisite row is relational state that must already exist before a later operation can update or
depend on it. Its absence is not automatically a transient outage: it can expose a lifecycle or
provisioning invariant that was never materialized.

Candidate relationship:

```text
schema permits row
!= lifecycle creates row
!= runtime can safely assume row exists
```

### 4.2 Fail-closed missing prerequisite

When required coordination state is absent, the protected operation must stop without applying the
submission, expose only a bounded sanitized classification, and preserve retry evidence. A safe
failure is not the same as a repaired prerequisite.

### 4.3 Observed service failure versus unknown outcome

- `service-unavailable`: a trustworthy protocol response was observed. In the reproduced missing-row
  case, the operation is `not-applied` and the evidence must be preserved.
- `unknownOutcome`: transport did not provide a trustworthy protocol response before classification;
  possible application cannot be inferred away, so exact request identity is preserved.
- historical `sync-interrupted` / `transport-or-closure`: remains the client-observed historical
  record and is not retroactively rewritten by later server evidence.

The distinction depends on what the observer can prove, not merely on which component eventually
logged an error.

### 4.4 Deadline as an observation boundary

A client deadline limits how long the client waits for evidence. It does not by itself prove that the
server was not reached, that the server stopped, or that no transaction committed. Conversely, an
observed bounded server response may justify a known `not-applied` classification when the server
contract and transaction evidence support it.

### 4.5 Initialization ownership

Initialization ownership names the lifecycle operation responsible for establishing a required row
exactly once and keeping its invariant valid. The owner must be selected together with transaction,
idempotency, concurrency, RLS and least-privilege behavior; it cannot be inferred merely because a
fixture inserts the row.

Candidate dependency order:

```text
Account lifecycle
→ cursor-state initialization owner
→ idempotent/concurrent creation proof
→ enrollment compatibility
→ first-submission proof
→ hosted check gathering
```

## 5. Evidence boundaries

Accepted evidence for this staging pass:

- locally reproduced zero-row cursor update followed by the former unsafe dereference;
- failing-before/passing-after protected-submission regression;
- bounded `service-unavailable` / HTTP `503` / `not-applied` mapping;
- Flutter preservation of an observed service failure response;
- correction of the misleading intermediate successful log status;
- API 51-test pass and Flutter 178-test pass with four lab-gated skips;
- disposable convergence/recovery harness evidence;
- Windows release and Android debug builds;
- unchanged migrations 001–006 and no timeout extension;
- sanitized hosted baseline showing Account 1, Device 1 and zero cursor/submission/event/
  acknowledgement rows before this local correction.

This evidence does not establish:

- that the historical provider `500` exposed its internal exception directly;
- that the corrected commit is deployed;
- that the hosted cursor row now exists;
- which operation canonically owns fresh or repair initialization;
- provider-backed first-submission success;
- exact-identity retry success;
- production readiness, GCM02 closure or Cycle 10 closure;
- any learner maturity transition.

## 6. Misconceptions to prevent

- Correct classification is not correction of the underlying data prerequisite.
- HTTP `503` does not mean “unknown outcome” when the response is observed and the server proves the
  submission was not applied.
- A client timeout does not prove that Render was never reached.
- A later Render result does not retroactively change what the historical client observed.
- A schema or migration defining `account_cursor_state` does not prove that every Account receives a
  row.
- A fixture that seeds coordination state does not identify the production lifecycle owner.
- Enrollment success does not by itself prove all Account-scoped synchronization prerequisites exist.
- A one-time database repair is not a substitute for an idempotent fresh-Account lifecycle rule.
- A safe `503` is not hosted synchronization success.
- Passing local/disposable tests does not authorize a real provider retry.
- Implementation evidence does not manufacture learner maturity.

## 7. Questions for the next check-gathering phase

1. Which operation creates the Account itself, and what atomic work is performed in that same
   transaction?
2. Is `account_cursor_state(next_cursor = 1)` an Account invariant, an enrollment prerequisite, or a
   lazily created synchronization coordination record?
3. Must initialization occur at Account provisioning, at first enrollment, or at first protected
   Sync? What failure and recovery semantics follow from each option?
4. How are existing Accounts missing the row repaired without duplicating cursor allocation or
   weakening RLS?
5. Can two concurrent enrollment/first-submission attempts initialize the row idempotently?
6. Which identity is permitted to initialize it: migrator, provisioning service, or least-privilege
   runtime transaction under Account context?
7. Does row creation roll back atomically when the owning lifecycle operation fails?
8. How will tests distinguish fresh Account creation, legacy missing-row repair, duplicate request,
   concurrency and foreign-Account denial?
9. What sanitized evidence proves the row exists before one exact-identity hosted retry is authorized?
10. Does post-deployment Closure observe the bounded `503` correctly if the prerequisite is still
    missing, without changing the preserved unknown events?

## 8. Staging recommendations

For Main synthesis and the next D/E/F unit:

- require an explicit architectural decision naming the cursor-state initialization owner;
- require fresh-Account and existing-missing-Account paths to be defined separately;
- preserve `next_cursor = 1` and cursor monotonicity as tested invariants;
- require idempotent and concurrent initialization tests;
- require transaction rollback, RLS, cross-Account denial and least-privilege probes;
- retain the bounded `service-unavailable` fallback even after initialization is implemented;
- do not alter the client deadline merely to hide server lifecycle defects;
- do not update permanent Didactic memory until Main accepts the ownership model and evidence;
- do not authorize provider mutation or a real retry until deployment, harmless correlation, fresh
  sanitized counts and cursor-row presence are separately evidenced.

Recommended Didactic candidates after that evidence exists:

```text
prerequisite row
initialization ownership
safe failure versus repaired invariant
observer-relative outcome classification
deadline as evidence boundary
fixture seeding versus production lifecycle
```

## 9. Current Didactic terminal

```text
C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED
C10_MCG02_CURSOR_STATE_PREREQUISITE_UNRESOLVED
GCM02_OPEN
LEARNER_MATURITY_UNCHANGED
REAL_RETRY_NOT_AUTHORIZED
```
