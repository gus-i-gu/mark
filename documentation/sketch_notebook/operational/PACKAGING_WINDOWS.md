# Windows Packaging Runbook

## Goal

Produce a diagnostic PyInstaller `onedir` build for external Windows testing.

The first artifact is a portable folder:

```text
dist/Markei/Markei.exe
```

Users must keep the entire `dist/Markei/` folder together. A polished installer
is a later milestone.

## Source Validation

```powershell
python -m compileall app
python main.py
python -m app
```

## Database Validation

```powershell
python -c "from app.core import database; print(database.DATABASE_PATH); print(database.SCHEMA_PATH); print(database.SEED_PATH); connection = database.connect(); print('connected'); connection.close()"
```

Expected behavior:

- `schema.sql` and `seed.sql` are read from bundled application resources.
- `market.sqlite` is created under the user's local app data folder.
- Existing user databases are not deleted during normal startup.

## Install Build Dependency

```powershell
python -m pip install -r requirements-dev.txt
```

## Diagnostic Console Build

```powershell
python -m PyInstaller --clean --name Markei --onedir --add-data "app/database/schema.sql;app/database" --add-data "app/database/seed.sql;app/database" main.py
```

Or:

```powershell
.\scripts\build_windows.ps1
```

## Windowed Build After Console Validation

```powershell
.\scripts\build_windows.ps1 -Windowed
```

## Packaged App Validation

```powershell
.\dist\Markei\Markei.exe
```

External-machine checklist:

1. Launch `dist/Markei/Markei.exe`.
2. Confirm the app opens without requiring a terminal command.
3. Confirm the database is created in the user app data folder.
4. Add one purchase.
5. Close and reopen the packaged app.
6. Confirm the purchase persists.
7. Confirm the app still works when the entire `dist/Markei/` folder is copied
   to another local folder.
