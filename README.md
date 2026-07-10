# Markei

Markei is a Windows desktop PySide6 application backed by SQLite.

## Runtime Data

- Application files install under `%LOCALAPPDATA%\Programs\Markei`.
- User data is stored under `%LOCALAPPDATA%\Markei`.
- The live database is `%LOCALAPPDATA%\Markei\market.sqlite`.
- Startup diagnostics are written under `%LOCALAPPDATA%\Markei\logs`.

The installer does not install, replace, migrate, or delete `market.sqlite`.
Normal uninstall preserves `%LOCALAPPDATA%\Markei`.

## Source Launch

```powershell
python -m pip install -r requirements.txt
python main.py
```

## Windows Build

Tested target:

- Windows per-user installation
- Python 3.14
- PySide6 and PyInstaller versions pinned in `requirements.txt` and `requirements-build.txt`

Clean build environment:

```powershell
py -3.14 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip install -r requirements-build.txt
.\scripts\build_windows.ps1
```

Primary outputs:

- Frozen runtime: `dist\Markei\Markei.exe`
- Installer, when Inno Setup is available: `dist\installer\Markei-Setup-<version>.exe`

The PyInstaller runtime bundles `app/database/schema.sql` only. `seed.sql` remains a development fixture and is not part of production initialization.

## Installer

The Inno Setup script is `packaging\windows\markei.iss`.

It installs the validated one-folder runtime, creates a Start Menu shortcut, optionally creates a desktop shortcut, registers uninstall, and preserves `%LOCALAPPDATA%\Markei`.

The installer contains no SQL execution and no migration logic.

## Backup

Close Markei, then copy:

```text
%LOCALAPPDATA%\Markei\
```

This preserves the SQLite database and sidecar files.

## Unsigned Build Notice

Sprint 01 artifacts are unsigned. Windows SmartScreen or antivirus products may warn about an unknown publisher until a future signing process exists.
