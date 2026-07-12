# D_OPS_STAGE — Cycle 06 Sprint 02 Final Desktop Validation

> Status: Main-approved materialization stage
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Inputs: `A_OPERATIONAL.md`, `B_DIDACTIC.md`, `C_DESIGN.md`
> Codex report target: `DEV_STAGE/G_OPS_CODEX.md`

## 1. Objective

Complete the remaining Cycle 06 milestone gates without reopening Sprint 01 architecture or packaging decisions.

Current inherited state:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

Sprint 02 must:

```text
provide Inno Setup / ISCC.exe
→ rebuild the frozen runtime
→ compile and inspect the installer
→ install in an ordinary per-user Windows environment
→ launch from the Start Menu without Python or source checkout
→ exercise Register / Lists / History / Settings
→ close and immediately reopen
→ verify persistence
→ test same-version reinstall or compatible upgrade
→ uninstall and verify retained user data
→ reinstall and recover retained data
→ record SmartScreen / antivirus observations
→ produce evidence for Main/human acceptance
```

This is one validation-centered materialization unit. Do not perform speculative corrections before a gate fails.

## 2. Mandatory Bootstrap

Before implementation or validation:

1. read repository `AGENTS.md` completely;
2. read `documentation/sketch_notebook/INDEX.md`;
3. follow the full methodology sequence indicated there;
4. recover state from `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, and `[M]_STAGE/J_[M]_STAGE.md`;
5. read D/E/F as one coherent authority set.

If a Main-stage naming conflict appears, `J_[M]_STAGE.md` is the active file.

## 3. Accepted Boundaries — Do Not Reopen

Preserve:

- `Markei.spec` as authoritative one-folder packaging source;
- `scripts/build_windows.ps1` as invocation wrapper;
- `installer/Markei.iss` as installer authority;
- `scripts/build_installer.ps1` as compile wrapper;
- schema-only production package;
- exclusion of `seed.sql`, live DB, WAL/SHM, logs, tests, caches, and source residue;
- per-user installation under `%LOCALAPPDATA%\Programs\Markei`;
- retained user state under `%LOCALAPPDATA%\Markei`;
- identity `Markei` / `Markei.exe` / `0.1.0` / publisher `Markei` / stable AppId;
- Start Menu shortcut required;
- desktop shortcut optional;
- launcher-owned startup diagnostics;
- current `MainWindow.closeEvent()` service-close coordination.

## 4. Toolchain and Build Route

Provide Inno Setup 6 and resolve `ISCC.exe` through one supported route:

```powershell
.\scripts\build_installer.ps1 -ISCCPath "C:\path\to\ISCC.exe"
```

or:

```powershell
$env:ISCC_PATH = "C:\path\to\ISCC.exe"
.\scripts\build_installer.ps1
```

or normal Inno Setup 6 installation discovery.

Record:

- compiler path;
- compiler version;
- builder Python version;
- PyInstaller and PySide6 versions;
- working branch;
- exact commands and exit codes.

Run at minimum:

```powershell
python -m compileall app main.py
python -m unittest discover -s tests
.\scripts\build_windows.ps1
.\scripts\build_installer.ps1 -ISCCPath "C:\path\to\ISCC.exe"
```

Attempt `python -m pytest` only if pytest is available; absence must be reported, not hidden.

Expected artifacts:

```text
dist\Markei\Markei.exe
dist\installer\Markei-Setup-0.1.0-x64.exe
```

## 5. Installer Artifact Gate

After compilation, record:

- artifact path;
- size;
- timestamp;
- SHA256;
- installer-visible name, version, publisher, architecture;
- compiler command result.

Verify the installer consumes `dist\Markei` and does not introduce:

```text
seed.sql
market.sqlite
*.sqlite-wal
*.sqlite-shm
*.log
__pycache__
*.pyc
tests
source tree
```

A compiled installer is `built`, not `installed` or lifecycle `validated`.

## 6. Safe Installed-Lifecycle Environment

Prefer a dedicated ordinary Windows test account with no previous Markei state.

Before installation, record whether these exist:

```text
%LOCALAPPDATA%\Programs\Markei
%LOCALAPPDATA%\Markei
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Markei
```

Do not use or delete the ordinary user’s real Markei data. Preserve a copy of the dedicated account’s database before destructive lifecycle transitions.

## 7. Clean Installation and Installed Launch

1. Run the compiled installer interactively.
2. Confirm per-user destination and no administrator requirement.
3. Confirm installed files under `%LOCALAPPDATA%\Programs\Markei`.
4. Confirm Start Menu shortcut creation.
5. Test optional desktop shortcut separately when selected.
6. Launch from the Start Menu only, without Python, repository checkout, or development working directory.
7. Confirm visible MainWindow and all four public surfaces.
8. Record any startup log, dialog, SmartScreen warning, or antivirus action.

## 8. Principal Workflow Gate

Use a unique test dataset and record semantic values, not only screenshots:

1. Settings: create or edit one uniquely named test store and save settings.
2. Register: register one unique product and purchase.
3. Lists: confirm the product appears in the expected projection.
4. History: confirm the purchase appears with expected values.
5. Settings: confirm saved values remain visible.

A workflow failure must be classified before any source correction.

## 9. Installed Close, Reopen, and Persistence Gate

Close through the normal window control and immediately relaunch from the Start Menu.

Verify:

- no retained database lock;
- no startup error;
- test store, product, purchase, Lists projection, History entry, and settings persist;
- `%LOCALAPPDATA%\Markei\market.sqlite` exists;
- installed-context cleanup is successful.

Sprint 01 frozen evidence cannot substitute for this installed-context gate.

## 10. Reinstall, Uninstall, and Recovery Gates

### Same-version reinstall

Run the same installer again. Confirm program files are repaired/replaced and the existing dataset remains available.

### Uninstall

Uninstall through Windows Installed Apps or the registered uninstaller. Confirm:

- installed program files removed;
- shortcuts removed;
- `%LOCALAPPDATA%\Markei\market.sqlite` retained.

### Reinstall recovery

Reinstall the same compatible package, launch from Start Menu, and confirm the retained dataset reappears without manual database copying.

Use semantic row evidence before and after transitions. Hashes may supplement but not replace data-content checks.

## 11. Human Validation Boundary

Codex may automate:

- compiler discovery and version capture;
- static tests and builds;
- installer compilation;
- hashes and file-set inspection;
- scripted path checks;
- database queries;
- silent actions only where they do not hide required observations.

Human evidence is required for:

- installer wizard and privilege behavior;
- SmartScreen/antivirus observations;
- Start Menu and desktop-shortcut usability;
- visible installed launch;
- Register, Lists, History, and Settings correctness;
- normal close and immediate reopen;
- retention-policy acceptance;
- final beta acceptance.

Codex must not declare `accepted`.

## 12. Failure Classification and Correction Authority

Classify the first failing gate as one of:

```text
toolchain prerequisite
installer configuration defect
packaging defect
installed runtime defect
application workflow defect
data-retention defect
Windows reputation/security observation
human acceptance failure
```

Stop dependent gates after a failure and preserve original evidence.

Only after direct failure evidence may Codex make the smallest relevant correction in:

- `scripts/build_installer.ps1`;
- `installer/Markei.iss`;
- `Markei.spec`;
- launcher diagnostics;
- existing resource/writable-path handling;
- current `MainWindow` shutdown coordination;
- a narrowly reproduced beta-blocking workflow;
- focused validation assets.

Re-run the failed gate and all dependent gates after correction.

## 13. Prohibited Scope

Do not introduce:

- composition-root or dependency-injection redesign;
- ProductService/Repository decomposition;
- transaction redesign unless separately reconciled after a demonstrated blocker;
- schema redesign or migration ledger;
- mobile, backend/API, synchronization, authentication, or cloud work;
- one-file packaging;
- auto-update, signing, rollback framework;
- broad UI redesign;
- optional uninstall data-deletion UX;
- unrelated cleanup.

## 14. G Report Contract

Replace `DEV_STAGE/G_OPS_CODEX.md` with a concise Sprint 02 report containing:

1. files changed and why;
2. toolchain versions and compiler path;
3. commands, working directory, and exit results;
4. frozen and installer artifact paths, sizes, and SHA256 hashes;
5. installed path and shortcut evidence;
6. workflow dataset and observed results;
7. close/reopen and persistence evidence;
8. reinstall, uninstall-retention, and recovery evidence;
9. SmartScreen/antivirus observations;
10. every failure, classification, correction, and rerun;
11. human-validation items completed or still pending;
12. evidence status using only:

```text
configured
built
launched
installed
validated
accepted
blocked
unknown
```

13. remaining blockers;
14. confirmation that prohibited scope was not introduced.

Do not modify permanent Operational memory, Main-root files, or methodology files.