# INDEX.md

> Version: 0.2
> Status: Draft
> Persistence Class: Derived / Navigational
> Knowledge Class: Navigational
> Authority: Main Chat
> Scope: Sketch Notebook navigation, bootstrap routing, and project-memory map

---

# 1. Purpose

`INDEX.md` is the navigation entrypoint for the Sketch Notebook.

Every chat, agent, or human reviewer should begin here before exploring the rest of the notebook.

Its purpose is to expose:

* the canonical notebook root;
* the methodology boot order;
* the project-memory structure;
* the domain checkpoint entry points;
* the DEV_STAGE routing surface;
* the relationship between methodology, project memory, and repository implementation.

This file is a map.

It is not the primary source of canonical truth.

If a rule is needed, consult the methodology file that owns the rule.

---

# 2. Canonical Notebook Root

The canonical Sketch Notebook root is:

```text
documentation/sketch_notebook/
```

Invalid notebook roots include:

```text
app/documentation/sketch_notebook/
```

Sketch Notebook material must not be created under `app/documentation/`, adjacent repositories, misplaced folders, or alternative notebook roots.

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

* a role’s reasoning perspective is unclear;
* a new role is introduced;
* the conversational system itself is being revised;
* a role behaves inconsistently with its intended perspective.

`METHOD_GLOSSARY.md` should be consulted when methodology vocabulary is unclear.

---

# 4. Methodology Files

Canonical methodology files:

```text
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
documentation/sketch_notebook/methodology/METHOD_GLOSSARY.md
```

Responsibilities:

| File                    | Primary responsibility                                                                              |
| ----------------------- | --------------------------------------------------------------------------------------------------- |
| `METHOD_FOUNDATIONS.md` | What the Sketch Notebook Method is                                                                  |
| `FLUX.md`               | How information is routed, staged, written, materialized, reported, recovered, created, and renamed |
| `PROMOTION_RULES.md`    | How knowledge changes semantic state                                                                |
| `CHAT_PROTOCOL.md`      | How each role communicates and structures output                                                    |
| `CHAT_BEHAVIOUR.md`     | How each role reasons from its perspective                                                          |
| `METHOD_GLOSSARY.md`    | What methodology-specific terms mean                                                                |

Methodology files are protected.

They should be modified only during explicit methodological work under Main Chat and human supervision.

---

# 5. Project-Memory Layers

The Sketch Notebook separates three broad layers.

```text
Methodology
    defines the method

Project Memory
    stores interpreted project knowledge

Repository Implementation
    stores source code and materialized files
```

The repository may show what exists.

The notebook should explain what it means.

When possible, project state should be recovered from notebook memory before reading source files.

Repository inspection is used when implementation truth is uncertain, source files are directly relevant, or notebook drift is suspected.

---

# 6. Hierarchical Recovery

The standard recovery order is:

```text
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

This is a cost discipline.

A role should not consume full canonical registers, historical logs, or source files when the relevant checkpoint already answers the task.

A role may inspect deeper sources when:

* the checkpoint is empty;
* the checkpoint is stale;
* the checkpoint is insufficient;
* notebook drift is suspected;
* implementation truth is uncertain;
* source files are the direct subject of the task;
* materialization must be validated.

---

# 7. Top-Level Structure

```text
documentation/sketch_notebook/
│
├── INDEX.md
│
├── 00_PROJECT_STATE.md
├── 05_SESSION_LOG.md
│
├── methodology/
│   ├── METHOD_FOUNDATIONS.md
│   ├── FLUX.md
│   ├── PROMOTION_RULES.md
│   ├── CHAT_PROTOCOL.md
│   ├── CHAT_BEHAVIOUR.md
│   └── METHOD_GLOSSARY.md
│
├── DEV_STAGE/
│   ├── A_OPERATIONAL.md
│   ├── B_DIDACTIC.md
│   ├── C_DESIGN.md
│   ├── D_OPS_STAGE.md
│   ├── E_DDC_STAGE.md
│   ├── F_DSN_STAGE.md
│   ├── G_OPS_CODEX.md
│   ├── H_DDC_CODEX.md
│   └── I_DSN_CODEX.md
│
├── operational/
│   ├── 04_TODO.md
│   ├── 10_OPERATIONAL_STATE.md
│   ├── 11_OPERATIONAL_RECORD.md
│   └── 12_OPERATIONAL_MODEL.md
│
├── didactics/
│   ├── 02_KANBAN.md
│   ├── 07_GLOSSARY.md
│   ├── 08_CONCEPT_MAP.md
│   └── 13_LECTURE_REGISTER.md
│
└── design/
    ├── 01_ARCHITECTURE.md
    ├── 03_DECISION_LOG.md
    ├── 09_DESIGN_STATE.md
    └── 14_MODEL_OVERVIEW.md
```

---

# 8. Global Coordination Files

## 00_PROJECT_STATE.md

Global project-state checkpoint.

It should expose the current high-level state of the project.

Main Chat owns its coherence.

## 05_SESSION_LOG.md

Global observational session record.

It should preserve session-level drift, reconciliation, accepted direction, and important continuity notes.

Main Chat owns its coherence.

---

# 9. Domain Checkpoints

Low-token domain entry points:

| Domain      | Checkpoint                                                          |
| ----------- | ------------------------------------------------------------------- |
| Operational | `documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md` |
| Didactic    | `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`         |
| Design      | `documentation/sketch_notebook/design/09_DESIGN_STATE.md`           |

These files should be read before deeper domain files when recovering state.

A checkpoint should summarize current state.

It should not become a canonical register.

It should not become a historical log.

---

# 10. Domain Symmetry Files

Each functional domain exposes four semantic roles:

```text
Canonical Knowledge
Derived Knowledge
Domain Checkpoint
Observational History
```

## operational/

| Role                            | File                       |
| ------------------------------- | -------------------------- |
| Derived operational knowledge   | `04_TODO.md`               |
| Domain checkpoint               | `10_OPERATIONAL_STATE.md`  |
| Observational history           | `11_OPERATIONAL_RECORD.md` |
| Canonical operational knowledge | `12_OPERATIONAL_MODEL.md`  |

## didactics/

| Role                           | File                     |
| ------------------------------ | ------------------------ |
| Canonical didactic knowledge   | `02_KANBAN.md`           |
| Derived didactic knowledge     | `07_GLOSSARY.md`         |
| Domain checkpoint              | `08_CONCEPT_MAP.md`      |
| Observational learning history | `13_LECTURE_REGISTER.md` |

## design/

| Role                         | File                   |
| ---------------------------- | ---------------------- |
| Canonical design knowledge   | `01_ARCHITECTURE.md`   |
| Observational design history | `03_DECISION_LOG.md`   |
| Domain checkpoint            | `09_DESIGN_STATE.md`   |
| Derived design knowledge     | `14_MODEL_OVERVIEW.md` |

---

# 11. DEV_STAGE Routing

`DEV_STAGE/` contains three groups.

## Functional stage files

Functional chats write active stage reports:

```text
A_OPERATIONAL.md
B_DIDACTIC.md
C_DESIGN.md
```

## Main materialization stage files

Main Chat writes Codex-ready materialization instructions:

```text
D_OPS_STAGE.md
E_DDC_STAGE.md
F_DSN_STAGE.md
```

## Codex report stage files

Codex writes post-materialization evidence:

```text
G_OPS_CODEX.md
H_DDC_CODEX.md
I_DSN_CODEX.md
```

Codex reports are evidence.

They are not canonical truth.

---

# 12. Role Routing Summary

| Role             | First recovery surface                     | Active stage                 | Post-Codex report          | Permanent domain      |
| ---------------- | ------------------------------------------ | ---------------------------- | -------------------------- | --------------------- |
| Operational Chat | `operational/10_OPERATIONAL_STATE.md`      | `DEV_STAGE/A_OPERATIONAL.md` | `DEV_STAGE/G_OPS_CODEX.md` | `operational/`        |
| Didactic Chat    | `didactics/08_CONCEPT_MAP.md`              | `DEV_STAGE/B_DIDACTIC.md`    | `DEV_STAGE/H_DDC_CODEX.md` | `didactics/`          |
| Design Chat      | `design/09_DESIGN_STATE.md`                | `DEV_STAGE/C_DESIGN.md`      | `DEV_STAGE/I_DSN_CODEX.md` | `design/`             |
| Main Chat        | `00_PROJECT_STATE.md` + domain checkpoints | `DEV_STAGE/D/E/F`            | `DEV_STAGE/G/H/I`          | global coherence      |
| Codex            | `AGENTS.md` + `INDEX.md` + D/E/F           | materialization only         | `DEV_STAGE/G/H/I`          | no semantic promotion |

---

# 13. Functional Chat Route

Functional chats should follow this route:

```text
INDEX
↓
methodology boot
↓
domain checkpoint
↓
canonical / derived / observational files only as needed
↓
repository inspection only when required
↓
assigned A/B/C stage file
```

After Codex reports exist:

```text
G/H/I report
↓
domain classification
↓
domain memory update
↓
checkpoint refresh
```

Functional chats must follow `FLUX.md` for exact write authority.

---

# 14. Main Chat Route

Main Chat should follow this route:

```text
INDEX
↓
methodology boot
↓
00_PROJECT_STATE.md
↓
domain checkpoints
↓
A/B/C functional reports
↓
deeper domain files only as needed
↓
D/E/F materialization stages
```

After materialization:

```text
G/H/I reports
↓
domain checkpoints
↓
00_PROJECT_STATE.md
↓
05_SESSION_LOG.md
↓
reconciliation
```

Main Chat checks global coherence.

---

# 15. Codex Route

Codex should begin from:

```text
AGENTS.md
↓
documentation/sketch_notebook/INDEX.md
↓
methodology boot as required
↓
D/E/F Main-approved materialization stages
```

Codex materializes.

Codex reports evidence into:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex should not independently promote knowledge.

Codex should not create or rename Sketch Notebook files unless explicitly authorized by Main Chat under human-supervised methodological revision or explicitly instructed in D/E/F according to `FLUX.md`.

---

# 16. File Creation and Rename Guardrail

No chat, Codex task, automated tool, or manual update should create new files directly under:

```text
documentation/sketch_notebook/
```

unless explicitly authorized by Main Chat under human-supervised methodological revision.

Files must not be renamed except by Main Chat under human-supervised methodological revision.

File creation and renaming require a coherence check against:

* `INDEX.md`;
* `FLUX.md`;
* relevant domain checkpoints;
* affected prompts;
* affected materialization instructions;
* affected references.

This rule prevents data fragmentation, path drift, and data loss during pruning.

---

# 17. Invalid Older Names

Invalid or deprecated names include:

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

# 18. Navigation Summary

Start here:

```text
documentation/sketch_notebook/INDEX.md
```

Then read methodology in this order:

```text
METHOD_FOUNDATIONS.md
FLUX.md
PROMOTION_RULES.md
CHAT_PROTOCOL.md
```

Then recover from the appropriate checkpoint:

```text
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

Then inspect deeper domain memory only if needed.

Then inspect repository implementation only if needed.

The goal is not to read everything.

The goal is to recover the project state correctly with the least sufficient context.
