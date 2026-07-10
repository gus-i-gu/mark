# 00_PROJECT_STATE.md

> Status: Active global state
> Authority: Main Chat
> Persistence class: Global State Canon-Checkpoint
> Scope: Fast recovery of current Markei and Sketch Notebook state

---

# 1. Current Milestone

Markei has completed Cycle 04 - Settings Stabilization.

```text
Cycle 04 application changes were materialized and validated.
Operational, Didactic, and Design domain memory were reconciled.
Main continuity is closed for the session.
```

Cycle 04 recovered from an initially disturbed staging attempt by restarting from repository-backed A/B/C stages, producing Main-approved D/E/F stages, materializing through Codex, validating through G/H/I, and reconciling into permanent O/A/D domain memory.

# 2. Current Application State

Public desktop tabs:

```text
Register
Lists
History
Settings
```

Stable state:

- Register remains purchase-entry-only.
- Lists remains the public inventory surface.
- History remains service-driven with Month -> Week grouping and embedded read-only analytics.
- Settings remains the user-facing configuration and store-management surface.
- Store create/update remains in Settings.
- Product View remains service-driven and read-only.

Cycle 04 canonical settings:

```text
history.week_boundary
history.month_boundary_mode
history.month_boundary_weekday
history.month_boundary_day
time_reference.day_boundary_time
```

Implemented behavior:

- week boundary supports all seven weekdays;
- month boundary supports `first_weekday` and `day_of_month`;
- month weekday supports all seven weekdays;
- month day is constrained to 1-28;
- day-boundary time uses normalized 24-hour `HH:MM`;
- invalid submitted values are rejected before persistence;
- invalid persisted values fall back safely;
- defaults are inserted non-destructively;
- legacy `history.month_boundary_rule` remains compatibility residue;
- `pages.order` remains persisted but inert.

Current purchase records are date-only. Therefore `time_reference.day_boundary_time` is contract-ready but does not materially alter current History grouping.

# 3. Current Architecture State

```text
Desktop UI
-> ProductService
-> Repository
-> SQLite
```

- UI owns rendering, controls, navigation hooks, edit events, and page composition.
- ProductService owns business meaning, settings defaults, strict edit validation, persisted-value fallback, History grouping, read-model assembly, and operational-date interpretation.
- Repository owns SQL retrieval, row mapping, and generic key/value persistence.
- SQLite owns persisted facts, relationships, migrations, and settings rows.

Cycle 04 introduced no intentional architectural boundary drift.

Implementation watch point:

- First-weekday operational-month period-end calculation should be verified. Source inspection suggests its displayed end may differ from the intended day-before-next-period rule.

# 4. Current Didactic State

Cycle 04 learning pipeline:

```text
persisted preference
-> service validation / fallback
-> interpreted behavior
-> read model or operational helper
-> PySide6 presentation
```

Strengthened concepts include Configuration State, Default Value as Fallback Contract, Validation Boundary, Enumerated Choice Values, Time Bucketing, Time Reference as Behavioral Anchor, Settings-Owned Preferences, ProductService-Owned Settings Interpretation, Repository-Owned Settings Persistence, and History Grouping Service Responsibility.

No concept was promoted to Green.

Important distinctions:

- preference is not interpreted behavior;
- invalid-edit rejection is not persisted-value fallback;
- UI label is not stored semantic value;
- factual purchase date is not derived operational date;
- platform preparation is not platform implementation.

# 5. Platform Readiness

Current classification:

```text
Improved preparation for future platform discussion.
Not ready for a second platform implementation.
```

Prepared:

- service-owned Lists and History read models;
- service-owned Settings validation and interpretation;
- platform-neutral semantic settings values;
- UI-label versus semantic-value separation;
- operational-date helper outside PySide6.

Not ready:

- second presentation layer;
- shared service infrastructure;
- account or synchronization design;
- cross-platform persistence;
- typed service contracts;
- dependency injection/service factory;
- reliable time-of-day purchase data;
- automated service and UI interaction coverage.

# 6. Current Sketch Notebook State

Cycle 04 completed this repository-backed loop:

```text
INDEX-driven bootstrap
-> A/B/C functional staging
-> D/E/F Main synthesis
-> Codex materialization
-> G/H/I evidence
-> O/A/D permanent-domain reconciliation
-> Main session closure
```

The earlier staging disturbance remains historical evidence, but it no longer describes current project state.

Permanent domain checkpoints now reflect Cycle 04:

- `operational/10_OPERATIONAL_STATE.md`
- `didactics/08_CONCEPT_MAP.md`
- `design/09_DESIGN_STATE.md`

DEV_STAGE retains Cycle 04 staging and Codex evidence. These are staging and observational inputs, not current canonical truth.

# 7. Active Risks And Remaining Work

Highest-priority work:

1. Human Settings save-feedback QA for valid and invalid inputs.
2. Human store create/update UI QA and dependent-page refresh verification.
3. Verify first-weekday operational-month period-end labels.
4. Validate Register, Lists, History analytics, Settings, and Product View interaction paths.

Existing risks:

- invalid analytics date input behaves like an omitted boundary;
- same-day purchases can produce sub-day frame average timelapse;
- multi-store analytics needs richer fixture validation;
- old Storage/Shortage/Market source files remain transitional;
- `pages.order` remains inert and potentially misleading;
- legacy and canonical month-boundary keys may coexist;
- full automated PySide6 interaction coverage is absent.

Deferred decisions:

- legacy month-key cleanup policy;
- `pages.order` removal or implementation;
- future purchase time-of-day storage;
- operational-day effects on Lists or predictions;
- Settings internal component split;
- future platform architecture.

# 8. Recovery Route

Start with:

```text
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

Then use the relevant domain checkpoint:

```text
Operational: operational/10_OPERATIONAL_STATE.md
Didactic: didactics/08_CONCEPT_MAP.md
Design: design/09_DESIGN_STATE.md
```

Read DEV_STAGE or source files only when validating materialization, investigating drift, or executing the next approved task.
