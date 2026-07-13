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
# Cycle 07 Sprint 05 Operational Checkpoint

> Branch: `cycle-07-mobile-preparation`
> Inspected head: `ca53097b346ae42b216188dabc56a6eef45b051c`
> Codex evidence: `DEV_STAGE/G_OPS_CODEX.md`
> Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md` §24
> Preparation staging: `DEV_STAGE/A_OPERATIONAL.md`

## Implemented and validated

```text
Cycle 06 Python/PySide6 beta: accepted and protected
Flutter/Dart SDK: H: path selected and doctor-evidenced
Android Studio/SDK 36/tool components: installed
Android licenses/toolchain: doctor-validated
application ID/label: com.gusigu.markei / Markei
persistent app-private Device UUID: implemented and tested
Flutter tests: 27 passed
debug APK: built and identity-inspected
API-36 emulator: booted
APK: installed and launched
app-private Drift database: runtime-observed
Purchase registration: human-confirmed
Windows Flutter build: passed
Python regressions: 5 passed
```

Repository truth supports the source, test, identity, APK, emulator, database, Windows, and Python claims. The local event queue remains synchronization preparation only.

## Partial, contradictory, and deferred

Partial: force-stop/relaunch and database inspection provide meaningful persistence evidence, but the required keyboard, Back, rotation, background/resume, text-scale, staged-state, and human-visible History-after-restart matrix is incomplete. One emulator is evidenced; no physical device is validated.

Contradiction: G says `devtools_options.yaml` was not committed; repository truth shows it added. It is harmless empty-extension configuration, but intentional ownership is unresolved and deferred to bounded hygiene.

Deferred: physical device, Android release/signing/upgrade/backup/accessibility/Play Store, iOS, authentication, TypeScript API, Postgres/Neon, real synchronization, central catalogue, legacy import, editing/deletion, and PySide6 retirement.

## Current operational decision

A supplemental Android lifecycle checklist is required before ordinary Sprint 05 closure because J §23 acceptance explicitly named those behaviors. The checklist is evidence-first and authorizes no source change. Main may instead narrow closure explicitly and carry every missing gate as debt.

Use “Purchase registration”; “Purchase upsert” is unsupported.

## Host recovery

The selected Flutter SDK, Android SDK root, component versions, system image, and AVD are recorded in G/Record. Exact storage cost is unknown because it was not measured. Preserve the environment until the lifecycle supplement closes; cleanup requires inventory, explicit authority, and named-component removal.

## Authority and next route

No additional implementation is active. Read `04_TODO.md` for the lifecycle checklist and hygiene/recovery gates. If the checklist exposes a defect, stop for Main routing. After evidence closure, Main may close Sprint 05 and select the next objective.

## Recovery pointers

1. This checkpoint — compact current truth.
2. `04_TODO.md` — active lifecycle, hygiene, and recovery gates.
3. `12_OPERATIONAL_MODEL.md` — stable evidence/recovery rules.
4. Latest `11_OPERATIONAL_RECORD.md` entry — command and contradiction chronology.
5. G — Codex transcript; J §24 — Main classification; A/D — intended gates.
