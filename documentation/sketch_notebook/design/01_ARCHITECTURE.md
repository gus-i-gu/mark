# 01_ARCHITECTURE.md

> Version: 0.1-recovery
> Status: Recovered Canon
> Persistence Class: Canonical
> Knowledge Class: Design
> Authority: Design Chat [D], reconciled through Main Chat [M]
> Scope: Markei dependency direction, responsibility boundaries, domain relationships, persistence boundaries, desktop composition, and accepted current structural constraints
> Reconciliation Sources: `DEV_STAGE/C_DESIGN.md` and `[M]_STAGE/J_[M]_STAGE.md`

---

# 1. Purpose

This file defines the accepted current architecture of Markei.

It records stable structural knowledge that may be depended upon by future design, implementation, operational, and didactic work. It describes the present system without treating every existing coupling as a desired permanent endpoint.

Unresolved redesign questions, historical evolution, and temporary recovery evidence do not belong here. They remain staged for later design decisions, derived views, checkpoints, or observational records.

---

# 2. System Form

Markei is a local desktop monolith implemented with Python, PySide6, and SQLite.

The application is organized as a layered system inside one deployable desktop program. Its architecture separates presentation, application coordination, persistence behavior, database lifecycle, and persistent resources without introducing distributed services or remote APIs.

The current structural form is:

```text
Desktop Bootstrap
    app/main.py

Desktop Composition and Coordination
    app/desktop/main_window.py

Qt Presentation
    app/desktop/ui/pages/*
    app/desktop/ui/widgets/*

Application Facade and Business Layer
    app/core/services.py

Persistence Facade
    app/core/repository.py

Persistence Lifecycle and Compatibility
    app/core/database.py

Domain Representation and Declared Invariants
    app/core/models.py
    app/core/contracts.py
    app/core/config.py

Bundled Persistence Resources
    app/database/schema.sql
    app/database/seed.sql

Writable Runtime State
    %LOCALAPPDATA%/Markei/market.sqlite
```

---

# 3. Dependency Direction

The accepted runtime dependency direction is:

```text
Desktop Presentation
    ↓
ProductService Application Facade
    ↓
Repository Persistence Facade
    ↓
Database Manager
    ↓
SQLite
```

The following boundaries are canonical:

1. Desktop presentation may request application behavior from the service layer.
2. Desktop presentation must not execute SQL or manipulate SQLite cursors.
3. The service layer may coordinate repositories, domain models, settings, calculations, and application-facing projections.
4. The service layer must not contain SQLite statements or depend on Qt widget objects.
5. Repository owns SQL execution and row-to-model mapping.
6. Database Manager owns database paths, initialization, connection configuration, additive compatibility migration, reset, and closure primitives.
7. Lower persistence layers must not depend on desktop presentation objects.
8. Domain models carry application data but do not execute persistence operations or orchestrate workflows.

The current implementation uses direct concrete construction rather than complete runtime dependency inversion. Pages construct `ProductService`, and `ProductService` constructs `Repository`. This is an accepted description of the present implementation, not a permanent architectural requirement.

---

# 4. Desktop Composition

## 4.1 Bootstrap

`app/main.py` is the desktop bootstrap. It creates the Qt application, creates `MainWindow`, shows the window, and enters the Qt event loop.

The bootstrap remains intentionally thin.

## 4.2 MainWindow

`MainWindow` is the current desktop shell and informal UI coordinator.

It owns:

- page construction;
- tab composition;
- navigation between public surfaces;
- edit routing into Register;
- refresh coordination for Lists and History.

The public desktop surfaces are:

```text
Register
Lists
History
Settings
```

Storage, Shortage, and Market are currently represented as Lists modes:

```text
Storage  → in-house
Shortage → shortage
Market   → to-buy
```

MainWindow knows the concrete pages, and selected pages call MainWindow navigation or refresh methods. This bidirectional UI relationship is accepted as the current coordination pattern.

## 4.3 Page Responsibilities

```text
RegisterPage
    writable receipt and product workflow

ListsPage
    read-only inventory projections and status modes

HistoryPage
    read-only grouped purchase history and analytics

SettingsPage
    history-period settings and store editing

ProductDetailPanel
    read-only rendering of service-prepared product detail data
```

Pages own Qt widgets, event bindings, selection behavior, dialogs, colors, and visual placement. They consume service operations and service-prepared projections rather than persistence commands.

---

# 5. Application Service Boundary

`ProductService` currently functions as the Markei application facade.

Its accepted responsibility groups are:

```text
Commands
    register receipts
    update and delete products
    delete purchases
    save stores
    save settings

Calculated State
    recalculate Product summaries
    calculate duration and consumption
    estimate next purchase
    calculate shelf life and expiration
    calculate price variation

Inventory Projections
    storage / shortage / market classification
    Lists projections

History Projections
    grouped month and week history
    period summaries
    expenditure analytics
    frame comparison

Administration
    settings defaults and validation
    legacy settings compatibility
    store management

Presentation-Oriented Projections
    Lists rows
    History groups
    History analytics
    Product detail views
```

The service owns application meaning and workflow coordination. SQL remains outside it.

Its current breadth is canonical as a description of responsibility concentration. It does not establish that one service class must remain the permanent design. Any later decomposition must preserve workflow ownership, calculated-state ownership, and transaction semantics rather than splitting by file size alone.

---

# 6. Persistence Boundary

## 6.1 Repository

`Repository` is the current complete SQLite persistence facade for the monolith.

It owns:

- SQL execution;
- product, purchase, category, store, setting, and related persistence queries;
- row-to-domain mapping;
- one SQLite connection and cursor per Repository instance;
- mutation commits;
- explicit and context-manager closure.

Repository must not own inventory classification, forecasting, history grouping, application settings interpretation, or Qt presentation behavior.

Repository and service decomposition are coupled decisions because application workflows may span multiple persistence operations.

## 6.2 Database Manager

`app.core.database` owns persistence lifecycle and compatibility behavior:

- resolve bundled resource paths;
- resolve writable user-data paths;
- initialize a new database;
- configure SQLite connections;
- apply current additive compatibility migrations;
- provide and close connections;
- perform destructive reset when explicitly invoked.

Every managed connection is configured with:

```text
PRAGMA foreign_keys = ON
PRAGMA journal_mode = WAL
PRAGMA synchronous = NORMAL
row_factory = sqlite3.Row
```

The current migration mechanism is additive and idempotent for its encoded changes. It is not a general versioned migration framework.

---

# 7. Resource and User-State Separation

Bundled application resources and writable user state are separate architectural responsibilities.

```text
Bundled resources
    app/database/schema.sql
    app/database/seed.sql

Writable user database
    %LOCALAPPDATA%/Markei/market.sqlite
```

A home-directory fallback is used when `LOCALAPPDATA` is unavailable. Frozen execution resolves bundled resources through the frozen runtime base.

The user database is external to installed application files. Application replacement or uninstall must not conceptually redefine writable user data as a replaceable program resource.

Database initialization and compatibility migration belong to the persistence lifecycle boundary, not to desktop presentation.

---

# 8. Domain Model

## 8.1 Active Entities

The active domain representation contains:

```text
Category
Store
Product
Purchase
```

These are slotted dataclasses used to carry application data across layers. They do not execute SQL and do not own application workflows.

## 8.2 Relationship Spine

The accepted active relationship spine is:

```text
Category 1 ─── * Product
Product  1 ─── * Purchase
Store    1 ─── * Purchase, optional
```

The schema also contains Promotion relationships, but Promotion is not promoted here as an active application capability because no complete current domain, service, and desktop workflow has been established.

## 8.3 Purchase

`Purchase` is the historical receipt record and source event for purchase history.

A receipt entry creates a Purchase. Purchases are not edited as ordinary mutable state. An erroneous Purchase may be deleted, after which dependent Product summaries are recalculated.

## 8.4 Product

`Product` persists:

1. editable product identity and metadata;
2. current inventory state;
3. cached analytical summaries derived from Purchase history.

The accepted interpretation is:

```text
Purchase
    historical source record

Product
    editable product identity and metadata
    + persisted current-state and analytical cache
```

This interpretation does not yet establish the hybrid Product role as the permanent long-term domain target. It defines the current responsibility arrangement.

---

# 9. Product Calculated-State Invariant

Editable Product state and calculated Product state are distinct responsibilities.

Editable state includes:

- product identifier;
- category;
- product name;
- brand;
- unit;
- minimum quantity;
- reorder threshold;
- notes.

Calculated state includes:

- current quantity;
- current and previous prices;
- current and previous purchase dates;
- average daily consumption;
- average duration;
- expected next purchase;
- average shelf life;
- expected expiration;
- price delta and percentage.

`ProductService.recalculate_product()` is the centralized producer of calculated Product summary fields.

Calculated fields must not be independently authored by desktop pages or arbitrary repository callers. The validity of the Product cache depends on preserving this ownership rule.

---

# 10. Read-Model Boundary

The service layer may expose platform-neutral, use-case-specific projections so presentation layers do not recreate business calculations.

The current representation flow is:

```text
Database Row
    persistence representation
        ↓
Domain Model
    application entity representation
        ↓
Service Projection / View Model
    use-case-specific representation
        ↓
Qt Widget
    platform-specific rendering
```

Lists, History, analytics, and Product detail currently use dictionary-based projections assembled by `ProductService`.

The dictionaries are accepted for the current MVP. Some labels are formatted in the service, while Qt-specific colors, controls, signals, dialogs, and layout remain in desktop code.

Whether dictionary projections become typed immutable view models, or formatting moves into presenters, remains an unresolved refinement and is not a canonical requirement.

---

# 11. Current Lifecycle Model

Each principal page currently constructs its own service, repository, and SQLite connection chain:

```text
RegisterPage → ProductService → Repository → SQLite connection
ListsPage    → ProductService → Repository → SQLite connection
HistoryPage  → ProductService → Repository → SQLite connection
SettingsPage → ProductService → Repository → SQLite connection
```

Normal MainWindow construction therefore creates four service instances, four repository instances, and four long-lived SQLite connections.

`ProductService` and `Repository` expose explicit close capability. Some pages attempt local cleanup through widget close events.

The canonical current-state interpretation is:

```text
local cleanup capability exists
but application-wide shutdown ownership is implicit
```

This statement does not assert that a runtime resource leak has been proven. Deterministic shutdown behavior requires operational validation.

Per-page resource ownership is accepted as present implementation state, not as a preferred permanent composition principle.

---

# 12. Current Transaction Model

Repository mutation methods commit autonomously.

Receipt registration currently performs multiple persistence commits:

```text
create or update Product
    → commit
insert Purchase
    → commit
recalculate and update Product summary
    → commit
```

Purchase deletion followed by Product-summary recalculation has the same multi-commit characteristic.

The current workflow model is sequentially consistent but not transactionally atomic across the complete user action. Failure after an earlier committed step can leave a partial persisted state.

This is a canonical implementation property and a non-canonical future decision.

No transaction redesign is accepted here. A later design decision must determine whether best-effort sequential consistency is sufficient or whether workflow-level commit/rollback semantics are required.

Transaction ownership belongs at the workflow boundary and cannot be changed safely as an isolated repository split.

---

# 13. Source Contracts

`app/core/contracts.py` records:

- editable and calculated Product field classifications;
- Purchase immutability;
- repository and service abstract surfaces;
- system invariants;
- centralized Product recalculation responsibility.

These contracts are accepted as architectural declarations and partial abstract interfaces.

They are not currently complete runtime dependency-inversion boundaries because concrete services and repositories expose broader capabilities, and concrete dependencies are constructed directly.

Whether contracts become complete substitutable interfaces or remain limited responsibility declarations is unresolved.

---

# 14. Accepted Current Boundaries

The following statements form the stable Design canon for the recovered system:

1. Markei is a layered local PySide6 desktop monolith backed by SQLite.
2. Runtime dependency direction is Desktop → ProductService → Repository → Database Manager → SQLite.
3. Desktop and service code do not execute SQL directly.
4. ProductService is the current broad application facade.
5. Repository is the current broad persistence facade.
6. Database Manager owns initialization, connection configuration, additive compatibility migration, resource paths, user-data paths, and closure primitives.
7. Domain models do not execute persistence operations.
8. Purchase is the historical receipt record.
9. Product persists editable product information plus calculated summaries derived from Purchase history.
10. Product calculated state is centrally produced by the service recalculation workflow.
11. MainWindow composes Register, Lists, History, and Settings and coordinates desktop navigation and refresh.
12. Storage, Shortage, and Market currently exist as Lists modes.
13. Service-produced dictionaries function as UI-facing view models.
14. Bundled SQL resources are separate from the writable user database.
15. Each principal page currently owns its own service/repository/connection chain.
16. Application-wide shutdown ownership is currently implicit.
17. Receipt and purchase-deletion workflows are multi-commit and non-atomic.
18. Source contracts define useful boundaries but do not cover the full concrete runtime surface.

---

# 15. Unresolved Design Decisions

The following are explicitly excluded from accepted target architecture and must remain unresolved until deliberate decision:

1. whether page-local service ownership remains the intended lifecycle model;
2. whether `app/main.py`, MainWindow, or another composition object should own shutdown;
3. whether receipt workflows require transaction atomicity for the MVP;
4. whether ProductService should be retained, renamed, or decomposed;
5. whether Repository should remain one persistence facade;
6. whether contracts should become complete substitutable interfaces;
7. whether dictionary read models should become typed objects;
8. whether formatting remains in ProductService;
9. whether migration moves to an explicit startup and version-ledger system;
10. whether Promotion persistence is active, deferred, incomplete, or stale;
11. whether `pages.order` should be consumed, migrated, or retired;
12. whether Product's editable/cache hybrid role is the accepted long-term domain model.

These questions may appear in the derived model overview and Design checkpoint as unresolved navigation. They must not be presented there as settled truth.

---

# 16. Derivation Contract

Future Design symmetry files must derive from this canon as follows:

```text
01_ARCHITECTURE.md
    canonical accepted architecture
        ↓
14_MODEL_OVERVIEW.md
    derived structural map and relationship summary
        ↓
09_DESIGN_STATE.md
    compact current Design recovery checkpoint
```

`03_DECISION_LOG.md` remains empty until a definite accepted design action, decision, postponement, or recovery milestone is authorized for observational recording.

Derived and checkpoint files must not introduce architectural claims absent from this file. If later evidence contradicts this canon, reconciliation must identify the exact conflict before the canonical file is revised.
