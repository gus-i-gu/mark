# C_DESIGN — C10-S01B Local Synchronization Convergence Completion

> Sequence: FLX-INV-02 investigative/speculative round
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
> Knowledge state: candidate / proposed / provisional
> Branch/baseline: `intermid-cycle-recovery` / `1af8137e3f7db2d5ee3ecdf3796ae62808e0717c`
> Inspection date: 2026-07-14
> Authority: Design/Architecture [D]; repository and external materialization: none

## 1. Methodology retained

The complete route `INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES →
CHAT_PROTOCOL` was read after both AGENTS files. Design owns responsibility, dependency,
relationship, schema and maintainability analysis. Under PRC-01, repository inspection proves only
implemented structure; named tests prove only their stated boundary. Repetition does not promote a
claim. This stage may replace only C, preserves disagreement, and cannot edit source, permanent
memory, Main stages, reports, methodology or external resources. FLX-INV-02 cannot authorize Codex.

## 2. Actual current architecture

```text
Register Purchase use case → LocalPurchaseRepository → one Drift transaction
  → Purchase/Product/Store facts + SyncEvent + PendingEvent
Sync use cases → SyncTransport port (no adapter)
  → Drift outbox / Drift remote applier
Fastify routes → AuthVerifier → transaction helper → acceptSubmission → PostgreSQL
Docker lab → PostgreSQL 18 + migration 001
```

Dependency direction is sound: Flutter presentation/application/domain do not depend on HTTP,
Fastify, `pg`, Docker or Neon; Flutter does not connect to PostgreSQL. Schema v5 adds installation,
submission, membership, inbox and cursor structures. V3 fixtures and canonical hashing exist in
Dart and TypeScript. These are foundations, not a complete vertical slice.

## 3. Implemented / stubbed / missing inventory

| Concern | State at baseline | Evidence boundary |
| --- | --- | --- |
| local Purchase + event/outbox atomic write | implemented, tested | Drift tests only |
| v3 schemas/hash fixtures | implemented, partial | schemas leave aggregate subobjects open |
| upload service | implemented, thin | no automated route→real PostgreSQL proof |
| download route | stub | always empty; no auth/database query |
| acknowledgement route | stub | constant duplicate result; no auth/database write |
| PostgreSQL transaction | implemented, incomplete | serializable once; no retry/context |
| AuthVerifier | port + fixture/refusing adapters | normal runtime intentionally unusable |
| Flutter SyncTransport | missing | port only; no HTTP implementation/composition |
| remote apply | partial | inserts inbox and advances cursor, no facts |
| two-device harness | partial | direct in-process event replay, no API/Postgres |
| RLS/isolation | partial | only `sync_events` has policy/probe |
| migration/roles | partial | 001 creates role; weak FK/RLS/grant coverage |
| retention/rebootstrap/live auth | deferred | must remain outside S01B |

Additional defects found: upload trusts an unvalidated request shape; `sync_events.event_id` is
globally unique but its duplicate lookup is not Account-scoped; coordination tables omit several
composite foreign keys; runtime receives DML on `accounts`; transaction context never sets the
authenticated Account; local greatest-contiguous logic returns the maximum applied cursor rather
than proving contiguity; page apply can accept cursor gaps and advances per event instead of once to
the verified page boundary.

## 4. Proposed C10-S01B topology

```text
explicit lab composition
  → SyncCoordinator
      → UploadPendingEvents → HttpSyncTransport
      → DownloadPageLoop → HttpSyncTransport
      → ApplyRemotePurchasePage → Drift transaction
      → AcknowledgeCommittedCursor → HttpSyncTransport
  → loopback Fastify API
      → production-shaped AuthVerifier port (fixture only in lab/test composition)
      → SyncApplicationService
      → PgSyncRepository + bounded transaction runner
  → PostgreSQL runtime role + complete Account RLS
```

`SyncCoordinator` owns order and bounded looping, not persistence or protocol parsing. Transport
owns HTTP, JSON and timeouts. API application service owns authorization and use-case rules.
`PgSyncRepository` owns SQL. Drift remote application owns local atomicity and collision results.
The app remains local-only unless an explicit lab/test composition injects transport and token
source; default composition has no sync coordinator.

## 5. Executable endpoint and failure hypotheses

- All bodies/responses receive closed JSON Schemas with `$id`, operation-specific request/result
  definitions, bounded strings/arrays, formats and `additionalProperties: false` recursively.
- `POST /submissions`: authenticated Device must equal request Device; validate request hash and
  every event before transaction. One serializable transaction locks Device/cursor state, enforces
  exact sequence, allocates cursors, appends events and stores replay result.
- `GET /events?after=<opaque>&limit=1..100`: authenticate; decode cursor only server-side; query
  `account_id = claim.account` and `server_cursor > decoded` ordered ascending, `limit + 1`.
  Response includes events, request `after`, and `nextCursor` equal to the last returned cursor;
  empty page preserves `after`. Cursor encoding is versioned opaque base64url data protected by
  strict parsing; clients never perform cursor arithmetic.
- `POST /acknowledgements`: body carries Device and cursor token. Authenticate matching Device,
  decode Account cursor, reject beyond Account high-water mark, then upsert
  `greatest = GREATEST(existing, supplied)`. Equal/lower is duplicate-equivalent; revoked/foreign
  Device is terminal. It does not delete events.
- Map validation 400, auth-required 401, forbidden/revoked 403, collision/gap 409,
  protocol-upgrade 422, bounded exhaustion 503, and unknown timeout/network locally. Every failure
  maps to a typed code/outcome/retryability; no raw SQL/Fastify exception crosses the boundary.

## 6. Bounded Flutter HTTP transport

Add an infrastructure adapter implementing the existing `SyncTransport`, using an injected HTTP
client, explicit loopback/test base URI, token-source port, clock/correlation source and codec.
It sends bearer material only in headers, never stores/logs it, applies request/connect/response
timeouts, caps response bytes, validates status/content type/schema, and maps transport/HTTP/
protocol failures to typed application results. Credentials, fixture claims and API host are absent
from source and defaults. Do not retry inside the adapter: orchestration decides whether the same
SubmissionId/request hash is safe to retry. Downloads and acknowledgements may retry only under
their idempotent contract.

## 7. Complete remote-apply algorithm

For each authenticated Account page, before mutation:

1. validate page ordering, cursor continuity from committed local cursor, Event envelope/hash,
   type/version, Account and aggregate totals/invariants;
2. classify each EventId: absent; same hash (equivalent); different hash (quarantine/stop);
3. decode complete immutable Store, Product(s), Purchase, Items and optional Person/Payment facts;
4. for stable IDs already present, require field-for-field semantic equivalence; same Product code
   or exact-identity key with a different stable ID/content is collision, never auto-merge;
5. in one Drift transaction insert absent Store/Product/reference facts, Purchase and Items; insert
   inbox rows; advance `sync_state.account_cursor` once to the verified page end;
6. on any invalid/collision/gap, roll back facts, inbox and cursor together, persist quarantine only
   in a separate post-rollback diagnostic transaction if Main authorizes such a table;
7. after commit, invalidate/requery rebuildable Lists via the application projection boundary;
   do not persist a List aggregate or acknowledge before commit.

The event must contain every immutable fact needed by existing Drift rows. The current permissive
schema must be closed over Store/Product/Item/quantity/money/reference shapes. Optional referenced
Person/Payment facts require either complete immutable snapshots or explicit null; bare foreign IDs
cannot be applied on a fresh peer.

## 8. Schema, migration and RLS corrections

Prefer additive `002_coordination_hardening.sql`; 001 is already published at the required commit.
002 should be transactional and fail closed. Proposed corrections:

- composite FKs: submissions and events `(account_id,device_id) → devices`; acknowledgements same;
  cursor state and all coordination Account IDs → accounts;
- unique Account/Event identity aligned with lookup policy; retain global Event UUID only if the
  protocol formally guarantees it and still scope authorization queries by Account;
- indexes for `(account_id,server_cursor)`, Device sequence, submission replay and ack lookup;
- checks for event type/version/hash, non-empty bounded result, cursor/sequence positivity;
- enable and force RLS on every Account-bearing coordination table; policies for SELECT/INSERT/
  UPDATE using transaction-local `markei.account_id` and Device where applicable;
- revoke public/default privileges; runtime gets only required table/sequence operations and no
  Account provisioning or DDL; enrollment/migration role owns Account/Device creation;
- API transaction starts, sets `SET LOCAL markei.account_id` and Device claims from verified auth,
  then executes repository calls on the same checked-out connection.

Migration tests must apply 001 then 002, inspect constraints/policies/grants, exercise both Accounts,
and recreate a fresh database. Never rewrite a previously applied migration in place. If 001 has
never left this branch, squashing is cheaper, but loses the exact published-baseline audit trail and
is not recommended for this recovery branch.

## 9. Bounded PostgreSQL serialization retry

The transaction runner, not routes or repositories, retries SQLSTATE `40001` and optionally `40P01`
only. Use at most 3 total attempts with short capped jitter, a fresh connection/transaction each
attempt, and one overall deadline. The action must be database-idempotent through SubmissionId and
event constraints. Never retry validation, auth, FK/check/unique collision, pool timeout or unknown
commit outcome as a new logical submission. Exhaustion returns retryable service-unavailable;
client retains the same SubmissionId.

## 10. Cross-process verification architecture

One test runner starts disposable PostgreSQL, applies 001+002 with migrator credentials, starts the
compiled API as a child process on an allocated loopback port, and waits on readiness. Two separate
Flutter integration-test processes use different SQLite paths and injected lab transport/token
sources. A registers offline; A uploads through HTTP; a proxy/fault adapter drops the post-commit
response; A retries the same Submission; B downloads/applies/acks through HTTP. Processes close and
reopen databases; SQL and client queries compare one server Event, one B Purchase aggregate,
equivalent Product/Store facts, cursor/ack and rebuilt Lists. Teardown owns child processes,
containers, volumes and temp files even on failure. Direct event replay remains a unit test only.

The pre-Neon gate requires: route schema tests; real Postgres upload/download/ack integration;
wrong-Account/revoked-Device/RLS/grant probes on every table; serialization retry/exhaustion;
cursor paging/gap/reorder; duplicate/collision/quarantine; atomic crash points; two-process reopen
convergence; local-only regression; migration 001→002/fresh checks; secret scan and deterministic
teardown. Passing this gate prepares MCG-01; it does not authorize or contact Neon.

## 11. Alternatives and recommendations

| Decision | Alternatives and trade-offs | Recommendation / confidence |
| --- | --- | --- |
| API/Postgres topology | A: Fastify inject + mocked DB: fast, misses SQL/network. B: API child + container Postgres: real boundaries, moderate setup. C: Flutter and API in one test process: simpler but false topology. | B; retain A for unit tests. High. Rollback: remove lab harness only. |
| remote apply boundary | A: generic event applier writes tables: extensible, weak aggregate rules. B: type-dispatch to Purchase aggregate applier: explicit atomic invariants. C: reuse registration command: risks new IDs/outbox echo. | B. High. Rollback: disable injected sync composition; local data unchanged before committed page. |
| later Neon connection | A: direct runtime connection: simple, connection pressure/rotation risk. B: provider pooler: scalable, transaction-mode caveats. C: app-owned proxy pool: more operations. | Keep A/B unresolved until MCG provider evidence; design `pg.Pool` abstraction compatible with direct or pooled URL. Medium. Security equal if TLS/least privilege; test prepared statements and transaction-local RLS for B. |
| migration strategy | A: edit 001: clean fresh schema, destroys published immutability. B: additive 002: auditable/upgradable, extra file. C: replace 001 plus compatibility script: dual truth. | B. High. Rollback: disposable DB recreate; forward corrective 003 after any live apply. |
| RLS context | A: `SET LOCAL` verified claims per transaction: pooled-safe if transaction discipline holds. B: explicit Account predicate only: testable, weaker defense. C: session `SET`: leaks across pooled borrowers. | A plus explicit predicates. High. Test context absence/wrong Account/reset; never C. |

## 12. Rollback, stop and deferred boundaries

Local-only startup is the architectural rollback: no adapter/config means no network work. Database
migration rollback is restore/recreate only in disposable tests; production rollback must be a new
forward migration. Stop on ambiguous v5 data, aggregate schema insufficiency, non-atomic apply,
fixture auth reachable from normal composition, missing Account scoping, migration drift, secrets,
unowned resources, or any need for external provider access.

Remain deferred: production authentication/provider and enrollment; API host; Neon project/
connection mode selection; retention, snapshots, cursor expiry and rebootstrap; edits/deletion and
conflict merging; background sync; UI redesign/Analytics; telemetry, backup and public release.

## 13. Unresolved Main decisions

1. Authorize additive migration 002 versus explicitly declaring 001 unpublished and squashable.
2. Decide whether optional Person/Payment facts enter v3 now or are forbidden/null in S01B.
3. Approve a durable quarantine table or require rollback plus external test diagnostics only.
4. Freeze opaque cursor encoding/version and page-contiguity rule.
5. Confirm test-only token/claim issuance mechanism and cross-process runner ownership without
   selecting a production auth provider.
6. Decide whether MCG-01 begins only after every gate above passes (Design recommendation: yes).

No production auth provider, API host, Neon topology or retention policy is silently selected.
