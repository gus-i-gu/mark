# J_MAIN_STAGE.md

> Status: Active Main staging draft
> Scope: Cycle 05 preparation for full mobile implementation
> Authority: Main Chat
> Persistence class: Main stage / refreshable synthesis

---

# 1. Purpose

This J stage carries the closed Cycle 04 global state into Cycle 05 preparation.

It stages the Main-level synthesis needed before any full mobile implementation begins.

Cycle 05 is not yet authorization to build the mobile application. Its first responsibility is to put every required change, dependency, boundary, migration, test, and product decision into an ordered implementation program.

Source continuity:

- `00_PROJECT_STATE.md` records Cycle 04 as materialized, domain-reconciled, and globally closed.
- `05_SESSION_LOG.md` records the Cycle 04 implementation evidence, limitations, watch points, and closure history.
- `06_SESSION_SCHEME.md` provides the forward recovery and execution sequence.

# 2. Current Accepted Baseline

Cycle 04 closed with this stable application boundary:

```text
Desktop UI
-> ProductService
-> Repository
-> SQLite
```

Current stable capabilities:

- Register purchase entry;
- unified Lists page;
- grouped History and embedded analytics;
- Settings and store create/update;
- service-owned read models;
- service-owned Settings validation and interpretation;
- platform-neutral semantic setting values;
- repository-owned generic persistence.

Current platform classification:

```text
Improved preparation for mobile discussion.
Not ready for full mobile implementation.
```

# 3. Cycle 04 Closure Material Carried Forward

Cycle 05 must preserve these conclusions from `00_PROJECT_STATE.md` and `05_SESSION_LOG.md`:

1. UI labels and stored semantic values are separate.
2. ProductService owns business interpretation.
3. Repository remains a persistence adapter rather than a business-meaning owner.
4. Current purchase records remain date-only.
5. `time_reference.day_boundary_time` is contract-ready but does not materially affect current records.
6. `pages.order` remains inert.
7. Legacy `history.month_boundary_rule` remains compatibility residue.
8. Human UI verification remains incomplete.
9. A possible first-weekday period-end defect remains to be verified.
10. Mobile implementation must not copy PySide6 widget behavior into a second UI layer.

# 4. Cycle 05 Primary Objective

Prepare a complete ordered program for mobile implementation.

The cycle should answer:

```text
What must become platform-neutral?
What must remain desktop-specific?
What persistence model will mobile use?
How will desktop and mobile share or synchronize data?
What service contracts are required?
What API or backend boundary is required?
What authentication and identity model is required?
What migrations preserve current local data?
What validation and automated tests are required before mobile UI work?
Which mobile technology and packaging route will be selected?
```

The output should be an implementation sequence, dependency map, risk register, and acceptance plan.

# 5. Required Preparation Domains

## 5.1 Product and scope definition

Define the first mobile release precisely:

- mobile companion versus full desktop replacement;
- offline-only versus synchronized use;
- single-user versus account-based use;
- supported mobile platforms;
- required screens and workflows;
- features explicitly excluded from the first mobile release.

Do not let “full mobile implementation” remain an undefined ambition.

## 5.2 Application-core separation

Audit the current core for platform coupling.

Required outcomes:

- identify every PySide6 dependency outside desktop presentation files;
- identify service methods that can already be reused;
- define typed service/read-model contracts;
- define a service factory or dependency-injection boundary;
- separate application configuration from desktop widget state;
- formalize date/time parsing and validation independent from widgets;
- preserve ProductService as business-meaning owner unless evidence requires a more explicit application layer.

## 5.3 Persistence and data ownership

Choose and document the target mobile data architecture.

Candidate questions:

- local SQLite on each device;
- shared remote database through an API;
- offline-first local database with synchronization;
- desktop-local data migration;
- stable identifiers across devices;
- conflict handling;
- backup and recovery;
- schema-version compatibility;
- attachment/image storage if receipt capture is later added.

No synchronization implementation should begin before data ownership and conflict rules are explicit.

## 5.4 Backend and API boundary

Determine whether full mobile implementation requires a backend.

If required, define:

- API responsibilities;
- authentication boundary;
- request/response contracts;
- versioning;
- error model;
- pagination/filtering needs;
- secure configuration handling;
- deployment and operating-cost constraints;
- desktop compatibility with the same service boundary.

Avoid exposing SQLite or repository internals directly as an API contract.

## 5.5 Identity, privacy, and security

Before account or synchronization work, define:

- whether accounts are required;
- user and household ownership model;
- authentication method;
- authorization rules;
- local session handling;
- data export and deletion expectations;
- handling of store, purchase, receipt, and future image data;
- secret and credential storage boundaries.

Security-sensitive implementation must follow a dedicated reviewed stage rather than being improvised inside UI development.

## 5.6 Mobile presentation architecture

Select the mobile framework only after the reusable core and data boundary are understood.

The comparison should consider:

- compatibility with the existing Python core;
- ability to share contracts or generated clients;
- Android and possible iOS support;
- offline storage support;
- camera and receipt-image access;
- maintainability for the current developer;
- testing and packaging quality;
- distribution path;
- long-term ecosystem risk.

Framework selection is a Cycle 05 decision, not an assumption.

## 5.7 Testing and validation foundation

Before broad mobile UI construction, establish:

- automated ProductService tests;
- settings and temporal-boundary tests;
- repository contract tests;
- migration tests;
- API contract tests if a backend is selected;
- mobile view-model tests;
- desktop regression checks;
- fixture strategy for multiple stores, dates, and devices;
- acceptance criteria for offline and synchronization behavior.

Human-only validation is insufficient for a second-platform expansion.

## 5.8 Desktop compatibility and migration

Cycle 05 must decide whether desktop remains:

- an independent local application;
- a client of the same backend;
- an administrative companion;
- a migration source only;
- or a maintained parallel platform.

Required preparation:

- current database import/export route;
- compatibility with existing user data;
- legacy Settings key cleanup policy;
- treatment of inert `pages.order`;
- time-of-day storage decision;
- schema evolution rules;
- rollback strategy.

# 6. Ordered Cycle 05 Workstreams

Recommended order:

```text
0. Close remaining Cycle 04 verification risks
1. Define mobile product scope and acceptance criteria
2. Audit core/platform coupling
3. Define typed contracts and dependency boundaries
4. Choose data ownership, persistence, and synchronization model
5. Define backend/API and identity requirements
6. Select mobile framework using the established constraints
7. Design migration and desktop coexistence
8. Build automated test foundation
9. Produce phased mobile implementation stages
10. Begin mobile materialization only after Main approval
```

Workstreams may inform each other, but implementation should not skip dependency order.

# 7. Functional Chat Responsibilities For Cycle 05

Operational Chat should produce:

- repository coupling inventory;
- exact files and dependencies;
- validation baseline;
- migration risks;
- implementation sequencing;
- build, packaging, and deployment constraints.

Didactic Chat should produce:

- concepts required before mobile work;
- learning dependency order;
- distinction between application core, adapter, API, synchronization, and presentation;
- glossary and KANBAN proposals grounded in implementation needs.

Design Chat should produce:

- target architecture alternatives;
- responsibility maps;
- data ownership and synchronization boundaries;
- desktop/mobile/backend relationships;
- framework-selection criteria;
- explicit architectural decision points.

Main Chat should reconcile the three reports into phased D/E/F materialization stages.

# 8. Required Cycle 05 Deliverables Before Mobile Coding

Cycle 05 preparation is complete only when Main has:

1. a defined first mobile product scope;
2. a current-state coupling audit;
3. a target architecture decision;
4. a persistence and synchronization decision;
5. an identity/security decision or an explicit no-account decision;
6. a mobile framework decision;
7. typed service/API contract direction;
8. migration and desktop-coexistence plan;
9. automated validation plan;
10. phased implementation roadmap with stop conditions;
11. risks and deferrals clearly classified;
12. Codex-ready stages for only the first approved mobile phase.

# 9. Immediate Preconditions

Before opening broad Cycle 05 domain staging, verify or explicitly carry forward:

- Settings save-feedback interaction;
- store create/update interaction and refresh;
- first-weekday period-end correctness;
- current desktop regression state.

A small correction pass may occur before the mobile-preparation analysis if these checks reveal defects.

# 10. Explicit Non-Authorization

This J stage does not authorize:

- immediate mobile UI implementation;
- backend deployment;
- authentication implementation;
- synchronization implementation;
- destructive database migration;
- receipt-image recognition;
- external provider integration;
- abandonment of the desktop application.

Those require later Main-approved stages after Cycle 05 analysis.

# 11. Main Exit Condition

Cycle 05 preparation succeeds when the project can answer, in dependency order:

```text
what the first mobile product is
what architecture supports it
what data model and backend it requires
what contracts and tests protect it
how current desktop data survives
which implementation phase starts first
```

Only then should Codex receive a first mobile materialization prompt.
