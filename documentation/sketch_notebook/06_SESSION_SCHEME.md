# 06_SESSION_SCHEME.md

> Version: Cycle 06 Sprint 02 forward checkpoint 0.2
> Status: Active Forward Checkpoint
> Persistence Class: Forward Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Required branch: `sketch-notebook-recovery`
> Current-state source: `00_PROJECT_STATE.md`
> Historical source: `05_SESSION_LOG.md`
> Domain checkpoints: `operational/10_OPERATIONAL_STATE.md`, `didactics/08_CONCEPT_MAP.md`, `design/09_DESIGN_STATE.md`
> Active Main stage: `[M]_STAGE/J_[M]_STAGE.md`
> Cycle target: fully executable and installable Windows primary beta of Markei

---

# 1. Purpose

This file prepares Cycle 06 Sprint 02.

Sprint 02 continues the same single Cycle 06 milestone. It does not introduce a new milestone, feature program, or architecture cycle.

It defines:

- inherited Sprint 01 evidence;
- the remaining installed-lifecycle gates;
- bounded domain responsibilities;
- the Codex materialization boundary;
- human validation requirements;
- closure and recovery rules.

It does not itself authorize source modification. Implementation authority must flow through Main reconciliation and D/E/F staging.

---

# 2. Single Active Milestone

Cycle 06 has one active milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Expected delivery:

```text
Windows installer
→ ordinary per-user installation
→ Start Menu launchable Markei.exe
→ no Python command or source checkout required
→ writable user data outside installed program files
→ Register / Lists / History / Settings workflows
→ clean close and immediate reopen
→ retained data through compatible lifecycle tests
→ uninstall according to accepted preservation policy
→ reinstall and recover retained data
→ human acceptance
```

Cycle 06 does not close from source execution, a successful PyInstaller build, a frozen executable launch, installer source, or installer compilation alone.

---

# 3. Inherited Sprint 01 State

Accepted evidence:

```text
configured: yes
built: yes
launched: yes — isolated frozen launch and immediate reopen
installed: blocked
validated: partial
accepted: no
```

Sprint 01 completed:

- authoritative `Markei.spec` one-folder packaging;
- `scripts/build_windows.ps1` invocation wrapper;
- schema-only production package;
- exclusion of sample seed and live/transient data;
- coordinated `Markei` / `Markei.exe` / `0.1.0` identity;
- startup diagnostics under `%LOCALAPPDATA%/Markei/logs`;
- per-user Inno Setup source;
- Start Menu shortcut and optional desktop shortcut configuration;
- preserve-data uninstall configuration;
- standard-library release tests;
- frozen build and isolated launch/reopen;
- evidence-triggered `MainWindow.closeEvent()` shutdown correction.

Sprint 01 blocker:

```text
ISCC.exe unavailable
→ installer not compiled
→ installed lifecycle not exercised
```

---

# 4. Sprint 02 Bounded Objective

Sprint 02 must complete the remaining release gates:

```text
1. provide and resolve Inno Setup / ISCC.exe
2. compile installer
3. inspect installer artifact and identity
4. perform clean per-user installation
5. launch from Start Menu without Python/source checkout
6. exercise principal desktop workflows
7. close and immediately reopen
8. verify persisted data
9. test compatible reinstall or upgrade
10. uninstall
11. verify %LOCALAPPDATA%/Markei preservation
12. reinstall and recover retained data
13. record SmartScreen and antivirus observations
14. obtain human acceptance or record exact blockers
```

Only changes directly required by failed Sprint 02 gates are in scope.

---

# 5. Required Inspection Route

Use fractioned recovery and inspection.

## Pass 1 — Current state

Read:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
[M]_STAGE/J_[M]_STAGE.md
```

## Pass 2 — Installer and release surfaces

Inspect only:

```text
Markei.spec
scripts/build_windows.ps1
requirements-build.txt
installer/Markei.iss
scripts/build_installer.ps1
build/markei_version_info.txt
```

## Pass 3 — Installed runtime boundaries

Inspect only when needed:

```text
main.py
app/main.py
app/startup_diagnostics.py
app/core/config.py
app/core/database.py
app/desktop/main_window.py
```

## Pass 4 — Validation assets

Inspect:

```text
tests/test_release_configuration.py
DEV_STAGE/G_OPS_CODEX.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/I_DSN_CODEX.md
```

Do not begin with a repository-wide audit.

---

# 6. Domain Responsibilities

## Operational [O]

Own:

- exact Inno Setup prerequisite and compiler discovery;
- installer build command;
- artifact inspection;
- clean-install procedure;
- installed workflow test route;
- reopen, upgrade/reinstall, uninstall, retention, and recovery evidence;
- SmartScreen/antivirus observation;
- exact evidence status and blockers.

Output:

```text
DEV_STAGE/A_OPERATIONAL.md
```

The Sprint 02 A stage must be compact and delta-focused. It must not repeat Sprint 01 packaging analysis.

## Didactic [A]

Own:

- installed-execution learning delta;
- installer artifact versus installed state;
- retention configuration versus observed preservation;
- Windows reputation warning versus application correctness;
- maturity implications for the four Cycle 06 Red concepts.

Output:

```text
DEV_STAGE/B_DIDACTIC.md
```

No automatic Green promotion is permitted.

## Design [D]

Own:

- installed application boundary;
- installer placement and identity verification;
- compatible reinstall/upgrade interpretation;
- uninstall preservation evidence;
- classification of any failed lifecycle gate as configuration, implementation, policy, or environmental defect.

Output:

```text
DEV_STAGE/C_DESIGN.md
```

No broad architecture redesign is authorized.

---

# 7. Token and Staging Control

A/B/C are Main reconciliation inputs, not exhaustive reports.

Each stage must contain:

```text
Main Synthesis Summary
Essential Evidence Index
Sprint 02 Findings
Blocking Decisions
Required Corrections
Acceptance Gates
Main Handoff
```

Target length:

```text
A  1,500–2,000 words
B  1,000–1,500 words
C  1,200–1,800 words
```

Do not copy source, logs, or Sprint 01 reports verbatim.

Main will read summaries first and expand only disputed claims.

---

# 8. D/E/F and Codex Route

After A/B/C:

```text
Main reconciliation in J
→ bounded D/E/F delta stages
→ Codex materialization and validation
→ G/H/I evidence
→ Main primary reconciliation
→ permanent domain updates
→ Main-root closure
```

Codex must load:

```text
AGENTS.md
→ documentation/sketch_notebook/INDEX.md
→ complete methodology boot sequence
→ 00_PROJECT_STATE.md
→ 06_SESSION_SCHEME.md
→ J_[M]_STAGE.md
→ D/E/F
```

Codex must not reinterpret policy or expand scope.

---

# 9. Human Validation Boundary

Sprint 02 requires human-observable Windows evidence for:

- installer wizard and destination;
- installed file placement;
- Start Menu shortcut;
- optional desktop shortcut behavior if selected;
- application launch without development tooling;
- Register, Lists, History, and Settings usability;
- close and immediate reopen;
- retained data after reopen;
- compatible reinstall or upgrade;
- uninstall behavior;
- retained `%LOCALAPPDATA%/Markei` data;
- reinstall recovery;
- SmartScreen and antivirus behavior.

Automated tests may support these claims but cannot replace all human installed-lifecycle evidence.

---

# 10. Failure Classification

Every failure must be classified as one of:

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

Only the smallest correction needed to pass the failed gate may be staged.

---

# 11. Explicit Deferrals

Outside Sprint 02 and Cycle 06 unless directly beta-blocking:

- mobile;
- backend/API;
- synchronization;
- authentication;
- cloud persistence;
- broad ProductService or Repository decomposition;
- composition-root redesign;
- transaction redesign;
- general schema redesign or migration ledger;
- unrelated UI redesign;
- auto-update;
- signing;
- rollback infrastructure;
- one-file packaging;
- optional uninstall data-deletion UX.

Workflow atomicity remains inherited debt unless ordinary beta validation demonstrates a release-blocking failure.

---

# 12. Sprint 02 Exit Criteria

Sprint 02 succeeds only when evidence supports:

```text
configured: yes
built: yes
launched: yes
installed: yes
validated: yes for the accepted beta lifecycle
accepted: yes by Main/human review
```

Minimum evidence:

- compiled installer artifact and identity;
- clean installation;
- installed launch;
- principal workflow pass;
- close/reopen and persistence pass;
- compatible reinstall or upgrade pass;
- uninstall retention pass;
- reinstall recovery pass;
- recorded Windows security/reputation observations;
- matching G/H/I reports;
- domain reconciliation;
- Main-root closure.

If any gate remains blocked, Cycle 06 remains open and the exact blocker must be recorded without status inflation.

---

# 13. Recovery Warning

The core distinction remains:

```text
installer source
≠ compiled installer
≠ installed application
≠ validated installed lifecycle
≠ accepted beta
```

Sprint 02 exists to cross those remaining boundaries with evidence.