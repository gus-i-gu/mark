# 00_PROJECT_STATE.md

> Version: Cycle 06 global state 0.2
> Status: Active Global State Canon-Checkpoint
> Persistence Class: Canon-Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Reconciliation source: `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Concise accepted global state and low-cost recovery entrypoint

---

# 1. Current Milestone

Cycle 06 has one active milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Sprint 01 completed the first bounded release-enablement materialization. The milestone remains open because installer compilation and the installed lifecycle have not yet been completed.

Current evidence state:

```text
configured: yes
built: yes
launched: yes — isolated frozen launch and immediate reopen
installed: blocked
validated: partial
accepted: no
```

Cycle 06 Sprint 02 is the next bounded session. It must finish the remaining installer and installed-lifecycle gates without introducing a second milestone.

---

# 2. Current Application and Architecture

Markei remains a local Python desktop application using PySide6 and SQLite.

```text
main.py
→ app.main.main()
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

Storage, Shortage, and Market remain modes inside Lists.

Responsibility direction remains:

| Layer | Responsibility |
| --- | --- |
| Desktop | Qt rendering, input, navigation, dialogs, refresh coordination, and final page-service shutdown coordination |
| `ProductService` | Workflows, validation, calculations, settings, stores, and UI-facing projections |
| `Repository` | SQL, row/model mapping, persistence operations, commits, and connection/cursor ownership |
| Database Manager | Resource and user-data paths, initialization, SQLite configuration, additive compatibility work, and reset primitives |
| SQLite | Persistent facts and declared relationships |

Packaging and installation are deployment concerns around this application boundary. They do not own business workflows, SQL, or user-created state.

---

# 3. Current Release Boundary

Production packaging is now materially defined:

```text
Markei.spec
    authoritative one-folder windowed PyInstaller definition
    includes schema.sql
    excludes seed.sql and live/transient user data
    UPX disabled
    Windows version resource attached

scripts/build_windows.ps1
    clean-build invocation wrapper

installer/Markei.iss
    per-user Windows x64 installer source
    stable AppId
    Start Menu shortcut
    optional desktop shortcut
    preserves external user data by default

scripts/build_installer.ps1
    Inno Setup compile wrapper
```

Release identity:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Installer AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
```

Read-only production resource:

```text
app/database/schema.sql
```

Development/test fixture excluded from production:

```text
app/database/seed.sql
```

Writable retained user state:

```text
%LOCALAPPDATA%/Markei/market.sqlite
```

Generated writable diagnostics:

```text
%LOCALAPPDATA%/Markei/logs/startup.log
```

WAL and SHM files remain transient writable companions and must never be bundled.

---

# 4. Validated Sprint 01 Evidence

Current-branch evidence supports:

- source compilation;
- five standard-library release tests;
- a successful one-folder PyInstaller build;
- creation of `dist\Markei\Markei.exe`;
- isolated frozen launch and immediate reopen;
- schema-only first launch;
- zero sample category, store, product, and purchase rows;
- structural/default settings creation;
- exclusion of `seed.sql`, live database, WAL/SHM, and startup logs from the distribution;
- startup-log path and content creation;
- focused shutdown failure detection;
- a bounded `MainWindow.closeEvent()` correction;
- closure of all four page-owned service/repository chains;
- release of the isolated SQLite directory after close.

Recorded executable evidence:

```text
dist\Markei\Markei.exe
SHA256 E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B
```

The shutdown correction resolves the focused source/frozen gate. Installed shutdown remains unvalidated.

---

# 5. Current Domain State

## Operational

The Operational domain records a built and partially validated frozen runtime, configured installer source, blocked installer compilation, and unvalidated installed lifecycle.

Checkpoint:

```text
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
```

## Didactic

The Didactic domain now includes four canonical Red concepts:

```text
&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

No concept is Green through explicit human validation.

Checkpoint:

```text
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

## Design

The Design domain has absorbed the deployment boundary, schema-only production policy, retained external data, coordinated identity, launcher-owned startup diagnostics, and MainWindow-owned final page-service shutdown coordination.

Checkpoint:

```text
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

---

# 6. Remaining Sprint 02 Work

```text
provide Inno Setup / ISCC.exe
→ compile installer
→ inspect installer artifact
→ perform clean per-user installation
→ launch from Start Menu without Python or source checkout
→ exercise Register / Lists / History / Settings
→ close and immediately reopen
→ verify persistence
→ test compatible reinstall or upgrade
→ uninstall
→ verify %LOCALAPPDATA%/Markei preservation
→ reinstall and recover retained data
→ record SmartScreen / antivirus observations
→ obtain human acceptance
```

Sprint 02 may make only narrowly evidenced corrections required to pass these gates.

---

# 7. Active Risks and Deferrals

Active risks:

- installer toolchain availability;
- installed placement and shortcut behavior;
- installed workflow regressions;
- uninstall/reinstall data preservation;
- compatible upgrade behavior;
- Windows reputation and antivirus observations;
- human workflow acceptance.

Inherited debt retained outside the first release-enablement correction:

- workflow-level atomicity across multi-commit user actions;
- complex migration strategy;
- broader service/repository decomposition.

Explicitly outside Cycle 06 unless directly beta-blocking:

- mobile;
- backend/API;
- synchronization;
- authentication;
- cloud persistence;
- broad schema or UI redesign;
- composition-root redesign;
- auto-update;
- signing;
- rollback infrastructure;
- one-file packaging;
- optional uninstall data-deletion UX.

---

# 8. Global Recovery Route

Use the least expensive sufficient source:

```text
1. Read this file for global orientation.
2. Read 06_SESSION_SCHEME.md for Sprint 02 boundaries and exit criteria.
3. Read the relevant domain checkpoint.
4. Read the corresponding derived or canonical file only when detail is required.
5. Read observational history only for chronology.
6. Read J_[M]_STAGE.md for the active Sprint 02 coordination prompt.
7. Inspect source only when notebook memory is insufficient or drift is suspected.
```

Domain checkpoints:

```text
Operational  operational/10_OPERATIONAL_STATE.md
Didactic     didactics/08_CONCEPT_MAP.md
Design       design/09_DESIGN_STATE.md
```

Active Main staging surface:

```text
[M]_STAGE/J_[M]_STAGE.md
```

---

# 9. Main Continuity State

Sprint 01 has been materialized, evidenced through G/H/I, reconciled by Main, and absorbed into all three permanent domains.

The next authorized coordination unit is Cycle 06 Sprint 02: complete installer compilation and the full installed lifecycle, then reconcile evidence before any claim of beta acceptance or Cycle 06 closure.