# 06_SESSION_SCHEME.md

> Status: Forward checkpoint
> Authority: Main Chat
> Persistence class: Refreshable planning checkpoint
> Scope: Cycle 05 mobile-development preparation, recovery route, and exit criteria

---

# 1. Next Session Focus

Begin Cycle 05 as an ordering and architecture-preparation cycle for full mobile implementation.

Primary objective:

```text
Identify, classify, and sequence every change required before Markei can safely begin full mobile implementation.
```

Cycle 05 should prepare the complete path. It should not begin broad mobile coding before the target product, architecture, data ownership, persistence, synchronization, contracts, tests, migration, and framework decisions are reconciled.

# 2. Mandatory Recovery Route

Read first:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md
```

Then consult the domain checkpoints:

```text
Operational: documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
Didactic:    documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
Design:      documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

Use deeper domain files and repository source only when the checkpoint is insufficient or when implementation coupling must be verified.

# 3. Current Baseline

Cycle 04 is closed as:

```text
materialized
validated at service/offscreen level
reconciled into Operational, Didactic, and Design memory
globally checkpointed by Main
```

Current accepted layer boundary:

```text
Desktop UI
-> ProductService
-> Repository
-> SQLite
```

Current mobile classification:

```text
Improved preparation for mobile discussion.
Not ready for full mobile implementation.
```

Prepared now:

- service-owned Lists and History read models;
- service-owned Settings validation and interpretation;
- platform-neutral semantic values;
- UI-label and semantic-value separation;
- generic repository persistence;
- operational-date helper outside PySide6.

Still missing:

- defined first mobile product scope;
- target mobile architecture;
- typed service/read-model contracts;
- dependency-injection or service-factory boundary;
- persistence and synchronization model;
- backend/API decision;
- identity and security decision;
- mobile framework decision;
- migration and desktop-coexistence plan;
- automated service, migration, contract, and UI validation foundation.

# 4. Immediate Pre-Cycle Verification

Before broad Cycle 05 staging, resolve or explicitly carry forward:

1. Human Settings save-feedback QA.
2. Human store create/update UI QA.
3. Dependent-page refresh verification.
4. First-weekday operational-month period-end correctness.
5. Basic desktop regression status for Register, Lists, History, Settings, and Product View.

If a defect is confirmed, prepare a focused correction stage before mobile preparation continues.

# 5. Cycle 05 Questions To Resolve

## Product scope

- Is mobile a companion, replacement, or parallel client?
- Is the first release offline-only or synchronized?
- Is it single-user or account-based?
- Which platforms are initially supported?
- Which workflows are mandatory for the first release?

## Application core

- Which current modules are platform-neutral?
- Which behaviors are coupled to PySide6?
- What typed contracts are required?
- Where should dependency construction live?
- Which validation rules must move into reusable application services?

## Data and persistence

- Does each device keep local SQLite data?
- Is there a shared remote source of truth?
- Is an offline-first synchronization model required?
- How are stable IDs, conflicts, backups, and schema versions handled?
- How is current desktop data migrated safely?

## Backend and API

- Is a backend required for the chosen product scope?
- What responsibilities belong to the API?
- What request/response and error contracts are needed?
- How will API versioning and deployment be handled?

## Identity and security

- Are accounts required?
- Who owns purchases, stores, and future receipt data?
- What authentication and authorization model applies?
- How are sessions and sensitive configuration handled?

## Mobile presentation

- Which framework best fits the accepted architecture and developer constraints?
- How will mobile consume shared behavior or generated API clients?
- What offline, camera, packaging, testing, and distribution capabilities are required?

## Testing and migration

- What automated tests must exist before mobile UI implementation?
- How will desktop regressions be detected?
- What migration, rollback, and compatibility rules protect existing data?

# 6. Domain Chat Sequence

Open separate repository-backed domain chats.

## Operational [O]

Primary output:

- current repository/platform coupling audit;
- exact files and dependencies;
- desktop validation baseline;
- build and packaging constraints;
- persistence/migration risks;
- ordered implementation workstreams.

Stage to:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
```

## Didactic [A]

Primary output:

- concepts required for mobile work;
- learning dependency sequence;
- distinction between core, adapter, API, persistence, synchronization, and UI;
- concept maturity and glossary proposals.

Stage to:

```text
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
```

## Design [D]

Primary output:

- target architecture alternatives;
- responsibility and deployment maps;
- persistence/synchronization choices;
- desktop/mobile/backend relationships;
- framework-selection criteria;
- explicit decisions and unresolved branches.

Stage to:

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

Each domain must begin with `AGENTS.md` and `INDEX.md`, follow the Hierarchical Recovery Principle, analyze its primary concern before staging, and avoid source edits.

# 7. Main Reconciliation Sequence

After A/B/C are committed:

```text
1. Compare domain assumptions.
2. Resolve product-scope conflicts.
3. Resolve architecture and data-ownership conflicts.
4. Classify decisions versus open alternatives.
5. Produce a phased mobile roadmap.
6. Prepare D/E/F only for the first approved implementation phase.
```

Do not create one oversized Codex task for the entire mobile application.

# 8. Required Cycle 05 Planning Deliverables

Before mobile materialization begins, Main should possess:

1. mobile release scope;
2. current coupling inventory;
3. target architecture;
4. persistence and synchronization decision;
5. backend/API decision;
6. identity/security decision or explicit no-account decision;
7. mobile framework decision;
8. typed contract direction;
9. migration and desktop-coexistence plan;
10. automated test plan;
11. phased implementation roadmap;
12. risk register and explicit deferrals;
13. first-phase Codex-ready acceptance criteria.

# 9. Recommended Implementation Phases

The exact phases depend on Cycle 05 decisions, but Main should attempt to produce an order similar to:

```text
Phase 0: desktop corrections and automated baseline
Phase 1: platform-neutral contracts and dependency boundary
Phase 2: persistence/API foundation
Phase 3: identity and synchronization foundation, if required
Phase 4: mobile application shell and navigation
Phase 5: Register and Lists mobile workflows
Phase 6: History, Settings, and store workflows
Phase 7: migration, offline behavior, and cross-platform validation
Phase 8: packaging, distribution, and release hardening
```

This is a planning skeleton, not pre-approved architecture.

# 10. Explicit Deferrals Until Reconciled

Do not begin without later Main approval:

- broad mobile UI implementation;
- production backend deployment;
- authentication implementation;
- synchronization implementation;
- destructive migration;
- receipt-image recognition;
- external provider integration;
- removal of the desktop application.

# 11. Cycle 05 Exit Criteria

Cycle 05 preparation succeeds when:

```text
the first mobile product is defined
the target architecture is selected
data ownership and persistence are selected
backend and identity needs are resolved
typed contracts and tests are planned
desktop data migration is protected
implementation is split into safe phases
the first phase has Codex-ready instructions and acceptance criteria
```

If these conditions are not met, Cycle 05 should remain a planning cycle rather than pretending mobile implementation is ready.
