# 11_OPERATIONAL_RECORD.md

> Version: Recovery record 0.1
> Status: Active observational history
> Persistence Class: Observational
> Knowledge Class: Operational
> Branch: `sketch-notebook-recovery`
> Scope: Chronological evidence of Operational-domain recovery and repopulation
> Truth boundary: This file records what occurred; present operational truth remains owned by `12_OPERATIONAL_MODEL.md`, current execution by `04_TODO.md`, and recovery state by `10_OPERATIONAL_STATE.md`.

---

# 1. Record Purpose

This file preserves the definite actions, corrections, and materialization sequence used to repopulate the Operational domain after its permanent files were intentionally emptied for the Sketch Notebook recovery test.

It exists so that later Main, Operational, Codex, or human review can answer:

```text
What was inspected?
What was staged?
What was promoted?
Which conflicts were discovered?
Which mistakes were corrected?
How did the current canon, derivative, and checkpoint emerge?
```

This record does not independently establish current implementation truth. Where chronology conflicts with a later canonical or checkpoint statement, the later authoritative surface governs present recovery.

---

# 2. Recovery Preconditions

## 2026-07-10 — Methodology bootstrap completed

The Operational Chat began on branch:

```text
sketch-notebook-recovery
```

The required methodology sequence was loaded from:

```text
documentation/sketch_notebook/INDEX.md
→ methodology/METHOD_FOUNDATIONS.md
→ methodology/FLUX.md
→ methodology/PROMOTION_RULES.md
→ methodology/CHAT_PROTOCOL.md
```

The Operational domain was then recovered through the Hierarchical Recovery Principle.

The following permanent Operational files were confirmed empty:

```text
operational/04_TODO.md
operational/10_OPERATIONAL_STATE.md
operational/11_OPERATIONAL_RECORD.md
operational/12_OPERATIONAL_MODEL.md
```

This established that repository inspection was required because no cheaper sufficient Operational memory existed.

No application source or permanent domain file was changed during bootstrap.

---

# 3. First Operational Structural Staging

## 2026-07-10 — Repository structural review staged

The first active Operational stage reviewed:

```text
app/core/
app/database/
app/desktop/
```

The review recovered the contemporary execution spine:

```text
main.py
→ app.main.main()
→ MainWindow
→ desktop pages
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

The inspection concentrated on:

- database execution;
- initialization and additive migration;
- resource bundling and writable-data paths;
- Repository connection lifetime;
- desktop shutdown ownership;
- mutation commit behavior;
- validation commands;
- structural facts suitable for later notebook promotion.

The first stage was materialized in:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
```

Commit:

```text
ce14d2549311f90144f95f0a54eafcbeb24bc126
```

The stage correctly remained non-canonical and separated observed facts, inferences, risks, and next validation work.

Important initial findings included:

- ProductService directly constructs Repository;
- Repository owns one SQLite connection and cursor;
- inspected pages construct ProductService directly;
- resource files and user-local SQLite state are separated;
- migration is additive and invoked during connection creation;
- Repository mutation methods commit individually;
- deterministic application-level shutdown ownership was not demonstrated by the initial inspection.

---

# 4. First Canonical Promotion Attempt and Reference Error

## 2026-07-10 — Initial canon created from an incorrect Main reference

The first Operational canonical reconstruction was written to:

```text
operational/12_OPERATIONAL_MODEL.md
```

Commit:

```text
433b54d96d6e3381ecd2fd59829fbf0a1fbf67c1
```

The initial promotion correctly attempted to extract stable operational rules rather than copy the entire A-stage report.

However, its reconciliation source was wrong.

The intended Main reference was:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

Instead, an earlier Main-branch `J_MAIN_STAGE.md` was consulted after the exact recovery-branch path was not initially resolved.

This produced a valid-looking but methodologically incorrect promotion route because:

- the comparator was not the human-designated recovery reference;
- it came from a different branch context;
- it did not contain the exact A/B/C recovery reconciliation prepared for this repopulation cycle.

The error was recognized before derivative and checkpoint reconstruction proceeded.

---

# 5. Canonical Reconciliation Corrected

## 2026-07-10 — Exact `[M]_STAGE/J_[M]_STAGE.md` loaded

The designated Main reconciliation file was then read from the recovery branch:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

It classified evidence as:

```text
CONFIRMED IMPLEMENTATION FACT
RECONCILED INTERPRETATION
OPERATIONAL VALIDATION REQUIRED
DESIGN DECISION REQUIRED
HISTORICAL CLASSIFICATION REQUIRED
```

The exact J reference resolved several A-stage uncertainties:

- all four principal pages construct ProductService;
- normal MainWindow construction creates four service/repository/connection chains;
- `ProductService.close()` exists and delegates to Repository closure;
- page-level cleanup attempts exist, while composition-level shutdown ownership remains implicit;
- receipt registration and purchase deletion/recalculation are confirmed multi-commit, non-atomic workflows;
- `seed.sql` contains baseline rows plus an example Rice product;
- production seed policy remains unresolved;
- contracts cover less than the complete concrete runtime surface.

## Canonical file fully replaced

`12_OPERATIONAL_MODEL.md` was refreshed completely from:

```text
DEV_STAGE/A_OPERATIONAL.md
+
[M]_STAGE/J_[M]_STAGE.md
```

Commit:

```text
572f7043d2d721e70e6638713054b64237984661
```

The corrected canon established stable Operational knowledge for:

- runtime and responsibility direction;
- supported entrypoints;
- desktop composition relevant to execution;
- resource versus writable-data ownership;
- SQLite connection configuration;
- initialization and migration;
- Repository and ProductService connection lifetime;
- distributed shutdown ownership as the current model;
- statement commits versus workflow transactions;
- destructive reset restrictions;
- validation status vocabulary;
- isolated validation conventions;
- packaging and installed-lifecycle evidence boundaries.

Unresolved future architecture choices were explicitly excluded from canon.

---

# 6. Derivative Reconstruction

## 2026-07-10 — `04_TODO.md` populated

The Operational derivative was reconstructed from the corrected canon:

```text
operational/04_TODO.md
```

Commit:

```text
792a6bf32efb658127161e1a628f42a0731879f8
```

The derivative was designed as a lower-cost recovery and supervision surface rather than a second canonical model.

It reorganized canon into:

- fast recovery card;
- runtime and persistence ownership summary;
- lifecycle and transaction summary;
- prioritized P0/P1/P2 work;
- validation ladder;
- command-ready checks;
- Main/human decision boundaries;
- retrieval map back to exact canonical sections.

The derivative established the drift rule:

```text
canon wins
→ identify derivative drift
→ refresh 04_TODO.md
```

Its principal active priorities were:

```text
P0  protect ordinary user data during validation
P1  validate deterministic shutdown
P1  map multi-commit failure states
P1  resolve production seed policy
P2  validate migration behavior
P2  validate packaged resource discovery
P2  validate installed data preservation
```

---

# 7. Main-Branch Retrospective for Checkpoint Recovery

## 2026-07-10 — Bounded Cycle 05 commit retrospective performed

To rebuild the checkpoint, a bounded retrospective was conducted against the main branch.

The reviewed historical window covered:

```text
Cycle 04 closure
→ post-Cycle 04 recovery preparation
→ Cycle 05 mobile-planning direction
→ `cycle 5.0 outburst mode`
→ Sprint 01 packaging checkpoint/TODO/evidence/model reconciliation
```

Representative main-branch commits included:

```text
c84e8506  Close Cycle 04 global project state
777a30b3  Record Cycle 04 session closure
bd4b4cd9  Prepare post-Cycle 04 recovery scheme
e9cf0f08  Stage Cycle 05 mobile preparation synthesis
a4f77326  Prepare Cycle 05 mobile development planning session
c51938b7  cycle 5.0 outburst mode
11a931f6  Reconcile Cycle 05 Sprint 01 operational checkpoint
bc4d3a5c  Reconcile Cycle 05 Sprint 01 operational TODO
d4a14485  Append Cycle 05 Sprint 01 operational evidence
fbeef65c  Add desktop packaging operational model
```

The retrospective separated:

```text
artifact outcome
from
methodology-cycle outcome
```

The recovered classification was:

```text
artifact outcome
    partial success

methodology-cycle outcome
    failed / incoherent closure
```

The precedent cycle reportedly produced a successfully built and launched one-folder frozen runtime, but did not complete installer compilation or installed lifecycle validation.

The cycle itself failed coherent closure because:

- direction changed from mobile preparation to Windows packaging during execution;
- oversized cross-domain staging weakened role and recovery boundaries;
- G/H/I Codex reports remained stale on Cycle 04 while Sprint 01 evidence was promoted;
- permanent memory was reconstructed post hoc from mixed and human-accepted evidence;
- the installer lifecycle remained blocked;
- prior human UI checks remained incomplete;
- the original mobile-preparation objective remained unfulfilled.

Main-branch packaging claims were therefore retained as historical continuity rather than treated as current recovery-branch validation.

---

# 8. Temporary Staging-File Constraint Violation

## 2026-07-10 — Extra Operational DEV_STAGE file created

During the retrospective step, a new temporary file was created:

```text
DEV_STAGE/A_OPERATIONAL_RETROSPECTIVE.md
```

Commit:

```text
17dfef6b169856ccaf715158538290c3aa0f02eb
```

The content itself matched the temporary historical purpose, but the physical file creation violated the established staging constraint:

```text
Operational Chat owns and refreshes DEV_STAGE/A_OPERATIONAL.md
Operational Chat does not create alternate A-stage filenames without authorization
```

The semantic purpose did not justify a new physical stage surface.

This is recorded as a methodology-routing violation, not as an implementation-content failure.

The reinforced constraint is:

```text
All future active Operational staging must refresh:
DEV_STAGE/A_OPERATIONAL.md

Do not create:
A_OPERATIONAL_TRACKRECORD.md
A_OPERATIONAL_RETROSPECTIVE.md
or other alternate Operational A-stage files
unless Main/human explicitly changes the methodology file map.
```

---

# 9. First Checkpoint Reconstruction

## 2026-07-10 — `10_OPERATIONAL_STATE.md` populated

The first checkpoint reconstruction was written to:

```text
operational/10_OPERATIONAL_STATE.md
```

Commit:

```text
74e18af3fbedbf7508c4e808568681d5539fed40
```

It synthesized:

- current recovery-branch application state from canon;
- active work from the derivative;
- precedent Cycle 05 failure continuity from the temporary retrospective;
- present validation classification;
- highest operational risks;
- next execution sequence;
- hierarchical recovery route.

The checkpoint explicitly prevented historical main-branch packaging evidence from being mistaken for current recovery-branch validation.

At that moment, `11_OPERATIONAL_RECORD.md` remained intentionally empty because canon, derivative, and checkpoint had only just been reconstructed.

---

# 10. Staging Topology Corrected

## 2026-07-10 — Retrospective moved into the designated A-stage

The content of the extra retrospective file was moved into:

```text
DEV_STAGE/A_OPERATIONAL.md
```

This intentionally refreshed and replaced the earlier structural-review stage because its stable findings had already been classified into canon, derivative, and checkpoint.

Commit:

```text
929fa945cb860f9e42e1b566812dd8bafcd38c82
```

The obsolete extra file was then deleted.

Commit:

```text
54d3052c71de8b042a51b0e31f9d8093ca35c886
```

No `A_OPERATIONAL_TRACKRECORD.md` file existed on the branch. The actual mismatched file was `A_OPERATIONAL_RETROSPECTIVE.md`, and it was treated as the semantic equivalent identified by the human correction.

The final staging topology returned to:

```text
DEV_STAGE/A_OPERATIONAL.md
    sole active Operational functional stage
```

---

# 11. Checkpoint Reference Corrected

## 2026-07-10 — Checkpoint refreshed after staging correction

The checkpoint initially referenced the now-deleted extra retrospective filename.

It was refreshed to use:

```text
Historical recovery source: DEV_STAGE/A_OPERATIONAL.md
```

The recovery route was also updated so that future Operational chats use:

```text
1. operational/10_OPERATIONAL_STATE.md
2. operational/04_TODO.md
3. operational/12_OPERATIONAL_MODEL.md when exact rationale is needed
4. DEV_STAGE/A_OPERATIONAL.md for active staged evidence
5. operational/11_OPERATIONAL_RECORD.md only for chronology
6. repository inspection only when memory is insufficient or drift is suspected
```

The checkpoint was also changed from “observational record empty” to “observational history opened.”

Commit:

```text
72b6f6f2a6ca8506d1a4435a3f7d9558fec8142d
```

---

# 12. Operational Domain Repopulation Result

The Operational domain now contains all four Domain Symmetry roles:

```text
Canonical
    operational/12_OPERATIONAL_MODEL.md

Derived
    operational/04_TODO.md

Checkpoint
    operational/10_OPERATIONAL_STATE.md

Observational
    operational/11_OPERATIONAL_RECORD.md
```

The active temporary surface is:

```text
DEV_STAGE/A_OPERATIONAL.md
```

Current semantic division:

- `12_OPERATIONAL_MODEL.md` defines stable operational truth and procedure;
- `04_TODO.md` reorganizes canon for rapid supervision and execution;
- `10_OPERATIONAL_STATE.md` provides current recovery state, risks, continuity, and next route;
- `11_OPERATIONAL_RECORD.md` preserves chronology and correction history;
- `DEV_STAGE/A_OPERATIONAL.md` remains ephemeral and refreshable for current Operational reasoning.

---

# 13. Recovery Lessons Recorded

The repopulation cycle established the following durable process lessons:

1. Exact designated reconciliation files must be resolved before promotion; a plausible same-named Main file on another branch is not an acceptable substitute.
2. Canon must be refreshed completely when its reconciliation basis is wrong.
3. Derived files must reorganize canon and cannot become independent truth surfaces.
4. Checkpoints may combine present canon, active derivative pressure, and historical continuity, but must label historical evidence separately from current validation.
5. Observational files should open only after durable recovery surfaces exist.
6. A temporary semantic need does not authorize a new physical DEV_STAGE filename.
7. Operational Chat must refresh `DEV_STAGE/A_OPERATIONAL.md` rather than create alternate A-stage files.
8. Historical artifact success and methodology-cycle success must be classified independently.
9. Main-branch evidence does not automatically validate the recovery branch.
10. Corrections to memory routing are themselves definite project events and belong in observational history.

---

# 14. Current Record Boundary

This first observational entry closes the Operational-domain repopulation history from:

```text
empty permanent Operational domain
→ repository structural staging
→ first promotion attempt
→ reconciliation-source correction
→ canonical reconstruction
→ derivative reconstruction
→ precedent-cycle retrospective
→ checkpoint reconstruction
→ staging-file topology correction
→ observational record opening
```

Future entries should record only definite Operational events such as:

- completed validation with reproducible evidence;
- accepted or materialized lifecycle changes;
- migration execution results;
- packaging and installed-lifecycle results;
- checkpoint refreshes;
- Main closure of the recovery cycle;
- later detected and corrected notebook drift.

Temporary hypotheses and intended work remain in `DEV_STAGE/A_OPERATIONAL.md` or `04_TODO.md`, not in this record until an actual event occurs.

---

# 15. Cycle 06 First Windows Release-Enablement Unit

## 2026-07-12 — D-stage materialization and Main reconciliation accepted

Main authorized the bounded `D_OPS_STAGE.md` unit. Codex changed:

```text
Modified
    Markei.spec
    scripts/build_windows.ps1
    main.py
    app/desktop/main_window.py

Created
    app/startup_diagnostics.py
    requirements-build.txt
    installer/Markei.iss
    scripts/build_installer.ps1
    tests/test_release_configuration.py
```

The materialization established `Markei.spec` as the authoritative one-folder packaging source, made the PowerShell build script invoke the spec, included only `schema.sql` as the production SQL resource, excluded the seed fixture and transient/live data, added a per-user installer definition and compile wrapper, added startup diagnostics, and added focused release-configuration tests.

Observed toolchain:

```text
Python 3.14.6
PySide6 6.11.1
PyInstaller 6.21.0
```

Observed commands and results:

```text
python -m compileall app main.py
    passed

python -m pytest
    blocked: pytest not installed

python -m unittest discover -s tests
    passed: 5 tests

.\scripts\build_windows.ps1
    passed

.\scripts\build_installer.ps1
    blocked: ISCC.exe not found
```

The successful frozen build produced:

```text
dist\Markei\Markei.exe
SHA256 E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B
```

Distribution inspection found `Markei.exe` and `_internal\app\database\schema.sql`. It did not find `seed.sql`, a live database, WAL/SHM files, or startup logs.

Isolated first launch created the external user database with zero category, store, product, and purchase rows plus expected structural/default settings. A second isolated frozen launch also succeeded.

Focused shutdown validation initially failed because the isolated SQLite file remained held open after `MainWindow.close()`. A bounded `MainWindow.closeEvent()` coordinator was then added. The rerun showed all four page-owned repositories open before close and closed afterward; the isolated database directory became removable. The frozen runtime was rebuilt, and immediate frozen reopen succeeded.

The focused shutdown issue is therefore resolved for the tested source/frozen context. Installed shutdown remains unvalidated.

Installer compilation produced no artifact because `ISCC.exe` was unavailable. Consequently clean installation, Start Menu launch, installed principal workflows, compatible upgrade/reinstall, uninstall retention, reinstall recovery, SmartScreen/antivirus observation, and final human acceptance remain blocked or pending.

Main reconciled the evidence as:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
installed: blocked
validated: partial
accepted: no
```

Main authorized permanent Operational reconciliation through `J_[M]_STAGE.md`. Workflow atomicity remained inherited debt and was not modified.
