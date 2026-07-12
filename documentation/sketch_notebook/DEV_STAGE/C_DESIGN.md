# C_DESIGN — Cycle 06 Windows Primary Beta

> Status: Active functional Design stage
> Knowledge state: Staged / non-canonical
> Authority: Design Chat [D]
> Repository: `gus-i-gu/markei`
> Branch: `sketch-notebook-recovery`
> Main reconciliation surface: `documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`
> Scope: Packaged-runtime, installer, user-data, identity, lifecycle, seed, and beta-boundary analysis for Cycle 06

---

## 1. Stage Status and Authority

This file replaces the stale Cycle 05 retrospective previously stored in `C_DESIGN.md`.

It is a Design functional stage. It records:

- current accepted architectural boundaries;
- branch-backed implementation facts;
- packaging and lifecycle observations;
- unresolved policy alternatives;
- Design decision candidates;
- beta blockers;
- validation dependencies;
- explicit future-cycle deferrals.

It is not canonical architecture. It does not authorize source changes, packaging changes, installer changes, permanent Design-memory changes, or Codex execution.

Main Chat must reconcile this stage with Operational and Didactic stages in:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

before D/E/F materialization stages are prepared.

---

## 2. Cycle 06 Design Objective and Scope Guard

Cycle 06 has one active milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

The architectural target lifecycle is:

```text
Windows installer
→ ordinary user installation
→ launchable application executable
→ no development Python command
→ writable user state outside installed program files
→ Register / Lists / History / Settings
→ deterministic close and immediate reopen
→ preserved intended user data
→ explicitly accepted uninstall-retention behavior
```

Cycle 06 does not authorize:

- mobile architecture;
- backend or API work;
- synchronization;
- authentication;
- cloud persistence;
- unrelated features;
- broad ProductService decomposition;
- broad Repository decomposition;
- general schema redesign;
- migration-framework replacement;
- broad view-model redesign;
- unrelated visual redesign;
- cleanup justified only by file size or preference.

Any additional proposal is classified in this stage as either:

```text
required beta blocker
```

or:

```text
future-cycle proposal
```

---

## 3. Sources and Exact Files Inspected

Every repository inspection used `sketch-notebook-recovery` explicitly.

### Main and Design recovery

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
```

### Operational continuity used only for evidence boundaries

```text
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/operational/11_OPERATIONAL_RECORD.md
```

### Current application and persistence boundary

```text
main.py
app/main.py
app/core/config.py
app/core/database.py
app/core/repository.py
app/database/schema.sql
app/database/seed.sql
app/desktop/main_window.py
app/desktop/ui/pages/register_page.py
requirements.txt
```

### Current release identity source

```text
build/markei_version_info.txt
```

### Current stage being replaced

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

### Branch topology and bounded historical checks

The current branch head was resolved as:

```text
7dfef693b5589456d6535c36858346710d5fae0a
Prepare Cycle 06 installable beta session scheme
```

A branch-qualified comparison was made from the Cycle 04 closure commit to `sketch-notebook-recovery`:

```text
base: c84e8506a50e0a594d99615049f93f707c9477a8
head: sketch-notebook-recovery
```

The comparison exposed `build/markei_version_info.txt` but did not expose a committed PyInstaller specification, installer definition, build script, icon, or source test for the historical Cycle 05 packaging claims.

The following expected conventional paths were checked directly on `sketch-notebook-recovery` and were absent:

```text
markei.spec
Markei.spec
build/markei.spec
packaging/markei.spec
packaging/Markei.spec
build_windows.ps1
requirements-build.txt
pyproject.toml
installer/markei.iss
Markei.iss
tests/test_cycle05_installation.py
```

Historical commits were inspected only to classify evidence, not to recover current implementation truth:

```text
d4a1448524273084a1f1af79345b5e085c90513a
    historical Cycle 05 packaging evidence absorption

fbeef65c53eb21c6a8357ec6e74bb67d60248c22
    historical desktop-packaging operational model
```

### Inspection limitation

No exhaustive repository tree API was available through the connector. Therefore the safe conclusion is:

```text
No current version-controlled PyInstaller specification or installer definition
was identified through the branch comparison, branch-qualified source inspection,
and direct expected-path checks.
```

This does not prove that no differently named local or untracked packaging file ever existed. It does prove that the current inspected branch does not yet expose a recoverable, verified packaging/installer source contract sufficient for Cycle 06 staging.

---

## 4. Current Accepted Architecture

The current accepted architecture remains:

```text
Desktop UI
→ ProductService application facade
→ Repository persistence facade
→ Database Manager
→ SQLite
```

Stable responsibility boundaries:

| Boundary | Accepted responsibility |
| --- | --- |
| Desktop pages and widgets | Qt rendering, input, navigation, dialogs, visual state, and refresh coordination |
| `ProductService` | Application workflows, validation, calculations, settings interpretation, and UI-facing projections |
| `Repository` | SQL, row/model mapping, persistence operations, commits, and connection/cursor ownership |
| `app.core.database` | Resource and user-data paths, initialization, SQLite configuration, additive compatibility changes, close/reset primitives |
| SQLite | Persistent facts and relationships |

The broad ProductService and Repository facades describe current responsibility concentration. They are not permanent decomposition decisions.

Packaging must preserve these boundaries. A PyInstaller specification or installer script may collect and deploy the application, but it must not become the owner of workflow behavior, persistence semantics, database initialization rules, or user-data policy.

---

## 5. Current Packaging and Installation Design Facts

### Confirmed current implementation facts

1. `main.py` imports `main` from `app.main` and calls it only when executed as the program entry module.
2. `app.main.main()` creates `QApplication`, constructs `MainWindow`, shows it, and enters the Qt event loop.
3. `MainWindow` constructs Register, Lists, History, and Settings pages.
4. The database module distinguishes a frozen resource base from a writable user-data directory.
5. The live database path is `%LOCALAPPDATA%/Markei/market.sqlite`, with a home-directory fallback.
6. `schema.sql` and `seed.sql` are resolved as application resources beneath `app/database/`.
7. Fresh initialization executes `schema.sql` and then executes `seed.sql` whenever the seed file is present.
8. Existing databases receive additive, idempotent compatibility operations during connection creation.
9. `APP_NAME`, `VERSION`, database filename, schema filename, and seed filename are declared in `app/core/config.py`.
10. `build/markei_version_info.txt` declares `Markei.exe` and version `0.1.0`.
11. `requirements.txt` declares PySide6 but does not pin a version or declare PyInstaller.
12. No current committed packaging specification or installer definition was identified in the inspected branch.
13. No current startup-diagnostic boundary is visible in `app/main.py`; unhandled startup errors can escape the entrypoint.
14. Historical main-branch packaging success is observational continuity only and is not current-branch validation.

### Current identity drift

Version `0.1.0` currently appears in at least two places:

```text
app/core/config.py
build/markei_version_info.txt
```

The values agree now, but no synchronization contract is visible. The version-info file uses `CompanyName = Markei`, which is an application name rather than a clearly accepted publisher identity.

### Current packaging-source gap

Cycle 06 cannot treat historical build claims as reproducible current configuration while the branch does not expose an identified, version-controlled:

- PyInstaller specification or equivalent build definition;
- installer definition;
- pinned build dependency set;
- release build script or runbook;
- icon/resource policy;
- startup-log implementation;
- stable installer identity.

This is a Design/Operational preparation gap, not proof that the application architecture is invalid.

---

## 6. Packaged Runtime Boundary

The intended boundary is:

```text
Source application
    defines Markei runtime behavior

Packaging specification
    selects entrypoint, Python/runtime dependencies,
    application modules, read-only resources, metadata,
    exclusions, and output topology

Frozen runtime
    contains the executable and replaceable runtime content

Installer
    deploys the frozen runtime, shortcuts, identity,
    uninstall registration, and replacement behavior

Installed application files
    replaceable program content

Writable user-data location
    persistent user-created and runtime-created state
```

### Inside immutable or replaceable package content

```text
Markei executable
Python runtime components required by the frozen application
PySide6 and required Qt runtime components
application modules under app/
schema.sql
approved icons and UI resources
Windows executable version metadata
static license/readme material if later approved
```

`seed.sql` belongs inside the package only if Main/human explicitly accepts a production seed policy requiring it. The recommendation in this stage is to exclude it from the production package.

### Outside replaceable package content

```text
market.sqlite
market.sqlite-wal
market.sqlite-shm
runtime logs
user backups or exports
future user-specific configuration not stored in the database
```

### Resource-location ownership

| Resource | Location owner |
| --- | --- |
| Bundled code and static files | Packaging specification defines inclusion; `app.core.database.resource_base()` resolves them at runtime |
| Live database directory | `app.core.database.user_data_dir()` |
| Live database creation | `app.core.database.initialize()` through `connect()` |
| Database compatibility updates | `app.core.database.migrate()` |
| Installer destination | Installer configuration |
| Start Menu and uninstall registration | Installer configuration |
| Startup diagnostics | Application entrypoint boundary; installer only ensures the location is writable and preserved |

### Startup diagnostics ownership

Startup diagnostics are application behavior, not installer behavior. The packaging configuration may choose windowed versus console execution, but the canonical runtime entrypoint should own:

- catching startup exceptions at the outer application boundary;
- writing an inspectable log outside program files;
- presenting a user-visible failure message where Qt can be initialized safely;
- returning a non-success exit status.

Recommended writable log location:

```text
%LOCALAPPDATA%/Markei/logs/
```

The exact implementation belongs to D/E/F only after Main reconciliation.

---

## 7. Entrypoint and Executable Composition

### Canonical application entrypoint

The canonical application function is:

```text
app.main.main()
```

It owns Qt application construction, MainWindow construction, display, and event-loop entry.

### Top-level adapter

```text
main.py
```

is a thin launcher adapter. It should remain the packaging target because it provides a stable repository-root entrypoint while delegating application construction to `app.main.main()`.

### Recommended PyInstaller collection contract

A future version-controlled specification should collect:

```text
entrypoint
    main.py

application package
    app/**

runtime dependencies
    PySide6 and required Qt plugins/libraries

required bundled data
    app/database/schema.sql

conditional data
    app/database/seed.sql only if approved by seed policy

metadata
    build/markei_version_info.txt or its accepted replacement

optional identity resources
    approved application icon
```

It must exclude:

```text
market.sqlite
*-wal
*-shm
__pycache__
*.pyc
development-only sample data
build and distribution outputs from source collection
documentation archives not required at runtime
```

### Installer composition

The installer should install the complete frozen runtime output, not the Python source tree and not a development virtual environment.

It should create an ordinary launch path to:

```text
Markei.exe
```

and must not install a prebuilt live database as program content.

### Entrypoint ambiguity classification

There is no architectural ambiguity between `main.py` and `app.main.main()`:

```text
main.py
    launcher adapter and recommended packaging target

app.main.main()
    canonical application construction function
```

What remains unresolved is the missing current packaging specification that binds this entrypoint to a reproducible executable.

### Frozen-runtime status

Frozen-runtime behavior is currently classified as:

```text
historical implementation evidence
not current recovery-branch validation
not yet reconciled current Cycle 06 acceptance
```

---

## 8. Resource and Writable User-State Classification

| Item | Classification | Package/install policy | Runtime owner | Notes |
| --- | --- | --- | --- | --- |
| `app/database/schema.sql` | Bundled read-only resource; replaceable application content | Must be bundled and installed | Database Manager locates and reads | Required for fresh initialization |
| `app/database/seed.sql` | Current bundled resource; production classification unresolved | Recommended excluded from production runtime | Database Manager executes whenever present | Present file contains category, store, settings, and Rice sample |
| `%LOCALAPPDATA%/Markei/market.sqlite` | Generated writable state and retained user data | Must never be bundled as program content | Database Manager creates/reuses; Repository and SQLite mutate | Preserve through ordinary upgrade and recommended uninstall |
| `market.sqlite-wal` | Transient runtime content associated with user data | Must never be bundled | SQLite creates and removes/checkpoints as connections operate | Lifecycle validation must ensure no retained lock blocks close/reopen |
| `market.sqlite-shm` | Transient runtime content associated with user data | Must never be bundled | SQLite | Same lifecycle requirement as WAL |
| Runtime logs | Generated writable diagnostic state | Must live outside program files | Application entrypoint/startup diagnostic boundary | No current implementation identified; recommended under `%LOCALAPPDATA%/Markei/logs/` |
| `app/core/config.py` constants | Replaceable application content | Bundled with application code | Application modules | Not user-editable configuration |
| Settings rows in `market.sqlite` | Retained user data | Preserve with database | Service/Repository/Database migration | Current user preferences are database state |
| Icons | Decision unresolved / replaceable application content | Bundle only approved static icon resources | Packaging and installer consume; application may set window icon | No verified icon resource or policy found |
| `build/markei_version_info.txt` | Replaceable build metadata | Consumed by packaging process, not copied as live user data unless tool requires it | Release/build configuration | Declares `Markei.exe`, `Markei`, and version `0.1.0` |
| `requirements.txt` | Development/build input | Not ordinary installed runtime content | Build environment | Declares unpinned PySide6 only |
| `__pycache__`, `*.pyc` | Development/generated content | Exclude | Python/build process | Current repository history contains tracked compiled artifacts; they are not release content |
| Build/dist directories | Generated replaceable artifacts | Installer input only after validation | Build procedure | Not canonical source and not user data |
| User backups/exports | Retained user data | Outside install directory | Future explicit data-management workflow | Backup/export implementation is not required unless beta acceptance explicitly includes it |

### Classification consequence

Path separation is accepted architecture. It is not proof of preservation. Preservation requires installed lifecycle evidence.

---

## 9. Production Seed Policy Alternatives

### Alternative A — Schema-only empty production database

```text
Package schema.sql
Exclude seed.sql
Create structural settings through migration/default logic
```

**User-facing consequence**

- First launch presents an empty business state.
- No misleading supermarket, product, price, or purchase data appears.
- The user must register the first real product/purchase.

**Packaging consequence**

- Simplest production resource set.
- Absence of `seed.sql` already causes current initialization to skip seed execution.

**Migration consequence**

- Current migration creates six settings defaults without overwriting user choices.
- Any required category/store defaults must be verified rather than assumed.

**Test consequence**

- Fresh-install acceptance must verify all four pages work with no business records.
- Register must accept the first receipt without a seeded store or sample product.

**Risk**

- A hidden dependency on seeded category/store rows could break first use.

**Compatibility with current behavior**

- Directly compatible with `initialize()` because seed execution is conditional on file presence.
- Historically reported as successful, but requires current-branch validation.

### Alternative B — Schema plus structural defaults only

```text
Package schema.sql
Provide only non-business defaults required for operation
Exclude demonstration stores, products, purchases, and prices
```

**User-facing consequence**

- Empty real-world product history while required application defaults exist.

**Packaging consequence**

- Requires either a production-specific seed resource or explicit default creation in migration/application initialization.
- Introduces risk of maintaining development and production seed variants.

**Migration consequence**

- Structural defaults must use idempotent insertion and must not overwrite user choices.

**Test consequence**

- Must verify exact default-row count and that repeated startup does not duplicate defaults.

**Risk**

- Ambiguity over whether category or store rows are structural or business data.

**Compatibility with current behavior**

- Settings defaults are already created by migration.
- Current `seed.sql` is not structural-only because it contains a named store and Rice product.

### Alternative C — Schema plus demonstration/sample business data

**User-facing consequence**

- Users see data they did not enter and may mistake it for their own inventory/history.

**Packaging consequence**

- Requires bundling the present or revised seed.

**Migration consequence**

- Sample rows need collision and repeat-initialization rules.

**Test consequence**

- Tests may pass because fixtures hide empty-state defects.

**Risk**

- Highest risk of confusion, polluted analytics, duplicate identifiers, and accidental persistence of demonstration records.

**Compatibility with current behavior**

- Matches current source initialization when the existing `seed.sql` is present.

### Alternative D — Conditional development-only seed

```text
Source/development mode may opt into fixtures
Production package excludes seed.sql
```

**User-facing consequence**

- Production remains empty; development can use fixtures.

**Packaging consequence**

- Requires an explicit build exclusion and a clear test mode.

**Migration consequence**

- Same production behavior as Alternative A.

**Test consequence**

- Enables fixture-based tests while preserving separate empty-state tests.

**Risk**

- A packaging mistake could include the development seed.

**Compatibility with current behavior**

- Compatible because current initialization executes the seed based only on resource presence.

### Design recommendation candidate

Recommend:

```text
Alternative A for production
+
Alternative D for development/testing only
```

Production should package `schema.sql` and exclude `seed.sql`. Structural settings defaults should remain idempotent database-initialization behavior. No named store, sample product, purchase, promotion, or price record should enter a production user database.

This recommendation requires Main/human acceptance before D/E/F because seed inclusion changes the user-visible initial data contract.

---

## 10. Startup, Shutdown, and Lifecycle Ownership

### Observed structure

```text
main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ four pages
→ page-owned ProductService instances
→ Repository instances
→ SQLite connections
```

`MainWindow` constructs all four principal pages. At least Register directly constructs its own ProductService. Recovered canonical and operational memory confirms the same page-local chain for Lists, History, and Settings.

`ProductService` and Repository expose local close capability. Cleanup attempts are distributed. `MainWindow` does not currently expose an authoritative `closeEvent()` in the inspected source.

### Confirmed runtime defect

No runtime resource leak or retained database lock is yet confirmed from current Cycle 06 evidence.

### Plausible beta risk

The lifecycle target requires deterministic close and immediate reopen. Implicit, distributed cleanup can fail silently if:

- one page does not close its service;
- Qt destruction order differs from assumptions;
- a cleanup exception interrupts later closures;
- WAL/SHM state or a connection remains active;
- a frozen/windowed process exits differently from a source run.

### Design question

Which object owns the statement:

```text
The application is shutting down; close every long-lived application resource exactly once.
```

### Recommended beta-bounded ownership

Recommend `MainWindow` as the composition-level shutdown owner for Cycle 06 because it already constructs and retains the four pages.

This does not require a dependency-injection redesign. A bounded implementation may:

```text
MainWindow close/shutdown boundary
→ ask each page-owned service to close
→ make close idempotent
→ continue cleanup if one close fails
→ expose/log cleanup failure
→ accept Qt close only after cleanup attempt
```

An equivalent application-level owner in `app.main` is acceptable only if it can deterministically reach every page-owned service. MainWindow is the smaller responsibility change in the current composition.

### Change versus validation conclusion

Classification:

```text
Current implicit cleanup
    validation-only concern until exercised

Deterministic closure requirement
    accepted beta boundary

If all four repositories close reliably under normal and frozen shutdown
    no lifecycle code change required

If any repository remains open, cleanup is skipped, or an exception is hidden
    required beta blocker
    → bounded MainWindow-owned shutdown correction
```

No broad service/repository lifetime refactor is authorized.

### Immediate reopen safety

Operational evidence must show:

- all four connections are open after MainWindow construction;
- normal application close closes all four;
- no cleanup exception is emitted or hidden;
- a new process can immediately open the same database;
- the isolated user-data directory can be removed after close;
- no unexpected WAL/SHM lock remains.

---

## 11. Application Identity and Version Contract

### Identity elements and ownership

| Element | Owner |
| --- | --- |
| Application display name | Application configuration and UI |
| Window title | Desktop composition |
| Executable filename | Packaging configuration |
| File/product version metadata | Build/release configuration |
| Semantic application version | Application/release identity contract |
| Publisher | Human/Main-approved release identity, materialized in installer and executable metadata |
| Installer stable `AppId` or equivalent | Installer configuration |
| Install directory and shortcut name | Installer configuration |
| Database filename and user-data namespace | Application configuration/database manager |
| Database compatibility behavior | Database Manager and accepted migration policy |

### Current facts

```text
APP_NAME = Markei
VERSION = 0.1.0
window title = Markei
version-info executable = Markei.exe
version-info product/file version = 0.1.0
```

### Minimum primary-beta identity contract

Before D/E/F, Main/human must accept:

```text
Application name: Markei
Executable name: Markei.exe
Semantic version: 0.1.0 or an explicitly revised beta version
Publisher: explicit human-owned value, not inferred from CompanyName=Markei
Installer identity: one stable generated identifier retained across upgrades
User-data namespace: %LOCALAPPDATA%/Markei
Database filename: market.sqlite
```

### Version ownership recommendation

Recommend `app/core/config.py::VERSION` as the semantic application-version owner, with a release rule requiring the same value to be materialized into:

- Windows executable metadata;
- installer display version;
- generated artifact naming;
- release evidence.

A build tool may require a generated metadata file, but that file should be treated as a projection of the accepted semantic version rather than an independent source of truth.

### Application version versus schema migration

Application version and schema compatibility are separate:

```text
Application version
    identifies the distributed software artifact

Schema migration state
    identifies which persisted data shapes the software can open safely
```

Cycle 06 does not require a complete versioned migration framework. It does require validation that the accepted beta executable can:

- initialize a fresh database;
- reopen its own existing database;
- apply current additive compatibility changes repeatedly without corruption;
- fail visibly rather than destructively if an unsupported database state is encountered.

---

## 12. Installer, Upgrade, and Reinstall Boundary

### Installer responsibility

The installer owns:

- per-user or machine-level deployment mode as explicitly accepted;
- installation of the complete frozen runtime;
- stable application identity;
- version display;
- publisher display;
- Start Menu shortcut;
- optional desktop shortcut only if approved;
- uninstall registration;
- replacement/removal of installed application files;
- implementation of the accepted user-data-retention policy.

The installer does not own:

- database creation;
- database migration semantics;
- ProductService workflows;
- Repository operations;
- business defaults;
- database reset;
- silent deletion of user state.

### Recommended bounded lifecycle

| Scenario | Intended Cycle 06 behavior |
| --- | --- |
| Same-version reinstall | Replace/repair program files; preserve `%LOCALAPPDATA%/Markei`; relaunch against same compatible database |
| New-version upgrade | Reuse stable installer identity and install location; replace program files; preserve user data; application applies accepted compatibility changes on startup |
| Application-file replacement | Must not copy over, move, or delete the live database |
| Existing compatible database | Open and migrate idempotently; preserve products, purchases, stores, settings, and analytical state |
| Incompatible future database | Outside full Cycle 06 migration design; minimum behavior is visible failure and preservation of the original database, not destructive reset |
| Uninstall then reinstall | Reinstall program files; rediscover retained database under the same user-data namespace; preserve intended state |

### Package-output convention

The accepted source contract should distinguish:

```text
version-controlled packaging source
    spec, installer script, metadata source, build inputs

generated frozen runtime
    build/dist output

generated installer
    distributable installer executable

installed application
    user-machine program files

retained user data
    %LOCALAPPDATA%/Markei
```

Generated outputs are evidence-bearing artifacts, not permanent architecture or notebook canon.

---

## 13. Uninstall Data-Retention Policy Alternatives

### Alternative A — Remove application files; preserve all user data

**User expectation**

- Reinstall restores the prior household data.
- Uninstall does not silently erase purchase history.

**Accidental-loss risk**

- Lowest.

**Implementation complexity**

- Lowest. Installer removes only files it installed.

**Reinstall behavior**

- Application reconnects to `%LOCALAPPDATA%/Markei/market.sqlite`.

**Upgrade compatibility**

- Strongest alignment with stable external user-data ownership.

**Beta suitability**

- High.

### Alternative B — Preserve by default; offer explicit removal

**User expectation**

- Supports both ordinary uninstall and deliberate full removal.

**Accidental-loss risk**

- Low only if wording, default, and confirmation are unambiguous.

**Implementation complexity**

- Moderate. Requires installer/uninstaller UI and safe deletion of database, WAL/SHM, logs, and perhaps backups.

**Reinstall behavior**

- Depends on selected option.

**Upgrade compatibility**

- Good, but a mistaken selection can destroy upgrade continuity.

**Beta suitability**

- Acceptable after explicit UX and safety validation.

### Alternative C — Remove application and user data

**User expectation**

- Some users expect a complete removal, but many do not expect purchase history to be deleted without a separate warning.

**Accidental-loss risk**

- Highest.

**Implementation complexity**

- Superficially simple, but safe active-connection handling and confirmation remain necessary.

**Reinstall behavior**

- Starts empty.

**Upgrade compatibility**

- Poor if uninstall is used during manual upgrade.

**Beta suitability**

- Not recommended.

### Alternative D — External/manual behavior remains undefined

**User expectation**

- Unclear.

**Accidental-loss risk**

- Unbounded because actual behavior is not an accepted contract.

**Implementation complexity**

- Deferred rather than solved.

**Reinstall behavior**

- Unreliable.

**Upgrade compatibility**

- Unreliable.

**Beta suitability**

- Not acceptable because Cycle 06 explicitly requires an accepted policy.

### Design recommendation candidate

Recommend Alternative A for the primary beta:

```text
Uninstall removes installed application files and shortcuts.
Uninstall preserves %LOCALAPPDATA%/Markei and all user data.
```

The installer/uninstaller and release notes should state this behavior clearly.

Alternative B is a future refinement after a safe explicit data-removal UX exists. A Settings reset action is not equivalent to uninstall cleanup and must not be silently invoked by the installer.

Main/human acceptance is required before installer materialization.

---

## 14. Principal Desktop Beta Contract

The beta contract preserves the current public surfaces:

```text
Register
Lists
History
Settings
```

Storage, Shortage, and Market remain Lists modes. No navigation redesign is required for Cycle 06.

### Register

Minimum architectural contract:

- desktop owns input widgets, feedback, and dialogs;
- ProductService owns validation and receipt/product workflow meaning;
- Repository owns persistence operations;
- database manager owns initialization and connection lifecycle primitives;
- a successful mutation triggers dependent view refresh;
- user-entered data remains after close and reopen.

### Lists

Minimum architectural contract:

- ProductService assembles inventory/status projections;
- desktop renders and switches Lists modes;
- no SQL or duplicate business classification moves into the UI;
- data reflects successful Register changes after refresh and after reopen.

### History

Minimum architectural contract:

- Purchase remains the historical source record;
- ProductService assembles grouped history and analytics projections;
- desktop renders read-only history;
- history reflects persisted writes after refresh and reopen.

### Settings

Minimum architectural contract:

- ProductService interprets and validates settings;
- Repository persists them;
- default settings are created idempotently;
- user-selected settings are not overwritten by repeated startup or upgrade;
- Settings remains separate from installer policy and destructive uninstall behavior.

### Cross-cutting ownership

| Concern | Owner |
| --- | --- |
| Field/business validation | ProductService/application workflow |
| Persistence commands and mapping | Repository |
| Connection configuration and database compatibility | Database Manager |
| Read-model assembly | ProductService |
| Rendering and interaction | Desktop UI |
| Refresh coordination | MainWindow and current desktop relationships |
| Startup application construction | `app.main.main()` |
| Startup diagnostic boundary | Recommended outer application entrypoint |
| Deterministic shutdown | Recommended MainWindow composition boundary, subject to validation gate |
| Installed deployment | Installer |
| User-data retention policy | Accepted Design/Main/human policy implemented by installer behavior |

Packaging must not reopen stable business semantics unless an installed-runtime defect proves a narrow beta blocker.

---

## 15. Required Beta-Blocking Design Decisions

The following decisions are required before Main finalizes D/E/F.

### Decision 1 — Production seed policy

Recommended candidate:

```text
Production packages schema.sql but exclude seed.sql.
Development/testing may use seed.sql conditionally.
No sample store or Rice product enters production user data.
```

Status:

```text
decision required before D/E/F
human/Main acceptance required
```

### Decision 2 — Uninstall retention

Recommended candidate:

```text
Uninstall removes program files and preserves %LOCALAPPDATA%/Markei.
```

Status:

```text
decision required before D/E/F
human/Main acceptance required
```

### Decision 3 — Minimum identity contract

Required values:

```text
application name
executable name
semantic version
publisher
stable installer identity
install mode/location
shortcut policy
```

Recommended current values where already grounded:

```text
Markei
Markei.exe
0.1.0 unless explicitly revised
%LOCALAPPDATA%/Markei
market.sqlite
```

Publisher, installer identity, and install mode remain human/Main decisions.

### Decision 4 — Packaging source contract

A current version-controlled packaging specification and installer definition must exist or be explicitly created through D/E/F. Historical claims and generated artifacts are insufficient.

Status:

```text
required beta blocker
```

### Decision 5 — Startup diagnostic boundary

A windowed installed executable must not disappear silently on startup failure.

Recommended candidate:

```text
outer application entrypoint catches startup failure
→ writes log under user-writable Markei data
→ presents visible failure where possible
→ exits non-successfully
```

Status:

```text
required beta blocker unless Operational proves an equivalent current mechanism
```

### Decision 6 — Shutdown owner

Recommended candidate:

```text
MainWindow is the beta composition-level shutdown owner.
```

Status:

```text
accepted candidate subject to Operational evidence
implementation change required only if current shutdown validation fails
```

---

## 16. Validation-Only Questions for Operational

Operational must provide direct evidence for the following; Design must not invent the answers.

### Packaging source and artifact

- Which exact version-controlled file builds the frozen runtime?
- Which exact version-controlled file builds the installer?
- Are those files present on `sketch-notebook-recovery` after Main-approved materialization?
- Does the build use `main.py` as entrypoint?
- Does the frozen runtime include `schema.sql` at the path expected by `resource_base()`?
- Does it exclude `seed.sql` according to accepted policy?
- Does it exclude `market.sqlite`, WAL, SHM, sample records, source caches, and development archives?
- Does the executable metadata match the accepted application version and publisher?

### Startup

- Does launching from outside the build directory work?
- Does launching from a Start Menu shortcut work?
- Where does an intentionally injected startup failure appear?
- Is a log created in a writable user-data location?
- Does failure return a non-success status rather than silently exiting?

### Fresh user state

- With an isolated empty `LOCALAPPDATA`, does first launch create only intended structural state?
- Are products, purchases, stores, and promotions empty under the accepted seed policy?
- Can the first real receipt be registered without sample data?
- Are settings defaults present once and preserved after repeated startup?

### Shutdown and reopen

- Are all four page-owned repositories open after page construction?
- Are all four closed after normal application shutdown?
- Are cleanup failures visible?
- Can the executable reopen immediately against the same database?
- Can the isolated data directory be removed after final close?
- What WAL/SHM files remain, and are they expected?

### Installer lifecycle

- Does installation place only replaceable application content in the install directory?
- Does it create the approved shortcuts?
- Does same-version reinstall preserve user data?
- Does upgrade preserve user data and settings?
- Does uninstall implement the accepted policy?
- Does reinstall rediscover retained data?
- Are program files removed while user data remains intact under the recommended policy?

### Principal workflows

- Register persists a purchase and refreshes Lists/History.
- Lists modes load and change correctly.
- History shows the persisted event.
- Settings changes persist and are not overwritten.
- Close/reopen preserves all accepted state.

### Transaction-risk evidence

The current multi-commit workflow is a known architectural property. Operational should identify exact partial states under injected failure. A transaction redesign is required in Cycle 06 only if the demonstrated partial state blocks controlled beta acceptance or risks ordinary-user data integrity under plausible failure.

---

## 17. Required Beta-Bounded Changes

The following are eligible Cycle 06 changes after Main reconciliation.

### Required regardless of current runtime validation

1. Materialize a version-controlled packaging source contract if none exists on the branch.
2. Materialize a version-controlled installer definition.
3. Declare/pin the required runtime and build dependencies sufficiently for a reproducible beta build.
4. Bind `main.py` to the generated executable.
5. Bundle `schema.sql` and implement the accepted seed inclusion/exclusion.
6. Exclude live database, WAL/SHM, sample data, caches, and unrelated generated content.
7. Synchronize executable and installer metadata with the accepted identity/version contract.
8. Implement the accepted uninstall-retention behavior.
9. Establish inspectable startup failure behavior if no equivalent mechanism exists.

### Conditional required change

```text
If shutdown validation fails
→ add bounded MainWindow/application cleanup ownership
→ do not redesign service/repository composition beyond what is needed
```

### Not automatically required

- ProductService decomposition;
- Repository decomposition;
- workflow transaction redesign;
- typed view models;
- general schema redesign;
- migration ledger;
- navigation redesign;
- Settings feature expansion.

---

## 18. Future-Cycle Proposals and Explicit Deferrals

The following are explicitly excluded from Cycle 06 unless new evidence proves a narrow beta blocker:

```text
mobile application
backend/API
cloud persistence
synchronization
accounts/authentication
automatic updating
rollback framework
code signing infrastructure
SmartScreen reputation program
antivirus reputation optimization
complete migration framework
schema-version ledger
major service decomposition
major repository decomposition
full dependency-injection/composition-root redesign
typed view-model conversion
presentation-layer rewrite
navigation redesign
Promotion feature completion
pages.order activation
long-term Product aggregate/cache redesign
backup/export product feature
optional uninstall data-removal UX
```

Code signing and reputation hardening remain important release-hardening work, but they are not substitutes for the primary beta lifecycle and should not block an internally controlled unsigned beta unless human/Main changes the acceptance scope.

---

## 19. Proposed Design Acceptance Criteria

Cycle 06 Design is ready for Main acceptance when all of the following boundaries and decisions are explicit.

### Runtime and package boundary

- `main.py` is the packaging target and `app.main.main()` remains the canonical application construction function.
- The package contains replaceable application/runtime content only.
- `schema.sql` is bundled and runtime-discoverable.
- `market.sqlite`, WAL, SHM, logs, and user backups remain outside installed program files.
- Startup diagnostics have an accepted application-owned boundary.

### Seed boundary

- Main/human accepts a production seed policy.
- The package inclusion rule implements that policy exactly.
- Demonstration business data is not silently installed.

### Identity boundary

- Application name, executable name, semantic version, publisher, stable installer identity, install mode, and shortcut policy are accepted.
- Executable metadata and installer metadata project the same accepted version.
- Application version remains distinct from schema migration state.

### Lifecycle boundary

- The authoritative shutdown owner is explicit, or current distributed cleanup is directly proven deterministic.
- Immediate close/reopen behavior is part of acceptance.
- Upgrade and reinstall replace application files without replacing compatible user data.
- Unsupported database states fail visibly and preserve the original database.

### Uninstall boundary

- Main/human accepts one user-data-retention policy.
- Installer behavior implements it without invoking application reset semantics.
- Reinstall behavior is defined against the retained/deleted state.

### Desktop contract

- Register, Lists, History, and Settings retain their current responsibility boundaries.
- Packaging does not move business logic or SQL into the installer or desktop layer.
- Current user data survives the tested installed lifecycle.

### Scope boundary

- Every proposed change is classified as required beta blocker, validation-only concern, future-cycle proposal, or explicit deferral.
- No broad refactor is included merely because it is architecturally attractive.

---

## 20. Handoff to Main Chat

### Accepted current boundaries to preserve

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

```text
Bundled/replaceable application content
≠
writable retained user data
```

```text
main.py
→ app.main.main()
→ QApplication
→ MainWindow
```

### Recommended decision candidates

```text
Production seed
    schema-only production initialization
    structural settings defaults through idempotent initialization/migration
    seed.sql development-only and excluded from production

Uninstall
    remove application files
    preserve %LOCALAPPDATA%/Markei

Shutdown
    validate first
    use MainWindow as bounded authoritative owner if current cleanup is not deterministic

Version
    app/core/config.py VERSION is semantic owner
    build and installer metadata must match

Startup diagnostics
    outer application entrypoint owns visible/logged failure behavior
```

### Human/Main decisions still required

- production seed policy;
- uninstall-retention policy;
- publisher identity;
- semantic beta version if not `0.1.0`;
- stable installer `AppId` or equivalent;
- per-user versus machine-wide install mode;
- desktop shortcut policy;
- whether unsigned controlled beta is acceptable;
- whether shutdown evidence is sufficient without a bounded code change;
- whether demonstrated multi-commit failure states block beta acceptance.

### Architecturally necessary work before packaging acceptance

Current inspection did not identify a current version-controlled PyInstaller spec or installer definition. Main should treat creation or recovery of those source artifacts as a required beta blocker rather than relying on historical main-branch build claims.

### Operational proof required

Operational must provide current-branch evidence for:

- generated runtime resource inclusion/exclusion;
- source-independent launch;
- startup-failure observability;
- fresh initialization under accepted seed policy;
- all-four-repository shutdown;
- immediate reopen;
- principal desktop workflows;
- same-version reinstall;
- upgrade preservation;
- uninstall policy;
- reinstall recovery.

### Didactic distinctions relevant to later promotion

Without owning KANBAN promotion, this stage depends on preserving these distinctions:

```text
source application versus packaging configuration
packaged executable versus installer
bundled resource versus writable user data
configured build versus validated installed release
application version versus schema compatibility
uninstalling program files versus deleting user data
local cleanup capability versus authoritative lifecycle ownership
```

### Main reconciliation route

Main Chat should reconcile this C stage with A and B in:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

No D/E/F instruction is produced by this stage.
