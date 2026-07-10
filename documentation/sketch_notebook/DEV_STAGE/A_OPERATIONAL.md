# Operational Structural System Review

> Status: Active functional stage
> Role: Operational Chat [O]
> Branch: `sketch-notebook-recovery`
> Scope: `app/core/`, `app/database/`, and `app/desktop/`
> Knowledge state: staged operational evidence and hypotheses; not canonical
> Write boundary: only `DEV_STAGE/A_OPERATIONAL.md` was modified

---

## 1. Review Objective

Recover the current executable and persistence structure from repository implementation after the operational notebook domain was intentionally pruned.

Priority order followed:

```text
app/core/
↓
app/database/
↓
app/desktop/
↓
commit-oriented analysis deferred
```

The review concentrates on:

- database execution;
- migration safety;
- resource bundling;
- connection lifetime;
- shutdown behavior;
- validation commands;
- implementation facts relevant to later Sketch Notebook repopulation.

The GitHub connector does not expose directory listings through `fetch_file`, and code search did not return indexed paths. Structure was therefore recovered through known entrypoints, direct file reads, and import edges. Statements below distinguish observed facts from operational inferences.

---

## 2. Recovered Execution Structure

Observed executable chain:

```text
main.py
→ app.main.main()
→ QApplication
→ app.desktop.main_window.MainWindow
→ desktop pages
→ app.core.services.ProductService
→ app.core.repository.Repository
→ app.core.database.connect()
→ SQLite database
```

`app/main.py` owns Qt application creation, window display, and event-loop startup. It does not currently construct or own the service/repository graph and does not register an explicit database shutdown hook.

Current public desktop composition observed in `MainWindow`:

```text
MainWindow
├── RegisterPage
├── ListsPage
├── HistoryPage
└── SettingsPage
```

The former Storage, Shortage, and Market surfaces are represented as internal views of the unified Lists page. `MainWindow` supplies navigation helpers that select `in-house`, `shortage`, or `to-buy` list modes.

---

## 3. `app/core/` Structural Picture

### 3.1 Observed modules

Files directly inspected:

```text
app/core/contracts.py
app/core/database.py
app/core/repository.py
app/core/services.py
```

Additional imported core module observed:

```text
app/core/models.py
app/core/config.py
```

### 3.2 Responsibility chain

Observed implementation boundaries:

```text
contracts.py
    declares domain, repository, and service interfaces/invariants

models.py
    supplies Product, Purchase, Category, and Store objects

services.py
    owns business workflows, validation, calculations, settings interpretation,
    and UI-facing read-model assembly

repository.py
    owns SQL execution and row-to-model mapping

database.py
    owns resource paths, user-data paths, connection configuration,
    initialization, migration, and close operations
```

The intended dependency direction is explicit in module documentation and imports:

```text
Desktop presentation
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

No SQL was observed in the sampled desktop or service code. Repository SQL and database lifecycle remain separated at module level.

### 3.3 Contracts versus implementation

`RepositoryContract` defines only part of the concrete repository surface. The concrete Repository additionally exposes category, store, settings, history-row, summary-row, maintenance, and connection-state operations.

Operational implication:

- the abstract contract documents the minimum persistence boundary;
- it is not currently a complete substitutability contract for the concrete Repository;
- tests or future adapters relying only on `RepositoryContract` may not cover the actual ProductService dependency surface.

This is a design-facing observation but has operational consequences for test doubles, platform adapters, and recovery accuracy.

### 3.4 Service construction

`ProductService.__init__()` constructs `Repository()` directly.

Observed chain per service instance:

```text
ProductService()
→ Repository()
→ connect()
→ one SQLite connection + one cursor
```

Operational consequence:

- connection ownership is implicitly attached to each service instance;
- dependency injection is not currently available at the constructor boundary;
- lifecycle control depends on whether ProductService exposes and callers invoke a corresponding close operation.

---

## 4. `app/database/` Structural Picture

### 4.1 Observed resources

Directly inspected:

```text
app/database/schema.sql
```

Configured resource names indicate:

```text
schema.sql
seed.sql
```

The database manager computes resource paths under:

```text
<resource_base>/app/database/
```

and the writable database path under:

```text
%LOCALAPPDATA%/Markei/<DATABASE_NAME>
```

with a home-directory fallback for environments without `LOCALAPPDATA`.

### 4.2 Resource versus user data separation

Observed separation:

```text
bundled, replaceable resources
    app/database/schema.sql
    app/database/seed.sql when present

persistent writable state
    %LOCALAPPDATA%/Markei/market.sqlite
```

`resource_base()` supports source execution and frozen execution through `sys.frozen` and `sys._MEIPASS` handling.

Operational classification:

- resource/user-data boundary: implemented;
- source and frozen resource lookup: implemented in code;
- successful bundling of every required resource: requires artifact validation;
- preservation through installer upgrade/uninstall/reinstall: cannot be inferred from path placement alone.

### 4.3 Schema state

Observed tables:

```text
products
purchases
categories
stores
settings
promotions
```

Observed indexes:

```text
idx_product_name
idx_purchase_product
idx_purchase_date
```

Observed referential behavior:

- purchases reference products with `ON UPDATE CASCADE` and `ON DELETE CASCADE`;
- purchases reference stores without explicit delete/update actions;
- products reference categories without explicit delete/update actions;
- promotions reference products and stores without explicit cascade rules.

Operational note: foreign-key enforcement is enabled per configured connection, so delete/update behavior depends on these declared actions rather than merely on schema relationships.

### 4.4 Initialization behavior

`connect()` initializes the database automatically when the database file is absent.

Initialization sequence observed:

```text
create user-data directory
→ preserve existing database unless recreate=True
→ create SQLite connection
→ apply connection configuration
→ execute schema.sql
→ execute seed.sql when the file exists
→ commit
→ close initialization connection
```

Important operational distinction:

- a missing `seed.sql` is accepted;
- a present `seed.sql` is always executed during fresh initialization;
- production cleanliness therefore depends on packaging rules excluding development/sample seed material, not only on database code.

### 4.5 Migration behavior

Current migration mechanism is an inline idempotent compatibility routine invoked by every `connect()`.

Observed upgrades:

```text
purchases.expiration_date
products.average_shelf_life_days
products.expected_expiration_date
stores.address
settings table
six default settings rows
```

Migration techniques:

```text
PRAGMA table_info
→ add missing nullable columns with ALTER TABLE
→ CREATE TABLE IF NOT EXISTS
→ INSERT OR IGNORE defaults
→ commit
```

Operational strengths:

- current operations are repeatable;
- default settings preserve user choices;
- migration occurs before Repository use;
- schema compatibility is checked on every opened connection.

Operational limitations and risks:

1. No explicit schema-version table or ordered migration ledger was observed.
2. Migration history exists only as current Python code; previously applied transformations are not durably identified.
3. `ensure_column()` interpolates table, column, and definition strings. Current arguments are static internal constants, but the helper must remain inaccessible to untrusted input.
4. The migration commit is explicit, but the routine is not wrapped in an explicit all-or-nothing transaction covering every future migration step.
5. The current pattern handles additive nullable columns and idempotent defaults well, but destructive changes, renames, data transforms, constraint changes, and table rebuilds will require a stronger migration protocol.
6. Every new service-created connection repeats migration checks, increasing startup work and widening the number of locations where migration failure may surface.

Current classification:

```text
additive compatibility migration: implemented
current migration idempotence: structurally credible, execution validation required
versioned migration system: absent
complex migration safety: not established
```

### 4.6 Reset safety

`reset()` delegates to `initialize(recreate=True)`, which unlinks the live database file before rebuilding it.

Operational status:

- destructive behavior is explicit in code;
- no backup, confirmation, open-connection coordination, WAL/SHM cleanup, or rollback mechanism was observed;
- reset must remain a development/maintenance operation and must not be exposed as an ordinary user action without additional safeguards.

---

## 5. Connection Lifetime And Shutdown Review

### 5.1 Repository lifecycle

Repository construction opens one connection and one cursor:

```text
Repository.__init__
→ connect()
→ connection.cursor()
```

Repository exposes:

```text
close()
__enter__()
__exit__()
is_open
in_transaction
```

This provides a valid explicit/context-manager lifecycle at repository level.

### 5.2 Desktop ownership pattern

Observed desktop pages instantiate ProductService directly. Confirmed examples:

```text
RegisterPage.service = ProductService()
ListsPage.service = ProductService()
```

MainWindow also constructs HistoryPage and SettingsPage, whose imports and role strongly imply the same page-owned service pattern; those constructors should be verified directly in the next bounded inspection.

With the confirmed pages alone:

```text
MainWindow
├── RegisterPage → ProductService → Repository → SQLite connection
└── ListsPage    → ProductService → Repository → SQLite connection
```

Likely full current shape, pending direct verification of the remaining constructors:

```text
one desktop window
→ multiple page-owned ProductService instances
→ multiple Repository instances
→ multiple long-lived SQLite connections
```

### 5.3 Shutdown gap

`app/main.py` starts the Qt event loop and exits through `sys.exit(app.exec())`.

`MainWindow` as inspected has no `closeEvent`, application `aboutToQuit` handler, shared service owner, or explicit repository close loop.

Operational conclusion:

- Repository supports explicit closure;
- the desktop composition does not currently demonstrate that close is called;
- normal process termination will release OS resources eventually, but deterministic transaction completion, WAL cleanup behavior, test isolation, reset safety, and in-process restart behavior should not rely on process teardown;
- connection lifetime is currently page lifetime by construction, but shutdown ownership is undefined.

Recommended operational target:

```text
application composition root owns service/repository lifecycle
→ pages receive shared service or explicit scoped services
→ Qt shutdown signal closes owned repositories exactly once
→ destructive reset is blocked while owned connections remain open
```

This recommendation is staged, not approved architecture.

---

## 6. Transaction And Write Behavior

Repository write methods generally execute one SQL statement and immediately call `commit()`.

Observed examples:

```text
create/update/delete Product
insert/delete Purchase
```

Operational implications:

- simple single-statement persistence is durable promptly;
- multi-step ProductService workflows may span several independently committed repository calls;
- service-level business operations such as receipt registration and summary recalculation may therefore be partially materialized if a later step fails.

A commit-per-method repository is safe for isolated operations but does not itself guarantee atomic business workflows.

Required next verification:

1. Trace `ProductService.register_receipt()` completely.
2. List every repository write invoked by the workflow.
3. Inject failure after each step.
4. Confirm whether partial Product/Purchase/summary state can remain.
5. Decide whether an explicit transaction boundary belongs around the service workflow.

Current classification:

```text
statement-level commits: observed
business-workflow atomicity: unverified and potentially absent
rollback policy: not observed
```

---

## 7. Desktop Functional Picture

Observed MainWindow responsibilities:

- instantiate pages;
- provide tab navigation;
- route editing to RegisterPage;
- refresh Lists and History pages.

Observed page/service relationship:

- pages call ProductService directly;
- no separate controller layer is present;
- ProductService exposes domain objects and UI-oriented dictionaries/read models;
- MainWindow coordinates cross-page refresh after writes.

Functional presentation shape:

```text
Register
    writable receipt/product workflow

Lists
    all / in-house / shortage / to-buy composite views

History
    grouped purchase history read model

Settings
    persisted settings and store editing surface
```

Operational boundary appears usable for a local desktop MVP, but page-owned services make lifecycle testing and future second-presentation integration more expensive than a shared composition root would.

---

## 8. Structural Findings For Notebook Repopulation

### Stable implementation facts suitable for later classification

1. The executable dependency chain is Desktop → ProductService → Repository → Database Manager → SQLite.
2. ProductService owns business interpretation and UI-facing read-model assembly.
3. Repository owns SQL and row mapping.
4. Database Manager owns initialization, migration, connection configuration, resource paths, user-data paths, and close.
5. SQLite foreign keys, WAL mode, `synchronous=NORMAL`, and `sqlite3.Row` are configured on every connection.
6. Writable database state is external to bundled resources under the user-local application-data directory.
7. Existing-database migration is additive and idempotent for the currently encoded changes.
8. Repository has explicit close/context-manager support.
9. Desktop pages construct services directly, producing independently owned connection chains.
10. No deterministic application-level shutdown owner was observed.
11. Repository methods commit individually; service-workflow atomicity requires direct validation.
12. Storage, Shortage, and Market are currently list modes rather than separate public pages.

### Operational observations requiring validation before canonical promotion

- exact number of simultaneously open desktop connections;
- whether HistoryPage and SettingsPage each construct ProductService;
- whether ProductService provides a close method elsewhere in the file;
- whether Qt object destruction indirectly triggers closure;
- receipt-workflow atomicity under injected failure;
- behavior when migration fails halfway;
- reset behavior with active connections and WAL files;
- packaged schema discovery in one-folder and one-file modes;
- absence of seed/sample business data in production artifacts;
- installer lifecycle preservation of `%LOCALAPPDATA%/Markei`.

### Cross-domain handoff candidates

Design Chat may later evaluate:

- composition-root ownership;
- shared versus page-scoped ProductService;
- transaction-boundary ownership;
- completeness of RepositoryContract;
- whether read-model assembly should remain in ProductService.

Didactic Chat may later classify:

- connection ownership;
- transaction boundary;
- idempotent migration;
- resource path versus user-data path;
- graceful shutdown;
- statement atomicity versus workflow atomicity.

Operational Chat does not write B or C stage files.

---

## 9. Validation Command Set

These commands are proposed for a local checkout on `sketch-notebook-recovery`.

### 9.1 Static import and syntax validation

```powershell
python -m compileall app main.py
python -c "from app.core.database import connect; c = connect(); print(c.execute('PRAGMA foreign_keys').fetchone()[0]); c.close()"
python -c "from app.core.repository import Repository; r = Repository(); print(r.is_open); r.close(); print(r.is_open)"
python -c "from app.core.services import ProductService; s = ProductService(); print(type(s.repository).__name__)"
```

### 9.2 Fresh initialization validation

Use an isolated `LOCALAPPDATA` directory to avoid touching user data:

```powershell
$env:LOCALAPPDATA = "$PWD\.tmp-localappdata"
Remove-Item -Recurse -Force $env:LOCALAPPDATA -ErrorAction SilentlyContinue
python -c "from app.core.database import connect, DATABASE_PATH; c=connect(); print(DATABASE_PATH); print(c.execute('SELECT name FROM sqlite_master WHERE type=''table'' ORDER BY name').fetchall()); c.close()"
```

Acceptance checks:

- database directory is created;
- schema tables exist;
- foreign keys report enabled;
- database is outside source resources;
- business tables are empty unless seed inclusion is intentionally under test.

### 9.3 Migration idempotence validation

```powershell
$env:LOCALAPPDATA = "$PWD\.tmp-localappdata"
python -c "from app.core.database import connect; [connect().close() for _ in range(3)]; print('connect/migrate repeated successfully')"
```

Then inspect columns and default settings:

```powershell
python -c "from app.core.database import connect; c=connect(); print([r['name'] for r in c.execute('PRAGMA table_info(products)')]); print(dict(c.execute('SELECT key,value FROM settings'))); c.close()"
```

### 9.4 Connection lifetime validation

Instrument or test page construction and shutdown:

```powershell
python -c "from app.core.repository import Repository; r1=Repository(); r2=Repository(); print(r1.is_open, r2.is_open); r1.close(); r2.close(); print(r1.is_open, r2.is_open)"
```

Required Qt validation should count page-owned repositories before and after `QApplication.quit()` and verify each is closed deterministically.

### 9.5 Transaction-failure validation

Create an isolated database and inject an exception between receipt workflow writes. Verify Product, Purchase, and calculated summary state after failure.

Expected classification outcomes:

```text
all changes absent       → workflow atomic
partial changes present  → workflow not atomic
```

### 9.6 Reset safety validation

Only against isolated test data:

```powershell
$env:LOCALAPPDATA = "$PWD\.tmp-localappdata-reset"
python -c "from app.core.database import connect, reset; c=connect(); print('open'); c.close(); reset(); print('reset complete')"
```

Additional Windows test:

- keep one Repository connection open;
- invoke reset from a second execution path;
- record database/WAL unlink behavior and failure mode;
- never run this against the ordinary user database.

### 9.7 Desktop smoke validation

```powershell
python main.py
python -m app.main
```

Verify:

- one visible MainWindow;
- Register, Lists, History, and Settings tabs load;
- Lists modes switch correctly;
- one receipt write refreshes Lists and History;
- closing the window terminates without locked database files;
- reopening preserves data.

---

## 10. Operational Risk Register

| Risk | Current evidence | Severity | Next action |
| --- | --- | --- | --- |
| Undefined application-level connection shutdown | Repository close exists; no MainWindow/app shutdown owner observed | High | Trace all service instances and add deterministic lifecycle validation |
| Partial receipt workflow commits | Repository commits per write method | High | Failure-injection test around `register_receipt()` |
| Unversioned migrations | Inline current-state migration only | Medium-High | Define migration ledger/version strategy before complex schema changes |
| Destructive reset against live DB | Unlink-and-rebuild behavior | High | Restrict to isolated/dev use; validate open-connection behavior |
| Seed resource accidentally bundled | Initialization executes seed whenever present | High for production data integrity | Assert production artifact excludes seed/sample records |
| Migration repeated per service connection | `connect()` always invokes `migrate()` | Medium | Measure cost and centralize startup migration if needed |
| Incomplete abstract repository contract | Concrete service dependency surface is larger than ABC | Medium | Compare every ProductService repository call with contract |
| Installed lifecycle unverified | External data path is code-level only | Medium-High | Validate upgrade/uninstall/reinstall with generated installer |

---

## 11. Recommended Next Operational Pass

Before commit-oriented analysis, continue bounded implementation inspection in this order:

```text
1. remaining app/core files
   config.py
   models.py
   full ProductService lifecycle and any close method

2. remaining app/database resources
   seed.sql presence/content
   packaging inclusion rules

3. remaining app/desktop constructors
   history_page.py
   settings_page.py
   widgets that construct services

4. packaging/release source files
   PyInstaller specification
   installer script
   build commands

5. tests and validation scripts
   database migration tests
   repository lifecycle tests
   desktop smoke tests
```

Exit criteria for the structural review:

- complete file inventory for the three requested directories;
- exact service/repository/connection count at runtime;
- documented shutdown owner or confirmed gap;
- receipt-workflow transaction map;
- resource inclusion map;
- executable validation matrix;
- only then compare implementation commits and reconstruct operational chronology.

---

## 12. Stage Conclusion

The repository currently presents a coherent layered desktop application with explicit service, repository, and database-manager responsibilities. The strongest operational implementation is the separation of bundled schema resources from persistent user data and the centralized connection configuration/migration entrypoint.

The principal structural risk is lifecycle fragmentation:

```text
page-owned service
→ page-owned repository
→ page-owned SQLite connection
→ no observed application shutdown owner
```

The principal data-integrity question is broader than SQLite statement safety:

```text
individual repository calls commit
but
multi-step business workflow atomicity remains unverified
```

These findings are suitable for Main synthesis and for later operational-memory reconstruction after further validation. They remain staged evidence and must not be copied directly into canonical, derived, checkpoint, or observational files without classification and reconciliation.
