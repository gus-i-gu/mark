# I_DSN_CODEX.md

> Cycle: 05
> Sprint: 01 - Windows Desktop Installation
> Report type: Codex design evidence

## 1. Bootstrap and stage files read

Read the required bootstrap, D/E/F, supporting A/B/C, `00_PROJECT_STATE.md`, and `06_SESSION_SCHEME.md`.

## 2. Accepted design decisions materialized

Materialized:

```text
PyInstaller one-folder runtime
per-user Inno Setup script
external %LOCALAPPDATA%\Markei user state
schema-only production initialization
application-owned migration/default insertion
data-preserving installer policy
startup failure boundary
single runtime version source
```

## 3. Files changed or created for design reasons

Runtime/source:

```text
main.py
app/__main__.py
app/main.py
app/core/database.py
app/core/repository.py
app/core/services.py
app/desktop/ui/pages/register_page.py
```

Packaging/release:

```text
packaging/markei.spec
packaging/windows/markei.iss
scripts/build_windows.ps1
scripts/validate_windows_package.ps1
requirements.txt
requirements-build.txt
.gitignore
README.md
tests/test_cycle05_installation.py
```

Removed tracked generated/runtime artifacts:

```text
build/
dist/
__pycache__/
app/database/market.sqlite
Markei.spec
```

## 4. Final packaging and installation context diagram

```text
main.py
-> app.main.main()
-> QApplication / MainWindow
-> ProductService
-> Repository
-> SQLite at %LOCALAPPDATA%\Markei\market.sqlite

packaging/markei.spec
-> dist\Markei\Markei.exe
-> packaging/windows/markei.iss
-> %LOCALAPPDATA%\Programs\Markei
```

Installer compilation was blocked by missing `ISCC.exe`.

## 5. Entrypoint and startup responsibility evidence

`main.py` and `app/__main__.py` remain narrow process delegates.

`app/main.py` owns:

```text
QApplication creation
MainWindow construction
event loop
fatal startup logging
fatal startup dialog where Qt is available
non-zero return on failure
```

It does not own ProductService rules, Repository SQL, or migrations.

## 6. Runtime-path ownership evidence

Runtime resource and user-data path behavior remains in `app/core/database.py`:

```text
resource_base()
user_data_dir()
SCHEMA_PATH
DATABASE_PATH
```

No UI page inspects `_MEIPASS`.

ProductService and Repository do not import packaging or installer modules.

## 7. Resource-state and user-state boundary evidence

Bundled read-only resource:

```text
dist\Markei\_internal\app\database\schema.sql
```

Writable user state:

```text
%LOCALAPPDATA%\Markei\market.sqlite
%LOCALAPPDATA%\Markei\logs\startup-*.log
```

Tracked active database was removed from source control.

## 8. Schema initialization ownership evidence

Application-owned:

```text
database.connect()
database.initialize()
database.migrate()
ensure_default_setting()
```

Installer-owned SQL: none.

## 9. Seed/sample-fixture decision evidence

Production:

```text
schema.sql only
no sample rows
no bundled market.sqlite
```

Development fixture remains explicit:

```text
initialize_with_sample_data()
include_sample_data=True
app/database/seed.sql remains in source
```

## 10. Empty-state design evidence

Zero products, purchases, stores, and categories was validated as a first-launch state.

Register now supports first receipt creation without a seeded store and creates the category named by the user-entered category field.

Lists, History, Settings, and Register constructed successfully against an empty database.

## 11. Repository, ProductService, and UI boundary evidence

Repository:

```text
added create_category()
continues to own SQL and row mapping
```

ProductService:

```text
owns first-receipt prerequisite interpretation
creates user-entered category
reports missing store prerequisite
```

UI:

```text
Register owns input defaults and validation messages
does not execute schema, inspect frozen runtime, or create sample records
```

## 12. PyInstaller and Inno Setup responsibility evidence

PyInstaller:

```text
freezes runtime
collects PySide6/Qt runtime components
bundles schema.sql
adds executable metadata
does not install or mutate user database
```

Inno Setup:

```text
places dist\Markei under %LOCALAPPDATA%\Programs\Markei
creates shortcuts
registers uninstall
excludes SQLite state
contains no SQL
```

## 13. Version-authority evidence

Runtime authority:

```text
app/core/config.py VERSION = "0.1.0"
```

PyInstaller version metadata is generated from the runtime authority.

Inno version is passed by `scripts/build_windows.ps1`; direct `markei.iss` fallback duplicates `0.1.0` and remains a consistency check item.

## 14. Upgrade and uninstall evidence

Configured:

```text
stable AppId
DefaultDirName={localappdata}\Programs\Markei
PrivilegesRequired=lowest
SQLite files excluded from payload
no deletion of %LOCALAPPDATA%\Markei
```

Not observed:

```text
upgrade preservation
uninstall preservation
reinstall recovery
```

Reason: Inno Setup compiler unavailable.

## 15. Desktop-to-mobile isolation evidence

Windows-specific files are isolated to:

```text
packaging/
scripts/build_windows.ps1
scripts/validate_windows_package.ps1
app/main.py startup shell
database runtime-path helpers
```

No mobile framework, API, backend, authentication, synchronization, or cross-device persistence was introduced.

SQLite remains Sprint 01 desktop persistence, not a declared mobile contract.

## 16. Boundary drift found

No new ProductService awareness of PyInstaller.

No Repository awareness of Inno Setup or Start Menu behavior.

No UI `_MEIPASS` usage.

Existing drift retained and reported:

```text
runtime-path helpers remain in app/core/database.py as accepted shortest-route desktop infrastructure coupling
```

## 17. Decisions not materialized

Not materialized:

```text
compiled installer artifact
installed application validation
portable ZIP
icon asset
schema-version ledger
code signing
explicit uninstall data-removal option
```

## 18. Deferred items and open questions

Deferred:

```text
Inno Setup environment installation
installer syntax validation
Start Menu launch validation
upgrade/uninstall/reinstall lifecycle validation
production signing
SmartScreen/antivirus observation
manual UI QA
Sprint 02 mobile planning
```

Open question:

```text
Whether direct Inno compilation without scripts should be allowed despite the fallback version duplication.
```

## 19. Suggested Design Chat follow-up

After Inno Setup validation, reconcile whether the runtime-path helpers should remain in `app/core/database.py` or move to a desktop runtime-path module before Sprint 02 cloning.
