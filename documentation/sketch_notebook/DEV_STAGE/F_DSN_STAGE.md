# F_DSN_STAGE — C10-S01 Synchronization Architecture Contract

> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITH D/E
> Scope: pre-Neon local protocol, persistence, API and dependency architecture
> Live provider/auth/deployment: prohibited

## 1. Required topology

```text
Flutter application
→ synchronization application ports/use cases
← local Drift adapters + HTTP transport adapter
→ app-private SQLite v5

HTTP transport
→ controlled TypeScript API
→ application transactions
→ pg adapter
→ disposable PostgreSQL 18 lab
```

Domain/application code must not depend on Flutter widgets, Drift, HTTP, Fastify, `pg`, Docker or
Neon. Flutter never connects to PostgreSQL and never owns database migration credentials.

## 2. Repository structure

Preferred bounded structure; equivalent names require explanation in I:

```text
contracts/shared_beta/v3/
  purchase_registered.schema.json
  sync_submission.schema.json
  sync_download_page.schema.json
  sync_acknowledgement.schema.json
  protocol_failure.schema.json
  fixtures/

clients/markei_flutter/lib/domain/sync/
clients/markei_flutter/lib/application/sync/
clients/markei_flutter/lib/infrastructure/local/sync/
clients/markei_flutter/lib/infrastructure/remote/
clients/markei_flutter/test/sync/
clients/markei_flutter/tool/sync_lab.dart

services/markei_sync_api/
  src/domain/
  src/application/
  src/http/
  src/postgres/
  migrations/
  test/

infra/sync_lab/
  compose.yaml
  scripts/
  README.md
```

Keep handwritten modules near 250 lines. Split migrations and route/transaction responsibilities.
Generated Drift output is exempt and remains derived.

## 3. Executable v3 contract

Canonical JSON must be UTF-8, deterministic and hashed with SHA-256 using one documented canonical
serialization shared by Dart and TypeScript. Do not hash ordinary non-canonical `jsonEncode` output
whose map ordering or numeric representation is ambiguous.

Event envelope fields:

```text
eventId UUID
accountId UUID
deviceId UUID
deviceSequence positive integer
eventType = purchase.registered
payloadVersion = 3
occurrenceTime UTC RFC3339
payload complete immutable Purchase aggregate
contentHash lowercase SHA-256 hex of canonical content
```

The Purchase payload includes stable Purchase/Store/Product/Item IDs, Product code and exact identity
facts, quantity/unit/mode, currency/minor-unit totals, optional Person/Payment reference facts and
timestamps required by the accepted aggregate. It excludes Lists projections, UI state, analytics,
credentials, local file paths and mutable retry metadata.

Upload Submission:

```text
submissionId UUID
deviceId UUID
requestHash SHA-256
events non-empty bounded array
```

AccountId is derived from verified auth context at the server. If retained in an event for hash/
domain identity, it must equal that verified Account; it is never authorization by itself.

Define explicit batch and payload byte limits in shared fixtures/config. Reject unknown protocol
versions and unknown security-relevant fields.

## 4. Local schema v5

Handwritten Drift authority must add or evolve these logical units:

### InstallationMetadata

- singleton key or uniqueness ensuring one current installation row;
- InstallationId UUID v4;
- AccountId FK;
- currentDeviceId FK to Devices;
- createdAt/updatedAt;
- unique Account/current-installation invariant suitable for one app-private DB.

Bootstrap transaction:

1. load singleton metadata;
2. if present, require referenced Account/Device and reuse it;
3. if absent, inspect existing Devices;
4. exactly one usable UUID Device for the provisional Account → backfill metadata;
5. none → create Device + metadata atomically;
6. multiple usable Devices without metadata → typed ambiguity; do not choose earliest.

Preserve historical/non-current Devices and sequence ownership.

### SyncSubmissions

- SubmissionId PK, AccountId, DeviceId;
- requestHash, state, createdAt/updatedAt;
- attemptCount, nextAttemptAt nullable, leaseUntil nullable;
- outcome and response/error code nullable;
- stable retry uses same row and request hash.

### SyncSubmissionEvents

- SubmissionId FK + EventId FK composite key;
- deterministic membership/order;
- no Event appears twice in one Submission.

### PendingEvents

Retain EventId ownership and lifecycle. It may gain acceptedAt/lastErrorCode, but Submission attempt
facts belong to SyncSubmissions, not duplicated per Event. Valid transitions are explicit and tested.

### SyncInbox

- AccountId + EventId PK/unique;
- contentHash, serverCursor, state/appliedAt;
- same ID/hash replay is equivalent;
- same ID/different hash is terminal conflict.

### SyncState

Cursor advances only in the same transaction that inserts inbox entries and applies all accepted
facts for the contiguous page. Never advance past a rejected/gapped Event.

## 5. Local application ports

Define framework-independent interfaces/results for:

- `CurrentInstallationRepository`;
- `SyncOutboxRepository`;
- `SyncInboxRepository` or one atomic `RemoteEventApplier`;
- `SyncTransport.uploadSubmission`;
- `SyncTransport.downloadAfter`;
- `SyncTransport.acknowledge`;
- `UploadPendingEvents`;
- `DownloadAndApplyEvents`;
- `AcknowledgeAppliedCursor`;
- injected Clock/UUID/backoff policy where deterministic tests require them.

The HTTP adapter converts typed transport/protocol results but does not decide domain conflict or
mutate Drift outside repositories. Synchronization is disabled by default in composition.

## 6. Remote apply transaction

For each downloaded contiguous page, one Drift transaction must:

1. validate Account, version, cursor order and hash;
2. detect inbox duplicate/conflict;
3. create/reuse Product, Store and optional reference facts only under stable-ID/content rules;
4. insert Purchase and Items idempotently;
5. insert applied inbox record;
6. invalidate/rebuild relevant derived Lists state;
7. advance Account cursor only after every Event in the accepted page applies.

Equivalent existing stable facts are reused. Same stable ID with differing immutable content yields
typed conflict and no partial page commit. No automatic Product merge or visible-code reassignment.

## 7. API boundaries

Required routes:

```text
GET  /health/live
GET  /health/ready
POST /v1/sync/submissions
GET  /v1/sync/events?after=<opaque>&limit=<bounded>
POST /v1/sync/acknowledgements
```

Health responses reveal no secrets/schema internals. All sync routes require `AuthVerifier` output
containing AccountId and authorized DeviceId. Payload Account/Device must match verified context.

Fixture auth:

- exists only as an injected test adapter;
- may use deterministic claims without real bearer tokens;
- cannot be selected by normal CLI/environment configuration;
- server entrypoint refuses startup without a non-fixture verifier;
- integration tests may construct the app directly with fixture verifier and loopback listener.

No enrollment/revocation endpoint or production auth adapter is implemented in C10-S01. Test fixtures
seed Accounts/Devices through migration-owned helpers.

## 8. Server PostgreSQL model

Forward SQL migrations create logical tables:

- `accounts`;
- `devices` with Account, status, next expected sequence and timestamps;
- `account_cursor_state` with next cursor;
- `submissions` with request hash and stored JSON result;
- `sync_events` with EventId, Account, Device, sequence, cursor, type/version, occurrence, JSONB
  payload, content hash and received time;
- `device_acknowledgements` with greatest contiguous cursor;
- migration ledger owned by the migration tool.

Required uniqueness/indexes:

- EventId unique;
- Account + Device + DeviceSequence unique;
- Account + ServerCursor unique;
- Account + Device + SubmissionId unique;
- Account + ServerCursor download index;
- Account + Device status lookup.

Store UUIDs as UUID, cursor/sequence as BIGINT, hashes with exact length checks, payload as JSONB and
timestamps as `timestamptz`. Add positive/bounded checks. Do not use floating currency values.

## 9. Upload transaction and idempotency

Within one serializable/retryable transaction:

1. derive Account/Device from verified context and lock relevant Device/Account cursor state;
2. look up SubmissionId;
3. same SubmissionId/request hash → return stored response;
4. same SubmissionId/different hash → terminal conflict;
5. validate each Event schema/hash/Account/Device and exact next DeviceSequence;
6. same EventId/hash already accepted → duplicate-equivalent result;
7. same EventId/different hash → terminal conflict;
8. allocate per-Account cursors and append new Events;
9. update expected Device sequence;
10. store complete Submission response;
11. commit once.

Retry the whole transaction after PostgreSQL serialization failure with bounded attempts. Do not
return accepted before commit. A timeout after commit is recovered by the same SubmissionId.

## 10. Download and acknowledgement

Download returns Account-scoped Events strictly after the cursor, ascending, bounded and with next
cursor metadata. Cursor is opaque to clients even if represented numerically in the lab.

Acknowledgement accepts only a cursor that the Device can claim contiguously applied under the
contract. Server stores monotonic max; lower/equal replay is equivalent. It does not mean all Devices
acknowledged and does not trigger deletion in this unit.

## 11. Authorization and database roles

- Migration role owns DDL and is never used by runtime.
- Runtime role has only required DML/sequence/function grants and cannot alter schema/roles.
- API derives AccountId from AuthVerifier and uses Account-scoped transactions.
- Implement/test RLS defense in depth on coordination tables where feasible; set Account context
  transaction-locally and fail closed when absent.
- RLS does not replace API authorization, constraints or tests.
- Connections, tokens and passwords never enter tracked files or logs.

## 12. Conflict and retention boundary

First slice is append-only Purchase registration. Different Purchase IDs coexist. Same stable ID with
different immutable content is quarantined/conflict. Settings, reference mutation, edits/deletes,
Product merge and Store correction are excluded.

No TTL/deletion/snapshot is implemented. Disposable lab teardown deletes only inventoried lab data.
Live bounded retention requires a later accepted snapshot/rebootstrap and eligible-Device policy.

## 13. Verification architecture

Required layers:

- shared v3 fixture validation and cross-language hash parity;
- Dart domain/application unit tests;
- Drift fresh/v4→v5/failure/reopen/concurrency/crash tests;
- TypeScript domain/application/route tests;
- PostgreSQL migration/constraint/role/RLS/concurrency tests;
- API idempotency, isolation and typed failure integration tests;
- two-file Drift + API/Postgres local system harness;
- existing Flutter/Python regression suites.

Do not use mocks as the only evidence for transactions, constraints, migrations or cross-language
protocol compatibility.

## 14. I evidence requirements

Replace only `DEV_STAGE/I_DSN_CODEX.md`. Report final dependency direction, added modules, local/server
schema and migration IDs, protocol version/hash rules, transaction/idempotency behavior, auth fixture
containment, RLS/role evidence, deferred decisions, generated files and architectural deviations.

Explicitly state that local proof is not Neon, production authentication, deployment, retention,
backup, UI/UX or release acceptance.
