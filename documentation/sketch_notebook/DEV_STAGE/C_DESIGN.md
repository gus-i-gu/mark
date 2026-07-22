# C_DESIGN — Account Cursor-State Lifecycle Reconciliation

> Sequence: FLX-PRM-04 / PRC-01 domain reconciliation
> Role: Design/Architecture [D]
> Branch / inspected HEAD: `intermid-cycle-recovery` / `75dc7bed0789d693af93abb3ed15e107fd77433a`
> Source authority: `F_DSN_STAGE.md`, `I_DSN_CODEX.md`, current Design checkpoint and post-materialization J
> Authority: Design staging and Main handoff only
> Writable surface: `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> Status: **PROVISIONAL DESIGN RECOMMENDATION — GCM02 OPEN; NO IMPLEMENTATION, PROVIDER MUTATION OR RETRY AUTHORITY**

## 1. Reconciliation result

The protected submission failure is architecturally localized. An otherwise authorized Account and
Device reached `acceptSubmission`, but the Account had no `account_cursor_state` row. The previous
implementation assumed that row existed after a zero-row update and threw before inserting a hosted
event or Submission. Commit `75dc7be` now converts that missing prerequisite into a bounded
`service-unavailable` / HTTP `503` / `not-applied` result and corrects misleading terminal logging.

That correction is accepted only as safe failure classification. It does not establish the missing
row, hosted readiness, provider convergence, GCM02 closure, or permission to retry events 1–2.

The unresolved architecture question is the lifecycle owner of the one-to-one state:

```text
Account
  -> exactly one account_cursor_state
  -> zero or more memberships
  -> zero or more enrolled Devices
  -> zero or more synchronized Events
```

Design recommends that **Account provisioning owns creation of `account_cursor_state` in the same
database transaction that creates the Account**. Enrollment consumes an already provisioned Account;
Sync consumes and advances its cursor. Neither may become an implicit repair path.

## 2. PRC-01 classification records

### 2.1 Missing cursor state caused the protected-submission failure

```text
Claim: Missing account_cursor_state caused the reproduced protected-submission failure.
Source: I_DSN_CODEX; commit 75dc7be regression; post-materialization J.
Current state: validated locally; accepted diagnosis within the correlated provider evidence boundary.
Evidence: failing-before/passing-after synthetic route regression; provider final 500; zero hosted Sync rows.
Evidence boundary: local disposable fixtures plus sanitized provider shape; provider internals were not inspected.
Contradictions: none; historical client observation remains provider-evidence-unavailable at its deadline.
Semantic owner: Design for responsibility boundary; Operational for execution evidence.
Target role: Design staging now; permanent promotion deferred by human instruction.
History disposition: preserve the historical 500 and client timeout; do not rewrite them as 503.
Confidence: high for the local cause; bounded for exact provider internals.
Human/Main authority: reconciliation requested; permanent files expressly blocked until GCM02 closure.
Required regeneration: Main J append-only synthesis and later Design permanent memory after closure authority.
Result: accepted staging claim; no provider or retry authority.
```

### 2.2 Zero-row handling is corrected

```text
Claim: Missing cursor state now returns service-unavailable / 503 / not-applied without hosted fact insertion.
Source: I_DSN_CODEX; implementation diff at 75dc7be; named API and Flutter tests.
Current state: implemented and locally validated.
Evidence: 51 API tests; 178 Flutter tests with four gated skips; platform builds and local harnesses passed.
Evidence boundary: local and build evidence only; corrected commit is not provider-deployed or hosted-proved.
Contradictions: deployment alone would still fail while the provider row remains absent.
Semantic owner: Design error/transaction boundary; Operational validation record.
Target role: staging; later Architecture/Decision Log/Design State if authorized.
History disposition: append correction after the former defect; do not erase it.
Confidence: high locally.
Human/Main authority: no permanent promotion or deployment authorized here.
Required regeneration: post-deployment evidence only after cursor lifecycle materialization and reconciliation.
Result: accepted bounded correction; hosted prerequisite unresolved.
```

### 2.3 Account provisioning owns cursor initialization

```text
Claim: Account provisioning must atomically establish account_cursor_state before membership/enrollment/Sync.
Source: schema dependency, runtime grants, hosted flow inspection, fixtures that seed both rows, current failure.
Current state: proposed Design decision.
Evidence: accounts are prerequisite parents; runtime cannot create Accounts after migration 002; enrollment
  requires an existing membership/Account and currently creates only Device/enrollment state.
Evidence boundary: repository architecture; no canonical production Account-provisioning implementation exists yet.
Contradictions: current provider Account exists without its cursor row, proving the provisioning invariant was not enforced.
Semantic owner: Design canonical architecture.
Target role: Main decision and a new D/E/F materialization boundary.
History disposition: preserve the provider gap as evidence motivating the decision.
Confidence: high for ownership; physical enforcement choice remains provisional.
Human/Main authority: required before implementation.
Required regeneration: Architecture, Decision Log, Model Overview and Design State only after accepted materialization.
Result: recommended; not yet canonical or implemented.
```

### 2.4 Existing Accounts require controlled repair

```text
Claim: Existing Accounts missing cursor state require one forward-only, transactionally validated repair.
Source: sanitized Neon baseline (Account 1, Device 1, cursor state 0, no Sync facts); migrations 001-006.
Current state: proposed and blocked pending Main authority.
Evidence: provider prerequisite is absent; migrations 001-006 are immutable history.
Evidence boundary: sanitized counts only; no provider mutation or exhaustive account scan was performed here.
Contradictions: none; ad hoc enrollment or first-Sync repair would conflict with lifecycle ownership.
Semantic owner: Design repair boundary; Operational owns execution/check procedure.
Target role: new D/E/F and Codex materialization, then provider gate.
History disposition: additive migration/repair evidence; never edit 001-006 or rewrite the earlier ledger.
Confidence: high that repair is needed; exact data-set scope requires safe provider evidence.
Human/Main authority: required before source or provider changes.
Required regeneration: new G/H/I and Main reconciliation before deployment.
Result: recommended controlled repair; provider action remains unauthorized.
```

## 3. Canonical responsibility recommendation

### 3.1 Account provisioning

Account provisioning owns the aggregate bootstrap transaction:

```text
BEGIN
  create Account
  create account_cursor_state(next_cursor = 1)
  create initial identity/membership when that workflow owns it
COMMIT
```

The Account and cursor-state pair is one synchronization aggregate prerequisite. A successfully
provisioned Account must never be externally visible without its cursor row. `next_cursor = 1`
means no hosted Event has yet received a server cursor.

Because no production Account-provisioning service is presently established, the next unit should
make the invariant enforceable at the database boundary rather than depending on dashboard/manual
discipline. The provisional preferred physical design is an additive migration after 006 that:

1. installs a narrowly owned Account-initialization mechanism for future Account insertion;
2. backfills missing cursor rows for existing Accounts;
3. leaves existing cursor rows unchanged;
4. records its own forward-only migration identity transactionally.

A database trigger attached to Account insertion is the preferred enforcement candidate because all
provisioning paths then receive the same atomic invariant. An explicit provisioning procedure is a
valid alternative only if direct Account insertion is revoked from every other path and all current
fixtures/provider setup are migrated to that procedure. Main must freeze the physical choice after
Codex proves its privilege and upgrade behavior.

### 3.2 Enrollment

Enrollment owns identity-to-installation-to-Device binding. It may verify that the Account aggregate
is provisioned and return a bounded unavailable result if not, but it must not insert cursor state.
Making enrollment the creator would:

- couple Device lifecycle to Account synchronization bootstrap;
- leave Accounts without Devices structurally incomplete;
- create ambiguity under concurrent first enrollments;
- hide defective provisioning instead of correcting it;
- require runtime authority to repair Account-level infrastructure opportunistically.

Re-enrollment is likewise not a repair mechanism. It must not be used on the human Account merely to
cause cursor initialization.

### 3.3 Sync and recovery

Upload advances the existing Account cursor under its transaction and returns `service-unavailable`
without applying facts when the prerequisite is absent. Download, acknowledgement and recovery must
likewise treat absence as an invariant failure, not infer an empty Account where that could conceal
corruption. No client component owns initialization.

## 4. Existing-Account repair boundary

The repair must be additive, idempotent and safe for more than the currently observed single Account.
For each missing row, initialize:

```text
next_cursor = max(existing sync_events.server_cursor for Account) + 1
```

with `1` when no Events exist. Although the current provider counts show zero Events, deriving from
existing immutable facts prevents cursor reuse if another environment contains a partial historical
state. Existing `account_cursor_state` values must never be reset, decreased or recomputed.

Recommended migration transaction order:

```text
BEGIN
  acquire the narrow locks required to exclude Account/cursor allocation races
  install future Account-initialization enforcement
  INSERT missing cursor rows from Accounts and per-Account event high-water
    ON CONFLICT DO NOTHING
  verify every Account has exactly one cursor row
  record migration ledger entry
COMMIT
```

The migration must fail and roll back if it detects an invalid high-water condition, duplicate
server cursors, a non-positive next cursor, privilege/ownership drift, or an Account that remains
without state. No destructive down migration, table reset, event rewrite, resequencing or manual
one-row SQL patch is accepted as the canonical repair.

## 5. Transaction, concurrency, RLS and privilege invariants

The next design/materialization unit must preserve all of the following:

- Account creation and initial cursor-state creation are atomic;
- concurrent Account provisioning cannot create two states or expose a state-less committed Account;
- concurrent first submissions serialize cursor allocation through the single Account row;
- existing `next_cursor` never moves backward and each committed server cursor remains unique;
- a failed provisioning or repair transaction leaves neither partial Account infrastructure nor a
  false migration-ledger success;
- runtime remains unable to create schema, roles or Accounts;
- runtime may advance cursor state only inside authenticated, Account-scoped protected transactions;
- RLS continues to bind `account_cursor_state.account_id` to transaction Account context;
- the migration owner, not the hosted runtime identity, owns schema/repair materialization;
- any trigger/function has a fixed safe `search_path`, qualified objects, minimal execute surface,
  explicit owner and revoked `PUBLIC` access where applicable;
- repair does not modify memberships, Devices, enrollments, submissions, events, acknowledgements,
  local outbox rows or events 1–2.

## 6. Alternatives and tradeoffs

| Alternative | Benefit | Cost/risk | Design disposition |
| --- | --- | --- | --- |
| Provisioning transaction plus database trigger | Atomic invariant across insertion paths; smallest consumer coupling | Trigger ownership/search-path/upgrade behavior needs strong proof | Preferred candidate |
| Exclusive provisioning procedure | Explicit API and auditable authority | Requires revoking/banning every direct insertion path and updating fixtures | Acceptable if comprehensively enforced |
| Enrollment `INSERT ... ON CONFLICT` repair | Easy near the observed workflow | Wrong owner; races first enrollment; conceals provisioning defect | Rejected |
| First Sync lazy initialization | Avoids separate provisioning work | Mixes repair with fact acceptance and complicates unknown/rollback semantics | Rejected |
| One-off provider console insert | Fast for one Account | Non-repeatable, bypasses migration evidence and future invariant | Rejected as canonical route |
| Edit migration 001 or replay 001-006 | Makes fresh schema appear complete | Rewrites forward history and does not safely repair deployed state | Rejected |
| Additive backfill only | Repairs current Accounts | Future provisioning can regress | Insufficient alone |

## 7. Contradictions and drift

1. Schema intent and fixture practice treat `account_cursor_state` as mandatory, but the foreign key
   permits an Account without it and no current production provisioning boundary enforces total
   participation.
2. Local harnesses explicitly insert Account and cursor rows together, so they masked the missing
   provider provisioning step until the real protected submission.
3. Enrollment successfully created/recognized the Device while Account synchronization state was
   absent. This proves enrollment completion is not sufficient hosted-Sync readiness evidence.
4. Commit `75dc7be` corrects failure behavior, not the prerequisite. Treating its terminal
   `CAUSE_CORRECTED` as GCM02 closure would collapse implemented classification into provider readiness.
5. The historical Closure attempt did not observe response headers before its 1000 ms deadline. It
   remains client-side observation loss even though server logs later recorded a 500; do not rewrite
   either evidence owner.

## 8. Evidence required before any provider deployment or retry

### 8.1 Local materialization evidence

- fresh 001-through-new-migration path creates the invariant;
- upgrade 001-006 to the new migration repairs a missing row;
- existing correct cursor rows remain byte/value equivalent;
- missing row with no Events becomes `next_cursor = 1`;
- missing row with existing Events becomes `max(server_cursor) + 1` without collision;
- concurrent Account provisioning and concurrent repair are idempotent;
- concurrent first submissions allocate distinct monotonic cursors;
- forced failure rolls back DDL/data/ledger effects as designed;
- trigger/procedure owner, mode, ACL, fixed search path and object-shadowing resistance pass;
- runtime Account insertion and schema creation remain denied;
- cross-Account RLS and transaction-context probes fail closed;
- enrollment cannot create or repair cursor state;
- upload/download/ack/recovery absence paths remain bounded and non-applied;
- migrations 001-006 remain unchanged;
- full API, Flutter, convergence/recovery, platform build, secret-scan and changed-path validations pass.

### 8.2 Reconciliation and deployment evidence

New G/H/I must distinguish invariant materialization from provider deployment. Main and all domains
must reconcile the new unit before provider action. Only then may a separately authorized deployment
apply the forward migration with the migrator identity and deploy the corrected server/client.

After deployment, gather only sanitized evidence:

1. deployed commit/migration identity and successful startup/readiness;
2. Account count equals cursor-state count for the scoped development environment;
3. the existing Account has one cursor row with the expected safe next cursor;
4. submissions/events/acknowledgements remain unchanged before retry;
5. runtime DDL/Account creation remains denied and RLS remains scoped;
6. one harmless health correlation passes.

Only Main/human authority after those checks may permit one exact-identity retry. A retry is not part
of the repair migration, deployment, or health verification.

## 9. Accepted invariants retained from I/J

- external subject, Account, membership, InstallationId and DeviceId remain distinct;
- exact Submission identity, request hash, ordered events 1–2 and next local Device sequence 3 remain
  unchanged;
- immutable Event identity/content hash/device sequence and idempotent replay rules remain stable;
- client-observed diagnostics and server-observed lifecycle logs remain separate evidence owners;
- final `response-completed` owns terminal HTTP status; logging cannot affect transaction outcome;
- an observed 503 is a server-declared not-applied failure, while a missed deadline remains unknown
  until durable server evidence is reconciled;
- JWT/JWKS, transaction-time authorization, callback validation, route inventory, runtime/migrator
  separation and offline-first local operation are not weakened;
- GCM02, MCG-03/04 and Cycle 11 remain outside this boundary.

## 10. Recommended next Design boundary

Main should stage one bounded unit provisionally named:

```text
C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR
```

Its architecture objective is:

```text
Account provisioning
  -> atomic cursor-state invariant
  -> additive repair of existing missing state
  -> enrollment consumes but does not create Account state
  -> protected Sync advances or fails closed
```

Main must freeze before Codex starts:

1. trigger-backed invariant versus exclusive provisioning procedure;
2. additive migration identifier after 006 and ledger checksum policy;
3. high-water-derived repair rule and locking strategy;
4. exact privilege/RLS probes and producer case list;
5. deployment as a later, separately authorized provider gate.

Current terminals:

```text
C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED
C10_MCG02_CURSOR_STATE_PREREQUISITE_UNRESOLVED
GCM02_OPEN
REAL_SYNC_RETRY_UNAUTHORIZED
```
