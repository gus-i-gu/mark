# H_DDC_CODEX.md

> Cycle: 05
> Sprint: 01 - Windows Desktop Installation
> Report type: Codex didactic evidence

## 1. Bootstrap and stage files read

Read the required bootstrap, D/E/F, and supporting A/B/C stages. D/E/F were treated as direct materialization authority. A/B/C were supporting evidence only.

## 2. Implementation events observed

Observed transition:

```text
source entrypoint
-> PyInstaller one-folder runtime
-> Inno Setup script
-> installer validation blocked by missing ISCC.exe
```

Also observed seed-free first launch, empty business tables, first receipt creation, frozen runtime launch, and startup failure logging.

## 3. Concept candidates by proposed identifier

Evidence gathered for:

```text
&&&20 - Packaged Application Lifecycle
&&&21 - Packaging Versus Installation
&&&22 - Resource State Versus User State
&&&23 - Build-Time Versus Runtime Dependency
&&&24 - Reproducible Build Process
&&&25 - Successful Build Versus Validated Release
&&&26 - Release Version and Compatibility Contract
&&%09 - Frozen Python Execution Context
&%%15 - Markei Installed Data Lifecycle
```

No concept was promoted or assigned final learning maturity.

## 4. Existing concepts reinforced

Evidence reinforced:

```text
Naming as Data Contract
Configuration State
Default Value as Fallback Contract
Validation Boundary
Adapter Boundary
Capability Versus Placeholder
SQLite Schema Evolution
Service Contract Stability
Platform-Neutral Read-Model Shape
```

## 5. Entrypoint evidence

PyInstaller entrypoint:

```text
main.py
```

Root delegation remains:

```text
main.py -> app.main.main()
```

Source and packaged execution share `app.main.main()`.

## 6. Source versus frozen execution evidence

Source:

```text
resource_base -> repository root
schema -> app/database/schema.sql
database -> %LOCALAPPDATA%\Markei\market.sqlite
```

Frozen:

```text
schema -> dist\Markei\_internal\app\database\schema.sql
launch did not depend on repository working directory
```

`sys.frozen` and `_MEIPASS` remain isolated in database runtime-path infrastructure, not UI pages.

## 7. Build-time versus runtime dependency evidence

Runtime dependency:

```text
PySide6==6.11.1
```

Build-only dependency:

```text
pyinstaller==6.21.0
```

External installer tooling:

```text
Inno Setup ISCC.exe
```

`ISCC.exe` was unavailable.

## 8. Packaging versus installation evidence

PyInstaller produced:

```text
dist\Markei\Markei.exe
```

Inno Setup input exists:

```text
packaging/windows/markei.iss
```

Installed application state was not observed because installer compilation was unavailable.

## 9. Executable versus installer evidence

Executable validation occurred against:

```text
dist\Markei\Markei.exe
```

Installer artifact expected but not produced:

```text
dist\installer\Markei-Setup-0.1.0.exe
```

## 10. Bundled-resource evidence

Bundled:

```text
schema.sql
Qt runtime components collected by PyInstaller hooks
Windows executable version metadata generated from app.core.config.VERSION
```

Not bundled:

```text
seed.sql
market.sqlite
SQLite sidecars
```

## 11. Writable-user-state evidence

Created under temporary clean profile:

```text
%LOCALAPPDATA%\Markei\market.sqlite
```

The installer script does not touch `%LOCALAPPDATA%\Markei`.

## 12. Schema initialization versus seeding evidence

Schema initialization:

```text
database.connect() -> initialize() -> schema.sql -> migrate()
```

Production seeding:

```text
not file-existence driven
not enabled by default
```

Development fixture:

```text
initialize_with_sample_data()
include_sample_data=True
```

## 13. Empty-database evidence

Seed-free first launch counts:

```text
products: 0
purchases: 0
stores: 0
categories: 0
settings: 6
```

Public pages opened in offscreen construction:

```text
Register
Lists
History
Settings
```

Corrections:

```text
Store ID no longer defaults to missing store 1.
User-entered category can be created during first receipt.
Missing store ID reports a clear prerequisite.
```

## 14. Installed SQLite lifecycle evidence

Observed lifecycle through frozen launch and service restart:

```text
missing database -> created under user data directory
schema applied
settings inserted by migration
first receipt persisted
new service instance reopened product and history
```

Installer upgrade/uninstall lifecycle was not observed.

## 15. Release-version evidence

Authoritative runtime source:

```text
app/core/config.py -> VERSION = "0.1.0"
```

PyInstaller metadata is generated from that value in `packaging/markei.spec`.

Inno receives the version from `scripts/build_windows.ps1` as `/DMyAppVersion=<version>`. `markei.iss` contains a fallback `0.1.0` for direct manual compilation; this is duplicated declaration and should be checked during installer validation.

## 16. Successful build versus validated release evidence

Successful:

```text
PyInstaller build
payload validation
frozen startup probe
seed-free database creation
offscreen page construction
first receipt persistence
startup failure logging
```

Not validated:

```text
compiled installer
installed app
Start Menu launch
upgrade/uninstall/reinstall preservation
SmartScreen/antivirus
```

## 17. Tool-specific observations

PyInstaller owns freezing, runtime collection, schema bundling, and executable metadata.

Inno Setup script owns placement, shortcuts, uninstall registration, and installer metadata.

Neither tool owns SQL, migrations, business rules, or sample data.

## 18. Concept-numbering or notebook drift observed

B_DIDACTIC reported checkpoint/KANBAN numbering drift. Codex did not modify permanent didactic memory and did not reuse or promote identifiers.

`06_SESSION_SCHEME.md` remains mobile-preparation oriented, while current D/E/F and human direction define Sprint 01 as Windows desktop installation.

## 19. Concepts not ready for canon

Not ready for canonical promotion from Codex evidence alone:

```text
validated release
upgrade compatibility
installed application lifecycle
SmartScreen/antivirus behavior
rollback
code signing
```

## 20. Deferred concepts

Deferred:

```text
mobile framework
mobile UI
backend/API
authentication
synchronization
cross-device persistence
MSIX/Microsoft Store
automatic updater
production signing
strict deterministic builds
CI release publishing
```

## 21. Remaining didactic risks

Risks:

```text
installer behavior remains configured but unobserved
fallback Inno version duplicates app.core.config.VERSION
successful PyInstaller build may be mistaken for full release validation
tracked generated artifacts were removed, which should be explained as release hygiene rather than feature work
```

## 22. Suggested Didactic Chat follow-up

Classify the observed distinction between packaged runtime and installed application after Inno Setup validation exists. Keep PyInstaller and Inno as tooling evidence, not automatic canonical concepts.
