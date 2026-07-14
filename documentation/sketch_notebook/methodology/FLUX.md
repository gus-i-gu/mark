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

# 13. Sequence Protocols

Sequence Protocols define the controlling operational route for a bounded unit of work.

They do not create new roles, files, knowledge states, or promotion authority. They select how the existing roles and memory surfaces are used.

## 13.1 Sequence Index and Shared Contract — FLX-SEQ-00

| ID | Sequence | Use when | Primary result |
| --- | --- | --- | --- |
| FLX-ORD-01 | Ordinary Sequence | a bounded change can move once through investigation, synthesis, materialization, evidence, and reconciliation | implemented and reconciled project change |
| FLX-INV-02 | Investigative Sequence | the problem requires repeated repository exploration and cross-domain confrontation before implementation authority can be frozen | cumulative evidence, compressed Main synthesis, and progressively improved provisional staging |
| FLX-PRN-03 | Pruning Sequence | permanent memory has become stale, repetitive, disordered, or expensive to recover | reorganized canon, regenerated derivatives, preserved history, and compact checkpoints |
| FLX-PRM-04 | Promotion/Reconciliation Sequence | knowledge must change semantic state or be absorbed after evidence, investigation, or pruning | uniquely owned, evidence-qualified permanent knowledge |

Shared constraints:

1. One Sequence Protocol is controlling at a time.
2. A controlling sequence may invoke another only at an explicit transition gate.
3. Every invocation states sequence ID, role, branch, baseline, writable surfaces, evidence boundary, and next handoff.
4. Human direction may select the sequence. Main may recommend a sequence but must not disguise a sequence change.
5. Stage content is never canon merely because a sequence repeats it.
6. Repository evidence is not promotion.
7. Materialization is not promotion.
8. Promotion follows PRC-01 in PROMOTION_RULES.md.
9. Observational history is preserved unless a factual correction is explicitly authorized.
10. New files, renames, methodology changes, source changes, commits, and pushes require their ordinary authority even when a sequence is active.
11. A sequence stops when its next transition lacks evidence, authority, a required human decision, or an unambiguous writable scope.
12. Prompts should read FLX-SEQ-00, the selected protocol, and PRC-01 before opening broader methodology.

Selection rule:

~~~text
bounded executable change
    -> FLX-ORD-01

repeated inquiry before authority
    -> FLX-INV-02

memory maintenance without new product truth
    -> FLX-PRN-03

semantic-state change or post-evidence absorption
    -> FLX-PRM-04
~~~

Allowed transitions:

~~~text
FLX-ORD-01
    -> FLX-PRM-04 after materialization evidence
    -> FLX-PRN-03 when recovery drift blocks the ordinary route

FLX-INV-02
    -> another FLX-INV-02 round
    -> FLX-PRM-04 when findings are ready for semantic acceptance
    -> FLX-ORD-01 when D/E/F are frozen and implementation is authorized
    -> FLX-PRN-03 when accumulated memory must be reorganized first

FLX-PRN-03
    -> FLX-PRM-04 only for claims that require semantic correction
    -> FLX-ORD-01 or FLX-INV-02 after recovery surfaces are healthy

FLX-PRM-04
    -> FLX-ORD-01 for an accepted executable change
    -> FLX-INV-02 when evidence remains insufficient
    -> FLX-PRN-03 when accepted truth requires broad regeneration
~~~

Localized reading route:

- always read this shared contract;
- read only the selected protocol below;
- read PROMOTION_RULES.md PRC-01;
- use deeper FLUX or PROMOTION_RULES sections only for a named uncertainty;
- use the corresponding SEQ prompt in PROMPT_COLLECTION.md.

## 13.2 Ordinary Sequence — FLX-ORD-01

Purpose:

Move one bounded unit from human direction through functional staging, Main synthesis, materialization, evidence, permanent reconciliation, and forward continuity.

Entry conditions:

- one sufficiently bounded objective;
- known branch and baseline;
- recoverable role checkpoints;
- no unresolved contradiction requiring repeated investigation;
- writable scope and authority identifiable before mutation.

Protocol:

~~~text
Human prompt
↓
Methodological boot and FLX-ORD-01 selection
↓
Global orientation from 00_PROJECT_STATE and 06_SESSION_SCHEME when needed
↓
O/A/D recover from their checkpoints
↓
O/A/D inspect deeper memory and repository truth only as required
↓
O/A/D write or replace A/B/C for the bounded unit
↓
Main reads A/B/C, human direction, checkpoints, and required evidence
↓
Main resolves contradictions and prepares controlling D/E/F
↓
Codex reads D/E/F and materializes the authorized change
↓
Codex validates and writes G/H/I
↓
FLX-PRM-04 absorbs G/H/I into permanent domain memory
↓
domain checkpoints regenerate
↓
Main reconciles 00/05/06 and next-session direction
↓
Git/GitHub persistence
~~~

Ordinary stage behavior:

- A/B/C describe one bounded functional assessment.
- D/E/F are controlling instructions, not exploratory drafts.
- G/H/I report what physically happened.
- permanent memory changes only through classification and promotion.
- J is optional unless cross-domain contradiction, accumulated context, or explicit Main reconciliation requires it.

Exit conditions:

- implementation is validated or precisely classified as blocked/host-unvalidated;
- G/H/I match the materialized scope;
- permanent memory is reconciled;
- checkpoints and Main continuity expose one current state;
- residual work is explicitly deferred or staged.

Ordinary failure conditions:

- repeated rounds are needed to discover the problem;
- D/E/F cannot be made controlling without unresolved product or architecture decisions;
- permanent memory is too stale to support a reliable stage;
- evidence ownership remains contradictory.

When any failure condition holds, transition explicitly to FLX-INV-02, FLX-PRN-03, or FLX-PRM-04.

Localized prompt route:

~~~text
PROMPT_COLLECTION: SEQ-ORD-01
FLUX: FLX-SEQ-00 + FLX-ORD-01
PROMOTION_RULES: PRC-01
~~~

## 13.3 Investigative Sequence — FLX-INV-02

Purpose:

Support repeated, sequential domain investigation when repository truth, product direction, architecture, vocabulary, and operational evidence must be confronted several times before implementation authority is safe.

The sequence is cumulative but must become cheaper and more precise each round.

Entry conditions:

- Main defines the investigation question and expected decision boundary;
- branch, baseline, round identifier, and repository scope are explicit;
- A/B/C, active J, and D/E/F have declared round semantics;
- D/E/F remain provisional unless a later activation explicitly freezes them;
- Codex, source mutation, promotion, and permanent-memory mutation remain inactive during exploration.

Round protocol:

~~~text
Main publishes the current question and recovery pointers
↓
O/A/D read:
    latest relevant J reconciliation
    paired D/E/F cache
    paired checkpoint
    preceding paired A/B/C round
↓
O/A/D inspect repository truth for the new question
↓
O/A/D append a delta round to A/B/C
↓
Main reads the newest A/B/C deltas
↓
Main appends a grouped reconciliation to J
↓
Main compresses active domain conclusions and next questions into provisional D/E/F
↓
Main reads latest A/B/C + J + D/E/F as one investigation cache
↓
Main publishes the narrower next round
↓
repeat
~~~

A/B/C contract:

- append one marked round;
- lead with newly inspected evidence and corrections;
- preserve prior rounds by reference rather than repetition;
- identify retained, corrected, superseded, contradicted, unresolved, prospective, and deferred claims;
- tie material claims to paths, symbols, tests, commands, or named evidence;
- read the latest J reconciliation before repository exploration;
- confront the paired D/E/F cache before recommending the next route.

J contract:

- reconcile, group, and compress rather than copy A/B/C;
- preserve domain provenance and disagreement;
- maintain one current structural model for the round;
- classify every conclusion;
- name decisions Main cannot infer;
- transfer active domain-specific cache into D/E/F so J does not become the only usable working memory;
- preserve prior J history through marked reconciliation sections until an authorized refresh replaces the active cache.

D/E/F investigative contract:

- remain explicitly PROVISIONAL — NOT AUTHORIZED FOR CODEX;
- hold the smallest useful domain cache for the next round;
- record retained, corrected, superseded, rejected, and new material;
- expose evidence still requested;
- separate schema-free, schema-bearing, dependency-bearing, host, and human-decision work;
- end with the next paired-domain questions and stop conditions.

Performance-improvement rule:

Every new round must reduce at least one of:

- unresolved ambiguity;
- repository surfaces not yet indexed;
- duplicated stage prose;
- unclassified contradiction;
- unknown dependency/schema consequence;
- unbounded validation scope;
- human decisions Main cannot yet formulate precisely.

A round that only restates prior content is invalid.

Implementation activation gate:

FLX-INV-02 does not authorize Codex.

To exit toward implementation, Main and the human must:

1. identify the controlling findings;
2. classify or carry every contradiction;
3. freeze exact D/E/F sections;
4. mark superseded provisional sections;
5. name writable and prohibited files;
6. define validation, rollback, and stop conditions;
7. state ACTIVE — CODEX IMPLEMENTATION AUTHORIZED;
8. transition explicitly to FLX-ORD-01 at the Codex/materialization boundary.

Other exits:

- use FLX-PRM-04 when findings should become permanent without source work;
- use FLX-PRN-03 when accumulated memory needs restructuring;
- close with an observational record when the investigation produces no accepted change.

Localized prompt route:

~~~text
PROMPT_COLLECTION: SEQ-INV-02
Concrete investigative prompts:
    ERI-01
    FCA-02
    MJR-03
    MDE-04
FLUX: FLX-SEQ-00 + FLX-INV-02
PROMOTION_RULES: PRC-01
~~~

## 13.4 Pruning Sequence — FLX-PRN-03

Purpose:

Restore recovery quality by sorting, parsing, pruning, regenerating, and restructuring existing permanent memory without silently inventing new project truth.

Pruning is semantic maintenance, not deletion for brevity.

Entry conditions:

- recovery drift, duplicate ownership, stale derivatives, disordered canon, or checkpoint inflation is evidenced;
- Main defines domain scope and protected history;
- the sequence states whether each file is canonical, derived, checkpoint, observational, Main continuity, or stage;
- no source implementation is implied.

Domain protocol:

~~~text
recover checkpoint as an entry hypothesis
↓
inspect canonical owner and relevant evidence
↓
inspect derived document for stale or duplicate material
↓
inspect observational history only as needed
↓
classify keep / move-by-meaning / summarize / reference / regenerate / correct
↓
reconcile and restructure canon without changing unapproved meaning
↓
regenerate and improve derived documents
↓
preserve or append observational history
↓
regenerate the checkpoint last
↓
report ownership changes, removals, references, and unresolved promotion questions
~~~

Canonical maintenance:

- sort and parse stable knowledge by responsibility;
- consolidate duplicate canonical ownership under one owner;
- preserve accepted meaning and traceable corrections;
- do not convert proposals or observations into canon;
- do not rewrite canon merely to match a derived summary;
- report any semantic change that requires FLX-PRM-04.

Derived maintenance:

- regenerate from accepted canon and current unresolved work;
- remove stale statements and duplicate explanation;
- improve indexing, headings, references, and recovery order;
- enhance clarity without creating independent truth;
- prefer reference to repeated authority-bearing prose.

Observational maintenance:

- preserve chronology;
- append a pruning/reconciliation event when useful;
- correct factual error explicitly rather than silently rewriting history;
- never use an observational file as the new current-state owner.

Checkpoint regeneration:

- occurs last;
- represents current state after canon and derivatives are reconciled;
- remains compact and points to deeper owners;
- contains one unambiguous present-state segment;
- does not preserve full rationale or chronology.

Main continuity:

After domain pruning, Main may refresh 00_PROJECT_STATE and 06_SESSION_SCHEME and append the event to 05_SESSION_LOG. Main-root files summarize; they do not replace domain ownership.

Pruning report requirements:

- files read and changed;
- semantic role of each file;
- canonical owner decisions;
- content pruned or converted to reference;
- derived sections regenerated;
- history preserved or corrected;
- checkpoint line count and recovery pointers;
- claims requiring FLX-PRM-04;
- no-change files and reason;
- next sequence.

Exit conditions:

- each stable meaning has one canonical owner;
- derivatives can be regenerated from named owners;
- checkpoints recover current state cheaply;
- history remains traceable;
- unresolved semantic changes are routed to FLX-PRM-04.

Localized prompt route:

~~~text
PROMPT_COLLECTION: SEQ-PRN-03
FLUX: FLX-SEQ-00 + FLX-PRN-03
PROMOTION_RULES: PRC-01 + targeted reconciliation rules when ownership changes
~~~

## 13.5 Promotion/Reconciliation Sequence — FLX-PRM-04

Purpose:

Change the semantic state of knowledge deliberately and reconcile it across domain, file role, implementation evidence, and Main continuity.

This sequence operationalizes PROMOTION_RULES.md. FLUX controls route and authority; PROMOTION_RULES controls meaning.

Entry sources may include:

- Ordinary Sequence G/H/I evidence;
- frozen Investigative Sequence findings;
- Pruning Sequence ownership conflicts;
- direct human decisions;
- repository drift;
- methodology refinement evidence.

Protocol:

~~~text
state the candidate claim
↓
read PRC-01
↓
identify evidence and confidence
↓
identify one semantic owner
↓
classify current state and target state
↓
check contradictions and history
↓
choose canonical / derived / checkpoint / observational destination
↓
apply domain-specific reconciliation
↓
regenerate derivatives
↓
refresh checkpoint last
↓
reconcile Main continuity when global state changed
↓
audit that materialization and promotion remain distinct
~~~

Hard gates:

- conversation is not persistence;
- stage is not canon;
- G/H/I is evidence, not canon;
- implementation does not prove validation;
- validation does not prove learner maturity;
- Main preference does not prove acceptance;
- derived and checkpoint files cannot create truth;
- observational files do not define current truth;
- canonical ownership is unique;
- cross-domain repetition must be perspectival;
- corrections preserve history;
- blocked, deferred, host-unvalidated, and unresolved claims are not promoted as accepted or validated.

Domain order for full permanent reconciliation:

1. Observational — preserve what happened.
2. Canonical — accept or correct stable truth.
3. Derived — regenerate explanation or action views.
4. Checkpoint — regenerate compact present state.
5. Main continuity — summarize cross-domain truth when required.

A promotion may validly produce no canonical change.

Exit conditions:

- claim state and evidence are explicit;
- semantic owner is unique;
- destination role is correct;
- derivative/checkpoint content agrees with canon;
- history and disagreement remain recoverable;
- global continuity is refreshed only when affected.

Localized prompt route:

~~~text
PROMPT_COLLECTION: SEQ-PRM-04
Compatible concrete prompts:
    PDR2-00
    PDR2-O
    PDR2-A
    PDR2-D
FLUX: FLX-SEQ-00 + FLX-PRM-04
PROMOTION_RULES: PRC-01, then targeted deeper sections only when required
~~~

## 13.6 Sequence Handoff Envelope

Every transition should publish a compact envelope:

~~~text
Sequence:
Role:
Round or unit:
Branch:
Baseline / inspected HEAD:
Question or accepted objective:
Inputs read:
New evidence:
Current claim states:
Contradictions:
Writable surfaces:
Prohibited surfaces:
Authority:
Next sequence:
Next prompt:
Stop condition:
~~~

This envelope is a cache boundary. It should point to detailed evidence rather than reproduce it.

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

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
