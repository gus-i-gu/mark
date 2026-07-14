# PROMOTION_RULES.md

> Version: 0.4
> Status: Draft
> Persistence Class: Canonical
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Knowledge-state transitions, promotion integrity, and reconciliation constraints in the Sketch Notebook Method

---

# 1. Purpose

`PROMOTION_RULES.md` defines how knowledge changes semantic state inside the Sketch Notebook Method.

It answers one primary question:

> What does this knowledge become?

It also defines the reconciliation constraints that prevent the same semantic knowledge from being duplicated, contradicted, or rephrased into drift across files.

It does not define:

- exact file paths;
- write authority;
- commit rules;
- boot order;
- staging filenames;
- Codex report filenames;
- domain checkpoint filenames;
- read-window procedure;
- Landline Marks;
- operational recovery-cost thresholds.

Those operational rules belong to `FLUX.md`.

`METHOD_FOUNDATIONS.md` defines the ontology of the method.

`FLUX.md` defines routing and authority.

`CHAT_PROTOCOL.md` defines communication structure.

`PROMOTION_RULES.md` defines semantic transformation and reconciliation discipline.

---

# 1A. Promotion Cache — PRC-01

PRC-01 is the low-cost semantic cache for ordinary sequence decisions.

It does not replace the complete rules below. It allows prompts to verify routine classification and promotion without rereading the entire file.

Read deeper sections only when PRC-01 cannot resolve a named contradiction, ownership question, maturity transition, or methodology change.

## PRC-01.1 Claim-State Vocabulary

| State | Meaning | Does not prove |
| --- | --- | --- |
| candidate | captured as potentially relevant | correctness, acceptance, or destination |
| proposed | a concrete option has been stated | selection |
| provisional | classified working knowledge awaiting acceptance or evidence | canon or implementation authority |
| accepted | an authorized semantic decision may be depended on within its stated boundary | implementation or validation |
| implemented | repository behavior or structure exists | correct execution, platform acceptance, or learner maturity |
| validated | named evidence passed within a stated environment and scope | broader platform or production acceptance |
| host-unvalidated | the relevant host could not establish the claim | product failure or success |
| blocked | a named gate prevents progress | rejection |
| deferred | intentionally assigned to a later boundary | completion |
| superseded | replaced for current use while retained as history | historical erasure |
| contradicted | relevant evidence disagrees and requires resolution | automatic choice of either side |

Never collapse these states.

## PRC-01.2 Semantic Destination Cache

| Destination | Owns | Must not do |
| --- | --- | --- |
| Functional stage | current domain investigation and alternatives | claim canon |
| Main/J synthesis | cross-domain grouping, contradiction, current investigative cache | replace domain canon |
| D/E/F | provisional investigation cache or controlling materialization instructions, as explicitly marked | mix provisional and active authority |
| G/H/I | materialization evidence | promote itself |
| Canonical | one domain’s stable accepted truth | preserve raw chronology or speculation |
| Derived | reorganized explanation, map, index, or TODO from accepted owners | create truth |
| Checkpoint | compact current-state recovery | become canon, history, or full rationale |
| Observational | chronology, evidence, decisions, failures, corrections | define current truth alone |
| Main continuity | global state, session history, and forward recovery | replace domain ownership |

## PRC-01.3 Required Classification Record

Before promotion, record:

~~~text
Claim:
Source:
Current state:
Evidence:
Evidence boundary:
Contradictions:
Semantic owner:
Target role:
History disposition:
Confidence:
Human/Main authority:
Required regeneration:
Result:
~~~

If any required field is unknowable and materially affects the result, promotion stops or remains provisional.

## PRC-01.4 Integrity Gates

A promotion is invalid when any of the following is true:

1. conversation is treated as persistence;
2. staging is treated as canon;
3. Codex evidence is copied into canon without interpretation;
4. implementation is called validated without named evidence;
5. project evidence is treated as learner maturity;
6. two permanent files claim the same canonical meaning;
7. derived knowledge or a checkpoint creates an independent fact;
8. an observational record is rewritten as current truth;
9. Main-root state replaces a domain owner;
10. cross-domain repetition lacks a distinct perspective;
11. a correction erases useful history;
12. a materialized file change is treated as semantic acceptance;
13. a proposed, blocked, deferred, contradicted, or host-unvalidated claim is promoted as accepted or validated;
14. a new file or rename bypasses FLUX authority;
15. methodology changes occur outside explicit methodological context.

## PRC-01.5 Evidence Gate

Use the narrowest evidence sufficient for the claim.

Examples:

| Claim | Minimum evidence class |
| --- | --- |
| code exists | repository inspection |
| unit behavior works | named passing unit test |
| platform build works | named successful platform build |
| manual workflow works | recorded manual observation |
| migration preserves data | representative migration and reopen evidence |
| synchronization works | real upload/download/convergence evidence, not a local queue |
| learner maturity changed | explicit learner explanation or application evidence under Didactic criteria |
| architecture accepted | authorized decision plus coherent responsibility and dependency evidence |
| operational model accepted | repeatable or adequately evidenced execution rule |

Evidence must keep environment, scope, date/head, and known exclusions visible.

## PRC-01.6 Promotion Order

For full domain reconciliation:

~~~text
Observational
    preserve event and evidence
↓
Canonical
    accept or correct stable truth
↓
Derived
    regenerate from accepted owners
↓
Checkpoint
    regenerate current recovery state
↓
Main continuity
    summarize only when global state changed
~~~

A valid run may conclude:

~~~text
no canonical change
derived refresh only
checkpoint refresh only
observational append only
promotion blocked
further investigation required
~~~

## PRC-01.7 Sequence Binding

- FLX-ORD-01 invokes PRC-01 after G/H/I or an accepted direct change.
- FLX-INV-02 uses PRC-01 to keep round claims provisional and distinct; it does not promote merely through repetition.
- FLX-PRN-03 uses PRC-01 when pruning exposes an ownership conflict or semantic correction.
- FLX-PRM-04 is the controlling promotion sequence and must complete the Required Classification Record.

## PRC-01.8 Deeper Reading Index

Read only the targeted section needed:

| Question | Read |
| --- | --- |
| knowledge-state meaning | Sections 2–5 |
| domain and semantic-role classification | Sections 6–9 |
| validation and synthesis | Sections 10–11 |
| canonical/derived/checkpoint/observational handling | Sections 12–15 |
| Codex report absorption and drift | Sections 16–17 |
| vertical/horizontal reconciliation or duplicate ownership | Section 18 |
| promotion direction | Section 19 |
| domain-specific promotion | Section 20 |
| structural gaps | Section 21 |
| non-negotiable integrity rules | Section 22 |
| relationship with routing or communication | Sections 24–25 |

---

# 2. Promotion

Promotion is the controlled transformation of knowledge from one maturity state into another.

Promotion is not merely copying text between files.

Promotion changes the epistemic status of information.

A piece of knowledge may become:

```text
captured
staged
classified
validated
synthesized
canonical
derived
checkpointed
observational
materialized
reconciled
```

Promotion gives structure to the movement from transient conversation toward durable project memory, implementation, or historical record.

---

# 3. Promotion vs Materialization

Promotion and materialization are different operations.

## 3.1 Promotion

Promotion is semantic.

It determines:

- what the knowledge means;
- how mature the knowledge is;
- which domain owns it;
- whether it is canonical, derived, checkpoint, observational, or staged;
- whether it should affect implementation or memory.

Promotion happens through reasoning, classification, validation, synthesis, and reconciliation.

## 3.2 Materialization

Materialization is physical.

It changes files.

Materialization may affect:

- source code;
- notebook files;
- stage files;
- domain folders;
- methodology files;
- repository structure.

Materialization is performed by Codex, explicit human editing, or other authorized file-editing processes.

## 3.3 Relationship

Promotion decides what a change means.

Materialization applies a change to files.

A materialized change is not automatically semantically valid.

A promoted conclusion is not persistent until it is materialized or otherwise recorded in the appropriate notebook memory.

---

# 4. Knowledge States

The Sketch Notebook Method recognizes several knowledge states.

These states are semantic.

Exact paths and writable locations are defined by `FLUX.md`.

---

## 4.1 Transient Conversation

Transient Conversation is raw dialogue.

It may include:

- ideas;
- doubts;
- questions;
- explanations;
- hypotheses;
- plans;
- arguments;
- exploratory reasoning.

This state is temporary.

Nothing in conversation is persistent project memory until captured, staged, materialized, or recorded.

---

## 4.2 Captured Knowledge

Captured Knowledge is information identified as potentially relevant.

Capture exists to prevent useful reasoning from disappearing inside chat history.

Capture does not imply approval.

Capture only means:

> This may matter later.

Captured knowledge may be incomplete, uncertain, contradictory, or exploratory.

---

## 4.3 Classified Knowledge

Classified Knowledge has been assigned a semantic domain or role.

Classification answers:

> What kind of knowledge is this?

Common classifications include:

- operational action;
- operational observation;
- operational model candidate;
- didactic concept;
- glossary candidate;
- learning observation;
- design observation;
- architectural decision candidate;
- derived summary candidate;
- checkpoint update;
- methodology refinement;
- implementation instruction;
- historical event;
- structural gap;
- drift report.

Classification does not make knowledge canonical.

It only identifies what kind of handling it requires.

---

## 4.4 Functional Stage

Functional Stage is domain-specific staging performed by functional chats.

Functional staging captures current reasoning from:

- Operational Chat;
- Didactic Chat;
- Design Chat.

Functional stage material is not canonical.

It is working material awaiting Main synthesis, domain-memory update, or later reconciliation.

---

## 4.5 Main Synthesis

Main Synthesis is the integration of staged material by Main Chat.

Main synthesis may:

- compare functional reports;
- resolve contradictions;
- detect drift;
- choose implementation direction;
- prepare materialization instructions;
- determine notebook update requirements;
- defer unresolved questions.

Main synthesis transforms multiple domain perspectives into coherent project direction.

---

## 4.6 Materialization Stage

Materialization Stage is Main-approved instruction before physical change.

It may include:

- patch instructions;
- application implementation plans;
- notebook update proposals;
- command sequences;
- validation instructions;
- domain-memory update instructions;
- methodology update instructions.

Materialization stage material is not final memory.

It is the instruction layer before physical materialization.

---

## 4.7 Codex Report Stage

Codex Report Stage is post-materialization evidence.

It records what Codex actually did.

It may include:

- files changed;
- files created;
- files deleted;
- commands run;
- validation results;
- skipped instructions;
- failed instructions;
- unresolved risks;
- suggested follow-up.

Codex report material is observational evidence.

It is not canonical knowledge.

It becomes useful when functional chats classify it, domain files absorb it, and Main Chat reconciles it.

---

## 4.8 Canonical Knowledge

Canonical Knowledge defines accepted truth within a domain.

Canonical knowledge should be:

- validated;
- stable enough to depend on;
- owned by one domain;
- free from unresolved contradiction;
- revisable only through deliberate update.

Examples include:

- methodology principles;
- didactic KANBAN concepts;
- architecture rules;
- accepted design decisions;
- operational models;
- domain models;
- stable responsibility boundaries.

Canonical knowledge belongs in permanent domain memory.

---

## 4.9 Derived Knowledge

Derived Knowledge reorganizes, summarizes, indexes, maps, or explains canonical knowledge.

Derived knowledge does not create independent truth.

It depends on canonical knowledge.

Examples include:

- glossary entries;
- model overviews;
- concept maps;
- TODO views;
- project-state summaries;
- navigation summaries.

If derived knowledge contradicts canonical knowledge, the derived knowledge is stale or invalid unless the canonical file is also being revised through an authorized process.

---

## 4.10 Domain Checkpoint

A Domain Checkpoint is ephemeral derived knowledge optimized for recovery.

It summarizes the current state of a domain so a role can recover context without reading all canonical, derived, observational, or repository material.

A checkpoint should answer:

- where the domain currently stands;
- what is stable;
- what is active;
- what is unresolved;
- what recently changed;
- what should be read next if deeper context is required.

A checkpoint does not introduce independent truth.

A checkpoint should be refreshed when domain state changes.

A checkpoint may become stale.

A stale checkpoint should be regenerated from canonical, derived, observational, and implementation evidence.

---

## 4.11 Observational Record

An Observational Record preserves what happened.

It records:

- actions;
- sessions;
- lectures;
- decisions;
- validation attempts;
- failures;
- materialization events;
- human overrides;
- drift observations;
- reconciliation events.

Observational records do not define current truth by themselves.

They preserve sequence and evidence.

They should generally be append-oriented.

---

## 4.12 Reconciled Knowledge

Reconciled Knowledge has been checked against other relevant project-memory layers.

Reconciliation may compare:

- checkpoint state;
- canonical domain knowledge;
- derived domain knowledge;
- observational history;
- stage files;
- Codex reports;
- source code;
- human direction.

Reconciled knowledge may produce:

- canonical correction;
- derived regeneration;
- checkpoint refresh;
- observational note;
- new TODO;
- design revision;
- didactic update;
- operational update;
- methodology refinement.

Reconciliation does not always promote knowledge.

Sometimes it confirms that no change is needed.

Sometimes it detects drift.

---

# 5. Conceptual Promotion Lifecycle

The general lifecycle is:

```text
Transient Conversation
↓
Capture
↓
Classification
↓
Functional Stage
↓
Main Synthesis
↓
Materialization Stage
↓
Materialization
↓
Codex Report Stage
↓
Domain Classification
↓
Canonical / Derived / Checkpoint / Observational Memory
↓
Reconciliation
↓
Persistence
```

This lifecycle may be shortened for small tasks.

It should not be bypassed when knowledge affects:

- methodology;
- project architecture;
- learning state;
- implementation behavior;
- domain memory;
- file structure;
- source code;
- durable project direction.

---

# 6. Domain Symmetry and Promotion

Every functional domain should expose four semantic roles:

```text
Canonical Knowledge
Derived Knowledge
Domain Checkpoint
Observational History
```

Promotion must respect these roles.

The same event may produce updates in more than one role.

Example:

```text
A new architectural decision is accepted.
↓
Canonical: architecture file updated.
Observational: decision log entry appended.
Derived: model overview refreshed.
Checkpoint: design state refreshed.
```

A single file should not permanently carry incompatible semantic roles if doing so creates drift.

Canonical files should be able to improve definitions.

Observational files should preserve historical sequence.

Derived files should summarize truth without creating it.

Checkpoints should remain compact and recoverable.

---

# 7. Hierarchical Recovery and Promotion

The Hierarchical Recovery Principle affects how promotion is validated.

Before promoting new knowledge, the system should prefer the least expensive sufficient source.

The recovery order is:

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

This order is not a proof hierarchy.

It is a recovery-cost hierarchy.

For promotion decisions:

- a checkpoint may identify the current state;
- canonical knowledge determines stable truth;
- derived knowledge explains or summarizes canonical truth;
- observational history explains how the current state emerged;
- repository inspection verifies implementation reality when needed.

A checkpoint alone should not be treated as canonical evidence.

A derived summary alone should not override canonical knowledge.

An observational record alone should not define current truth.

Repository inspection may override notebook assumptions when implementation truth contradicts project memory, but that contradiction should be recorded as drift and reconciled.

---

# 8. Capture

Capture is the transition from transient conversation into potentially useful memory.

Capture may occur when:

- a user proposes a new direction;
- a bug exposes a concept;
- a design question appears;
- a command fails;
- a new relationship is discovered;
- Codex reports a materialization result;
- a chat identifies drift;
- a recurring term needs definition.

Captured knowledge should be preserved in the appropriate stage, report, log, or domain file according to `FLUX.md`.

Capture does not validate.

Capture does not promote to canon.

Capture only prevents loss.

---

# 9. Classification

Classification determines what kind of knowledge has been captured.

Classification asks:

```text
Which domain owns this?
Which semantic role does it serve?
How mature is it?
What should happen next?
```

Classification dimensions include:

## 9.1 Domain Classification

Possible domain classifications include:

```text
operational
didactic
design
methodological
main/global
implementation/source
```

## 9.2 Semantic Role Classification

Possible semantic-role classifications include:

```text
canonical
derived
checkpoint
observational
stage
materialization instruction
Codex report evidence
structural gap
drift
```

## 9.3 Maturity Classification

Possible maturity classifications include:

```text
raw
captured
staged
validated
accepted
deferred
rejected
superseded
stale
reconciled
```

Classification is required before durable promotion.

---

# 10. Validation

Validation determines whether knowledge is stable enough to move forward.

Before promotion, the system should ask:

1. Is the information clear?
2. Is it useful?
3. Is it sufficiently supported by evidence or reasoning?
4. Does it belong to this domain?
5. Does another canonical source already own this knowledge?
6. Is it consistent with current checkpoints?
7. Is it consistent with canonical files?
8. Is it consistent with derived files?
9. Is it consistent with observational evidence?
10. Is repository inspection required?
11. Is it ready to affect permanent memory or implementation?

Unvalidated knowledge should remain staged, remain observational, be marked as unresolved, or be discarded.

---

# 11. Synthesis

Synthesis combines classified and validated material into coherent direction.

Synthesis is mainly performed by Main Chat.

Synthesis may:

- merge functional reports;
- resolve contradictions;
- identify drift;
- choose an implementation direction;
- prepare Codex instructions;
- determine domain-memory updates;
- determine checkpoint refresh needs;
- decide that more investigation is required.

Synthesis is the bridge between functional reasoning and materialization.

Synthesis does not automatically make knowledge canonical.

Canonical promotion still requires domain-appropriate validation and placement.

---

# 12. Canonical Promotion

Canonical Promotion occurs when knowledge becomes accepted truth within a domain.

Examples:

- a recurring concept becomes a KANBAN entry;
- a stable architecture rule enters architecture documentation;
- an operational convention becomes part of the operational model;
- a methodology principle becomes part of methodology specification;
- a domain relationship becomes an accepted design decision.

Canonical promotion should be careful and deliberate.

A canonical document should not receive raw, uncertain, or contradictory material.

Canonical promotion should identify:

- the domain owner;
- the canonical home;
- supporting evidence;
- affected derived files;
- affected checkpoints;
- relevant observational records;
- whether repository verification is required.

Canonical knowledge may be revised.

Revision should preserve historical explanation through observational records when the change is significant.

---

# 13. Derived Generation

Derived Generation occurs when canonical knowledge is reorganized into a useful view.

Derived generation may produce or refresh:

- glossary entries;
- model overviews;
- concept maps;
- TODO views;
- project state summaries;
- architecture summaries;
- navigation summaries.

Derived documents are useful views.

They are not independent sources of truth.

Derived generation should occur when:

- canonical knowledge changes;
- derived material becomes stale;
- Main reconciliation detects drift;
- a checkpoint needs compact support material;
- a domain requires easier recovery or explanation.

If derived material conflicts with canonical material, the derived material should be corrected or regenerated.

---

# 14. Checkpoint Refresh

Checkpoint Refresh occurs when a domain checkpoint is updated to reflect the current state of a domain.

Checkpoint refresh is a form of derived generation.

It is optimized for low-token recovery.

Checkpoint refresh may summarize:

- stable canonical state;
- active work;
- recent changes;
- unresolved issues;
- drift;
- next files to inspect;
- next likely actions or concepts.

A checkpoint should not become:

- a canonical register;
- a long historical log;
- a replacement for domain files;
- a place for independent truth.

Checkpoint refresh should happen after:

- Codex report classification;
- domain-memory updates;
- canonical promotion;
- derived regeneration;
- important observational recording;
- Main reconciliation;
- meaningful implementation changes.

A checkpoint may remain empty or minimal when the domain itself has not yet been initialized.

---

# 15. Observational Recording

Observational Recording preserves what happened.

It should record events, not redefine truth.

Examples include:

- session summaries;
- execution attempts;
- test results;
- materialization events;
- decisions accepted or postponed;
- concepts introduced;
- misconceptions detected;
- Codex reports;
- promotions performed;
- reconciliation events.

Observational records should generally be append-oriented.

Observational records may later support canonical promotion, but they do not become canonical merely because they are recorded.

---

# 16. Codex Report Absorption

Codex Report Absorption is the process of interpreting G/H/I report evidence after materialization.

Codex reports should be treated as observational evidence.

Functional chats should classify Codex report content into domain roles:

```text
canonical update candidate
derived update candidate
checkpoint refresh
observational record
structural gap
drift
future TODO
```

Codex reports should not be copied blindly into permanent memory.

They should be interpreted by the appropriate functional chat.

Main Chat then reconciles domain updates with global project state.

---

# 17. Drift Detection

Drift occurs when two or more project-memory layers disagree.

Examples:

- checkpoint contradicts canonical file;
- derived file omits new canonical knowledge;
- observational history says something changed but checkpoint does not reflect it;
- repository implementation differs from notebook memory;
- Codex report says an instruction failed but stage files imply success;
- human direction supersedes notebook state;
- old filenames remain referenced after methodological rename.

Drift is not automatically failure.

Drift is a signal that reconciliation is required.

Drift should be classified as:

```text
checkpoint drift
derived drift
canonical drift
observational gap
implementation drift
routing drift
methodology drift
naming drift
```

---

# 18. Reconciliation Rules

Reconciliation compares project-memory layers and resolves or records drift.

Promotion answers:

> What does this knowledge become?

Reconciliation answers:

> Does this knowledge remain coherent after being translated across domains, semantic roles, files, implementation, and time?

Reconciliation is not merely a final step after Codex.

It may occur during capture, classification, validation, synthesis, domain-memory absorption, checkpoint refresh, methodology revision, and session closure.

The goal of reconciliation is complementarity, not repetition.

---

## 18.1 Reconciliation Inputs

Reconciliation may compare:

- checkpoint state;
- canonical domain knowledge;
- derived domain knowledge;
- observational history;
- functional stage files;
- Main materialization stage files;
- Codex reports;
- Main-root continuity files;
- source code;
- human direction.

Reconciliation should use the least expensive sufficient source first, but it may inspect deeper evidence when drift, uncertainty, or implementation truth requires it.

---

## 18.2 Reconciliation Questions

Reconciliation asks:

1. Does the checkpoint reflect canonical state?
2. Does derived knowledge reflect canonical knowledge?
3. Does observational history explain how the current state emerged?
4. Does repository state agree with notebook memory?
5. Did materialization match Main-approved instructions?
6. Did human direction override prior knowledge?
7. Are filenames and routes still canonical?
8. Are domain roles still distinguishable?
9. Does any file duplicate semantic authority already owned elsewhere?
10. Does any summary restate canon so fully that it becomes duplicate canon?
11. Does any observational record get rewritten as current truth?
12. Does any checkpoint teach, justify, or preserve history instead of recovering state?
13. Does Main-root state summarize global truth without replacing domain ownership?

---

## 18.3 Vertical Reconciliation

Vertical reconciliation checks whether knowledge remains coherent across semantic layers and time.

Typical vertical chain:

```text
observational evidence
↓
canonical / derived updates
↓
checkpoint refresh
↓
global project state
```

Vertical reconciliation asks whether each layer reflects the correct semantic maturity.

Examples:

- Codex evidence should be interpreted before becoming domain memory.
- Canonical files should preserve stable truth rather than raw reports.
- Derived files should reorganize canon without creating new truth.
- Checkpoints should summarize current state without becoming registers.
- `00_PROJECT_STATE.md` should summarize global state without duplicating domain files.

---

## 18.4 Horizontal Reconciliation

Horizontal reconciliation checks whether domains remain complementary rather than contradictory.

Typical horizontal chain:

```text
Operational ↔ Didactic ↔ Design ↔ Main
```

Horizontal reconciliation asks whether each domain speaks from its own responsibility.

Examples:

- Operational memory should own execution state, validation facts, implementation risks, and TODO pressure.
- Design memory should own architecture, boundaries, responsibility decisions, and model relationships.
- Didactic memory should own learning concepts, glossary development, concept dependencies, and lecture history.
- Main memory should own global coherence, session closure, cross-domain reconciliation, and next-session continuity.

A shared event may appear in several domains, but each appearance must use the domain's own semantic language.

Shared events should not be copied verbatim across domains unless the copied passage is explicitly quoted as evidence.

---

## 18.5 Duplicate Semantic Data Constraints

Duplicate semantic data occurs when two or more files attempt to own the same meaning at the same authority level.

Duplicate semantic data is not the same as cross-reference.

Allowed repetition includes:

- a checkpoint briefly pointing to canonical truth;
- a derived file summarizing canon;
- an observational record preserving what happened;
- Main-root state summarizing global current state;
- several domains interpreting the same event from different responsibilities.

Prohibited duplication includes:

- two canonical files claiming ownership of the same stable rule;
- a derived file restating canonical truth so fully that it becomes an alternate canon;
- a checkpoint containing enough detail to replace canonical, derived, or observational files;
- an observational file being rewritten to serve as current-state canon;
- a Main-root file duplicating full domain truth;
- stage-file language being copied into permanent memory without classification.

When duplicate semantic data is detected, the system should choose one canonical owner and convert the other occurrence into:

- a reference;
- a summary;
- a derived view;
- a checkpoint note;
- an observational record;
- a drift report;
- or a removal candidate under Main-approved revision.

---

## 18.6 Reconciliation Outputs

Reconciliation may result in:

- no change;
- checkpoint refresh;
- derived regeneration;
- canonical correction;
- observational note;
- new TODO;
- design revision;
- didactic update;
- operational update;
- methodology refinement;
- source-code correction;
- stage-file correction;
- duplicate-content pruning;
- ownership clarification;
- structural-gap report.

Reconciliation should preserve history when correcting current truth.

Correcting a current-state file should not erase useful historical evidence from observational records.

---

## 18.7 Reconciliation Failure Modes

Reconciliation has failed or remains incomplete when:

- drift is noticed but not classified;
- duplicate semantic ownership remains unresolved;
- a checkpoint contradicts canonical state;
- a derived file contradicts canon;
- an observational record is treated as current truth;
- Main-root state overrides domain ownership;
- stage text is copied into canon without classification;
- implementation reality contradicts notebook memory without a drift note;
- a file is expanded to solve a contradiction that should have been resolved by ownership clarification.

When reconciliation cannot be completed, the unresolved contradiction should be recorded explicitly rather than hidden by verbose restatement.

---

# 19. Promotion Directions

Promotion may occur in several directions.

## 19.1 Vertical Promotion

Vertical Promotion changes maturity.

Example:

```text
Raw observation
↓
Captured note
↓
Functional stage
↓
Validated conclusion
↓
Canonical knowledge
↓
Derived summary
↓
Checkpoint refresh
```

Vertical promotion answers:

> How mature is this knowledge?

## 19.2 Horizontal Promotion

Horizontal Promotion changes domain ownership or perspective.

Example:

```text
Operational bug discovery
→ Design architecture review
```

or:

```text
Design relationship decision
→ Didactic KANBAN candidate
```

Horizontal promotion answers:

> Which domain should own or interpret this knowledge?

## 19.3 Reflective Promotion

Reflective Promotion updates the methodology itself.

Example:

```text
Repeated file drift
↓
Methodological observation
↓
Main synthesis
↓
FLUX update
```

Reflective promotion answers:

> Does the method itself need to change?

Reflective promotion should be rare and human-supervised.

---

# 20. Domain-Specific Promotion

## 20.1 Operational Promotion

Operational promotion may transform:

- failed command → operational record;
- repeated validation procedure → operational model;
- current blocker → operational state;
- deferred action → TODO;
- Codex implementation evidence → operational record or state update.

Operational canonical promotion belongs to stable operational knowledge.

Operational observation belongs to operational history.

Operational state belongs to the operational checkpoint.

## 20.2 Didactic Promotion

Didactic promotion may transform:

- implementation problem → concept candidate;
- recurring concept → KANBAN entry;
- concept definition → glossary entry;
- current learning dependency → concept map;
- lecture event → lecture register;
- misconception → learning observation.

Didactic canonical promotion should preserve KANBAN numbering and concept identity.

Didactic derived generation should not create new concept truth.

## 20.3 Design Promotion

Design promotion may transform:

- design observation → decision candidate;
- accepted responsibility boundary → architecture;
- postponed decision → decision log;
- model summary → model overview;
- current architecture state → design checkpoint;
- implementation contradiction → design drift.

Design canonical promotion belongs in architecture or other accepted design canonical files.

Design observational recording belongs in decision history.

Design checkpoint refresh belongs in design state.

## 20.4 Methodological Promotion

Methodological promotion may transform:

- repeated workflow failure → method issue;
- recurring vocabulary ambiguity → method glossary entry;
- routing ambiguity → FLUX update;
- concept-state ambiguity → PROMOTION_RULES update;
- communication inconsistency → CHAT_PROTOCOL update;
- foundational ambiguity → METHOD_FOUNDATIONS update.

Methodological promotion must be deliberate.

It should be supervised by Main Chat and the human developer.

---

# 21. Structural Gaps

A Structural Gap exists when the method requires a semantic role but the repository does not yet provide an adequate file, route, or protocol.

Examples:

- a domain lacks observational history;
- a domain checkpoint exists but is empty or structurally unusable;
- a canonical file is missing for a required domain role;
- a methodology term is used but not defined;
- a file rename occurred but old references remain;
- a functional chat is responsible for a duty but has no protocol.

Structural gaps should not be silently patched by arbitrary file creation.

They should be reported, synthesized, and materialized through the authority defined by `FLUX.md`.

---

# 22. Promotion Integrity Rules

## Rule 1 — Conversation is not persistence

A fact, idea, decision, or concept is not part of project memory until captured, staged, recorded, or materialized.

## Rule 2 — Staging is not canon

Stage material may be useful, but it is not authoritative.

## Rule 3 — Codex reports are evidence, not canon

G/H/I reports describe materialization evidence.

They must be interpreted before becoming domain memory.

## Rule 4 — Canonical ownership must be unique

Each stable knowledge object should have one canonical home.

Duplicate canonical truth creates drift.

## Rule 5 — Derived knowledge cannot create truth

Derived documents summarize, reorganize, map, or explain.

They do not establish independent facts.

## Rule 6 — Checkpoints cannot create truth

Domain checkpoints summarize current domain state for recovery.

They do not override canonical files.

## Rule 7 — Observational records do not define current truth

Historical records preserve sequence and evidence.

They do not determine current project state by themselves.

## Rule 8 — Materialization requires synthesis

Permanent repository changes should follow Main synthesis or explicit human instruction.

## Rule 9 — Methodology changes require methodological context

Changes to methodology specifications should happen only during explicit methodological work.

## Rule 10 — File creation and renaming require routing authority

New files and file renames must follow `FLUX.md`.

Semantic need alone does not authorize arbitrary file creation.

## Rule 11 — Reconciliation preserves history

Correcting current truth should not erase useful historical evidence.

## Rule 12 — Reconciliation prunes duplicate ownership

When the same stable meaning appears in multiple authority-bearing files, reconciliation should identify the canonical owner and convert the others into summaries, references, derived views, checkpoint notes, or observational history.

## Rule 13 — Cross-domain repetition must be perspectival

The same event may appear in more than one domain only when each domain interprets it from its own responsibility.

Verbatim duplication across domains should be avoided unless explicitly quoted as evidence.

## Rule 14 — Main-root state summarizes, it does not replace domains

Main-root current-state files may summarize global truth, but they must not become substitute operational, didactic, or design canon.

---

# 23. Relationship with METHOD_FOUNDATIONS

`METHOD_FOUNDATIONS.md` defines what the Sketch Notebook Method is.

It defines foundational ontology, including:

- project memory;
- knowledge domains;
- Domain Symmetry;
- Domain Checkpoints;
- Hierarchical Recovery;
- Continuous Reconciliation.

`PROMOTION_RULES.md` depends on that ontology.

It should not redefine the method’s foundation.

It defines how knowledge moves through the ontology.

---

# 24. Relationship with FLUX

`PROMOTION_RULES.md` defines semantic transformation and reconciliation constraints.

`FLUX.md` defines operational routing.

This document intentionally avoids exact file paths, writable paths, commit scopes, and concrete authority rules except when referring to conceptual roles.

If a question asks:

> What does this knowledge become?

consult `PROMOTION_RULES.md`.

If a question asks:

> Which file may write where?

consult `FLUX.md`.

If promotion or reconciliation requires materialization, `FLUX.md` determines who may perform it.

---

# 25. Relationship with CHAT_PROTOCOL

`CHAT_PROTOCOL.md` defines communication structure.

Promotion may require structured reporting.

Examples:

- Didactic concepts require a defined concept format.
- Checkpoints may require compact recovery structure.
- Observational records may require readable append-oriented entries.
- Reconciliation reports may require explicit drift, owner, and resolution fields.

`PROMOTION_RULES.md` determines the semantic state.

`CHAT_PROTOCOL.md` determines the communication form.

---

# 26. Closing Principle

Promotion is the discipline that prevents conversation from becoming chaos.

It allows knowledge to move through capture, classification, validation, synthesis, materialization, checkpointing, observation, and reconciliation.

Reconciliation is the discipline that prevents promoted knowledge from becoming duplicate, contradictory, or misplaced.

It protects the project from confusing:

- raw thought with stable truth;
- stage files with canonical memory;
- Codex reports with interpretation;
- derived summaries with authority;
- checkpoints with canon;
- historical records with current state;
- materialized files with validated knowledge;
- repeated wording with shared truth;
- global summaries with domain ownership.

The Sketch Notebook does not merely store information.

It changes the status of information deliberately and keeps those statuses coherent across files, domains, and time.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
