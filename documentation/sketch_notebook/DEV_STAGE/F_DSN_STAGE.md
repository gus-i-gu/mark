# F_DSN_STAGE — C10-S02 Design Materialization Authority

> Sequence: FLX-INV-02 → Main D/E/F
> Unit: disposable retention, snapshot and rebootstrap mechanism
> Baseline: `f6ecf800d736f0d77dd1754eded4f5544462ea83`
> Authority: controlling architecture contract for Codex

## 1. Topology and dependency direction

Preserve:

```text
Flutter domain/application ports
→ Drift + HTTP infrastructure
→ authenticated Fastify application services
→ PostgreSQL repositories/transactions
→ lab-only SnapshotStore and cleanup worker
```

Flutter never connects to PostgreSQL or receives storage credentials. Recovery logic must not enter
pages/widgets. PostgreSQL and snapshot chunks remain disposable loopback lab resources.

## 2. Version boundaries

- Event: `purchase.registered`, payload version 3, unchanged.
- Cursor: existing opaque `c10b:<integer>` lab token, unchanged.
- Recovery snapshot format: version 1.
- Server migration: forward-only 003; never edit 001/002.
- Drift schema: additive v6; preserve v5 data and synchronization invariants.

Contracts live under the existing shared-beta contract boundary and are closed recursively. Dart
and TypeScript share deterministic fixtures and canonical hashes.

## 3. Injected policy

Define `RetentionPolicy` with explicit values supplied by composition:

- minimum event retention duration;
- recent-contact/dormant threshold;
- Device lease duration or expiry instant;
- snapshot chunk maximum bytes;
- cleanup batch maximum rows;
- recovery session lifetime;
- supported snapshot/event format versions.

No production default. Normal API startup must refuse retention worker composition without an
explicit policy. Lab tests inject deterministic values and a `Clock`.

## 4. Device lifecycle

Keep `devices.status` as authorization state `active|revoked`. Migration 003 adds nullable/backfilled
`last_seen_at` and `lease_expires_at` under a safe lab rule. Retention class is derived:

```text
revoked                       → revoked
now >= lease_expires_at       → expired
now-last_seen < threshold     → eligible-active
otherwise                    → eligible-dormant
```

Eligible-active and eligible-dormant acknowledgements constrain cleanup. Expired and revoked do
not. Sync/recovery calls update last-seen only after verified Account/Device authorization; C10-S02
does not renew production leases, enroll, replace or reactivate Devices.

## 5. PostgreSQL migration 003

Use coherent names following existing schema conventions. Required logical structures:

### Account retention state

One row per Account:

- `earliest_incremental_cursor`, initially stream origin;
- nullable current available SnapshotId;
- policy/recovery format version;
- updated timestamp.

Never advance earliest availability before the corresponding event deletion commits.

### Snapshot manifest

Account-scoped immutable identity with:

- SnapshotId and state;
- covered-through cursor and captured high-water;
- recovery format and compatible event/schema versions;
- chunk count, total bytes, ordered-manifest hash;
- fact counts and build/validate/publish timestamps;
- superseded SnapshotId relation where useful.

Only `available` may authorize recovery or cleanup. State transitions are monotonic.

### Snapshot chunks

Account+Snapshot+index identity, length, content hash and bounded binary/JSON bytes. The lab store
implements a port; do not bind domain/application code to PostgreSQL bytes.

### Cleanup runs

CleanupRunId, Account, policy version, SnapshotId, proposed/committed cursor range, state, attempts,
counts and timestamps. Identity makes worker retry idempotent.

### Rebootstrap sessions

RecoverySessionId, Account, Device, SnapshotId, request hash, state, expiry, stored start result,
last observed chunk/completion metadata and timestamps. Same identity/hash replays; same identity
with different hash is conflict.

All new Account tables use composite ownership FKs where possible, RLS and explicit predicates.
Add indexes for available snapshot lookup, cleanup claims, session replay and chunk ordering.

## 6. Roles and transaction boundaries

Runtime API may:

- read capabilities/available manifests and chunks;
- create/query/update its Device-bound recovery sessions;
- read incremental events and submit normal acknowledgements.

Runtime may not build/publish snapshots, delete events, advance availability floor, alter policy,
provision Devices or perform DDL.

Dedicated lab worker may build/validate/publish snapshots and execute coverage-gated cleanup for one
Account. It may not enroll/revoke Devices, alter roles/schema or cross Account boundaries.

Use transaction-local Account/Device context and explicit predicates. Keep bounded serialization/
deadlock retry. Snapshot build uses one stable Account view; publication is a separate transaction
after durable read-back verification. Cleanup locks one Account retention row, recomputes every
predicate, deletes a bounded contiguous cursor prefix and advances state/ledger in one transaction.

## 7. Snapshot format 1

Manifest canonical content includes:

- AccountId, SnapshotId, format version and covered-through cursor;
- compatible event/schema versions;
- ordered chunk descriptors `{index,length,hash}`;
- total bytes/hash;
- deterministic fact counts.

Canonical fact stream order:

```text
Account → Stores → Products → People → PaymentMethods → Purchases → PurchaseItems
```

Within each kind sort by stable opaque ID. Serialize closed normalized records only. Include facts
required by Drift constraints: Account default currency; complete reference facts; immutable
Purchase/Item values. Exclude queues, Devices, secrets, cursor inbox, acknowledgement, recovery
metadata and Lists projections.

Server currently owns events rather than normalized fact tables. For this append-only slice the
snapshot builder deterministically folds accepted `purchase.registered` v3 events, rejecting any
identity/content collision or bare non-null Person/Payment reference. Do not invent merge rules.

Chunk after canonical fact serialization with an injected byte ceiling; hashes cover exact UTF-8
bytes and the ordered manifest. Read back every chunk before `available` publication.

## 8. Snapshot and cleanup invariants

Snapshot cut:

1. establish one consistent Account view;
2. read high-water and contributing events/facts in that view;
3. set `coveredThroughCursor` to that view's high-water;
4. build/verify chunks;
5. publish only if compatible and complete.

Events committed after the view remain later incremental events.

Cleanup boundary is the greatest contiguous cursor satisfying all three independent floors:

```text
minimum-age floor
eligible-Device acknowledgement floor
available compatible snapshot covered-through floor
```

If any floor is absent, cleanup deletes nothing. Delete only a bounded contiguous prefix. An invalid,
building, failed or incompatible snapshot contributes no floor. Preserve the previous available
generation until replacement and a later cleanup checkpoint are verified.

## 9. API contracts

### Capabilities

Returns protocol/recovery versions, current high-water, earliest incremental cursor, compatible
SnapshotId alias when available, retention policy version and derived Device class. It returns no
duration as a production promise in C10-S02.

### Incremental download

Validate the supplied cursor before querying events:

- origin/current within retained range → normal page, including valid empty page;
- older than earliest retained position → typed `cursor-expired`, no events;
- include safe action `full-rebootstrap-required` only when a compatible snapshot is available.

### Rebootstrap start/status

Start is POST with RecoverySessionId/request hash and supported formats. Bind stored result to
verified Account+Device+Snapshot. Query returns phase and immutable manifest. Unknown start outcome
queries/replays the same identity.

### Chunk

Return exact session-bound index, length, hash and bytes with a response cap. Reject missing,
out-of-range, expired, revoked and cross-Account access. Do not expose storage keys.

### Complete

Client reports verified SnapshotId/hash and committed catch-up cursor. Server checks session,
snapshot and cursor bounds; it does not trust completion to advance acknowledgement beyond the
normal verified acknowledgement transaction. Same request identity replays stored result.

## 10. Drift v6 and recovery ports

Add minimal durable tables for recovery session metadata and downloaded-chunk verification. They
must not become authoritative Account facts. Migrate v5→v6 without selecting/deleting facts or
changing outbox identities.

Add application ports equivalent to:

- `RecoveryTransport` for capabilities/session/manifest/chunks/completion;
- `RecoveryProgressRepository` for durable session/chunk phase;
- `SnapshotFactApplier` for fresh-target atomic fact/cursor apply;
- `LocalRecoveryGuard` for pending/uploading/unknown outbox detection.

HTTP and Drift remain adapters. Domain/application code receives typed results, not status-code or
table details.

## 11. Fresh-target rebootstrap algorithm

1. Check local guard. Any unsafe outbox state returns `local-changes-block-rebootstrap`.
2. Start/replay one Device-bound recovery session.
3. Download missing chunks; persist only verified progress.
4. Verify full ordered manifest, Account, versions, counts and total hash.
5. In one fresh-target Drift transaction, apply canonical facts plus snapshot covered cursor.
6. Download/apply every event after the cut through captured/current high-water.
7. Acknowledge the committed contiguous cursor.
8. Complete/query the recovery session.
9. Close/reopen target and compare authoritative facts and derived Lists queries.

Corruption, conflict or crash before transaction commit leaves target facts/cursor unchanged.
C10-S02 does not swap a production database file, merge a populated database, invent Device
replacement or discard the original database.

## 12. Security and failure mapping

- Cross-Account access → `wrong-account`, not applied.
- Unknown/revoked Device → `device-revoked` or typed denial, not applied.
- Retention-expired Device → distinct `device-expired`; may rebootstrap only if authorization and
  session policy permit.
- Old cursor → `cursor-expired`; never empty success.
- Unsupported format → `protocol-upgrade-required` or `recovery-unavailable`.
- Corrupt manifest/chunk → `conflict`, no apply.
- Interrupted transport → `unknown` only where commit is unknowable; preserve session identity.
- Unsafe local work → `local-changes-block-rebootstrap`, no mutation.

Never log payloads, chunks, tokens, credential URLs or SQL details. Cap chunk, manifest, page and
error sizes. Test forged identifiers, replay, truncation, downgrade, premature cleanup, malicious
ack advancement and worker privilege escalation.

## 13. Explicit exclusions

No Neon mutation, object-storage SDK, production auth/enrollment, hosted worker, pg_cron, production
duration, live cleanup, account deletion, edits/deletes/tombstones, encryption redesign, signed URL,
production database switch, UI/UX work, Analytics or broad page refactor.

## 14. I report requirements

I must record final dependency direction, schema/migration IDs, recovery/event versions, policy
injection, snapshot format/hash/chunk rules, transaction/cleanup invariants, RLS/role evidence,
rebootstrap behavior, fixture containment, architectural deviations and every deferred decision.
