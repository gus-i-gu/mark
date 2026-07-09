# FLUX.md

> Version: 0.3
> Status: Draft
> Persistence Class: Canonical / Operational
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Sketch Notebook routing, staging, write authority, materialization flow, and Codex report feedback

---

# 1. Purpose

`FLUX.md` defines the operational routing of information between the Main Chat, the functional chats, Codex CLI, GitHub, VS Code, and the Sketch Notebook.

Its purpose is to prevent:

* uncontrolled edits;
* duplicated writes;
* path drift;
* premature promotion;
* undocumented materialization;
* loss of implementation evidence;
* overloading Main Chat or Codex with unsuitable documentation responsibilities.

`FLUX.md` answers one primary question:

> Which actor may read, write, stage, materialize, or report which project knowledge, and through which path?

Semantic maturity is defined by `PROMOTION_RULES.md`.

Operational routing is defined here.

---

# 2. Canonical Notebook Root

The canonical Sketch Notebook root is:

```text
documentation/sketch_notebook/
```

All notebook files, methodology files, stage files, and permanent project-memory files must live under this root.

The following path is invalid for Sketch Notebook material:

```text
app/documentation/sketch_notebook/
```

No chat, Codex task, or manual update should create or maintain Sketch Notebook files under `app/documentation/`.

---

# 3. Conversational Actors

The Sketch Notebook workflow uses the following actors.

## 3.1 Main Chat

The Main Chat coordinates the system as a whole.

It performs synthesis, compares functional reports, prepares Codex-ready materialization instructions, checks consistency between project state and notebook state, and updates global project continuity files.

Main Chat is responsible for global coherence.

## 3.2 Functional Chats

The functional chats are:

* Operational Chat;
* Didactic Chat;
* Design Chat.

Functional chats analyze the project from their own domain perspective.

They stage active reports into `DEV_STAGE/ A_OPERATIONAL` , `DEV_STAGE/B_DIDACTIC`, and `DEV_STAGE/C_DESIGN`.

After Codex materialization reports exist, functional chats also extract relevant information from Codex report stages into their own permanent domain folders.

Functional chats are responsible for domain memory.

## 3.3 Codex

Codex is the materialization agent.

Codex reads Main-approved materialization stages, applies repository changes, runs validation when instructed, and reports what actually happened.

Codex should not decide semantic promotion.

Codex should not invent methodology.

Codex reports evidence.

## 3.4 Human / VS Code

The human developer and VS Code provide inspection, review, manual verification, and final acceptance.

Human supervision remains responsible for accepting, rejecting, redirecting, or correcting materialized changes.

---

# 4. DEV_STAGE

`DEV_STAGE` is the staging area of the Sketch Notebook.

Canonical path:

```text
documentation/sketch_notebook/DEV_STAGE/
```

`DEV_STAGE` contains three groups of files.

## 4.1 Functional Stage Files

Functional chats write these files:

```text
A_OPERATIONAL.md
B_DIDACTIC.md
C_DESIGN.md
```

Purpose:

* capture current operational, didactic, and design reasoning;
* prepare domain-specific material for Main synthesis;
* avoid losing functional analysis inside transient conversation.

## 4.2 Main Materialization Stage Files

Main Chat writes these files:

```text
D_OPS_STAGE.md
E_DDC_STAGE.md
F_DSN_STAGE.md
```

Purpose:

* transform functional reports into Codex-ready instructions;
* specify application changes;
* specify notebook changes;
* identify validation requirements;
* preserve Main-approved implementation direction.

## 4.3 Codex Report Stage Files

Codex writes these files after materialization:

```text
G_OPS_CODEX.md
H_DDC_CODEX.md
I_DSN_CODEX.md
```

Purpose:

* report what Codex actually changed;
* report what Codex did not or could not change;
* report validation commands and results;
* expose implementation evidence for functional chats and Main Chat;
* provide raw material for operational, didactic, and design permanent memory.

Codex report stages are not canonical.

They are observational evidence.

---

# 5. Permanent Domain Folders

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

## 5.1 operational/

The operational folder stores execution-oriented project memory.

Examples:

```text
04_TODO.md
10_ACTIONS.md
11_OPERATIONAL_TRACKRECORD.md
```

Recommended responsibility:

* `04_TODO.md`: stable backlog, not currently being executed;
* `10_ACTIONS.md`: active or upcoming operational actions;
* `11_OPERATIONAL_TRACKRECORD.md`: append-only observational record of materialized actions, commands, validation results, failures, and operational outcomes.

## 5.2 didactics/

The didactics folder stores learning-oriented project memory.

Examples:

```text
02_KANBAN.md
07_GLOSSARY.md
08_CONCEPT_MAP.md
```

Recommended responsibility:

* `02_KANBAN.md`: canonical register of learned concepts;
* `07_GLOSSARY.md`: persistent derivative glossary generated from KANBAN and methodology vocabulary;
* `08_CONCEPT_MAP.md`: refreshed checkpoint of current learning state, dependencies, unstable concepts, and next study direction.

## 5.3 design/

The design folder stores architecture-oriented project memory.

It should preserve:

* domain model decisions;
* responsibility boundaries;
* architectural decisions;
* UI responsibility decisions;
* relationship diagrams;
* design rationale;
* deferred design questions.

The exact file naming may evolve, but design knowledge should not remain only in stage files.

## 5.4 methodology/

The methodology folder stores the rules of the Sketch Notebook Method itself.

Only explicit methodological work should modify this folder.

Codex must not modify methodology unless Main Chat explicitly instructs it to do so.

---

# 6. Write Authority

## 6.1 Functional Chat Active Stage Authority

During active functional staging, each functional chat writes only its assigned A/B/C stage file.

| Chat             | Active stage file                                          |
| ---------------- | ---------------------------------------------------------- |
| Operational Chat | `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md` |
| Didactic Chat    | `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`    |
| Design Chat      | `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`      |

During this phase, functional chats must not edit:

* application source files;
* methodology files;
* Main stage files;
* Codex report files;
* other functional stage files.

## 6.2 Functional Chat Domain Memory Authority

After Codex report files G/H/I exist, functional chats may update their own permanent domain folders.

| Chat             | May read         | May update                                   |
| ---------------- | ---------------- | -------------------------------------------- |
| Operational Chat | `G_OPS_CODEX.md` | `documentation/sketch_notebook/operational/` |
| Didactic Chat    | `H_DDC_CODEX.md` | `documentation/sketch_notebook/didactics/`   |
| Design Chat      | `I_DSN_CODEX.md` | `documentation/sketch_notebook/design/`      |

This authority is limited to extracting, classifying, and reconciling Codex-reported evidence into the chat's own domain memory.

Functional chats must separate:

* observational records;
* canonical knowledge;
* derived knowledge.

Functional chats must not write outside their own domain folders.

Functional chats must not edit methodology files.

Functional chats must not edit application source files.

## 6.3 Main Chat Authority

Main Chat may write:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Main Chat may also update global project continuity files, including:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
```

Main Chat checks whether functional domain folders remain consistent with:

* A/B/C functional reports;
* D/E/F materialization stages;
* G/H/I Codex reports;
* source code state;
* human direction.

Main Chat is responsible for reporting consistency, drift, and unresolved contradictions into `05_SESSION_LOG.md`.

## 6.4 Codex Authority

Codex reads:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Codex may edit:

* application source files;
* permanent notebook files explicitly named in D/E/F;
* domain folders explicitly named in D/E/F;
* methodology files only if D/E/F explicitly authorize methodology modification.

Codex writes post-materialization reports to:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex must report:

* files changed;
* files created;
* files deleted;
* commands run;
* validation results;
* skipped instructions;
* failed instructions;
* unresolved risks;
* documentation updates performed;
* documentation updates not performed.

Codex reports are not canonical knowledge.

They are evidence for later reconciliation.

---

# 7. Knowledge Classes and Routing

`FLUX.md` uses the knowledge classes defined by `PROMOTION_RULES.md`.

## 7.1 Functional Stage

A/B/C files are functional stage material.

They are working reports.

They are not canonical.

## 7.2 Main Materialization Stage

D/E/F files are Main-approved materialization instructions.

They are not final memory.

They are the instruction layer before physical change.

## 7.3 Codex Report Stage

G/H/I files are post-materialization reports.

They are observational evidence.

They are not canonical.

## 7.4 Canonical Knowledge

Canonical knowledge belongs in permanent domain files when validated and accepted.

Examples:

* KANBAN concept entries;
* architectural decisions;
* stable operational runbooks;
* methodology rules.

## 7.5 Derived Knowledge

Derived knowledge summarizes or reorganizes canonical knowledge.

Examples:

* glossary;
* concept map;
* project state snapshot.

Derived knowledge must not create independent truth.

## 7.6 Observational Records

Observational records preserve what happened.

Examples:

* operational track record;
* session log;
* Codex execution report.

Observational records should be append-only unless explicitly corrected by Main Chat.

---

# 8. Standard Flow

The standard workflow is:

```text
Human prompt
↓
Functional chats boot from INDEX + methodology + their domain folder
↓
Functional chats read G/H/I if relevant and present
↓
Functional chats write A/B/C active stage reports
↓
Main Chat reads A/B/C + human prompt + domain folders
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
Main Chat reads domain folders + G/H/I + 00_PROJECT_STATE + 05_SESSION_LOG
↓
Main Chat checks consistency and records drift/resolution in 05_SESSION_LOG
↓
Git/GitHub persistence
↓
Next session boots from improved project memory
```

This flow separates:

* intention;
* synthesis;
* materialization;
* evidence;
* domain memory;
* global continuity.

---

# 9. Functional Chat Post-Codex Duties

After Codex reports are available, each functional chat has a second-message duty.

## 9.1 Operational Chat Post-Codex Duty

Operational Chat reads:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
```

Then it updates operational memory as appropriate.

Required classification:

```text
historical / observational
canonical operational knowledge
derived operational view
active action
future TODO
```

Typical targets:

```text
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/operational/10_ACTIONS.md
documentation/sketch_notebook/operational/11_OPERATIONAL_TRACKRECORD.md
```

## 9.2 Didactic Chat Post-Codex Duty

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
```

Typical targets:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

## 9.3 Design Chat Post-Codex Duty

Design Chat reads:

```text
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Then it updates design memory as appropriate.

Required classification:

```text
canonical design decision
architectural observation
deferred design question
derived architecture summary
implementation drift
```

Typical targets:

```text
documentation/sketch_notebook/design/
```

---

# 10. Main Chat Continuity Duties

Main Chat is not the primary writer of domain memory after G/H/I exist.

That responsibility belongs to the functional chats.

Main Chat is responsible for global coherence.

Main Chat should check:

* whether `00_PROJECT_STATE.md` reflects the current state;
* whether `05_SESSION_LOG.md` records the session;
* whether operational, didactic, and design folders agree with each other;
* whether Codex reports contradict the intended D/E/F stages;
* whether permanent domain memory contradicts source code state;
* whether derived files drift from canonical files.

Main Chat records consistency checks, drift, unresolved contradictions, and accepted reconciliations in:

```text
documentation/sketch_notebook/05_SESSION_LOG.md
```

Main Chat may update:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
```

when a project-state change is validated.

---

# 11. Naming Rules

Chats must never invent staging filenames.

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

Invalid older names include:

```text
DEV_TRACK/
B_DIDACTICS.md
02_DIDACTICS.md
app/documentation/sketch_notebook/*
```

These names may appear in historical context, but they are not canonical.

---

# 12. Commit Rules

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
```

Codex materialization commits may include multiple files, but only according to Main-approved stage instructions.

Codex report commits should include:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

---

# 13. Failure Rules

An update is invalid if:

* a chat writes outside its authority;
* a chat writes under `app/documentation/sketch_notebook/`;
* a chat invents a staging filename;
* Codex modifies methodology without explicit Main instruction;
* Codex materializes source changes not supported by D/E/F;
* functional chats modify application source code;
* functional chats write into another functional domain folder;
* derived files introduce truth not present in canonical files;
* observational records are rewritten as if they were canonical truth.

Main Chat must inspect invalid updates, recover useful content if necessary, and restore canonical routing.

---

# 14. Summary

Functional chats stage active reasoning in A/B/C.

Main Chat synthesizes and writes D/E/F.

Codex materializes and reports through G/H/I.

Functional chats extract Codex reports into their own permanent domain folders.

Main Chat checks global continuity through `00_PROJECT_STATE.md` and `05_SESSION_LOG.md`.

The canonical notebook root is always:

```text
documentation/sketch_notebook/
```

The staging folder is always:

```text
documentation/sketch_notebook/DEV_STAGE/
```

The goal of FLUX is not only to move information forward.

The goal is to preserve evidence, responsibility, and learning without confusing stage, synthesis, materialization, report, canonical memory, derivative memory, and historical record.
