# 00_PROJECT_STATE.md

> Status: Active global state
> Authority: Main Chat
> Persistence class: Global State Canon-Checkpoint
> Scope: Fast recovery of current Markei and Sketch Notebook state

---

# 1. Current Milestone

Markei has completed Cycle 03 — Read-Model Consolidation.

Cycle 03 materialized:

- unified `Lists` page;
- embedded History analytics;
- global latest / delta price display in Lists;
- service-owned read models for Lists and History analytics;
- mobile-readiness preparation through boundaries, not rewrite.

This file is the Main-owned global recovery surface. It intentionally combines current-state checkpoint behavior with accepted global project-state canon. It should remain concise and point to domain checkpoints for depth.

---

# 2. Current Application State

Public desktop tabs are now:

```text
Register
Lists
History
Settings
```

Former public Storage / Shortage / Market meanings are now Lists internal views:

```text
Storage  -> in-house
Shortage -> shortage
Market   -> to-buy
```

Lists supports:

```text
all
in-house
shortage
to-buy
in-house + shortage
shortage + to-buy
```

Current feature state:

- Register remains purchase-entry-only.
- Settings remains the store-management surface.
- Product View remains service-driven and operational.
- Lists is the public inventory surface.
- History remains grouped by service-owned Month -> Week logic.
- History now includes embedded read-only analytics.
- Cycle 03 introduced no schema changes.

---

# 3. Current Architecture State

Accepted boundary:

```text
Desktop UI
↓
ProductService
↓
Repository
↓
SQLite
```

ProductService owns:

- Product View read models;
- Lists read models;
- grouped History read models;
- History analytics read models;
- inventory status classification;
- latest/delta price meaning;
- analytics frame interpretation;
- expenditure percentages;
- frame average purchase timelapse;
- product-cycle comparison.

UI owns rendering, controls, navigation hooks, and event handling.

Repository owns SQL retrieval, persistence, settings access, and row mapping.

SQLite owns persisted facts, relationships, settings, and migrations.

---

# 4. Current Didactic State

Cycle 03 learning focus:

```text
raw data
→ filtered frame
→ aggregate
→ derived metric
→ read model
→ UI presentation
```

New or reinforced concept areas:

- percentage as derived aggregate;
- filtering frame;
- comparative metric;
- baseline definition;
- status classification versus UI filtering;
- platform-neutral read-model shape;
- History analytics read model;
- unified Lists page with internal views;
- mobile readiness without rewrite.

Didactic concepts are registered in `didactics/02_KANBAN.md`, summarized in `didactics/08_CONCEPT_MAP.md`, and explained through `didactics/07_GLOSSARY.md`.

---

# 5. Mobile Readiness

Current classification:

```text
Prepared for future mobile discussion.
Not ready for mobile implementation.
```

Prepared:

- service-owned Lists read model;
- service-owned History analytics read model;
- platform-neutral dictionaries/lists;
- reduced UI calculation ownership;
- clearer Desktop UI / ProductService / Repository / SQLite boundary.

Not ready:

- mobile UI;
- API/backend rewrite;
- sync/auth design;
- mobile persistence strategy;
- typed service contracts;
- dependency injection/service factory;
- formal date validation;
- automated service tests;
- explicit separation between UI labels and semantic values.

---

# 6. Current Sketch Notebook State

Cycle 03 completed the first full experimental Sketch Notebook loop:

```text
A/B/C functional staging
↓
D/E/F Main synthesis
↓
Codex materialization
↓
G/H/I Codex reports
↓
O/A/D domain absorption
↓
Main reconciliation
```

The loop worked, but exposed method refinements:

- some files became over-verbose;
- checkpoints need compactness enforcement;
- derived files need resorting discipline;
- ever-growing files need read-window rules;
- `06_SESSION_SCHEME.md` needs formal registration as a forward checkpoint;
- `[M]_STAGE/J_MAIN_STAGE.md` needs routing decision;
- `PROVISORY_[M]_DOUBLE_LAB.MD` is a temporary lab bridge, not canon.

---

# 7. Active Risks

Application risks:

- Manual UI QA remains incomplete.
- Invalid analytics date input behaves like an omitted boundary.
- Same-day purchases can produce sub-day frame average timelapse.
- Multi-store analytics totals need richer validation.
- Old Storage/Shortage/Market page files remain transitional.
- `pages.order` remains persisted but inert.

Methodology risks:

- Root Main files are being initialized after the first complete cycle rather than before it.
- `06_SESSION_SCHEME.md`, `[M]_STAGE`, and `PROVISORY_[M]_DOUBLE_LAB.MD` require routing registration or explicit provisional classification.
- File-growth and reconciliation rules need methodology revision.

---

# 8. Next Recovery Files

For operational state:

```text
operational/10_OPERATIONAL_STATE.md
```

For learning state:

```text
didactics/08_CONCEPT_MAP.md
```

For design state:

```text
design/09_DESIGN_STATE.md
```

For next-session agenda:

```text
06_SESSION_SCHEME.md
```

For session history:

```text
05_SESSION_LOG.md
```

For Main staging of current method-lab conclusions:

```text
[M]_STAGE/J_MAIN_STAGE.md
```
