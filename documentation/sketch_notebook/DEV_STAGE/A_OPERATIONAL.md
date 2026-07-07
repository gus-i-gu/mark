# [O] Session [NNN] | HH:MM_07_07_2026 | Markei

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Operational Chat.

Scope: execution, packaging investigation, validation commands, deployment risks, Windows runtime concerns.

Write authority for this session:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
```

No application source files were modified.
No permanent notebook files were modified.
No methodology files were modified.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BOOTSTRAP STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Read successfully:

1. `AGENTS.md`
2. `documentation/sketch_notebook/INDEX.md`
3. `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
4. `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
5. `documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md`
6. `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`
7. `documentation/sketch_notebook/methodology/FLUX.md`
8. `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`

Operational authority confirmed:

- Functional Operational Chat may inspect application source files when required.
- Functional Operational Chat may write only this assigned stage file.
- Application source files are not to be edited by this chat.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TASK INVESTIGATED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Investigate how to package the current PySide6 Markei app into a simple executable/installable form for non-developer users.

Requested focus:

- current run command
- Python/PySide6 dependencies
- database file handling
- app startup path
- executable packaging options
- validation commands
- risks for Windows users

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SOURCE FILES INSPECTED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Notebook/methodology:

- `AGENTS.md`
- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
- `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
- `documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md`
- `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`
- `documentation/sketch_notebook/methodology/FLUX.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`

Application/package-relevant files:

- `requirements.txt`
- `main.py`
- `app/__main__.py`
- `app/main.py`
- `app/desktop/main_window.py`
- `app/core/config.py`
- `app/core/database.py`
- `app/core/repository.py`
- `app/database/schema.sql`
- `app/database/seed.sql`

External packaging references inspected:

- PyInstaller usage documentation, version shown as `6.21.0`.
- Qt for Python deployment documentation for PyInstaller.
- Qt for Python deployment documentation for `pyside6-deploy`.
- Qt for Python deployment documentation for Nuitka.
- Nuitka user manual.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CURRENT RUN COMMAND
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

The repository currently exposes two normal development entry points.

## 1. Root script

`main.py` imports `main` from `app.main` and calls it under the standard guard:

```python
from app.main import main

if __name__ == "__main__":
    main()
```

Development command:

```powershell
python main.py
```

## 2. Package execution

`app/__main__.py` states that Markei can be run with:

```powershell
python -m app
```

It imports `main` from `app.main` and calls it under the standard guard.

## Operational recommendation

Use the root `main.py` as the first packaging entry point.

Reason:

- PyInstaller expects a concrete script path naturally.
- `main.py` is already a thin wrapper around `app.main.main()`.
- The application imports remain package-qualified through `app.*`.
- The generated executable name can be controlled independently with `--name Markei`.

Recommended first build entry:

```powershell
python -m PyInstaller --name Markei --windowed --onedir main.py
```

Use `--onedir` first, not `--onefile`.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PYTHON / PYSIDE6 DEPENDENCIES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current `requirements.txt` contains only:

```text
PySide6
```

No packaging dependency is currently listed.

## Development dependency needed for packaging

For a PyInstaller packaging path, add/install at build time:

```powershell
python -m pip install pyinstaller
```

Possible future `requirements-dev.txt`:

```text
pyinstaller
```

## Optional future dependency

For robust user-writable database placement, consider:

```text
platformdirs
```

Reason:

- Markei should not write the live SQLite database inside the frozen application bundle.
- On Windows, installed program directories may be read-only for normal users.
- A user-data path is safer than a project-relative path after packaging.

Possible target path pattern:

```text
%LOCALAPPDATA%/Markei/market.sqlite
```

or, if `platformdirs` is adopted:

```python
user_data_dir("Markei", "Markei")
```

This is a future implementation note, not a change performed in this session.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
APPLICATION STARTUP PATH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

`app/main.py` creates the Qt application:

```python
app = QApplication(sys.argv)
window = MainWindow()
window.show()
sys.exit(app.exec())
```

It imports `MainWindow` from:

```python
from app.desktop.main_window import MainWindow
```

It also contains a fallback for direct execution:

```python
if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
```

## Packaging implication

The normal packaged path should avoid relying on direct execution of `app/main.py`.

Preferred packaging entry:

```text
main.py
```

not:

```text
app/main.py
```

Reason:

- `main.py` starts at repository root during analysis.
- Package imports remain stable.
- The `app` package is treated as a package, not as a loose script directory.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DATABASE FILE HANDLING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This is the main packaging risk.

Current constants in `app/core/config.py`:

```python
DATABASE_NAME = "market.sqlite"
DATABASE_DIR_NAME = "app/database"
SCHEMA_NAME = "schema.sql"
SEED_NAME = "seed.sql"
```

Current path resolution in `app/core/database.py`:

```python
APP_DIR = Path(__file__).resolve().parent
PROJECT_DIR = APP_DIR.parent.parent
DATABASE_DIR = PROJECT_DIR / DATABASE_DIR_NAME
DATABASE_PATH = DATABASE_DIR / DATABASE_NAME
SCHEMA_PATH = DATABASE_DIR / SCHEMA_NAME
SEED_PATH = DATABASE_DIR / SEED_NAME
```

Current connection behavior:

```python
if not database_exists():
    initialize()
```

Current initialization behavior:

```python
DATABASE_DIR.mkdir(parents=True, exist_ok=True)
if DATABASE_PATH.exists():
    DATABASE_PATH.unlink()
connection = sqlite3.connect(DATABASE_PATH)
```

The schema and seed are read from:

```text
app/database/schema.sql
app/database/seed.sql
```

## Why this is fragile after packaging

In a normal source checkout, `PROJECT_DIR` resolves to the repository root.

After PyInstaller freezing, `__file__` no longer behaves like a normal source-tree anchor. The resolved path may point inside the generated bundle or temporary extraction area, depending on build mode.

That makes the current database strategy risky because Markei currently tries to keep writable data under:

```text
app/database/market.sqlite
```

This is acceptable for development, but not ideal for end users.

## Critical operational distinction

The packaged application needs two different database-related locations:

1. bundled read-only resources
2. user-writable runtime data

Bundled resources:

```text
schema.sql
seed.sql
```

User-writable runtime file:

```text
market.sqlite
```

These should not be treated as the same directory after packaging.

## Recommended future design

Keep schema and seed as packaged resources, but create/copy the live database into a user-writable directory.

Suggested runtime behavior:

```text
On startup:
1. Resolve user data directory for Markei.
2. Ensure that directory exists.
3. If market.sqlite is missing there, initialize it from bundled schema.sql and optional seed.sql.
4. Connect to the user-data database, not the bundled application folder.
```

Suggested Windows user-data target:

```text
%LOCALAPPDATA%\Markei\market.sqlite
```

Potential package resource target:

```text
app/database/schema.sql
app/database/seed.sql
```

## Minimal packaging workaround before refactor

For first build experiments only, include the database folder as PyInstaller data:

```powershell
python -m PyInstaller `
  --name Markei `
  --windowed `
  --onedir `
  --add-data "app/database;app/database" `
  main.py
```

This may allow `schema.sql` and `seed.sql` to be present in the bundle.

However, it does not fully solve the live SQLite write-location problem.

Do not treat this workaround as the final installable-user solution.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXECUTABLE PACKAGING OPTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Option A — PyInstaller `onedir`

Recommended first option.

Command:

```powershell
python -m PyInstaller --name Markei --windowed --onedir --add-data "app/database;app/database" main.py
```

Expected output:

```text
dist/Markei/Markei.exe
```

Operational advantages:

- Simplest PyInstaller path.
- Easier to inspect missing files.
- Easier to debug Qt plugin and DLL issues.
- Better first packaging target for PySide6 desktop apps.
- User can receive a zipped `dist/Markei/` folder.

Operational disadvantages:

- Distribution is a folder, not a single file.
- User must not move only `Markei.exe` away from its support files.
- A later installer should place the full folder correctly.

## Option B — PyInstaller `onefile`

Command:

```powershell
python -m PyInstaller --name Markei --windowed --onefile --add-data "app/database;app/database" main.py
```

Advantages:

- Produces one executable file in `dist/`.
- Simpler-looking artifact for non-developer users.

Risks:

- Startup can be slower because files are extracted at launch.
- Runtime paths are more complicated.
- A writable SQLite database must not live only inside the extracted temporary bundle.
- Debugging hidden import, Qt plugin, and resource-path issues is harder.

Operational recommendation:

Do not start with `onefile`.

Validate `onedir` first.

Move to `onefile` only after database path handling is refactored to a stable user-data directory.

## Option C — `pyside6-deploy`

Qt for Python provides `pyside6-deploy` as a deployment tool.

Potential command shape:

```powershell
pyside6-deploy main.py
```

Advantages:

- Comes from the Qt for Python ecosystem.
- Intended specifically for PySide applications.

Risks for current Markei:

- The current database handling still needs separation between packaged resources and user-writable data.
- Project-specific control may be less explicit than a PyInstaller spec file.
- PyInstaller remains the more common first diagnostic packaging path for small Python desktop apps.

Operational recommendation:

Consider later, but do not use as the first packaging path.

## Option D — Nuitka

Nuitka can compile Python applications and has Qt/PySide deployment support.

Potential command shape:

```powershell
python -m nuitka --standalone --enable-plugin=pyside6 --windows-console-mode=disable main.py
```

Advantages:

- Strong alternative for compiled Python distribution.
- Can produce standalone builds.

Risks for current Markei:

- More complex first setup.
- Slower iteration than PyInstaller.
- Database path problem remains unchanged.

Operational recommendation:

Keep Nuitka as a later alternative if PyInstaller produces unacceptable size, startup, or antivirus friction.

## Option E — Installer wrapper after PyInstaller

After `onedir` works, package the `dist/Markei/` folder with an installer tool.

Possible Windows installer directions:

- Inno Setup
- NSIS
- WiX Toolset
- MSIX packaging

Operational recommendation:

First milestone should not be a polished installer.

First milestone should be:

```text
A zipped dist/Markei folder that launches on another Windows machine.
```

Then add an installer after runtime behavior is stable.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RECOMMENDED PACKAGING SEQUENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Phase 1 — Confirm source runtime

From repository root:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python main.py
```

Alternative source command:

```powershell
python -m app
```

Expected result:

- Qt window opens.
- Tabs are visible.
- Register/Storage/Shortage/Market/History/Settings initialization does not crash.
- Database initializes if missing.

## Phase 2 — Install packaging dependency

```powershell
python -m pip install pyinstaller
python -m PyInstaller --version
```

## Phase 3 — First diagnostic build with console enabled

Use console first, even though final app should be windowed.

```powershell
python -m PyInstaller --name Markei --onedir --add-data "app/database;app/database" main.py
```

Run:

```powershell
.\dist\Markei\Markei.exe
```

Reason:

- Console output helps expose missing imports, missing files, schema path errors, and Qt plugin failures.

## Phase 4 — Windowed build

After console build works:

```powershell
python -m PyInstaller --name Markei --windowed --onedir --add-data "app/database;app/database" main.py
```

Run:

```powershell
.\dist\Markei\Markei.exe
```

## Phase 5 — Clean rebuild

```powershell
Remove-Item -Recurse -Force build, dist, Markei.spec
python -m PyInstaller --clean --name Markei --windowed --onedir --add-data "app/database;app/database" main.py
```

## Phase 6 — External-machine validation

Copy the entire folder:

```text
dist/Markei/
```

to another Windows user profile or another Windows machine.

Run:

```powershell
.\Markei.exe
```

Expected result:

- App opens without Python installed separately.
- App can create/open the SQLite database.
- App can register a product/purchase.
- App can close and reopen with data still present.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VALIDATION COMMANDS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Environment validation

```powershell
python --version
python -m pip --version
python -m pip show PySide6
python -m pip show shiboken6
python -m pip show pyinstaller
```

## Source validation

```powershell
python main.py
python -m app
```

## Database validation before packaging

```powershell
python -m app.core.database
```

Expected source-tree effect:

```text
app/database/market.sqlite
```

exists after initialization.

## Build validation

```powershell
python -m PyInstaller --clean --name Markei --onedir --add-data "app/database;app/database" main.py
```

Then:

```powershell
Test-Path .\dist\Markei\Markei.exe
Get-ChildItem .\dist\Markei
.\dist\Markei\Markei.exe
```

## Runtime persistence validation

Manual test:

1. Open packaged app.
2. Add one product/purchase through Register.
3. Close the app.
4. Reopen the app.
5. Confirm the data remains visible.

This test is essential because Markei is a data app, not just a window app.

## Missing-resource validation

Temporarily rename/remove the source-tree `app/database/market.sqlite`, rebuild, and run the packaged app.

Expected result:

- If the database does not exist, packaged app should still be able to initialize from schema.

Current risk:

- With current path logic, this may fail or create the database inside the bundle layout rather than a safe user-data directory.

## Debug build command

If the windowed build silently fails:

```powershell
python -m PyInstaller --clean --name Markei --onedir --add-data "app/database;app/database" main.py
.\dist\Markei\Markei.exe
```

Avoid `--windowed` while debugging so tracebacks remain visible.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WINDOWS USER RISKS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Moving only the `.exe`

For `onedir`, the user must keep the whole folder together.

Bad:

```text
Move only Markei.exe to Desktop.
```

Good:

```text
Move or install the whole Markei folder.
```

## 2. Writable database location

If the app is installed under:

```text
C:\Program Files\Markei\
```

normal users may not be allowed to write there.

Therefore the live SQLite database should eventually move to:

```text
%LOCALAPPDATA%\Markei\market.sqlite
```

or equivalent.

## 3. Antivirus / SmartScreen warnings

Unsigned executables downloaded from the internet may trigger Windows SmartScreen or antivirus warnings.

This is common for small independent apps.

Mitigation later:

- code signing certificate;
- stable installer;
- version metadata;
- avoid suspicious compression tools;
- distribute through a trusted channel.

## 4. Onefile temporary extraction

`--onefile` extracts bundled contents at runtime.

Risks:

- slower startup;
- temporary-directory interference;
- resource path surprises;
- unsafe assumption that writable data can live near bundled files.

## 5. Hidden crash when using `--windowed`

`--windowed` hides the console.

If the app crashes during startup, the user may see nothing.

Mitigation:

- validate first with console enabled;
- add GUI error reporting later;
- add logging to a user-data log file later.

## 6. Qt platform plugin failures

PySide6 apps depend on Qt plugins and DLLs.

Common symptom:

```text
Could not load the Qt platform plugin "windows"
```

Mitigation:

- start with PyInstaller `onedir`;
- inspect collected files;
- ensure build is performed inside the intended virtual environment;
- avoid mixing global PySide6/Shiboken installs with venv installs.

## 7. Python version compatibility

The local project context previously observed Python `3.14.6` on Windows.

Packaging tools and binary GUI libraries are sensitive to Python version support.

Operational recommendation:

- validate PySide6 and PyInstaller with the exact local Python version;
- if packaging fails due to wheel/tool support, use the newest broadly-supported stable Python version available for PySide6/PyInstaller at build time;
- do not assume that a source app running under one Python version guarantees a frozen app will build cleanly under the same version.

## 8. SQLite file locks

Markei has previously encountered database lock/permission behavior during database reinitialization.

The current `initialize()` function deletes the existing SQLite file before rebuilding:

```python
if DATABASE_PATH.exists():
    DATABASE_PATH.unlink()
```

Risks:

- failure if the DB is open;
- data loss if reset is triggered unintentionally;
- permission failure under installed directories.

Installer/runtime behavior should not routinely call destructive reset.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MINIMAL PATCH PLAN FOR MAIN SYNTHESIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This Operational Chat did not patch application files.

Suggested Main/Codex materialization plan:

## Patch 1 — Separate bundled resources from user data

Target:

```text
app/core/database.py
app/core/config.py
```

Intent:

- Keep `schema.sql` and `seed.sql` as packaged resources.
- Move live `market.sqlite` to a user-writable directory.
- Avoid writing under the frozen bundle.

Possible new conceptual paths:

```text
RESOURCE_DATABASE_DIR = bundled app/database directory
USER_DATABASE_DIR = user data directory
DATABASE_PATH = USER_DATABASE_DIR / market.sqlite
SCHEMA_PATH = RESOURCE_DATABASE_DIR / schema.sql
SEED_PATH = RESOURCE_DATABASE_DIR / seed.sql
```

## Patch 2 — Add frozen-resource path helper

Target:

```text
app/core/paths.py
```

or inside existing database/config layer if avoiding a new file.

Intent:

- Resolve normal source-tree paths during development.
- Resolve PyInstaller `_MEIPASS` or bundle-relative paths when frozen.

Possible behavior:

```python
if getattr(sys, "frozen", False):
    resource_base = Path(sys._MEIPASS)
else:
    resource_base = project_root
```

## Patch 3 — Add packaging dependency path

Target:

```text
requirements-dev.txt
```

Possible content:

```text
pyinstaller
```

Optional later:

```text
platformdirs
```

## Patch 4 — Add packaging script or documented command

Possible target:

```text
scripts/build_windows.ps1
```

or notebook operational runbook after Main synthesis.

Initial command:

```powershell
python -m PyInstaller --clean --name Markei --windowed --onedir --add-data "app/database;app/database" main.py
```

## Patch 5 — Add basic runtime logging before final windowed distribution

Target:

```text
app/main.py
```

Intent:

- Capture startup exceptions to a user-data log file.
- Reduce silent failure under `--windowed`.

This can wait until basic packaging works.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OPERATIONAL CONCLUSION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Markei is close to being packageable as a simple Windows desktop app, but not yet ready for a reliable non-developer installer.

The current best first packaging target is:

```powershell
python -m PyInstaller --name Markei --windowed --onedir --add-data "app/database;app/database" main.py
```

The current best first user-facing artifact is:

```text
A zipped dist/Markei folder.
```

The main blocker before calling it installable is database path handling.

The live SQLite file should move out of the application/package directory and into a user-writable Markei data directory.

Until that is done, `onedir` may work as a local experiment, but it should not be trusted as a durable Windows install for non-developer users.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NEXT RECOMMENDED ACTION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Ask Main Chat to synthesize this report into `D_OPS_STAGE.md` for Codex materialization.

Primary implementation target:

```text
Make database path handling packaging-safe before producing the first Windows executable.
```

Suggested Codex task after Main synthesis:

```text
Refactor Markei database startup so schema/seed are read as bundled resources while market.sqlite is created in a user-writable app data directory, then add a Windows PyInstaller build command/runbook and validate source + packaged startup.
```
