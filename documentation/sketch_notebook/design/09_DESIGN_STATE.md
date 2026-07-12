# 09_DESIGN_STATE.md

> Version: 0.2-cycle06
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Low-cost recovery surface for the current Cycle 06 Design state
> Sources: `01_ARCHITECTURE.md`, `14_MODEL_OVERVIEW.md`, `DEV_STAGE/G_OPS_CODEX.md`, `DEV_STAGE/I_DSN_CODEX.md`, `[M]_STAGE/J_[M]_STAGE.md`

---

# Current Milestone

Cycle 06 remains focused on one milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

The first bounded materialization unit is complete, but the milestone is not closed.

---

# Current Architecture

Markei remains a layered local desktop monolith:

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
Database Manager
    ↓
SQLite
```

Packaging and installation remain deployment concerns around this application boundary. No broad business, persistence, schema, or composition redesign was introduced.

---

# Cycle 06 Deployment State

Accepted current status:

```text
packaging boundary materialized
frozen runtime built and launched
resource/user-state boundary partially validated
startup diagnostics validated by test
shutdown correction validated in focused and frozen checks
installer source configured
installer compilation blocked
installed lifecycle unvalidated
beta not accepted
```

Evidence classification:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
installed: blocked
validated: partial
accepted: no
```

---

# Accepted Boundaries

## Packaging

- `Markei.spec` is the authoritative one-folder PyInstaller definition.
- `scripts/build_windows.ps1` invokes the spec rather than duplicating package composition.
- Production packaging includes `schema.sql`.
- Production packaging excludes `seed.sql`, live databases, WAL/SHM, logs, tests, caches, and development residue.

## User state

- `%LOCALAPPDATA%/Markei/market.sqlite` is retained writable user data.
- WAL/SHM files are transient writable companions.
- `%LOCALAPPDATA%/Markei/logs/startup.log` is generated writable diagnostics.
- External placement supports retention but does not prove uninstall or reinstall preservation.

## Startup

- Root `main.py` remains the launcher adapter and owns the outer startup-diagnostic boundary.
- `app.main.main()` remains responsible for Qt application construction.

## Shutdown

- Four pages continue to own four service/repository/connection chains.
- Focused validation initially demonstrated that distributed cleanup alone left the isolated SQLite file open.
- `MainWindow.closeEvent()` now idempotently coordinates closure of all four page-owned services.
- Local service/repository close responsibility remains intact.
- This is a bounded lifecycle correction, not a composition-root redesign.

## Installer and identity

Configured release identity:

```text
Markei
Markei.exe
0.1.0
Publisher: Markei
Stable AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
```

Configured installer policy:

```text
per-user installation
Start Menu shortcut
optional desktop shortcut
preserve %LOCALAPPDATA%/Markei by default
```

These installer behaviors are configured, not installed or lifecycle-validated.

---

# Validated Evidence

The following evidence is accepted for the bounded materialization:

- source/static compilation passed;
- five standard-library release tests passed;
- one-folder frozen runtime built;
- frozen runtime launched and reopened from an isolated profile;
- first launch created schema/default settings without sample business rows;
- distribution included `schema.sql` and excluded `seed.sql`, live DB, WAL/SHM, and startup logs;
- startup log path and content creation were validated;
- shutdown correction closed all four repositories and released the isolated database directory.

---

# Remaining Blocked Lifecycle Gates

```text
provide Inno Setup / ISCC.exe
→ compile installer
→ inspect installer artifact
→ clean per-user install
→ launch from Start Menu without Python/source checkout
→ exercise Register / Lists / History / Settings
→ close and immediate reopen
→ verify retained data
→ test compatible reinstall or upgrade
→ uninstall
→ verify preservation policy
→ reinstall and recover retained data
→ human acceptance
```

No compiled installer artifact currently exists.

---

# Current Open Risks

1. Installed program placement, shortcuts, and uninstall registration remain unvalidated.
2. Default data preservation through uninstall/reinstall remains configured but unproven.
3. Compatible upgrade/reinstall behavior against retained SQLite state remains unvalidated.
4. Human principal-workflow acceptance remains outstanding.
5. Workflow atomicity remains inherited product/design debt and was not changed.

---

# Explicit Deferrals

Outside Cycle 06:

- composition-root or dependency-injection redesign;
- ProductService/Repository decomposition;
- workflow transaction redesign unless separately evidenced and reconciled;
- schema redesign or migration ledger;
- mobile, backend/API, synchronization, authentication, and cloud persistence;
- auto-update, signing, rollback framework, and one-file packaging;
- optional uninstall data-deletion UX;
- broad UI/navigation redesign.

---

# Recovery Route

```text
Rapid current state
    → this file

Compact architecture map
    → design/14_MODEL_OVERVIEW.md

Exact accepted architecture
    → design/01_ARCHITECTURE.md

Chronology and rationale
    → design/03_DECISION_LOG.md
```

The next Design checkpoint update should follow installer compilation and installed-lifecycle evidence, not configuration alone.