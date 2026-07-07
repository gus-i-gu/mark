# [M] Session 004 | 11:??_07_07_2026 | Markei

# D_OPS_STAGE — Main Operational Materialization Stage

> Source stages:
> - `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
> - `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
> - `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
>
> Purpose: Codex-ready operational implementation brief for making Markei packageable as a simple Windows desktop app.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Operational Synthesis

The new milestone is:

```text
Make Markei installable/executable and usable by non-developer users.
```

Operational, Design, and Didactic stages agree that this is not merely an `.exe` question.

The central operational blocker is path/data separation:

```text
Program files/resources
    must be bundled with the app.

User data
    must live in a user-writable app data folder.
```

Current development behavior is repository-relative:

```text
app/database/schema.sql
app/database/seed.sql
app/database/market.sqlite
```

This is acceptable while developing from a source checkout, but it is fragile for a packaged Windows desktop app.

The first reliable packaging milestone should therefore be:

```text
Source app continues to run.
Database initialization becomes packaging-safe.
PyInstaller onedir build can launch.
Packaged app can create/read/write user data outside the bundle.
```

---

# 2. Approved Operational Direction

Use PyInstaller `onedir` as the first packaging path.

Do not begin with `onefile`.

Reason:

- `onedir` is easier to inspect and debug;
- PySide6/Qt support files are easier to verify;
- missing schema/resource files are easier to diagnose;
- `onefile` complicates temporary extraction and writable SQLite paths.

The first user-facing artifact is not a polished installer yet.

Approved first artifact:

```text
A zipped dist/Markei folder containing Markei.exe and support files.
```

Installer tooling such as Inno Setup, NSIS, WiX, or MSIX is deferred until the runtime path behavior is stable.

---

# 3. Required Code / Repository Changes

## 3.1 Make database paths packaging-safe

Primary targets:

```text
app/core/config.py
app/core/database.py
```

Optional new helper target if cleaner:

```text
app/core/paths.py
```

Required behavior:

1. Schema/seed files remain bundled resources.
2. The live SQLite database file is created in a user-writable app data directory.
3. The app must work both from source and from a frozen PyInstaller build.
4. The app must not write the live user database inside the frozen application bundle.

Conceptual path split:

```text
RESOURCE_DATABASE_DIR
    location containing bundled schema.sql and seed.sql

USER_DATABASE_DIR
    user-writable Markei data folder

DATABASE_PATH
    USER_DATABASE_DIR / market.sqlite

SCHEMA_PATH
    RESOURCE_DATABASE_DIR / schema.sql

SEED_PATH
    RESOURCE_DATABASE_DIR / seed.sql
```

Windows target for user data:

```text
%LOCALAPPDATA%\Markei\market.sqlite
```

Implementation may use the standard library only, for example:

```python
Path(os.environ.get("LOCALAPPDATA", Path.home() / "AppData" / "Local")) / "Markei"
```

Do not add `platformdirs` unless Codex determines it is necessary and records the reason. The preferred first patch should avoid adding a new runtime dependency.

## 3.2 Add frozen resource path handling

When running from source, resource paths should resolve to the repository/project resource location.

When frozen by PyInstaller, resource paths should resolve through the PyInstaller runtime resource base.

Typical detection pattern:

```python
if getattr(sys, "frozen", False):
    resource_base = Path(getattr(sys, "_MEIPASS", Path(sys.executable).parent))
else:
    resource_base = project_root
```

Codex should inspect actual current paths before choosing exact implementation.

## 3.3 Preserve safe initialization behavior

Current initialization deletes an existing database file before rebuilding.

For normal startup/user-run behavior:

```text
If market.sqlite is missing:
    create it from schema.sql and optional seed.sql.

If market.sqlite exists:
    connect to it; do not delete it.
```

Destructive reset behavior must not happen during normal startup.

If a reset helper remains, it should be explicit and not called automatically by `connect()`.

## 3.4 Add development packaging dependency

Create or update:

```text
requirements-dev.txt
```

with:

```text
pyinstaller
```

Do not add PyInstaller to `requirements.txt` unless there is already a project convention that runtime and dev dependencies are combined.

## 3.5 Add a Windows build script or runbook

Preferred target:

```text
scripts/build_windows.ps1
```

If the `scripts/` directory does not exist, Codex may create it.

The first build script should:

1. run from repository root or check that it is in repository root;
2. call PyInstaller using module mode;
3. use `--clean`;
4. use `--name Markei`;
5. use `--onedir`;
6. include bundled database resources;
7. build from `main.py`.

Initial command shape:

```powershell
python -m PyInstaller --clean --name Markei --onedir --add-data "app/database;app/database" main.py
```

Add `--windowed` only after console-mode build is validated.

The build script may support a `-Windowed` flag or similar, but keep it simple.

## 3.6 Add or update operational runbook material

Create or update permanent operational notes under:

```text
documentation/sketch_notebook/operational/
```

Suggested file if absent:

```text
documentation/sketch_notebook/operational/PACKAGING_WINDOWS.md
```

This runbook should include:

- source validation commands;
- PyInstaller install command;
- diagnostic console build command;
- windowed build command after validation;
- expected output path `dist/Markei/Markei.exe`;
- external-machine validation checklist;
- warning that users must keep the entire `dist/Markei/` folder together for `onedir` builds;
- note that a polished installer is a later milestone.

---

# 4. Do Not Do

Codex must not:

1. Start with PyInstaller `--onefile`.
2. Add cloud sync, accounts, analytics, scraping, barcode services, or remote APIs.
3. Move the project to a web/API architecture.
4. Replace SQLite.
5. Change the full UI navigation in this operational packaging patch unless explicitly directed by F_DSN_STAGE and scope is approved.
6. Modify methodology files.
7. Treat `app/database/market.sqlite` inside the bundle as the final user-data strategy.
8. Delete user data during normal startup.

---

# 5. Required Inspection Before Patch

Inspect:

```text
main.py
app/__main__.py
app/main.py
app/core/config.py
app/core/database.py
app/core/repository.py
app/database/schema.sql
app/database/seed.sql
requirements.txt
```

Search for direct assumptions about:

```text
app/database/market.sqlite
DATABASE_PATH
DATABASE_DIR
SCHEMA_PATH
SEED_PATH
Path(__file__)
sys._MEIPASS
```

Report any discovered path assumptions before finalizing the patch.

---

# 6. Validation Commands

After patching, run from repository root:

```powershell
python -m compileall app
```

Then source runtime validation:

```powershell
python main.py
```

Alternative source command:

```powershell
python -m app
```

Database validation:

```powershell
python - <<'PY'
from app.core import database
print("database", database.DATABASE_PATH)
print("schema", database.SCHEMA_PATH)
print("seed", database.SEED_PATH)
connection = database.connect()
print("connected")
connection.close()
PY
```

Build dependency validation:

```powershell
python -m pip show pyinstaller
```

If missing:

```powershell
python -m pip install -r requirements-dev.txt
```

First diagnostic build:

```powershell
python -m PyInstaller --clean --name Markei --onedir --add-data "app/database;app/database" main.py
```

Run packaged app:

```powershell
.\dist\Markei\Markei.exe
```

If a build script is added, also validate:

```powershell
.\scripts\build_windows.ps1
```

---

# 7. Manual Validation Checklist

Codex should report what it could and could not validate.

Manual user-data test:

1. Launch source app.
2. Confirm database path points to user app data or approved dev/user data path.
3. Add one purchase.
4. Close app.
5. Reopen app.
6. Confirm data persists.
7. Build `onedir` executable.
8. Launch `dist/Markei/Markei.exe`.
9. Add one purchase in packaged app.
10. Close packaged app.
11. Reopen packaged app.
12. Confirm data persists.
13. Confirm the app does not require Python to be manually invoked by the user.

If GUI validation cannot be completed in the current environment, Codex must say so clearly and provide the exact command outputs it did obtain.

---

# 8. Expected Codex Report

Codex must report:

1. files changed;
2. database path strategy chosen;
3. where `schema.sql` and `seed.sql` are read from;
4. where `market.sqlite` is created;
5. whether destructive initialization was avoided during normal startup;
6. whether `requirements-dev.txt` was created/updated;
7. whether `scripts/build_windows.ps1` was created;
8. operational runbook files created/updated;
9. validation commands run;
10. command outputs;
11. whether `dist/Markei/Markei.exe` was produced;
12. remaining risks.
