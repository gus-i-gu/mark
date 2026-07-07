# PROMOTION_RULES.md

> Version: 0.2
> Status: Draft
> Persistence Class: Canonical
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Knowledge state transitions in the Sketch Notebook Method

---

# 1. Purpose

`PROMOTION_RULES.md` defines how knowledge changes state inside the Sketch Notebook Method.

It does not define file paths, write permissions, commit rules, or exact routing.

Those operational rules belong to `FLUX.md`.

Promotion is semantic.

Flux is operational.

This document answers one primary question:

> How does knowledge evolve from transient conversation into persistent project memory or implementation?

---

# 2. Promotion

Promotion is the controlled transformation of knowledge from one maturity state into another.

Promotion is not merely copying text between files.

A promotion changes the epistemic status of information.

Information may become:

- captured;
- staged;
- synthesized;
- validated;
- canonical;
- derived;
- historical;
- materialized.

Promotion gives structure to the movement from raw conversation toward stable project knowledge.

---

# 3. Promotion vs Materialization

Promotion and materialization are different operations.

## Promotion

Promotion is semantic.

It determines what knowledge means, how mature it is, and which knowledge state it belongs to.

Promotion happens through reasoning and synthesis.

## Materialization

Materialization is physical.

It applies promoted or synthesized knowledge into repository files, source code, markdown documents, or other persistent artifacts.

Materialization is performed by Codex CLI or by explicit human editing.

Promotion decides what should change.

Materialization changes the files.

---

# 4. Knowledge States

The Sketch Notebook Method recognizes the following conceptual knowledge states.

## 4.1 Transient Conversation

Raw dialogue, reasoning, questions, hypotheses, and exploratory thought.

This state is temporary.

Nothing in conversation is persistent until captured.

## 4.2 Functional Stage

Domain-specific staging performed by functional chats.

Functional staging captures useful reasoning from Operational, Didactic, or Design perspectives.

Functional stage material is not canonical.

It is working material awaiting Main synthesis.

## 4.3 Main Synthesis

The Main Chat integrates functional stage material.

It compares domain perspectives, resolves contradictions, extracts conclusions, and prepares coherent materialization instructions.

Main synthesis transforms multiple staged reports into coordinated project direction.

## 4.4 Materialization Stage

Main-approved staging prepared for Codex or human implementation.

Materialization stage material may include:

- patch instructions;
- notebook update proposals;
- application implementation plans;
- command sequences;
- conceptual updates to be written into permanent folders.

Materialization stage is still not the final project memory.

It is the instruction layer before physical change.

## 4.5 Canonical Knowledge

Validated knowledge accepted as authoritative within its domain.

Canonical knowledge belongs in permanent notebook memory.

Examples include architectural decisions, method specifications, KANBANs, domain models, and stable operational references.

## 4.6 Derived Knowledge

Views, summaries, maps, indexes, or snapshots generated from canonical knowledge.

Derived knowledge should not introduce independent truth.

It reorganizes what is already canonical.

## 4.7 Observational Record

Append-only records of what happened.

Observational records preserve the sequence of work, actions, and sessions.

They do not define current truth.

---

# 5. Conceptual Promotion Lifecycle

The general lifecycle is:

```text
Transient Conversation
↓
Functional Stage
↓
Main Synthesis
↓
Materialization Stage
↓
Materialization
↓
Canonical / Operational / Derived / Observational Memory
↓
Persistence
```

This lifecycle may be shortened for small tasks, but it should not be bypassed when knowledge affects project structure, methodology, learning, or implementation.

---

# 6. Capture

Capture is the transition from transient conversation into staged material.

Capture exists to prevent useful reasoning from disappearing inside chat history.

Captured material may be incomplete, uncertain, or exploratory.

Capture does not imply approval.

Capture only means:

> This information may matter later.

---

# 7. Classification

Classification determines what kind of knowledge has been captured.

Typical classifications include:

- operational action;
- bug report;
- design observation;
- architectural decision candidate;
- didactic concept;
- glossary candidate;
- methodology refinement;
- implementation instruction;
- historical event.

Classification does not make knowledge canonical.

It only identifies the appropriate semantic domain.

---

# 8. Validation

Validation determines whether staged knowledge is stable enough to move forward.

Before promotion, the system should ask:

1. Is the information clear?
2. Is it useful?
3. Is it sufficiently supported by evidence or reasoning?
4. Does it belong to this domain?
5. Does another canonical source already own this knowledge?
6. Is it ready to affect permanent memory or implementation?

Unvalidated knowledge should remain staged or be discarded.

---

# 9. Synthesis

Synthesis combines staged material into coherent direction.

Synthesis is mainly performed by the Main Chat.

Synthesis may:

- merge functional reports;
- resolve conflicts;
- choose an implementation direction;
- prepare Codex instructions;
- determine notebook updates;
- decide that more investigation is required.

Synthesis is the bridge between functional reasoning and materialization.

---

# 10. Canonical Promotion

Canonical promotion occurs when knowledge becomes the authoritative reference for its domain.

Examples:

- a design proposal becomes a decision;
- a recurring concept becomes a KANBAN;
- a methodological insight becomes part of a methodology specification;
- an implementation boundary becomes part of architecture documentation.

Canonical promotion should be careful and deliberate.

A canonical document should not receive raw, uncertain, or contradictory material.

---

# 11. Derived Generation

Derived generation occurs after canonical knowledge changes.

Derived documents should be regenerated or revised to reflect canonical updates.

Derived generation may produce:

- project state summaries;
- concept maps;
- glossary references;
- current action views;
- navigation indexes.

Derived documents are useful views.

They are not independent sources of truth.

---

# 12. Observational Recording

Observational recording preserves what happened.

It should record events, not redefine knowledge.

Examples of observational entries include:

- session summaries;
- execution attempts;
- test results;
- materialization events;
- decisions accepted or postponed;
- promotions performed.

Observational records should generally be append-only.

---

# 13. Promotion Directions

Promotion may occur in two conceptual directions.

## 13.1 Vertical Promotion

Vertical promotion changes maturity.

Example:

```text
Raw observation
↓
staged report
↓
validated conclusion
↓
canonical decision
↓
derived summary
```

Vertical promotion answers:

> How mature is this knowledge?

## 13.2 Horizontal Promotion

Horizontal promotion changes domain ownership or perspective.

Example:

```text
Operational bug discovery
→ Design architecture review
```

or:

```text
Design pattern discussion
→ Didactic KANBAN candidate
```

Horizontal promotion answers:

> Which domain should own this knowledge?

Horizontal promotion may happen before or during vertical promotion.

---

# 14. Promotion Integrity Rules

## Rule 1 — Conversation is not persistence

A fact, idea, decision, or concept is not part of project memory until captured or materialized.

## Rule 2 — Staging is not canon

Stage material may be useful, but it is not authoritative.

## Rule 3 — Canonical ownership must be unique

Each stable knowledge object should have one canonical home.

Duplicate canonical truth creates drift.

## Rule 4 — Derived knowledge cannot create truth

Derived documents summarize or reorganize.

They do not establish new facts.

## Rule 5 — Historical records do not define truth

Historical records preserve sequence and evidence.

They do not determine current project state.

## Rule 6 — Materialization requires synthesis

Permanent repository changes should follow Main synthesis or explicit human instruction.

## Rule 7 — Methodology changes require methodological context

Changes to methodology specifications should happen only during explicit methodology work.

---

# 15. Relationship with FLUX

`PROMOTION_RULES.md` defines semantic transformation.

`FLUX.md` defines operational routing.

This document intentionally avoids exact filenames, writable paths, and commit scopes except when referencing the conceptual role of stage, synthesis, and materialization.

If a question asks:

> What does this knowledge become?

consult `PROMOTION_RULES.md`.

If a question asks:

> Which file may write where?

consult `FLUX.md`.

---

# 16. Relationship with METHOD_FOUNDATIONS

`METHOD_FOUNDATIONS.md` defines what the Sketch Notebook Method is.

`PROMOTION_RULES.md` defines how knowledge changes state inside that method.

Promotion depends on the ontology defined by `METHOD_FOUNDATIONS.md`.

It should not redefine the method's ontology.

---

# 17. Closing Principle

Promotion is the discipline that prevents conversation from becoming chaos.

It allows ideas to pass through capture, validation, synthesis, and materialization without confusing raw thought, staged material, canonical knowledge, derived views, and historical memory.
