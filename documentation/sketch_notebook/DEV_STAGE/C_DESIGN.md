# C_DESIGN.md

> Status: Functional Design Stage
> Knowledge State: Staged / Observational / Unpromoted
> Authority: Design Chat [D]
> Scope: Consolidated structural recovery of the current Markei implementation for later Main synthesis and Sketch Notebook repopulation
> Branch inspected: `sketch-notebook-recovery`

---

# 1. Review Objective

Recover the current functional and structural picture from implementation evidence before commit-oriented historical analysis.

Inspected surfaces:

```text
app/main.py
app/core/
    contracts.py
    models.py
    services.py
    repository.py
    database.py
app/database/
    schema.sql
app/desktop/
    main_window.py
    ui/pages/register_page.py
    ui/pages/lists_page.py
    ui/pages/history_page.py
    ui/pages/settings_page.py
    ui/widgets/product_detail_panel.py
```

This report does not promote architecture into canonical design memory. It stages implementation observations, inferred responsibility boundaries, drift candidates, and unresolved design questions.

---

# 2. Consolidated Structural Picture

```text
app/main.py
    ↓ creates
QApplication + MainWindow
    ↓ composes and coordinates
RegisterPage / ListsPage / HistoryPage / SettingsPage
    ↓ each page constructs independently
ProductService
    ↓ constructs
Repository
    ↓ owns
one SQLite connection + cursor
    ↓ delegates lifecycle to
app.core.database
    ↓ initializes / configures / migrates / connects
app/database/schema.sql
    ↓ defines
SQLite persistence model
```

Observed dependency direction:

```text
Desktop UI
    → ProductService
        → Repository
            → Database Manager
                → SQLite
```

Supporting types flow inward from `app.core.models` and `app.core.contracts`, but runtime dependency inversion is incomplete because concrete classes construct their own concrete dependencies.

---

# 3. Domain and Persistence Model

## 3.1 Domain entities

`app/core/models.py` defines:

- `Category`
- `Store`
- `Product`
- `Purchase`

Current model character:

- Models are persistence-oriented dataclasses with small semantic helpers.
- Models do not execute SQL or orchestrate application workflows.
- Relationships are identifier-based rather than nested object graphs.
- `Purchase` is the immutable historical ledger, except that erroneous records may be deleted.
- `Product` combines editable metadata, current inventory state, and cached analytical summaries derived from purchases.

Design interpretation:

```text
Purchase = historical source record
Product  = editable aggregate identity + persisted current-state projection/cache
```

This dual role is coherent only while recalculation ownership remains centralized and all write paths preserve the invariant.

## 3.2 Persistent relationships

`app/database/schema.sql` defines:

```text
Category 1 ─── * Product
Product  1 ─── * Purchase
Store    1 ─── * Purchase (optional)
Product  1 ─── * Promotion
Store    1 ─── * Promotion (optional)
Settings key ─ value
```

Important semantics:

- Product deletion cascades to purchases.
- Product identifier updates cascade to purchases.
- Category and Store deletion behavior is not explicitly declared.
- Promotions exist structurally but are not represented by an inspected domain model or active service/UI workflow.

Staged drift candidate:

```text
promotions table = dormant roadmap structure, incomplete feature, or stale schema
classification unresolved
```

---

# 4. Declared Architecture Contracts

`app/core/contracts.py` declares:

- editable versus calculated Product fields;
- Purchase immutability;
- repository and service abstract bases;
- system invariants;
- service-owned Product-summary recalculation.

Positive architectural value:

- It records important responsibility boundaries close to implementation.
- It identifies calculated Product fields as protected derived state.
- It distinguishes historical Purchase truth from current Product summary.

Runtime mismatch:

- `RepositoryContract` exposes only a subset of concrete repository behavior.
- `ServiceContract` excludes stores, settings, history projections, analytics, list projections, and product-view projections now provided by `ProductService`.
- `ProductService` constructs `Repository` directly rather than receiving a contract implementation.
- Desktop pages construct `ProductService` directly rather than receiving an application-facing contract.

Current classification:

```text
contracts.py
    = useful architectural declaration
    + partial abstract interface
    ≠ active complete dependency-inversion boundary
```

This is not necessarily a defect for the current desktop monolith, but the distinction must be preserved when repopulating design canon.

---

# 5. Application Service Cohesion

## 5.1 Actual ProductService responsibility

`ProductService` now owns several capability groups:

```text
Commands
    register receipt
    update/delete product
    delete purchase
    save store
    save settings

Domain calculations
    recalculate Product summary
    duration and consumption calculations
    next-purchase estimation
    shelf-life and expiration estimation
    price variation

Inventory projections
    storage / shortage / market classification
    unified Lists read model

History projections
    month/week grouping
    period summaries
    expenditure analytics
    frame comparison

Administration
    settings defaults and validation
    legacy setting adaptation
    store management

Presentation-oriented models
    labels
    platform-neutral dictionaries
    Product detail views
```

Positive boundary:

- SQL remains outside the service.
- Business calculations are centralized.
- Desktop pages consume application operations and prepared read models.
- History grouping and analytics are not duplicated inside widgets.

Cohesion finding:

```text
ProductService is no longer merely a product service.
It currently behaves as the Markei application facade.
```

The service remains workable for the small monolith, but its name and declared contract no longer describe its actual breadth.

## 5.2 Read-model boundary

The service emits dictionary-based read models for:

- Lists rows;
- History month/week groups;
- History analytics;
- Product detail views.

The desktop layer retains widget-specific presentation concerns:

- tables and trees;
- colors;
- text placement;
- event connections;
- user feedback dialogs.

The service currently also emits formatted labels such as money, status, cycle, date, and remaining-time strings.

Staged interpretation:

```text
Domain calculation
    → application projection
        → partially formatted platform-neutral dictionary
            → Qt-specific rendering
```

This is a reasonable MVP boundary. It is not yet clear whether formatting belongs intentionally in the application facade or should eventually move to desktop presenters/view models.

---

# 6. Repository Cohesion and Transaction Model

## 6.1 Repository responsibility

`Repository` owns:

- SQL execution;
- row-to-domain mapping;
- products, purchases, categories, stores, settings, and some promotion queries;
- one SQLite connection and cursor;
- commit helpers;
- lifecycle closure;
- context-manager support.

`app.core.database` owns connection acquisition and closure mechanics.

Positive boundary:

- Persistence mechanics are centralized.
- Service code does not manipulate cursors.
- Models remain independent of SQLite.

Breadth finding:

```text
one Repository = complete persistence facade for the monolith
```

This mirrors the single application-service facade. Splitting either layer independently would require deliberate aggregate and transaction ownership decisions.

## 6.2 Proven transaction behavior

Repository mutation methods commit internally.

Observed receipt workflow:

```text
get Product
→ create Product OR update Product     [commit]
→ insert Purchase                      [commit]
→ recalculate Product
→ update Product summary               [commit]
```

Therefore receipt registration is sequentially consistent but not atomic.

Possible partial states after interruption or exception include:

```text
Product created without Purchase
Product metadata updated without Purchase
Purchase inserted before Product summary refresh
Purchase deleted before recalculation completes
```

This is now a confirmed architectural property, not merely an uncertainty.

Required future decision:

- accept best-effort sequential consistency for the local MVP; or
- introduce service-owned transaction boundaries for workflows that must succeed or roll back as one unit.

A transaction change cannot be made safely as a repository-only refactor because current repository methods commit autonomously.

---

# 7. Database Lifecycle and Resource Boundaries

## 7.1 Resource versus user state

```text
Bundled read-only resource
    app/database/schema.sql

Writable runtime state
    %LOCALAPPDATA%/Markei/market.sqlite
```

This is a sound installed-application boundary.

## 7.2 Connection acquisition side effects

`connect()` performs:

```text
check database existence
→ initialize from schema when absent
→ open connection
→ configure PRAGMAs and row factory
→ apply idempotent migrations
→ return connection
```

Consequences:

- Repository construction also performs startup compatibility work.
- Every page-owned service creates a repository and triggers migration checks.
- Ordinary dependency construction and schema-evolution responsibility are coupled.

The current behavior is viable because migrations are idempotent, but startup ownership is implicit.

---

# 8. Desktop Composition and Coordination

## 8.1 Entry point

`app/main.py` is intentionally thin:

- create `QApplication`;
- create `MainWindow`;
- show it;
- enter the Qt event loop.

It does not construct shared application dependencies or coordinate application shutdown.

## 8.2 MainWindow

`MainWindow` owns:

- page construction;
- tab composition;
- navigation helpers;
- edit routing into Register;
- refresh coordination for Lists and History.

Current relationship:

```text
MainWindow knows concrete pages
Pages know selected MainWindow methods
```

This forms an informal desktop coordinator with bidirectional UI coupling.

The pattern is manageable for the current application but should be explicitly named before more cross-page behavior is added.

## 8.3 Per-page service ownership

Confirmed page ownership:

```text
RegisterPage → ProductService → Repository → connection
ListsPage    → ProductService → Repository → connection
HistoryPage  → ProductService → Repository → connection
SettingsPage → ProductService → Repository → connection
```

Consequences:

- four service facades and four long-lived repository connections are created during normal window composition;
- UI tests cannot naturally inject substitutes;
- startup migration checks repeat;
- application resource ownership is distributed among child widgets;
- no single composition object has an authoritative list of resources to close.

## 8.4 Local closeEvent behavior

HistoryPage and SettingsPage explicitly close their own services in `closeEvent`, swallowing cleanup exceptions.

This partially mitigates resource leakage but does not establish reliable application-level ownership because:

- child-page close event delivery depends on Qt widget lifecycle behavior;
- cleanup policy is duplicated across pages;
- swallowed exceptions remove cleanup evidence;
- MainWindow does not expose a single shutdown sequence;
- closure consistency across all pages remains an implementation convention rather than a composition invariant.

The correct interpretation is therefore:

```text
cleanup exists locally
but shutdown ownership remains structurally implicit
```

## 8.5 Settings and refresh coupling

SettingsPage edits both persisted application settings and Store entities, then calls `MainWindow.refresh_pages()`.

MainWindow refreshes Lists and History, while Settings refreshes itself locally.

This demonstrates that MainWindow already acts as a small application event coordinator, but through direct method calls rather than signals or an event abstraction.

## 8.6 ProductDetailPanel

`ProductDetailPanel` is a read-only Qt renderer for a service-prepared dictionary.

Positive boundary:

- It has no service or repository dependency.
- It does not calculate business state.
- It renders identity, summary, store-price, and recent-purchase projections.

This widget is the clearest example of the desired presentation boundary:

```text
service prepares view data
widget renders view data
```

---

# 9. Current Functional Architecture

```text
Desktop Bootstrap
    app/main.py

Desktop Composition / Coordination
    app/desktop/main_window.py

Qt Presentation
    app/desktop/ui/pages/*
    app/desktop/ui/widgets/*

Application Facade / Business Layer
    app/core/services.py

Persistence Facade
    app/core/repository.py

Persistence Lifecycle / Compatibility
    app/core/database.py

Domain Representation / Declared Invariants
    app/core/models.py
    app/core/contracts.py
    app/core/config.py

Bundled Persistence Definition
    app/database/schema.sql

External Runtime State
    %LOCALAPPDATA%/Markei/market.sqlite
```

---

# 10. Stable-Looking Boundaries for Later Promotion Review

The following appear deliberate and coherent enough to become candidates for canonical design recovery after Main reconciliation:

1. Desktop UI does not execute SQL.
2. Application service owns workflows, validation, calculations, and UI-consumable projections.
3. Repository owns SQLite statements and row mapping.
4. Database manager owns connection configuration, initialization, migration, and resource/user-data location.
5. Domain models do not perform persistence.
6. Purchase is the historical ledger.
7. Product stores editable state plus a cached summary recalculated from Purchase history.
8. MainWindow composes pages and coordinates navigation and refresh.
9. ProductDetailPanel-style widgets render prepared view data without business or persistence dependencies.
10. Bundled application resources are separated from writable user data.

These are still staged observations, not canonical architecture.

---

# 11. Architectural Risks and Drift Candidates

## High relevance

- Receipt registration and purchase deletion workflows are not transactionally atomic.
- Connection ownership is distributed through per-page concrete service construction.
- Application shutdown has local cleanup attempts but no explicit composition-level owner.
- ProductService breadth and naming no longer match its application-facade role.
- Contracts do not cover the concrete service/repository surface they appear to describe.

## Medium relevance

- MainWindow and pages form bidirectional direct-call coupling.
- Database migration runs during every repository construction.
- Product mixes editable aggregate state and cached analytical projection.
- Read models are untyped dictionaries with partially application-owned formatting.
- Cleanup exceptions are swallowed by page close handlers.

## Structural drift candidates

- `promotions` exists in persistence but lacks a recovered active domain/application/UI path.
- `pages.order` is persisted but tab composition remains hard-coded.
- Source comments call `contracts.py` canonical architecture while notebook design canon is empty; source declarations require reconciliation, not direct promotion.
- Current visible tabs are Register, Lists, History, and Settings, while persisted default page order still names Register, Storage, Shortage, Market, History, and Settings.
- Legacy Storage/Shortage/Market concepts now appear consolidated inside the Lists page, creating naming drift between settings/defaults and desktop composition.

---

# 12. Unresolved Design Decisions

1. Should desktop composition use one shared application facade, or bounded services with explicitly owned repositories/connections?
2. Should `app/main.py`, MainWindow, or a dedicated application container own startup and shutdown?
3. Where should initialization and migration occur: connection acquisition or a dedicated startup phase?
4. Is non-atomic receipt registration acceptable for the local MVP?
5. If atomicity is required, should transaction ownership belong to service workflows, a unit-of-work abstraction, or repository workflow methods?
6. Is Product intentionally both editable aggregate and persisted projection cache?
7. Should ProductService be renamed as the application facade or decomposed by capability?
8. Should contracts become complete runtime interfaces/protocols or remain architectural declarations?
9. Should MainWindow remain the direct desktop coordinator or should pages communicate through signals/events?
10. Should read-model dictionaries become explicit immutable view-model types?
11. Should presentation formatting remain in service projections or move to desktop presenters/widgets?
12. Is `promotions` active roadmap structure or stale schema?
13. Should `pages.order` be consumed, migrated to current tab semantics, or retired?
14. Should local page close handlers be replaced by one authoritative application shutdown sequence?

---

# 13. Recommended Transition to Commit-Oriented Analysis

The present implementation picture is now sufficiently complete for historical inspection.

Commit-oriented analysis should be limited to explaining:

- when the monolithic ProductService acquired settings, history analytics, and read-model responsibilities;
- when Storage/Shortage/Market became unified under Lists;
- whether per-page service construction was deliberate or inherited;
- whether contracts were intended for active dependency inversion or documentation;
- whether promotions and `pages.order` are active roadmap commitments or abandoned structures;
- whether packaging work introduced an intended application lifecycle boundary not yet reflected in desktop composition.

Historical commits must not override current implementation evidence. They should explain design intent and classify accumulation, drift, and deliberate architecture.

---

# 14. Stage Classification

```text
Canonical design knowledge: none promoted
Derived design knowledge: none promoted
Design checkpoint: still empty
Observational design history: still empty
Functional design stage: consolidated
Repository files changed: C_DESIGN.md only
Application implementation changed: no
Ready for commit-oriented design analysis: yes
```
