# 10_OPERATIONAL_STATE.md

> Version: Cycle 06 checkpoint 0.3
> Status: Active operational checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Operational
> Branch: `sketch-notebook-recovery`
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Active work source: `operational/04_TODO.md`

---

# 1. Current Cycle 06 State

Markei's first Windows release-enablement unit has been materialized and reconciled.

```text
configured: yes
built: yes
launched: yes — isolated frozen launch and immediate reopen
installed: blocked
validated: partial
accepted: no
```

The frozen one-folder runtime was built and partially validated. The installer source is configured, but installer compilation is blocked because `ISCC.exe` was unavailable. The installed lifecycle is unvalidated, and the beta is not accepted.

# 2. Validated Current-Branch Evidence

The following gates passed on `sketch-notebook-recovery`:

- source compilation;
- five standard-library release tests;
- one-folder PyInstaller build;
- creation of `dist\Markei\Markei.exe`;
- schema-only package/resource boundary;
- absence of seed fixture, live database, WAL/SHM, and startup log from the distribution;
- isolated frozen first launch;
- external writable database creation;
- zero sample business rows on first launch;
- startup-log creation;
- focused source shutdown validation after correction;
- closure of all four page-owned repositories;
- immediate frozen reopen.

The executable evidence recorded by Codex was:

```text
dist\Markei\Markei.exe
SHA256 E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B
```

# 3. Shutdown Correction

Focused validation initially showed that the isolated SQLite file remained open after window closure. A bounded `MainWindow.closeEvent()` coordinator was added to idempotently close the four page-owned services. The rerun confirmed all repositories closed and the isolated database directory became removable.

This resolves the focused source/frozen shutdown gate. Installed shutdown remains unvalidated because no installed execution has occurred.

# 4. Current Packaging Boundary

Current production packaging is:

```text
Markei.spec
    authoritative one-folder windowed build
    includes schema.sql
    excludes seed.sql
    excludes tests
    UPX disabled
    version resource attached

scripts/build_windows.ps1
    clean-build invocation wrapper

installer/Markei.iss
    per-user x64 installer source
    Start Menu shortcut
    optional desktop shortcut
    external user data preserved by default

scripts/build_installer.ps1
    installer compile wrapper
    blocked without ISCC.exe
```

Startup failures are written to:

```text
%LOCALAPPDATA%/Markei/logs/startup.log
```

Writable database state remains at:

```text
%LOCALAPPDATA%/Markei/market.sqlite
```

# 5. Remaining Beta Blockers

```text
provide Inno Setup / ISCC.exe
→ compile installer
→ inspect installer artifact
→ clean install
→ Start Menu launch
→ principal workflow QA
→ close and immediate installed reopen
→ persistence verification
→ compatible upgrade/reinstall
→ uninstall retention verification
→ reinstall recovery
→ SmartScreen/antivirus observation
→ human acceptance
```

Workflow atomicity remains inherited Operational debt and was not changed.

# 6. Recovery Route

```text
1. Read this checkpoint.
2. Read 04_TODO.md for remaining work.
3. Read 12_OPERATIONAL_MODEL.md for stable rules.
4. Read 11_OPERATIONAL_RECORD.md for chronology and artifact evidence.
5. Read J_[M]_STAGE.md and G_OPS_CODEX.md only when reconciliation detail is required.
6. Inspect source only when these surfaces are insufficient or drift is suspected.
```

Refresh this checkpoint when installer compilation or any installed-lifecycle gate changes status.
