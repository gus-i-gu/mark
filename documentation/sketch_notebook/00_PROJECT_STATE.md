# 00_PROJECT_STATE.md

> Version: Recovery global state 0.1
> Status: Active Global State Canon-Checkpoint
> Persistence Class: Canon-Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Reconciliation source: `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Concise accepted global state and low-cost recovery entrypoint

---

# 1. Current Milestone

The Sketch Notebook recovery cycle has completed its first permanent-domain reconstruction.

```text
methodology bootstrap
→ repository structural recovery
→ A/B/C functional staging
→ Main reconciliation
→ Operational domain repopulation
→ Didactic domain repopulation
→ Design domain repopulation
→ cross-domain verification
→ global state reconstruction
```

All three functional domains now expose canonical, derived, checkpoint, and observational memory.

The current milestone is:

```text
recovery stabilization and validation preparation
```

It is not feature expansion. No mobile, backend, synchronization, installer, or new packaging architecture is currently accepted as the active implementation milestone.

---

# 2. Current Application State

Markei is a local Python desktop application using PySide6 and SQLite.

```text
main.py
→ app.main.main()
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

Storage, Shortage, and Market are currently represented as modes inside Lists rather than independent public tabs.

Current responsibility direction:

| Layer | Current responsibility |
| --- | --- |
| Desktop | Qt rendering, input, navigation, dialogs, and refresh coordination |
| `ProductService` | Workflows, validation, calculations, settings, stores, and UI-facing projections |
| `Repository` | SQL, row/model mapping, persistence operations, commits, and one connection/cursor per instance |
| Database Manager | Paths, initialization, connection configuration, additive migration, close/reset primitives |
| SQLite | Persistent facts and declared relationships |

Desktop code does not execute SQL. Domain models do not own persistence or complete workflows.

---

# 3. Current Domain and Persistence State

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

`Purchase` is the historical receipt record. `Product` contains editable identity and metadata plus current and cached analytical state derived from Purchase history. `ProductService.recalculate_product()` is the centralized producer of calculated Product summaries.

Promotion persistence exists in the schema but is not currently classified as an active end-to-end application capability.

Bundled database resources:

```text
app/database/schema.sql
app/database/seed.sql
```

Writable user state:

```text
%LOCALAPPDATA%/Markei/market.sqlite
```

Managed SQLite connections use foreign-key enforcement, WAL journaling, synchronous `NORMAL`, and `sqlite3.Row`.

Fresh initialization uses schema and optional seed resources. Existing databases receive additive, idempotent compatibility changes. A numbered migration ledger and schema-version table do not currently exist.

---

# 4. Current Lifecycle and Transaction State

Normal MainWindow construction creates:

```text
4 pages
→ 4 ProductService instances
→ 4 Repository instances
→ 4 SQLite connections and cursors
```

Local service/repository close capability and page-level cleanup attempts exist. One authoritative application-level shutdown owner is not established.

This is a confirmed structural condition, not proof of a runtime resource leak.

Repository mutations commit independently. Receipt registration and purchase deletion/recalculation span multiple commits and are not transactionally atomic across the complete user action.

Whether lifecycle ownership should be centralized and whether workflow-level transactions are required remain Design/human decisions.

---

# 5. Current Operational State

The Operational domain is fully repopulated.

Current highest priorities:

```text
P0  protect ordinary user data during validation
P1  validate deterministic Qt shutdown and closure of all four repositories
P1  map exact partial states under multi-commit workflow failure
P1  resolve production seed policy
P2  validate migration and reset behavior in isolated databases
P2  revalidate packaged SQL-resource inclusion and discovery
P2  validate installed data preservation when installer tooling is available
P2  complete retained human desktop interaction checks
```

Historical main-branch packaging evidence reports a working one-folder frozen runtime, but it is not contemporary recovery-branch validation. Installer compilation and installed lifecycle validation remained incomplete.

Operational checkpoint:

```text
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
```

---

# 6. Current Didactic State

The Didactic domain is fully repopulated with a fresh recovery KANBAN baseline, glossary, concept-map checkpoint, and observational record.

Active learning areas include:

- responsibility and package boundaries;
- raw versus derived data;
- naming as a data contract;
- dataclasses and domain representations;
- application service and repository patterns;
- presentation adapters and view models;
- SQLite initialization, migration, PRAGMAs, and relational integrity;
- bundled resources versus writable user data.

Unstable learning areas remain:

- resource ownership and lifetime;
- deterministic cleanup;
- connection and cursor ownership;
- statement atomicity versus workflow atomicity.

No canonical concept is Green through explicit human learning validation. Implementation confidence does not automatically establish learner mastery.

Didactic checkpoint:

```text
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

---

# 7. Current Design State

The Design domain is fully repopulated.

Accepted current architecture:

```text
Desktop UI
→ ProductService application facade
→ Repository persistence facade
→ Database Manager
→ SQLite
```

The present broad ProductService and Repository responsibilities are accepted as descriptions of current concentration, not permanent decomposition decisions.

Open Design questions include:

- page-local versus composition-owned service/repository lifetime;
- authoritative startup and shutdown owner;
- workflow transaction policy;
- service and repository decomposition;
- complete versus declarative source contracts;
- dictionary versus typed view models;
- formatting ownership;
- additive versus versioned migrations;
- Promotion status;
- `pages.order` status;
- long-term Product editable-state/cache role.

These are unresolved questions, not approved refactor instructions.

Design checkpoint:

```text
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

---

# 8. Methodology and Recovery State

The methodology bootstrap remains:

```text
INDEX.md
→ METHOD_FOUNDATIONS.md
→ FLUX.md
→ PROMOTION_RULES.md
→ CHAT_PROTOCOL.md
```

The recovery demonstrated the intended separation among:

```text
repository evidence
functional staging
Main reconciliation
semantic promotion
physical materialization
permanent domain memory
```

A prior path mismatch around the Main J reference and an extra temporary Operational stage filename were detected and corrected. Exact file paths and authorized stage surfaces remain part of the knowledge-routing contract.

The previous Cycle 05 is globally classified as:

```text
useful partial artifact outcome
+
failed / incoherent methodology-cycle closure
```

Its durable lesson is to maintain one explicit milestone, preserve inherited validation debt, separate current facts from future targets, and reconcile domain outputs before replacing shared coordination surfaces.

---

# 9. Active Global Risks and Decisions

## Validation risks

- shutdown behavior is structurally implicit and not yet directly proven;
- multi-commit workflows can produce partial durable states;
- production seed classification remains unresolved;
- complex migration safety is not established;
- current-branch generated and installed runtime behavior requires revalidation;
- prior human UI verification debt remains open.

## Decision boundaries

Main/human and Design must decide lifecycle ownership, workflow transaction policy, seed policy, facade decomposition, contract scope, view-model typing, migration strategy, Promotion status, `pages.order`, and long-term Product modeling.

No decision above is authorized merely by appearing in this checkpoint.

---

# 10. Global Recovery Route

Use the least expensive sufficient source:

```text
1. Read this file for global orientation.
2. Read the relevant domain checkpoint.
3. Read the relevant derived surface for task detail.
4. Read exact domain canon only when precise rules or definitions are required.
5. Read observational history only when chronology or correction history matters.
6. Inspect repository implementation only when notebook memory is insufficient,
   implementation truth is directly relevant, or drift is suspected.
```

Domain checkpoints:

```text
Operational  operational/10_OPERATIONAL_STATE.md
Didactic     didactics/08_CONCEPT_MAP.md
Design       design/09_DESIGN_STATE.md
```

Temporary Main reconciliation surface:

```text
[M]_STAGE/J_[M]_STAGE.md
```

---

# 11. Next Main Continuity Actions

The next Main-root files must be rebuilt separately and in order:

```text
1. 05_SESSION_LOG.md
2. 06_SESSION_SCHEME.md
```

`05_SESSION_LOG.md` should preserve the recovery chronology, major corrections, domain repopulation, and accepted reconciliation events without becoming current-state canon.

`06_SESSION_SCHEME.md` should then define the next bounded session, expected recovery files, unresolved decisions, validation priorities, exit criteria, and recovery warnings.

The current `00_PROJECT_STATE.md` rebuild is complete.