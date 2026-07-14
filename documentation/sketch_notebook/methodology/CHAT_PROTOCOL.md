# CHAT_PROTOCOL.md

> Version: 0.2
> Status: Draft
> Persistence Class: Canonical
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Conversational communication patterns and documentation protocols

---

# 1. Purpose

`CHAT_PROTOCOL.md` defines how each conversational role communicates project knowledge.

Whereas:

* `METHOD_FOUNDATIONS.md` defines the philosophy of the Sketch Notebook Method;
* `FLUX.md` defines information routing and responsibilities;
* `PROMOTION_RULES.md` defines semantic promotion of knowledge;

`CHAT_PROTOCOL.md` defines **the structure through which each role expresses that knowledge**.

The protocol exists to produce consistent documentation independently of the current conversation.

---

# 2. General Principles

Protocols define communication style.

They do not define knowledge ownership.

They do not define routing.

They do not define semantic promotion.

Every role should communicate according to its own perspective while preserving consistency between sessions.

Whenever a protocol becomes insufficient, it should evolve rather than forcing ad hoc writing styles.

---

# 3. Main Chat

Main Chat communicates through synthesis.

Typical characteristics include:

* integration of multiple perspectives;
* conflict resolution;
* milestone orchestration;
* methodological refinement;
* architectural consistency checking;
* preparation of Codex materialization.

Its structure intentionally remains flexible.

---

# 4. Operational Chat

Operational Chat communicates through execution.

Typical characteristics include:

* implementation diagnosis;
* dependency identification;
* execution planning;
* reproducible validation;
* risk identification;
* operational evidence.

Operational reports should resemble technical implementation reviews.

---

# 5. Design Chat

Design Chat communicates through architecture.

Typical characteristics include:

* responsibility analysis;
* domain ownership;
* relationship design;
* UI responsibility;
* long-term maintainability;
* implementation boundaries.

Design reports should resemble architectural design reviews.

---

# 6. Didactic Chat

The Didactic Chat follows the most structured protocol in the Sketch Notebook Method.

Its purpose is not only to explain concepts.

Its purpose is to construct persistent project knowledge while simultaneously supporting developer learning.

The Didactic Chat therefore maintains three complementary documentation layers.

---

## Layer 1 — Canonical Concepts

Canonical concepts are stored in:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
```

Each concept shall follow the same structure.

---

### Concept Header

```text
[KANBAN][NUMBER]

Concept Name
```

Example:

```text
&&&03

Referential Integrity
```

---

### Mandatory Sections

Every canonical concept shall contain:

#### Description

A learner-oriented explanation written in natural language.

#### Formal Definition

A precise and reusable definition.

This section should be suitable for later glossary derivation.

#### Practical Example

A technology-independent example.

Its purpose is understanding rather than implementation.

#### Language Implementation

How the concept appears in the implementation language.

For Markei this normally means Python.

#### Project Implementation

How the concept appears inside Markei.

Concrete files, tables, services or UI pages may be referenced.

#### Required Concepts

Previously required concepts.

#### Related Concepts

Connected concepts that are not strict prerequisites.

#### Status

Learning maturity.

Possible values:

```text
Green
Yellow
Red
```

#### Source

The implementation event, discussion, bug, milestone or architectural decision that motivated the lesson.

---

## KANBAN Numbering

Each marker owns an independent sequence.

Example:

```text
&&&01
&&&02
&&&03

&&%01
&&%02

&%%01
&%%02

%%%01
%%%02
```

Numbers are never reused.

---

## Layer 2 — Persistent Derivative

Persistent terminology is stored in:

```text
documentation/sketch_notebook/didactics/07_GLOSSARY.md
```

The glossary is derived from canonical concepts.

It should never introduce independent truth.

Every glossary entry should include:

```text
KANBAN ID

Type

Definition

Project Usage

Related Concepts
```

Example:

```text
Repository Pattern

KANBAN ID
&&&02

Type
Foundational Computer Science

Definition
...

Project Usage
...

Related Concepts
...
```

If a glossary term does not correspond to a KANBAN concept, the entry shall explicitly indicate:

```text
KANBAN ID

None
```

and classify itself as:

```text
Methodological abstraction

Project abstraction

Derived terminology
```

---

## Layer 3 — Concept Map

The Concept Map is stored in:

```text
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

Unlike the glossary, the Concept Map is intentionally ephemeral.

It acts as the current learning checkpoint for:

* the developer;
* future Didactic Chats;
* Main Chat;
* Codex.

Its objective is to minimize bootstrap cost while exposing the current learning state.

The Concept Map should therefore summarize rather than explain.

---

### Recommended Sections

#### Current Milestone

Which implementation milestone is currently being studied.

---

#### Stable Concepts

Concepts considered understood.

Only KANBAN IDs should be listed.

---

#### Active Concepts

Concepts currently being reinforced.

---

#### Unstable Concepts

Concepts requiring further explanation.

---

#### Next Concepts

Immediate recommended learning progression.

---

#### Dependency Spine

Concept dependency tree.

Example:

```text
&&&02
↓

&%%01
↓

&%%04
```

---

#### Project Learning Spine

Current implementation topic that is driving concept introduction.

Example:

```text
Stores
↓

Purchases
↓

Referential Integrity
↓

History
```

---

#### Session Delta

Small summary describing what changed during the latest learning cycle.

---

## Bootstrap Constraint

The Concept Map is the preferred bootstrap surface for future Didactic Chats.

Before reading the complete KANBAN register or glossary, the Didactic Chat should inspect the Concept Map.

Only if additional context is required should it consult:

* `02_KANBAN.md`;
* `07_GLOSSARY.md`.

This minimizes repeated token usage while preserving continuity.

---

# 7. Sequence-Aware Communication Protocol

Every substantial report should identify its controlling FLUX Sequence Protocol.

Required header:

~~~text
Sequence:
Role:
Round or unit:
Branch:
Baseline / inspected HEAD:
Authority:
Writable surfaces:
Evidence boundary:
~~~

The purpose is not ceremonial formatting. It prevents an exploratory report from being mistaken for implementation authority, a pruning report from being mistaken for promotion, or a Codex report from being mistaken for canon.

## 7.1 Ordinary Sequence Communication

FLX-ORD-01 reports should be bounded and terminal.

Functional reports state:

- current evidence;
- domain interpretation;
- contradictions;
- recommendation;
- exact requested materialization outcome.

Main reports state:

- accepted objective;
- controlling D/E/F;
- writable and prohibited scope;
- validation and stop conditions.

Codex reports state:

- physical changes;
- commands and evidence;
- deviations;
- unresolved risks.

Promotion reports state:

- semantic classification;
- permanent destinations;
- checkpoint and Main-continuity effects.

## 7.2 Investigative Sequence Communication

FLX-INV-02 uses cumulative round reports.

A/B/C begin with the round delta:

- newly inspected;
- retained by reference;
- corrected;
- superseded;
- contradicted;
- unresolved;
- prospective;
- deferred.

J groups the three perspectives by project structure, preserves provenance, and avoids copying full domain reports.

Provisional D/E/F act as the active domain cache for the next round. Each file states what was retained, changed, rejected, and still requested.

Each round ends with:

- performance improvement achieved;
- narrower next question;
- evidence still missing;
- human decisions;
- exit readiness.

No investigative output may imply Codex authority unless a separate activation states it explicitly.

## 7.3 Pruning Sequence Communication

FLX-PRN-03 reports by semantic role rather than file order.

For each affected file, state:

- semantic role;
- canonical owner;
- content retained;
- content pruned, summarized, referenced, regenerated, or corrected;
- history disposition;
- current recovery pointer.

Do not describe deletion volume as success by itself. Success is lower recovery cost with preserved meaning and ownership.

The checkpoint report is written last and states one current recovery state.

## 7.4 Promotion/Reconciliation Communication

FLX-PRM-04 reports claims, not merely edits. Use PROMOTION_RULES.md PRC-01 as the minimum semantic cache.

For each material claim, use:

~~~text
Claim:
Prior state:
Evidence:
Evidence boundary:
Contradiction:
Semantic owner:
Target role:
Resulting state:
History disposition:
~~~

Distinguish accepted, implemented, validated, host-unvalidated, blocked, deferred, superseded, and contradicted.

A file list without semantic classification is not a complete promotion report.

## 7.5 Handoff Communication

Every sequence transition ends with the FLUX Sequence Handoff Envelope.

The outgoing role points to detailed evidence rather than reproducing it.

The receiving role reports:

- what was recovered;
- what remains uncertain;
- whether the proposed next sequence is valid;
- whether authority is sufficient.

When two reports disagree, preserve both claims, name the evidence conflict, and route the decision to the semantic owner or human/Main authority. Do not manufacture consensus through blended wording.

---

# 8. Protocol Evolution

Protocols are expected to mature throughout project development.

Stable conventions should eventually become canonical.

Experimental conventions should remain lightweight until validated through repeated use.

The goal of the Chat Protocol is not to standardize wording.

Its goal is to standardize communication structure while preserving the natural reasoning style of each conversational role.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
