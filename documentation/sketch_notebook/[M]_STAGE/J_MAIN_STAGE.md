# J_MAIN_STAGE.md

> Status: Main staging draft
> Scope: Cycle 03 closure, Main-root file preparation, and methodology-lab handoff
> Authority: Main Chat under human-supervised methodological revision
> Persistence class: Stage / provisional synthesis

---

# 1. Purpose

This file stages Main-level conclusions and methodology-lab notes before patching the Main-root continuity files:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
```

It also stages proposed content for the temporary communication file:

```text
PROVISORY_[M]_DOUBLE_LAB.md
```

The provisional file is not created by this stage. Its creation remains subject to explicit Main/human authorization because new Sketch Notebook files require routing registration.

---

# 2. Current Structural Observation

Cycle 03 successfully tested the full Sketch Notebook loop:

```text
A/B/C functional staging
↓
D/E/F Main materialization staging
↓
Codex implementation
↓
G/H/I Codex evidence
↓
O/A/D domain memory absorption
↓
Main reconciliation
```

The implementation result was strong:

- public inventory navigation became one `Lists` tab;
- former Storage / Shortage / Market meanings became Lists internal views;
- History analytics was embedded in HistoryPage;
- ProductService owns Lists and History analytics read models;
- no schema changes were introduced;
- no mobile rewrite occurred;
- mobile readiness improved through service/read-model boundaries.

The methodology result was also strong, but exposed a verbosity and recovery-cost problem.

Cycle 03 produced rich domain memory, especially in canonical and observational files. This is useful for preservation, but risky for recovery if every future chat rereads full large files.

---

# 3. Main Assessment Of Over-Verbosity

## 3.1 What worked

Verbose capture worked well for ever-growing records and detailed canonical registers.

Useful examples:

- `operational/11_OPERATIONAL_RECORD.md` preserves execution evidence.
- `didactics/13_LECTURE_REGISTER.md` preserves learning events.
- `design/03_DECISION_LOG.md` preserves decision history.
- `didactics/02_KANBAN.md` now provides a rich canonical concept register.

## 3.2 What disappointed

Verbose capture is weaker in files whose semantic purpose is compression or rearrangement.

Risky targets:

- checkpoints, because they should be compact recovery surfaces;
- derived files, because they should reorganize truth rather than duplicate all truth;
- global state files, because they must support fast next-session recovery.

## 3.3 Proposed principle

The method should not merely ask whether content is correct.

It should also ask whether the file still performs its semantic role at its current length.

---

# 4. Proposed File Growth Vocabulary

## 4.1 Ever-growing files

Ever-growing files preserve sequence and evidence.

They are usually append-oriented.

Examples:

```text
05_SESSION_LOG.md
operational/11_OPERATIONAL_RECORD.md
didactics/13_LECTURE_REGISTER.md
design/03_DECISION_LOG.md
```

Rule candidate:

```text
Ever-growing files should not be fully reread by default after they exceed the sprint read limit.
```

Recommended recovery method after threshold:

1. read file header;
2. read latest entry or latest bounded line window;
3. search by date / cycle / heading when older context is needed;
4. read older sections only by targeted consultation.

## 4.2 Refreshable files

Refreshable files are rewritten or compactly updated from other knowledge layers.

Examples:

```text
00_PROJECT_STATE.md
06_SESSION_SCHEME.md
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

Rule candidate:

```text
Refreshable files should remain compact and optimized for recovery.
```

## 4.3 Derived / resorted files

Derived files reorganize canonical truth.

Examples:

```text
operational/04_TODO.md
didactics/07_GLOSSARY.md
design/14_MODEL_OVERVIEW.md
```

Rule candidate:

```text
Derived files must not become duplicate canon. If they grow too much, they should be resorted, compacted, or indexed.
```

## 4.4 Canonical files

Canonical files own accepted domain truth.

Examples:

```text
operational/12_OPERATIONAL_MODEL.md
didactics/02_KANBAN.md
design/01_ARCHITECTURE.md
methodology/*.md
```

Rule candidate:

```text
Canonical files may grow, but full-file reread should be replaced by checkpoint-first recovery and targeted heading/concept lookup once they cross the sprint read limit.
```

## 4.5 Checkpoints

Checkpoints are compact recovery surfaces.

Examples:

```text
00_PROJECT_STATE.md
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

Rule candidate:

```text
A checkpoint fails its role if it becomes a long register or historical record.
```

---

# 5. Proposed Length Constraint

Introduce a methodology variable:

```text
SPRINT_READ_LIMIT = 800 lines
```

Optional stronger marker:

```text
REPARTITION_REVIEW_LIMIT = 1300 lines
```

## 5.1 At 800 lines

When a file reaches 800 lines:

- assign or confirm its file-growth class;
- define a read-window policy;
- update prompts so agents do not reread the entire file by default;
- prefer checkpoint-first recovery and targeted search.

## 5.2 At 1300 lines

When a file reaches 1300 lines:

- perform a repartition review;
- consider section indexing, compaction, re-sorting, or a Main-approved structural change;
- avoid arbitrary file creation;
- preserve historical evidence if compaction changes current truth.

## 5.3 Checkpoint exception

Checkpoints should normally be much smaller than 800 lines.

Proposed checkpoint guidance:

```text
Target: under 200–300 lines.
Review: approaching 400 lines.
Failure: 800 lines.
```

---

# 6. Reconciliation Protocol Candidate

Cycle 03 exposed the need to distinguish two forms of reconciliation.

## 6.1 Vertical reconciliation

Vertical reconciliation checks whether knowledge remains coherent across semantic layers through time.

It asks:

```text
Does the checkpoint reflect canonical state?
Does derived knowledge reflect canon?
Does observational history explain how the current state emerged?
Does repository implementation agree with notebook memory?
Does project state reflect validated domain state?
```

Typical vertical chain:

```text
Codex reports
↓
observational domain records
↓
canonical / derived updates
↓
domain checkpoints
↓
00_PROJECT_STATE.md
↓
05_SESSION_LOG.md
```

## 6.2 Horizontal reconciliation

Horizontal reconciliation checks whether domains remain complementary rather than contradictory.

It asks:

```text
Does Operational state contradict Design boundaries?
Does Didactic framing distort implementation reality?
Does Design duplicate Operational execution rules?
Does one domain claim ownership that belongs to another?
Are shared concepts named consistently across domains?
```

Cycle 03 example:

```text
Operational: Lists is implemented and public tabs changed.
Design: ListsPage is the public inventory surface.
Didactics: Lists is a unified UI surface over one service read model.
```

These claims are complementary.

Minor terminology refinement:

```text
all = default Lists view key / hybrid all-products presentation
in-house / shortage / to-buy = semantic internal views
in-house + shortage / shortage + to-buy = composite filter views
```

---

# 7. Special Class: 00_PROJECT_STATE.md

`00_PROJECT_STATE.md` creates an ambiguity that should become explicit methodology.

It is both:

1. a global checkpoint for fast recovery;
2. a Main-owned current-state canon for the whole project.

This makes it a special class within the Domain Symmetry model.

Proposed term:

```text
Global State Canon-Checkpoint
```

## 7.1 Proposed meaning

`00_PROJECT_STATE.md` should define the accepted current state of the project at Main level, while remaining concise enough to support fast boot.

It is more authoritative than ordinary checkpoints because it is Main-owned global current state.

It is less detailed than full canonical domain files because it must not duplicate all domain truth.

## 7.2 Proposed constraints

`00_PROJECT_STATE.md` should:

- state the current project milestone;
- state current implementation state;
- state current notebook/methodology state;
- summarize accepted cross-domain reconciliation;
- identify active risks and next recovery files;
- avoid long historical detail;
- point to domain checkpoints for depth;
- point to `05_SESSION_LOG.md` for session history;
- point to `06_SESSION_SCHEME.md` for next-session agenda.

## 7.3 Proposed methodology placement

This special class should be defined in methodology where promotion levels and knowledge states are described.

Candidate owner:

```text
PROMOTION_RULES.md
```

Supporting routing owner:

```text
FLUX.md
```

Navigation registration owner:

```text
INDEX.md
```

---

# 8. Main Root File Drafts

This section stages sample content for three Main-root files.

They are not yet patched by this stage.

---

## 8.1 Draft for 00_PROJECT_STATE.md

```markdown
# 00_PROJECT_STATE.md

> Status: Active global state
> Authority: Main Chat
> Persistence class: Global State Canon-Checkpoint
> Scope: Fast recovery of current Markei + Sketch Notebook state

---

# Current Milestone

Markei has completed Cycle 03 — Read-Model Consolidation.

Cycle 03 materialized:

- unified `Lists` page;
- embedded History analytics;
- global latest / delta price display in Lists;
- service-owned read models for Lists and History analytics;
- mobile-readiness preparation through boundaries, not rewrite.

# Current Application State

Public desktop tabs are now:

```text
Register
Lists
History
Settings
```

Former public Storage / Shortage / Market meanings are now Lists internal views:

```text
Storage  -> in-house
Shortage -> shortage
Market   -> to-buy
```

Lists supports:

```text
all
in-house
shortage
to-buy
in-house + shortage
shortage + to-buy
```

History remains grouped by service-owned Month -> Week logic and now includes embedded read-only analytics.

Register remains purchase-entry-only.

Settings remains the store-management surface.

No Cycle 03 schema changes were introduced.

# Current Architecture State

Accepted boundary:

```text
Desktop UI
↓
ProductService
↓
Repository
↓
SQLite
```

ProductService owns:

- Product View read models;
- Lists read models;
- grouped History read models;
- History analytics read models;
- status classification;
- latest/delta price meaning;
- analytics frame interpretation;
- percentages;
- frame average purchase timelapse;
- product-cycle comparison.

UI owns rendering, controls, navigation hooks, and event handling.

Repository owns SQL retrieval, persistence, settings access, and row mapping.

SQLite owns persisted facts and settings.

# Current Didactic State

Cycle 03 learning focus:

```text
raw data
→ filtered frame
→ aggregate
→ derived metric
→ read model
→ UI presentation
```

New or reinforced concepts include:

- percentage as derived aggregate;
- filtering frame;
- comparative metric;
- baseline definition;
- status classification versus UI filtering;
- platform-neutral read-model shape;
- History analytics read model;
- unified Lists page with internal views;
- mobile readiness without rewrite.

# Mobile Readiness

Current classification:

```text
Prepared for future mobile discussion.
Not ready for mobile implementation.
```

Prepared:

- service-owned Lists read model;
- service-owned History analytics read model;
- platform-neutral dictionaries/lists;
- UI calculation ownership reduced.

Not ready:

- mobile UI;
- API/backend rewrite;
- sync/auth design;
- mobile persistence strategy;
- typed service contracts;
- dependency injection/service factory;
- formal date validation;
- automated service tests;
- separation between UI labels and semantic values.

# Active Risks

- Manual UI QA remains incomplete.
- Invalid analytics date input behaves like omitted boundary.
- Same-day purchases can produce sub-day frame average timelapse.
- Multi-store analytics totals need richer validation.
- Old Storage/Shortage/Market page files remain transitional.
- `pages.order` remains persisted but inert.
- Main-root and methodology files require revision to register `06_SESSION_SCHEME.md`, `[M]_STAGE`, and file-growth rules.

# Next Recovery Files

For operational state:

```text
operational/10_OPERATIONAL_STATE.md
```

For learning state:

```text
didactics/08_CONCEPT_MAP.md
```

For design state:

```text
design/09_DESIGN_STATE.md
```

For next-session agenda:

```text
06_SESSION_SCHEME.md
```

For session history:

```text
05_SESSION_LOG.md
```
```

---

## 8.2 Draft for 05_SESSION_LOG.md

```markdown
# 05_SESSION_LOG.md

> Status: Global observational history
> Authority: Main Chat
> Persistence class: Ever-growing observational record
> Scope: Session-level drift, reconciliation, accepted direction, and continuity notes

---

## 2026-07-09 — Cycle 03 Closure And Methodology Stress Test

### Session Scope

This session completed experimental Cycle 03 closure for Markei and tested the Sketch Notebook workflow through a full loop:

```text
functional staging
→ Main synthesis
→ Codex materialization
→ Codex evidence
→ domain absorption
→ Main reconciliation
```

### Application Achievements

- Codex materialized the unified Lists page.
- Public tabs became Register / Lists / History / Settings.
- Former Storage / Shortage / Market meanings became Lists internal views.
- Lists gained shared 10-column display with Price and Δ Price.
- History gained embedded read-only analytics.
- ProductService now exposes Lists and History analytics read models.
- No schema changes were introduced.
- No mobile rewrite occurred.

### Validation Evidence

Codex reported:

- compile validation passed;
- database smoke opened existing DB without destructive reset;
- Lists smoke returned all required view counts;
- History read-model smoke returned `months=1`, `unparsed=0`;
- analytics smoke returned parsed/unparsed/excluded counts and totals;
- offscreen Qt startup returned public tabs Register / Lists / History / Settings.

### Domain Reconciliation

Operational, Didactic, and Design folders absorbed G/H/I evidence.

No blocking cross-domain contradiction was found.

Accepted reconciliation:

- Operational owns validation state and remaining manual QA tasks.
- Didactics owns read-model consolidation as learning progression.
- Design owns boundary decisions around Lists and History analytics.
- Main owns global coherence and next-session continuity.

### Methodology Observations

Cycle 03 produced strong results but revealed over-verbosity risk.

Observation:

- ever-growing files can tolerate verbosity better;
- derived files and checkpoints are harmed by excessive detail;
- canonical registers may grow but need targeted recovery rules;
- checkpoints need stronger compactness constraints;
- Main-root files need clearer roles.

### Proposed Method Refinements

- Define file-growth classes:
  - ever-growing;
  - refreshable;
  - derived / resorted;
  - canonical;
  - checkpoint;
  - forward checkpoint.
- Introduce `SPRINT_READ_LIMIT = 800 lines`.
- Introduce `REPARTITION_REVIEW_LIMIT = 1300 lines`.
- Define vertical and horizontal reconciliation.
- Define `00_PROJECT_STATE.md` as a Global State Canon-Checkpoint.
- Register `06_SESSION_SCHEME.md` as a forward checkpoint.
- Register `[M]_STAGE/J_MAIN_STAGE.md` as Main staging surface if accepted.

### Remaining Risks

- Manual UI QA remains pending.
- Invalid analytics date handling needs explicit behavior.
- Same-day average timelapse semantics need review.
- Old inventory page files need cleanup decision.
- Methodology files need revision to incorporate new routing and file-growth protocol.

### Next Session Direction

Next session should focus on methodology revision before new feature implementation.

Primary topics:

1. patch `00_PROJECT_STATE.md`;
2. patch `05_SESSION_LOG.md`;
3. patch `06_SESSION_SCHEME.md`;
4. revise INDEX / FLUX / PROMOTION_RULES / METHOD_GLOSSARY as needed;
5. run canon consistency audit after root files are initialized.
```

---

## 8.3 Draft for 06_SESSION_SCHEME.md

```markdown
# 06_SESSION_SCHEME.md

> Status: Forward checkpoint
> Authority: Main Chat
> Persistence class: Refreshable planning checkpoint
> Scope: Next-session agenda, expected files, unresolved decisions, and continuity frame

---

# Next Session Focus

The next session should prioritize Sketch Notebook methodology refinement after the Cycle 03 stress test.

Primary objective:

```text
Reduce recovery cost without losing evidence richness.
```

# Topics To Resolve

1. Register Main-root file roles:
   - `00_PROJECT_STATE.md` as Global State Canon-Checkpoint;
   - `05_SESSION_LOG.md` as ever-growing global observational history;
   - `06_SESSION_SCHEME.md` as forward checkpoint.

2. Register or decide status of:
   - `[M]_STAGE/J_MAIN_STAGE.md`;
   - `PROVISORY_[M]_DOUBLE_LAB.md`.

3. Define file-growth protocol:
   - ever-growing files;
   - refreshable files;
   - derived / resorted files;
   - canonical files;
   - checkpoints;
   - forward checkpoints.

4. Define length thresholds:
   - `SPRINT_READ_LIMIT = 800 lines`;
   - `REPARTITION_REVIEW_LIMIT = 1300 lines`;
   - checkpoint compactness guidance.

5. Define reconciliation protocol:
   - vertical reconciliation;
   - horizontal reconciliation.

6. Decide where methodology clauses belong:
   - `INDEX.md` for navigation registration;
   - `FLUX.md` for routing and file-growth operations;
   - `PROMOTION_RULES.md` for semantic classes and reconciliation types;
   - `METHOD_GLOSSARY.md` for vocabulary;
   - optional future protocol file only if needed.

# Expected Files To Inspect

Start with:

```text
INDEX.md
methodology/FLUX.md
methodology/PROMOTION_RULES.md
methodology/METHOD_GLOSSARY.md
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
[M]_STAGE/J_MAIN_STAGE.md
```

Consult domain checkpoints only if current project state needs confirmation:

```text
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

# Deferred Application Work

Do not start a new Markei feature cycle until methodology closure is patched or explicitly deferred.

Pending application work remains:

- manual UI QA;
- invalid analytics date input handling;
- same-day timelapse review;
- old Storage/Shortage/Market page file cleanup decision;
- mobile-readiness audit continuation.

# Exit Criteria For Next Session

A successful next session should leave:

- `00_PROJECT_STATE.md` initialized;
- `05_SESSION_LOG.md` initialized;
- `06_SESSION_SCHEME.md` initialized;
- routing for `06_SESSION_SCHEME.md` clarified;
- decision on `[M]_STAGE` and provisional lab file routing;
- methodology patch plan prepared or staged.
```

---

# 9. Proposed PROVISORY_[M]_DOUBLE_LAB.md Content

This section stages the text for a temporary lab-communication file.

The file has not been created by this stage.

```markdown
# PROVISORY_[M]_DOUBLE_LAB.md

> Status: Provisional lab bridge
> Authority: Main Chat + specialized methodology chat
> Scope: Temporary communication surface for Sketch Notebook system refinement
> Warning: This is not canonical methodology. It exists only for the current mid-sprint lab unless later promoted.

---

# 1. Context

This provisional note summarizes the latest Main Chat observations after Markei Cycle 03 and prepares a second methodology-specialized chat to refine the Sketch Notebook system.

Cycle 03 successfully completed a full Sketch Notebook loop:

```text
A/B/C functional staging
→ D/E/F Main synthesis
→ Codex materialization
→ G/H/I Codex reports
→ O/A/D domain absorption
→ Main reconciliation
```

The application result was strong. The methodology result was promising but exposed file-growth and reconciliation issues.

---

# 2. Markei Cycle 03 Outcome

Implemented and reconciled:

- unified Lists page;
- internal views replacing public Storage / Shortage / Market tabs;
- embedded History analytics;
- service-owned Lists read model;
- service-owned History analytics read model;
- global latest/delta price display;
- no schema change;
- no mobile rewrite.

Current classification:

```text
Desktop architecture: improved and mostly stable, pending manual QA.
Mobile readiness: improved for future discussion, not ready for mobile implementation.
Methodology: successful but over-verbose.
```

---

# 3. Methodology Problem Exposed

The domain reports and domain-memory absorption were accurate but over-verbose.

Verbosity worked acceptably for ever-growing files, but caused concern for:

- checkpoints;
- derived files;
- global state summaries;
- future recovery cost.

The system needs a rule that distinguishes file semantic role from allowed growth behavior.

---

# 4. Proposed File Classes

## Ever-growing

Append-oriented files preserving sequence and evidence.

Examples:

```text
05_SESSION_LOG.md
operational/11_OPERATIONAL_RECORD.md
didactics/13_LECTURE_REGISTER.md
design/03_DECISION_LOG.md
```

## Refreshable

Current-state files rewritten or compactly refreshed.

Examples:

```text
00_PROJECT_STATE.md
06_SESSION_SCHEME.md
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

## Derived / resorted

Files that reorganize or summarize canonical truth.

Examples:

```text
operational/04_TODO.md
didactics/07_GLOSSARY.md
design/14_MODEL_OVERVIEW.md
```

## Canonical

Accepted truth owned by a domain.

Examples:

```text
operational/12_OPERATIONAL_MODEL.md
didactics/02_KANBAN.md
design/01_ARCHITECTURE.md
methodology/*.md
```

## Forward checkpoint

A refreshable planning checkpoint for the next session.

Candidate:

```text
06_SESSION_SCHEME.md
```

---

# 5. Proposed Length Protocol

Candidate variables:

```text
SPRINT_READ_LIMIT = 800 lines
REPARTITION_REVIEW_LIMIT = 1300 lines
```

At 800 lines:

- define read-window policy;
- avoid full reread by default;
- prefer header + latest entry + targeted search.

At 1300 lines:

- perform repartition review;
- consider compaction, indexing, or Main-approved structural change.

Checkpoint guidance:

```text
Target: 200–300 lines
Review: near 400 lines
Failure: 800 lines
```

---

# 6. Proposed Reconciliation Protocol

## Vertical reconciliation

Checks coherence through time and semantic maturity layers:

```text
observational evidence
↓
canonical / derived updates
↓
checkpoint refresh
↓
global project state
```

## Horizontal reconciliation

Checks coherence across domains:

```text
Operational ↔ Design ↔ Didactics ↔ Main
```

Goal:

- complementary constraints;
- no duplicate canonical ownership;
- no cross-domain contradiction;
- clear ownership of shared terms.

---

# 7. 00_PROJECT_STATE.md Ambiguity

`00_PROJECT_STATE.md` is special.

It behaves both as:

1. global checkpoint;
2. Main-owned current-state canon.

Proposed term:

```text
Global State Canon-Checkpoint
```

This should be described in methodology, likely in:

```text
PROMOTION_RULES.md
FLUX.md
INDEX.md
METHOD_GLOSSARY.md
```

---

# 8. Main-Root Files To Initialize

Prepare or patch:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
```

Suggested roles:

- `00_PROJECT_STATE.md`: current global state and essential recovery context;
- `05_SESSION_LOG.md`: ever-growing session history;
- `06_SESSION_SCHEME.md`: forward checkpoint for next session agenda.

---

# 9. Structural Questions For Specialized Methodology Chat

1. Should `[M]_STAGE/J_MAIN_STAGE.md` become a permanent Main staging route?
2. Should `PROVISORY_[M]_DOUBLE_LAB.md` be created, or should provisional communication remain inside J?
3. Should file-growth rules live in `FLUX.md`, a new protocol file, or both?
4. Should vertical/horizontal reconciliation live in `PROMOTION_RULES.md`, `FLUX.md`, or a new protocol file?
5. How should `00_PROJECT_STATE.md` be formally classified?
6. Should INDEX be updated immediately to register `06_SESSION_SCHEME.md` and `[M]_STAGE`?
7. How should prompts enforce read-window policies after large files cross threshold?

---

# 10. Recommended Immediate Direction

Do not start a new Markei implementation feature until the Main-root and methodology-routing gaps are resolved or deliberately deferred.

Prioritize:

1. initialize `00_PROJECT_STATE.md`;
2. initialize `05_SESSION_LOG.md`;
3. initialize `06_SESSION_SCHEME.md`;
4. decide status of `[M]_STAGE`;
5. decide status of provisional double-lab file;
6. patch methodology routing and vocabulary.
```

---

# 10. Issues To Raise Before Patching 00 / 05 / 06

1. `06_SESSION_SCHEME.md` exists but is not yet registered in `INDEX.md`.
2. `[M]_STAGE/J_MAIN_STAGE.md` exists but is not yet registered in `INDEX.md` or `FLUX.md`.
3. `PROVISORY_[M]_DOUBLE_LAB.md` was requested conceptually, but does not currently exist in the repository.
4. Creating or registering new files requires explicit Main/human-supervised methodological revision.
5. `00_PROJECT_STATE.md` needs formal classification because it combines global checkpoint behavior with Main-owned current-state canon.
6. File-growth rules should probably be staged before large-file recovery becomes normal practice.

---

# 11. Recommended Next Patch Sequence

1. Review this J stage.
2. Decide whether to create `PROVISORY_[M]_DOUBLE_LAB.md` or keep its content inside J.
3. Patch `00_PROJECT_STATE.md`, `05_SESSION_LOG.md`, and `06_SESSION_SCHEME.md` using the drafts above, adjusted after review.
4. Patch `INDEX.md` to register:
   - `06_SESSION_SCHEME.md`;
   - `[M]_STAGE/J_MAIN_STAGE.md` if accepted.
5. Patch methodology files:
   - `PROMOTION_RULES.md` for `Global State Canon-Checkpoint` and reconciliation types;
   - `FLUX.md` for file-growth/read-window routing;
   - `METHOD_GLOSSARY.md` for new terms.
6. Run a final methodology consistency pass.
