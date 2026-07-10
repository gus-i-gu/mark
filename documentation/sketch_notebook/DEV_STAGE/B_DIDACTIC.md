# Didactic Structural Recovery Report

> Status: Active functional stage
> Role: Didactic Chat [A]
> Branch reviewed: `sketch-notebook-recovery`
> Scope: Structural learning recovery from `app/core/`, `app/database/`, and `app/desktop/`
> Knowledge state: Staged, evidence-backed, non-canonical
> Constraint: No application source, methodology file, Main-owned file, Codex report, or other functional stage file was modified.

---

## 1. Recovery Purpose

The permanent didactic domain is empty in this recovery branch, so the current repository implementation must be treated as implementation evidence from which didactic knowledge can later be reconstructed.

This report does not promote concepts into `02_KANBAN.md`, derive final glossary entries, or establish a completed learning checkpoint. It stages a current structural picture and classifies the concepts that the repository presently teaches.

The review followed the requested order:

```text
app/core/
↓
app/database/
↓
app/desktop/
```

Commit-oriented interpretation is intentionally deferred until after this structural baseline.

---

## 2. Recovered Package Picture

The currently evidenced application structure is:

```text
main.py
↓
app/main.py
↓
app/desktop/
    main_window.py
    ui/pages/
    ui/widgets/
↓
app/core/
    services.py
    repository.py
    database.py
    models.py
    contracts.py
    config.py
↓
app/database/
    schema.sql
    seed.sql (optional runtime resource when present)
↓
SQLite user database
```

The dominant dependency direction is:

```text
Desktop presentation
↓
ProductService
↓
Repository
↓
Database connection manager
↓
SQLite
```

Domain models and abstract contracts support that chain without owning presentation or SQL execution.

This structure is not a strict framework-enforced clean architecture. It is a practical layered desktop application whose boundaries are expressed through package placement, imports, docstrings, abstract base classes, and method responsibilities.

---

## 3. `app/core/` — Recovered Learning Model

### 3.1 Core package responsibility

`app/core/` is the platform-neutral application center. It contains the domain entities, business workflows, persistence contracts, concrete SQLite adapter, database lifecycle functions, and configuration constants used by the desktop presentation.

The package teaches that “core” does not mean one homogeneous layer. It currently groups several related but distinct responsibilities:

```text
Domain description       → models.py
Responsibility contract  → contracts.py
Business interpretation  → services.py
Persistence adaptation   → repository.py
Connection lifecycle     → database.py
Shared constants/paths   → config.py
```

The package boundary is therefore broader than the service layer. A future learner should distinguish package cohesion from class-level responsibility.

### 3.2 Domain models

`models.py` defines `Category`, `Store`, `Product`, and `Purchase` as slotted dataclasses.

Recovered distinction:

```text
Model
≠ database table implementation
≠ SQL mapper
≠ business workflow
```

The models describe application entities and carry data across layers. `Product` combines editable metadata, current inventory state, and cached analytical summaries. `Purchase` represents an append-oriented receipt event and is documented as immutable except for deletion.

Important concept candidates:

- domain entity;
- dataclass as structured data carrier;
- editable state versus event record;
- persistent identity;
- cached summary versus source event;
- optional value;
- property as derived object-level query.

### 3.3 Contracts

`contracts.py` defines abstract responsibility surfaces rather than implementations.

It contains:

- field classifications for `Product` and `Purchase`;
- `RepositoryContract`;
- `ServiceContract`;
- system invariants.

Recovered distinction:

```text
Contract
= declares expected behavior and responsibility

Concrete class
= supplies executable behavior
```

`Repository` inherits `RepositoryContract`; `ProductService` inherits `ServiceContract`. This makes the architecture partially explicit, although the concrete service currently constructs the concrete repository directly rather than receiving it through dependency injection.

Concept candidates:

- interface contract;
- abstract base class;
- invariant;
- implementation versus declaration;
- substitutability;
- dependency inversion as an intended but only partially realized boundary.

### 3.4 ProductService

`services.py` is the business orchestration layer. It coordinates repository operations, validates input, applies calculations, interprets settings, and assembles UI-facing read models.

Its declared boundary is:

```text
ProductService knows:
- workflows
- rules
- calculations

ProductService does not know:
- SQL syntax
- SQLite cursors
- physical schema operations
```

This is the clearest platform-neutral boundary in the current system. Desktop pages import `ProductService`, not `Repository` or `sqlite3`.

The service also appears to own presentation-neutral dictionaries used as read models, such as rows returned to list views. This is didactically important:

```text
Domain model
≠ view model
```

A `Product` represents application state. A list-row dictionary represents a particular presentation-ready projection of that state, including formatted labels and status fields.

Concept candidates:

- application service;
- orchestration;
- validation boundary;
- business rule;
- read model;
- platform-neutral presentation data;
- fallback/default configuration;
- legacy configuration compatibility.

### 3.5 Repository

`repository.py` is the concrete SQLite persistence adapter. It owns SQL statements, query execution, transaction commits, and row-to-model conversion.

Its constructor opens one connection and one cursor:

```text
Repository()
↓
connect()
↓
configured sqlite3.Connection
↓
repository cursor
```

The repository persists entities, retrieves entities, returns selected query rows for service-level interpretation, and delegates physical connection creation/configuration to `database.py`.

Recovered distinction:

```text
Repository owns persistence operations.
Database manager owns connection creation and schema lifecycle.
Service owns business meaning.
```

The repository therefore is not “the database.” It is an adapter through which application operations are translated into SQL.

Concept candidates:

- Repository pattern;
- persistence adapter;
- SQL boundary;
- row mapping;
- parameterized query;
- transaction commit;
- connection-scoped repository;
- raw query projection versus domain entity result.

### 3.6 Connection ownership

The current connection model is instance-oriented:

```text
Each ProductService
owns one Repository
which owns one SQLite connection and cursor.
```

Desktop pages construct their own `ProductService` instances. Consequently, multiple pages may hold separate long-lived SQLite connections during one application session.

This is not automatically incorrect. SQLite supports multiple connections, and WAL mode is enabled. However, it creates a precise learning question:

```text
Who owns the connection lifetime?
```

The repository opens the connection. Page-level `closeEvent()` methods attempt to close their service, but page widgets normally live inside the main window and may not receive independent close events in the same way as top-level windows. The implementation therefore exposes a distinction between declared cleanup support and proven application-wide shutdown ownership.

This should be staged as an unstable concept rather than a confirmed defect until shutdown behavior is reviewed operationally.

Concept candidates:

- resource ownership;
- connection lifetime;
- deterministic cleanup;
- widget lifetime versus application lifetime;
- long-lived connection;
- WAL concurrency;
- ownership chain.

---

## 4. `app/database/` — Recovered Learning Model

### 4.1 SQL resources versus runtime database

`app/database/schema.sql` is a bundled source resource. The live `market.sqlite` database is placed in the user data directory rather than inside the installed application resources.

Recovered distinction:

```text
schema.sql
= version-controlled creation specification

market.sqlite
= mutable user state
```

`database.py` resolves bundled resources separately from writable user data:

```text
RESOURCE_DATABASE_DIR
→ bundled schema/seed resources

USER_DATABASE_DIR
→ %LOCALAPPDATA%/Markei

DATABASE_PATH
→ writable market.sqlite
```

This separation is central to both packaging and persistence learning.

### 4.2 Schema structure

The SQL schema currently defines:

- `categories`;
- `products`;
- `stores`;
- `purchases`;
- `settings`;
- `promotions`;
- indexes for product name, purchase product, and purchase date.

The main relational spine is:

```text
Category 1 ── * Product
Product  1 ── * Purchase
Store    1 ── * Purchase
Product  1 ── * Promotion
Store    1 ── * Promotion
```

`purchases.product_id` uses `ON UPDATE CASCADE` and `ON DELETE CASCADE`, teaching that relational actions can preserve referential consistency when a product identifier changes or a product is removed.

Concept candidates:

- relational schema;
- primary key;
- foreign key;
- referential integrity;
- cascading update/delete;
- index;
- one-to-many relationship;
- durable fact versus cached summary.

### 4.3 Initialization versus migration

The database manager explicitly separates two lifecycle operations.

Initialization:

```text
missing database
↓
create user directory
↓
create SQLite file
↓
execute schema.sql
↓
optionally execute seed.sql
↓
commit and close
```

Migration:

```text
existing database connection
↓
inspect current schema
↓
add missing columns/tables/default settings
↓
commit
```

Recovered distinction:

```text
Initialization creates a new persistence state.
Migration evolves an existing persistence state.
```

`connect()` combines existence checking, connection opening, configuration, and migration. Thus every normal connection path also acts as a schema-evolution checkpoint.

The migration strategy is currently imperative and idempotent rather than version-table driven. Functions such as `ensure_column`, `ensure_settings_table`, and `ensure_default_setting` inspect or insert only when needed.

Concept candidates:

- initialization;
- migration;
- idempotence;
- schema introspection;
- additive migration;
- production seed policy;
- compatibility with existing user data.

### 4.4 SQLite connection configuration

Every connection created through the manager is configured with:

```text
foreign_keys = ON
journal_mode = WAL
synchronous = NORMAL
row_factory = sqlite3.Row
```

These settings teach separate concerns:

- referential rules must be enabled per connection in SQLite;
- WAL affects journaling and concurrent access behavior;
- synchronous mode trades durability guarantees against performance;
- `sqlite3.Row` allows name-based row access and supports mapping to models.

The phrase “database configuration” should therefore not be collapsed into one concept. It includes integrity, journaling, durability/performance, and row representation.

---

## 5. `app/desktop/` — Recovered Learning Model

### 5.1 Presentation adapter

`app/desktop/` is the PySide6 presentation package. It translates user interaction into service calls and renders service results into widgets.

The entry chain is:

```text
app/main.py
↓
QApplication
↓
MainWindow
↓
page widgets
↓
Qt event loop
```

`MainWindow` owns the public tabs:

- Register;
- Lists;
- History;
- Settings.

Storage, Shortage, and Market are internal views selected within the unified Lists page rather than separate top-level page classes.

### 5.2 Page responsibility

The reviewed pages import `ProductService` directly.

Example boundary:

```text
ListsPage
↓ asks ProductService for get_lists_view(...)
↓ receives presentation-ready row dictionaries
↓ creates QTableWidgetItem objects
```

The UI decides widget construction, selection behavior, colors, and navigation. The service decides business status and row content.

This is a useful adapter boundary:

```text
Service returns meaning.
Desktop decides rendering.
```

`RegisterPage` is documented as the writable purchase-entry page and uses `ProductService` for application operations. `MainWindow` coordinates page navigation and refreshes, but does not execute SQL or calculate inventory state.

Concept candidates:

- presentation adapter;
- event-driven UI;
- widget composition;
- signal/slot;
- navigation coordinator;
- read-only view versus writable workflow;
- rendering responsibility;
- page refresh coordination.

### 5.3 View models

The Lists page consumes dictionaries containing values such as:

- `product_name`;
- `quantity_label`;
- `price_label`;
- `delta_price_label`;
- `cycle_label`;
- `remaining_label`;
- `status`;
- `status_label`.

These dictionaries are neither raw database rows nor complete domain models. They are view models assembled for a presentation use case.

Recovered distinction:

```text
Database row
→ persistence representation

Domain model
→ application entity representation

View model
→ presentation-specific representation
```

The current view-model type is an untyped dictionary. This keeps the boundary platform-neutral but leaves field names as runtime string contracts. The learner should understand both the benefit and the fragility of that choice.

Concept candidates:

- view model;
- projection;
- formatting boundary;
- dictionary data contract;
- platform neutrality;
- typed versus untyped boundary object.

---

## 6. Recovered Functional Picture

The current application behavior can be summarized as:

```text
Register receipt or edit product
↓
Desktop page collects user values
↓
ProductService validates and interprets workflow
↓
Repository persists or retrieves records
↓
Database manager supplies configured/migrated connection
↓
SQLite stores categories, products, purchases, stores, settings, promotions
↓
ProductService recalculates summaries and assembles read models
↓
MainWindow refreshes Lists and History
```

The core durable distinction is:

```text
Purchase
= historical source event

Product summary fields
= recalculated/cached current interpretation
```

Settings are stored as key/value persistence facts. ProductService applies defaults, validation, and compatibility interpretation before exposing them to the UI.

---

## 7. Structural Strengths Evidenced

1. Desktop pages depend on `ProductService`, not directly on SQL or SQLite.
2. Repository and database-manager responsibilities are explicitly separated.
3. Domain models do not execute SQL.
4. New database initialization and existing database migration are distinct functions.
5. Bundled resources and writable user data use separate paths.
6. SQLite integrity and row behavior are configured centrally.
7. List presentation consumes service-created read models rather than constructing business status from raw rows.
8. System invariants are documented in a contract module.

These are implementation observations, not yet canonical didactic claims.

---

## 8. Structural Tensions And Learning Questions

The following are staged as questions or unstable concepts, not defects:

### 8.1 Concrete dependency construction

`ProductService` inherits an abstract contract but directly constructs `Repository()`.

Learning question:

```text
Does a contract provide practical substitutability
when the concrete dependency is constructed internally?
```

This introduces dependency injection and test substitution as future concepts.

### 8.2 Multiple service and connection instances

Each page appears to instantiate its own service, and each service creates its own repository and connection.

Learning question:

```text
Should connection ownership belong to each page,
a shared application service container,
or a shorter operation scope?
```

No architectural correction is proposed in this report.

### 8.3 Shutdown ownership

Pages contain local cleanup attempts, but application-wide shutdown behavior has not yet been structurally proven.

Learning question:

```text
Which object receives the final responsibility
for closing all service/repository resources?
```

### 8.4 Untyped view models

Dictionary-based view models preserve presentation independence but depend on string-key agreement.

Learning question:

```text
When does a flexible dictionary become a fragile implicit contract?
```

### 8.5 Migration maturity

The migration layer is additive and idempotent but has no evidenced explicit migration version ledger.

Learning question:

```text
At what project complexity does schema inspection
need to become ordered versioned migration history?
```

### 8.6 Broad core package

`app/core/` contains domain, service, persistence, and database lifecycle responsibilities.

Learning question:

```text
When is one cohesive package sufficient,
and when should internal layers become separate subpackages?
```

---

## 9. Proposed Didactic Reconstruction Spine

The repository supports the following initial learning progression:

```text
1. Python package and module structure
↓
2. Responsibility boundary
↓
3. Domain entity and dataclass
↓
4. Contract versus implementation
↓
5. Application service and business orchestration
↓
6. Repository as persistence adapter
↓
7. SQLite connection and cursor ownership
↓
8. Relational schema and referential integrity
↓
9. Initialization versus migration
↓
10. Event-driven desktop adapter
↓
11. Domain model versus view model
↓
12. Resource lifetime and application shutdown
```

This sequence should guide later KANBAN reconstruction, but no identifiers are assigned here because the canonical register is currently empty and identifier recovery may require commit-oriented analysis.

---

## 10. Knowledge-State Classification

### Canonical-concept candidates

- package/module boundary;
- layered responsibility;
- domain entity;
- contract versus implementation;
- application service;
- Repository pattern;
- persistence adapter;
- relational integrity;
- initialization versus migration;
- resource ownership;
- view model;
- presentation adapter.

### Glossary-derivative candidates

- cursor;
- row factory;
- WAL;
- idempotent migration;
- schema introspection;
- projection;
- signal/slot;
- user-data directory;
- bundled resource;
- cascading foreign key action.

### Active/unstable concepts

- connection ownership across page-local services;
- shutdown and deterministic cleanup;
- dependency inversion versus direct construction;
- typed versus dictionary view models;
- additive migration versus versioned migration;
- package cohesion versus internal layer subdivision.

### Observational learning evidence

- all permanent didactic files were empty at recovery start;
- repository structure supplies the first recoverable learning baseline;
- no prior KANBAN identifiers should be inferred solely from transient conversation;
- commit history should be inspected next to recover concept evolution, former identifiers, and superseded structural interpretations.

---

## 11. Recommended Next Recovery Read

After this structural stage, commit-oriented analysis should focus on commits that introduced or changed:

1. `app/core/contracts.py` and model naming;
2. repository/service separation;
3. database initialization and migration;
4. view-model assembly;
5. desktop page consolidation;
6. connection closing and packaging paths;
7. prior didactic KANBAN/checkpoint material before the recovery pruning.

The goal of that phase is not merely to list changes. It is to recover:

```text
which concepts appeared
why they appeared
which terminology stabilized
which distinctions were corrected
which KANBAN identifiers were previously occupied
```

---

## 12. Stage Conclusion

The contemporary repository evidences a working layered model:

```text
PySide6 desktop adapter
→ ProductService business boundary
→ Repository persistence adapter
→ database lifecycle manager
→ SQLite schema and user database
```

The most important didactic recovery themes are package structure, responsibility ownership, persistence boundaries, connection lifetime, initialization versus migration, and the distinction among database rows, domain models, and view models.

This report is ready for Main Chat synthesis. It must remain staged until commit history and any recoverable pre-pruning didactic evidence are reconciled.
