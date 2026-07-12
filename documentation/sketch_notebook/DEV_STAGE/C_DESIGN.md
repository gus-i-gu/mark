# C_DESIGN — Cycle 06 Sprint 02

> Status: Active functional Design stage  
> Knowledge state: Staged / non-canonical  
> Authority: Design Chat [D]  
> Repository: `gus-i-gu/markei`  
> Branch: `sketch-notebook-recovery`  
> Main coordination: `documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`

## Main Synthesis Summary

Sprint 02 does not need a new application architecture. The accepted boundary remains a local layered desktop monolith surrounded by packaging and installation concerns:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

Sprint 01 already materialized the package, installer-source, resource, identity, diagnostics, and shutdown boundaries. The remaining Design task is to verify that the compiled installer and installed runtime preserve those boundaries in an ordinary per-user Windows lifecycle.

Expected installed form:

```text
replaceable installed program files
+
registered Start Menu shortcut
+
optional desktop shortcut

separate from

%LOCALAPPDATA%/Markei
    market.sqlite
    WAL/SHM companions
    logs
```

No unresolved Design policy blocks installer compilation. Existing decisions already define schema-only production initialization, stable release identity, per-user placement, default user-data preservation, Start Menu launch, optional desktop shortcut, launcher-owned startup diagnostics, and MainWindow-owned final service-close coordination.

The first Sprint 02 materialization boundary should therefore be operationally centered: provide Inno Setup, compile and inspect the installer, exercise the installed lifecycle, and patch only a directly failed gate. A valid bounded correction may change installer configuration, package collection, launcher diagnostics, installed-path handling, or existing desktop shutdown coordination. It must not introduce service/repository decomposition, dependency injection, transaction redesign, schema redesign, or a general migration system.

Cycle 06 remains incomplete until installed launch, principal workflows, close/reopen, compatible reinstall or upgrade, uninstall preservation, reinstall recovery, and human acceptance are evidenced.

## Inherited Accepted Boundary

The following are accepted and should not be reopened without contradictory Sprint 02 evidence:

- `Markei.spec` owns one-folder frozen composition.
- `scripts/build_windows.ps1` invokes that authority.
- `installer/Markei.iss` owns placement, release identity, shortcuts, and uninstall registration.
- `scripts/build_installer.ps1` owns compiler discovery and installer compilation invocation.
- `schema.sql` is bundled read-only application content.
- `seed.sql` is excluded from production.
- `market.sqlite` and settings are retained writable user data.
- WAL/SHM are transient writable companions.
- startup logs are generated under `%LOCALAPPDATA%/Markei/logs`.
- release identity is `Markei` / `Markei.exe` / `0.1.0` / publisher `Markei` / stable AppId.
- Start Menu shortcut is required; desktop shortcut is optional.
- MainWindow coordinates final idempotent closure of four page-owned services.

Current evidence remains:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

## Essential Evidence Index

| ID | File or evidence | Design relevance |
| -- | ---------------- | ---------------- |
| E1 | `00_PROJECT_STATE.md` | Defines the current milestone, inherited boundaries, and remaining lifecycle route. |
| E2 | `design/01_ARCHITECTURE.md` | Canonical source for deployment, identity, retention, and shutdown boundaries. |
| E3 | `design/09_DESIGN_STATE.md` | Confirms installer compilation and installed lifecycle remain blocked. |
| E4 | `installer/Markei.iss` | Configures per-user placement, identity, shortcuts, and frozen-distribution consumption. |
| E5 | `scripts/build_installer.ps1` | Resolves `ISCC.exe`, requires `dist/Markei`, and defines the expected installer artifact. |
| E6 | `app/core/database.py` | Separates bundled resources from `%LOCALAPPDATA%/Markei` writable state. |
| E7 | `app/desktop/main_window.py` | Implements bounded final closure of page-owned services. |
| E8 | `DEV_STAGE/G_OPS_CODEX.md` and `I_DSN_CODEX.md` | Record frozen validation, shutdown correction, and the installer blocker. |

## Installed Application Boundary

The installer should place only replaceable program content under its per-user application directory:

```text
Markei.exe
collected Python / PySide6 / Qt runtime files
schema.sql
approved static assets
version metadata
```

It must not install or generate the live database, WAL/SHM, seed fixture, startup log, tests, caches, or source tree as program content.

The installed executable must launch without a Python command, source checkout, repository working directory, or development environment. Resource lookup must continue to resolve packaged `schema.sql`; writable-path lookup must continue to target `%LOCALAPPDATA%/Markei`.

Shortcut ownership remains installation UX:

```text
Start Menu shortcut
    required installed launch path

Desktop shortcut
    optional user-selected installer task
```

A shortcut failure is an installer configuration or registration defect. It is not evidence that the application architecture or persistence boundary is wrong.

## Reinstall / Upgrade / Uninstall Interpretation

### Same-version reinstall

Expected behavior:

```text
replace installed program files
retain stable AppId
retain %LOCALAPPDATA%/Markei
reopen compatible existing database
```

A reinstall must not overwrite the live database with a packaged database or rerun sample seed data.

### Compatible beta upgrade

Expected behavior:

```text
stable installer identity
→ replace program files
→ retain user state
→ open existing database
→ apply current additive compatibility behavior
```

Cycle 06 does not establish downgrade handling, incompatible-schema recovery, rollback, or a numbered migration ledger.

### Uninstall

Accepted policy:

```text
remove installed program files and shortcuts
preserve %LOCALAPPDATA%/Markei by default
```

Preservation is evidenced only when uninstall completes and the external database remains present and readable. External placement and absence of installer delete directives support the policy but do not validate it.

### Reinstall after uninstall

The reinstalled application should reopen retained compatible data and preserve principal workflow continuity. A failure here may indicate installer identity drift, unexpected user-data deletion, resource/path drift, or runtime compatibility failure.

## Failure Classification

| Failure | Primary classification | Design interpretation |
| --- | --- | --- |
| `ISCC.exe` unavailable | toolchain prerequisite / environmental | No architecture change; supply the compiler or its path. |
| Installer compile error | installer configuration defect | Correct only the failing `.iss` or compile wrapper boundary. |
| Missing runtime file after install | packaging or installer-content defect | Determine whether the spec omitted it or installer failed to copy it. |
| Start Menu shortcut absent/broken | installer registration defect | Correct installer shortcut configuration. |
| Installed app cannot locate `schema.sql` | packaging/resource-resolution defect | Bounded fix in package collection or existing resource-path logic. |
| Installed app writes under program files | installed runtime boundary defect | Correct writable-path resolution; do not move user state into installer ownership. |
| Register/Lists/History/Settings fail only installed | installed runtime or workflow defect | Patch the narrow failed dependency/path/workflow gate. |
| Database remains locked after installed close | lifecycle defect | Verify the existing MainWindow close path executes; extend only that bounded coordination if evidence requires it. |
| Data disappears after uninstall | retention defect | Correct installer deletion behavior or path assumptions; preserve accepted policy. |
| SmartScreen warning without runtime failure | Windows reputation/security observation | Record separately; not proof of application incorrectness. |
| Human rejects workflow or UX | human-acceptance failure | Record exact reason; do not relabel as technical validation success. |

## Potential Beta-Bounded Corrections

Permitted only after a gate fails with direct evidence:

1. correct `ISCC.exe` discovery or invocation in the compile wrapper;
2. correct installer file inclusion, destination, architecture, identity, shortcut, or uninstall directives;
3. correct `Markei.spec` collection when an installed runtime dependency/resource is missing;
4. correct launcher diagnostics when installed startup failure is not inspectable;
5. correct existing resource or writable-path resolution if source/frozen behavior differs from installed behavior;
6. correct the current MainWindow close coordinator if installed shutdown bypasses or incompletely executes it;
7. add focused validation assets or logging needed to identify the failed beta gate.

No speculative correction is authorized before failure evidence.

## Explicit Deferrals

Deferred outside Sprint 02: composition-root redesign, dependency injection, shared service/repository lifetime redesign, ProductService or Repository decomposition, workflow transaction redesign, schema redesign, migration ledger, mobile, backend/API, synchronization, authentication, cloud persistence, unrelated UI redesign, one-file packaging, auto-update, signing, rollback framework, and optional uninstall data-deletion UX.

Workflow atomicity remains inherited debt unless ordinary installed beta testing demonstrates a concrete release blocker requiring separate Main reconciliation.

## Acceptance Conditions

Design considers the installed boundary evidenced only when the following chain passes:

```text
compiled installer artifact with expected identity
→ clean per-user installation
→ expected installed file boundary
→ Start Menu launch without Python/source checkout
→ Register / Lists / History / Settings pass
→ close and immediate reopen pass
→ persisted data remains correct
→ same-version reinstall or compatible upgrade preserves data
→ uninstall removes program files and preserves user state
→ reinstall recovers retained compatible data
→ security/reputation observations recorded
→ Main/human acceptance
```

Installer compilation alone changes `blocked` to `built` for the installer artifact; it does not establish `installed`, `validated`, or `accepted`.

## Main Handoff

Design finds no new blocking policy decision before Sprint 02 materialization. Main should authorize an operationally centered D/E/F unit that supplies the installer compiler, compiles and inspects the artifact, supports safe installed-lifecycle validation, and permits only evidence-triggered beta-bounded corrections.

The reconciliation should preserve the accepted program/user-state split, stable identity, default retention policy, shortcut policy, launcher diagnostic boundary, and existing MainWindow shutdown coordination. Any failed gate should be classified using the table above before implementation scope is expanded.