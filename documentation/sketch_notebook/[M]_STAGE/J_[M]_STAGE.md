# [M] Recovery Reconciliation Reference

> Status: Provisional Main reconciliation reference
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Branch: `sketch-notebook-recovery`
> Scope: Reconciliation of `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, and `DEV_STAGE/C_DESIGN.md` for the first Sketch Notebook promotion cycle
> Knowledge state: Reconciled staged knowledge; promotion source, not yet permanent domain canon
> Supersedes in this file: Initial exploratory collection and domain-launch prompts

---

# 1. Purpose

This file is the first cross-domain referential point produced during the recovery cycle.

The permanent operational, didactic, design, and Main-root project-memory files were intentionally emptied. The repository implementation was inspected by the three functional chats, which staged their findings in:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

Main Chat has now compared those reports against each other and, where their confidence levels differed, against the current source implementation.

This document therefore performs four tasks:

1. identify statements supported consistently across domains;
2. resolve factual disagreements and confidence mismatches;
3. separate implementation fact, interpretation, risk, and decision;
4. classify the material that may enter the first `PROMOTION_RULES` cycle.

This file is provisional. It is not a replacement for permanent domain memory. Its purpose is to provide one reconciled source from which the functional chats may reconstruct their canonical, derived, checkpoint, and observational files without independently re-litigating the same repository baseline.

---

# 2. Evidence and Reconciliation Method

The reconciliation used this precedence for the present recovery task:

```text
Human recovery direction
↓
Current repository implementation
↓
Convergent A/B/C observations
↓
Single-domain interpretation
↓
Unverified hypothesis or proposed target
```

This is not a permanent truth hierarchy. It is the appropriate evidence order because all permanent domain files are empty and the current implementation is the direct subject of recovery.

Each statement below is classified as one of:

```text
CONFIRMED IMPLEMENTATION FACT
    directly present in current source or schema

RECONCILED INTERPRETATION
    supported by implementation and consistent cross-domain reasoning

OPERATIONAL VALIDATION REQUIRED
    structurally plausible, but runtime evidence is still required

DESIGN DECISION REQUIRED
    current structure is known, but its intended future status is not accepted

HISTORICAL CLASSIFICATION REQUIRED
    current implementation is known, but commit history may be needed to distinguish deliberate direction from accumulated drift
```

No unresolved decision is promoted as canonical architecture. No operational risk is converted into an established failure without execution evidence. No didactic candidate is assigned a recovered historical KANBAN identifier merely from conversation memory.

---

# 3. Reconciled Contemporary Topography

## 3.1 Executable and dependency spine

**CONFIRMED IMPLEMENTATION FACT**

```text
root main.py
↓
app.main.main()
↓
QApplication
↓
app.desktop.main_window.MainWindow
↓
RegisterPage / ListsPage / HistoryPage / SettingsPage
↓
ProductService
↓
Repository
↓
app.core.database
↓
SQLite
```

Responsibility direction is currently:

```text
Desktop presentation
    renders widgets, receives input, coordinates navigation and refresh

ProductService
    validates, orchestrates workflows, calculates state,
    interprets settings, and assembles UI-consumable projections

Repository
    executes SQL, maps rows and models, commits mutations,
    and owns one connection and cursor per repository instance

Database manager
    resolves resource and user-data paths, initializes schema,
    configures connections, applies compatibility migrations,
    and exposes connection close/reset operations

SQLite and SQL resources
    persist user state and define the creation schema
```

The repository is a practical layered desktop monolith. It is not presently a framework-enforced clean architecture, nor does it need to be described as one.

## 3.2 Confirmed application packages and modules

```text
app/
├── main.py
├── core/
│   ├── config.py
│   ├── contracts.py
│   ├── database.py
│   ├── models.py
│   ├── repository.py
│   └── services.py
├── database/
│   ├── schema.sql
│   └── seed.sql
└── desktop/
    ├── main_window.py
    └── ui/
        ├── pages/
        │   ├── register_page.py
        │   ├── lists_page.py
        │   ├── history_page.py
        │   └── settings_page.py
        └── widgets/
            └── product_detail_panel.py
```

The files above are confirmed from direct inspection and import relationships. This topography is suitable for initial domain-memory reconstruction.

---

# 4. Reconciled Domain and Persistence Model

## 4.1 Domain entities

**CONFIRMED IMPLEMENTATION FACT**

`app/core/models.py` defines:

```text
Category
Store
Product
Purchase
```

The entities are slotted dataclasses used to carry application data across layers. They do not execute SQL and do not own application workflows.

**RECONCILED INTERPRETATION**

```text
Purchase
    historical source event / receipt record

Product
    persistent product identity and editable metadata
    + cached current-state and analytical summary derived from purchases
```

The current system depends on `ProductService.recalculate_product()` remaining the centralized producer of calculated Product summary fields.

This interpretation is suitable for design canon and didactic explanation, but the stronger statement that Product is an intentionally accepted aggregate/projection hybrid remains a design question until explicitly accepted.

## 4.2 Relational schema

**CONFIRMED IMPLEMENTATION FACT**

Current tables:

```text
categories
products
stores
purchases
settings
promotions
```

Current relationship spine:

```text
Category 1 ── * Product
Product  1 ── * Purchase
Store    1 ── * Purchase, optional store reference
Product  1 ── * Promotion
Store    1 ── * Promotion, optional store reference
Settings key ─ value
```

`purchases.product_id` uses `ON UPDATE CASCADE` and `ON DELETE CASCADE`. Other inspected foreign keys do not declare equivalent cascade actions.

Indexes exist for product name, purchase product ID, and purchase date.

## 4.3 Promotions status

**CONFIRMED IMPLEMENTATION FACT**

A `promotions` table exists. Purchases also store a simple promotion flag.

**HISTORICAL CLASSIFICATION REQUIRED**

No complete current model/service/desktop workflow for promotion entities was established by the recovery reports. The table may represent dormant roadmap structure, incomplete work, or stale persistence design.

It must not yet be described as an active application capability or as obsolete canon.

---

# 5. Reconciled Database Lifecycle

## 5.1 Resource and writable-state separation

**CONFIRMED IMPLEMENTATION FACT**

```text
Bundled resources
    app/database/schema.sql
    app/database/seed.sql

Writable runtime state
    %LOCALAPPDATA%/Markei/market.sqlite
```

A home-directory fallback is used when `LOCALAPPDATA` is unavailable. Frozen execution is accounted for through `sys.frozen` and `_MEIPASS` resource resolution.

**RECONCILED INTERPRETATION**

The source implements a sound conceptual boundary between replaceable application resources and persistent user data.

**OPERATIONAL VALIDATION REQUIRED**

The following are not proven merely by source inspection:

- correct inclusion of schema and seed resources in all packaged modes;
- preservation of user data through installer upgrade, uninstall, and reinstall;
- production exclusion or intentional use of sample seed records.

## 5.2 Connection configuration

**CONFIRMED IMPLEMENTATION FACT**

Every connection obtained through the database manager is configured with:

```text
PRAGMA foreign_keys = ON
PRAGMA journal_mode = WAL
PRAGMA synchronous = NORMAL
row_factory = sqlite3.Row
```

This fact is suitable for operational canon, design description of the persistence boundary, and didactic treatment of SQLite connection configuration.

## 5.3 Initialization and migration

**CONFIRMED IMPLEMENTATION FACT**

Fresh initialization:

```text
create user-data directory
→ preserve an existing database unless recreate=True
→ create SQLite database
→ execute schema.sql
→ execute seed.sql when present
→ commit and close
```

Existing-database compatibility:

```text
open configured connection
→ inspect schema
→ add currently required columns/tables/default values when absent
→ commit
```

Current migration operations are additive and idempotent for the encoded changes. There is no explicit numbered migration ledger or schema-version table.

**RECONCILED INTERPRETATION**

The implementation currently provides an additive compatibility migration mechanism, not a general mature migration framework.

It is safe to teach and document the distinction between initialization and migration. It is not safe to claim that complex future migrations are already supported.

## 5.4 Reset

**CONFIRMED IMPLEMENTATION FACT**

`reset()` rebuilds by calling initialization with `recreate=True`, which removes the active database file before recreating it.

**OPERATIONAL RISK**

No backup, user confirmation, open-connection coordination, or rollback system was established. Reset must remain classified as a destructive maintenance/development capability until safeguarded and validated.

---

# 6. Reconciled Desktop Composition

## 6.1 Public composition

**CONFIRMED IMPLEMENTATION FACT**

`MainWindow` composes four visible tabs:

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

`MainWindow` coordinates tab navigation, product edit routing, and refreshes for Lists and History.

## 6.2 Page responsibilities

**CONFIRMED IMPLEMENTATION FACT**

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
    read-only renderer of service-prepared product detail data
```

Desktop pages call ProductService rather than Repository or SQLite directly.

The service provides application meaning and presentation-oriented projections. Qt widgets retain widget construction, selection, colors, navigation, and dialogs.

## 6.3 View-model boundary

**CONFIRMED IMPLEMENTATION FACT**

Lists, History, analytics, and product-detail surfaces consume dictionary-based projections assembled by ProductService.

**RECONCILED INTERPRETATION**

```text
Database row
    persistence representation

Domain model
    application entity representation

Service projection / view model
    use-case-specific presentation representation

Qt widget
    platform-specific rendering
```

The dictionaries are platform-neutral but untyped, and some labels are already formatted in the service.

**DESIGN DECISION REQUIRED**

Whether to retain dictionaries and service-level formatting or introduce explicit view-model types/presenters is unresolved. The current implementation is valid evidence; a redesign is not implied by this observation.

---

# 7. Reconciled Service, Repository, and Contract Boundaries

## 7.1 ProductService role

**CONFIRMED IMPLEMENTATION FACT**

ProductService owns:

- product and purchase commands;
- product-summary recalculation;
- inventory status and Lists projections;
- History grouping and analytics;
- settings defaults, compatibility, validation, and persistence coordination;
- store management;
- product-detail projections;
- resource cleanup through `close()`.

**RECONCILED INTERPRETATION**

ProductService currently functions as the application facade, not only as a narrowly bounded product service.

This breadth is a design fact about current responsibility concentration. It is not by itself proof that the service must be split.

## 7.2 Repository role

**CONFIRMED IMPLEMENTATION FACT**

Repository is the monolithic persistence facade for products, purchases, categories, stores, settings, and related projections. It owns SQL, row mapping, one SQLite connection, one cursor, commits, and explicit/context-manager closure.

The database manager owns connection acquisition and configuration mechanics, while Repository owns the acquired connection during its lifetime.

## 7.3 Contracts

**CONFIRMED IMPLEMENTATION FACT**

`contracts.py` records field classifications, invariants, and abstract repository/service surfaces.

The concrete ProductService and Repository expose more capabilities than their current abstract contracts. ProductService also constructs Repository directly, while pages construct ProductService directly.

**RECONCILED INTERPRETATION**

The contracts are useful architectural declarations and partial interfaces. They are not presently complete runtime dependency-inversion boundaries.

**DESIGN DECISION REQUIRED**

The project must later decide whether contracts should become complete substitutable interfaces/protocols or remain limited responsibility declarations.

---

# 8. Conflict Verification and Resolution

## 8.1 Number of page-owned services and connections

Operational initially confirmed Register and Lists and left History and Settings for direct verification. Didactic and Design reported the four-page pattern.

**RESOLUTION: CONFIRMED IMPLEMENTATION FACT**

```text
RegisterPage → ProductService → Repository → SQLite connection
ListsPage    → ProductService → Repository → SQLite connection
HistoryPage  → ProductService → Repository → SQLite connection
SettingsPage → ProductService → Repository → SQLite connection
```

Normal MainWindow construction therefore creates four service instances, four repository instances, and four long-lived SQLite connections.

## 8.2 ProductService cleanup capability

Operational initially listed the existence of a ProductService close method as requiring verification.

**RESOLUTION: CONFIRMED IMPLEMENTATION FACT**

`ProductService.close()` delegates to `self.repository.close()`.

Local cleanup capability exists.

## 8.3 Application shutdown ownership

Operational described no demonstrated application-level shutdown owner. Didactic described page-level cleanup attempts. Design confirmed HistoryPage and SettingsPage local `closeEvent()` methods and classified shutdown ownership as implicit.

**RESOLUTION: RECONCILED INTERPRETATION**

```text
cleanup capability exists at service/repository level
+
cleanup attempts exist in page widgets
but
no single composition-level shutdown owner is established
```

This is not the same as proving a runtime leak.

**OPERATIONAL VALIDATION REQUIRED**

Qt shutdown behavior must be tested to determine whether every page-owned service closes deterministically and whether cleanup exceptions occur.

**DESIGN DECISION REQUIRED**

The project must later choose whether lifecycle ownership remains distributed or moves to `app/main.py`, MainWindow, or another composition object.

## 8.4 Receipt-workflow atomicity

Operational originally classified workflow atomicity as unverified. Design reported it as confirmed non-atomic.

Main source verification confirms:

```text
register_receipt()
→ create or update Product
→ insert Purchase
→ recalculate Product
→ update Product summary
```

Repository mutation methods commit internally after each mutation.

**RESOLUTION: CONFIRMED IMPLEMENTATION PROPERTY**

Receipt registration is not transactionally atomic across the full business workflow. Failure after an earlier committed step can leave a partial state.

Purchase deletion followed by summary recalculation has the same multi-commit characteristic.

This does not prove that failures commonly occur. It establishes the transaction model.

**DESIGN DECISION REQUIRED**

Accept best-effort sequential consistency for the local MVP, or introduce a workflow transaction boundary. No redesign is promoted yet.

## 8.5 Seed status

Main exploration and Didactic described seed execution as optional when present. Operational warned that production cleanliness depends on packaging. The seed currently contains baseline category/store/settings plus an example Rice product.

**RESOLUTION**

- seed execution behavior: confirmed;
- seed content: confirmed;
- classification of each row as required baseline or demonstration data: unresolved;
- production artifact policy: operational validation and human decision required.

## 8.6 Current Lists naming versus persisted page order

Design identified a mismatch:

```text
visible tabs
    Register, Lists, History, Settings

persisted default pages.order
    Register,Storage,Shortage,Market,History,Settings
```

**RESOLUTION: CONFIRMED DRIFT CANDIDATE**

The setting and current desktop composition do not express the same navigation model. Whether `pages.order` is dormant, stale, or intended for future use requires historical and design classification.

---

# 9. Stable Promotion Baseline

The following statements have enough convergent and source-backed evidence to enter the first promotion cycle.

## 9.1 Cross-domain stable implementation baseline

1. Markei is currently a local PySide6 desktop application backed by a user-local SQLite database.
2. The runtime dependency chain is Desktop → ProductService → Repository → Database Manager → SQLite.
3. Desktop code does not execute SQL directly.
4. ProductService owns business workflows, calculations, settings interpretation, and UI-consumable projections.
5. Repository owns SQL and row/model mapping.
6. Database Manager owns connection configuration, initialization, additive migration, resource paths, and user-data paths.
7. Domain models do not execute persistence operations.
8. Purchase is the historical receipt record.
9. Product persists editable product information plus calculated current summaries derived from Purchase history.
10. MainWindow composes Register, Lists, History, and Settings.
11. Storage, Shortage, and Market currently exist as Lists modes.
12. SQL resources are bundled separately from the writable user database.
13. SQLite foreign keys, WAL, synchronous NORMAL, and sqlite3.Row are configured centrally.
14. Current schema compatibility migration is additive and idempotent for encoded changes, without a version ledger.
15. Each principal page constructs its own ProductService/Repository/connection chain.
16. ProductService and Repository expose close capability, but application-wide shutdown ownership is implicit.
17. Repository mutations commit individually; receipt and purchase-deletion workflows are multi-commit and non-atomic.
18. Service-produced dictionaries currently function as UI-facing view models.
19. ProductService and Repository are broad application and persistence facades.
20. Contracts declare important boundaries but do not cover the full concrete runtime surface.

These facts may be expressed differently in each domain, but their semantic ownership must remain distinct.

---

# 10. First Promotion Classification

## 10.1 Operational domain

### Canonical operational knowledge candidates

- supported execution entry points;
- database resource and user-data path model;
- connection configuration contract;
- initialization and current migration procedure;
- repository/service connection ownership chain;
- explicit close operations;
- statement-level commit model;
- validation discipline using isolated `LOCALAPPDATA` paths;
- destructive reset restrictions;
- packaging/database smoke-test expectations.

### Derived operational knowledge candidates

- active risk and validation backlog;
- packaging verification tasks;
- transaction-failure test plan;
- shutdown verification tasks;
- migration-versioning future task.

### Operational checkpoint candidates

- current executable state;
- current highest risks;
- validations completed versus still required;
- next files/commands to inspect.

### Operational observational history candidates

- recovery-cycle repository inspection;
- A-stage creation;
- Main reconciliation;
- source verification resolving lifecycle and transaction confidence conflicts.

## 10.2 Didactic domain

### Canonical didactic candidates

Initial concept families may cover:

- package and module boundaries;
- layered responsibility;
- domain entity and dataclass;
- contract versus implementation;
- application service;
- Repository pattern and persistence adapter;
- SQLite connection/cursor ownership;
- relational schema and referential integrity;
- initialization versus migration;
- resource ownership and deterministic cleanup;
- presentation adapter and event-driven UI;
- database row versus domain model versus view model;
- statement atomicity versus workflow atomicity.

Historical KANBAN identifiers and former statuses must not be inferred solely from this recovery. New identifiers may be allocated according to current canonical numbering rules if the human accepts a fresh register.

### Derived didactic candidates

- glossary entries for cursor, row factory, WAL, idempotence, schema introspection, projection, signals/slots, user-data directory, bundled resource, and cascading actions;
- concept dependency map;
- project learning spine.

### Didactic checkpoint candidates

- current recovery milestone;
- stable, active, and unresolved concept groups;
- immediate learning progression;
- project dependency spine.

### Didactic observational history candidates

- concept recovery from a pruned notebook;
- concepts introduced by the contemporary architecture;
- distinctions whose stability remains dependent on operational or design decisions.

## 10.3 Design domain

### Canonical design candidates

- present dependency direction;
- responsibility boundaries among desktop, service, repository, database manager, models, and SQL resources;
- Purchase historical-record role;
- Product calculated-summary ownership through ProductService;
- MainWindow composition and coordination role;
- Lists consolidation of Storage/Shortage/Market;
- resource/user-data separation;
- current read-model/presentation boundary;
- current application-facade and persistence-facade structure.

Canonical design should describe the accepted current structure without pretending every current coupling is a desired permanent endpoint.

### Derived design candidates

- module responsibility map;
- domain relationship diagram;
- current architecture overview;
- drift and unresolved-decision index.

### Design checkpoint candidates

- accepted current boundaries;
- active architectural tensions;
- unresolved human decisions;
- next historical/source inspection points.

### Design observational history candidates

- recovery of the current structural state;
- consolidation of legacy pages into Lists;
- emergence of ProductService as application facade;
- discovery of distributed lifecycle ownership and non-atomic workflows;
- unresolved promotion/settings drift.

---

# 11. Knowledge That Must Not Yet Be Canonically Promoted

The following remain unresolved and must be staged as risks, TODOs, questions, or observations rather than accepted truth about intended design:

1. whether four page-local services are the desired lifecycle model;
2. whether MainWindow, `app/main.py`, or another object should own shutdown;
3. whether receipt workflow atomicity is required for the MVP;
4. whether ProductService should be renamed, decomposed, or retained;
5. whether Repository should remain one persistence facade;
6. whether contracts should become complete substitutable interfaces;
7. whether view-model dictionaries should become typed objects;
8. whether formatting remains in ProductService;
9. whether migrations move to an explicit startup/versioned system;
10. whether the promotions table is active, deferred, or stale;
11. whether `pages.order` should be consumed, migrated, or retired;
12. whether sample Rice and store data belong in production seed;
13. whether packaged resources and installer lifecycle behave correctly;
14. whether child-page `closeEvent()` reliably closes every connection at application shutdown;
15. whether Product's hybrid editable/cache role is an accepted long-term domain decision.

---

# 12. Promotion Integrity Rules for the First Repopulation

The first repopulation should obey these constraints:

1. Domain files receive only knowledge owned by that domain.
2. Canonical files define accepted stable responsibility or procedure; they do not become copies of A/B/C.
3. Derived files summarize canonical truth and may include navigational views, but introduce no independent claim.
4. Checkpoints remain compact recovery surfaces.
5. Observational files preserve this recovery event and unresolved evidence without defining present truth alone.
6. Runtime risks remain operational unless and until they become accepted architectural constraints.
7. Architectural questions remain design decisions, not operational defects.
8. Didactic files teach stable concepts and explicitly mark project examples that remain unsettled.
9. The same implementation fact may appear in multiple domains only through each domain's semantic responsibility.
10. J remains the reconciliation source until the first domain files are materialized and checked against it.
11. After successful domain repopulation, J should be retained as provisional reconciliation evidence, revised into a lighter Main reference, or retired according to explicit Main/human direction.

---

# 13. Recommended First Materialization Sequence

```text
J reconciled reference
↓
Operational promotion proposal
    12_OPERATIONAL_MODEL
    04_TODO
    10_OPERATIONAL_STATE
    11_OPERATIONAL_RECORD
↓
Didactic promotion proposal
    02_KANBAN
    07_GLOSSARY
    08_CONCEPT_MAP
    13_LECTURE_REGISTER
↓
Design promotion proposal
    01_ARCHITECTURE
    14_MODEL_OVERVIEW
    09_DESIGN_STATE
    03_DECISION_LOG
↓
Main reconciliation of populated domains
↓
00_PROJECT_STATE
05_SESSION_LOG
06_SESSION_SCHEME
```

The order does not make one functional domain epistemically superior. It provides a controlled first materialization sequence and allows later domains to reference already stabilized terminology where useful.

No permanent file should be filled by copying its entire stage report. Each target must be written according to its semantic role.

---

# 14. Referential Recovery Point

The first reconciled recovery statement is:

```text
Markei currently operates as a layered local desktop monolith.

PySide6 pages call a broad ProductService application facade.
ProductService coordinates workflows, calculations, settings, and view projections.
A broad Repository persistence facade executes SQLite operations and owns one
connection/cursor per service instance. app.core.database centralizes database
paths, initialization, additive migrations, and connection configuration.

Purchase records are historical source events. Product records combine editable
identity/state with cached summaries recalculated from purchase history.

The public desktop is Register, Lists, History, and Settings; former Storage,
Shortage, and Market surfaces are Lists modes.

The strongest established boundaries are the absence of SQL in presentation and
service code, the separation of repository SQL from database lifecycle, and the
separation of bundled SQL resources from writable user data.

The principal current tensions are distributed page-level resource ownership,
implicit application shutdown, multi-commit non-atomic business workflows,
broad facade responsibilities, partial contracts, untyped view-model dictionaries,
and schema/settings structures whose current feature status is unresolved.
```

This statement is the shared referential baseline for the first permanent-domain repopulation. Any domain proposal that contradicts it must identify new evidence, the exact conflicting statement, and the reconciliation required before materialization.

---

# 15. Current State

```text
A_OPERATIONAL: staged and reconciled
B_DIDACTIC: staged and reconciled
C_DESIGN: staged and reconciled
J_[M]_STAGE: consolidated promotion reference
Permanent domain memory: still empty
Promotion readiness: ready for first domain repopulation proposals
Application source changes in this reconciliation: none
```
