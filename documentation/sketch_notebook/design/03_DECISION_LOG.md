# 03_DECISION_LOG.md

> Version: 0.1-recovery
> Status: Active Observational Record
> Persistence Class: Observational History
> Knowledge Class: Design History
> Authority: Design Chat [D]
> Scope: Append-oriented record of the Design-domain recovery and repopulation performed on `sketch-notebook-recovery`
> Current Coverage: Initial Design staging through canonical, derivative, and checkpoint reconstruction

---

# 1. Purpose and Reading Rule

This file records what happened during the Design-domain repopulation cycle.

It preserves:

- investigation steps;
- reconciliation events;
- staging and promotion sequence;
- encountered conflicts and corrections;
- files produced;
- commit evidence;
- methodological lessons derived from the recovery process.

This file does not independently define current architecture.

For current accepted Design knowledge, read:

```text
Canonical architecture
    01_ARCHITECTURE.md

Derived architecture overview
    14_MODEL_OVERVIEW.md

Current recovery checkpoint
    09_DESIGN_STATE.md
```

Entries are chronological and append-oriented. Later entries may clarify earlier observations, but earlier history should not be silently rewritten merely because the current architecture changes.

---

# 2. Recovery Context

The recovery cycle began after the permanent Sketch Notebook domain files had been intentionally pruned while the application repository remained available as the contemporary implementation evidence.

Design-domain permanent files were empty:

```text
design/01_ARCHITECTURE.md
design/14_MODEL_OVERVIEW.md
design/09_DESIGN_STATE.md
design/03_DECISION_LOG.md
```

The immediate Design objective was therefore not feature design. It was reconstruction of trustworthy project memory from:

1. methodology rules;
2. the current application implementation;
3. Design functional staging;
4. Main reconciliation;
5. historical commits where needed for checkpoint context.

The recovery followed Domain Symmetry:

```text
Functional stage
    DEV_STAGE/C_DESIGN.md

Canonical Design knowledge
    design/01_ARCHITECTURE.md

Derived Design knowledge
    design/14_MODEL_OVERVIEW.md

Design checkpoint
    design/09_DESIGN_STATE.md

Observational Design history
    design/03_DECISION_LOG.md
```

---

# 3. Event 01 — Methodology Boot and Empty-Domain Detection

## State

The Design Chat recovered the methodology navigation and write-routing rules before performing repository analysis.

The recovered Design symmetry roles were:

```text
01_ARCHITECTURE.md
    stable architectural knowledge

14_MODEL_OVERVIEW.md
    derivative reorganization of canonical architecture

09_DESIGN_STATE.md
    low-cost current-state recovery checkpoint

03_DECISION_LOG.md
    append-oriented design history
```

All four Design files were empty at bootstrap.

## Consequence

Repository implementation could be used as evidence, but implementation observations could not be copied directly into permanent canon. The first required output was a functional Design stage in `DEV_STAGE/C_DESIGN.md`.

## Classification

```text
Type: recovery initialization
Canonical effect: none
Permanent files changed: none
```

---

# 4. Event 02 — Initial Structural Repository Review

## Objective

Recover the present structural picture before reading commit history.

## Inspected implementation surfaces

```text
app/main.py
app/core/contracts.py
app/core/models.py
app/core/services.py
app/core/repository.py
app/core/database.py
app/database/schema.sql
app/desktop/main_window.py
app/desktop/ui/pages/register_page.py
app/desktop/ui/pages/lists_page.py
```

Later investigation expanded this set to History, Settings, and ProductDetailPanel.

## Initial recovered dependency direction

```text
Desktop UI
    → ProductService
        → Repository
            → Database Manager
                → SQLite
```

## Initial structural findings

- Desktop pages did not execute SQL.
- ProductService coordinated workflows and calculations.
- Repository owned SQL and row mapping.
- Database Manager owned initialization, configuration, migration, paths, and connection primitives.
- Product contained editable state plus cached calculated state.
- Purchase acted as the historical purchase record.
- MainWindow acted as page composer and informal navigation/refresh coordinator.
- Each inspected page constructed its own ProductService.
- ProductService constructed Repository.
- Repository opened one SQLite connection and cursor.

## Stage materialization

```text
Commit: 0c7143e13cd27e1b6a20506cadf045631e2eeeae
Message: Stage initial design recovery review
File: documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

## Classification

```text
Type: functional Design staging
Knowledge state: observational and unpromoted
Application source changed: no
```

---

# 5. Event 03 — Deeper Structural Consolidation

## Additional inspection

The review expanded to:

```text
app/desktop/ui/pages/history_page.py
app/desktop/ui/pages/settings_page.py
app/desktop/ui/widgets/product_detail_panel.py
remaining ProductService workflow sections
remaining Repository lifecycle and helper sections
```

## Confirmed lifecycle finding

All four principal pages independently constructed a ProductService:

```text
RegisterPage → ProductService → Repository → connection
ListsPage    → ProductService → Repository → connection
HistoryPage  → ProductService → Repository → connection
SettingsPage → ProductService → Repository → connection
```

HistoryPage and SettingsPage contained local `closeEvent()` cleanup attempts. Cleanup capability therefore existed, but application-wide shutdown ownership remained distributed and implicit.

## Confirmed transaction finding

Receipt registration was confirmed as a multi-commit workflow:

```text
create or update Product     → commit
insert Purchase              → commit
recalculate Product
update Product summary       → commit
```

Purchase deletion followed by Product recalculation had the same sequential multi-commit character.

This changed the classification from “atomicity uncertain” to:

```text
confirmed current implementation property:
workflow is sequentially consistent but not transactionally atomic
```

## Additional boundary finding

`ProductDetailPanel` emerged as the clearest presentation boundary:

```text
service prepares view data
    → widget renders view data
```

It contained no service, repository, SQL, or business-calculation responsibility.

## Stage consolidation

```text
Commit: 3f40e25109ede1501541fa8eefce84465dcb47bd
Message: Consolidate design structural recovery
File: documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

## Classification

```text
Type: expanded functional staging
Canonical effect: none
Important resolution: lifecycle ownership and transaction model clarified
```

---

# 6. Event 04 — First Main-Reference Path Failure

## Intended operation

The Design stage was to be reconciled against a Main-authored reference before canonical promotion.

## Incorrect path initially used

```text
documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md
```

The file lookup returned `404 Not Found`.

## Temporary conclusion

The absence was initially recorded as a structural reconciliation gap, and a canonical candidate was staged only inside `C_DESIGN.md` rather than written into the permanent Design folder.

## Concurrent-write conflict

During the attempted stage update, GitHub returned a content-SHA conflict. The current file was re-read before proceeding so unseen work would not be overwritten.

This preserved reconciliation safety:

```text
failed write
→ re-read current blob
→ reconcile current content
→ write replacement using current SHA
```

## Corrective stage commit

```text
Commit: 65199e4e3d02541fc4f25f9f677e307c40447973
Message: Stage initial design canon candidate
File: documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

## Classification

```text
Type: process correction
Canonical effect: none
Lesson: exact staging paths are part of the knowledge-routing contract
```

---

# 7. Event 05 — Correct Main Reference Identified

## Human correction

The correct Main reconciliation file was identified as:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

## Reconciliation result

The Main reference confirmed:

- the contemporary layered desktop-monolith structure;
- responsibility boundaries among desktop, ProductService, Repository, Database Manager, and SQLite;
- Purchase as historical receipt record;
- Product as editable information plus calculated summary cache;
- ProductService as the current application facade;
- Repository as the current persistence facade;
- MainWindow as public desktop composer and coordinator;
- Lists consolidation of Storage, Shortage, and Market;
- resource/user-data separation;
- four page-owned service/repository/connection chains;
- implicit application-wide shutdown ownership;
- multi-commit, non-atomic business workflows;
- dictionary-based service projections;
- partial source contracts.

The Main reference also explicitly prohibited unresolved future targets from being promoted as accepted architecture.

## Reconciliation principle

```text
C_DESIGN
    repository-backed Design reasoning

J_[M]_STAGE
    cross-domain reconciliation and promotion filter

reconciled overlap
    eligible canonical Design knowledge

unresolved differences or proposed targets
    remain outside canon
```

## Classification

```text
Type: Main/Design reconciliation
Canonical readiness: established
```

---

# 8. Event 06 — Canonical Architecture Repopulation

## Target

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
```

The file was empty before materialization.

## Materialization method

The canonical file was written as a new semantic artifact rather than as a copy of `C_DESIGN.md` or `J_[M]_STAGE.md`.

It retained stable accepted knowledge and excluded unresolved redesign proposals.

## Canonical content established

- system form as a local Python/PySide6/SQLite desktop monolith;
- runtime dependency direction;
- desktop, service, repository, and database-manager boundaries;
- MainWindow and page responsibilities;
- ProductService application-facade role;
- Repository persistence-facade role;
- database resource and user-state separation;
- active domain entities and relationship spine;
- Purchase historical-record role;
- Product calculated-state invariant;
- read-model boundary;
- current distributed lifecycle model;
- current multi-commit transaction model;
- source-contract classification;
- explicit unresolved Design areas.

## Excluded from accepted future design

The canon did not decide:

- whether services should become shared or remain page-local;
- which object should own shutdown;
- whether workflow atomicity is required;
- whether ProductService or Repository should be decomposed;
- whether contracts should become full substitutable interfaces;
- whether dictionary projections should become typed view models;
- whether Promotion is active or stale;
- whether `pages.order` should be used or removed;
- whether Product’s hybrid role is the permanent domain target.

## Commit

```text
Commit: 4431a25c8365e0c847c4c97b2775a90eda21ea0b
Message: Repopulate canonical design architecture
File: documentation/sketch_notebook/design/01_ARCHITECTURE.md
```

## Classification

```text
Type: canonical promotion and physical materialization
Knowledge class: Canonical Design
```

---

# 9. Event 07 — Derived Model Overview Repopulation

## Target

```text
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

The file was empty before materialization.

## Derivative objective

Reorganize canonical architecture into a faster, more approachable recovery surface for humans and AI agents.

The derivative was intentionally:

- less verbose than canon;
- organized by recovery need rather than formal proof order;
- explicit about its lower authority;
- prohibited from introducing independent truth.

## Derivative organization

```text
System at a glance
→ Responsibility map
→ Desktop model
→ Domain spine
→ Representation flow
→ Persistence model
→ Current structural constraints
→ Stable boundaries
→ Open Design areas
→ Recovery routing
```

## Recovery routing introduced

```text
Rapid structural orientation
    → 14_MODEL_OVERVIEW.md

Exact accepted architecture
    → 01_ARCHITECTURE.md

Current milestone and active tensions
    → 09_DESIGN_STATE.md

Accepted Design evolution
    → 03_DECISION_LOG.md
```

## Commit

```text
Commit: b019063163e45dc72ffb04a9010483a035e858e2
Message: Repopulate derived design model overview
File: documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

## Classification

```text
Type: derived knowledge materialization
Independent truth introduced: no
```

---

# 10. Event 08 — Main-Branch Retrospective for Checkpoint Recovery

## Reason for retrospective

Canonical and derivative files described current structure, but the checkpoint also needed to preserve the failed precedent cycle that affected project continuity.

Commit history was therefore consulted as temporary evidence and staged in `C_DESIGN.md` before checkpoint reconstruction.

## Historical range emphasized

```text
Cycle 04 closure
→ post-Cycle-04 recovery planning
→ Cycle 05 mobile preparation
→ Cycle 05 planning expansion
→ cycle 5.0 outburst mode
```

Important commits included:

```text
75ab80972d0bfcafb0a859acfe1d7a2cc06d183b
    Absorb Cycle 04 into design checkpoint

04db2d39090c9722d0832b78d64704e67254fc16
    Reconcile Cycle 04 architecture

1322c677b1912eab3ac1a0bafba31fa999af8fdc
    Record Cycle 04 design absorption

82142888065a53a3fde5c71c599a63a8debd7177
    Update Cycle 04 model overview

bd4b4cd9233d08c2907c2bfe0644206994ad351a
    Prepare post-Cycle 04 recovery scheme

e9cf0f08f99dee587d5ed88cf68ba2512d3bf102
    Stage Cycle 05 mobile preparation synthesis

a4f773267a1d96f72d8c7427abcdb33c196e3720
    Prepare Cycle 05 mobile development planning session

c51938b7d603f05aa8745db7a54f3a257dd27ee5
    cycle 5.0 outburst mode
```

## Failed-precedent finding

Cycle 04 closed with a coherent architectural checkpoint but retained explicit validation debt.

Cycle 05 then broadened into mobile planning and Windows packaging before that debt was fully absorbed.

The outburst comparison changed major coordination surfaces simultaneously:

```text
A_OPERATIONAL
B_DIDACTIC
C_DESIGN
J_MAIN_STAGE
06_SESSION_SCHEME.md
```

The comparison also included compiled `__pycache__` files.

The failure was classified primarily as:

```text
cycle-control overload
+ knowledge-routing overload
+ excessive simultaneous replacement of coordination surfaces
```

It was not classified as proof that the layered application architecture had failed.

## Durable process lesson

```text
one active milestone per cycle
+ inherited validation debt remains visible
+ current fact separated from proposed target
+ A/B/C reconciled before shared-stage replacement
+ implementation artifacts separated from notebook reasoning
```

## Ephemeral stage commit

```text
Commit: ec9a1b6dc5d5252e1031e0890a468ecc38321b55
Message: Stage design checkpoint retrospective
File: documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

## Classification

```text
Type: historical evidence staging
Permanent Design effect: none until checkpoint reconciliation
```

---

# 11. Event 09 — Design Checkpoint Reconstruction

## Target

```text
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

The recovery-branch checkpoint was empty before materialization.

## Inputs

```text
01_ARCHITECTURE.md
    accepted present architecture

14_MODEL_OVERVIEW.md
    compact architectural organization

C_DESIGN retrospective
    failed-cycle and recovery-process evidence

main-branch commit sequence
    historical context for the failed precedent
```

## Checkpoint objective

Provide the least expensive sufficient Design recovery surface.

The checkpoint therefore emphasized:

- current recovery milestone;
- accepted dependency and responsibility baseline;
- compact domain-model state;
- current lifecycle and transaction constraints;
- facade, contract, and projection state;
- failed Cycle 05 precedent;
- active Design questions;
- operational validation dependencies;
- next Design actions;
- escalation paths to derivative and canon.

## Historical interpretation recorded

Packaging and mobile architecture from the failed cycle were retained as historical proposals, not current accepted architecture.

The checkpoint documented that the failed precedent concerned coordination and recovery discipline more than a demonstrated breakdown of Markei’s current structural boundaries.

## Commit

```text
Commit: 32a6834ef845280ed372c518ddcf1edb1e4e2112
Message: Rebuild design checkpoint from retrospective
File: documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

## Classification

```text
Type: checkpoint materialization
Knowledge class: ephemeral derived recovery state
```

---

# 12. Event 10 — Design Symmetry Completion

After canonical, derivative, and checkpoint reconstruction, the Design folder reached:

```text
01_ARCHITECTURE.md
    populated canonical knowledge

14_MODEL_OVERVIEW.md
    populated derivative knowledge

09_DESIGN_STATE.md
    populated recovery checkpoint

03_DECISION_LOG.md
    ready for the first observational record
```

The completed flow was:

```text
repository inspection
→ C_DESIGN functional staging
→ deeper structural verification
→ Main reconciliation correction
→ canonical architecture
→ derivative model overview
→ historical checkpoint retrospective
→ Design checkpoint
→ observational recovery record
```

This event is the first complete Design-domain repopulation after the intentional pruning operation.

---

# 13. Recovery Decisions and Non-Decisions

## Decisions established during repopulation

The recovery process established the following knowledge-routing decisions:

1. `C_DESIGN.md` is the functional reasoning and temporary reconciliation surface.
2. `J_[M]_STAGE.md` is the correct Main reconciliation reference for this recovery cycle.
3. Canon contains accepted stable present architecture, not every current implementation detail and not proposed future targets.
4. The model overview reorganizes canon and introduces no independent architectural truth.
5. The checkpoint combines current state with active tensions and recovery-critical historical context.
6. The decision log records the recovery event and does not replace canon or checkpoint.
7. The Cycle 05 outburst is retained as a failed coordination precedent rather than promoted as current product direction.

## Architectural questions deliberately left open

No final decision was made during repopulation about:

- shared versus page-local services;
- composition-root placement;
- deterministic shutdown ownership;
- workflow transaction atomicity;
- ProductService decomposition;
- Repository decomposition;
- complete runtime contracts;
- typed view models;
- service-versus-presenter formatting;
- explicit versioned migrations;
- Promotion capability status;
- `pages.order` status;
- Product’s long-term aggregate/cache role;
- mobile architecture;
- packaging architecture.

These remain questions for future Design cycles rather than defects in the recovery record.

---

# 14. Conflicts and Corrections Preserved

## Main-stage filename mismatch

```text
Initially attempted:
    [M]_STAGE/J_MAIN_STAGE.md

Correct reference:
    [M]_STAGE/J_[M]_STAGE.md
```

The incorrect lookup produced a false absence signal. Human correction restored the intended reconciliation route before permanent canon was written.

## Content-SHA write conflict

A GitHub update failed because the expected content SHA no longer matched the current file. The stage was re-read and reconciled before retrying.

This avoided overwriting concurrent or intervening content.

## Historical versus current branch evidence

Main-branch commits were used only for retrospective checkpoint evidence. They were not treated as a source for replacing the recovered current architecture on `sketch-notebook-recovery`.

## Canon versus current implementation constraints

Current couplings and limitations were documented as present architectural properties without being promoted as preferred permanent endpoints.

Examples:

```text
four page-owned connections
    present implementation property
    not permanent composition decision

multi-commit receipt workflow
    present transaction property
    not accepted future target

broad ProductService
    current application facade
    not mandatory permanent class structure
```

---

# 15. Materialization Ledger

| Sequence | Commit | Message | Primary File | Semantic Result |
| --- | --- | --- | --- | --- |
| 1 | `0c7143e13cd27e1b6a20506cadf045631e2eeeae` | Stage initial design recovery review | `DEV_STAGE/C_DESIGN.md` | Initial structural evidence staged |
| 2 | `3f40e25109ede1501541fa8eefce84465dcb47bd` | Consolidate design structural recovery | `DEV_STAGE/C_DESIGN.md` | Lifecycle, transaction, and presentation findings consolidated |
| 3 | `65199e4e3d02541fc4f25f9f677e307c40447973` | Stage initial design canon candidate | `DEV_STAGE/C_DESIGN.md` | Canon candidate staged after path/SHA recovery |
| 4 | `4431a25c8365e0c847c4c97b2775a90eda21ea0b` | Repopulate canonical design architecture | `design/01_ARCHITECTURE.md` | Canonical Design memory restored |
| 5 | `b019063163e45dc72ffb04a9010483a035e858e2` | Repopulate derived design model overview | `design/14_MODEL_OVERVIEW.md` | Derived recovery overview restored |
| 6 | `ec9a1b6dc5d5252e1031e0890a468ecc38321b55` | Stage design checkpoint retrospective | `DEV_STAGE/C_DESIGN.md` | Failed-cycle history staged ephemerally |
| 7 | `32a6834ef845280ed372c518ddcf1edb1e4e2112` | Rebuild design checkpoint from retrospective | `design/09_DESIGN_STATE.md` | Design checkpoint restored |

Application source was not modified by these Design repopulation commits.

---

# 16. Final State of This Recovery Event

```text
Canonical Design memory
    restored

Derived Design overview
    restored

Design checkpoint
    restored

Observational Design history
    initialized by this record

Application implementation
    unchanged by Design repopulation

Methodology files
    unchanged

Main reconciliation reference
    read and respected, not modified by Design Chat
```

The next append to this file should occur only when a definite Design event happens, such as:

- acceptance or rejection of one of the unresolved architecture decisions;
- a materialized architecture change;
- reconciliation of implementation drift;
- a future domain recovery or promotion cycle;
- retirement or reclassification of a structural element such as Promotion or `pages.order`.
