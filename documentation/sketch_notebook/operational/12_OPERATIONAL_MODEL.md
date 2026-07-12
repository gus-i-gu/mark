# 12_OPERATIONAL_MODEL.md

> Version: Cycle 06 reconciliation 0.3
> Status: Canonical operational knowledge
> Persistence Class: Canonical
> Knowledge Class: Operational
> Branch: `sketch-notebook-recovery`
> Authority: Operational Chat under Main reconciliation
> Reconciliation sources: `DEV_STAGE/D_OPS_STAGE.md`, `DEV_STAGE/G_OPS_CODEX.md`, `[M]_STAGE/J_[M]_STAGE.md`

---

# 1. Purpose

This file defines stable Operational knowledge for Markei execution, packaging, persistence, diagnostics, and release validation. Current priority belongs in `04_TODO.md`; current state belongs in `10_OPERATIONAL_STATE.md`; chronology belongs in `11_OPERATIONAL_RECORD.md`.

# 2. Runtime and Persistence Boundary

Markei remains a local PySide6 desktop application backed by SQLite:

```text
main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

Writable user state is external to packaged application files:

```text
%LOCALAPPDATA%/Markei/market.sqlite
%LOCALAPPDATA%/Markei/logs/startup.log
```

A home-directory fallback may be used when `LOCALAPPDATA` is unavailable. Packaged resources and writable user data are different operational classes. A live database, WAL/SHM files, logs, caches, tests, and sample business fixtures are not valid production package content.

# 3. Production Resource Policy

The production frozen runtime is schema-only:

```text
include: app/database/schema.sql
exclude: app/database/seed.sql
```

`seed.sql` remains a development/test fixture. First launch initializes structural/default settings without sample category, store, product, or purchase rows.

Resource-path handling in source does not prove artifact inclusion. Every frozen build must be inspected directly for required and forbidden resources.

# 4. Packaging Authority and Toolchain Layers

`Markei.spec` is the authoritative one-folder PyInstaller definition. `scripts/build_windows.ps1` is an invocation and clean-build wrapper; it must not independently redefine package contents.

Operational dependencies are separated by phase:

```text
build time
    Python + PyInstaller + PySide6

runtime
    frozen Markei distribution and bundled Qt/runtime resources

installer time
    Inno Setup / ISCC.exe
```

A successful frozen build does not imply successful installer compilation. Installer compilation is a separate evidence gate.

The observed successful builder environment was:

```text
Python 3.14.6
PyInstaller 6.21.0
PySide6 6.11.1
```

Exact versions belong in the build dependency surface only after a successful contemporary build.

# 5. Frozen and Installed Evidence Gates

Use these statuses precisely:

```text
configured
built
launched
installed
validated
accepted
blocked
```

The release ladder is:

```text
configuration materialized
→ frozen artifact built
→ frozen artifact launched
→ frozen resource/data boundary validated
→ installer compiled
→ installer artifact inspected
→ application installed
→ installed launch and workflows validated
→ upgrade/uninstall/reinstall lifecycle validated
→ human/Main acceptance
```

Evidence from one gate does not prove a later gate. Installer source without a compiled artifact is `configured`, not `installed`. Frozen launch does not validate Start Menu launch or installed lifecycle behavior.

# 6. Startup Diagnostics Boundary

The root executable entrypoint owns the outer startup-exception boundary. Unhandled startup exceptions must:

- produce a non-successful process result;
- write UTF-8 timestamp, exception type, message, and traceback to the writable per-user startup log;
- provide a concise visible error when Qt permits, otherwise stderr;
- avoid writing diagnostics under installed application files.

Startup-log creation is validated separately from every possible installed startup failure.

# 7. Connection and Shutdown Model

Normal MainWindow construction creates four page-owned service/repository/SQLite chains. Repository and ProductService expose local close capability.

Current composition-level shutdown behavior is:

```text
MainWindow.closeEvent()
→ idempotently close Register, Lists, History, and Settings services
→ each service closes its Repository
→ each Repository closes its SQLite connection
```

The composition-level correction was evidence-triggered: focused validation initially showed an isolated SQLite file remained held open. The bounded `MainWindow` coordinator was added, and the source/frozen shutdown gate then passed.

Stable rule:

```text
validate lifecycle behavior first
→ make the smallest correction justified by demonstrated failure
→ rerun the failed gate
```

Validated source/frozen shutdown does not prove installed shutdown; the installed execution context requires its own evidence.

# 8. Database and Transaction Safety

Every opened Repository must have an identifiable owner and deterministic close path. Validation that creates, migrates, resets, corrupts, or injects failure must use an isolated user-data root and close all connections before cleanup.

Repository mutation methods commit individual persistence operations. Multi-step receipt registration and purchase deletion/recalculation remain non-atomic as complete business workflows. Workflow atomicity is inherited Operational debt; it was not changed by the release-enablement unit.

# 9. Installer and Installed Lifecycle Rules

The installer consumes the built one-folder distribution rather than source files. The configured primary beta topology is per-user, x64, no-administrator installation with:

- stable installer identity;
- Start Menu shortcut;
- optional desktop shortcut;
- application files under the per-user Programs location;
- writable state under `%LOCALAPPDATA%/Markei`;
- default preservation of user data during uninstall.

Configuration does not validate retention. Acceptance requires direct evidence for:

```text
clean install
→ Start Menu launch
→ principal workflows
→ close and immediate reopen
→ persistence
→ compatible upgrade/reinstall
→ uninstall
→ retained-data verification
→ reinstall recovery
```

SmartScreen and antivirus observations are release evidence, not proof derived from source configuration.

# 10. Canonical Maintenance Rule

Update this model only when stable Operational behavior or reusable validation rules change. Command output, artifact hashes, transient blockers, and current work status belong in the record, checkpoint, or TODO rather than canon.
