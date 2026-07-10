# 13_LECTURE_REGISTER.md

> Domain: Didactic
> Status: Observational history
> Authority: Didactic Chat [A]
> Scope: Didactic-domain recovery, repopulation, reconciliation corrections, and Cycle 05 learning record
> Current truth sources: `02_KANBAN.md`, `07_GLOSSARY.md`, and `08_CONCEPT_MAP.md`
> Historical evidence source: `DEV_STAGE/B_DIDACTIC.md` and referenced commits
> Rule: This file explains how present knowledge emerged; it does not override canon or checkpoint state.

---

# Observation 001 — Didactic Domain Recovery and First Complete Repopulation

## Observation Metadata

```text
Observation class: Domain-recovery history
Role: Didactic Chat [A]
Repository: gus-i-gu/markei
Branch: sketch-notebook-recovery
Recovery period: 2026-07-10
Starting state: permanent Didactic files intentionally empty
Ending state: canon, derivative, checkpoint, and observational roles populated
```

The recovery operation reconstructed the Didactic domain from current repository evidence, Main reconciliation, bounded commit history, and human correction. It did not restore the old notebook blindly. It rebuilt a contemporary learning memory and preserved important discontinuities instead of hiding them.

The final Domain Symmetry sequence became:

```text
02_KANBAN.md
canonical concepts
↓
07_GLOSSARY.md
derivative retrieval and terminology
↓
08_CONCEPT_MAP.md
current learning checkpoint
↓
13_LECTURE_REGISTER.md
observational history of the recovery process
```

---

## 1. Recovery Preconditions

At the beginning of the special recovery cycle, the permanent Didactic files were empty:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md
```

The application repository remained the primary evidence of current behavior. The Didactic role was therefore required to recover what the repository teaches without confusing implementation observation with canonical learning knowledge.

The recovery followed these distinctions:

```text
repository fact
≠ didactic interpretation

staged interpretation
≠ canonical concept

canonical concept
≠ derivative summary

derivative summary
≠ current checkpoint

checkpoint
≠ historical observation
```

This separation was essential because the recovery process itself contained corrections, superseded assumptions, and incomplete historical cycles.

---

## 2. First Structural Staging

### Commit

```text
6b20498b3893eb8d8fc3d0aeb53668393f87391a
Stage didactic structural recovery review
```

### File

```text
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
```

The first Didactic stage inspected the contemporary structure under:

```text
app/core/
app/database/
app/desktop/
```

It recovered the current dependency and responsibility chain:

```text
PySide6 desktop presentation
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

The stage identified the major learning areas later used for canon reconstruction:

- responsibility boundaries;
- package and module structure;
- domain entities and slotted dataclasses;
- application-service orchestration;
- repository and SQL boundaries;
- SQLite connection and cursor ownership;
- initialization versus migration;
- relational integrity;
- database-row, domain-model, and view-model distinctions;
- presentation adapters;
- resource lifetime and shutdown;
- statement atomicity versus workflow atomicity.

At this point the material remained deliberately non-canonical. Connection cleanup, transaction scope, contract completeness, typed view models, migration versioning, and package subdivision were classified as questions rather than accepted answers.

### Learning significance

The structural review established that a package name such as `core` is not itself a complete architectural explanation. Within `app/core`, several responsibilities coexist:

```text
models.py       → application entities
contracts.py    → responsibility declarations and invariants
services.py     → workflows and business interpretation
repository.py   → SQL and row mapping
database.py     → connection and schema lifecycle
config.py       → shared paths and constants
```

The first durable lesson of the recovery was therefore that **physical grouping and semantic responsibility are related but not identical**.

---

## 3. Initial Canonical Reconstruction Attempt

### Commit

```text
5c81ff280f92c8932cc05fe4963a1cb790677da7
Stage first didactic canonical reconstruction tranche
```

The first reconciliation attempt compared `B_DIDACTIC.md` against a historically recovered Main-stage file named `J_MAIN_STAGE.md`. It proposed restoring three historical concepts:

```text
&&&01
&&&02
&&&03
```

The proposed concepts focused on field semantics, raw versus derived data, and naming as a contract.

### Correction later required

The human then identified a reference-name mismatch. The correct reconciliation source was not the older `J_MAIN_STAGE.md`, but the current exact file:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

This correction is part of the observational record because it demonstrates a methodology-critical lesson:

```text
semantically similar file
≠ designated authority file
```

The first attempt was not treated as final merely because its conclusions were plausible. The authoritative path supplied by the human had to replace the historical substitute.

### Learning significance

Recovery accuracy depends not only on content similarity, but also on **file role, current authority, branch location, and exact designation**. A historically valid Main-stage file may still be the wrong reconciliation source for the current promotion cycle.

---

## 4. Correct Reconciliation Against `J_[M]_STAGE.md`

The exact Main reconciliation file classified repository evidence into:

```text
CONFIRMED IMPLEMENTATION FACT
RECONCILED INTERPRETATION
OPERATIONAL VALIDATION REQUIRED
DESIGN DECISION REQUIRED
HISTORICAL CLASSIFICATION REQUIRED
```

It also explicitly authorized fresh Didactic canonical reconstruction from current concept families while prohibiting unresolved decisions from being promoted as settled knowledge.

The Main reference established the stable contemporary baseline:

```text
Desktop presentation
→ ProductService application facade
→ Repository persistence facade
→ database lifecycle manager
→ SQLite
```

It confirmed that:

- desktop pages call ProductService rather than SQL;
- ProductService owns workflows, calculations, settings interpretation, and UI-facing projections;
- Repository owns SQL, row mapping, individual commits, and one connection/cursor per instance;
- database management owns paths, initialization, additive migrations, and connection configuration;
- Purchase represents historical receipt events;
- Product contains editable state plus cached summaries recalculated from purchases;
- four principal pages construct four service/repository/connection chains;
- local cleanup capability exists, but application-wide shutdown ownership remains implicit;
- receipt registration and deletion/recalculation are multi-commit workflows;
- dictionary projections function as current view models;
- contracts document boundaries but do not expose the full concrete runtime surface.

This exact reconciliation became the valid promotion basis.

---

## 5. Canonical Didactic Repopulation

### Commit

```text
d9016d929821828d5cd10535ea22df0bd3cee9ac
Repopulate canonical didactic register from recovery reconciliation
```

### File

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
```

The previously empty canonical file was populated as a fresh recovery baseline. The register did not copy the entire stage report. It extracted stable, teachable concepts according to Didactic ownership.

The canonical register introduced the current concept set:

```text
&&&01  Responsibility Boundary
&&&02  Raw Data Versus Derived Data
&&&03  Naming as Data Contract
&&&04  Resource Ownership and Lifetime

&&%01  Package and Module Boundary
&&%02  Dataclass as Structured Data Carrier
&&%03  Context Manager and Deterministic Cleanup

&%%01  Application Service
&%%02  Repository Pattern and Persistence Adapter
&%%03  Presentation Adapter
&%%04  Database Row, Domain Model, and View Model
&%%05  Statement Atomicity Versus Workflow Atomicity

%%%01  SQLite Initialization Versus Migration
%%%02  SQLite Connection and Cursor Ownership
%%%03  SQLite PRAGMA and Connection Configuration
%%%04  Relational Schema and Referential Integrity
%%%05  Bundled Resource Versus Writable User Data
```

Each entry followed the mandatory canonical protocol:

- Description;
- Formal Definition;
- Practical Example;
- Language Implementation;
- Project Implementation;
- Required Concepts;
- Related Concepts;
- Status;
- Source.

### Canonical limits preserved

The register documented current structures but did not canonically prescribe unresolved solutions. It did not claim that:

- page-local services are the desired final lifecycle model;
- shutdown ownership has been solved;
- workflow-wide transactions are already implemented;
- ProductService or Repository must be split;
- abstract contracts are complete substitutable interfaces;
- dictionary view models must be replaced;
- numbered migration history already exists;
- promotions and `pages.order` have settled feature status;
- packaged installation lifecycle is fully validated.

### Learning significance

Canon was reconstructed as **stable conceptual knowledge**, not as a transcript of repository inspection or a list of future architectural preferences.

---

## 6. Derivative Glossary Repopulation

### Commit

```text
5c56784c927b5287fdbce2e4109ed3483f42d662
Derive didactic glossary from canonical recovery register
```

### File

```text
documentation/sketch_notebook/didactics/07_GLOSSARY.md
```

The derivative file reorganized canon for human supervision and lower-cost agent recovery. It was intentionally shorter and more accessible than the canonical lessons.

The glossary added retrieval-oriented spines:

```text
current system spine
representation spine
runtime-resource spine
persistence-lifecycle spine
```

It then grouped entries by practical retrieval need rather than canonical numbering:

- architecture and responsibility;
- data meaning and representation;
- resource and transaction lifecycle;
- SQLite structure and lifecycle;
- supporting derived terminology;
- supervision notes.

Every canonical glossary entry retained:

```text
KANBAN ID
Type
Definition
Project Usage
Related Concepts
```

Supporting terms such as cursor, row factory, WAL, idempotent migration, schema introspection, projection, signal/slot, user-data directory, bundled resource, and cascading action were marked:

```text
KANBAN ID: None
Type: Derived terminology
```

### Learning significance

The derivative file demonstrated that **reorganization improves retrieval without creating new truth**. It remained subordinate to `02_KANBAN.md` and explicitly pointed back to canon whenever full meaning was required.

---

## 7. Commit Retrospective for Checkpoint Recovery

### Commit

```text
e724ae51f318b3d845aeb63b33b8858fecf2a706
Stage didactic commit retrospective for checkpoint recovery
```

### File

```text
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
```

The staging file was refreshed into an ephemeral retrospective covering the transition:

```text
Cycle 04 closure
↓
post-Cycle 04 recovery scheme
↓
Cycle 05 mobile-preparation synthesis
↓
Cycle 05 mobile-development planning
↓
cycle 5.0 outburst pivot
↓
Cycle 05 Sprint 01 desktop packaging
↓
partial packaging reconciliation
```

The bounded commit set included:

```text
1e07b48  Reconcile Cycle 04 didactic checkpoint
c84e850  Close Cycle 04 global project state
bd4b4cd  Prepare post-Cycle 04 recovery scheme
e9cf0f0  Stage Cycle 05 mobile preparation synthesis
a4f7732  Prepare Cycle 05 mobile development planning session
c51938b  cycle 5.0 outburst mode
11a931f  Reconcile Cycle 05 Sprint 01 operational checkpoint
bc4d3a5  Reconcile Cycle 05 Sprint 01 operational TODO
b29aec0  Reconcile Cycle 05 Sprint 01 didactic checkpoint
d4a1448  Append Cycle 05 Sprint 01 operational evidence
fbeef65  Add desktop packaging operational model
```

The retrospective was not used to rewrite canon automatically. Its purpose was to recover current learning state, failed transitions, historical naming, and unresolved boundaries for the checkpoint.

### Concurrent-write observation

During staging, the recovery branch was also receiving Operational and Design updates. Two normal contents-API writes were safely rejected because the branch head advanced. The Didactic change was then reapplied against current branch state.

This exposed another practical methodology lesson:

```text
file unchanged
+
branch advanced elsewhere
=
write still requires fresh reconciliation
```

Concurrent domain work must not be overwritten merely because the local target file appears unchanged.

---

## 8. Checkpoint Reconstruction

### Commit

```text
e16edc6732d79ffee0b5a6e5f614d3fbf4d9c7f6
Rebuild didactic checkpoint from canon and Cycle 05 retrospective
```

### File

```text
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

The checkpoint compressed current learning state for economical recovery.

It recorded the present milestone:

```text
canonical register recovered
→ derivative glossary recovered
→ checkpoint rebuilt
→ observational history pending
```

No concepts were marked Green because repository evidence proves implementation state, not human mastery.

Active concepts were those strongly evidenced and ready for reinforcement. Unstable concepts were:

```text
&&&04  Resource Ownership and Lifetime
&&%03  Context Manager and Deterministic Cleanup
&%%05  Statement Atomicity Versus Workflow Atomicity
%%%02  SQLite Connection and Cursor Ownership
```

The checkpoint also preserved the failed-cycle transition:

```text
closed Cycle 04 desktop baseline
↓
Cycle 05 mobile-preparation plan
↓
mobile exit conditions not reached
↓
cycle 5.0 outburst pivot
↓
partially completed Windows packaging sprint
↓
current recovery cycle
```

The low-cost future recovery route became:

```text
08_CONCEPT_MAP
↓
07_GLOSSARY when terminology is enough
↓
targeted 02_KANBAN concepts when full explanation is required
↓
DEV_STAGE/B_DIDACTIC only for retrospective evidence
↓
repository and commit history only when drift is suspected
```

---

## 9. Cycle 05 Conceptual and Methodological Failure Analysis

### Staged note commit

```text
6855efa63ef89e284938bb4cc7fa5c7f5a23b9f8
Append Cycle 05 methodological learning note
```

Cycle 05 did not fail because no useful implementation occurred. It failed because one cycle name came to contain two different semantic efforts without a controlled transition.

The original Cycle 05 objective was mobile-preparation planning. Its declared completion conditions required decisions about:

- the first mobile product scope;
- reusable and platform-neutral core boundaries;
- typed service and read-model contracts;
- dependency construction;
- persistence and synchronization;
- backend/API responsibility;
- identity, authorization, and security;
- mobile framework selection;
- migration and desktop coexistence;
- automated validation;
- phased implementation and stop conditions.

Those conditions were not met before the project pivoted into desktop packaging.

The later packaging sprint produced real value:

```text
source application
→ PyInstaller one-folder runtime
→ bundled schema resource
→ per-user SQLite state
→ schema-only first launch
→ installer configuration
```

But its completion boundary also remained partial:

```text
validated frozen runtime
≠ validated installed release
```

Inno Setup compilation and installed lifecycle checks were not completed because `ISCC.exe` was unavailable. Start Menu launch, upgrade preservation, uninstall/reinstall behavior, SmartScreen, antivirus behavior, signing, and rollback remained unresolved.

### 9.1 Primary conceptual flaws

#### A. Scope changed without a formal cycle-state transition

The project moved from mobile architecture preparation to Windows packaging, but the original cycle was not first classified as:

```text
completed
suspended
superseded
interrupted
or abandoned
```

Without that classification, the shared name `Cycle 05` became ambiguous.

#### B. Exit criteria existed textually but did not function as gates

The mobile-planning files contained detailed prerequisites. However, those prerequisites did not prevent a materially different sprint from becoming the active workstream under the same cycle identity.

The distinction is:

```text
written exit criteria
≠ enforced transition gate
```

#### C. Planning, configuration, implementation, validation, and completion states blurred

Cycle 05 exposed repeated status confusions:

```text
planned
≠ selected

selected
≠ implemented

implemented
≠ validated

configured
≠ executable

packaged
≠ installed

launched once
≠ release validated
```

A cycle may contain useful artifacts while still failing its declared objective.

#### D. Local progress displaced global reconciliation

Packaging produced concrete and visible results. Mobile preparation consisted mainly of unresolved strategic decisions. The visible success of the packaging sprint made it easier for the project to move forward operationally while leaving the original cross-domain objective unresolved.

This was not an error in packaging work itself. It was a coordination failure between local success and global cycle meaning.

#### E. The notebook captured activity more clearly than transition meaning

Commits documented what was added, reconciled, or validated. They did not immediately provide one authoritative statement explaining:

- why the mobile-preparation direction stopped;
- whether it was superseded or merely deferred;
- which unresolved decisions survived the pivot;
- what new exit criteria governed packaging;
- whether the cycle name still referred to the same semantic object.

The recovery process had to infer that transition retrospectively.

#### F. Cycle identity became overloaded

The same identifier came to mean:

```text
Cycle 05 = full mobile preparation
```

and later:

```text
Cycle 05 Sprint 01 = Windows desktop packaging
```

These efforts were related to future distribution, but they did not share the same objective, evidence model, or closure criteria. Reusing the cycle identity concealed the semantic break.

### 9.2 Central methodological lesson

```text
planned objective
≠ active sprint objective
≠ materialized artifact
≠ validation evidence
≠ cycle closure
```

A cycle should be evaluated against the objective and exit conditions it declared, not merely against the volume or usefulness of work completed under its name.

### 9.3 Recommended transition discipline

When a major pivot occurs, the notebook should record a compact transition reconciliation before substantial new staging:

1. previous objective;
2. previous completion state;
3. unresolved knowledge carried forward;
4. reason for the pivot;
5. new objective;
6. new evidence and validation model;
7. new exit criteria;
8. explicit relationship to the previous cycle: completed, suspended, superseded, interrupted, or abandoned;
9. whether a new cycle or sprint identifier is required.

A semantic objective change should normally receive a new cycle identity unless Main and the human explicitly preserve continuity and explain why.

---

## 10. Final Didactic Recovery State

At the end of this recovery sequence:

```text
02_KANBAN.md
populated canonical recovery baseline

07_GLOSSARY.md
populated derivative retrieval surface

08_CONCEPT_MAP.md
populated current learning checkpoint

13_LECTURE_REGISTER.md
populated first observational recovery record
```

The current Didactic memory should be interpreted as follows:

```text
02_KANBAN
answers: What concepts are accepted and teachable?

07_GLOSSARY
answers: How can those concepts be retrieved and supervised quickly?

08_CONCEPT_MAP
answers: What is the current learning state and what should be read next?

13_LECTURE_REGISTER
answers: How did this state emerge, what corrections occurred, and what should not be forgotten?
```

The observational record must not promote Cycle 05 packaging concepts automatically, alter current KANBAN numbering, or turn unresolved architecture into accepted solutions. Its role is to preserve traceability, failure learning, and the reasoning behind the current checkpoint.

---

## 11. Commit Ledger for This Recovery Observation

```text
6b20498b3893  Stage didactic structural recovery review
5c81ff280f92  Stage first didactic canonical reconstruction tranche

d9016d929821  Repopulate canonical didactic register from recovery reconciliation
5c56784c927b  Derive didactic glossary from canonical recovery register
e724ae51f318  Stage didactic commit retrospective for checkpoint recovery
e16edc6732d7  Rebuild didactic checkpoint from canon and Cycle 05 retrospective
6855efa63ef8  Append Cycle 05 methodological learning note
```

The `5c81ff...` stage is retained here as an important superseded step: it used the wrong Main-stage reference and was corrected through the exact `J_[M]_STAGE.md` reconciliation before permanent canon was populated.

---

## Observation Closure

The first Didactic domain recovery is now observationally complete.

Its most important durable lessons are:

```text
exact authority path matters
staging must remain distinguishable from canon
canon must not absorb unresolved design choices
derivative knowledge must not introduce truth
checkpoint recovery should include failed transitions
implementation evidence does not equal learner mastery
useful sprint output does not prove cycle completion
major pivots require explicit semantic transition records
```

Future observations should append new events rather than rewrite this recovery history, except to correct factual errors with an explicit amendment.