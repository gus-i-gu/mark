# J_[M]_STAGE — Cycle 06 Sprint 02 Main Coordination Prompt

> Status: Active Main coordination prompt
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Required branch: `sketch-notebook-recovery`
> Knowledge state: Reconciled staging; not permanent domain canon
> Milestone: Fully executable and installable Windows primary beta
> Sprint: 02 — installer and installed-lifecycle completion

---

# 1. Main Authorization

Cycle 06 continues with the same single active milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Sprint 01 established a built and partially validated frozen runtime. Sprint 02 must finish the installer and installed lifecycle.

Current evidence state:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and immediate reopen
installed: blocked
validated: partial
accepted: no
```

This prompt authorizes Operational [O], Didactic [A], and Design [D] to perform compact Sprint 02 delta analysis and stage A/B/C for Main reconciliation.

It does not authorize source modification, permanent-memory updates, or Codex execution.

---

# 2. Mandatory Recovery Context

All domain chats must already have loaded the methodology. Before Sprint 02 work, refresh only:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

Then read the relevant domain checkpoint:

```text
Operational  operational/10_OPERATIONAL_STATE.md
Didactic     didactics/08_CONCEPT_MAP.md
Design       design/09_DESIGN_STATE.md
```

All GitHub reads and writes must explicitly use:

```text
sketch-notebook-recovery
```

Do not recover from the default branch.

---

# 3. Inherited Sprint 01 Facts

Do not re-investigate these facts unless drift is detected:

- `Markei.spec` is the authoritative one-folder windowed PyInstaller definition;
- `scripts/build_windows.ps1` invokes the spec;
- production includes `schema.sql` and excludes `seed.sql`;
- live database, WAL/SHM, logs, tests, and caches are excluded from the distribution;
- writable state is under `%LOCALAPPDATA%/Markei`;
- startup diagnostics write to `%LOCALAPPDATA%/Markei/logs/startup.log`;
- release identity is Markei / Markei.exe / 0.1.0 / publisher Markei / stable AppId;
- `installer/Markei.iss` defines per-user installation, Start Menu shortcut, optional desktop shortcut, and preserve-data behavior;
- frozen runtime built and launched against isolated user state;
- first launch contained no sample business rows;
- shutdown validation initially failed;
- a bounded `MainWindow.closeEvent()` correction closed all four page-owned services;
- focused source/frozen close and immediate reopen then passed;
- installer compilation failed only because `ISCC.exe` was unavailable in the Codex environment.

These facts are recorded in G/H/I and permanent domain memory.

---

# 4. Sprint 02 Target

The remaining path is:

```text
provide Inno Setup / ISCC.exe
→ compile installer
→ inspect installer artifact
→ clean per-user install
→ launch from Start Menu without Python/source checkout
→ exercise Register / Lists / History / Settings
→ close and immediately reopen
→ verify persisted user data
→ test compatible reinstall or upgrade
→ uninstall
→ verify retained %LOCALAPPDATA%/Markei data
→ reinstall and recover retained data
→ record SmartScreen / antivirus observations
→ obtain human acceptance
```

Sprint 02 must determine exactly what analysis, implementation correction, tooling, and human validation are required to complete this path.

---

# 5. Operational [O] Prompt

You observe Markei as execution.

## Objective

Prepare the exact operational route from the current configured installer source to a validated installed beta lifecycle.

## Required inspection

Read:

```text
installer/Markei.iss
scripts/build_installer.ps1
Markei.spec
scripts/build_windows.ps1
requirements-build.txt
tests/test_release_configuration.py
DEV_STAGE/G_OPS_CODEX.md
```

Inspect other files only when a specific installed-lifecycle dependency requires them.

## Required findings

Determine:

1. exact supported Inno Setup installation or discovery route;
2. exact `ISCC.exe` resolution behavior;
3. installer compile command and output path;
4. artifact inspection checks;
5. clean-profile preparation without risking ordinary user data;
6. clean install procedure;
7. Start Menu launch procedure;
8. installed workflow test sequence;
9. close and immediate reopen procedure;
10. persistence evidence capture;
11. same-version reinstall and compatible upgrade procedure;
12. uninstall and retained-data verification;
13. reinstall and recovery procedure;
14. SmartScreen and antivirus observation recording;
15. which steps Codex can execute and which require human interaction;
16. any narrow source or installer correction that may be required if a gate fails.

Do not pre-authorize speculative corrections.

## Stage output

Write only:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
```

Required compact structure:

```text
# A_OPERATIONAL — Cycle 06 Sprint 02

## Main Synthesis Summary
## Inherited Evidence
## Essential Evidence Index
## Installer Toolchain Route
## Installed Lifecycle Test Route
## Human Validation Boundary
## Failure Classification
## Potential Bounded Corrections
## Acceptance Gates
## Main Handoff
```

Target length: 1,500–2,000 words.

---

# 6. Didactic [A] Prompt

You observe Markei as learning.

## Objective

Prepare the Sprint 02 learning delta needed to understand installer compilation, installed execution, lifecycle evidence, and acceptance without duplicating the Sprint 01 concepts.

## Required inspection

Read:

```text
didactics/02_KANBAN.md
didactics/07_GLOSSARY.md
didactics/08_CONCEPT_MAP.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/G_OPS_CODEX.md
installer/Markei.iss
scripts/build_installer.ps1
```

## Required findings

Determine:

1. how Sprint 02 evidence will reinforce `&&&05`, `&&%04`, `&%%06`, and `%%%06`;
2. whether any genuinely new concept is required;
3. the distinction between installer configuration and compiled installer artifact;
4. the distinction between installed launch and frozen launch;
5. the distinction between configured retention and observed preservation;
6. the distinction between SmartScreen/reputation warnings and application correctness;
7. learner-check questions for installed lifecycle evidence;
8. maturity changes that could be considered after evidence, without automatic Green promotion.

Prefer reinforcement over new concept creation.

## Stage output

Write only:

```text
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
```

Required compact structure:

```text
# B_DIDACTIC — Cycle 06 Sprint 02

## Main Synthesis Summary
## Inherited Learning State
## Essential Evidence Index
## Existing Concepts to Reinforce
## New Candidate Need Assessment
## Installed-Lifecycle Distinctions
## Learner Validation Questions
## Maturity Constraints
## Main Handoff
```

Target length: 1,000–1,500 words.

No concept may become Green through this stage.

---

# 7. Design [D] Prompt

You observe Markei as architecture.

## Objective

Prepare the design interpretation required to validate the installed application boundary and classify any Sprint 02 failure without reopening broad architecture.

## Required inspection

Read:

```text
design/01_ARCHITECTURE.md
design/14_MODEL_OVERVIEW.md
design/09_DESIGN_STATE.md
DEV_STAGE/I_DSN_CODEX.md
DEV_STAGE/G_OPS_CODEX.md
installer/Markei.iss
scripts/build_installer.ps1
app/core/database.py
app/desktop/main_window.py
```

## Required findings

Determine:

1. the expected installed-program boundary;
2. the expected retained user-state boundary;
3. how same-version reinstall and compatible upgrade should behave;
4. how uninstall preservation should be evidenced;
5. how Start Menu and optional desktop shortcuts fit the accepted installer boundary;
6. how installed shutdown evidence relates to the bounded MainWindow correction;
7. how to classify failures as installer, packaging, runtime, workflow, retention, environmental, or human-acceptance problems;
8. which corrections could be beta-bounded and which remain future-cycle proposals.

Do not redesign service/repository composition or persistence architecture.

## Stage output

Write only:

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

Required compact structure:

```text
# C_DESIGN — Cycle 06 Sprint 02

## Main Synthesis Summary
## Inherited Accepted Boundary
## Essential Evidence Index
## Installed Application Boundary
## Reinstall / Upgrade / Uninstall Interpretation
## Failure Classification
## Potential Beta-Bounded Corrections
## Explicit Deferrals
## Acceptance Conditions
## Main Handoff
```

Target length: 1,200–1,800 words.

---

# 8. Cross-Domain Constraints

All three stages must:

- remain delta-focused;
- avoid repeating Sprint 01 analysis;
- distinguish fact, inference, configured behavior, and observed evidence;
- preserve the single Cycle 06 milestone;
- expose contradictions and decisions explicitly;
- avoid source modifications;
- avoid permanent-memory modifications;
- avoid D/E/F preparation;
- avoid broad repository inspection;
- avoid token burst.

Use evidence vocabulary exactly:

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

---

# 9. Main Reconciliation Route

After A/B/C are committed, Main will:

```text
1. read the three Main Synthesis Summaries;
2. identify agreements and contradictions;
3. inspect only disputed evidence;
4. decide the smallest Sprint 02 materialization unit;
5. replace J with the Sprint 02 reconciliation;
6. prepare bounded D/E/F delta stages;
7. issue the Codex prompt.
```

No functional stage independently authorizes implementation.

---

# 10. Expected Sprint 02 Materialization Boundary

The anticipated Codex unit is operationally centered:

```text
resolve installer compiler
→ compile installer
→ inspect artifact
→ automate safe checks where possible
→ support human installed-lifecycle validation
→ patch only failed beta gates
→ report G/H/I evidence
```

This is an expectation, not pre-approval of every change. A/B/C must determine the exact bounded unit.

---

# 11. Explicit Deferrals

Do not introduce:

- mobile;
- backend/API;
- synchronization;
- authentication;
- cloud persistence;
- broad ProductService or Repository decomposition;
- composition-root redesign;
- workflow transaction redesign unless ordinary beta testing proves a release blocker;
- schema redesign or migration ledger;
- unrelated UI redesign;
- one-file packaging;
- auto-update;
- signing;
- rollback framework;
- optional uninstall data-deletion UX.

---

# 12. Stage Completion Reports

Each domain completion response must contain only:

1. branch;
2. stage path;
3. word count;
4. evidence entry count;
5. blocking decision count;
6. one-paragraph conclusion;
7. commit SHA;
8. confirmation that no source or permanent-memory file was modified.

Stop after the report and wait for Main reconciliation.