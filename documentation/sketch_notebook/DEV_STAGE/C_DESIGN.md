# C_DESIGN.md

> Status: Ephemeral Design Retrospective
> Knowledge State: Staged / Reconciled / Non-canonical
> Authority: Design Chat [D]
> Scope: Main-branch commit retrospective for rebuilding `design/09_DESIGN_STATE.md`
> Branch examined: `main`
> Canon conflict target: `design/01_ARCHITECTURE.md`

---

# 1. Purpose

This stage records the historical evidence needed to rebuild the Design checkpoint.

It is intentionally temporary. It does not redefine canon, replace the derivative overview, or populate observational history.

The checkpoint should represent the current recovery state while preserving the most important lesson from the failed precedent cycle.

---

# 2. Retrospective Range

The useful main-branch range is:

```text
Cycle 04 design closure
    75ab809  Absorb Cycle 04 into design checkpoint
    04db2d3  Reconcile Cycle 04 architecture
    1322c67  Record Cycle 04 design absorption
    8214288  Update Cycle 04 model overview
    c84e850  Close Cycle 04 global project state
    777a30b  Record Cycle 04 session closure
    bd4b4cd  Prepare post-Cycle 04 recovery scheme

Cycle 05 preparation and failure
    e9cf0f0  Stage Cycle 05 mobile preparation synthesis
    a4f7732  Prepare Cycle 05 mobile development planning session
    c51938b  cycle 5.0 outburst mode
```

Later Cycle 05 recovery commits show that the repository resumed domain-by-domain reconciliation, but the checkpoint lesson is established by the transition above.

---

# 3. Cycle 04 Recovered State

The former main-branch checkpoint described four completed boundary-preserving cycles:

```text
Cycle 01  Product View
Cycle 02  History and Settings
Cycle 03  Lists and History Analytics
Cycle 04  Settings Stabilization
```

Its stable responsibility model was:

```text
Desktop UI
    rendering, controls, navigation, events

ProductService
    application meaning, validation, grouping,
    calculations, settings interpretation, projections

Repository
    SQL, generic persistence, row mapping

SQLite
    persisted facts, relationships, settings
```

Cycle 04 also left explicit verification risks rather than declaring total completion:

- Settings save-feedback behavior;
- store create/update interaction;
- dependent-page refresh;
- first-weekday operational-month period-end correctness;
- broad desktop regression coverage.

The checkpoint therefore represented a coherent architectural closure with remaining operational verification.

---

# 4. Failed Precedent Cycle

## 4.1 Intended direction

Cycle 05 initially shifted from post-Cycle-04 verification toward broad mobile preparation.

The planning surface expanded to include:

- product scope;
- target mobile architecture;
- persistence and synchronization;
- backend and API decisions;
- identity and security;
- mobile framework selection;
- typed contracts;
- migration and coexistence;
- testing and phased implementation.

This was wider than the unresolved verification boundary inherited from Cycle 04.

## 4.2 Outburst commit

Between the post-Cycle-04 recovery point and `c51938b`, three commits changed:

```text
06_SESSION_SCHEME.md
DEV_STAGE/A_OPERATIONAL.md
DEV_STAGE/B_DIDACTIC.md
DEV_STAGE/C_DESIGN.md
[M]_STAGE/J_MAIN_STAGE.md
```

The comparison reports approximately:

```text
A_OPERATIONAL     1,755 changed lines
B_DIDACTIC       2,168 changed lines
C_DESIGN         1,278 changed lines
J_MAIN_STAGE       666 changed lines
SESSION_SCHEME     304 changed lines
```

Compiled `__pycache__` files were also modified in the same range.

The Design stage itself moved from architecture recovery into a large Windows packaging proposal, while the surrounding cycle was still carrying mobile-preparation planning.

## 4.3 Failure classification

The failed precedent cycle is classified as:

```text
primary failure
    cycle-scope expansion
    + simultaneous cross-domain restaging
    + Main-reference replacement
    + insufficient reconciliation checkpoints

not established as
    a failure of the layered Markei architecture itself
```

The problem was not that packaging or mobile preparation were invalid subjects. The problem was that multiple future directions, domain outputs, and coordination surfaces were rewritten together before the previous cycle's verification debt had been absorbed.

## 4.4 Durable checkpoint lesson

A cycle must not treat broad planning volume as evidence of architectural readiness.

Before a new architecture cycle expands scope, it should establish:

1. the exact inherited verification debt;
2. the single active milestone;
3. which statements are current facts versus proposed targets;
4. which domain owns each unresolved question;
5. a reconciliation point before Main and all functional stages are replaced;
6. a checkpoint update after accepted materialization, not before it.

---

# 5. Conflict Against Current Canon

The recovered canon defines the current system as a layered local desktop monolith:

```text
Desktop Presentation
    ↓
ProductService
    ↓
Repository
    ↓
Database Manager
    ↓
SQLite
```

The commit retrospective does not contradict this structure.

It adds historical context relevant to checkpoint state:

- Cycle 04 established useful feature-level boundaries;
- some Cycle 04 behavior remained operationally unverified;
- Cycle 05 prematurely widened scope to packaging and mobile architecture;
- the outburst cycle overloaded staging and reconciliation surfaces;
- the current recovery cycle intentionally rebuilt architecture from source and reconciled Main evidence before repopulating domain memory.

Canon remains authoritative for accepted structure. The retrospective informs milestone state, active tensions, and recovery discipline.

---

# 6. Checkpoint Extraction

`design/09_DESIGN_STATE.md` should contain:

- current recovery milestone;
- present architectural baseline;
- completed repopulation state;
- inherited failed-cycle lesson;
- active architectural tensions;
- operational validations still required;
- unresolved design decisions;
- next recovery actions;
- routing to canon and derivative files.

It should not reproduce the complete Cycle 01–04 feature history.

It should not promote packaging or mobile architecture proposals from the failed cycle.

It should not populate `03_DECISION_LOG.md` yet.

---

# 7. Stage Result

```text
Canon conflict: compatible
Historical addition: failed Cycle 05 control pattern
Canonical change required: no
Derivative change required: no
Checkpoint rebuild: ready
Observational history: remain empty
Application source changes: none
```
