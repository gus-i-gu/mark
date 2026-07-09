# FLUX.md

> Version: 0.5
> Status: Draft
> Persistence Class: Canonical / Operational
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Sketch Notebook routing, staging, write authority, materialization flow, recovery order, file naming, recovery economy, methodology sprint handling, and Codex report feedback

---

# 1. Purpose

`FLUX.md` defines the operational routing of information between Main Chat, functional chats, Codex, GitHub, VS Code, the repository implementation, and the Sketch Notebook.

Its purpose is to prevent:

- uncontrolled edits;
- duplicated writes;
- path drift;
- premature promotion;
- undocumented materialization;
- loss of implementation evidence;
- unnecessary token consumption;
- overloaded Main Chat duties;
- unsuitable documentation responsibility assigned to Codex;
- rogue file creation;
- undocumented file renaming;
- recovery-cost drift;
- temporary methodology sprint files becoming silent permanent canon.

`FLUX.md` answers one primary question:

> Which actor may read, write, stage, materialize, report, recover, reconcile, create, rename, or retire which project knowledge, and through which path?

Foundational principles are defined by `METHOD_FOUNDATIONS.md`.

Semantic maturity is defined by `PROMOTION_RULES.md`.

Communication structures are defined by `CHAT_PROTOCOL.md`.

Operational routing is defined here.

---

# 2. Canonical Notebook Root

The canonical Sketch Notebook root is:

```text
documentation/sketch_notebook/
```

All notebook files, methodology files, stage files, domain files, Main-root files, and permanent project-memory files must live under this root.

The following path is invalid for Sketch Notebook material:

```text
app/documentation/sketch_notebook/
```

No chat, Codex task, automated tool, or manual update should create or maintain Sketch Notebook files under `app/documentation/`.

New files must not be created in adjacent repositories, misplaced folders, or alternative notebook roots.

---

# 3. Methodological Boot Order

The standard methodology boot order is:

```text
INDEX
↓
METHOD_FOUNDATIONS
↓
FLUX
↓
PROMOTION_RULES
↓
CHAT_PROTOCOL
```

This order loads:

```text
Navigation
↓
Foundational ontology
↓
Routing and authority
↓
Knowledge-state semantics
↓
Communication structure
```

`CHAT_BEHAVIOUR.md` remains a stable ontological guide for role perspectives.

It should be consulted when:

- a role’s reasoning perspective is unclear;
- a new role is introduced;
- the conversational system itself is being revised;
- a role behaves inconsistently with its intended perspective.

It does not need to be re-expanded into every ordinary boot if its principles are already stable and represented through `FLUX.md` and `CHAT_PROTOCOL.md`.

---

# 4. Conversational Actors

The Sketch Notebook workflow uses the following actors.

## 4.1 Main Chat

Main Chat coordinates the system as a whole.

It performs synthesis, compares functional reports, prepares Codex-ready materialization instructions, checks consistency between project state and notebook state, records drift, updates global continuity files, and prepares the next session recovery surface.

Main Chat is responsible for global coherence.

## 4.2 Functional Chats

The functional chats are:

- Operational Chat;
- Didactic Chat;
- Design Chat.

Functional chats analyze the project from their own domain perspective.

They stage active reports into `DEV_STAGE/A`, `DEV_STAGE/B`, and `DEV_STAGE/C`.

After Codex materialization reports exist, functional chats extract relevant information from Codex report stages into their own permanent domain folders.

Functional chats are responsible for domain memory.

## 4.3 Codex

Codex is the materialization agent.

Codex reads Main-approved materialization stages, applies repository changes, runs validation when instructed, and reports what actually happened.

Codex should not decide semantic promotion.

Codex should not invent methodology.

Codex should not create or rename Sketch Notebook files unless explicitly instructed by Main-approved materialization stages.

Codex reports evidence.

## 4.4 Human / VS Code

The human developer and VS Code provide inspection, review, manual verification, strategic direction, and final acceptance.

Human supervision remains responsible for accepting, rejecting, redirecting, or correcting materialized changes.

---

# 5. DEV_STAGE

`DEV_STAGE` is the active staging area of the Sketch Notebook.

Canonical path:

```text
documentation/sketch_notebook/DEV_STAGE/
```

`DEV_STAGE` contains three groups of files.

---

## 5.1 Functional Stage Files

Functional chats write these files during active domain staging:

```text
A_OPERATIONAL.md
B_DIDACTIC.md
C_DESIGN.md
```

Purpose:

- capture current operational, didactic, and design reasoning;
- prepare domain-specific material for Main synthesis;
- avoid losing functional analysis inside transient conversation.

These files are functional stage material.

They are not canonical.

---

## 5.2 Main Materialization Stage Files

Main Chat writes these files:

```text
D_OPS_STAGE.md
E_DDC_STAGE.md
F_DSN_STAGE.md
```

Purpose:

- transform functional reports into Codex-ready instructions;
- specify application changes;
- specify notebook changes;
- identify validation requirements;
- preserve Main-approved implementation direction.

These files are materialization stage material.

They are not final project memory.

---

## 5.3 Codex Report Stage Files

Codex writes these files after materialization:

```text
G_OPS_CODEX.md
H_DDC_CODEX.md
I_DSN_CODEX.md
```

Purpose:

- report what Codex actually changed;
- report what Codex did not or could not change;
- report validation commands and results;
- expose implementation evidence for functional chats and Main Chat;
- provide raw material for operational, didactic, and design permanent memory.

Codex report stages are observational evidence.

They are not canonical.

---

# 6. Permanent Domain Folders

Permanent domain folders live under:

```text
documentation/sketch_notebook/
```

Canonical domain folders:

```text
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
documentation/sketch_notebook/methodology/
```

Domain folders contain persistent project memory.

They are not temporary stage surfaces.

Each functional domain should expose the semantic roles defined by the Domain Symmetry Principle:

```text
Canonical Knowledge
Derived Knowledge
Domain Checkpoint
Observational History
```

The exact filenames may differ between domains.

The semantic roles must remain distinguishable.

---

# 7. Main-Root Continuity Files

The Sketch Notebook root may contain Main-owned continuity files.

These files are not methodology files, functional domain files, or DEV_STAGE files.

They form a disjunct continuity flux used for Main session closure, global recovery, and next-session preparation.

Current Main-root continuity files are:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

## 7.1 00_PROJECT_STATE.md

`00_PROJECT_STATE.md` is the Main-owned global current-state recovery surface.

It should expose:

- current project milestone;
- current application state;
- current architecture state;
- current didactic state;
- current methodology state;
- active risks;
- next recovery files.

It should remain concise.

It should point to domain checkpoints for depth.

It should not duplicate full domain truth.

It should be refreshed when the accepted global project state changes.

## 7.2 05_SESSION_LOG.md

`05_SESSION_LOG.md` is the Main-owned global observational session record.

It preserves:

- session-level drift;
- major reconciliation events;
- accepted direction;
- closure notes;
- methodology observations;
- continuity evidence.

It is append-oriented.

It should not be rewritten as current-state canon.

It explains how global state changed.

## 7.3 06_SESSION_SCHEME.md

`06_SESSION_SCHEME.md` is the Main-owned forward checkpoint.

It prepares the next session by recording:

- next-session focus;
- expected files to inspect;
- unresolved decisions;
- deferred work;
- exit criteria;
- recovery warnings.

It is predictive and refreshable.

It describes the intended next recovery frame.

It does not validate that future state has occurred.

## 7.4 Main-Root Continuity Flow

At session closure, Main Chat may update:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
```

The typical flow is:

```text
Domain checkpoints
↓
Codex reports
↓
Human validation
↓
Main reconciliation
↓
00_PROJECT_STATE refresh
↓
05_SESSION_LOG append
↓
06_SESSION_SCHEME refresh
```

This flow is disjunct from functional domain promotion.

Main-root files coordinate global continuity.

They do not replace operational, didactic, or design domain memory.

---

# 8. Domain Recovery Entry Points

The Hierarchical Recovery Principle requires each domain to expose a low-token entry point before requiring full canonical or historical reading.

These entry points are Domain Checkpoints.

Current checkpoint files:

| Domain | Checkpoint |
| --- | --- |
| Operational | `documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md` |
| Didactic | `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md` |
| Design | `documentation/sketch_notebook/design/09_DESIGN_STATE.md` |

A Domain Checkpoint should answer:

- where the domain currently stands;
- what changed recently;
- what is stable;
- what is active;
- what is unresolved;
- what should be read next if deeper context is required.

A checkpoint does not introduce independent truth.

A checkpoint summarizes the current state of canonical, derived, and observational knowledge.

---

# 9. Hierarchical Recovery Order

Every role should recover project state using the least expensive knowledge source capable of answering the current task.

The standard recovery order is:

```text
Main-root continuity file, when global orientation is required
↓
Domain Checkpoint
↓
Canonical Knowledge
↓
Derived Knowledge
↓
Observational History
↓
Repository Inspection
```

This hierarchy is a cost discipline, not a prohibition.

A role may inspect deeper sources when:

- the checkpoint is empty;
- the checkpoint is stale;
- the checkpoint is insufficient;
- notebook drift is suspected;
- implementation truth is uncertain;
- repository files are the direct subject of the task;
- materialization must be validated;
- the task is methodology revision;
- a structural routing gap is under review.

A role should not consume full canonical registers, historical logs, or source files when the relevant Main-root file or checkpoint already answers the task.

---

# 10. Domain Folder Responsibilities

## 10.1 operational/

The operational folder stores execution-oriented project memory.

Required semantic roles:

| Role | Current / Expected File |
| --- | --- |
| Canonical operational knowledge | `12_OPERATIONAL_MODEL.md` |
| Derived operational knowledge | `04_TODO.md` and related operational views |
| Domain checkpoint | `10_OPERATIONAL_STATE.md` |
| Observational history | `11_OPERATIONAL_RECORD.md` |

`12_OPERATIONAL_MODEL.md` should define stable operational knowledge: execution model, validation conventions, operational responsibilities, and implementation workflow principles.

`04_TODO.md` should contain stable backlog items or deferred operational tasks.

`10_OPERATIONAL_STATE.md` should summarize the current operational state for fast recovery.

`11_OPERATIONAL_RECORD.md` should preserve append-oriented operational history: actions performed, commands run, validation results, failures, and outcomes.

If a required semantic role lacks a file, the absence should be reported as a structural gap and materialized through Main-approved instructions.

---

## 10.2 didactics/

The didactics folder stores learning-oriented project memory.

Required semantic roles:

| Role | Current / Expected File |
| --- | --- |
| Canonical didactic knowledge | `02_KANBAN.md` |
| Derived didactic knowledge | `07_GLOSSARY.md` |
| Domain checkpoint | `08_CONCEPT_MAP.md` |
| Observational learning history | `13_LECTURE_REGISTER.md` |

`02_KANBAN.md` should contain canonical learned concepts.

`07_GLOSSARY.md` should derive terminology from canonical concepts and methodology vocabulary.

`08_CONCEPT_MAP.md` should act as the didactic checkpoint: current learning state, stable concepts, unstable concepts, next concepts, and dependency spine.

`13_LECTURE_REGISTER.md` should preserve append-oriented learning history: lectures introduced, questions raised, concepts reinforced, misconceptions detected, and meta-learning observations.

Meta-learning history should not be mixed permanently into `02_KANBAN.md`.

---

## 10.3 design/

The design folder stores architecture-oriented project memory.

Required semantic roles:

| Role | Current / Expected File |
| --- | --- |
| Canonical design knowledge | `01_ARCHITECTURE.md` |
| Derived design knowledge | `14_MODEL_OVERVIEW.md` |
| Domain checkpoint | `09_DESIGN_STATE.md` |
| Observational design history | `03_DECISION_LOG.md` |

`01_ARCHITECTURE.md` should define stable architectural knowledge: dependency direction, responsibility boundaries, domain relationships, and structural principles.

`14_MODEL_OVERVIEW.md` should summarize or reorganize the current architectural model without introducing independent truth.

`09_DESIGN_STATE.md` should summarize the current architectural state for fast recovery.

It should identify:

- active architectural milestone;
- stable decisions;
- unresolved design questions;
- current domain model;
- implementation drift, if any;
- deeper design files to inspect if needed.

`03_DECISION_LOG.md` should preserve append-oriented design history: accepted decisions, postponed decisions, rationale, consequences, and design changes over time.

If canonical, derived, checkpoint, or observational design files are absent or inconsistent, the absence or inconsistency should be reported as a structural gap and materialized through Main-approved instructions.

---

## 10.4 methodology/

The methodology folder stores the rules of the Sketch Notebook Method itself.

Current methodology files include:

```text
METHOD_FOUNDATIONS.md
FLUX.md
PROMOTION_RULES.md
CHAT_PROTOCOL.md
CHAT_BEHAVIOUR.md
METHOD_GLOSSARY.md
```

Only explicit methodological work should modify this folder.

Codex must not modify methodology unless Main Chat explicitly instructs it to do so.

---

# 11. Write Authority

## 11.1 Functional Chat Active Stage Authority

During active functional staging, each functional chat writes only its assigned A/B/C stage file.

| Chat | Active stage file |
| --- | --- |
| Operational Chat | `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md` |
| Didactic Chat | `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md` |
| Design Chat | `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md` |

During this phase, functional chats must not edit:

- application source files;
- methodology files;
- Main stage files;
- Codex report files;
- other functional stage files;
- another functional domain folder;
- Main-root continuity files.

---

## 11.2 Functional Chat Domain Memory Authority

After Codex report files G/H/I exist, functional chats may update their own permanent domain folders.

| Chat | May read | May update |
| --- | --- | --- |
| Operational Chat | `G_OPS_CODEX.md` | `documentation/sketch_notebook/operational/` |
| Didactic Chat | `H_DDC_CODEX.md` | `documentation/sketch_notebook/didactics/` |
| Design Chat | `I_DSN_CODEX.md` | `documentation/sketch_notebook/design/` |

This authority is limited to extracting, classifying, reconciling, and checkpointing Codex-reported evidence into the chat's own domain memory.

Functional chats must separate:

- observational records;
- canonical knowledge;
- derived knowledge;
- domain checkpoints.

Functional chats must not write outside their own domain folders.

Functional chats must not edit methodology files.

Functional chats must not edit application source files.

Functional chats must not independently promote methodology changes.

---

## 11.3 Main Chat Authority

Main Chat may write:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Main Chat may also update global project continuity files:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

Main Chat checks whether functional domain folders remain consistent with:

- human direction;
- A/B/C functional reports;
- D/E/F materialization stages;
- G/H/I Codex reports;
- source code state;
- domain checkpoints;
- canonical domain files;
- derived domain files;
- observational records;
- Main-root continuity files.

Main Chat is responsible for reporting consistency, drift, unresolved contradictions, and accepted reconciliation into `05_SESSION_LOG.md`.

---

## 11.4 Codex Authority

Codex reads:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Codex may edit:

- application source files;
- permanent notebook files explicitly named in D/E/F;
- domain folders explicitly named in D/E/F;
- methodology files only if D/E/F explicitly authorize methodology modification;
- Main-root files only if D/E/F explicitly authorize that update.

Codex writes post-materialization reports to:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex must report:

- files changed;
- files created;
- files deleted;
- commands run;
- validation results;
- skipped instructions;
- failed instructions;
- unresolved risks;
- documentation updates performed;
- documentation updates not performed.

Codex reports are not canonical knowledge.

They are evidence for later reconciliation.

---

# 12. Knowledge Classes and Routing

`FLUX.md` uses the knowledge classes defined by `METHOD_FOUNDATIONS.md` and `PROMOTION_RULES.md`.

## 12.1 Functional Stage

A/B/C files are functional stage material.

They are working reports.

They are not canonical.

## 12.2 Main Materialization Stage

D/E/F files are Main-approved materialization instructions.

They are not final memory.

They are the instruction layer before physical change.

## 12.3 Codex Report Stage

G/H/I files are post-materialization reports.

They are observational evidence.

They are not canonical.

## 12.4 Canonical Knowledge

Canonical knowledge belongs in permanent domain files when validated and accepted.

Examples:

- KANBAN concept entries;
- architectural decisions;
- stable operational guides;
- domain models;
- methodology principles.

## 12.5 Derived Knowledge

Derived knowledge summarizes or reorganizes canonical knowledge.

Examples:

- glossary;
- concept map;
- TODO views;
- architecture overview;
- project state snapshot.

Derived knowledge must not create independent truth.

## 12.6 Domain Checkpoint

A Domain Checkpoint is ephemeral derived knowledge optimized for recovery.

Examples:

- `08_CONCEPT_MAP.md`;
- `10_OPERATIONAL_STATE.md`;
- `09_DESIGN_STATE.md`.

Checkpoints should be refreshed when domain state changes.

## 12.7 Main-Root Continuity Knowledge

Main-root continuity files are Main-owned global coordination surfaces.

They are not domain files.

They are not methodology files.

They are not DEV_STAGE files.

They support session closure and next-session recovery.

## 12.8 Observational Records

Observational records preserve what happened.

Examples:

- operational record;
- session log;
- lecture register;
- decision log;
- Codex execution report.

Observational records should be append-oriented unless explicitly corrected by Main Chat under human-supervised methodological revision.

---

# 13. Standard Flow

The standard workflow is:

```text
Human prompt
↓
Methodological boot
↓
Global orientation from 00_PROJECT_STATE when needed
↓
Functional chats recover from domain checkpoints
↓
Functional chats inspect canonical / derived / observational files only as needed
↓
Functional chats inspect repository when required
↓
Functional chats write A/B/C active stage reports
↓
Main Chat reads A/B/C + human prompt + domain checkpoints
↓
Main Chat inspects deeper domain files only as needed
↓
Main Chat writes D/E/F materialization stages
↓
Codex reads D/E/F
↓
Codex materializes application and/or notebook changes
↓
Codex writes G/H/I materialization reports
↓
Functional chats read G/H/I
↓
Functional chats update their own permanent domain folders
↓
Functional chats refresh their domain checkpoints
↓
Main Chat reads domain checkpoints + G/H/I + 00_PROJECT_STATE + 05_SESSION_LOG
↓
Main Chat checks consistency and records drift/resolution in 05_SESSION_LOG
↓
Main Chat refreshes 00_PROJECT_STATE and 06_SESSION_SCHEME when needed
↓
Git/GitHub persistence
↓
Next session boots from improved project memory
```

This flow separates:

- intention;
- recovery;
- reasoning;
- staging;
- synthesis;
- materialization;
- evidence;
- domain memory;
- checkpoint refresh;
- global reconciliation;
- forward recovery preparation;
- persistence.

---

# 14. Functional Chat Post-Codex Duties

After Codex reports are available, each functional chat has a post-Codex duty.

## 14.1 Operational Chat Post-Codex Duty

Operational Chat reads:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
```

Then it updates operational memory as appropriate.

Required classification:

```text
canonical operational knowledge
derived operational view
domain checkpoint update
historical / observational record
active action
future TODO
structural gap
```

Typical targets:

```text
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/operational/11_OPERATIONAL_RECORD.md
documentation/sketch_notebook/operational/12_OPERATIONAL_MODEL.md
```

If `12_OPERATIONAL_MODEL.md` is insufficient for a new stable operational rule, Operational Chat should report the structural gap in `A_OPERATIONAL.md` or `10_OPERATIONAL_STATE.md`.

It should not invent permanent filenames unless Main-approved instructions authorize them.

---

## 14.2 Didactic Chat Post-Codex Duty

Didactic Chat reads:

```text
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
```

Then it updates didactic memory as appropriate.

Required classification:

```text
canonical concept
glossary derivative
concept-map checkpoint
unstable concept
next study concept
meta-learning observation
structural gap
```

Typical targets:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md
```

If `13_LECTURE_REGISTER.md` is insufficient for a new learning-history event, Didactic Chat should report the structural gap in `B_DIDACTIC.md` or `08_CONCEPT_MAP.md`.

It should not invent permanent filenames unless Main-approved instructions authorize them.

---

## 14.3 Design Chat Post-Codex Duty

Design Chat reads:

```text
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Then it updates design memory as appropriate.

Required classification:

```text
canonical design decision
architectural observation
derived architecture summary
domain checkpoint update
deferred design question
implementation drift
structural gap
```

Typical targets:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

Design Chat may update existing design files according to their semantic role.

If a design update requires a new permanent design file, Design Chat should report the structural gap in `C_DESIGN.md` or `09_DESIGN_STATE.md`.

It should not invent permanent filenames unless Main-approved methodological or materialization instructions authorize them.

---

# 15. Main Chat Continuity Duties

Main Chat is not the primary writer of domain memory after G/H/I exist.

That responsibility belongs to the functional chats.

Main Chat is responsible for global coherence and continuity.

Main Chat should check:

- whether `00_PROJECT_STATE.md` reflects the current project state;
- whether `05_SESSION_LOG.md` records the session;
- whether `06_SESSION_SCHEME.md` prepares the next session;
- whether domain checkpoints agree with canonical domain files;
- whether derived domain files reflect canonical domain files;
- whether observational records explain recent changes;
- whether operational, didactic, and design folders agree with each other;
- whether Codex reports contradict intended D/E/F stages;
- whether permanent domain memory contradicts source code state;
- whether human direction overrides prior project memory.

Main Chat records consistency checks, drift, unresolved contradictions, and accepted reconciliations in:

```text
documentation/sketch_notebook/05_SESSION_LOG.md
```

Main Chat may update:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

when project-state or next-session recovery state changes.

---

# 16. Codex Report Duties

Codex reports should be concise but complete.

Each G/H/I report should include:

```text
Source stage files
Files changed
Files created
Files deleted
Commands run
Validation results
Instructions completed
Instructions skipped
Failures or blockers
Unresolved risks
Suggested functional follow-up
```

Codex should avoid long explanatory documentation inside G/H/I.

Codex should report evidence.

Functional chats interpret that evidence.

Main Chat reconciles that evidence.

---

# 17. Checkpoint Refresh Duties

Whenever a functional chat updates its permanent domain folder after reading G/H/I, it should refresh the domain checkpoint if the current state changed.

Checkpoint refresh targets:

| Chat | Checkpoint |
| --- | --- |
| Operational Chat | `operational/10_OPERATIONAL_STATE.md` |
| Didactic Chat | `didactics/08_CONCEPT_MAP.md` |
| Design Chat | `design/09_DESIGN_STATE.md` |

A checkpoint should remain compact.

A checkpoint should point to deeper files rather than reproduce them.

A checkpoint should make the next boot cheaper.

A checkpoint should not become a historical log.

A checkpoint should not become a canonical register.

A checkpoint should answer in a short read:

```text
What exists?
What changed?
What remains open?
Where should recovery continue?
```

---

# 18. Naming and File Creation Rules

Chats must never invent staging filenames.

Chats, Codex, and automated tools must not create new files directly under:

```text
documentation/sketch_notebook/
```

unless explicitly authorized by Main Chat under human-supervised methodological revision.

New files must not be created in adjacent repositories, misplaced folders, or alternative notebook roots.

File creation outside established domain folders creates data fragmentation and increases the risk of data loss during pruning.

Files must not be renamed except by Main Chat under human-supervised methodological revision.

Renaming requires a coherence check against:

- `INDEX.md`;
- `FLUX.md`;
- relevant domain checkpoints;
- affected functional prompts;
- affected Codex materialization instructions.

Valid functional stage files:

```text
A_OPERATIONAL.md
B_DIDACTIC.md
C_DESIGN.md
```

Valid Main materialization stage files:

```text
D_OPS_STAGE.md
E_DDC_STAGE.md
F_DSN_STAGE.md
```

Valid Codex report stage files:

```text
G_OPS_CODEX.md
H_DDC_CODEX.md
I_DSN_CODEX.md
```

Current Main-root continuity files are:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
```

Current domain symmetry files are:

```text
operational/
    04_TODO.md
    10_OPERATIONAL_STATE.md
    11_OPERATIONAL_RECORD.md
    12_OPERATIONAL_MODEL.md

didactics/
    02_KANBAN.md
    07_GLOSSARY.md
    08_CONCEPT_MAP.md
    13_LECTURE_REGISTER.md

design/
    01_ARCHITECTURE.md
    03_DECISION_LOG.md
    09_DESIGN_STATE.md
    14_MODEL_OVERVIEW.md
```

Current checkpoint filenames are:

```text
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

Invalid older names include:

```text
DEV_TRACK/
B_DIDACTICS.md
02_DIDACTICS.md
10_ACTIONS.md
11_OPERATIONAL_TRACKRECORD.md
11_OPERATIONAL_TRACK.md
app/documentation/sketch_notebook/*
```

These names may appear in historical context, but they are not canonical.

---

# 19. Recovery-Economy

Recovery-Economy is the operational discipline that keeps project recovery cost from growing in proportion to notebook age.

The purpose is not to minimize information.

The purpose is to preserve enough information while ensuring each file still performs its semantic responsibility.

A file is not degraded merely because it is long.

A file is degraded when its length prevents it from performing its assigned role.

---

## 19.1 Semantic Responsibility Over Length

Every Sketch Notebook file has a primary semantic responsibility.

Operational handling should follow that responsibility.

A file should be evaluated by asking:

```text
Does this file still perform the role it exists to perform?
```

rather than:

```text
How long is this file?
```

Length may trigger review.

Length alone does not justify file creation, file splitting, or structural change.

---

## 19.2 File Operation Contract

Each file class has a preferred maintenance operation.

| File class | Preferred operation |
| --- | --- |
| Checkpoint | Refresh |
| Canonical | Reconcile |
| Derived / resorted | Extend / Reconcile |
| Observational | Append |
| Main-root current state | Refresh |
| Main-root session log | Append |
| Main-root forward checkpoint | Refresh |
| Stage file | Replace / supersede |
| Codex report | Replace per materialization cycle |

The preferred operation may be overridden only by explicit Main-approved methodological revision.

---

## 19.3 Append Contract

Observational files preserve chronology.

New registrations should append a dated section.

Existing historical sections are considered immutable records unless one of the following is true:

- factual correction is required;
- archival restructuring is explicitly approved;
- Main authorizes a historical correction or consolidation stage.

Observational files explain how current state emerged.

They do not define present truth by themselves.

Examples:

```text
05_SESSION_LOG.md
operational/11_OPERATIONAL_RECORD.md
didactics/13_LECTURE_REGISTER.md
design/03_DECISION_LOG.md
```

---

## 19.4 Refresh Contract

Refreshable files exist for fast recovery.

They should answer in a short read:

```text
What exists?
What changed?
What remains open?
Where should recovery continue?
```

A checkpoint should not become:

- a canonical register;
- a historical log;
- a lecture;
- an architectural essay;
- an implementation report.

If a checkpoint starts teaching, explaining full rationale, or preserving long chronology, it is stealing responsibility from another file.

Examples:

```text
00_PROJECT_STATE.md
06_SESSION_SCHEME.md
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

---

## 19.5 Canonical Growth

Canonical files may grow as the project matures.

Growth alone is expected.

When canonical files become expensive to recover, agents should shift from full reread to targeted recovery:

```text
checkpoint
↓
heading lookup
↓
targeted search
↓
bounded read window
```

Canonical files should remain searchable and internally navigable.

They should not be split merely because they crossed a size threshold.

Structural repartition requires Main-approved methodological revision.

Examples:

```text
methodology/*.md
operational/12_OPERATIONAL_MODEL.md
didactics/02_KANBAN.md
design/01_ARCHITECTURE.md
```

---

## 19.6 Derived / Resorted Economy

Derived files reorganize, summarize, or index canonical truth.

They must not become duplicate canon.

When derived files become too large or difficult to recover, preferred remedies are:

- resorting;
- compacting;
- indexing;
- replacing duplicated explanation with references;
- adding Landline Marks.

New file creation is not the default remedy.

Examples:

```text
operational/04_TODO.md
didactics/07_GLOSSARY.md
design/14_MODEL_OVERVIEW.md
```

---

## 19.7 Read Window Protocol

Large files should use read-window discipline before structural repartition.

Default recovery sequence for large files:

```text
file header
↓
latest Landline Mark
↓
targeted search
↓
bounded section read
↓
older Landline Mark only if required
```

Agents should not reread an entire large file when a bounded section or search can answer the task.

Crossing a length threshold activates recovery discipline.

It does not automatically authorize a new file.

---

## 19.8 Landline Marks

A Landline Mark is a stable heading or marker that allows agents to recover relevant late sections without rereading an entire file.

The name evokes a fixed recovery line: a known place where a future chat can reconnect to the file.

Suggested format:

```text
## LANDLINE: Latest Session
## LANDLINE: Cycle 03 Reconciliation
## LANDLINE: Current Methodology Risks
## LANDLINE: Latest Accepted Architecture
```

Landline Marks should mark semantic transitions.

They should not be arbitrary page divisions.

A file may contain multiple Landline Marks.

Agents should prefer the latest relevant Landline Mark when recovering current context.

---

## 19.9 Length Thresholds

The following thresholds guide recovery behavior.

```text
SPRINT_READ_LIMIT = 800 lines
REPARTITION_REVIEW_LIMIT = 1300 lines
```

At `SPRINT_READ_LIMIT`:

- confirm file class;
- use read-window recovery;
- prefer Landline Marks and targeted search;
- avoid full-file reread by default.

At `REPARTITION_REVIEW_LIMIT`:

- perform a repartition review;
- consider indexing, compaction, resorting, or structural change;
- preserve historical evidence if compaction changes current presentation;
- require Main-approved methodological revision for new files or repartition.

Checkpoint guidance:

```text
Target: 200–300 lines
Review: near 400 lines
Failure: 800 lines
```

---

## 19.10 Boundary-Stable Language

Reports should distinguish implementation stability from boundary stability.

Use:

```text
boundary-stable
```

when responsibilities, ownership, and architectural boundaries have stabilized, even if implementation details still need refinement.

Avoid using:

```text
stable
```

when the implementation still has known risks, deferred decisions, or manual validation gaps.

---

## 19.11 Recovery-Economy Failure Modes

Recovery-Economy drift exists when:

- checkpoints become long registers;
- derived files duplicate canon;
- observational files are rewritten as current truth;
- canonical files require full reread for ordinary recovery;
- large files lack headings or Landline Marks;
- new files are created to solve verbosity without Main-approved repartition;
- prompts require full rereads when checkpoint-first recovery is sufficient;
- Main-root continuity files duplicate full domain truth;
- `06_SESSION_SCHEME.md` becomes a historical record rather than a forward checkpoint.

When Recovery-Economy drift is detected, the agent should report it as structural drift rather than silently creating new files.

---

# 20. Methodology Refinement Sprints

A Methodology Refinement Sprint is an explicit, human-supervised work period focused on changing the Sketch Notebook Method itself.

It is not an ordinary Markei feature cycle.

It may modify:

```text
documentation/sketch_notebook/methodology/
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

It may also use temporary methodology sprint files when chat-to-chat communication requires a provisional bridge.

---

## 20.1 Sprint Authorization

A methodology refinement sprint requires explicit human direction and Main Chat supervision.

Functional chats may propose methodology refinements.

Functional chats must not independently materialize methodology changes.

Codex may materialize methodology changes only when D/E/F or other Main-approved materialization instructions explicitly authorize them.

---

## 20.2 Temporary Methodology Sprint Files

Temporary methodology sprint files may exist only when a methodology refinement sprint requires a provisional communication surface.

Temporary sprint files must declare:

- provisional status;
- authority;
- scope;
- owner;
- expiry condition.

They must not silently become permanent methodology.

They must not redefine canon by themselves.

They must end as one of:

```text
absorbed into methodology
absorbed into 05_SESSION_LOG.md
converted into an approved permanent route
deleted
left temporarily with explicit expiry condition
```

Current example:

```text
PROVISORY_[M]_DOUBLE_LAB.MD
```

---

## 20.3 Methodology Sprint Closure

Before a methodology refinement sprint closes, Main Chat should check:

- whether temporary sprint files have a disposition;
- whether `INDEX.md` registers all accepted routes;
- whether `FLUX.md` reflects operational routing changes;
- whether `PROMOTION_RULES.md` reflects semantic-state changes;
- whether `METHOD_FOUNDATIONS.md` reflects only foundational changes;
- whether `METHOD_GLOSSARY.md` contains new vocabulary;
- whether `00_PROJECT_STATE.md` and `06_SESSION_SCHEME.md` reflect the next recovery state.

Unresolved methodology questions should be recorded in `06_SESSION_SCHEME.md`.

Session-level methodology observations should be appended to `05_SESSION_LOG.md`.

---

# 21. Commit Rules

Functional active stage commits should be narrow:

```text
documentation/sketch_notebook/DEV_STAGE/<assigned A/B/C file>.md
```

Functional post-Codex domain-memory commits should be narrow and restricted to the chat's own permanent domain folder.

Examples:

```text
documentation/sketch_notebook/operational/*
documentation/sketch_notebook/didactics/*
documentation/sketch_notebook/design/*
```

Main stage commits should be narrow:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Main continuity commits should be narrow:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

Methodology refinement commits should be narrow enough to preserve semantic reviewability.

Codex materialization commits may include multiple files, but only according to Main-approved stage instructions.

Codex report commits should include:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

---

# 22. Failure Rules

An update is invalid if:

- a chat writes outside its authority;
- a chat writes under `app/documentation/sketch_notebook/`;
- a chat creates files directly under `documentation/sketch_notebook/` without Main-authorized methodological revision;
- a chat creates files in adjacent repositories, misplaced folders, or alternative notebook roots;
- a chat invents a staging filename;
- a chat renames files without Main-authorized methodological revision;
- Codex modifies methodology without explicit Main instruction;
- Codex materializes source changes not supported by D/E/F;
- functional chats modify application source code;
- functional chats write into another functional domain folder;
- functional chats modify Main-root continuity files without Main authorization;
- derived files introduce truth not present in canonical files;
- domain checkpoints become long canonical registers;
- observational records are rewritten as if they were canonical truth;
- Codex reports silently omit failed or skipped instructions;
- temporary methodology sprint files become permanent without explicit routing registration;
- `06_SESSION_SCHEME.md` is treated as validated future truth rather than a forward checkpoint;
- large files are split or multiplied solely because they crossed a length threshold.

Main Chat must inspect invalid updates, recover useful content if necessary, and restore canonical routing.

---

# 23. Summary

Functional chats recover from domain checkpoints first.

Functional chats stage active reasoning in A/B/C.

Main Chat synthesizes and writes D/E/F.

Codex materializes and reports through G/H/I.

Functional chats extract Codex reports into their own permanent domain folders.

Functional chats refresh their domain checkpoints.

Main Chat checks global continuity through:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

The canonical notebook root is always:

```text
documentation/sketch_notebook/
```

The staging folder is always:

```text
documentation/sketch_notebook/DEV_STAGE/
```

The current low-token domain checkpoints are:

```text
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

The current domain symmetry files are:

```text
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/operational/11_OPERATIONAL_RECORD.md
documentation/sketch_notebook/operational/12_OPERATIONAL_MODEL.md

documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md

documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

The current Main-root continuity files are:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

The goal of FLUX is not only to move information forward.

The goal is to preserve evidence, responsibility, learning, recovery, file coherence, continuity, and reconciliation without confusing stage, synthesis, materialization, report, canonical memory, derivative memory, checkpoint memory, forward checkpoint memory, Main-root continuity, and historical record.
