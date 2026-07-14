# J_MAIN_STAGE — Cycle 10 Pre-Neon Protocol Reconciliation

> Sequence: A/B/C investigation → Main synthesis → D/E/F materialization staging
> Unit: C10-S01 — Disposable local synchronization proof
> Status: RECONCILED; D/E/F CODEX AUTHORITY PREPARED; LIVE PROVIDER MUTATION BLOCKED
> Branch: `intermid-cycle-recovery`
> Reconciled investigation HEAD: `ad7107b602bd3820e8ef357491f57b1aab2ba632`
> Cycle 09 implementation baseline: `1d817972aea0229c9f109f236f4d224671927aab`
> Inputs: Cycle 10 A/B/C, repository source/tests, permanent memory and official platform evidence
> Authority: human-supervised Main synthesis

---

<!-- ROUND_MARKER:C10-S01-PRE-NEON-RECONCILIATION-2026-07-14 -->

## 1. Purpose and authority

This J reconciles the Cycle 10 investigations into one bounded Codex unit. D/E/F jointly
authorize implementation only through a disposable local API/PostgreSQL proof. Codex must not
create or mutate Neon, authentication-provider, API-hosting or other external resources.

The ten-phase Cycle 10 plan remains the cycle map. This unit advances phases 01–04 far enough to
prove one local vertical slice and prepares—not executes—MCG-01. Phases 05–10 remain future units.

## 2. Investigation reconciliation

A/B/C agree that the repository already owns useful local preparation: Account/Device rows,
Device sequence, immutable SyncEvent, PendingEvent, cursor scaffold and atomic Purchase/event
persistence. They also agree this is not synchronization.

Blocking gaps before networking are explicit installation ownership, retry/submission identity,
inbox/applied-event deduplication, atomic apply/cursor advancement, authenticated Account/Device
authorization, a server transaction model and executable protocol contracts.

The three domains converge on:

- offline-first Drift remains the operational database;
- Flutter never receives privileged PostgreSQL/Neon credentials;
- a controlled API owns authentication, authorization, validation and transactions;
- Neon-hosted PostgreSQL later owns bounded coordination persistence;
- `purchase.registered` is the only first-slice event;
- EventId, SubmissionId, DeviceSequence and ServerCursor are distinct;
- synchronization is neither backup nor export;
- target-image UI/UX work remains Cycle 11.

## 3. Main decisions for C10-S01

### 3.1 Implementation boundary

Implement and validate against a disposable local PostgreSQL lab. The last successful state must
remain a fully working local-only Flutter application with synchronization disabled.

Codex stops after local proof, G/H/I and a sanitized MCG-01 checklist. Status at exit:

```text
WAITING_FOR_MCG_01
```

### 3.2 API/runtime selection

Use a repository-local TypeScript API targeting Node 24 LTS, Fastify-style JSON-schema routes,
the `pg` driver and forward-only plain SQL migrations. Pin dependencies and lockfile. No ORM,
provider-specific data API or direct Flutter→Postgres connection is authorized.

Use Docker Compose with disposable PostgreSQL 18 for the lab when the host supports it. If the
container runtime is absent or cannot start, Codex must still implement static/unit contracts,
report the host blocker and not substitute a live Neon database.

### 3.3 Authentication boundary

Create an `AuthVerifier` port. C10-S01 may use only an injected fixture adapter in automated tests.
Fixture authentication must be impossible in a deployable/default runtime: it is allowed only
under the test process and loopback-bound lab harness. No authentication provider is selected.

### 3.4 Local identity and schema v5

Add an explicit singleton/current-installation relation that references exactly one current Device
for the Account. Preserve historical Devices and their sequence/event ownership. Remove startup
selection by scanning the earliest UUID as the normal path after migration.

Schema v5 must add bounded durable structures for:

- installation metadata and current Device;
- upload Submission/attempt state with request hash, lease/retry/result fields;
- Submission→Event membership;
- applied inbox EventId/content hash/server cursor;
- atomic cursor/apply bookkeeping.

Backfill the current valid UUID Device deterministically for existing single-installation files.
Ambiguous/no-valid-Device states must fail safely without resetting data.

### 3.5 Protocol identities

- EventId: immutable identity of one domain event.
- SubmissionId: identity of one logical upload request; an uncertain HTTP retry reuses it and
  must receive the same stored result.
- DeviceSequence: monotonic order per enrolled Device.
- ServerCursor: opaque monotonic Account coordination position.
- Inbox identity: AccountId + EventId with content hash and applied cursor.

For the lab, the server requires the exact next DeviceSequence. A gap is a typed rejection. Sequence
epoch/reset/rebootstrap remains unresolved and must not be invented in this unit.

### 3.6 First event and collision policy

Version the executable protocol as `purchase.registered` payload v3. It carries the complete
immutable Purchase aggregate and stable Product, Store and optional reference facts required for
another Device to apply it without querying the origin Device.

- same EventId + same content hash → duplicate-equivalent success;
- same SubmissionId + same request hash → replay stored response;
- same EventId/SubmissionId + different hash → terminal conflict;
- stable Product/code/exact-identity collision with different content → typed quarantine/conflict;
- no automatic merge, edit, deletion or blanket last-write-wins.

Lists remain derived and are rebuilt/invalidated locally after apply.

### 3.7 Local API and server persistence

Implement loopback lab endpoints:

```text
GET  /health/live
GET  /health/ready
POST /v1/sync/submissions
GET  /v1/sync/events?after=<cursor>&limit=<bounded>
POST /v1/sync/acknowledgements
```

Logical server persistence: Accounts, Devices, AccountCursorState, Submissions, Events,
DeviceAcknowledgements and migration ledger. Event append, exact sequence check, per-Account cursor
allocation and stored Submission result commit atomically.

Use separate migration/runtime roles in the local lab. Runtime cannot DDL. Account isolation must
be proven through server-derived identity, scoped transactions/constraints and RLS defense in depth
where the local harness can test it. Never accept AccountId authority from an unverified payload.

### 3.8 Retention and acknowledgement

The local lab records the greatest contiguous cursor applied by each Device. Cursor-only local
application is forbidden; the inbox ledger is required.

Do not implement deletion/TTL in C10-S01. Retain lab events only for the disposable test lifetime.
Snapshots, Device eligibility, expiry, rebootstrap and account deletion must be reconciled before
MCG-01/live retention configuration. A fixed TTL that can strand an offline Device is rejected.

## 4. Required local proof

The minimum executable story is:

```text
two isolated Drift files + one disposable Postgres/API
→ A registers Purchase offline
→ A uploads one v3 event
→ timeout after server commit is retried with same SubmissionId
→ duplicate returns equivalent stored result
→ B downloads after cursor
→ B inbox insert + fact apply + cursor advance commit atomically
→ B acknowledges greatest contiguous cursor
→ both clients reopen
→ Purchase facts and derived Lists compare deterministically
```

Also test wrong Account, unknown/revoked Device, sequence gap, hash mismatch, invalid version,
oversized batch, duplicate/reordered download, crash before/inside/after local apply, serialization
retry, runtime DDL denial and migration failure/no-silent-reset.

## 5. User-visible and privacy semantics

No page redesign is authorized. Application results/error codes may expose truthful minimum states:

`saved-local`, `waiting-upload`, `uploading`, `server-accepted`, `waiting-peer`,
`downloaded-applied`, `duplicate-ignored`, `conflict`, `auth-required`, `device-revoked`,
`cursor-expired`, `protocol-upgrade-required`, `unknown-outcome`.

“Uploaded” must not mean applied elsewhere. “Synchronized” must not mean backup. Logs and reports
contain IDs, codes, counts, timings and hashes only—never credentials or Purchase payloads.

## 6. Manual actions and gates

### Before/during Codex local proof

Human action is required only if the local host asks for it:

1. start an already installed Docker Desktop/Podman service;
2. approve installation of Node 24 LTS or a container runtime if not already available;
3. confirm that disposable local ports/volumes may be used;
4. never provide Neon credentials during C10-S01.

Codex must report a missing host capability instead of silently using a live service.

### MCG-01 — after Codex stops

The human—not Codex—must:

1. create/select an isolated Neon project and development branch;
2. choose region and supported PostgreSQL version;
3. create a disposable database, migration role and least-privilege runtime role;
4. review provider limits/cost/expiry and record teardown ownership;
5. store connection strings only in local/deployment secret storage;
6. run the supplied sanitized migration/runtime privilege probe;
7. return only redacted evidence: aliases, region/version, role names, migration hash, timestamps
   and pass/fail results.

Secret values, URLs, tokens and keys must never enter Git, notebook files, screenshots or chat.
MCG-02/03/04 remain inactive until MCG-01 is reconciled by Main.

## 7. File and scope discipline

- Keep ordinary source/docs near 250 lines; split modules by responsibility.
- Generated Drift output may exceed the limit and remains derived.
- Do not modify the protected Python/PySide6 database or behavior.
- Do not refactor Home/Lists/Purchase/History/Catalogue UI composition.
- Do not implement native sharing, Analytics, Household, production auth, live Neon, deployment,
  background synchronization, edits/deletes, snapshots or public release.
- D/E/F conflicts or an unsafe migration stop implementation before mutation.

## 8. Evidence and reporting

Codex replaces only G/H/I as its notebook evidence. Reports must list files, commands, passes,
failures, skipped gates, dependency versions, provider non-use and the exact final commit/path
inventory. Local lab artifacts and secrets remain untracked.

```text
A/B/C: reconciled
D/E/F: jointly active for C10-S01 only
local disposable protocol proof: authorized
live Neon/API/auth configuration: prohibited
expected terminal gate: WAITING_FOR_MCG_01
```
