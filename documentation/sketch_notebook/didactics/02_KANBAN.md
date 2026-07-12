# 02_KANBAN.md

> Domain: Didactic
> Status: Canonical concept register — Cycle 06 Sprint 02
> Authority: Didactic Chat [A], reconciled through Main reference
> Reconciliation sources: `DEV_STAGE/E_DDC_STAGE.md`, `DEV_STAGE/H_DDC_CODEX.md`, `DEV_STAGE/G_OPS_CODEX.md`, and `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Stable concepts evidenced by the contemporary Markei repository
> Maturity rule: implementation success does not establish learner mastery

---

# Foundational Computer Science

## &&&01
### Responsibility Boundary
#### Description
A responsibility boundary identifies which component should know, decide, or perform a kind of work.
#### Formal Definition
An explicit allocation of knowledge and behavior to a component or layer, together with constraints on what belongs elsewhere.
#### Practical Example
A screen gathers input, a service coordinates a use case, and a repository stores data.
#### Language Implementation
Python expresses boundaries through packages, modules, classes, imports, interfaces, and method calls.
#### Project Implementation
Markei separates desktop presentation, `ProductService`, `Repository`, database lifecycle, packaging, installer placement, validation evidence, and Main/human acceptance.
#### Required Concepts
None.
#### Related Concepts
`&&&02`, `&&&03`, `&&&05`, `&%%01`, `&%%02`, `&%%03`.
#### Status
Yellow.
#### Source
Current application and Cycle 06 reconciliation.

---

## &&&02
### Raw Data Versus Derived Data
#### Description
Source facts and values calculated from those facts have different evidential roles.
#### Formal Definition
Raw data is directly entered, observed, imported, or retrieved; derived data is produced through calculation, aggregation, filtering, formatting, prediction, or interpretation.
#### Practical Example
A receipt purchase is a source event; an expected next-purchase date is derived from history.
#### Language Implementation
Both may be represented by fields or keys, so naming, ownership, recalculation, and persistence rules preserve the distinction.
#### Project Implementation
Markei treats purchases as historical events and product summaries, status labels, and projections as derived or cached interpretations.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&&03`, `&&&05`, `&&%02`, `&%%04`.
#### Status
Yellow.
#### Source
Current Product/Purchase and service-projection boundary.

---

## &&&03
### Naming as Data Contract
#### Description
Names communicate the expected meaning of data and project states across boundaries.
#### Formal Definition
The use of stable, precise, responsibility-aware names to define the meaning and shape of exchanged information.
#### Practical Example
`configured`, `built`, `launched`, `installed`, `validated`, and `accepted` are not interchangeable labels.
#### Language Implementation
Naming contracts appear in attributes, signatures, dictionary keys, constants, settings keys, artifacts, and status reports.
#### Project Implementation
Cycle 06 keeps automated technical validation distinct from human-visible UI acceptance and final Main/human acceptance.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&&02`, `&&&05`, `&&%02`, `&%%04`.
#### Status
Yellow.
#### Source
Current naming chain and Cycle 06 evidence classification.

---

## &&&04
### Resource Ownership and Lifetime
#### Description
Resources require an identifiable owner and a defined lifetime.
#### Formal Definition
Resource ownership assigns creation, use, sharing, and release responsibility; lifetime is the interval during which a resource remains retained and valid.
#### Practical Example
A repository owns a database connection, while the application composition determines when all repositories close.
#### Language Implementation
Python expresses lifetime through constructors, `close()`, context managers, `try/finally`, event hooks, and composition.
#### Project Implementation
A bounded, idempotent `MainWindow.closeEvent()` closes all four page-owned services. Source/frozen and installed close/reopen evidence passed, while human-visible walkthrough remains pending.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&%03`, `&&&05`, `%%%02`, `&%%06`.
#### Status
Red.
#### Source
Cycle 06 shutdown failure, correction, and installed lifecycle rerun evidence.

---

## &&&05
### Evidence State and Validation Boundary
#### Description
A claim is limited by the strongest evidence actually obtained. Configuration, artifact creation, execution, deployment, validation, and acceptance are distinct states.
#### Formal Definition
An evidence state records what has been demonstrated; a validation boundary identifies the exact environment, lifecycle stage, conditions, and behavior covered by that evidence. Evidence from one boundary cannot automatically prove another.
#### Practical Example
A compiled installer proves artifact creation; it does not by itself prove installation, workflow behavior, retention, or acceptance.
#### Language Implementation
Projects encode evidence through command results, artifact inspection, hashes, logs, test results, environment records, and explicit acceptance decisions.
#### Project Implementation
Cycle 06 progressed from installer configuration to compiled installer, per-user installation, Start Menu launch, technical workflow persistence, close/reopen, same-version reinstall, uninstall retention, and reinstall recovery. Automated installed-lifecycle evidence is strong, but human-visible UI acceptance and SmartScreen behavior remain pending or unknown; `accepted: no`.
#### Required Concepts
`&&&01`, `&&&02`, `&&&03`.
#### Related Concepts
`&&%04`, `&%%06`, `%%%06`, `&&&04`.
#### Status
Red.
#### Source
Sprint 02 Main reconciliation plus G/H evidence.

---

# Python Language Concepts

## &&%01
### Package and Module Boundary
#### Description
A module groups definitions in one file; a package groups related modules under an import namespace.
#### Formal Definition
A module is an importable unit normally represented by a `.py` file; a package is an importable namespace containing modules or subpackages.
#### Practical Example
Business services and database infrastructure may share a package while retaining separate responsibilities.
#### Language Implementation
Python boundaries use directories, package markers, imports, and module-level names.
#### Project Implementation
Markei uses `app/core`, `app/database`, and `app/desktop`; physical grouping does not erase semantic responsibility.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&%02`, `&&%04`, `&%%01`, `&%%03`.
#### Status
Yellow.
#### Source
Current repository topology.

---

## &&%02
### Dataclass as Structured Data Carrier
#### Description
A dataclass concisely defines objects whose main role is carrying named data.
#### Formal Definition
A class declaration enhanced by generated initialization, representation, comparison, and related data-oriented behavior.
#### Practical Example
A purchase object carries product, date, quantity, and price without owning SQL.
#### Language Implementation
Python uses `@dataclass`, typed fields, and optionally `slots=True`.
#### Project Implementation
Markei defines `Category`, `Store`, `Product`, and `Purchase` as slotted dataclasses while persistence and workflows remain elsewhere.
#### Required Concepts
`&&&01`, `&&&03`.
#### Related Concepts
`&&&02`, `&%%04`.
#### Status
Yellow.
#### Source
Current models and reconciled entity boundary.

---

## &&%03
### Context Manager and Deterministic Cleanup
#### Description
A context manager ties setup and cleanup to a visible scope; long-lived applications may require an explicit lifecycle event instead.
#### Formal Definition
An object implementing context management so setup occurs on entry and cleanup on exit, including exceptional exit.
#### Practical Example
A short database operation can use `with`; a desktop session may close repositories during window shutdown.
#### Language Implementation
Python uses `with`, `__enter__`, `__exit__`, `try/finally`, and explicit `close()` methods.
#### Project Implementation
Markei uses explicit service closure in `MainWindow.closeEvent()`. Automated installed close and immediate reopen passed after the Sprint 01 correction.
#### Required Concepts
`&&&04`.
#### Related Concepts
`&&&05`, `%%%02`, `&%%06`.
#### Status
Red.
#### Source
Cycle 06 shutdown and installed-reopen evidence.

---

## &&%04
### Source, Frozen, and Installed Execution Context
#### Description
The same application can run from repository source, a collected executable distribution, or an installer-placed distribution. These contexts share business architecture but differ operationally.
#### Formal Definition
Source execution runs modules and resources through a development interpreter; frozen execution runs collected code and resources through a generated executable; installed execution runs that frozen runtime after installer-controlled placement, registration, and launch-path creation.
#### Practical Example
`python main.py`, `dist/Markei/Markei.exe`, and a Start Menu shortcut start the same application through different execution contexts.
#### Language Implementation
Python applications distinguish contexts through entrypoints, `sys.frozen`, `_MEIPASS`, resource resolution, collected dependencies, and platform-specific writable paths.
#### Project Implementation
Source and frozen execution were previously evidenced. Sprint 02 added actual installed execution from a Start Menu shortcut under `%LOCALAPPDATA%\Programs\Markei`, without requiring a Python command or source checkout.
#### Required Concepts
`&&&01`, `&&%01`, `%%%05`.
#### Related Concepts
`&&&05`, `&%%06`, `%%%06`.
#### Status
Red.
#### Source
Cycle 06 source, frozen, and installed-launch evidence.

---

# Target-File and Architecture Concepts

## &%%01
### Application Service
#### Description
An application service coordinates a user-facing use case without becoming presentation or persistence infrastructure.
#### Formal Definition
A boundary object that orchestrates domain and persistence operations to fulfill application use cases.
#### Practical Example
Receipt registration validates input, records a purchase, recalculates summaries, and returns results without exposing SQL to the UI.
#### Language Implementation
Commonly a class whose methods represent use cases and depend on repositories.
#### Project Implementation
`ProductService` coordinates commands, calculations, settings, stores, and UI-facing projections.
#### Required Concepts
`&&&01`, `&&%01`.
#### Related Concepts
`&%%02`, `&%%04`, `&%%05`.
#### Status
Yellow.
#### Source
Current service responsibility inventory.

---

## &%%02
### Repository Pattern and Persistence Adapter
#### Description
A repository translates application-oriented persistence operations into storage operations.
#### Formal Definition
A persistence abstraction that maps application requests and representations to database commands and results.
#### Practical Example
A service asks for purchases; the repository runs SQL and returns mapped results.
#### Language Implementation
Python repositories commonly contain parameterized SQL, cursor execution, commits, and row mapping.
#### Project Implementation
Markei's `Repository` owns SQL, mappings, one connection, one cursor, and individual commits; database setup remains in `app.core.database`.
#### Required Concepts
`&&&01`, `&&&02`, `&%%01`.
#### Related Concepts
`%%%02`, `%%%03`, `&%%05`.
#### Status
Yellow.
#### Source
Current repository implementation.

---

## &%%03
### Presentation Adapter
#### Description
A presentation adapter translates platform input into application calls and application results into rendering.
#### Formal Definition
A component that converts platform-specific interaction into application-boundary calls and representations.
#### Practical Example
A page reads widgets, calls a service, and renders prepared data.
#### Language Implementation
PySide6 uses widgets, layouts, signals, slots, event handlers, and dialogs.
#### Project Implementation
Markei pages call `ProductService`; automated Sprint 02 evidence exercised the same service/database path, but a full human-visible UI walkthrough remains pending.
#### Required Concepts
`&&&01`, `&&%01`, `&%%01`.
#### Related Concepts
`&&&04`, `&&%03`, `&%%04`, `&&&05`.
#### Status
Yellow.
#### Source
Current desktop composition and Sprint 02 validation boundary.

---

## &%%04
### Database Row, Domain Model, and View Model
#### Description
Overlapping information may appear in representations shaped for persistence, application meaning, or presentation.
#### Formal Definition
A database row is a persistence representation, a domain model is an application entity representation, and a view model is a use-case-specific rendering representation.
#### Practical Example
Stored numbers become a Product object and then formatted Lists labels.
#### Language Implementation
Python may use `sqlite3.Row`, dataclasses, dictionaries, `TypedDict`, or dedicated view models.
#### Project Implementation
Sprint 02 technical evidence included persisted product/purchase rows plus Lists, History, and Settings projections.
#### Required Concepts
`&&&02`, `&&&03`, `&&%02`, `&%%01`.
#### Related Concepts
`&%%03`, `%%%03`.
#### Status
Yellow.
#### Source
Current mapping and installed technical workflow evidence.

---

## &%%05
### Statement Atomicity Versus Workflow Atomicity
#### Description
One database statement can be atomic while a multi-step use case remains non-atomic when its steps commit separately.
#### Formal Definition
Statement atomicity is all-or-nothing execution of one statement; workflow atomicity is all-or-nothing execution of a complete use case within one transaction boundary.
#### Practical Example
Creating a product, adding a purchase, and updating a summary may leave partial state if each commits independently.
#### Language Implementation
SQLite workflow atomicity uses transaction boundaries, commits, rollbacks, and service/repository coordination.
#### Project Implementation
Markei receipt registration and deletion/recalculation remain multi-commit workflows. Sprint 02 success does not remove this inherited debt.
#### Required Concepts
`&&&01`, `&%%01`, `&%%02`.
#### Related Concepts
`&&&05`, `%%%02`.
#### Status
Red.
#### Source
Current repository/service behavior and Cycle 06 scope boundary.

---

## &%%06
### Packaging and Installation Artifact Lifecycle
#### Description
Packaging and installation move through distinct configurations, generated artifacts, deployed states, and lifecycle evidence.
#### Formal Definition
A release artifact lifecycle transforms source configuration into a frozen distribution, installer configuration into a compiled installer, and that installer into an installed application whose reinstall, uninstall, recovery, and retained-data behavior require separate validation.
#### Practical Example
A `.spec` file is not an executable; an executable directory is not an installer; installer source is not compiled setup media; installation is not lifecycle acceptance.
#### Language Implementation
Projects use packaging specifications, build wrappers, generated distributions, installer definitions, compiler outputs, installation metadata, and lifecycle tests.
#### Project Implementation
Sprint 02 produced `dist/installer/Markei-Setup-0.1.0-x64.exe`, installed files under `%LOCALAPPDATA%\Programs\Markei`, validated same-version reinstall, removed installed files during uninstall while retaining `%LOCALAPPDATA%\Markei`, and recovered retained data after reinstall.
#### Required Concepts
`&&&01`, `&&&04`, `&&%04`, `%%%05`.
#### Related Concepts
`&&&05`, `%%%06`.
#### Status
Red.
#### Source
Cycle 06 installer artifact and installed lifecycle evidence.

---

# Packages, Dependencies, and SQLite Concepts

## %%%01
### SQLite Initialization Versus Migration
#### Description
Initialization creates a new database; migration changes an existing database while preserving compatible user state. Seeding inserts predefined rows.
#### Formal Definition
Initialization establishes baseline persistence, migration transforms existing persistence, and seeding inserts optional predefined records into an initialized structure.
#### Practical Example
A first launch creates tables; migration ensures required defaults; a development fixture may insert sample rows.
#### Language Implementation
Python may use `connect`, `executescript`, schema inspection, conditional DDL, idempotent inserts, and commits.
#### Project Implementation
Production includes `schema.sql` and excludes `seed.sql`. Sprint 02 showed that category `F` / `General` and store `1` / `Default Store` are required structural defaults, created idempotently without sample products or purchases.
#### Required Concepts
`&&&01`, `&%%02`.
#### Related Concepts
`%%%02`, `%%%03`, `%%%05`, `&&&05`.
#### Status
Yellow.
#### Source
Current database lifecycle and Sprint 02 fresh-production correction.

---

## %%%02
### SQLite Connection and Cursor Ownership
#### Description
A connection owns SQLite session and transaction state; a cursor is a connection-bound execution interface.
#### Formal Definition
A connection is the runtime object owning database-session state and transaction context; a cursor executes statements and traverses results through that connection.
#### Practical Example
Four repositories can hold four independent database sessions.
#### Language Implementation
Python uses `sqlite3.Connection` and `sqlite3.Cursor`, explicit commit/rollback, row factories, PRAGMAs, and close operations.
#### Project Implementation
Each Markei repository opens one connection and cursor. The four page-owned chains closed successfully during automated installed close/reopen validation.
#### Required Concepts
`&&&04`, `&%%02`.
#### Related Concepts
`&&%03`, `&&&05`, `%%%03`, `&%%05`.
#### Status
Red.
#### Source
Current ownership structure and installed lifecycle evidence.

---

## %%%03
### SQLite PRAGMA and Connection Configuration
#### Description
SQLite behavior is partly configured per connection.
#### Formal Definition
PRAGMA statements inspect or modify SQLite metadata and connection/database behavior; centralized configuration applies expected settings to each connection.
#### Practical Example
Foreign keys, WAL, synchronous mode, and named row access are configured separately.
#### Language Implementation
Python uses connection execution and `row_factory` assignment.
#### Project Implementation
Markei enables foreign keys, requests WAL, uses synchronous `NORMAL`, and configures `sqlite3.Row`.
#### Required Concepts
`%%%02`.
#### Related Concepts
`%%%01`, `%%%04`, `&%%04`.
#### Status
Yellow.
#### Source
Current connection configuration.

---

## %%%04
### Relational Schema and Referential Integrity
#### Description
A relational schema defines tables, columns, keys, relationships, and constraints.
#### Formal Definition
Referential integrity requires foreign-key references to correspond to valid records or permitted null states.
#### Practical Example
A purchase references a product and follows declared update/delete behavior.
#### Language Implementation
SQLite uses `CREATE TABLE`, keys, indexes, nullability, and foreign-key actions.
#### Project Implementation
The fresh-production Register failure exposed that required category/store references must exist before inserting a purchase-backed product workflow.
#### Required Concepts
`&&&01`, `&%%02`.
#### Related Concepts
`%%%01`, `%%%03`.
#### Status
Yellow.
#### Source
Current schema and Sprint 02 referential-integrity evidence.

---

## %%%05
### Bundled Resource Versus Writable User Data
#### Description
Replaceable application resources and persistent mutable user state have different locations and lifecycles.
#### Formal Definition
A bundled resource is supplied with the application runtime; writable user data is created or modified during use and persists independently from installed program files.
#### Practical Example
A schema script travels with the application while the user's database belongs in a per-user directory.
#### Language Implementation
Python resolves source/frozen resources through paths and runtime indicators, while user data uses platform directories or environment variables.
#### Project Implementation
Installed program files under `%LOCALAPPDATA%\Programs\Markei` were removed by uninstall, while `%LOCALAPPDATA%\Markei\market.sqlite` remained and was recovered after reinstall. `schema.sql` is bundled, `seed.sql` is excluded, and logs/WAL/SHM remain writable external state.
#### Required Concepts
`&&&04`, `%%%01`.
#### Related Concepts
`&&%01`, `&&%04`, `&%%06`.
#### Status
Yellow.
#### Source
Sprint 02 uninstall retention and reinstall recovery evidence.

---

## %%%06
### Build-Time, Runtime, and Installer-Time Dependency
#### Description
Dependencies belong to different lifecycle stages and must not be treated as one undifferentiated requirement set.
#### Formal Definition
A build-time dependency produces a frozen artifact; a runtime dependency supports the executing application; an installer-time dependency compiles or executes installation tooling.
#### Practical Example
A packaging tool may exist only on the builder, collected GUI libraries support the executable, and an installer compiler produces setup media.
#### Language Implementation
Projects separate dependency manifests, build commands, collected modules/native libraries, and external compiler discovery.
#### Project Implementation
PyInstaller produced the frozen runtime; collected PySide6/Qt components support execution. Inno Setup 6.7.3 was installed per-user and discovered at `%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe`; it compiled the installer but is not required by the installed Markei application.
#### Required Concepts
`&&%01`, `&&%04`, `&%%06`.
#### Related Concepts
`&&&05`, `%%%05`.
#### Status
Red.
#### Source
Sprint 02 toolchain discovery and installed runtime evidence.

---

## &&&06
### Stable Identity
#### Description
An identity remains stable when mutable labels change.
#### Formal Definition
A durable identifier that refers to one logical subject independently of changeable descriptive attributes.
#### Practical Example
An account number remains the same after its contact email changes.
#### Language Implementation
Dart can represent UUID identities with immutable typed value objects.
#### Project Implementation
Markei uses distinct account, device, Product, Purchase, Purchase Item, and event UUIDs.
#### Required Concepts
`&&&01`, `&&&03`.
#### Related Concepts
`&&&07`, `&%%08`, `&%%11`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &&&07
### Authentication
#### Description
Authentication establishes evidence that a caller controls an identity.
#### Formal Definition
The verification of credentials or factors that produces an authenticated principal or session.
#### Practical Example
Verified sign-in proves control of an account before protected requests are accepted.
#### Language Implementation
Flutter obtains and securely retains an access token through a selected authentication provider.
#### Project Implementation
Verified email resolves an authenticated Markei account UUID; email is not the ownership key.
#### Required Concepts
`&&&06`.
#### Related Concepts
`&&&08`, `&%%14`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &&&08
### Authorization
#### Description
Authorization determines what an authenticated principal may do.
#### Formal Definition
A policy decision that permits or rejects an operation by a principal on a resource.
#### Practical Example
A signed-in account may read its own records but not another account's records.
#### Language Implementation
The Flutter client presents a token; the API performs authorization rather than trusting client claims.
#### Project Implementation
Markei scopes shared events to the authenticated account; row ownership is an authorization example.
#### Required Concepts
`&&&07`, `&&&01`.
#### Related Concepts
`&%%14`, `&&&06`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &&&09
### Eventual Consistency
#### Description
Replicas may differ temporarily yet converge after synchronization.
#### Formal Definition
A consistency model in which replicas receiving and deterministically applying the same accepted facts eventually reach equivalent state.
#### Practical Example
An offline device shows older data until it reconnects and catches up.
#### Language Implementation
Flutter persists a cursor, downloads unseen events, and rebuilds local projections deterministically.
#### Project Implementation
Markei devices converge on catalogue, purchases, and Storage/Shortage/Market projections after sync.
#### Required Concepts
`&%%13`, `&%%14`.
#### Related Concepts
`&%%12`, `&&&02`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &&&10
### Historical Integrity
#### Description
Later changes must not silently rewrite the meaning of accepted history.
#### Formal Definition
The preservation of original identities and authoritative observations required to interpret past events reproducibly.
#### Practical Example
A package-size change creates a new identity instead of altering an old receipt.
#### Language Implementation
Immutable Dart identities and append-only events preserve earlier references.
#### Project Implementation
Markei Purchase Items retain original Product IDs and commercial observations; analytic evolution does not rewrite purchases.
#### Required Concepts
`&&&02`, `&&&06`.
#### Related Concepts
`&%%17`, `&%%08`, `&%%11`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &&%05
### Immutable Dart Model
#### Description
An immutable Dart model represents state through fixed fields and replacement values.
#### Formal Definition
A typed Dart object whose identity-bearing state cannot mutate after construction.
#### Practical Example
A corrected value is created as a new object rather than editing the original instance.
#### Language Implementation
Dart uses `final` fields, const-capable constructors, value equality, and copy/replacement patterns.
#### Project Implementation
Markei event envelopes, catalogue identities, Money, and Quantity are modeled as immutable values.
#### Required Concepts
`&&%02`, `&&&04`.
#### Related Concepts
`&&&10`, `&%%11`, `%%%07`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%07
### Reusable Catalogue
#### Description
A reusable catalogue stores recurring account-private identities separately from purchases.
#### Formal Definition
An owner-scoped reference set whose entities can be reused by multiple historical transactions.
#### Practical Example
Several receipts reference the same household product identity.
#### Language Implementation
Dart repositories and use cases expose immutable catalogue models to Flutter.
#### Project Implementation
Markei keeps account-private Products and Stores that Purchase Items reference repeatedly.
#### Required Concepts
`&&&06`, `&%%02`.
#### Related Concepts
`&%%08`, `&%%10`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%08
### Product Identification Set and Deterministic Normalization
#### Description
A product identity is derived from exact normalized identity facts, not fuzzy similarity.
#### Formal Definition
A deterministic mapping from an account-scoped canonical attribute tuple to one stable Product ID.
#### Practical Example
Mechanically equivalent 350 g and 0.350 kg inputs resolve to one packaged identity.
#### Language Implementation
Pure Dart normalization converts text, dimensions, units, and amounts before UUID derivation.
#### Project Implementation
Markei distinguishes PACKAGED and BULK modes; fuzzy similarity warns but never automatically merges.
#### Required Concepts
`&%%07`, `&&&06`, `&&&03`.
#### Related Concepts
`&%%15`, `&&&10`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%09
### Purchase Aggregate
#### Description
A Purchase owns one consistency boundary for receipt registration.
#### Formal Definition
An aggregate root that enforces invariants and atomic change across its members and required persistence effects.
#### Practical Example
A receipt header and all valid lines commit together or none commit.
#### Language Implementation
A Dart Purchase command coordinates models and repository transaction through one use case.
#### Project Implementation
Markei commits Purchase, Purchase Items, and pending synchronization event atomically.
#### Required Concepts
`&%%01`, `&%%05`.
#### Related Concepts
`&%%10`, `&%%11`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%10
### Purchase Item
#### Description
A Purchase Item records one product-specific commercial observation within a Purchase.
#### Formal Definition
An aggregate member that references a catalogue Product and carries transaction-specific quantity and price facts.
#### Practical Example
One receipt line records two packages of a product and its line total.
#### Language Implementation
An immutable Dart item model belongs to a Purchase aggregate model.
#### Project Implementation
Markei stores Product reference, package count, dimensional amount, money, promotion, and related observations.
#### Required Concepts
`&%%09`, `&%%08`.
#### Related Concepts
`&%%15`, `&%%16`, `&&&10`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%11
### Append-Only Synchronization Event
#### Description
An accepted synchronization fact is appended rather than overwritten.
#### Formal Definition
An immutable, uniquely identified protocol fact that is validated and applied deterministically.
#### Practical Example
A `purchase.registered` event remains in history after acceptance.
#### Language Implementation
Dart encodes an immutable event envelope to a language-neutral payload.
#### Project Implementation
Markei synchronizes one atomic Purchase with immutable Purchase Item lines as the first event.
#### Required Concepts
`&&&06`, `&%%09`.
#### Related Concepts
`&%%12`, `&%%14`, `&&&10`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%12
### Offline Queue and Idempotent Delivery
#### Description
Durable pending work can be retried without duplicate effect.
#### Formal Definition
A persistent queue combined with event uniqueness and content rules so repeated logical submission is equivalent to one acceptance.
#### Practical Example
A lost response causes retry of the same event, not creation of a second order.
#### Language Implementation
Flutter stores pending events locally and retries the same UUID and payload.
#### Project Implementation
Markei returns prior acceptance for identical retries and rejects changed content under an accepted event UUID.
#### Required Concepts
`&%%11`, `&%%05`.
#### Related Concepts
`&%%13`, `&&&09`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%13
### Device Ordering and Synchronization Cursor
#### Description
Device creation order and server download order are distinct.
#### Formal Definition
A device-monotonic sequence records local event order while an opaque server cursor identifies accepted-event download position.
#### Practical Example
A device fills a sequence gap while another client pages after its last server cursor.
#### Language Implementation
Dart persists device sequence and account cursor independently of occurrence time.
#### Project Implementation
Markei rejects/request gaps and downloads account-scoped accepted events in bounded cursor pages.
#### Required Concepts
`&%%12`, `&&&06`.
#### Related Concepts
`&%%14`, `&&&09`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%14
### Sync Protocol
#### Description
A sync protocol defines stable cross-runtime exchange behavior.
#### Formal Definition
A versioned contract governing identities, payloads, validation, authorization, retries, ordering, cursors, errors, and compatibility.
#### Practical Example
Two applications interpret one accepted message and error code identically.
#### Language Implementation
Dart client DTOs exchange language-neutral JSON with a TypeScript API that validates runtime payloads.
#### Project Implementation
Markei's custom API owns token validation, idempotent append, cursor download, protocol versions, and stable errors.
#### Required Concepts
`&&&08`, `&%%13`.
#### Related Concepts
`%%%01`, `&&&09`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%15
### Dimensional Quantity
#### Description
A quantity combines magnitude with an explicit physical dimension and unit.
#### Formal Definition
A fixed-precision amount qualified by measurement kind and canonical unit.
#### Practical Example
One litre is VOLUME/L and is not inferred to equal one kilogram MASS/KG.
#### Language Implementation
Dart can use immutable Quantity values and enums for MASS/KG, VOLUME/L, and COUNT/UNIT.
#### Project Implementation
Markei separates Product package amount, Purchase Item package count, and normalized purchased amount.
#### Required Concepts
`&&&03`, `&&%05`.
#### Related Concepts
`&%%08`, `&%%10`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%16
### Monetary Minor Unit
#### Description
Money is represented by currency plus an integer smallest-unit amount.
#### Formal Definition
A monetary value composed of an explicit currency code and integer count of its minor unit.
#### Practical Example
BRL 8.79 is represented as BRL and 879 minor units.
#### Language Implementation
Dart uses an immutable Money value rather than binary floating-point for ordinary currency facts.
#### Project Implementation
Markei stores Purchase currency and authoritative line totals in minor units; UI may default territorial currency.
#### Required Concepts
`&&&03`, `&&%05`.
#### Related Concepts
`&%%10`, `&%%17`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## &%%17
### Versioned Analytic
#### Description
Analytical rules evolve through new versions without rewriting source facts.
#### Formal Definition
A derived algorithm identified by stable name and immutable semantic version, with results reproducible from authoritative inputs.
#### Practical Example
An improved price-change formula becomes version 2 while version 1 keeps its meaning.
#### Language Implementation
A Dart analytics registry selects pure algorithms by identifier/version and validates them with fixtures.
#### Project Implementation
Markei versions normalized price, purchase interval, and personalized inflation/deflation projections while purchases remain authoritative.
#### Required Concepts
`&&&02`, `&&&10`.
#### Related Concepts
`&%%16`, `&&&05`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.
---

## %%%07
### Flutter Framework and Responsive Widget Composition
#### Description
Flutter composes one client presentation across platform-appropriate layouts.
#### Formal Definition
A framework-managed widget tree that renders application state responsively under platform constraints and lifecycle events.
#### Practical Example
A wide layout uses a navigation rail while a phone uses compact navigation.
#### Language Implementation
Flutter supplies widgets, constraints, navigation, lifecycle hooks, plugins, and platform build targets; Dart remains the language.
#### Project Implementation
Markei uses Flutter for shared Windows/Android/iOS presentation while durable state remains outside widget memory.
#### Required Concepts
`&&%05`, `&%%03`, `&&&04`.
#### Related Concepts
`&&%03`, `&%%09`, `&%%14`.
#### Status
Red.
#### Source
Cycle 07 Sprint 02 Flutter shared-beta model design, Main J sections 17–18, and A/B/C restaging.

---

# Canonical Boundary

Cycle 07 Sprint 02 introduces the Flutter shared-beta model concepts as **Red** because model-design discussion establishes reusable concept identity, not learner mastery. No existing maturity changed. Authoritative Fact / Derived Projection remains owned by `&&&02`; Purchase atomicity extends `&%%05`; Row Ownership remains an Authorization example; composition root and lifecycle remain related to existing responsibility/resource concepts; protocol versioning belongs to `&%%14`; storage-schema versioning remains related to `%%%01`; and append-only event identity remains distinct from Dart immutability.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.

# Cycle 07 Sprint 03 Local Evidence Reconciliation

> Evidence source: `DEV_STAGE/H_DDC_CODEX.md` and Main J §19  
> Evidence class: implemented and unit-tested locally; platform and distributed behavior remain unvalidated  
> Maturity effect: none

Local executable evidence now strengthens the project manifestations of:

```text
&&&06 Stable Identity
&&&10 Historical Integrity
&&%05 Immutable Dart Model
&%%07 Reusable Catalogue
&%%08 Product Identification Set and Deterministic Normalization
&%%09 Purchase Aggregate
&%%10 Purchase Item
&%%11 Append-Only Synchronization Event
&%%12 Offline Queue and Idempotent Delivery
&%%15 Dimensional Quantity
&%%16 Monetary Minor Unit
&%%17 Versioned Analytic
%%%07 Flutter Framework and Responsive Widget Composition
```

The evidence demonstrates immutable Dart domain/value objects, account-private catalogue identities, PACKAGED/BULK rules, dimensional quantities, integer minor-unit money, aggregate validation and rollback, atomic persistence of Purchase/Items/local event/pending queue, close/reopen preservation, and a minimal identifier/version analytics registry. Drift is implemented for the fresh local foundation. Flutter scaffolding and tests execute, while responsive composition and target-platform runtime do not.

Evidence limits remain canonical:

- `&%%08`: normalization passes basic unit-equivalence fixtures, but Unicode/Portuguese behavior and cross-language canonical bytes remain provisional.
- `&%%12`: an offline queue row is prepared atomically; real server retry/idempotency is not implemented.
- `&%%13`: device/cursor structure is partial and repeated device sequence likely resets; monotonic ordering is not established.
- `&%%14`: JSON files are versioned semantic fixtures/contract examples, not a complete validated sync protocol.
- `&&&07`, `&&&08`, and `&&&09`: authentication, authorization, and eventual consistency remain unimplemented.
- `%%%07`: Flutter framework setup is evidenced; Windows, Android, iOS, responsive UI, and lifecycle execution remain host-unvalidated.
- Schema version 1 supports fresh creation; upgrade/migration recovery is unvalidated.

No status changes. Project execution evidence is not explicit learner evidence.

# Cycle 07 Sprint 04 Local Workflow Evidence Reconciliation

> Evidence sources: `DEV_STAGE/H_DDC_CODEX.md`, Main J §21, current Flutter source/tests, and `contracts/shared_beta/v2/`  
> Evidence class: implemented and tested locally, with Windows host validation  
> Maturity effect: none

Sprint 04 strengthens project evidence for `&&&06`, `&&&10`, `&&%05`, `&%%07`–`&%%13`, `&%%15`–`&%%17`, and `%%%07`. Product code, immutable local record UUID, and versioned semantic identification are now separate responsibilities. NFKC-based normalization, PACKAGED/BULK rules, atomic Purchase/event/queue persistence, monotonic device sequencing, v1-to-v2 migration, multi-item Flutter workflow, local history, and Windows build/launch evidence are implemented and tested within the reported boundary.

Canonical limits remain:

- `&%%08`: deterministic normalization is evidenced in Dart and fixtures, but cross-language parity and any future central catalogue assignment remain unproved.
- `&%%12`: durable queue creation and rollback are local delivery preparation; server retry/deduplication is absent.
- `&%%13`: per-device monotonic allocation is now locally evidenced; no server cursor exists.
- `&%%14`: v2 JSON Schemas and examples define a stronger structural contract, not a complete implemented Sync Protocol.
- `&&&07`, `&&&08`, and `&&&09`: authentication, authorization, and eventual consistency remain unimplemented.
- `%%%07`: responsive widget behavior and Windows execution are evidenced; Android is tooling-blocked, iOS host-unvalidated, and manual UI acceptance open.
- A future central Product UUID is not the user Product code or current local Product record UUID and remains deferred.

No KANBAN status changes. Implementation evidence is not learner evidence.
