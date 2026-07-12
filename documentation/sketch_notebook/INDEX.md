# INDEX.md

> Version: 0.5
> Status: Draft
> Persistence Class: Derived / Navigational
> Knowledge Class: Navigational
> Authority: Main Chat
> Scope: Sketch Notebook navigation, bootstrap routing, root-tree map, and recovery entrypoints

---

# 1. Purpose

`INDEX.md` is the navigation entrypoint for the Sketch Notebook.

Every chat, agent, or human reviewer should begin here before exploring the rest of the notebook.

Its purpose is to expose:

- the canonical notebook root;
- the methodology boot order;
- the complete Sketch Notebook root tree;
- Main-root continuity files;
- methodology files;
- domain checkpoint entry points;
- DEV_STAGE routing;
- `[M]_STAGE` routing;
- temporary methodology sprint files;
- the relationship between methodology, project memory, staging, and repository implementation.

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

- a role’s reasoning perspective is unclear;
- a new role is introduced;
- the conversational system itself is being revised;
- a role behaves inconsistently with its intended perspective.

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

| File | Primary responsibility |
| --- | --- |
| `METHOD_FOUNDATIONS.md` | What the Sketch Notebook Method is |
| `FLUX.md` | How information is routed, staged, written, materialized, reported, recovered, created, renamed, and controlled for recovery economy |
| `PROMOTION_RULES.md` | How knowledge changes semantic state and how reconciliation prevents duplicate semantic ownership |
| `CHAT_PROTOCOL.md` | How each role communicates and structures output |
| `CHAT_BEHAVIOUR.md` | How each role reasons from its perspective |
| `METHOD_GLOSSARY.md` | What methodology-specific terms mean |

Methodology files are protected.

They should be modified only during explicit methodological work under Main Chat and human supervision.

---

# 5. Project-Memory Layers

The Sketch Notebook separates four broad navigation layers.

```text
Methodology
    defines the method

Main-Root Continuity
    stores global current state, session history, and next-session recovery frame

Domain Memory
    stores interpreted operational, didactic, and design knowledge

Staging Surfaces
    store active reports, materialization instructions, Codex evidence, and Main methodology-stage work
```

Repository implementation remains outside the notebook layer.

The repository may show what exists.

The notebook should explain what it means.

When possible, project state should be recovered from notebook memory before reading source files.

Repository inspection is used when implementation truth is uncertain, source files are directly relevant, or notebook drift is suspected.

---

# 6. Hierarchical Recovery

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

This is a cost discipline.

A role should not consume full canonical registers, historical logs, or source files when the relevant Main-root file or domain checkpoint already answers the task.

A role may inspect deeper sources when:

- the checkpoint is empty;
- the checkpoint is stale;
- the checkpoint is insufficient;
- notebook drift is suspected;
- implementation truth is uncertain;
- source files are the direct subject of the task;
- materialization must be validated;
- the task is methodology revision;
- structural routing is under review.

---

# 7. Complete Sketch Notebook Root Structure

Current root structure:

```text
documentation/sketch_notebook/
│
├── INDEX.md
│
├── 00_PROJECT_STATE.md
├── 05_SESSION_LOG.md
├── 06_SESSION_SCHEME.md
├── PROVISORY_[M]_DOUBLE_LAB.MD
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
├── [M]_STAGE/
│   └── J_MAIN_STAGE.md
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

`PROVISORY_[M]_DOUBLE_LAB.MD` is listed because it currently exists as a temporary methodology sprint file.

It is not canonical methodology.

Its disposition should be resolved by methodology sprint closure.

---

# 8. Main-Root Continuity Files

Main-root continuity files live directly under:

```text
documentation/sketch_notebook/
```

They coordinate global recovery, session closure, and next-session preparation.

They are not functional domain files.

They are not methodology files.

They are not DEV_STAGE files.

## 8.1 00_PROJECT_STATE.md

`00_PROJECT_STATE.md` is the Global State Canon-Checkpoint.

It should expose the accepted current high-level state of the project while remaining concise enough for fast recovery.

Main Chat owns its coherence.

## 8.2 05_SESSION_LOG.md

`05_SESSION_LOG.md` is the Global Observational History.

It preserves session-level drift, reconciliation, accepted direction, closure notes, and important continuity evidence.

Main Chat owns its coherence.

## 8.3 06_SESSION_SCHEME.md

`06_SESSION_SCHEME.md` is the Forward Checkpoint.

It prepares the next session by recording next-session focus, expected files to inspect, unresolved decisions, deferred work, exit criteria, and recovery warnings.

Main Chat owns its coherence.

---

# 9. Main-Root Continuity Flow

Main-root continuity follows a disjunct flux protocol.

It coordinates global session closure without replacing functional domain promotion.

Typical closure flow:

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

Main-root files summarize or preserve global continuity.

They must not duplicate full operational, didactic, or design domain truth.

---

# 10. Domain Checkpoints

Low-token domain entry points:

| Domain | Checkpoint |
| --- | --- |
| Operational | `documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md` |
| Didactic | `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md` |
| Design | `documentation/sketch_notebook/design/09_DESIGN_STATE.md` |

These files should be read before deeper domain files when recovering state.

A checkpoint should summarize current state.

It should not become a canonical register.

It should not become a historical log.

---

# 11. Domain Symmetry Files

Each functional domain exposes four semantic roles:

```text
Canonical Knowledge
Derived Knowledge
Domain Checkpoint
Observational History
```

## operational/

| Role | File |
| --- | --- |
| Derived operational knowledge | `04_TODO.md` |
| Domain checkpoint | `10_OPERATIONAL_STATE.md` |
| Observational history | `11_OPERATIONAL_RECORD.md` |
| Canonical operational knowledge | `12_OPERATIONAL_MODEL.md` |

## didactics/

| Role | File |
| --- | --- |
| Canonical didactic knowledge | `02_KANBAN.md` |
| Derived didactic knowledge | `07_GLOSSARY.md` |
| Domain checkpoint | `08_CONCEPT_MAP.md` |
| Observational learning history | `13_LECTURE_REGISTER.md` |

## design/

| Role | File |
| --- | --- |
| Canonical design knowledge | `01_ARCHITECTURE.md` |
| Observational design history | `03_DECISION_LOG.md` |
| Domain checkpoint | `09_DESIGN_STATE.md` |
| Derived design knowledge | `14_MODEL_OVERVIEW.md` |

---

# 12. DEV_STAGE Routing

`DEV_STAGE/` contains active methodology workflow staging for ordinary implementation cycles.

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

# 13. [M]_STAGE Routing

`[M]_STAGE/` contains Main-level staging work that is not ordinary D/E/F materialization staging.

Current file:

```text
documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md
```

`J_MAIN_STAGE.md` may be used for:

- Main methodology-lab synthesis;
- Main-root continuity planning;
- methodology sprint handoff;
- staged root-file drafts;
- staging cross-domain conclusions before formal methodology or continuity materialization.

`[M]_STAGE` is not canonical methodology.

It is not domain memory.

It is not a substitute for `00_PROJECT_STATE.md`, `05_SESSION_LOG.md`, or `06_SESSION_SCHEME.md`.

Its contents require later promotion, absorption, or retirement.

---

# 14. Temporary Methodology Sprint Files

Temporary methodology sprint files may exist only during explicit methodology refinement work.

Current example:

```text
documentation/sketch_notebook/PROVISORY_[M]_DOUBLE_LAB.MD
```

Temporary methodology sprint files must declare provisional status, authority, scope, owner, and expiry condition.

They must not silently become canonical methodology.

They should be resolved by methodology sprint closure as one of:

```text
absorbed into methodology
absorbed into 05_SESSION_LOG.md
converted into an approved permanent route
deleted
left temporarily with explicit expiry condition
```

---

# 15. Role Routing Summary

| Role | First recovery surface | Active stage | Post-Codex report | Permanent memory |
| --- | --- | --- | --- | --- |
| Operational Chat | `operational/10_OPERATIONAL_STATE.md` | `DEV_STAGE/A_OPERATIONAL.md` | `DEV_STAGE/G_OPS_CODEX.md` | `operational/` |
| Didactic Chat | `didactics/08_CONCEPT_MAP.md` | `DEV_STAGE/B_DIDACTIC.md` | `DEV_STAGE/H_DDC_CODEX.md` | `didactics/` |
| Design Chat | `design/09_DESIGN_STATE.md` | `DEV_STAGE/C_DESIGN.md` | `DEV_STAGE/I_DSN_CODEX.md` | `design/` |
| Main Chat | `00_PROJECT_STATE.md` + domain checkpoints | `DEV_STAGE/D/E/F` and `[M]_STAGE/J_MAIN_STAGE.md` when needed | `DEV_STAGE/G/H/I` | Main-root continuity + global coherence |
| Codex | `AGENTS.md` + `INDEX.md` + D/E/F | materialization only | `DEV_STAGE/G/H/I` | no semantic promotion |

---

# 16. Functional Chat Route

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

# 17. Main Chat Route

Main Chat should follow this route for ordinary project cycles:

```text
INDEX
↓
methodology boot
↓
00_PROJECT_STATE.md
↓
06_SESSION_SCHEME.md when next-session agenda is relevant
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
00_PROJECT_STATE.md refresh if needed
↓
05_SESSION_LOG.md append if needed
↓
06_SESSION_SCHEME.md refresh if needed
↓
reconciliation
```

For methodology refinement sprints, Main may additionally use:

```text
[M]_STAGE/J_MAIN_STAGE.md
PROVISORY_[M]_DOUBLE_LAB.MD
```

according to `FLUX.md`.

---

# 18. Codex Route

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

# 19. File Creation and Rename Guardrail

No chat, Codex task, automated tool, or manual update should create new files directly under:

```text
documentation/sketch_notebook/
```

unless explicitly authorized by Main Chat under human-supervised methodological revision.

Files must not be renamed except by Main Chat under human-supervised methodological revision.

File creation and renaming require a coherence check against:

- `INDEX.md`;
- `FLUX.md`;
- relevant domain checkpoints;
- affected prompts;
- affected materialization instructions;
- affected references.

This rule prevents data fragmentation, path drift, and data loss during pruning.

---

# 20. Invalid Older Names

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

# 21. Navigation Summary

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

For Main/global recovery, inspect:

```text
00_PROJECT_STATE.md
06_SESSION_SCHEME.md
05_SESSION_LOG.md only when session history is needed
```

For domain recovery, inspect the appropriate checkpoint:

```text
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

Then inspect deeper domain memory only if needed.

Then inspect repository implementation only if needed.

For active implementation-cycle staging, use:

```text
DEV_STAGE/
```

For Main methodology-stage work, use:

```text
[M]_STAGE/J_MAIN_STAGE.md
```

For temporary methodology sprint communication, use only explicitly authorized provisional files.

The goal is not to read everything.

The goal is to recover the project state correctly with the least sufficient context.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
