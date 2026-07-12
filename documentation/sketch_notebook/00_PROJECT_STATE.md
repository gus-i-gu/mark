# 00_PROJECT_STATE.md

> Version: Cycle 06 closure / Cycle 07 entry 0.3
> Status: Active Global State Canon-Checkpoint
> Persistence Class: Canon-Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Reconciliation source: `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Concise accepted global state and low-cost recovery entrypoint

---

# 1. Global Milestone State

Cycle 06 is closed with the controlled Windows primary beta accepted by Main/human direction.

Cycle 06 milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Final evidence classification:

```text
configured: validated
built: validated
launched: validated — frozen and installed Start Menu launch
installed: validated — per-user installed lifecycle
validated: accepted for the controlled primary-beta boundary
accepted: yes — controlled beta, not production/public maturity
```

Acceptance is bounded. The technically validated lifecycle used the current ordinary Windows user with existing data backed up and restored. Human-visible SmartScreen behavior and a complete manual visual walkthrough were not separately captured; they remain release observations for future distribution rather than blockers to the accepted controlled beta.

---

# 2. Current Application and Architecture

Markei remains a local Python desktop application using PySide6 and SQLite.

```text
main.py
→ app.main.main()
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

Storage, Shortage, and Market remain modes inside Lists.

Responsibility direction:

| Layer | Responsibility |
| --- | --- |
| Desktop | Qt rendering, input, navigation, dialogs, refresh coordination, and final page-service shutdown coordination |
| `ProductService` | Workflows, validation, calculations, settings, stores, and UI-facing projections |
| `Repository` | SQL, row/model mapping, persistence operations, commits, and connection/cursor ownership |
| Database Manager | Resource and user-data paths, initialization, SQLite configuration, additive compatibility work, structural defaults, and reset primitives |
| SQLite | Persistent facts and declared relationships |

Packaging and installation remain deployment concerns around this application boundary. They do not own business workflows, SQL, or user-created state.

---

# 3. Accepted Windows Release Boundary

Production packaging and installation are materially defined:

```text
Markei.spec
    authoritative one-folder windowed PyInstaller definition
    includes schema.sql
    excludes seed.sql and live/transient user data
    UPX disabled
    Windows version resource attached

scripts/build_windows.ps1
    clean-build invocation wrapper

installer/Markei.iss
    per-user Windows x64 installer source
    stable AppId
    Start Menu shortcut
    optional desktop shortcut
    preserves external user data by default

scripts/build_installer.ps1
    Inno Setup compile wrapper
    discovers system and per-user ISCC.exe locations
```

Release identity:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Installer AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
```

Program files install under:

```text
%LOCALAPPDATA%/Programs/Markei
```

Retained writable user state remains under:

```text
%LOCALAPPDATA%/Markei
    market.sqlite
    transient WAL/SHM companions
    logs/startup.log
```

`schema.sql` is a bundled production resource. `seed.sql` remains a development/test fixture excluded from production.

Fresh production initialization creates only required idempotent structural defaults:

```text
category F / General
store 1 / Default Store
```

No sample products or purchases are created.

---

# 4. Accepted Cycle 06 Evidence

The recovery branch contains evidence for:

- source compilation and five standard-library release tests;
- clean one-folder frozen build;
- frozen launch and immediate reopen;
- compiled Inno Setup installer;
- per-user installation;
- installed Start Menu shortcut launch without a Python command or source checkout;
- external database initialization;
- structural defaults without sample products or purchases;
- installed technical Register persistence;
- Lists, History, and Settings projection evidence;
- installed close and immediate reopen;
- same-version reinstall with retained data;
- uninstall with retained `%LOCALAPPDATA%/Markei` state;
- reinstall and retained-data recovery.

Artifact evidence:

```text
Frozen executable
    SHA256 E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282

Installer
    dist/installer/Markei-Setup-0.1.0-x64.exe
    SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
    size 34,448,651 bytes
```

Two evidence-triggered corrections were accepted:

```text
per-user Inno Setup compiler not discovered
→ add per-user ISCC.exe discovery

fresh production Register foreign-key failure
→ add required structural category/store defaults
```

No broad architecture redesign was required.

---

# 5. Current Domain State

## Operational

The Operational domain records a compiled installer and technically validated installed lifecycle. Remaining items are release hygiene and future distribution observations, including artifact-channel policy, the non-blocking Inno architecture warning, signing/reputation considerations, and inherited workflow atomicity debt.

Checkpoint:

```text
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
```

## Didactic

The Didactic domain preserves the distinction among configuration, artifacts, execution contexts, validation, acceptance, and learner mastery. The four Cycle 06 release concepts remain Red because software success is not explicit learner validation.

Checkpoint:

```text
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

## Design

The Design domain records that the installed lifecycle preserved the accepted Desktop → ProductService → Repository → Database Manager → SQLite boundary, external writable state, stable installer identity, schema-only packaging, structural defaults, and MainWindow shutdown coordination.

Checkpoint:

```text
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

---

# 6. Residual Risks and Non-Blocking Debt

Cycle 06 closure does not erase:

- human-visible SmartScreen behavior for unsigned distribution;
- code signing and public reputation requirements;
- generated installer artifact/version-control policy;
- Inno Setup `x64` deprecation warning;
- true cross-version upgrade testing beyond same-version reinstall;
- workflow-level atomicity across multi-commit actions;
- broader migration strategy;
- optional uninstall data-deletion UX;
- future application/service decomposition questions.

These are not part of the accepted Cycle 06 controlled-beta milestone unless later evidence reclassifies them as blockers.

---

# 7. Cycle 07 Entry Direction

Cycle 07 is a preparation and architecture-discovery cycle for mobile development under an isolated cloned repository/worktree context.

It must not immediately rewrite the accepted desktop implementation.

Primary direction:

```text
preserve accepted Windows desktop baseline
→ create isolated mobile-preparation clone and branch
→ recover methodology and current domain state
→ inventory reusable platform-neutral logic
→ identify desktop-only dependencies
→ compare mobile delivery approaches
→ define persistence and synchronization assumptions
→ prototype the smallest vertical slice
→ reconcile evidence before selecting an implementation architecture
```

The active Cycle 07 boundaries and exit criteria are defined in:

```text
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

---

# 8. Global Recovery Route

Use the least expensive sufficient source:

```text
1. Read this file for accepted global state.
2. Read 06_SESSION_SCHEME.md for Cycle 07 preparation boundaries.
3. Read the relevant domain checkpoint.
4. Read derived or canonical domain memory only when exact detail is required.
5. Read 05_SESSION_LOG.md for chronology.
6. Read [M]_STAGE/J_[M]_STAGE.md for the Cycle 06 closure and Cycle 07 handoff.
7. Inspect source only when notebook memory is insufficient or implementation truth is directly required.
```

Domain checkpoints:

```text
Operational  operational/10_OPERATIONAL_STATE.md
Didactic     didactics/08_CONCEPT_MAP.md
Design       design/09_DESIGN_STATE.md
```
