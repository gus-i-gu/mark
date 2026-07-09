# METHOD_FOUNDATIONS.md

> Version: 0.3
> Status: Draft
> Persistence Class: Canonical
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Ontology and foundational principles of the Sketch Notebook Method

---

# 1. Purpose

The Sketch Notebook Method is a methodology for coordinating software development, debugging, project design, learning, documentation, and AI-assisted materialization across multiple conversations and tools.

Its central principle is:

> Conversation is transient.
> The Sketch Notebook is persistent.

The method treats the repository not only as a place for source code, but also as the persistent cognitive representation of the project.

The Sketch Notebook stores the project knowledge required to:

* understand the system;
* continue interrupted work;
* reproduce reasoning;
* validate implementation;
* preserve learning;
* detect drift;
* evolve the software without losing context.

The goal is not to make every chat remember everything.

The goal is to make the project remember itself.

---

# 2. The Sketch Notebook

The Sketch Notebook is the persistent knowledge system of the project.

It is not merely documentation.

It is the structured memory through which conversations, AI agents, development tools, source code, and human supervision coordinate around the same project reality.

Chats may reason, explain, plan, argue, diagnose, and synthesize.

Codex may materialize.

The repository may store code.

GitHub may persist changes.

But the Sketch Notebook preserves the project’s interpreted state.

The notebook exists because software development is not only a sequence of edits.

It is also a sequence of reasons.

---

# 3. Metalinguistic Role

The methodology files are not passive notes.

They are part of the system they describe.

When a chat begins work, it reads the methodology files to initialize its operating context.

This means methodology files function as both:

1. human-readable specifications;
2. context boot documents for AI-assisted work.

The method therefore contains a metalinguistic component: it defines the language, responsibilities, knowledge states, routing rules, and communication patterns through which the system speaks about itself.

A chat does not merely read the methodology as background information.

It loads the methodology as operating context.

---

# 4. Methodology Specifications

Each methodology file owns one primary semantic responsibility.

A methodology file should not expand endlessly to answer every related question.

If a document consistently starts answering more than one fundamental question, the methodology should be refactored rather than merely expanded.

Current methodological responsibilities:

| File                    | Primary semantic responsibility                                        |
| ----------------------- | ---------------------------------------------------------------------- |
| `METHOD_FOUNDATIONS.md` | What the Sketch Notebook Method is                                     |
| `FLUX.md`               | How information is routed, staged, written, materialized, and reported |
| `PROMOTION_RULES.md`    | How knowledge changes semantic state                                   |
| `CHAT_PROTOCOL.md`      | How each conversational role communicates and structures output        |
| `CHAT_BEHAVIOUR.md`     | How each conversational role reasons from its perspective              |
| `METHOD_GLOSSARY.md`    | What methodology-specific terms mean                                   |

The same object may appear in several files, but each file describes it from only one responsibility.

Example:

* `METHOD_FOUNDATIONS.md` defines Domain Checkpoint as a foundational concept.
* `FLUX.md` defines which checkpoint file each role reads or writes.
* `PROMOTION_RULES.md` defines whether checkpoint content is derived, canonical, or observational.
* `CHAT_PROTOCOL.md` defines how a chat should format checkpoint-relevant content.
* `METHOD_GLOSSARY.md` defines the term in consultative form.

This prevents duplication, drift, and contradictory instructions.

---

# 5. Methodological Boot Principle

Every participating chat should initialize its working context from the methodology.

The preferred methodological boot order is:

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

`CHAT_BEHAVIOUR.md` remains a stable ontological guide for role perspectives.

It may be consulted when a role’s reasoning perspective is unclear, when a new role is added, or when the conversational model itself is being revised.

It does not need to be re-expanded into every ordinary boot if its principles are already stable and represented through protocol and flux.

The boot order exists to load context in this sequence:

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

This order helps preserve both subject consistency and textual consistency.

---

# 6. Core Principles

## 6.1 Persistence Over Conversation

Conversations are temporary reasoning surfaces.

The Sketch Notebook is durable project memory.

Important knowledge must be externalized into the notebook before it becomes part of the project state.

## 6.2 Project Memory Over Chat Memory

The method does not depend on one conversation remembering the whole project.

Instead, project memory is distributed into persistent notebook artifacts.

A chat should recover project state from the notebook before relying on conversation memory.

## 6.3 Knowledge Before Modification

Implementation should not be separated from understanding.

The method follows the discipline:

```text
Understand
↓
Implement
↓
Validate
↓
Refactor
```

Knowledge does not replace implementation.

Knowledge prepares implementation.

Debugging does not replace learning.

Debugging validates architecture and concept understanding.

## 6.4 Separation of Concerns

The method separates:

* knowledge construction;
* recovery;
* staging;
* synthesis;
* promotion;
* materialization;
* validation;
* persistence;
* reconciliation.

Each layer should remain distinct.

Confusing these layers creates drift.

## 6.5 Authority as Write Responsibility

Authority means permission and responsibility to stage, modify, or reconcile specific project artifacts.

Authority does not automatically determine truth.

A chat may have authority to write a file, but the validity of what it writes still depends on evidence, consistency, and appropriate promotion.

Concrete write authority and routing rules belong to `FLUX.md`.

## 6.6 Human Supervision

The system is AI-assisted, not autonomous.

Human review remains responsible for accepting, rejecting, redirecting, or correcting materialized changes.

The human developer is not outside the method.

The human developer is the supervising intelligence that decides whether the method is serving the project.

---

# 7. Knowledge Domains

The Sketch Notebook organizes persistent memory into knowledge domains.

The current functional domains are:

* operational;
* didactic;
* design.

Each domain represents a different kind of project truth.

## 7.1 Operational Domain

The operational domain observes the project as execution.

It asks:

* what should be done now;
* what was attempted;
* what failed;
* what commands are relevant;
* what validation is required;
* what work remains.

Operational knowledge includes actions, TODOs, validation procedures, track records, run notes, implementation risks, and execution state.

## 7.2 Didactic Domain

The didactic domain observes the project as learning.

It asks:

* what concept appeared;
* what should be understood;
* what belongs in the KANBAN;
* what is stable knowledge;
* what is still unstable;
* how implementation becomes reusable understanding.

Didactic knowledge includes KANBAN concepts, glossary entries, concept maps, learning progress, required concepts, and project-based examples.

## 7.3 Design Domain

The design domain observes the project as architecture.

It asks:

* what responsibility belongs where;
* which relationship owns which fact;
* what structure is intended;
* which decisions are stable;
* what should the project become.

Design knowledge includes domain models, decisions, responsibility boundaries, architectural states, UI responsibility, deferred design questions, and design rationale.

## 7.4 Main Coordination

Main Chat is not a separate knowledge domain in the same sense.

Main Chat coordinates the whole system.

It reads functional domains, compares them, detects drift, prepares synthesis, updates global continuity, and keeps the project trajectory coherent.

Main Chat is the integration layer.

---

# 8. Domain Symmetry Principle

Every permanent knowledge domain should expose the same semantic capabilities.

The exact filenames may differ, but each domain should support four knowledge roles:

| Role                  | Purpose                                       | Stability                         |
| --------------------- | --------------------------------------------- | --------------------------------- |
| Canonical Knowledge   | Defines accepted truth within the domain      | Stable                            |
| Derived Knowledge     | Reorganizes or summarizes canonical knowledge | Revisable                         |
| Domain Checkpoint     | Provides fast current-state recovery          | Frequently refreshed              |
| Observational History | Records what happened over time               | Append-only or nearly append-only |

This is the Domain Symmetry Principle.

It does not require every domain folder to contain exactly the same number of files.

It requires every domain to make these four semantic roles available somehow.

A single file should not permanently carry incompatible semantic roles if doing so creates drift.

For example:

* a canonical file should be free to improve definitions;
* an observational file should preserve historical sequence;
* a checkpoint should be easy to rewrite;
* a derived file should not introduce independent truth.

When one file tries to perform all of these roles, the domain becomes difficult to maintain.

---

# 9. Domain Checkpoints

A Domain Checkpoint is an ephemeral derived document that summarizes the current state of one knowledge domain.

Its purpose is rapid session recovery.

A checkpoint does not introduce new truth.

It exposes the current operational state of canonical, derived, and observational knowledge while minimizing bootstrap cost.

A checkpoint should answer:

* where the domain currently stands;
* what changed recently;
* what is stable;
* what is active;
* what is unresolved;
* what should be read next if deeper context is required.

Current checkpoint examples include:

| Domain      | Checkpoint                            |
| ----------- | ------------------------------------- |
| Didactic    | `didactics/08_CONCEPT_MAP.md`         |
| Operational | `operational/10_OPERATIONAL_STATE.md` |
| Design      | `design/09_DESIGN_STATE.md`           |

Exact checkpoint filenames are routed by `FLUX.md`.

The foundational principle is that every domain should provide a low-token recovery surface before requiring full canonical or historical reading.

---

# 10. Hierarchical Recovery Principle

Every role shall recover project state using the least expensive knowledge source capable of answering the current task.

The preferred recovery order is:

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

This is the Hierarchical Recovery Principle.

A chat should not burn context reading a full canonical register if the checkpoint already answers the question.

A chat should not inspect long historical logs unless the evolution of a decision matters.

A chat should not inspect the repository before consulting the notebook when the notebook is expected to contain the current project state.

Repository inspection remains necessary when:

* implementation truth is uncertain;
* notebook drift is suspected;
* source files are the direct subject of the task;
* materialization must be validated;
* the checkpoint or canonical files are insufficient.

The hierarchy is not a prohibition.

It is a cost discipline.

---

# 11. Knowledge Classes

The Sketch Notebook distinguishes several classes of knowledge.

Detailed transition rules belong to `PROMOTION_RULES.md`.

This section defines the foundational ontology.

## 11.1 Transient Knowledge

Transient knowledge lives in conversation.

It includes raw ideas, questions, doubts, hypotheses, plans, explanations, and exploratory reasoning.

It is not project memory until captured or materialized.

## 11.2 Staged Knowledge

Staged knowledge is temporarily held for review, synthesis, or materialization.

It is useful but not canonical.

Stage files exist to prevent useful reasoning from disappearing while preserving the integrity of permanent memory.

## 11.3 Canonical Knowledge

Canonical knowledge defines accepted truth within a domain.

Canonical knowledge should be stable, validated, and owned by the appropriate domain.

Examples include:

* methodology principles;
* KANBAN concept entries;
* architectural decisions;
* operational guides;
* domain models.

## 11.4 Derived Knowledge

Derived knowledge reorganizes, summarizes, indexes, or maps canonical knowledge.

It does not introduce independent truth.

Examples include:

* glossary entries;
* concept maps;
* project state summaries;
* domain checkpoints;
* overviews.

## 11.5 Observational Knowledge

Observational knowledge records what happened.

It preserves events, attempts, failures, validations, session progress, and historical sequence.

It does not define current truth by itself.

Examples include:

* session logs;
* operational track records;
* learning logs;
* decision logs;
* Codex reports.

## 11.6 Materialized Knowledge

Materialized knowledge is knowledge that has been physically applied to repository files, source code, notebook files, or other persistent artifacts.

Materialization is not the same as semantic promotion.

A file may be changed without the change being conceptually correct.

Therefore materialized changes still require validation and reconciliation.

---

# 12. Promotion and Materialization

Promotion and materialization are different operations.

Promotion is semantic.

It changes the status of knowledge.

Materialization is physical.

It changes files.

A staged design decision becoming canonical is promotion.

A patch being applied to source code is materialization.

A concept being added to a KANBAN is both semantic promotion and physical materialization.

Because these operations can overlap, the method keeps their responsibilities separate.

Detailed promotion rules belong to `PROMOTION_RULES.md`.

Routing and materialization authority belong to `FLUX.md`.

---

# 13. Continuous Reconciliation Principle

Project knowledge continuously evolves.

Therefore, the Sketch Notebook must be periodically reconciled against:

* source code;
* functional stage reports;
* Main synthesis;
* Codex materialization reports;
* domain checkpoints;
* canonical domain files;
* derived domain files;
* observational records;
* human direction.

This is the Continuous Reconciliation Principle.

Drift is expected.

The methodology does not pretend drift can be avoided entirely.

It exists to detect, classify, and resolve drift without losing history.

Reconciliation asks:

```text
Does the checkpoint reflect the canonical state?
Does derived knowledge reflect canonical knowledge?
Does observational history explain how the current state emerged?
Does source code agree with notebook memory?
Did materialization match the Main-approved instruction?
Did human direction override or revise prior knowledge?
```

Reconciliation may produce:

* checkpoint refresh;
* canonical correction;
* derived regeneration;
* observational note;
* new TODO;
* design revision;
* didactic update;
* methodology refinement.

---

# 14. Role Appropriateness Principle

Each actor should perform the work most aligned with its strengths.

Functional Chats maintain domain memory.

Main Chat maintains coherence.

Codex materializes implementation and reports evidence.

The human developer supervises direction and acceptance.

No actor should routinely perform work better suited to another actor.

This principle explains why:

* Codex should report what happened rather than decide what it means;
* Functional Chats should classify domain evidence rather than leave all documentation to Main;
* Main should synthesize and reconcile rather than rewrite every domain file;
* the human should review and redirect rather than be hidden from the process.

Role appropriateness prevents overload.

It also improves documentation quality.

---

# 15. Conversational System

The method uses specialized conversational roles.

## 15.1 Main Chat

Main Chat observes the project as a whole.

It asks:

> Where is the project, and where should it go next?

Main Chat reasons in terms of milestones, synchronization, consistency, contradiction, and coordination.

## 15.2 Operational Chat

Operational Chat observes the project as execution.

It asks:

> What should be done now?

Operational Chat reasons in terms of commands, implementation, validation, risks, failures, and immediate next actions.

## 15.3 Didactic Chat

Didactic Chat observes the project as learning.

It asks:

> What does this teach us?

Didactic Chat reasons in terms of concepts, dependencies, examples, KANBANs, glossary entries, concept maps, and learning progression.

## 15.4 Design Chat

Design Chat observes the project as architecture.

It asks:

> What should the project become?

Design Chat reasons in terms of structure, responsibility, relationships, boundaries, domain models, UI responsibility, and long-term coherence.

## 15.5 Codex

Codex is not a conversational perspective in the same way.

Codex is the materialization agent.

It applies Main-approved instructions, modifies repository files, runs validation when directed, and reports evidence.

Codex should not invent methodology.

Codex should not independently promote knowledge.

---

# 16. Software Components

## 16.1 ChatGPT

ChatGPT conversations provide reasoning, planning, explanation, diagnosis, synthesis, and domain memory maintenance.

ChatGPT constructs and organizes knowledge.

## 16.2 Codex CLI

Codex CLI is the materialization agent.

It edits files, applies patch instructions, runs commands, validates changes when instructed, and reports materialization evidence.

## 16.3 GitHub

GitHub is the shared persistence and synchronization layer.

It stores source code, notebook files, commit history, and remote project state.

## 16.4 VS Code

VS Code is the local human inspection and development surface.

It is used for reading diffs, reviewing edits, running commands, and supervising changes before or after persistence.

## 16.5 Human Developer

The human developer provides judgment, intention, acceptance, rejection, correction, and strategic direction.

The method is AI-assisted, not AI-sovereign.

---

# 17. Conceptual Lifecycle

The general lifecycle is:

```text
Human intention
↓
Context boot
↓
Hierarchical recovery
↓
Domain reasoning
↓
Functional staging
↓
Main synthesis
↓
Materialization staging
↓
Codex materialization
↓
Codex report
↓
Functional domain-memory update
↓
Main reconciliation
↓
Human verification
↓
Git/GitHub persistence
↓
Checkpoint refresh
↓
Next session recovery
```

This lifecycle separates semantic work from physical file editing.

ChatGPT reasons.

The Sketch Notebook stores knowledge.

Codex materializes instructions.

GitHub persists state.

VS Code supports inspection.

The human developer supervises meaning.

---

# 18. Core Vocabulary

## Sketch Notebook

The persistent cognitive representation of the project.

## Methodology Files

Specifications that define the behavior, routing, transformation, vocabulary, and communication assumptions of the system.

## Knowledge Domain

A permanent project-memory area responsible for one kind of project truth.

Examples include operational, didactic, and design domains.

## Domain Checkpoint

A low-token, ephemeral derived document that summarizes the current state of one domain for fast recovery.

## Functional Chat

A specialized chat responsible for one domain perspective: operational, didactic, or design.

## Main Chat

The coordinating chat responsible for synthesis, global continuity, drift detection, and materialization preparation.

## Stage

A temporary notebook surface where working material is held before it becomes permanent knowledge or implementation instruction.

## Promotion

The semantic transformation of knowledge from one maturity state into another.

## Materialization

The physical act of converting staged or synthesized knowledge into repository changes.

## Reconciliation

The act of comparing checkpoints, canonical knowledge, derived knowledge, observational records, repository state, and human direction to detect and resolve drift.

## Persistence

The act of recording project state through repository files and Git/GitHub history.

---

# 19. Closing Principle

The Sketch Notebook Method exists to make AI-assisted development continuous, inspectable, teachable, and recoverable.

It does not attempt to eliminate uncertainty.

It gives uncertainty a place to be staged.

It does not attempt to eliminate drift.

It gives drift a process for detection and reconciliation.

It does not ask chats to remember the project.

It asks the project to remember itself.
