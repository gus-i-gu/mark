# 10_OPERATIONAL_STATE.md

> Version: Cycle 07 Sprint 02 Flutter checkpoint 0.6
> Status: Active operational checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Operational
> Branch: `cycle-07-mobile-preparation`
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Active work source: `operational/04_TODO.md`
> Reconciliation source: `[M]_STAGE/J_[M]_STAGE.md`

---

# 1. Current Cycle State

Cycle 06 remains accepted and closed for the controlled Windows primary beta.

Cycle 07 Sprint 02 planning and A/B/C Flutter restaging are complete. Main reconciliation is complete, and permanent-domain reconciliation is active. No application code, Flutter project, TypeScript API, database schema, authentication integration, Neon infrastructure, or D/E/F/G/H/I work has been authorized or produced.

```text
Cycle 06: accepted and closed
Cycle 07 Sprint 02 planning: complete
Flutter A/B/C restaging: complete
Main reconciliation: complete
Operational permanent-memory reconciliation: active/completed by this checkpoint
implementation authorization: none
D/E/F: postponed
next evidence target: Sprint 03 preparation
```

# 2. Accepted Planning Decisions

Accepted for planning and permanent-domain classification:

- Flutter/Dart is the shared Windows/Android/iOS client basis.
- TypeScript is favored for the synchronization API/protocol harness.
- Neon Postgres is favored as managed shared persistence.
- Every installation remains local-first with application-private storage.
- Account data is owned by immutable account UUID, not email.
- The first beta uses an account-private reusable catalogue.
- Purchase is an atomic aggregate containing one or more Purchase Items.
- One append-only `purchase.registered` event contains immutable item lines.
- Retry identity uses event UUID; one device uses UUID plus monotonic sequence; downloads use an opaque account-scoped cursor.
- Downloaded events and cursor advancement commit together locally.
- Raw facts remain authoritative; projections and Dart analytics are rebuildable and versioned.
- PySide6 and the original Cycle 06 database remain protected until evidenced parity and human/Main acceptance.
- No embedded Python runtime or client IPC bridge belongs in the Flutter client.

Accepted planning does not mean implemented, packaged, validated, deployed, or production-ready.

# 3. Provisional and Untested Decisions

The following are preferred experiment candidates or definitions requiring fixtures:

- Drift as the first Flutter SQLite candidate;
- `sqflite_common_ffi` as the retained persistence comparison;
- `flutter_secure_storage` as a credential-storage candidate;
- exact Flutter project layout and state/navigation choices;
- exact TypeScript API framework, Node runtime, hosting platform, and migration tool;
- authentication provider;
- Neon role, schema, branching, pooling, limits, and recovery behavior;
- deterministic Product UUID derivation and normalization versioning;
- exact decimal scale/ranges, fractional COUNT policy, and currency metadata;
- RLS as defense in depth;
- exact parity threshold for PySide6 retirement.

No compatibility claim for these candidates is validated. Windows and Android require empirical build/run evidence. iOS is explicitly unvalidated until macOS/Xcode execution.

# 4. Next Evidence Target — Sprint 03 Preparation

The next bounded evidence unit should prepare, then later execute only if D/E/F authorize:

```text
pinned Flutter/Dart + TypeScript/Node environments
→ canonical Dart/TypeScript JSON fixtures
→ fresh isolated local databases for simulated devices A/B
→ exact normalization and advisory-only similarity behavior
→ packaged/bulk catalogue identity
→ atomic Purchase + Items + pending event
→ close/reopen and projection/analytics rebuild
→ local TypeScript API + disposable Postgres
→ retry / sequence-gap / cursor / bootstrap / restart / account-isolation gates
→ Windows and Android build/run
→ Cycle 06 database isolation
→ iOS later through macOS/Xcode
→ non-production Neon only after local protocol proof
```

# 5. Scope and Recovery

No framework initialization, tool installation, database access, infrastructure provisioning, authentication account creation, deployment, source modification, or D/E/F/G/H/I activity is authorized.

Recovery route:

```text
1. Read this checkpoint.
2. Read 04_TODO.md for Sprint 03 preparation gates.
3. Read 11_OPERATIONAL_RECORD.md for chronology and candidate evidence boundaries.
4. Read J sections 17–18 for Main planning acceptance.
5. Read 12_OPERATIONAL_MODEL.md for stable technology-independent rules.
```

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
# Cycle 07 Sprint 04 Operational Checkpoint

> Branch: `cycle-07-mobile-preparation`
> Inspected implementation head: `32898f56f76895dc0f23d72cd132bcc24830e740`
> Evidence: `DEV_STAGE/G_OPS_CODEX.md`
> Staging: `DEV_STAGE/A_OPERATIONAL.md`
> Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md` §21

## Current truth

```text
Cycle 06 Python/PySide6 beta: accepted, validated, protected
Sprint 03 Flutter foundation: implemented and locally validated
Flutter/Dart: 3.44.6 / 3.12.2 recorded
Drift local schema: version 1 implemented
analysis/tests: passed (9 Flutter, 5 Python)
atomic Purchase/Items/event/queue: locally validated
Windows target: generated, build/run blocked
Android target: generated, SDK/device absent
iOS target: generated, host-unvalidated
Sprint 04 implementation: not started
```

## Accepted Sprint 04 planning

- local shared-client workflow precedes the synchronization harness;
- new internal Product IDs use UUID v4 and remain distinct from required account-private user Product codes;
- normalization v2 preserves display text and uses Unicode NFKC with versioned identity rules;
- contracts advance additively to `shared_beta/v2`, JSON Schema Draft 7, and readable examples;
- Drift advances through a rehearsed v1→v2 migration without rewriting existing Product references;
- Windows build/run is required;
- Android tooling installation is not authorized; attempt a build only if tooling already exists;
- PySide6 and ordinary Cycle 06 data remain protected.

## Defective, blocked, and deferred

Defective/unimplemented: Device upsert can reset sequence; no sequence uniqueness; no user Product code/display fields; Unicode-safe normalization absent; schemas absent; UI remains a foundation label; migration recovery untested.

Blocked/host-unvalidated: Windows requires the Visual Studio Native Desktop workload; Android SDK/device is absent; iOS requires macOS/Xcode.

Deferred: authentication, TypeScript API, Postgres/Neon, real synchronization, central catalogue mapping, code editing/retirement, legacy import, production packaging, iOS validation, and PySide6 retirement.

## Next valid route and authority

Main may write new D/E/F for sequence correction, schema v2 migration, Product identity separation, normalization v2, v2 schemas/examples, minimal Flutter Purchase UI/history, Windows setup/build/run, conditional Android build, Python regression, and Cycle 06 isolation. No implementation or host mutation is authorized by this checkpoint.

## Recovery pointers

1. Read this checkpoint first.
2. Read `04_TODO.md` for ordered executable gates.
3. Read `12_OPERATIONAL_MODEL.md` for stable safety rules.
4. Read the latest entry in `11_OPERATIONAL_RECORD.md` for chronology.
5. Read G for command evidence, A for contrary findings, and J §21 for accepted resolution.
