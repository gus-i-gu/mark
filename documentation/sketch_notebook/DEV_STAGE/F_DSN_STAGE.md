# F_DSN_STAGE — Cycle 06 Windows Primary Beta

> Status: Main-approved Design materialization stage
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Source: `[M]_STAGE/J_[M]_STAGE.md`
> Codex report target: `DEV_STAGE/I_DSN_CODEX.md`

## 1. Objective

Materialize the accepted Cycle 06 release boundaries into the permanent Design memory after implementation evidence is available. Preserve the current application architecture and record only the beta-critical deployment, identity, resource, and lifecycle decisions accepted by Main.

This stage does not authorize broad redesign.

## 2. Accepted Architecture Preserved

The application boundary remains:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

Packaging and installation are deployment concerns around this application. They do not become new business or persistence layers.

Accepted responsibility direction:

```text
Application entrypoint
    constructs and starts Markei
    owns inspectable startup diagnostics

Application/database code
    locates bundled resources
    creates writable user directories and state
    initializes and migrates SQLite

PyInstaller specification
    collects the executable runtime and approved read-only resources

Installer
    places replaceable program files
    registers identity, shortcuts, and uninstall behavior
    does not own workflows, SQL, migration meaning, or user-created data

Main/human acceptance
    decides whether evidence is sufficient for primary beta status
```

## 3. Authorized Permanent Design Files

After Codex materializes D and evidence is available, update only:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
```

Do not update these files with claims unsupported by actual G evidence.

## 4. Canonical Release-Boundary Decisions

### 4.1 Packaged runtime boundary

Record canonically:

```text
root main.py
    packaged launcher adapter

app.main.main()
    canonical Qt application-construction function

Markei.spec
    authoritative one-folder packaging definition

scripts/build_windows.ps1
    operational invocation wrapper, not an independent package definition
```

The packaged runtime includes executable code, required Python/Qt runtime components, `schema.sql`, approved static assets, and executable metadata.

The packaged runtime excludes `seed.sql` for production, live databases, WAL/SHM companions, generated logs, tests, development fixtures, and repository/build residue.

If D execution proves a different exact packaging file path, use the materialized path but preserve this ownership model.

### 4.2 Resource and writable-state classification

Record:

| Item | Accepted classification |
| --- | --- |
| `schema.sql` | Bundled read-only replaceable application resource |
| `seed.sql` | Development/test fixture; excluded from the production beta package |
| `market.sqlite` | Retained writable user data under `%LOCALAPPDATA%/Markei` |
| `market.sqlite-wal`, `market.sqlite-shm` | Transient writable companions; never bundled |
| startup logs | Generated writable diagnostics outside installed program files |
| settings stored in SQLite | Retained user data |
| icons and executable resources | Replaceable application content |
| version metadata | Replaceable release identity content |

External placement is an architectural boundary, not proof of successful preservation. Installed lifecycle evidence is still required.

### 4.3 Production initialization policy

Record the accepted primary-beta policy:

```text
fresh production database
= schema.sql
+ structural/default settings supplied by current application initialization/migration
+ no sample store/product/purchase/category business data
```

The current sample-bearing seed remains available only for development or tests unless a future decision reclassifies it.

### 4.4 Uninstall retention policy

Record:

```text
uninstall removes replaceable application files and shortcuts
uninstall preserves %LOCALAPPDATA%/Markei by default
reinstall may reuse compatible retained data
```

Optional user-data deletion UI is deferred.

### 4.5 Release identity contract

Record the minimum Cycle 06 identity:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Installer identity: one stable AppId across compatible upgrades
Primary target: Windows x64 controlled beta
```

Application version, executable metadata, and installer metadata form one coordinated release contract. They may be stored in tool-specific formats, but divergence is design drift.

Application version does not by itself prove database compatibility. Cycle 06 validates only fresh installation and compatible existing-data reopen/reinstall paths supported by the current additive compatibility behavior.

### 4.6 Shortcut policy

Record:

```text
Start Menu shortcut required
Desktop shortcut optional through an installer task
```

Shortcut policy belongs to installation UX and does not change application architecture.

### 4.7 Startup diagnostics

Record that the outer executable entrypoint owns making pre-window startup failure inspectable.

Accepted diagnostic boundary:

```text
unhandled startup exception
→ writable per-user startup log
→ concise visible error where safely available
→ failing process result
```

Logging must not move into installed program files or business layers.

## 5. Lifecycle Ownership Decision

Record the accepted Cycle 06 decision:

```text
validate current distributed page/service/repository cleanup first
```

Current structure remains an implementation fact:

```text
4 pages
→ 4 ProductService instances
→ 4 Repository instances
→ 4 SQLite connections/cursors
```

This structure is not canonically declared defective.

Only if G evidence demonstrates missed closure, cleanup exceptions, retained database locks, inability to reopen immediately, or inability to release an isolated database directory may Cycle 06 add a bounded MainWindow/application-owned close coordinator.

If such a correction is materialized, record it as:

```text
MainWindow/application composition coordinates idempotent closure
page/service/repository local close responsibility remains intact
```

Do not promote a new composition root, dependency-injection system, or broad lifetime redesign.

If validation passes without a code change, record that existing cleanup behavior was validated for the tested beta lifecycle without claiming a universal lifetime proof.

## 6. Transaction Boundary

Record no new transaction architecture unless D execution discovers an ordinary beta-blocking defect.

Existing multi-commit workflows remain inherited risk:

```text
statement commits exist
workflow atomicity is not guaranteed
```

Packaging and installation do not alter that fact. Transaction redesign is deferred unless concrete beta evidence requires a separately reconciled narrow correction.

## 7. Upgrade and Reinstall Boundary

Record the bounded Cycle 06 contract:

```text
same-version reinstall
    may replace program files
    must not overwrite retained compatible user data

compatible beta upgrade
    retains stable installer identity
    replaces program files
    opens existing database
    applies current additive compatibility behavior

uninstall then reinstall
    preserved user data may be reopened
```

Incompatible future database formats, downgrade policy, rollback, and a numbered migration framework are outside Cycle 06.

## 8. Model Overview Update

Refresh `14_MODEL_OVERVIEW.md` with a compact deployment map:

```text
Source tree
    main.py
    app/
    schema resource

Build layer
    Markei.spec
    build wrapper
    frozen one-folder distribution

Install layer
    Inno Setup source
    compiled installer
    installed replaceable program files

User-state layer
    %LOCALAPPDATA%/Markei/market.sqlite
    transient WAL/SHM
    startup logs
```

Show that installed application files and retained user state are separate sibling concerns around the existing application architecture.

Do not expand the overview into an operational runbook.

## 9. Design Checkpoint Update

Refresh `09_DESIGN_STATE.md` only after G evidence.

The checkpoint must state actual status precisely, for example:

```text
configured
built
launched
installed
validated
blocked
```

Do not state `accepted` unless Main/human acceptance occurs after G/H/I reconciliation.

Include:

- current Cycle 06 milestone;
- accepted resource, seed, retention, identity, and shortcut boundaries;
- materialized packaging/installer paths;
- startup diagnostic status;
- shutdown validation outcome;
- installed lifecycle evidence or blocker;
- remaining beta risks;
- explicit deferrals.

## 10. Decision Log Entry

Append an observational Cycle 06 decision entry recording:

1. A/B/C functional reports were reconciled in J;
2. production excludes sample-bearing seed data;
3. uninstall preserves `%LOCALAPPDATA%/Markei`;
4. Markei/0.1.0/Markei.exe/Markei publisher/stable AppId form the first beta identity;
5. `Markei.spec` is the packaging authority and the build script is an invocation wrapper;
6. Start Menu is required and desktop shortcut is optional;
7. shutdown is validate-first with evidence-triggered bounded correction;
8. broad redesigns remain deferred;
9. materialization and validation status are reported from G rather than inferred.

The log must distinguish Main acceptance of policy from later evidence of implementation behavior.

## 11. Evidence-Conditional Materialization

Codex must read `G_OPS_CODEX.md` before finalizing permanent Design state.

Use these rules:

```text
If packaging/installer files were created but not built:
    record configured only

If frozen build succeeded and launched:
    record built/launched with exact limits

If installer compile was blocked:
    record blocker; do not claim installed lifecycle

If installed lifecycle was exercised:
    record exact tested transitions

If shutdown correction was added:
    record why and where

If shutdown validation passed unchanged:
    record validation result without redesign
```

## 12. Explicit Deferrals

Keep outside Cycle 06 Design canon:

- mobile, backend/API, synchronization, authentication, cloud persistence;
- automatic updating;
- production signing unless controlled beta proves it blocking;
- rollback framework;
- general migration framework and schema-version ledger;
- incompatible-version and downgrade strategy;
- broad schema redesign;
- ProductService/Repository decomposition;
- composition-root or dependency-injection redesign;
- typed view-model conversion;
- UI/navigation redesign;
- optional uninstall data-removal UX;
- one-file packaging;
- `pages.order` activation and unrelated deferred design questions.

## 13. `I_DSN_CODEX.md` Report Contract

Report:

1. exact Design files modified;
2. canonical release boundaries added;
3. resource/state classifications recorded;
4. seed and retention policies recorded;
5. identity and shortcut contract recorded;
6. startup diagnostic boundary recorded;
7. shutdown/lifecycle outcome and whether it was evidence-conditional;
8. model overview changes;
9. checkpoint evidence status and blockers;
10. decision-log entry;
11. explicit deferrals preserved;
12. confirmation that no unsupported acceptance claim or broad redesign was promoted.

The report remains observational evidence for Main reconciliation.
