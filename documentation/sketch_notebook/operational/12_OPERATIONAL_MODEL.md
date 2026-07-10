# 12_OPERATIONAL_MODEL.md

> Version: Recovery draft 0.1
> Status: Canonical operational reconstruction in progress
> Persistence Class: Canonical
> Knowledge Class: Operational
> Authority: Operational Chat under explicit human-directed recovery
> Scope: Stable execution, persistence, migration, resource, lifecycle, and validation conventions for Markei

---

# 1. Purpose

This file defines stable operational knowledge for executing, validating, packaging, and maintaining Markei.

It records operational rules and boundaries that are sufficiently supported by repository implementation and Main-level continuity evidence.

It does not record:

- transient implementation hypotheses;
- current blockers or TODO pressure;
- session chronology;
- unvalidated defect claims;
- architecture decisions owned by the Design domain;
- learning explanations owned by the Didactic domain.

Those belong in the appropriate stage, derived, checkpoint, observational, design, or didactic surfaces.

---

# 2. Current Execution Model

The accepted executable dependency chain is:

```text
Desktop presentation
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

Operational responsibilities follow this chain:

- desktop presentation starts user workflows and renders results;
- `ProductService` coordinates business workflows, validation, calculations, settings interpretation, and UI-facing read models;
- `Repository` owns SQL execution, persistence operations, and row-to-model mapping;
- the Database Manager owns database paths, connection creation, connection configuration, initialization, migration, and connection closure;
- SQLite owns durable local data and declared relational constraints.

Operational validation should preserve this direction. Presentation code should not be validated as the owner of SQL or database lifecycle behavior, and Repository behavior should not be treated as the owner of business interpretation.

---

# 3. Application Entrypoint

The desktop startup chain is:

```text
main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ Qt event loop
```

The entrypoint is responsible for creating the Qt application, constructing the main window, displaying it, and starting the event loop.

Entrypoint validation should confirm both supported developer execution forms when they remain present:

```powershell
python main.py
python -m app.main
```

A successful import or process start is not by itself full desktop validation. The visible window, page construction, persistence access, shutdown, and data continuity must be checked separately.

---

# 4. Database Connection Configuration

Every SQLite connection created through Markei's Database Manager must be configured consistently.

The current connection contract includes:

```text
PRAGMA foreign_keys = ON
PRAGMA journal_mode = WAL
PRAGMA synchronous = NORMAL
row_factory = sqlite3.Row
```

Operational consequences:

- relational delete and update behavior depends on both declared schema actions and foreign-key enforcement;
- WAL mode may create database-adjacent `-wal` and `-shm` files during execution;
- row mapping expects named-column access through `sqlite3.Row`;
- validation of a connection must verify configuration on the connection being tested rather than assume global SQLite state.

A minimum connection check is:

```powershell
python -c "from app.core.database import connect; c=connect(); print(c.execute('PRAGMA foreign_keys').fetchone()[0]); c.close()"
```

---

# 5. Initialization Model

When the writable database does not exist, `connect()` initiates first-launch initialization.

The initialization sequence is:

```text
create user-data directory
→ open SQLite database
→ configure connection
→ execute schema.sql
→ execute seed.sql only when present
→ commit
→ close initialization connection
→ open the requested configured connection
→ run compatibility migration
```

Existing user data must be preserved unless a destructive recreation operation is explicitly requested.

A fresh database with empty business tables is a valid initialized state. It must not be confused with an uninitialized or broken database.

Production initialization should be schema-driven. Sample business data, a prebuilt live database, and SQLite WAL/SHM files are not production initialization inputs.

---

# 6. Resource And User-Data Separation

Bundled application resources and writable user data are separate operational classes.

Current resource placement:

```text
bundled resources
    app/database/schema.sql
    app/database/seed.sql when intentionally present
```

Current writable state placement:

```text
%LOCALAPPDATA%/Markei/<database name>
```

with a home-directory fallback when `LOCALAPPDATA` is unavailable.

Operational rules:

1. Bundled resources are replaceable application inputs.
2. The live SQLite database is persistent user data.
3. The live database must remain outside the installed runtime directory.
4. Packaging must include every required schema resource.
5. Production packaging must exclude development seed data unless explicitly approved.
6. External user-data placement supports preservation, but upgrade, uninstall, and reinstall preservation require direct lifecycle validation.

Resource lookup supports source execution and frozen execution. The presence of frozen-path code does not prove that a generated artifact contains the required resources.

---

# 7. Migration Model

Existing databases are upgraded through an idempotent compatibility migration executed during connection creation.

The current migration mechanisms include:

```text
PRAGMA table_info
→ detect missing columns
→ ALTER TABLE ... ADD COLUMN for additive nullable fields
→ CREATE TABLE IF NOT EXISTS
→ INSERT OR IGNORE default settings
→ commit
```

Stable operational rules:

- migration runs before Repository use;
- repeated connection and migration execution should preserve the same compatible schema state;
- default-setting insertion must not overwrite user-selected values;
- migration helpers that interpolate identifiers or definitions must receive only trusted internal constants;
- additive compatibility migration is not equivalent to a complete versioned migration system;
- table rebuilds, destructive changes, renames, data transforms, and constraint changes require an explicitly staged migration plan and stronger rollback evidence.

Current code-based compatibility migration does not by itself establish an ordered migration ledger. Schema-version compatibility must be treated as an explicit operational concern before complex evolution.

---

# 8. Repository Connection Lifetime

A Repository instance owns:

```text
one SQLite connection
+ one cursor derived from that connection
```

Repository provides explicit lifecycle operations:

```text
close()
__enter__()
__exit__()
is_open
in_transaction
```

Operational rules:

1. Every opened Repository must have an identifiable owner.
2. The owner must close it deterministically or use its context-manager boundary.
3. Process termination is not a substitute for an explicit lifecycle contract.
4. Destructive reset or database replacement must not proceed while owned connections remain open.
5. Tests must isolate and close repositories so connection leakage does not contaminate later validation.

The exact desktop composition owner and shutdown implementation remain subjects for further validation and design reconciliation; they are not defined canonically here.

---

# 9. Transaction And Commit Model

Repository write methods currently use statement-level execution followed by explicit commit.

Statement-level commit provides prompt durability for an isolated persistence operation.

It does not automatically guarantee atomicity for a business workflow composed of several Repository calls.

Operational validation must distinguish:

```text
statement atomicity
≠
workflow atomicity
```

For a multi-step service workflow, validation should inject failure between persistence steps and classify the result:

```text
all workflow changes absent
→ workflow transaction is atomic under the tested failure

partial workflow changes present
→ workflow transaction boundary is incomplete under the tested failure
```

Transaction-boundary ownership is not established merely by the existence of Repository commits. Any stronger workflow transaction policy requires direct implementation evidence and design agreement.

---

# 10. Reset Safety

Database reset is destructive recreation.

Operational rules:

- reset must be treated as a development or controlled maintenance operation;
- reset validation must use isolated test data and an isolated user-data directory;
- reset must not be run against the ordinary user database during exploratory validation;
- open connections, WAL/SHM files, backup behavior, confirmation, failure recovery, and rollback must be considered before reset is exposed through an ordinary user workflow.

A destructive operation is not safe merely because its behavior is explicit in code.

---

# 11. Validation Evidence Model

Operational status must distinguish configuration, implementation, and evidence.

Use the following vocabulary:

- `implemented`: behavior or configuration exists in repository files;
- `validated`: direct evidence demonstrates the claimed behavior under stated conditions;
- `configured but unvalidated`: source configuration exists but generated, runtime, or installed behavior lacks direct evidence;
- `blocked`: required validation cannot proceed because a prerequisite is unavailable;
- `deferred`: intentionally excluded from the active scope.

Validation should progress through the actual lifecycle being claimed.

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

Evidence from an earlier state must not be promoted as proof of a later state.

---

# 12. Minimum Validation Layers

## 12.1 Static and import validation

```powershell
python -m compileall app main.py
```

Purpose:

- detect syntax errors;
- detect basic import failures;
- confirm modules can be compiled in the active environment.

## 12.2 Fresh initialization validation

Use an isolated `LOCALAPPDATA` location.

Confirm:

- the user-data directory is created;
- expected tables exist;
- foreign keys are enabled;
- the live database is outside bundled resources;
- business tables are empty unless seed behavior is intentionally under test.

## 12.3 Migration idempotence validation

Open and close the same isolated database repeatedly.

Confirm:

- migration completes on each connection;
- columns are not duplicated;
- settings defaults are not duplicated;
- existing user settings are not overwritten.

## 12.4 Repository lifecycle validation

Confirm:

- Repository reports open after construction;
- `close()` releases the connection;
- context-manager exit closes the connection;
- repeated tests do not retain database locks.

## 12.5 Workflow failure validation

Inject failures between service-level persistence steps and inspect durable state afterward.

## 12.6 Desktop smoke validation

Confirm:

- one visible MainWindow;
- Register, Lists, History, and Settings surfaces load;
- list modes change correctly;
- a write refreshes dependent views;
- closing terminates without retained database locks;
- reopening preserves data.

## 12.7 Packaged-runtime validation

Confirm generated artifacts locate bundled schema resources and create or reuse the external user database under user-like execution conditions.

---

# 13. Production Packaging Rules

A packaging specification or installer script is a source artifact.

A generated application directory, executable, or installer is a generated artifact.

Operational rules:

- source configuration does not prove artifact generation;
- artifact generation does not prove runtime correctness;
- runtime launch does not prove installed lifecycle correctness;
- production artifacts must not contain a prebuilt live user database;
- production artifacts must not contain sample business records unless explicitly part of the product;
- production artifacts must not ship transient SQLite WAL/SHM files;
- user-data preservation requires direct upgrade, uninstall, and reinstall testing;
- signing, SmartScreen reputation, antivirus behavior, rollback, and automatic update are separate release-hardening concerns.

---

# 14. Current Structural Boundary

The current operationally accepted boundary is:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

This boundary is sufficiently established to support current-state recovery and validation planning.

It does not prove that:

- service construction is optimally centralized;
- all repositories are closed deterministically at application shutdown;
- service workflows are transactionally atomic;
- Repository contracts are complete for every adapter;
- the application is ready for mobile implementation;
- a configured installer has been compiled or lifecycle-validated.

Those claims require further evidence and, where responsibility ownership is involved, Design-domain reconciliation.

---

# 15. Canonical Maintenance Rule

This canonical model should be reconciled when stable operational behavior changes.

Updates should be supported by one or more of:

- repository implementation evidence;
- reproducible validation output;
- Codex materialization reports;
- accepted Main synthesis;
- explicit human direction.

Current blockers, experiments, and unverified risks should remain in Operational stage, TODO, checkpoint, or observational memory until classification and validation justify canonical promotion.
