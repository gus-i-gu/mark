# METHOD_GLOSSARY.md

> Version: 0.1
> Status: Draft
> Persistence Class: Canonical / Consultative
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Vocabulary of the Sketch Notebook Method

---

# 1. Purpose

`METHOD_GLOSSARY.md` defines methodology-specific vocabulary used by the Sketch Notebook Method.

It is consultative.

It does not define routing authority.

It does not define promotion rules.

It does not define conversational protocol.

It exists to reduce ambiguity when the same term appears across:

* `METHOD_FOUNDATIONS.md`;
* `FLUX.md`;
* `PROMOTION_RULES.md`;
* `CHAT_PROTOCOL.md`;
* `CHAT_BEHAVIOUR.md`;
* domain files;
* stage files;
* human prompts.

If another methodology file defines a rule, that file remains authoritative for the rule.

This glossary defines the terms.

---

# 2. Method Documents

## METHOD_FOUNDATIONS.md

The methodology file that defines the foundational ontology of the Sketch Notebook Method.

It answers:

> What is the method?

It owns foundational concepts such as:

* Sketch Notebook;
* project memory;
* knowledge domains;
* Domain Symmetry;
* Domain Checkpoint;
* Hierarchical Recovery;
* Continuous Reconciliation.

---

## FLUX.md

The methodology file that defines routing, write authority, staging, materialization flow, file naming, and recovery paths.

It answers:

> Who may read, write, stage, materialize, report, create, or rename what?

---

## PROMOTION_RULES.md

The methodology file that defines knowledge-state transitions.

It answers:

> What does this knowledge become?

It defines promotion, classification, validation, canonical promotion, derived generation, checkpoint refresh, observational recording, and reconciliation.

---

## CHAT_PROTOCOL.md

The methodology file that defines communication structure.

It answers:

> How should each role express its work?

It defines report shapes, didactic concept structure, and later may define checkpoint/log writing protocols.

---

## CHAT_BEHAVIOUR.md

The methodology file that defines role perspectives.

It answers:

> How does each role reason?

It is an ontological guide for conversational orientation, not primarily a formatting document.

---

## METHOD_GLOSSARY.md

The methodology file that defines methodology vocabulary.

It answers:

> What do these method terms mean?

It is consultative and vocabulary-oriented.

---

# 3. Core Method Terms

## Sketch Notebook

The persistent cognitive representation of the project.

It stores structured project knowledge so development can continue across conversations, tools, and sessions.

---

## Project Memory

The durable knowledge of the project as stored in the Sketch Notebook and repository.

Project memory is preferred over chat memory.

---

## Chat Memory

The temporary context of a single conversation.

Chat memory may help a session proceed, but it is not durable project memory.

---

## Methodology

The set of rules, principles, vocabulary, protocols, and routing structures that define how the Sketch Notebook operates.

---

## Methodological Work

Explicit work on the method itself.

Examples:

* revising `FLUX.md`;
* defining a new methodology term;
* changing boot order;
* renaming Sketch Notebook files;
* changing role authority;
* updating promotion rules.

Methodological work should be supervised by Main Chat and the human developer.

---

## Metalinguistic Role

The fact that methodology files are both:

1. human-readable documentation;
2. operating context for chats and tools.

The method describes itself and is used by the system while it works.

---

# 4. Knowledge States

## Transient Knowledge

Knowledge that exists only in conversation.

It may be useful, but it is not persistent until captured, staged, materialized, or recorded.

---

## Captured Knowledge

Knowledge identified as potentially relevant.

Capture means:

> This may matter later.

It does not mean the knowledge is correct, stable, or canonical.

---

## Classified Knowledge

Knowledge that has been assigned a domain, semantic role, or maturity level.

Classification determines how knowledge should be handled.

---

## Staged Knowledge

Temporary working material held before synthesis, promotion, or materialization.

Stage material is useful but not canonical.

---

## Functional Stage

A domain-specific stage produced by a functional chat.

Examples:

* `A_OPERATIONAL.md`;
* `B_DIDACTIC.md`;
* `C_DESIGN.md`.

---

## Main Synthesis

The integration performed by Main Chat after reading functional reports, human direction, and relevant project memory.

Main synthesis resolves contradictions and prepares materialization direction.

---

## Materialization Stage

Main-approved instruction before file changes.

Examples:

* `D_OPS_STAGE.md`;
* `E_DDC_STAGE.md`;
* `F_DSN_STAGE.md`.

---

## Codex Report Stage

Post-materialization evidence produced by Codex.

Examples:

* `G_OPS_CODEX.md`;
* `H_DDC_CODEX.md`;
* `I_DSN_CODEX.md`.

Codex reports are observational evidence, not canonical truth.

---

## Canonical Knowledge

Accepted project truth within a domain.

Canonical knowledge should have one clear home.

It should be stable enough for future work to depend on.

---

## Derived Knowledge

Knowledge that summarizes, reorganizes, explains, maps, or indexes canonical knowledge.

Derived knowledge does not create independent truth.

---

## Domain Checkpoint

A low-token, ephemeral derived document that summarizes the current state of one domain for fast recovery.

A checkpoint helps future chats avoid reading full canonical or historical files when unnecessary.

Current checkpoint examples:

* `didactics/08_CONCEPT_MAP.md`;
* `operational/10_OPERATIONAL_STATE.md`;
* `design/09_DESIGN_STATE.md`.

---

## Observational Knowledge

Knowledge that records what happened.

Observational knowledge preserves sequence, evidence, events, failures, attempts, lectures, decisions, validations, and reports.

It does not define current truth by itself.

---

## Materialized Knowledge

Knowledge that has been physically applied to repository files, source code, notebook files, or other persistent artifacts.

Materialization is physical, not automatically semantic validation.

---

## Reconciled Knowledge

Knowledge that has been checked against relevant layers such as checkpoints, canonical files, derived files, observational records, source code, stage files, Codex reports, and human direction.

---

# 5. Knowledge-Domain Terms

## Knowledge Domain

A permanent project-memory area responsible for one kind of project truth.

Current functional domains:

* operational;
* didactic;
* design.

---

## Operational Domain

The domain that observes the project as execution.

It owns knowledge about actions, commands, validation, TODOs, failures, implementation state, and operational workflow.

---

## Didactic Domain

The domain that observes the project as learning.

It owns knowledge about concepts, KANBANs, glossary material, concept maps, lectures, and learning progression.

---

## Design Domain

The domain that observes the project as architecture.

It owns knowledge about structure, relationships, responsibilities, domain models, design decisions, and architectural state.

---

## Main Coordination

The coordinating role of Main Chat.

Main is not a functional knowledge domain in the same way as operational, didactic, or design.

Main maintains coherence across domains.

---

# 6. Domain Symmetry Terms

## Domain Symmetry

The principle that each permanent knowledge domain should expose the same semantic capabilities.

The four semantic roles are:

* Canonical Knowledge;
* Derived Knowledge;
* Domain Checkpoint;
* Observational History.

Domain Symmetry does not require identical filenames across domains.

It requires comparable knowledge roles.

---

## Canonical Layer

The domain layer that defines accepted truth.

Examples:

* `didactics/02_KANBAN.md`;
* `operational/12_OPERATIONAL_MODEL.md`;
* `design/01_ARCHITECTURE.md`.

---

## Derived Layer

The domain layer that reorganizes or summarizes accepted truth.

Examples:

* `didactics/07_GLOSSARY.md`;
* `operational/04_TODO.md`;
* `design/14_MODEL_OVERVIEW.md`.

---

## Checkpoint Layer

The domain layer used for fast recovery.

Examples:

* `didactics/08_CONCEPT_MAP.md`;
* `operational/10_OPERATIONAL_STATE.md`;
* `design/09_DESIGN_STATE.md`.

---

## Observational Layer

The domain layer that records historical development.

Examples:

* `didactics/13_LECTURE_REGISTER.md`;
* `operational/11_OPERATIONAL_RECORD.md`;
* `design/03_DECISION_LOG.md`.

---

# 7. Recovery and Reconciliation Terms

## Hierarchical Recovery

The principle that a role should recover project state using the least expensive source capable of answering the task.

Standard recovery order:

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

---

## Low-Token Entry Point

A compact file used to recover current state without reading the full domain history or canonical register.

Domain checkpoints are low-token entry points.

---

## Bootstrap

The process of loading enough methodology and project state to begin work correctly.

---

## Methodological Boot

The boot sequence for loading methodology context.

Current order:

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

---

## Recovery

The act of reconstructing current project state from notebook memory and repository evidence.

---

## Reconciliation

The act of comparing project-memory layers and resolving or recording drift.

Reconciliation may compare:

* checkpoints;
* canonical files;
* derived files;
* observational records;
* stage files;
* Codex reports;
* source code;
* human direction.

---

## Continuous Reconciliation

The principle that project memory must be repeatedly checked against implementation, reports, decisions, and human direction.

Drift is expected.

The method exists to detect, classify, and resolve drift.

---

## Drift

A mismatch between project-memory layers or between notebook memory and implementation.

Examples:

* a checkpoint contradicts canonical knowledge;
* source code contradicts design memory;
* a renamed file is still referenced by old name;
* Codex reported a skipped instruction but the project state assumes success.

---

## Structural Gap

A missing or insufficient file, route, protocol, or semantic role required by the method.

Structural gaps should be reported and materialized through proper authority rather than patched through rogue file creation.

---

# 8. Promotion Terms

## Promotion

The semantic transformation of knowledge from one maturity state into another.

Promotion changes what knowledge means.

---

## Materialization

The physical act of changing files.

Materialization changes repository state.

Promotion and materialization may happen together, but they are not the same.

---

## Capture

The transition from transient conversation into potentially useful memory.

---

## Classification

The act of identifying the domain, role, and maturity of knowledge.

---

## Validation

The act of determining whether knowledge is clear, useful, supported, properly owned, and ready to move forward.

---

## Synthesis

The act of combining staged material into coherent direction.

Main Chat primarily performs synthesis.

---

## Canonical Promotion

The act of making knowledge accepted truth within a domain.

---

## Derived Generation

The act of producing a derived view from canonical knowledge.

---

## Checkpoint Refresh

The act of updating a domain checkpoint to reflect current domain state.

Checkpoint refresh is a form of derived generation.

---

## Observational Recording

The act of recording what happened without redefining current truth.

---

## Codex Report Absorption

The act of interpreting Codex report evidence into domain memory.

Functional chats absorb Codex reports into their domains.

---

# 9. Role Terms

## Main Chat

The coordinating chat responsible for synthesis, global coherence, drift detection, and materialization preparation.

---

## Functional Chat

A specialized chat responsible for a domain perspective.

Current functional chats:

* Operational Chat;
* Didactic Chat;
* Design Chat.

---

## Operational Chat

The functional chat responsible for execution, implementation diagnosis, validation strategy, commands, risks, and operational state.

---

## Didactic Chat

The functional chat responsible for learning, concepts, KANBAN entries, glossary candidates, concept maps, and lecture history.

---

## Design Chat

The functional chat responsible for architecture, responsibility boundaries, relationships, domain models, design decisions, and design state.

---

## Codex

The materialization agent.

Codex applies Main-approved instructions and reports evidence.

Codex should not independently decide semantic promotion.

---

## Human Developer

The supervising intelligence responsible for accepting, rejecting, redirecting, or correcting the system’s work.

---

# 10. Didactic Marker Terms

## KANBAN Marker

A symbol used to classify didactic concepts by learning type.

Current markers:

```text
&&&
&&%
&%%
%%%
```

---

## &&&

Foundational computer science concept.

Used for concepts that are broadly applicable beyond Python and beyond Markei.

Examples:

* Repository Pattern;
* Referential Integrity;
* Interface;
* Data Contract.

---

## &&%

Language-specific concept.

Used for concepts tied to a programming language.

In Markei, this usually means Python.

Examples:

* Python module;
* relative import;
* dataclass;
* dictionary key.

---

## &%%

Project implementation concept.

Used for concepts specific to how Markei is structured or implemented.

Examples:

* ProductService-to-Repository dependency;
* StoragePage display contract;
* Product summary state;
* Purchase owns store relationship.

---

## %%%

External library, framework, dependency, or tool concept.

Examples:

* PySide6;
* SQLite;
* sqlite3;
* PyInstaller;
* GitHub connector.

---

# 11. File-Routing Terms

## DEV_STAGE

The staging area of the Sketch Notebook.

It contains functional stages, Main materialization stages, and Codex report stages.

---

## A/B/C

Functional stage files.

They contain active reports from Operational, Didactic, and Design Chats.

---

## D/E/F

Main materialization stage files.

They contain Main-approved instructions for Codex or human materialization.

---

## G/H/I

Codex report stage files.

They contain post-materialization evidence.

---

## Rogue File

A file created outside approved routing, naming, or authority.

Rogue files fragment project memory and increase pruning/data-loss risk.

---

## File Drift

A mismatch between expected file names/routes and actual repository structure.

---

## Naming Drift

A form of file drift where old or invalid file names remain referenced after renaming.

---

# 12. Closing Note

`METHOD_GLOSSARY.md` is not a replacement for the methodology files.

It is a vocabulary companion.

When a term requires a rule, consult the file that owns the rule.

When a term requires a definition, consult this glossary.

The glossary should evolve only when methodology vocabulary stabilizes enough to be worth naming.

---

# 13. Appended Vocabulary — Methodology Refinement Sprint 01

This section records vocabulary introduced or stabilized during the methodology refinement sprint following Markei Cycle 03.

These terms are consultative definitions.

Rules remain owned by the methodology files that define them.

---

## Main-Root Continuity Files

Main-owned files located directly under `documentation/sketch_notebook/` that support global recovery, session closure, and next-session preparation.

Current examples:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

Main-root continuity files are not functional domain files, methodology files, or DEV_STAGE files.

---

## Main-Root Continuity Flux

The operational flow through which Main Chat closes a session and prepares the next session using Main-root continuity files.

Typical flow:

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

---

## Global State Canon-Checkpoint

A special Main-owned semantic class for a file that functions both as accepted global current-state summary and fast recovery checkpoint.

Current example:

```text
00_PROJECT_STATE.md
```

It summarizes global state without replacing domain-owned canonical files.

---

## Global Observational History

An append-oriented Main-owned observational record for session-level events, reconciliation, drift, accepted direction, and continuity notes.

Current example:

```text
05_SESSION_LOG.md
```

It explains how global state changed, but it does not define current truth by itself.

---

## Forward Checkpoint

A refreshable checkpoint that prepares the next session by describing intended recovery focus, expected files, unresolved decisions, deferred work, and exit criteria.

Current example:

```text
06_SESSION_SCHEME.md
```

A forward checkpoint is predictive.

It does not validate that future work has occurred.

---

## Recovery-Economy

The operational discipline that keeps project recovery cost from growing in proportion to notebook age.

Recovery-Economy evaluates whether a file still performs its semantic responsibility rather than judging file length alone.

Rules for Recovery-Economy are owned by `FLUX.md`.

---

## Semantic Responsibility Over Length

The principle that a file should be evaluated by whether it performs its assigned semantic role, not merely by how many lines it contains.

A long file is not automatically unhealthy.

A file becomes unhealthy when its length prevents it from functioning as its intended semantic class.

---

## File Operation Contract

The mapping between a file’s semantic class and its preferred maintenance operation.

Typical operations include:

```text
Checkpoint -> Refresh
Canonical -> Reconcile
Derived / resorted -> Extend / Reconcile
Observational -> Append
```

Operational handling of this contract belongs to `FLUX.md`.

---

## Append Contract

The rule that observational files preserve chronology by appending new dated sections rather than rewriting historical records.

Existing historical sections are considered immutable unless factual correction, archival restructuring, or Main-authorized historical revision is explicitly approved.

---

## Refresh Contract

The rule that refreshable files exist for fast recovery and should answer:

```text
What exists?
What changed?
What remains open?
Where should recovery continue?
```

Refreshable files should not become canonical registers, historical logs, lectures, or implementation reports.

---

## Read Window Protocol

The practice of recovering from large files through bounded reading rather than full rereading.

Typical sequence:

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

The Read Window Protocol is operational and belongs to `FLUX.md`.

---

## Landline Mark

A stable heading or marker that allows agents to recover relevant late sections of a large file without rereading the entire file.

The name evokes a fixed recovery line: a known place where a future chat can reconnect to the file.

Suggested format:

```text
## LANDLINE: Latest Session
## LANDLINE: Cycle 03 Reconciliation
## LANDLINE: Current Methodology Risks
```

Landline Marks should represent semantic transitions rather than arbitrary page divisions.

---

## Sprint Read Limit

A Recovery-Economy threshold that indicates when a file should stop being reread in full by default.

Current value:

```text
SPRINT_READ_LIMIT = 800 lines
```

Crossing this threshold activates read-window discipline.

It does not authorize automatic file creation.

---

## Repartition Review Limit

A Recovery-Economy threshold that indicates when a file may need structural review.

Current value:

```text
REPARTITION_REVIEW_LIMIT = 1300 lines
```

Crossing this threshold may trigger indexing, compaction, resorting, or Main-approved structural change.

---

## Boundary-Stable

A description for a system whose responsibilities, ownership, or architectural boundaries have stabilized even though implementation details may still evolve.

Use `boundary-stable` instead of `stable` when implementation still has known risks, deferred decisions, or manual validation gaps.

---

## Vertical Reconciliation

Reconciliation across semantic layers and time.

Typical chain:

```text
observational evidence
↓
canonical / derived updates
↓
checkpoint refresh
↓
global project state
```

Vertical reconciliation checks whether each layer reflects the correct semantic maturity.

---

## Horizontal Reconciliation

Reconciliation across domains or perspectives.

Typical chain:

```text
Operational ↔ Didactic ↔ Design ↔ Main
```

Horizontal reconciliation checks whether domains remain complementary rather than contradictory or duplicative.

---

## Duplicate Semantic Data

A drift condition where two or more files attempt to own the same meaning at the same authority level.

Duplicate semantic data differs from legitimate summary, reference, or domain-specific interpretation.

Reconciliation should identify one canonical owner and convert other occurrences into summaries, references, derived views, checkpoint notes, observational history, or removal candidates.

---

## Semantic Owner

The file, domain, or layer responsible for maintaining the authoritative form of a knowledge object.

Semantic ownership prevents the same stable rule, concept, boundary, or state claim from becoming duplicate canon.

---

## Duplicate Ownership

A form of duplicate semantic data where more than one file or domain claims authority over the same stable meaning.

Duplicate ownership should be resolved through reconciliation.

---

## Perspectival Repetition

Allowed repetition of the same event across different domains when each domain interprets the event through its own responsibility.

Example:

```text
Operational: validation passed or failed.
Design: boundary consequence changed.
Didactic: concept became teachable.
Main: global state shifted.
```

Perspectival repetition is not duplicate semantic data when ownership remains distinct.

---

## Methodology Refinement Sprint

An explicit, human-supervised work period focused on changing the Sketch Notebook Method itself.

A methodology refinement sprint is not an ordinary Markei feature cycle.

It may revise methodology files, Main-root continuity files, and navigation files under Main supervision.

---

## Temporary Methodology Sprint File

A provisional file created for chat-to-chat communication during a methodology refinement sprint.

Temporary methodology sprint files must declare provisional status, authority, scope, owner, and expiry condition.

They must end as absorbed, promoted, converted into an approved route, deleted, or explicitly left temporary with an expiry condition.

---

## Provisional Lab Bridge

A temporary methodology sprint file used to communicate experimental observations or staged method-lab conclusions before formal methodology promotion.

Current example:

```text
PROVISORY_[M]_DOUBLE_LAB.MD
```

A provisional lab bridge is not canonical methodology by itself.

---

## Disjunct Flux Protocol

A specialized operational flow that coexists with ordinary functional-domain flow without replacing it.

Main-root continuity flow is a disjunct flux protocol because it coordinates global session closure and next-session preparation separately from domain-memory promotion.

---

## Recovery-Cost Drift

A form of drift where the notebook still contains correct information but requires too much rereading, duplicated inspection, or broad context loading to recover the correct state.

Recovery-cost drift is addressed through Recovery-Economy rather than automatic file creation.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
