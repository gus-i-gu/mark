# [M] Post-Promotion Domain Consolidation

> Status: Temporary Main synthesis
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Branch: `sketch-notebook-recovery`
> Scope: Cross-domain verification after first permanent-domain repopulation and direct source for rebuilding `00_PROJECT_STATE.md`
> Knowledge state: Reconciled staging; not permanent domain canon
> Expiry condition: Absorbed into `00_PROJECT_STATE.md`, then retained only until `05_SESSION_LOG.md` and `06_SESSION_SCHEME.md` are rebuilt

---

# 1. Purpose

The first Sketch Notebook recovery promotion cycle has completed for all three permanent functional domains.

This Main synthesis verifies:

```text
Operational canon / derivative / checkpoint / history
+
Didactic canon / derivative / checkpoint / history
+
Design canon / derivative / checkpoint / history
```

It establishes the global referential state from which `00_PROJECT_STATE.md` may be rebuilt without duplicating the full contents of any domain.

This file does not replace functional canon. Exact operational rules remain in `operational/12_OPERATIONAL_MODEL.md`; exact didactic concepts remain in `didactics/02_KANBAN.md`; exact architectural rules remain in `design/01_ARCHITECTURE.md`.

---

# 2. Domain Symmetry Verification

## 2.1 Operational

```text
Canonical       operational/12_OPERATIONAL_MODEL.md
Derived         operational/04_TODO.md
Checkpoint      operational/10_OPERATIONAL_STATE.md
Observational   operational/11_OPERATIONAL_RECORD.md
```

Verified condition:

- all four semantic roles are populated;
- canon defines runtime, persistence, lifecycle, transaction, reset, isolation, and validation rules;
- TODO reorganizes canon into active validation priorities and command-ready checks;
- checkpoint exposes the current execution state and recovery route;
- observational history records the reconstruction sequence, reference-path correction, staging-topology correction, and Cycle 05 retrospective.

Operational domain status: **repopulated and recoverable**.

## 2.2 Didactic

```text
Canonical       didactics/02_KANBAN.md
Derived         didactics/07_GLOSSARY.md
Checkpoint      didactics/08_CONCEPT_MAP.md
Observational   didactics/13_LECTURE_REGISTER.md
```

Verified condition:

- all four semantic roles are populated;
- canon contains the fresh recovery concept register across the established marker families;
- glossary derives concise retrieval terminology from canon;
- checkpoint separates active, unstable, and next concepts and exposes the project learning spine;
- observational history records the didactic reconstruction, authoritative-path correction, concept promotion, and failed-cycle learning context.

No concept is Green through explicit human learning validation. Repository evidence establishes concept relevance and project accuracy, not learner mastery.

Didactic domain status: **repopulated and recoverable**.

## 2.3 Design

```text
Canonical       design/01_ARCHITECTURE.md
Derived         design/14_MODEL_OVERVIEW.md
Checkpoint      design/09_DESIGN_STATE.md
Observational   design/03_DECISION_LOG.md
```

Verified condition:

- all four semantic roles are populated;
- canon defines the current architecture and accepted responsibility boundaries without promoting unresolved redesigns;
- model overview provides the low-cost structural map;
- checkpoint records the current stabilization milestone, constraints, dependencies, and open decisions;
- observational history records investigation, reconciliation, promotion, corrections, and the failed Cycle 05 precedent.

Design domain status: **repopulated and recoverable**.

---

# 3. Cross-Domain Canonical Convergence

The three domains converge on the following current project baseline.

## 3.1 System form

Markei is a local Python desktop monolith using PySide6 and SQLite.

```text
root main.py
→ app.main.main()
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

Storage, Shortage, and Market are current Lists modes rather than independent public pages.

## 3.2 Responsibility direction

```text
Desktop presentation
    Qt widgets, input, rendering, navigation, dialogs, refresh coordination

ProductService
    application workflows, validation, calculations, settings interpretation,
    stores, and UI-consumable projections

Repository
    SQL, row/model mapping, persistence operations, individual commits,
    one connection and cursor per instance

Database Manager
    resource and user-data paths, initialization, connection configuration,
    additive compatibility migration, close/reset primitives

SQLite
    persistent facts and declared relationships
```

Desktop code does not execute SQL. Domain models do not own persistence or complete application workflows.

## 3.3 Domain and data model

Active domain representations:

```text
Category
Store
Product
Purchase
```

Relationship spine:

```text
Category 1 ─── * Product
Product  1 ─── * Purchase
Store    1 ─── * Purchase, optional
```

Accepted current interpretation:

```text
Purchase
    historical receipt/source record

Product
    editable identity and metadata
    + current state
    + cached analytical summaries derived from Purchase history
```

`ProductService.recalculate_product()` is the centralized producer of calculated Product summary state.

Promotion persistence exists in the schema but is not currently promoted as an active end-to-end application capability.

## 3.4 Persistence lifecycle

Bundled resources:

```text
app/database/schema.sql
app/database/seed.sql
```

Writable user state:

```text
%LOCALAPPDATA%/Markei/market.sqlite
```

Managed connections use:

```text
foreign_keys = ON
journal_mode = WAL
synchronous = NORMAL
row_factory = sqlite3.Row
```

Initialization creates a missing database from schema and optional seed resources. Existing databases receive additive, idempotent compatibility changes. No numbered migration ledger or schema-version table currently exists.

## 3.5 Lifecycle ownership

Normal MainWindow composition creates:

```text
4 pages
→ 4 ProductService instances
→ 4 Repository instances
→ 4 SQLite connections and cursors
```

Local service/repository close capability exists, and page-level cleanup attempts exist. One authoritative composition-level shutdown owner is not established.

This is a confirmed structural condition, not proof of a runtime leak.

## 3.6 Transaction model

Repository mutation methods commit independently.

```text
receipt registration
    create/update Product   → commit
    insert Purchase         → commit
    recalculate summary     → update Product → commit
```

Purchase deletion plus recalculation is likewise multi-commit.

The workflows are sequential but not transactionally atomic across the complete user action. Whether workflow-level transactions are required remains a Design/human decision.

## 3.7 Representation flow

```text
SQLite row
→ domain model
→ service projection / view model
→ Qt rendering
```

Current projections are dictionary-based and platform-neutral, with some formatting performed by ProductService. Typed view models and alternate formatting ownership remain unresolved refinements.

---

# 4. Current Recovery Milestone

```text
methodology bootstrap
→ repository structural recovery
→ A/B/C functional staging
→ Main reconciliation in J
→ first domain promotion
→ operational domain symmetry complete
→ didactic domain symmetry complete
→ design domain symmetry complete
→ post-promotion cross-domain verification complete
→ 00_PROJECT_STATE rebuild ready
```

The project is now in **recovery stabilization**, not feature expansion.

No new mobile, backend, synchronization, installer, or packaging architecture is currently accepted as an active implementation milestone.

---

# 5. Precedent Cycle 05 Classification

The permanent domains consistently classify the prior Cycle 05 as a mixed artifact outcome and failed methodology-cycle closure.

```text
artifact outcome
    useful packaging knowledge
    reportedly validated one-folder frozen runtime
    external per-user SQLite state
    installer configuration begun

cycle outcome
    failed / incoherent closure
```

The cycle widened from unresolved Cycle 04 verification into mobile preparation and then Windows packaging. Staging, direction, evidence, and report synchronization did not remain coherent. The installed lifecycle was not completed.

Historical main-branch packaging evidence must not be treated as current recovery-branch runtime validation without direct revalidation.

---

# 6. Active Cross-Domain Risks and Open Decisions

## Operational validation required

- deterministic closure of all four page-owned repositories during normal Qt shutdown;
- exact durable partial states under injected workflow failure;
- migration idempotence and migration-failure behavior in isolated databases;
- reset behavior with open connections and WAL/SHM files;
- schema/seed inclusion and discovery in generated artifacts;
- production exclusion of sample seed data, live database, and WAL/SHM files;
- installed upgrade, uninstall, and reinstall preservation behavior;
- complete human desktop interaction walkthrough.

## Human/Main and Design decisions required

- page-local versus composition-owned services and repositories;
- authoritative application startup and shutdown owner;
- workflow-level transaction policy;
- production seed classification;
- broad ProductService and Repository facade continuity or decomposition;
- completeness or simplification of source contracts;
- dictionary versus typed view models and formatting ownership;
- additive versus versioned migration strategy;
- Promotion persistence status;
- `pages.order` consumption, migration, or retirement;
- long-term Product editable-state/cache role.

These are not approved refactor instructions.

---

# 7. Didactic State

The first recovery KANBAN baseline is populated.

Active concepts include responsibility boundaries, raw versus derived data, naming contracts, packages/modules, dataclasses, application service, repository/persistence adapter, presentation adapter, representation layers, SQLite initialization/migration, PRAGMA configuration, relational integrity, and bundled resource versus writable user data.

Unstable concepts remain:

```text
resource ownership and lifetime
context manager and deterministic cleanup
statement atomicity versus workflow atomicity
SQLite connection and cursor ownership
```

No concept is Green until explicit human learning validation occurs.

---

# 8. Global Recovery Routing

For global recovery after `00_PROJECT_STATE.md` is rebuilt:

```text
1. 00_PROJECT_STATE.md
2. relevant domain checkpoint
3. relevant derived surface
4. exact domain canon only when precision is required
5. observational history only when evolution matters
6. repository inspection only when implementation truth or drift requires it
```

Domain checkpoints:

```text
Operational  operational/10_OPERATIONAL_STATE.md
Didactic     didactics/08_CONCEPT_MAP.md
Design       design/09_DESIGN_STATE.md
```

---

# 9. Input Contract for `00_PROJECT_STATE.md`

The rebuilt global state should remain concise and include only:

1. recovery milestone and domain-repopulation completion;
2. current application and architecture summary;
3. current operational validation state;
4. current didactic state;
5. current methodology/recovery state;
6. highest cross-domain risks and unresolved decisions;
7. exact low-cost recovery route;
8. next Main continuity action: rebuild `05_SESSION_LOG.md`, followed separately by `06_SESSION_SCHEME.md`.

It must not duplicate complete domain canon, long command sets, full concept definitions, or the full Cycle 05 chronology.

---

# 10. Temporary Stage Conclusion

The permanent functional domains are mutually coherent and sufficiently complete to support global-state reconstruction.

No blocking canonical contradiction was found among the three domains.

The most important global distinction is:

```text
current implementation structure is recovered and canonically described
but
runtime validation debt and future architecture decisions remain open
```

`00_PROJECT_STATE.md` may now be rebuilt from this synthesis.