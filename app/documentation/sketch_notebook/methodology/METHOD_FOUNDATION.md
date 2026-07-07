# METHOD_FOUNDATIONS.md

> Version: 0.1 (Draft)
> Status: Foundational Specification
> Persistence Class: Canonical
> Authority: Main Chat
> Scope: Entire Sketch Notebook Method

---

# 1. Purpose

The Sketch Notebook Method is a knowledge-oriented methodology for software development,
computer science study, project design and iterative debugging through coordinated
ChatGPT conversations.

Rather than considering conversations as the primary source of project memory,
the method establishes the Sketch Notebook as the project's persistent cognitive
representation.

Chats are temporary workspaces.

The Sketch Notebook is the persistent knowledge object.

The repository is the persistence layer.

Git records the notebook evolution.

---

# 2. Core Principles

The method is built upon six fundamental principles.

## 2.1 Persistence over Conversation

Conversation is transient.

Knowledge is persistent.

Information only becomes part of the project after being incorporated into the
Sketch Notebook.

---

## 2.2 Single Canonical Source

Every category of knowledge must possess exactly one canonical representation.

A canonical document is the definitive source of truth for its own domain.

Derived documents may summarize canonical information but shall never redefine it.

---

## 2.3 Separation of Responsibilities

Chats own responsibilities.

Documents own knowledge.

Authority belongs to chats.

Canonicity belongs to documents.

---

## 2.4 Progressive Knowledge Refinement

Knowledge evolves through increasing levels of refinement.

Raw observations become organized knowledge.

Organized knowledge becomes canonical knowledge.

Canonical knowledge generates operational and navigational views.

---

## 2.5 Historical Preservation

No significant project evolution should be lost.

Historical documents preserve the evolution of both the project and the methodology.

---

## 2.6 Modular Development

The project is decomposed into specialized conversations.

Each conversation develops one dimension of the project while remaining synchronized
through the Sketch Notebook.

---

# 3. Sketch Notebook

The Sketch Notebook is the persistent knowledge graph representing the project.

It is not documentation.

It is not merely a collection of Markdown files.

It is the structured representation of everything the project knows.

Every notebook file represents one specific knowledge object.

Relationships between notebook files define the project's internal knowledge graph.

---

# 4. Knowledge Classes

The Sketch Notebook is composed of four classes of documents.

---

## I. Observational Documents

Purpose

Record events.

Characteristics

- append-only
- chronological
- contextual
- historical

Question answered

"What happened?"

Examples

- SESSION_LOG
- OPERATIONAL_TRACKRECORD

---

## II. Canonical Documents

Purpose

Define stable project knowledge.

Characteristics

- curated
- authoritative within their domain
- stable
- carefully maintained

Question answered

"What is true?"

Examples

- METHOD_FOUNDATIONS
- CHAT_PROTOCOL
- PROMOTION_RULES
- ARCHITECTURE
- DOMAIN_MODEL
- DECISIONS
- KANBAN

Canonical documents constitute the official knowledge base of the project.

---

## III. Derived Documents

Purpose

Present canonical knowledge under useful operational or navigational perspectives.

Characteristics

- regenerated
- summarized
- non-authoritative
- replaceable

Question answered

"Given current knowledge, how should it be viewed?"

Examples

- PROJECT_STATE
- GLOSSARY
- CONCEPT_MAP
- ACTIONS

Derived documents never introduce new knowledge.

They reorganize existing canonical knowledge.

---

## IV. Operational Documents

Purpose

Coordinate current execution.

Characteristics

- ephemeral
- continuously rewritten
- execution-oriented

Question answered

"What should happen next?"

Examples

- TODO
- SESSION_SCHEME

Operational documents represent the current execution state rather than permanent
project knowledge.

---

# 5. Document Hierarchy

Documents possess different persistence levels.

Constitutional

Defines the methodology itself.

Examples

- METHOD_FOUNDATIONS
- CHAT_PROTOCOL
- PROMOTION_RULES

Structural

Defines the project.

Examples

- ARCHITECTURE
- DOMAIN_MODEL
- DECISIONS
- KANBAN

Operational

Coordinates current work.

Examples

- TODO
- ACTIONS
- PROJECT_STATE

Historical

Records project evolution.

Examples

- SESSION_LOG
- OPERATIONAL_TRACKRECORD

---

# 6. Authority

Authority defines which conversation possesses write responsibility over each
document.

Authority never determines truth.

Authority only determines editing responsibility.

Main Chat

Global authority.

May read every notebook file.

Coordinates every conversation.

Didactic Chat

Authority over learning-related documents.

Design Chat

Authority over structural project documents.

Operational Chat

Authority over execution-related documents.

---

# 7. Canonicity

Canonicity defines which document is considered the official source of knowledge
for a given subject.

Every domain possesses one canonical document.

Derived documents shall never replace canonical documents.

---

# 8. Knowledge Refinement

Knowledge evolves through successive refinement.

Conversation

↓

Development Track

↓

Operational Organization

↓

Canonical Knowledge

↓

Derived Views

↓

Historical Preservation

This process is called Promotion.

---

# 9. Promotion

Promotion is the controlled transformation of information from a temporary state
into an increasingly stable and canonical representation.

Promotion always begins inside DEV_TRACK.

Promotion never occurs directly from conversation into canonical documents.

The promotion workflow is formally specified in PROMOTION_RULES.md.

---

# 10. DEV_TRACK

DEV_TRACK constitutes the staging area of the Sketch Notebook.

Every specialized conversation first materializes its current work inside its
corresponding DEV_TRACK document.

DEV_TRACK documents collect temporary knowledge before organization.

They are persistent during development but continuously reorganized.

They function similarly to Git's staging area.

Conversation

↓

DEV_TRACK

↓

Notebook

↓

Git Commit

---

# 11. Session Lifecycle

Every session follows four conceptual phases.

Read

Consult notebook.

Develop

Perform discussion, implementation or study.

Promote

Organize generated knowledge.

Persist

Update notebook.

---

# 12. Repository Philosophy

Git stores versions.

The repository stores files.

The Sketch Notebook stores knowledge.

The conversations develop knowledge.

The methodology coordinates knowledge evolution.

Together they constitute a persistent cognitive representation of the project.
