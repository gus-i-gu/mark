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
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker preserves earlier planning; this segment is the rebuildable current Design map after Sprint 04.

# 1. Current System Map

```text
Protected Python/PySide6 beta
    Desktop UI → ProductService → Repository → Cycle 06 SQLite
    separate database; behavior reference and rollback

Flutter local shared client
    Presentation
    → application commands/query ports
    → independent Dart domain
    → local repository adapters
    → Drift schema v2
    → application-private SQLite

Deferred distributed path
    Flutter sync coordinator
    → authenticated custom TypeScript API
    → Neon Postgres
```

# 2. Local Composition

```text
MarkeiComposition
├── LocalDatabase.appPrivate()
├── PurchaseRegistrationRepository → LocalPurchaseRepository
├── CatalogueQueryRepository       → LocalQueryRepository
├── PurchaseHistoryRepository      → LocalQueryRepository
├── local Account placeholder
└── local Device placeholder
```

The placeholders are suitable for the bounded local slice, not accepted production identity or authentication.

# 3. Domain and Identity Map

```text
Account
├── Device
├── Products
│   ├── immutable internal Product ID
│   ├── user-designed Product code
│   ├── display name / brand
│   └── normalization-v2 exact identity facts
├── Stores
└── Purchases
    └── one or more Purchase Items
        └── immutable Product reference

Purchase registration
├── purchase.registered event
└── pending-event queue entry
```

A future central Product UUID is not present. Exact matching is account-scoped; fuzzy matching warns only.

# 4. Authoritative Facts and Projections

| Authoritative local facts | Derived/rebuildable views |
| --- | --- |
| Product internal ID, code, display and normalized identity | similarity warnings |
| Store reference and display name | catalogue lists |
| Purchase occurrence, currency, total | recent Purchase history |
| Purchase Item quantity and line total | normalized prices and later analytics |
| event envelope, payload, device sequence | synchronization status/projections |
| raw purchase observations | versioned analytical results |

JSON Schema validates structural contract shape. Dart domain tests validate cross-field meaning.

# 5. Atomic Registration

```text
insert account/sync metadata if needed
→ insert Device only when absent
→ resolve Store and exact Products
→ validate Purchase and Items
→ persist Purchase and Items
→ allocate next Device sequence
→ persist immutable event
→ enqueue pending event
→ commit once
```

Account/device/sequence uniqueness guards local ordering. Network activity is absent and pending events are not proof of synchronization.

# 6. Local Persistence and Migration

```text
schema v2
├── account-private Product-code and exact-identity uniqueness
├── account/device/sequence event uniqueness
├── display and normalized Product facts
├── Purchase aggregate tables
├── pending events and sync metadata
└── migration ledger

v1 → v2
├── preserves Product IDs and Purchase references
├── adds Product code/display fields
├── backfills reviewable legacy codes
└── records the upgrade with runtime UTC time
```

One upgrade path is validated. General downgrade, corruption recovery, desktop import, and broad migration policy remain open. Fresh-create ledger time is still source-fixed.

# 7. Evidence Boundary

**Validated:** formatting, analysis, 21 Flutter tests, schema validation, device sequencing, v1→v2 migration/reopen, atomic registration, five Python regressions, Windows build, and Windows startup smoke.

**Implemented but incompletely accepted:** minimal Purchase/History UI, multi-item staging, app-private composition, Product code/display model, normalization v2, JSON Schema v2 examples.

**Blocked or host-unvalidated:** manual UI/accessibility acceptance, Android build (SDK absent), Android execution, iOS build/run.

**Deferred:** authentication, API/Neon, actual synchronization, second-device convergence, central catalogue identity, desktop import, editing/deletion, Product-code lifecycle, Store branch identity, and PySide6 retirement.

# 8. Next Design Evidence Route

```text
manual Windows workflow and accessibility review
→ resolve local account/device lifecycle beyond placeholders
→ define Store and Product-code lifecycle gaps as needed
→ retain rollback and database isolation
→ only then stage the bounded synchronization/API evidence slice
```

The TypeScript/Neon direction remains accepted planning, not implemented architecture.

# 9. Recovery Pointers

- Canonical rules: `design/01_ARCHITECTURE.md`, sections 16–18.
- Rationale and chronology: `design/03_DECISION_LOG.md`, Event 16.
- Current checkpoint: `design/09_DESIGN_STATE.md`.
- Materialization evidence: `DEV_STAGE/I_DSN_CODEX.md`.
- Main resolution: `[M]_STAGE/J_[M]_STAGE.md`, section 21.
