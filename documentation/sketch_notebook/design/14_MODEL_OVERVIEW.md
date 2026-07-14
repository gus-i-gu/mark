# 14_MODEL_OVERVIEW.md

> Version: 0.5-cycle07-sprint03-unit01
> Status: Active Derived Overview
> Persistence Class: Derived
> Knowledge Class: Design
> Authority: Design Chat [D]
> Canonical Source: `design/01_ARCHITECTURE.md`
> Scope: Compact responsibility and evidence map after the local Flutter foundation

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above preserves earlier planning; this segment is the rebuildable current Design map after Sprint 05.

# 1. Current System Map

```text
Protected Python/PySide6 beta
    separate Cycle 06 SQLite; behavior reference and rollback

Windows / Android Flutter hosts
    → shared Flutter entrypoint and composition
    → presentation
    → application commands/query ports
    → independent Dart domain
    → local repository adapters
    → Drift schema v2
    → application-private SQLite

Deferred distributed path
    Flutter sync coordinator
    → authenticated TypeScript API
    → Neon Postgres
```

Android/Kotlin hosts Flutter only; it owns no business or persistence semantics.

# 2. Identity Ownership

| Identity | Owner and current state |
| --- | --- |
| Android application ID | `com.gusigu.markei`; installation/update/sandbox identity |
| Android label | `Markei`; presentation metadata |
| Account | `local-account`; provisional prototype placeholder |
| Device | database-owned UUID v4; created before composition completes |
| Device sequence | `devices.next_sequence`; allocated inside Purchase transaction |
| Product | immutable internal ID + user Product code + normalized identity facts |
| Purchase / Item | immutable local aggregate identities and facts |
| Event | UUID plus Account/Device/sequence envelope |
| central/cloud identity | deferred |

# 3. Device Bootstrap

```text
main() awaits MarkeiComposition.appPrivate()
→ open LocalDatabase.appPrivate()
→ LocalDeviceIdentityRepository.loadOrCreateDeviceId(local-account)
→ insert Account if absent
→ find reusable UUID v4 Device or create one
→ inject DeviceId into shared composition
→ event-producing commands become available
```

Tests establish creation, close/reopen reuse, distinct fresh-database IDs, sequence 1→2 continuity, and historical non-UUID preservation.

# 4. Prototype Debt

Current selection scans the first 20 Account Devices by creation time and chooses the earliest UUID v4.

```text
acceptable now
    bounded single-installation prototype

not acceptable for synchronization
    no explicit current-installation relation
    first-20 truncation
    ambiguous multiple-UUID selection
    no dedicated concurrent-bootstrap uniqueness
```

Future requirement: one installation metadata record references exactly one Device, bootstrap is idempotent under concurrency, and historical Devices remain separate.

# 5. Persistence and Schema

Schema v2 already owns Account, Device, sequence, Product, Store, Purchase/Items, Event, pending queue, sync metadata, and migration ledger. Sprint 05 changed bootstrap behavior, not persisted shape, so no schema migration was required.

Historical non-UUID Device rows remain untouched. Android runtime observed the SQLite database inside `com.gusigu.markei` application-private storage. Local queue/event preparation remains distinct from synchronization.

# 6. Purchase Transaction

```text
resolve/create Store and Product references
→ validate Purchase and Items
→ persist aggregate
→ allocate sequence for injected Device
→ persist purchase.registered event
→ enqueue pending event
→ commit once
```

# 7. Functional Scaffold

```text
Purchase / History navigation
+ SafeArea
+ scrollable phone-width form
+ staged BRL total
+ atomic registration
+ visible History
```

These are implemented functional-scaffold decisions, not final UI/UX. SafeArea owns inset avoidance; staged total exposes aggregate feedback. Broad visual hierarchy, accessibility, navigation refinement, and design-system work remain later.

# 8. Evidence Boundary

**Validated:** 27 Flutter tests, analysis, debug APK, identity badging, API 36 emulator boot/install/launch, Android sandbox database observation, Device bootstrap/sequence tests, human Purchase registration, Windows build, and five Python tests.

**Partial:** Android lifecycle/ergonomics, keyboard, Back, rotation, background/resume, larger text, and accessibility.

**Deferred:** physical device, release signing/store, backup policy, authentication, API/Neon, synchronization, central catalogue, import, broad UI/UX, iOS, and PySide6 retirement.

# 9. Configuration Boundary

```text
architectural
    stable application/sandbox identity
    shared dependency direction
    database-owned Device and sequence ownership
    app-private persistence

operational configuration
    compile/target SDK 36
    NDK, Java, Gradle
    Android Studio, emulator, SDK tools
```

# 10. Next Design Route

```text
optional bounded Android lifecycle/ergonomics supplement
→ Main closes Sprint 05 evidence
→ choose later UI/UX formalization or another accepted milestone
→ resolve explicit installation-Device invariant before real synchronization
```

# 11. Recovery Pointers

- Canonical: `design/01_ARCHITECTURE.md`, sections 16–19.
- Observational: `design/03_DECISION_LOG.md`, Event 17.
- Checkpoint: `design/09_DESIGN_STATE.md`.
- Evidence: `DEV_STAGE/I_DSN_CODEX.md`.
- Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md`, §24.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# Intermid Cycle Current Design Map

## 1. Active client topology

```text
Flutter presentation
→ application commands and query ports
→ independent Dart domain
← local repository/query adapters
→ Drift schema v2 / app-private SQLite
```

The protected Python/PySide6 beta remains isolated and recoverable. Local event/pending structures remain synchronization preparation, not synchronization.

## 2. Staged Purchase edit ownership

```text
_PurchasePageState
├── _editingKey             line/edit identity
├── _editingReference       retained ProductReference
├── _editingProductLabel    retained display label
└── editable controls       rebuild Item values only
```

Edit entry captures key, reference, and label. Edit save rebuilds package count, purchased quantity/unit, and line total while reusing Product identity and label. Save, edited-line removal, and successful registration clear edit state. The Product dropdown does not own staged-line identity.

## 3. Evidence classification

| Claim | State and evidence |
| --- | --- |
| Existing-Product edit retains Product ID | implemented and directly regression-validated |
| Existing Product is not duplicated | directly regression-validated |
| Edited Item values are persisted | directly regression-validated |
| NewProductReference follows the same retained-reference path | implemented structural support; no separate regression |
| Focused/full Flutter behavior | 7 focused and 32 total tests recorded as passing |
| Source quality gate | Flutter analysis recorded clean |
| Platform/restart/migration behavior | outside this correction's evidence boundary |

## 4. Current identity and lifecycle boundaries

- Product identity remains carried by `ProductReference`, distinct from editable Item values.
- Draft and edit state remain mounted-session presentation state.
- Registered Purchase facts remain owned by the atomic local repository transaction.
- Drift schema remains version 2.
- Event/pending ownership remains local preparation only.
- Store, submission-attempt, installation–Device, draft-persistence, and distributed identities remain unresolved separately.

## 5. Deferred Design decisions

```text
schema v3
Store identity/normalization
durable SubmissionId/idempotency
installation–Device lifecycle
persisted drafts
measured query/index policy
backup/export/restore identity
authentication and authorization
API/Neon
upload/download, cursor, convergence, synchronization
```

None is implied by the edit correction.

## 6. Recovery pointers

- Canonical: `design/01_ARCHITECTURE.md`, section 20.
- Observational: `design/03_DECISION_LOG.md`, Event 18.
- Checkpoint: `design/09_DESIGN_STATE.md`, current Intermid Cycle segment.
- Functional assessment: `DEV_STAGE/C_DESIGN.md`.
- Controlling Design stage: `DEV_STAGE/F_DSN_STAGE.md`.
- Materialization evidence: `DEV_STAGE/I_DSN_CODEX.md`.
- Main reconciliation: `[M]_STAGE/J_MAIN_STAGE.md`, sections 20–24.
