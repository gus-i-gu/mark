# 12_OPERATIONAL_MODEL.md

> Version: Recovery reconstruction 0.2
> Status: Canonical operational knowledge
> Persistence Class: Canonical
> Knowledge Class: Operational
> Authority: Operational Chat under explicit human-directed recovery and Main reconciliation
> Reconciliation sources: `DEV_STAGE/A_OPERATIONAL.md` + `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Stable execution, persistence, database lifecycle, resource ownership, connection lifetime, transaction behavior, and validation conventions for Markei

---

# 1. Purpose

This file defines the accepted operational model of Markei as reconstructed during the Sketch Notebook recovery cycle.

It contains stable execution facts, operational boundaries, and repeatable validation conventions supported by:

```text
current repository implementation
+
Operational functional staging
+
Main cross-domain reconciliation
```

It does not own:

- current task priority or risk ordering;
- temporary validation experiments;
- session chronology;
- unresolved architectural choices;
- didactic explanations;
- historical intent inferred from commits.

Those belong respectively in the Operational TODO, checkpoint, observational record, Design domain, Didactic domain, or later historical investigation.

---

# 2. Contemporary Runtime Model

Markei currently operates as a layered local PySide6 desktop application backed by SQLite.

The executable and dependency spine is:

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

The current operational responsibility direction is:

```text
Desktop presentation
    receives input, renders widgets, coordinates navigation and refresh

ProductService
    validates and coordinates workflows, performs calculations,
    interprets settings, and assembles UI-consumable projections

Repository
    executes SQL, maps rows and models, commits mutations,
    and owns one SQLite connection and cursor per instance

Database Manager
    resolves resource and user-data paths, creates and configures connections,
    initializes schema, applies compatibility migration, and exposes close/reset

SQLite and SQL resources
    persist user state and define the creation schema
```

Desktop code does not execute SQL directly. Domain models do not own persistence operations. Repository behavior must not be treated as the owner of business interpretation, and presentation behavior must not be treated as the owner of database lifecycle.

---

# 3. Supported Entrypoints

The current desktop startup chain supports these developer execution forms:

```powershell
python main.py
python -m app.main
```

The entrypoint creates the Qt application, constructs `MainWindow`, displays it, and starts the Qt event loop.

An import succeeding or a process starting is not complete desktop validation. Operational acceptance must separately verify:

- visible MainWindow construction;
- page construction;
- database access;
- user workflow execution;
- view refresh;
- shutdown behavior;
- persistence across reopening.

---

# 4. Desktop Composition

`MainWindow` composes four visible application surfaces:

```text
Register
Lists
History
Settings
```

The earlier Storage, Shortage, and Market concepts are currently represented as Lists modes:

```text
Storage  → in-house
Shortage → shortage
Market   → to-buy
```

Operational page roles are:

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

Desktop pages call `ProductService`, not Repository or SQLite directly.

---

# 5. Database Resource and User-Data Model

Bundled SQL resources and writable runtime data are separate operational classes.

Current bundled resources:

```text
app/database/schema.sql
app/database/seed.sql
```

Current writable runtime database:

```text
%LOCALAPPDATA%/Markei/market.sqlite
```

A home-directory fallback is used when `LOCALAPPDATA` is unavailable.

Source and frozen execution are accounted for through resource-base resolution using `sys.frozen` and `_MEIPASS` behavior.

Operational rules:

1. SQL resources are replaceable application inputs.
2. The live SQLite database is persistent user data.
3. The live database belongs outside the installed runtime directory.
4. A generated package must include every required SQL resource.
5. Resource-path code does not prove that a generated artifact contains those resources.
6. External database placement supports preservation, but upgrade, uninstall, and reinstall preservation require direct lifecycle evidence.
7. A prebuilt live user database and transient SQLite WAL/SHM files are not valid bundled production state.

The current seed contains baseline category, store, and settings rows plus an example Rice product. Which seed rows are required product defaults and which are demonstration data is unresolved. Production seed policy therefore remains a TODO/human decision, not canonical release acceptance.

---

# 6. SQLite Connection Configuration

Every SQLite connection obtained through the Database Manager is configured with:

```text
PRAGMA foreign_keys = ON
PRAGMA journal_mode = WAL
PRAGMA synchronous = NORMAL
row_factory = sqlite3.Row
```

Operational consequences:

- declared foreign-key actions are enforced only on configured connections;
- WAL mode may create adjacent `-wal` and `-shm` files during execution;
- Repository row mapping depends on named-column access;
- connection configuration must be validated on the actual connection under test rather than assumed as global SQLite state.

A minimum configuration probe is:

```powershell
python -c "from app.core.database import connect; c=connect(); print(c.execute('PRAGMA foreign_keys').fetchone()[0]); c.close()"
```

---

# 7. Initialization Model

When the writable database does not exist, `connect()` initiates first-launch initialization.

The current sequence is:

```text
create user-data directory
→ preserve existing database unless recreate=True
→ create SQLite database
→ configure connection
→ execute schema.sql
→ execute seed.sql when present
→ commit
→ close initialization connection
→ open requested configured connection
→ apply compatibility migration
```

Operational rules:

- existing user data is preserved unless destructive recreation is explicitly requested;
- initialization and migration are separate lifecycle responsibilities;
- seed execution is automatic when the resource exists;
- an initialized database may contain seed-provided rows;
- whether seeded business/example data is acceptable in a production artifact must be decided and validated explicitly.

---

# 8. Compatibility Migration Model

Existing databases are upgraded through a compatibility migration invoked during connection creation.

The current mechanism is:

```text
open configured connection
→ inspect schema with PRAGMA table_info
→ add currently required nullable columns when absent
→ create required table when absent
→ insert default settings with INSERT OR IGNORE
→ commit
```

Current migration behavior is additive and idempotent for the encoded changes.

Stable operational rules:

- migration completes before Repository use;
- repeated connection/migration execution should converge on the same compatible schema state;
- default insertion must not overwrite user-selected settings;
- helpers that interpolate identifiers or definitions must receive trusted internal constants only;
- additive compatibility migration is not a complete versioned migration framework;
- no numbered migration ledger or schema-version table currently records migration history;
- table rebuilds, destructive changes, renames, data transformations, and constraint changes require an explicitly staged migration plan with backup, failure, and rollback evidence.

Complex future migration safety is not established by the present additive mechanism.

---

# 9. Repository and Service Connection Ownership

One Repository instance owns:

```text
one SQLite connection
+
one cursor derived from that connection
```

Repository exposes:

```text
close()
__enter__()
__exit__()
is_open
in_transaction
```

`ProductService.close()` delegates to its Repository close operation.

Current desktop construction is:

```text
RegisterPage → ProductService → Repository → SQLite connection
ListsPage    → ProductService → Repository → SQLite connection
HistoryPage  → ProductService → Repository → SQLite connection
SettingsPage → ProductService → Repository → SQLite connection
```

Normal MainWindow construction therefore creates four long-lived service, repository, and connection chains.

Cleanup capability exists locally at ProductService and Repository level. Page-level cleanup attempts exist, but no single composition-level shutdown owner is established.

Operational rules:

1. Every opened Repository must have an identifiable owner.
2. Each owner must close its Repository deterministically or use context management.
3. Process termination is not a substitute for an explicit lifecycle contract.
4. Shutdown validation must verify all four page-owned services and connections.
5. Destructive reset or database replacement must not proceed while owned connections remain open.
6. Tests must close all repositories so database locks and WAL state do not contaminate later runs.

Distributed ownership is the confirmed current model. Whether ownership should be centralized is a Design decision, not an Operational canonical conclusion.

---

# 10. Shutdown Model

The application has local cleanup capability but implicit application-wide shutdown ownership.

Accepted current statement:

```text
service/repository close capability exists
+
page-level cleanup attempts exist
but
no single composition-level shutdown owner is established
```

This statement does not prove a runtime leak.

Operational validation must establish:

- whether every page-owned service receives deterministic cleanup during normal window closure;
- whether all four repositories report closed after Qt shutdown;
- whether shutdown emits cleanup exceptions;
- whether database locks or WAL/SHM state prevent immediate reopening, reset, or isolated test cleanup.

---

# 11. Commit and Transaction Model

Repository mutation methods commit after individual persistence operations.

Receipt registration follows a multi-step workflow:

```text
create or update Product
→ insert Purchase
→ recalculate Product
→ update Product summary
```

Purchase deletion followed by summary recalculation also spans multiple commits.

Therefore:

```text
statement-level commit
≠
workflow-level transaction
```

Receipt registration and purchase-deletion workflows are not transactionally atomic across the complete business operation. Failure after an earlier committed mutation can leave partial durable state.

This establishes the current transaction model; it does not prove failures occur frequently.

Operational validation should inject failure after each mutation boundary and inspect durable state. Whether best-effort sequential consistency remains acceptable or a workflow transaction boundary is introduced is a later Design/human decision.

---

# 12. Reset Safety

`reset()` performs destructive recreation by initializing with `recreate=True`, removing the active database file before rebuilding it.

Operational rules:

- reset is a development or controlled-maintenance capability;
- reset validation must use isolated test data and an isolated user-data directory;
- exploratory reset must never target the ordinary user database;
- open connections and SQLite WAL/SHM files must be accounted for before recreation;
- backup, confirmation, failure recovery, and rollback are required concerns before reset can become an ordinary user-facing action.

A destructive operation is not safe merely because its behavior is explicit in source code.

---

# 13. Validation Evidence Vocabulary

Operational reporting must distinguish implementation from proof.

Use:

- `implemented`: behavior or configuration exists in repository files;
- `validated`: direct evidence demonstrates the claim under stated conditions;
- `configured but unvalidated`: source configuration exists, but generated, runtime, or installed behavior lacks direct evidence;
- `blocked`: validation cannot proceed because a prerequisite is unavailable;
- `deferred`: intentionally excluded from the active scope.

Evidence from an earlier lifecycle state must not be promoted as proof of a later state.

For packaged desktop delivery:

```text
packaging configured
→ generated artifact built
→ generated artifact launched
→ installer compiled
→ installer installed
→ installed launch validated
→ upgrade/uninstall/reinstall lifecycle validated
→ release acceptance
```

---

# 14. Isolated Validation Convention

Database validation that creates, migrates, resets, corrupts, or injects failure must use an isolated user-data root.

PowerShell pattern:

```powershell
$env:LOCALAPPDATA = "$PWD\.tmp-localappdata"
Remove-Item -Recurse -Force $env:LOCALAPPDATA -ErrorAction SilentlyContinue
```

Operational rules:

- never perform destructive or migration experiments against ordinary user data;
- close every connection before deleting an isolated validation directory;
- record the exact environment, command, expected result, and actual result;
- distinguish source inspection from executed validation evidence.

---

# 15. Minimum Validation Layers

## 15.1 Static and import validation

```powershell
python -m compileall app main.py
```

Purpose:

- detect syntax errors;
- detect basic import failures;
- confirm modules compile in the active environment.

## 15.2 Fresh initialization validation

Using isolated `LOCALAPPDATA`, verify:

- user-data directory creation;
- expected table creation;
- connection configuration;
- database placement outside bundled resources;
- exact seed-created rows.

## 15.3 Migration idempotence validation

Repeatedly open and close the same isolated database and verify:

- migration completes each time;
- columns are not duplicated;
- default settings are not duplicated;
- existing user-selected settings are not overwritten.

## 15.4 Repository and service lifecycle validation

Verify:

- Repository is open after construction;
- `Repository.close()` closes it;
- Repository context-manager exit closes it;
- `ProductService.close()` closes its Repository;
- all four page-owned service chains close during application shutdown;
- repeated tests retain no database locks.

## 15.5 Transaction-failure validation

Inject failures between each receipt and deletion workflow mutation. Record which Product, Purchase, and calculated-summary changes remain durable.

## 15.6 Reset validation

Against isolated data only, test reset with:

- no open connection;
- an intentionally open Repository;
- WAL/SHM files present;
- immediate reconnect after reset.

## 15.7 Desktop smoke validation

Verify:

- one visible MainWindow;
- Register, Lists, History, and Settings load;
- Lists modes switch correctly;
- receipt registration refreshes Lists and History;
- Settings/store operations behave as expected;
- closing the application releases all database resources;
- reopening preserves durable state.

## 15.8 Packaged-runtime validation

Verify generated artifacts:

- locate bundled SQL resources;
- initialize or reuse the external user database;
- do not bundle a prebuilt live database or transient WAL/SHM files;
- contain only seed data explicitly accepted for production;
- preserve user data through the lifecycle being claimed.

---

# 16. Production Packaging Boundary

A packaging specification or installer script is a source artifact.

A generated application directory, executable, or installer is a generated artifact.

Operational rules:

- source configuration does not prove artifact generation;
- artifact generation does not prove runtime correctness;
- runtime launch does not prove installed lifecycle correctness;
- generated artifacts require direct resource and user-data validation;
- production seed content requires explicit acceptance rather than assumption;
- user-data preservation requires direct upgrade, uninstall, and reinstall testing;
- signing, SmartScreen reputation, antivirus behavior, rollback, and automatic update remain separate release-hardening concerns.

---

# 17. Canonical Boundary and Open Decisions

The canonical Operational model establishes current behavior and validation responsibilities. It does not decide the desired future architecture.

The following are confirmed present-state facts:

- four page-owned ProductService/Repository/connection chains;
- explicit local close capability;
- implicit application-wide shutdown ownership;
- additive compatibility migration without a version ledger;
- statement-level commits and multi-commit non-atomic receipt/deletion workflows;
- bundled SQL resources separated from writable user data;
- broad ProductService and Repository facades;
- partial abstract contracts relative to concrete runtime surfaces.

The following remain outside Operational canon as intended-future decisions:

- whether service/connection ownership should be centralized;
- which composition object should own shutdown;
- whether workflow atomicity must be introduced;
- whether ProductService or Repository should be split;
- whether contracts should become complete substitutable interfaces;
- whether migration should become startup-centralized and versioned;
- whether current seed example data belongs in production;
- whether persisted `pages.order` should be consumed, migrated, or retired.

These decisions belong to Main/human synthesis with Design-domain ownership where architectural responsibility is involved.

---

# 18. Canonical Maintenance Rule

This file must be reconciled when stable operational behavior changes.

Acceptable supporting evidence includes:

- current repository implementation;
- reproducible validation output;
- Codex materialization reports;
- accepted Main reconciliation;
- explicit human direction.

Current priority, unresolved validation, experiments, and recovery progress belong in `04_TODO.md` or `10_OPERATIONAL_STATE.md` until the planned checkpoint-completion milestone justifies the first append to `11_OPERATIONAL_RECORD.md`.
