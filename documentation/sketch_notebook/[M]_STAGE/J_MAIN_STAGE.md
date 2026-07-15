# J_MAIN_STAGE — Cycle 10 Retention and Recovery Reconciliation

> Sequence: FLX-INV-02 A/B/C → Main reconciliation → D/E/F materialization
> Unit: C10-S02 — Disposable local retention, snapshot and rebootstrap proof
> Status: RECONCILED; LOCAL CODEX AUTHORITY PREPARED; MCG-01 ACTIVE/UNRECONCILED
> Branch: `intermid-cycle-recovery`
> Reconciled HEAD: `f6ecf800d736f0d77dd1754eded4f5544462ea83`
> Accepted predecessor: C10-S01B at `14c7894e21139390f83a8787be368d3633aa20dd`
> Inputs: current A/B/C, prior J/D/E/F, G/H/I and inspected implementation
> Authority: human-supervised Main synthesis

---

<!-- ROUND_MARKER:C10-S02-RETENTION-RECOVERY-RECONCILIATION-2026-07-15 -->

## 1. Purpose and evidence state

C10-S01B proved one disposable local Account event moving through real Drift, HTTP, Fastify and
PostgreSQL boundaries. It did not prove bounded retention, snapshot durability, cursor expiry or
rebootstrap. A/B/C converge on a hybrid policy mechanism and retain production parameters as open.

PRC-01 classification:

- accepted and validated: the named C10-S01B local convergence story;
- accepted for local materialization: hybrid mechanism, typed cursor expiry, deterministic
  snapshots, coverage-gated cleanup and fresh-target rebootstrap;
- provisional: production durations, Device lease policy, snapshot location, worker scheduling,
  database replacement and unsent-change merge;
- externally active but unreconciled: MCG-01 Neon configuration;
- deferred: provider mutation, production auth, deployment, real Device enrollment and Cycle 11 UI.

A/B/C remain investigation. D/E/F below are the only Codex authority for C10-S02.

## 2. Main selection

Main selects Alternative C as the local proof topology:

```text
minimum retention floor
+ eligible Device acknowledgements/lease
+ validated compatible snapshot coverage
→ monotonic cleanup watermark
→ incremental sync or explicit rebootstrap
```

This selects mechanism, not production policy. Durations must be injected through a typed policy.
No production default is authorized. Tests may use conspicuous fixture durations and deterministic
clocks, but those values must be named test data and must not appear as a user promise.

Cleanup is disabled in normal composition. Only the disposable lab may invoke it explicitly after
all safety predicates pass.

## 3. C10-S02 boundary

C10-S02 extends only the disposable local topology:

```text
Drift A/B/C
↕ Flutter HTTP transport
loopback Fastify lab API
↕
disposable PostgreSQL 18
```

It proves one Account with synthetic `purchase.registered` v3 facts. Snapshot recovery format 1 is
new and independent of event payload version 3. Existing cursor token `c10b:*` remains unchanged.

No Neon access, object storage, deployed runtime, production credential, ordinary user data,
background application sync or UI surface is in scope.

## 4. Server lifecycle and cleanup decisions

Keep enrolled Device authorization status as `active` or `revoked`. Add `last_seen_at` and
`lease_expires_at`; derive these retention classes under an injected clock:

- eligible-active: lease-valid and recently seen;
- eligible-dormant: lease-valid but outside the recent-contact threshold;
- expired: lease ended and no longer blocks cleanup;
- revoked: authorization denied and never blocks cleanup.

Do not implement Device enrollment, replacement or user-selected lease renewal. The lab seeds
synthetic lifecycle values. Every sync/recovery endpoint must verify the Account/Device row and deny
revoked or unknown Devices; authenticated claims alone are insufficient.

An event may be deleted only when all are true:

```text
received_at is older than the injected minimum-retention floor
and every eligible Device acknowledgement covers the event
and one available compatible validated snapshot covers the event cursor
```

Cleanup locks one Account, recomputes the boundary in-transaction, deletes bounded batches and
advances `earliest_incremental_cursor` plus its ledger atomically. Failure preserves the prior
availability floor. No physical deletion route is exposed to Flutter.

## 5. Snapshot decisions

Add forward-only migration `003_retention_snapshot_recovery.sql`; never edit 001 or 002. The lab
uses PostgreSQL-held bounded binary/JSON chunks behind a `SnapshotStore` port. This is a test
storage choice, not a production decision for Neon or object storage.

Recovery format 1 contains deterministic complete Account-owned facts supported by the slice:

- Account identity and default currency needed for reconstruction;
- Store, Product, Purchase and PurchaseItem facts;
- Person and PaymentMethod facts when complete snapshots exist;
- covered-through cursor, format/schema/event compatibility, counts, sizes and hashes.

It excludes Devices, credentials, outbox, inbox, acknowledgements, recovery sessions, UI state and
derived Lists. A Purchase with a bare non-null Person/Payment reference remains unsupported and must
fail snapshot creation rather than emit an incomplete artifact.

Snapshot states are `building`, `validating`, `available`, `failed`, `superseded`. A snapshot may
authorize cleanup only after read-back, per-chunk and total-manifest verification. Keep the previous
available generation until its replacement is verified.

## 6. Cursor-expiry and API decisions

Add closed, versioned contracts and routes for:

```text
GET  /v1/sync/capabilities
POST /v1/sync/rebootstrap
GET  /v1/sync/rebootstrap/:sessionId
GET  /v1/sync/rebootstrap/:sessionId/chunks/:index
POST /v1/sync/rebootstrap/:sessionId/complete
```

Incremental download must distinguish:

- valid empty page: supplied cursor is within retained history and no later event exists;
- `cursor-expired`: requested cursor is older than the earliest incrementally available position;
- `full-rebootstrap-required`: compatible snapshot exists and no incremental mutation occurred;
- `recovery-unavailable`: no compatible validated snapshot exists.

Do not overload the existing acknowledgement high-water error. Recovery sessions are Account,
Device and Snapshot bound, idempotent, expiring and safe to query after unknown outcomes. Chunk
responses carry index, length and hash; no database/storage credential or public key is returned.

## 7. Local rebootstrap decisions

Authorize additive Drift schema v6 only for durable recovery-session/chunk progress and recovery
format compatibility. Preserve v5 facts, outbox, inbox and cursor through migration tests.

C10-S02 does not implement production replacement of a populated database. It proves:

1. fresh Device C requests recovery after an expired/origin cursor;
2. C downloads and verifies manifest/chunks with resumable identities;
3. C applies snapshot facts and covered cursor to a fresh inactive target database atomically;
4. C catches up events after the snapshot cut;
5. C acknowledges only after catch-up commits;
6. C reopens and matches the Account facts proved for A/B.

If a target has pending, uploading or unknown local submissions, rebootstrap stops with typed
`local-changes-block-rebootstrap`. Do not merge, reset, delete or silently export them. Platform
file swap, Device replacement and collision UX remain later decisions.

## 8. Required decisive proof

The lab must establish:

1. A/B create several synthetic events around a deterministic snapshot cut.
2. Snapshot format 1 builds from a consistent Account view and verifies before publication.
3. An append concurrent with or after the cut remains as a later event.
4. An eligible lagging Device prevents cleanup.
5. After its fixture lease expires, cleanup deletes only old covered/acknowledged events.
6. Download from the deleted range returns typed cursor expiry, never an empty success.
7. Device C resumes an interrupted chunk transfer using the same recovery session.
8. Corrupt/reordered/truncated chunks do not modify facts or cursor.
9. C commits snapshot facts, catches up later events, acknowledges, reopens and matches A/B facts.
10. Existing local Purchase history remains after server cleanup.
11. Pending/unknown local work blocks destructive rebootstrap.
12. Containers, volumes, temporary databases, chunks and generated credentials are removed.

## 9. Failure and security floor

Cover wrong Account, unknown/revoked/expired Device, forged SnapshotId/session, obsolete format,
manifest/chunk corruption, replay/reorder/truncation, interrupted build/download/apply/completion,
snapshot/append race, duplicate workers, premature cleanup, cleanup retry/exhaustion, cursor boundary,
cross-Account RLS, runtime DDL denial and API-unavailable local save.

All new Account tables require RLS plus explicit predicates. Snapshot building/cleanup uses a
separate least-privilege lab worker role. Runtime API cannot publish snapshots or run cleanup.
Diagnostics contain codes, aliases, cursors, counts, timings and hashes only—never fact payloads,
tokens, URLs, passwords or snapshot bytes.

## 10. Semantic boundary

Required truthful phases:

```text
rebootstrap-required → preparing → downloading → downloaded
→ applying → catching-up → recovery-completed
```

No earlier phase may claim `recovered` or `up-to-date`. Server cleanup does not delete autonomous
local history. Application snapshot is not Neon backup. Learner/KANBAN maturity remains unchanged.
Cycle 11 owns all polished placement, progress UI and Device-management presentation.

## 11. MCG-01 and later units

MCG-01 is active human work but no sanitized completion record exists in this repository round.
Codex must not read local provider notes, request credentials, contact Neon or run migration 003
against a provider.

After C10-S02 evidence, Main will reconcile it with sanitized MCG-01 facts. Only new authority may
activate C10-S03 provider probes. Production durations, scheduler/worker hosting, snapshot storage,
auth/enrollment, file replacement and account deletion remain undecided.

## 12. Reports and terminal state

Codex replaces G/H/I with exact paths, commands, counts, faults, deviations and teardown evidence.
Success requires the real local retention/rebootstrap story, not contract-only or direct replay.

```text
C10-S02_LOCAL_RECOVERY_PROVED
MCG-01_EVIDENCE_NOT_RECONCILED
```

If any decisive gate fails, report `C10-S02_PARTIAL` and stop. Do not advance C10-S03.
