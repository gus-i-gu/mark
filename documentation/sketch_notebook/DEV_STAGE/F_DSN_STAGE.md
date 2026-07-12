# F_DSN_STAGE — Cycle 06 Sprint 02 Final Desktop Validation

> Status: Main-approved Design materialization stage
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Inputs: `A_OPERATIONAL.md`, `B_DIDACTIC.md`, `C_DESIGN.md`
> Codex report target: `DEV_STAGE/I_DSN_CODEX.md`

## 1. Objective

Validate that the compiled installer and installed Windows lifecycle preserve the accepted Markei architecture and deployment boundaries.

Sprint 02 does not authorize a new architecture. It authorizes only evidence-triggered, beta-bounded corrections when a directly observed gate fails.

## 2. Accepted Architecture Preserved

The application boundary remains:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

Packaging and installation remain deployment concerns around this application. They do not own business workflows, SQL, migration semantics, or user-created state.

## 3. Boundaries That Must Remain Stable

Do not reopen without contradictory installed-lifecycle evidence:

- `main.py` is the launcher adapter and outer startup-diagnostic boundary;
- `app.main.main()` constructs the Qt application;
- `Markei.spec` owns one-folder frozen composition;
- `scripts/build_windows.ps1` invokes the spec;
- `installer/Markei.iss` owns placement, identity, shortcuts, and uninstall registration;
- `scripts/build_installer.ps1` owns compiler discovery and invocation;
- `schema.sql` is bundled read-only application content;
- `seed.sql` is excluded from production;
- `%LOCALAPPDATA%\Markei\market.sqlite` is retained writable user data;
- WAL/SHM are transient writable companions;
- startup logs are generated under `%LOCALAPPDATA%\Markei\logs`;
- identity is `Markei` / `Markei.exe` / `0.1.0` / publisher `Markei` / stable AppId;
- Start Menu shortcut is required;
- desktop shortcut is optional;
- `MainWindow.closeEvent()` coordinates final idempotent closure of four page-owned services.

## 4. Expected Installed Boundary

The installer may place only replaceable program content under the per-user program directory:

```text
Markei.exe
collected Python / PySide6 / Qt runtime files
schema.sql
approved static assets
version metadata
```

It must not install or treat as replaceable program content:

```text
market.sqlite
*.sqlite-wal
*.sqlite-shm
seed.sql
startup.log
tests
caches
source tree
```

The installed executable must launch without Python, a source checkout, repository working directory, or development environment.

Resource lookup must continue to find packaged `schema.sql`; writable-path lookup must continue to use `%LOCALAPPDATA%\Markei`.

## 5. Shortcut and Identity Boundary

Installed evidence must verify:

- per-user installation under `%LOCALAPPDATA%\Programs\Markei`;
- stable AppId retained across same-version reinstall and compatible upgrade;
- Start Menu shortcut launches the installed executable;
- optional desktop shortcut is created only when selected;
- application, executable, and installer identity remain synchronized.

A shortcut failure is primarily an installer registration defect, not an application-architecture failure.

## 6. Lifecycle Interpretation

### Clean installation

Expected:

```text
compiled installer
→ per-user program placement
→ registered uninstall entry
→ Start Menu shortcut
→ no user database shipped as program content
```

### Same-version reinstall

Expected:

```text
replace or repair program files
+ retain stable AppId
+ retain %LOCALAPPDATA%/Markei
+ reopen compatible existing database
```

### Compatible beta upgrade

When a compatible version transition is actually exercised:

```text
stable installer identity
→ replace program files
→ retain user state
→ reopen database
→ apply current additive compatibility behavior
```

Cycle 06 does not establish downgrade handling, rollback, incompatible-schema recovery, or a migration ledger.

### Uninstall

Accepted policy:

```text
remove installed program files and shortcuts
preserve %LOCALAPPDATA%/Markei by default
```

This becomes validated only through direct post-uninstall inspection.

### Reinstall after uninstall

Expected:

```text
reinstall compatible package
→ launch from Start Menu
→ reopen retained database
→ recover principal workflow state
```

## 7. Installed Shutdown Boundary

Sprint 01 proved source/frozen cleanup after adding bounded `MainWindow` coordination.

Sprint 02 must verify that installed normal closure reaches the same path and permits immediate reopen without retained database lock.

If installed shutdown fails:

1. prove whether `MainWindow.closeEvent()` executed;
2. identify which page service or repository remained open;
3. apply only the smallest correction within existing desktop shutdown coordination;
4. rerun installed close/reopen and dependent lifecycle gates.

Do not introduce a composition root, dependency injection, or shared-lifetime redesign.

## 8. Failure Classification

Use this primary classification before changing source:

| Failure | Design interpretation |
| --- | --- |
| `ISCC.exe` unavailable | Toolchain prerequisite; no architecture change. |
| Installer compile error | Correct only `.iss` or compile-wrapper boundary. |
| Missing runtime file after install | Determine packaging omission versus installer-copy defect. |
| Broken Start Menu shortcut | Installer registration defect. |
| Installed app cannot locate `schema.sql` | Packaging/resource-resolution defect. |
| Installed app writes under program files | Writable-state boundary defect. |
| Workflow fails only installed | Narrow installed dependency/path/workflow defect. |
| Database locked after installed close | Existing lifecycle coordination defect. |
| Data removed by uninstall | Retention-policy defect. |
| SmartScreen warning without runtime failure | Reputation/security observation. |
| Human rejects usability | Human-acceptance failure with exact reason. |

## 9. Evidence-Triggered Correction Authority

Only after direct failure evidence may Codex correct:

- compiler discovery/invocation;
- installer file inclusion, destination, architecture, identity, shortcut, or uninstall registration;
- PyInstaller collection of a missing installed dependency/resource;
- launcher diagnostics for an installed-only startup failure;
- existing resource or writable-path resolution;
- current MainWindow shutdown coordination;
- a narrowly reproduced beta-blocking workflow;
- focused validation tooling or logs.

No speculative correction is authorized.

## 10. Acceptance Chain

The installed boundary is evidenced only when this chain passes:

```text
compiled installer artifact with expected identity
→ clean per-user installation
→ correct installed file boundary
→ Start Menu launch without Python/source checkout
→ Register / Lists / History / Settings pass
→ close and immediate reopen pass
→ persisted data remains correct
→ same-version reinstall or compatible upgrade preserves data
→ uninstall removes program files and preserves user state
→ reinstall recovers retained compatible data
→ SmartScreen/antivirus observations recorded
→ Main/human acceptance
```

Installer compilation alone does not establish `installed`, `validated`, or `accepted`.

## 11. Explicit Deferrals

Do not introduce:

- composition-root redesign or dependency injection;
- service/repository lifetime redesign or decomposition;
- transaction redesign unless a demonstrated blocker is separately reconciled;
- schema redesign or migration ledger;
- mobile, backend/API, synchronization, authentication, or cloud persistence;
- one-file packaging;
- auto-update, signing, rollback framework;
- optional uninstall data-deletion UX;
- broad UI/navigation redesign.

Workflow atomicity remains inherited debt unless ordinary installed testing demonstrates a concrete release blocker.

## 12. I Report Contract

Replace `DEV_STAGE/I_DSN_CODEX.md` with a concise Sprint 02 report containing:

1. whether the accepted deployment boundary was preserved;
2. compiled installer identity and placement evidence;
3. installed program-file versus user-state evidence;
4. Start Menu and optional desktop-shortcut results;
5. installed resource and writable-path behavior;
6. installed shutdown/reopen result;
7. same-version reinstall or compatible upgrade result;
8. uninstall-retention result;
9. reinstall-recovery result;
10. every failed gate, primary classification, bounded correction, and rerun;
11. SmartScreen/antivirus classification;
12. remaining unvalidated design boundaries;
13. explicit deferrals preserved;
14. confirmation that permanent Design files were not modified.

Use evidence-appropriate states only. Codex must not declare final beta acceptance.