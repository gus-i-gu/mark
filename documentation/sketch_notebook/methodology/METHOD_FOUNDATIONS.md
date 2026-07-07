# METHOD_FOUNDATIONS.md

> Version: 0.2
> Status: Draft
> Persistence Class: Canonical
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Ontology and bootstrap context of the Sketch Notebook Method

---

# 1. Purpose

The Sketch Notebook Method is a methodology for coordinating software development, debugging, project design, and computer science learning across multiple AI-assisted conversations.

Its central principle is that conversation is transient, while the Sketch Notebook is persistent.

The method treats the repository not only as a place for source code, but also as a persistent cognitive representation of the project.

The Sketch Notebook therefore stores the project knowledge required to understand, continue, reproduce, and evolve the software.

---

# 2. The Sketch Notebook

The Sketch Notebook is the persistent knowledge system of the project.

It is not merely documentation.

It is the structured memory through which conversations, AI agents, development tools, and human supervision coordinate around the same project reality.

Chats may reason, explain, plan, and discuss.

The Sketch Notebook persists what matters.

The conversation itself remains transient.

The notebook remains persistent.

---

# 3. Metalinguistic Role

The methodology files are not passive notes.

They are part of the system they describe.

When a chat begins work, it reads the methodology files to initialize its context.

This means methodology files function as both:

1. human-readable specifications;
2. context boot documents for AI-assisted work.

The method therefore contains a metalinguistic component: it defines the language, responsibilities, and operational assumptions through which the system speaks about itself.

A chat does not merely read the methodology as background information.

It loads the methodology as operating context.

---

# 4. Context Boot Sequence

Every participating chat should initialize its working context by reading the methodology specifications.

Conceptual boot order:

```text
METHOD_FOUNDATIONS
    ↓
loads ontology

PROMOTION_RULES
    ↓
loads knowledge-transformation semantics

CHAT_BEHAVIOUR
    ↓
loads reasoning perspective

CHAT_PROTOCOL
    ↓
loads communication pattern

FLUX
    ↓
loads operational routing and write authority
```

This boot sequence allows multiple conversations to behave as coordinated parts of the same knowledge system rather than as isolated chats.

---

# 5. One Primary Semantic Responsibility

Every specification should establish one primary semantic context.

A methodology file should not expand endlessly to include every related concern.

If a document consistently starts answering more than one fundamental question, the methodology should be refactored rather than merely expanded.

This principle keeps the system coherent.

For the current methodology:

| File | Primary semantic context |
|---|---|
| `METHOD_FOUNDATIONS.md` | What the Sketch Notebook Method is |
| `PROMOTION_RULES.md` | How knowledge changes state |
| `CHAT_BEHAVIOUR.md` | How each chat reasons |
| `CHAT_PROTOCOL.md` | How each chat communicates |
| `FLUX.md` | How information is routed and materialized |

The same object may appear in several files, but each file describes it from only one semantic responsibility.

Example:

- `METHOD_FOUNDATIONS.md` may define DEV_STAGE as a staging concept.
- `PROMOTION_RULES.md` may define how knowledge passes through staging.
- `FLUX.md` defines the exact path, filename, and write authority.

This prevents duplication, drift, and contradictory instructions.

---

# 6. Core Principles

## 6.1 Persistence Over Conversation

Conversations are temporary reasoning surfaces.

The Sketch Notebook is the durable project memory.

Important knowledge must be externalized into the notebook before it becomes part of the project state.

## 6.2 Canonical Knowledge

A canonical document is authoritative over its own field of knowledge.

Canonicity belongs to documents, not chats.

Chats may have authority to write, but canonical truth belongs to the appropriate notebook artifact.

## 6.3 Authority as Write Responsibility

Authority means permission and responsibility to stage or modify specific files.

Authority does not automatically determine truth.

Concrete write authority and routing rules are defined in `FLUX.md`.

## 6.4 Separation of Concerns

The method separates:

- knowledge construction;
- staging;
- synthesis;
- materialization;
- persistence;
- verification.

Each layer should remain distinct.

## 6.5 Progressive Refinement

Knowledge develops gradually.

Raw conversation becomes staged material.

Staged material becomes synthesized instruction.

Synthesized instruction becomes materialized repository change.

Materialized change becomes persisted project state.

## 6.6 Human Supervision

The system is AI-assisted, not autonomous.

Human review remains responsible for accepting, rejecting, or redirecting materialized changes.

---

# 7. Knowledge Classes

The Sketch Notebook distinguishes several classes of knowledge.

## 7.1 Canonical Documents

Canonical documents define stable truth within their own domain.

They are carefully maintained and should change only through validated updates.

Examples include methodology specifications, architectural records, decisions, KANBANs, and domain models.

## 7.2 Derived Documents

Derived documents reorganize or summarize knowledge from canonical sources.

They do not introduce independent truth.

They are views, maps, snapshots, or indexes.

## 7.3 Operational Documents

Operational documents coordinate current work.

They are more volatile than canonical documents and may be rewritten as priorities change.

## 7.4 Observational Documents

Observational documents record events.

They preserve history and should generally be append-only.

They answer what happened, not what is currently true.

## 7.5 Staging Documents

Staging documents temporarily hold working material before it is synthesized or materialized.

They are not permanent project memory.

They exist to prevent loss of useful reasoning while preserving the integrity of canonical documents.

---

# 8. Conversational System

The method uses two categories of chats.

## 8.1 Main Chat

The Main Chat coordinates the whole system.

It synthesizes outputs from the functional chats, prepares materialization instructions, maintains global continuity, and supervises methodological refinement.

The Main Chat is the integration layer.

## 8.2 Functional Chats

Functional chats are specialized conversations with domain perspectives.

The current functional chats are:

- Operational Chat;
- Didactic Chat;
- Design Chat.

Each functional chat stages its own domain report.

Functional chats do not directly modify permanent notebook memory.

Concrete file authority is defined in `FLUX.md`.

---

# 9. Functional Perspectives

## 9.1 Operational Perspective

The Operational Chat observes the project as execution.

It asks what should be done, what failed, what command should be run, what evidence exists, and what immediate action is required.

## 9.2 Didactic Perspective

The Didactic Chat observes the project as learning.

It asks what concept appeared, what should be understood, what belongs in a KANBAN, and how practical work becomes structured knowledge.

## 9.3 Design Perspective

The Design Chat observes the project as architecture.

It asks what structure is intended, what responsibility belongs where, which decisions are stable, and how the project should evolve.

## 9.4 Main Perspective

The Main Chat observes the project as a whole.

It asks where the project currently is, what changed, which domain owns the next question, and what must be synchronized.

---

# 10. Sketch Notebook Structure

The canonical notebook root is:

```text
documentation/sketch_notebook/
```

The root contains the persistent knowledge structure for the project.

The exact routing and write authority are defined in `FLUX.md`, but the conceptual directory structure is:

```text
documentation/sketch_notebook/
│
├── methodology/
│   ├── METHOD_FOUNDATIONS.md
│   ├── PROMOTION_RULES.md
│   ├── CHAT_BEHAVIOUR.md
│   ├── CHAT_PROTOCOL.md
│   └── FLUX.md
│
├── operational/
│   └── permanent operational knowledge
│
├── didactics/
│   └── permanent learning knowledge
│
├── design/
│   └── permanent architecture and design knowledge
│
└── DEV_STAGE/
    └── staging files for functional chats and Main synthesis
```

## 10.1 methodology/

The `methodology/` directory contains the specifications that define the system itself.

These files are the most stable part of the notebook.

They should change only through explicit methodological work.

## 10.2 operational/

The `operational/` directory contains durable operational knowledge.

It may include actions, runbooks, debugging records, command references, execution notes, and operational state.

## 10.3 didactics/

The `didactics/` directory contains the structured learning system.

It may include KANBANs, glossary material, concept maps, explanatory notes, and learning progress.

## 10.4 design/

The `design/` directory contains structural project knowledge.

It may include architecture, domain models, design decisions, responsibility boundaries, and planned structure.

## 10.5 DEV_STAGE/

The `DEV_STAGE/` directory is the notebook staging surface.

It is not permanent memory.

Functional chats stage domain reports there.

The Main Chat stages synthesized materialization instructions there.

Codex reads Main-approved stage files when materializing changes.

---

# 11. Software Components

## 11.1 ChatGPT

ChatGPT conversations provide semantic reasoning, planning, explanation, and synthesis.

ChatGPT constructs and organizes knowledge.

## 11.2 Codex CLI

Codex CLI is the materialization agent.

It edits files, applies patch instructions, runs commands, and transforms Main-approved staged instructions into repository changes.

Codex materializes knowledge but should not invent methodology.

## 11.3 GitHub

GitHub is the shared persistence and synchronization layer.

It stores source code, notebook files, commit history, and remote project state.

## 11.4 VS Code

VS Code is the local human inspection and development surface.

It is used for reading diffs, reviewing edits, running commands, and supervising changes before or after persistence.

---

# 12. Conceptual Lifecycle

The conceptual lifecycle is:

```text
Conversation input
↓
Context boot
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
Human verification
↓
Git/GitHub persistence
↓
Notebook reread
```

This lifecycle separates semantic work from physical file editing.

ChatGPT reasons.

The Sketch Notebook stores knowledge.

Codex materializes instructions.

GitHub persists state.

VS Code supports human verification.

---

# 13. Core Vocabulary

## Sketch Notebook

The persistent cognitive representation of the project.

## Methodology Files

Specifications that define the behavior, routing, transformation, and communication assumptions of the system.

## Functional Chat

A specialized chat responsible for one domain perspective: operational, didactic, or design.

## Main Chat

The coordinating chat responsible for synthesis, global continuity, and materialization preparation.

## Stage

A temporary notebook surface where working material is held before it becomes permanent knowledge or implementation instruction.

## Promotion

The transformation of knowledge from one maturity state into another.

Defined in `PROMOTION_RULES.md`.

## Materialization

The act of converting staged/synthesized knowledge into actual repository changes.

Performed by Codex or by explicit human editing.

## Persistence

The act of recording project state through Git/GitHub.

---

# 14. Closing Principle

The Sketch Notebook Method exists to make AI-assisted development continuous, inspectable, and teachable.

The goal is not to make chats remember everything.

The goal is to make the project remember itself.
