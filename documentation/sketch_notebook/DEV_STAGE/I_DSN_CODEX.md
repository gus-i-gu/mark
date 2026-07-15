# I_DSN_CODEX — C10-S01B Design Evidence

Sequence: FLX-ORD-01
Role: Codex materialization evidence
Source stages: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`

## Dependency Direction

Flutter domain/application owns sync ports and typed results. Drift implements local outbox and remote apply. HTTP is isolated in `HttpSyncTransport`. The TypeScript API owns Fastify routes and `pg` transactions. PostgreSQL remains disposable loopback lab infrastructure. Flutter never connects directly to PostgreSQL, and normal app composition remains sync-disabled.

## Protocol, Hash And Cursor

Protocol event: `purchase.registered`, payload version `3`.

Payload now contains closed immutable Store, Product snapshots, Purchase, Items, quantity and Money facts; non-null Person/Payment IDs are rejected by the local remote applier until snapshots exist. The v3 schema recursively closes nested objects with `additionalProperties: false`.

Hashing rule: canonical UTF-8 JSON with recursively sorted object keys, SHA-256 lowercase hex over event content excluding `contentHash`. Dart and TypeScript parity is proven by the shared fixture hash `9c658e0666f9d8acf4f5bb599b2b351e96737d2828cc56f3ada43eda61025453`.

Cursor rule: origin is `c10b:0`; emitted cursors are versioned opaque tokens `c10b:<integer>`. Clients store/echo tokens and local application decodes only to verify contiguous page order.

## Local Application

`DriftRemoteEventApplier` validates Account, type/version, content hash and cursor continuity before mutation. `RemotePurchaseFactWriter` inserts or reuses equivalent Store/Product/Purchase/Item facts in one Drift transaction with inbox insertion and cursor advancement. Duplicate inbox identities with same hash are duplicate-equivalent; content conflicts stop without cursor advancement. No outbound SyncEvent/PendingEvent is created for remote apply.

`greatestContiguousAppliedCursor` now reads committed `sync_state.account_cursor`, not maximum inbox cursor.

## Server And Migration

`002_coordination_hardening.sql` adds Account/Device composite FKs, indexes, migration ledger entry, revoked `PUBLIC` privileges, least-privilege runtime grants and RLS policies. `001_init.sql` was unchanged.

Upload, download and acknowledgement routes authenticate every call, retain explicit Account predicates, set transaction-local Account/Device context and run in bounded serializable retry for SQLSTATE `40001`/`40P01` only, at most three attempts.

Upload enforces exact next DeviceSequence, SubmissionId/request-hash replay, EventId/content-hash duplicate equivalence and Account-scoped event lookup. Download returns all Account events ordered by server cursor, including the requesting Device. Acknowledgement rejects cursors beyond the Account high-water mark and persists monotonic Device cursor without deletion semantics.

## Fixture Auth Containment

Normal `main.ts` uses `RefusingAuthVerifier`. Fixture claims are only constructed by tests or `src/lab.ts`; the lab entrypoint requires explicit Account/Device environment claims and refuses non-loopback binding. No production authentication or Device enrollment was implemented.

## System Topology

The decisive harness creates two isolated Drift files, starts disposable loopback PostgreSQL 18, applies migrations and seed data through migrator authority, starts separate loopback Fastify child processes with synthetic fixture claims for Device A and B, uploads through Flutter HTTP, simulates dropped response after server commit, retries same SubmissionId, downloads through Flutter HTTP, applies complete remote facts, acknowledges, reopens both Drift files and compares stable Purchase/Item facts.

## Deviations And Deferred Work

The implemented proof covers the decisive vertical slice and focused fault locks. It does not expand every requested malformed/oversized/cross-Account/deadlock failure into an exhaustive standalone matrix. It also does not add Person/Payment reference snapshots beyond rejecting bare non-null IDs. Neon, deployment, production authentication and later MCG gates were not started.
