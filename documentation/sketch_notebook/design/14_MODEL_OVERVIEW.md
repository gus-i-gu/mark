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
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later.

# 1. Implemented Local Direction

```text
Flutter composition
→ application / Register Purchase
→ independent Dart domain
→ repository boundary
→ Drift local adapter
→ fresh application-private SQLite database
```

```text
Python/PySide6 beta
    preserved
    separate database
    behavioral reference and rollback
```

# 2. Domain Map

```text
Account
├── Device
├── Products
├── Stores
└── Purchases
    └── Purchase Items
        └── reference Product

Purchase registration
├── immutable local purchase.registered event
└── pending queue entry
```

Products support PACKAGED and BULK identity modes. Purchase is multi-item capable even though no full user workflow exists.

# 3. Implemented Ownership

| Surface | Current ownership/evidence |
| --- | --- |
| Flutter app/composition | Generated and analyzable; platform runtime unvalidated |
| Application port | Coordinates Register Purchase |
| Dart domain | Catalogue, Store, Purchase, Item, quantity, money, sync envelope, analytics |
| Drift adapter | Fresh local schema and atomic transaction; implemented/tested |
| Semantic fixtures | Versioned examples; incomplete as wire contracts |
| Generated files | Owned through source schema/configuration and regeneration |
| PySide6 | Preserved accepted beta; not retired |

# 4. Atomic Local Workflow

```text
resolve/create exact Store and Products
→ validate all Items
→ insert Purchase and Items
→ allocate local event metadata
→ insert purchase.registered
→ enqueue pending event
→ commit once
```

Invalid Item validation rolls back every write. Local facts and pending events survive close/reopen. No network work exists inside the transaction.

# 5. Implemented Representation

```text
Quantity
    MASS → KG
    VOLUME → L
    COUNT → UNIT
    six-decimal microunits
    fractional COUNT rejected

Money
    ISO currency code
    integer minor units

Analytics
    stable identifier + version registry
    raw facts preserved
```

# 6. Evidence Classification

**Implemented and locally tested:** domain boundaries, Drift fresh creation, catalogue structures, aggregate transaction, rollback, persistence/reopen, queue preparation, minimal analytics.

**Generated but host-unvalidated:** Android, Windows, and iOS targets.

**Not implemented:** purchase UI, authentication, API, Postgres/Neon, actual synchronization, second-device convergence, import, parity.

# 7. Defects and Open Boundaries

```text
device sequence
    likely reset/reuse defect
    monotonic ordering not established

normalization
    accented/Unicode behavior unsafe or unknown
    v1 remains provisional

Product identifier
    deterministic UUID-shaped candidate
    RFC/cross-language contract absent

fixtures
    useful examples
    incomplete protocol schema

migration
    fresh creation tested
    upgrade/recovery and legacy import absent

Store
    exact-name reuse only
    no deduplication/branch identity
```

# 8. Next Route Comparison

```text
Route 1 — recommended first
    fix sequence/Unicode
    strengthen fixtures
    minimal Flutter Purchase UI
    local projection/history
    close/reopen
    Windows + Android execution

Route 2 — later candidate
    complete wire contract
    TypeScript API
    disposable Postgres
    idempotency/sequence/cursor
    second-device and account isolation
```

Route 1 is a Design recommendation, not materialization authority.

# 9. Recovery Boundary

Flutter test success establishes local behavior only. It does not validate platform lifecycle, responsive composition, distributed synchronization, cloud architecture, or product parity.
