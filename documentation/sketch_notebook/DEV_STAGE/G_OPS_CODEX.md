# G_OPS_CODEX.md

> Cycle: 05
> Sprint: 01 - Windows Desktop Installation
> Report type: Codex operational evidence

## 1. Bootstrap and stage files read

Read in required order:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

Also read:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

## 2. Repository baseline confirmed

Branch used: `agent/cycle05-install-staging`.

Baseline confirmed:

```text
main.py -> app.main.main() -> QApplication -> MainWindow
Desktop UI -> ProductService -> Repository -> SQLite
%LOCALAPPDATA%\Markei\market.sqlite
```

## 3. Files changed, created, and deleted

Changed:

```text
main.py
app/__main__.py
app/main.py
app/core/database.py
app/core/repository.py
app/core/services.py
app/desktop/ui/pages/register_page.py
requirements.txt
scripts/build_windows.ps1
```

Created:

```text
.gitignore
README.md
requirements-build.txt
packaging/markei.spec
packaging/windows/markei.iss
scripts/validate_windows_package.ps1
tests/test_cycle05_installation.py
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Deleted from version control:

```text
Markei.spec
app/database/market.sqlite
tracked __pycache__/*.pyc files
tracked build/ generated PyInstaller files
tracked dist/ generated PyInstaller files
```

Generated-but-ignored validation output:

```text
build/
dist/
tests/__pycache__/
```

## 4. Dependency versions selected

Validated environment:

```text
Python 3.14.6
PySide6 6.11.1
PyInstaller 6.21.0
```

Pinned declarations:

```text
requirements.txt -> PySide6==6.11.1
requirements-build.txt -> pyinstaller==6.21.0
```

## 5. Startup failure-boundary evidence

Implemented top-level boundary in `app/main.py`.

Induced failure command returned:

```text
exit 1
logs 1
contains True
```

Diagnostic path example:

```text
%LOCALAPPDATA%\Markei\logs\startup-<timestamp>.log
```

The boundary reports that user data was not reset or replaced.

## 6. Resource and user-data path evidence

Source resource discovery:

```text
resource_base H:\Users\Gus\source\repo\markei
schema_exists True H:\Users\Gus\source\repo\markei\app\database\schema.sql
database_path C:\Users\gusrm\AppData\Local\Markei\market.sqlite
```

Frozen payload validation found:

```text
dist\Markei\_internal\app\database\schema.sql
```

No `seed.sql`, `market.sqlite`, `.sqlite`, `.sqlite-wal`, or `.sqlite-shm` file was present in the frozen runtime after the new build.

## 7. Production seed-policy evidence

`database.initialize()` now executes `schema.sql` only by default.

`seed.sql` remains in source as a development fixture and is executable only through explicit `initialize_with_sample_data()` / `include_sample_data=True`.

`packaging/markei.spec` bundles only `schema.sql`.

## 8. Empty-database corrections

Corrections:

```text
Register default Store ID 1 removed; empty Store ID maps to NULL.
Register validates non-numeric Store ID before service call.
ProductService creates a user-entered category when the first receipt names a new category.
ProductService reports a clear missing-store prerequisite if a non-existing store ID is supplied.
```

Unit evidence:

```text
products 0
purchases 0
stores 0
categories 0
settings > 0
```

Public page construction evidence:

```text
tabs 4
['Register', 'Lists', 'History', 'Settings']
```

## 9. PyInstaller configuration evidence

Created `packaging/markei.spec`.

Configuration:

```text
entrypoint: root main.py
output: one-folder dist\Markei\Markei.exe
console: False
UPX: False
bundled data: app/database/schema.sql
version metadata: generated from app.core.config.VERSION
Qt modules: PySide6.QtCore, PySide6.QtGui, PySide6.QtWidgets
```

PyInstaller build completed successfully.

## 10. Inno Setup configuration evidence

Created `packaging/windows/markei.iss`.

Configuration:

```text
per-user install
DefaultDirName={localappdata}\Programs\Markei
PrivilegesRequired=lowest
Start Menu shortcut
optional desktop shortcut
ordinary uninstall registration
stable AppId
installer output Markei-Setup-<version>.exe
no SQL execution
no migration logic
SQLite files excluded from payload
```

Installer compilation was not executed because `ISCC.exe` was unavailable.

## 11. Commands executed

```powershell
git status --short --branch
git branch --all --list
git fetch origin agent/cycle05-install-staging:agent/cycle05-install-staging
Get-Content <bootstrap and stage files>
rg --files
git rm -r build dist __pycache__ app/database/market.sqlite Markei.spec
git rm -rf app/__pycache__ app/core/__pycache__ app/database/__pycache__ app/desktop/__pycache__ app/desktop/ui/__pycache__ app/desktop/ui/pages/__pycache__ app/desktop/ui/widgets/__pycache__ app/mobile/__pycache__
python -c "import sys; print(sys.version); import PySide6; print('PySide6', PySide6.__version__)"
python -m compileall -q main.py app tests
python -m unittest discover -s tests -v
python -m PyInstaller --version
Get-Command ISCC.exe -ErrorAction SilentlyContinue
python -m PyInstaller --noconfirm --clean packaging\markei.spec
.\scripts\validate_windows_package.ps1
.\dist\Markei\Markei.exe clean-profile launch probe
offscreen MainWindow construction probe
restart persistence probe
startup failure boundary probe
.\scripts\build_windows.ps1
```

## 12. Source regression results

Passed:

```text
python -m compileall -q main.py app tests
python -m unittest discover -s tests -v
offscreen MainWindow construction: Register, Lists, History, Settings
source resource discovery: schema exists under app/database/schema.sql
```

Source GUI event-loop launch was not left running as a manual UI session; offscreen construction was used to verify public page startup safely.

## 13. Frozen-runtime results

Passed:

```text
python -m PyInstaller --noconfirm --clean packaging\markei.spec
dist\Markei\Markei.exe produced
dist\Markei\_internal\app\database\schema.sql present
.\scripts\validate_windows_package.ps1 passed
```

Frozen launch probe:

```text
alive=True
dbExists=True
```

Process was stopped after startup to avoid leaving a GUI process running.

## 14. Seed-free first-launch results

Clean temporary profile frozen launch created:

```text
%LOCALAPPDATA%\Markei\market.sqlite
```

Counts:

```text
products: 0
purchases: 0
stores: 0
categories: 0
settings: 6
```

## 15. First-user-data persistence results

Service-level restart persistence probe:

```text
products 1
history 1
stores 0
```

The first receipt used a user-entered category and no seeded store.

## 16. Installer, upgrade, uninstall, and reinstall results

Implemented installer script and build-script invocation.

Unavailable:

```text
installer compilation
Start Menu launch
upgrade preservation through installer
uninstall preservation through installer
reinstall recovery through installer
```

Reason:

```text
ISCC.exe was not found in the environment.
```

Design evidence from script:

```text
%LOCALAPPDATA%\Markei is not referenced for deletion.
No SQL appears in markei.iss.
SQLite payload files are excluded.
```

## 17. Failure-path results

Induced startup failure returned non-zero and wrote a traceback log.

No reset path is called from the failure boundary.

## 18. SmartScreen or antivirus observations

Not executed. No signed installer artifact was produced because Inno Setup was unavailable, and no SmartScreen or antivirus scan was available in the execution environment.

## 19. Instructions completed and skipped

Completed:

```text
startup failure boundary
schema-only production initialization
seed fixture made explicit
empty database public page construction
first real data creation without seed
PyInstaller one-folder configuration and build
payload validation
Inno Setup per-user script
dependency pinning
release documentation
G/H/I evidence reports
```

Skipped/unavailable:

```text
installer compilation and installed-app lifecycle validation
manual Start Menu launch
SmartScreen/antivirus observation
clean dependency installation in a fresh venv
```

## 20. Failures, blockers, and unresolved risks

Blocker:

```text
Inno Setup ISCC.exe unavailable; installer path could not be compiled or installed.
```

Risks:

```text
Inno script syntax and relative paths remain uncompiled.
Source launch with a synthetic LOCALAPPDATA disturbed the Windows Python launcher, so clean-profile source GUI launch was not used.
Qt offscreen construction emitted a font-directory warning.
No production code signing.
No manual human UI walkthrough.
```

## 21. Suggested follow-up

Install Inno Setup, run `.\scripts\build_windows.ps1`, then validate installer install, Start Menu launch, upgrade, uninstall preservation, reinstall recovery, and SmartScreen/antivirus behavior on a clean Windows profile.
