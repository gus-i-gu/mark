# C_DESIGN.md

> Status: Functional Design Stage
> Knowledge State: Staged / Observational / Unpromoted
> Authority: Design Chat [D]
> Scope: Structural recovery of the current Markei implementation for later Main synthesis and Sketch Notebook repopulation
> Branch inspected: `sketch-notebook-recovery`

---

# 1. Review Objective

Recover the current functional and structural picture from implementation evidence before commit-oriented analysis.

Initial inspection scope:

```text
app/core/
app/database/
app/desktop/
app/main.py
```

This report does not promote architecture into canonical design memory. It stages implementation observations, inferred responsibility boundaries, drift candidates, and unresolved design questions.

---

# 2. Current Structural Picture

```text
app/main.py
    ↓ creates
app.desktop.main_window.MainWindow
    ↓ composes and coordinates
Desktop pages and widgets
    ↓ each page creates
app.core.services.ProductService
    ↓ creates
app.core.repository.Repository
    ↓ owns one SQLite connection and cursor
app.core.database
    ↓ initializes, configures, migrates, and connects
app/database/schema.sql
    ↓ defines
SQLite persistence model
```

Observed dependency direction:

```text
Desktop UI → ProductService → Repository → Database Manager → SQLite
```

Domain dataclasses and contracts live in `app/core/` and are consumed by service and repository layers.

---

# 3. Core Layer

## 3.1 Domain models

`app/core/models.py` defines four persistence-oriented dataclasses:

- `Category`
- `Store`
- `Product`
- `Purchase`

Current model character:

- Models contain data plus small semantic helpers.
- They do not execute SQL or orchestrate workflows.
- `Product` combines editable identity/metadata, current inventory state, and cached analytical summary.
- `Purchase` represents the historical ledger and is described as immutable except for deletion.
- Relationships use identifiers rather than nested aggregate objects: `Product.category_id`, `Purchase.product_id`, and `Purchase.store_id`.

Design interpretation:

- The model is an anemic but coherent desktop-MVP domain model.
- `Product` behaves as a persisted projection/cache derived partly from the purchase ledger, not solely as independent source data.
- `Purchase` is the historical source event for inventory and price calculations.

## 3.2 Contracts

`app/core/contracts.py` declares domain field classifications, repository/service abstract bases, and system invariants.

Positive boundary:

- It explicitly distinguishes editable Product fields from calculated Product fields.
- It identifies Purchase as an immutable ledger.
- It states that calculated Product summaries have a single service-owned recalculation path.

Structural tension:

- `RepositoryContract` exposes only a subset of the methods used by `ProductService` and implemented by `Repository`.
- `ServiceContract` covers central mutation workflows but not the expanding read-model, settings, store, history-grouping, and presentation services.
- Concrete `ProductService` directly constructs concrete `Repository`, so the abstract repository contract is not currently used as an inversion boundary.

Current classification:

```text
contracts.py = architectural declaration and partial interface specification
not yet = complete dependency-inversion mechanism
```

## 3.3 Service cohesion

`app/core/services.py` contains one large `ProductService` responsible for:

- product and purchase workflows;
- product summary recalculation;
- inventory/list classification;
- history grouping and date-boundary rules;
- store editing;
- settings validation and persistence;
- UI-facing row/read-model construction.

Positive boundary:

- SQL and SQLite knowledge remain outside the service.
- Business workflow and derived-state calculation are centralized rather than duplicated in pages.
- UI pages request application-level operations rather than issuing database commands.

Cohesion risk:

- The class has become the application facade for several distinct capability groups.
- Product lifecycle, receipt registration, stores, settings, inventory projections, history projections, and formatting-oriented read models all accumulate in one module/class.
- The name `ProductService` no longer describes its full responsibility.

Staged design conclusion:

```text
Current service cohesion is acceptable for a small monolith,
but responsibility growth has crossed the point where explicit capability boundaries should be documented before further expansion.
```

No immediate split is promoted here. Candidate future boundaries include receipt/product commands, inventory projections, history projections, and settings/store administration.

## 3.4 Repository cohesion and connection ownership

`app/core/repository.py` is the concrete SQLite adapter.

Observed responsibilities:

- SQL execution;
- row-to-domain mapping;
- CRUD and query operations across products, purchases, categories, stores, and settings;
- transaction commits after mutations;
- ownership of one connection and cursor per Repository instance;
- delegation of connection creation/configuration/migration/closure to `app.core.database`.

Positive boundary:

- SQL is concentrated in the repository.
- Database lifecycle primitives are separated into the database manager.
- Service methods do not manipulate cursors.

Cohesion and lifecycle risks:

- One repository spans all persistence concerns, matching the single service facade but increasing class breadth.
- Every `ProductService()` creates a new `Repository()`, and every Repository creates a connection and cursor.
- Desktop pages instantiate services independently, therefore the current window creates multiple long-lived SQLite connections.
- Connection closure depends on each service/repository being closed correctly; composition-level ownership is not explicit in the inspected entry point or MainWindow.
- Transaction scope is repository-method-local because mutations commit individually. Multi-step service workflows therefore require careful review to determine whether they are atomic or only sequentially consistent.

---

# 4. Database Layer

## 4.1 Database manager

`app/core/database.py` owns:

- bundled-resource path resolution;
- user-writable data path resolution;
- first-run schema initialization;
- SQLite connection configuration;
- idempotent compatibility migrations;
- connection creation and closure;
- reset behavior.

Current packaging boundary:

```text
read-only bundled schema:
    application resource directory

writable database:
    %LOCALAPPDATA%/Markei/market.sqlite
```

This is a sound separation between installed application resources and user state.

## 4.2 Initialization and migration

`connect()` performs both connection acquisition and migration:

```text
connect request
→ initialize database if absent
→ open SQLite connection
→ configure PRAGMAs and row factory
→ apply idempotent migrations
→ return connection
```

Design consequence:

- Repository construction has side effects beyond obtaining a connection.
- Since each page creates a service/repository, migration checks run repeatedly during desktop composition.
- This is operationally safe when migrations remain idempotent, but composition and schema-evolution responsibilities are coupled to ordinary dependency construction.

## 4.3 Persistent relationships

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

- Product deletion cascades to Purchases.
- Product identifier updates cascade to Purchases.
- Category deletion behavior is not declared.
- Store deletion behavior is not declared.
- Promotions exist structurally but were not observed in the inspected service/domain path.

Drift candidate:

- `promotions` is present in schema but absent from the inspected domain models, repository excerpt, contracts, and desktop composition picture.
- It should be classified later as planned persistence, dormant implementation, or stale structure.

---

# 5. Desktop Layer and Composition

## 5.1 Application entry point

`app/main.py` is a thin desktop bootstrap:

- creates `QApplication`;
- creates `MainWindow`;
- shows the window;
- starts the Qt event loop.

This is an appropriate entry-point boundary, but it does not currently construct or inject shared application dependencies.

## 5.2 MainWindow responsibility

`app/desktop/main_window.py` currently owns:

- page construction;
- tab composition;
- page navigation;
- edit routing from list views to Register;
- refresh coordination after mutations.

Design interpretation:

- `MainWindow` is both the visual shell and an informal application coordinator.
- Pages hold back-references to MainWindow for cross-page interaction.
- This works for the desktop MVP but creates bidirectional UI knowledge:

```text
MainWindow knows concrete pages
Pages know MainWindow navigation/refresh surface
```

This is a manageable local coupling, but the coordinator responsibility should be made explicit in canonical design before adding more navigation flows.

## 5.3 Page-to-service ownership

Inspected pages instantiate their own `ProductService` directly.

```text
RegisterPage → ProductService()
ListsPage    → ProductService()
other pages likely follow the same composition convention
```

Consequences:

- UI depends on a concrete application service rather than an injected interface/facade.
- Services and database connections are duplicated per page.
- Shared transaction/lifecycle ownership is absent.
- Testing a page requires replacing construction behavior or monkeypatching rather than passing a test service.
- MainWindow cannot centrally close all repositories unless pages expose and coordinate that lifecycle.

Staged architectural candidate:

```text
app/main.py or MainWindow should eventually become the explicit desktop composition root:
construct shared application dependencies once,
inject them into pages,
and own shutdown.
```

This is a design candidate, not an approved refactor instruction.

## 5.4 Read-model boundary

`ListsPage` consumes dictionaries returned by `ProductService.get_lists_view()` and renders labels/status fields without querying persistence directly.

Positive boundary:

- UI rendering is separated from SQL and primary calculation logic.
- The service already exposes desktop-oriented read models.

Unresolved boundary:

- Some formatting semantics are produced by the service while colors and widget behavior remain in the page.
- This is a reasonable presentation split, but the exact boundary between domain calculation, application read model, and desktop presentation has not yet been canonically documented.

---

# 6. Current Functional Architecture

```text
Presentation
    app/main.py
    app/desktop/main_window.py
    app/desktop/ui/pages/*
    app/desktop/ui/widgets/*

Application / Business
    app/core/services.py

Persistence Adapter
    app/core/repository.py

Persistence Lifecycle and Compatibility
    app/core/database.py

Domain Representation and Declared Rules
    app/core/models.py
    app/core/contracts.py
    app/core/config.py

Bundled Persistence Resources
    app/database/schema.sql
    optional seed/migration-related resources

External Runtime State
    %LOCALAPPDATA%/Markei/market.sqlite
```

---

# 7. Stable-Looking Boundaries

The following implementation boundaries appear deliberate and coherent enough to serve as candidates for later canonical recovery:

1. Desktop UI does not execute SQL.
2. Service owns workflows, validation, calculation, and application-facing projections.
3. Repository owns SQLite statements and row mapping.
4. Database manager owns connection configuration, initialization, migration, and resource/user-data paths.
5. Domain models do not perform persistence.
6. Purchase is the historical ledger; Product stores editable state plus cached current/analytical summary.
7. MainWindow composes pages and coordinates desktop navigation/refresh.

These remain staged observations until reconciled by Main Chat and promoted through the methodology.

---

# 8. Architectural Risks and Drift Candidates

## High relevance

- Implicit connection ownership caused by per-page service construction.
- No explicit application shutdown path observed for closing all page-owned repositories.
- ProductService breadth and naming no longer match its full application-facade role.
- RepositoryContract and ServiceContract are incomplete relative to concrete implementation.
- Multi-step workflow atomicity is uncertain because repository mutations commit individually.

## Medium relevance

- MainWindow/page bidirectional references create an informal coordinator pattern.
- Database migration occurs during every repository construction.
- Product combines editable domain data and cached projections; recalculation invariants must remain strictly service-owned.
- Read models are dictionaries rather than explicit immutable view-model types.

## Structural drift candidates

- `promotions` table appears disconnected from the inspected active domain path.
- `pages.order` is persisted but desktop tab construction is currently hard-coded.
- Contracts describe canonical architecture in source comments, but notebook design canon is empty; implementation declarations must be reconciled rather than copied blindly.

---

# 9. Unresolved Design Questions

1. Should the desktop use one shared application service/repository connection, or one repository per bounded service with explicit lifecycle ownership?
2. Where should database initialization and migration occur: repository construction, application bootstrap, or a dedicated startup phase?
3. Does `ProductService` remain the intentional application facade, or should capability-specific services be introduced?
4. Should contracts be completed and used for dependency injection, simplified into protocols, or treated only as architectural documentation?
5. What transaction boundary is required for receipt registration and product-summary recalculation?
6. Is Product intentionally both aggregate state and persisted projection cache?
7. Is the promotions table active roadmap structure or stale schema?
8. Should MainWindow remain the desktop coordinator, or should page communication move through signals/application coordination?
9. Should UI read models remain dictionaries or become explicit dataclasses/protocol objects?
10. Which persisted settings are authoritative and consumed by current desktop behavior?

---

# 10. Recommended Next Design Recovery Pass

Before commit-oriented historical analysis, inspect the remaining implementation surfaces needed to complete the structural picture:

```text
app/core/services.py
    focused workflow and transaction sections

app/core/repository.py
    lifecycle helpers, mappings, settings, and close behavior

app/desktop/ui/pages/history_page.py
app/desktop/ui/pages/settings_page.py
app/desktop/ui/widgets/*

packaging/bootstrap files
    for shutdown and resource composition
```

Then compare recent commits only to explain how the current boundaries emerged and to distinguish deliberate architecture from accidental accumulation.

---

# 11. Stage Classification

```text
Canonical design knowledge: none promoted
Derived design knowledge: none promoted
Design checkpoint: still empty
Observational design history: still empty
Functional design stage: populated by this report
Repository files changed: C_DESIGN.md only
Application implementation changed: no
```
