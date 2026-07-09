# 13_LECTURE_REGISTER.md

> Domain: Didactic
> Status: Observational learning history

---

## 2026-07-09 — Product View Didactic Absorption

### Source Evidence

- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

### Learning Event

Codex materialization evidence exposed a coherent learning cycle around the Register-page Product View. The feature introduced shelf-life data, Product View read-model assembly, nullable model-field evolution, schema-safe migration, and explicit separation between service calculation and UI rendering.

### Concepts Absorbed

- &&&01 — Domain Model Field Semantics
- &&&02 — Raw Data Versus Derived Data
- &&&03 — Naming as Data Contract
- &&&04 — Cached Summary Field
- &&%01 — Optional Values and Nullable Fields
- &&%02 — Dataclass Field Evolution
- &%%01 — Markei Purchase Rhythm Versus Shelf-Life Rhythm
- &%%02 — Product View Read Model
- &%%03 — Repository Result Shape
- &%%04 — Service-Owned Calculation Responsibility
- %%%01 — SQLite Schema Evolution
- %%%02 — SQLite PRAGMA
- %%%03 — PySide6 Read-Only Widget Composition

### Key Didactic Observation

The main learner risk is semantic collapse: treating `average_duration_days`, `average_shelf_life_days`, `expected_next_purchase`, `expected_expiration_date`, and `expiration_date` as interchangeable date or duration fields. The lesson should emphasize semantic ownership before implementation mechanics.

### Recommended Next Lecture Sequence

1. Same type, different meaning: field semantics.
2. Raw receipt facts versus derived product summaries.
3. Optional and nullable values as valid absence.
4. Read model as service-prepared display shape.
5. SQLite schema evolution and `PRAGMA table_info`.
6. PySide6 read-only composition after the domain meaning is stable.

### Remaining Didactic Risks

- `expected_expiration_date` may be mistaken for actual purchase-level expiration history.
- Product View UI may be mistaken as the owner of calculations.
- SQLite PRAGMA may be treated as ordinary SQL instead of SQLite metadata introspection.
- Nullable fields may be treated as errors instead of intentionally supported absence.

---

## 2026-07-09 — Cycle 02 History + Settings Didactic Reconciliation

### Source Evidence

- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

### Learning Event

Cycle 02 introduced History and Settings as a continuation of Cycle 01. The feature exposed time bucketing by business boundaries, grouping distinct from sorting, aggregate Total rows, SQLite-backed configuration state, Settings-owned preferences, store editing, and separate read-only versus editable PySide6 composition.

### Concepts Promoted / Added

- &&&05 — Time Bucketing
- &&&06 — Aggregation and Totals
- &&&07 — Grouping Versus Sorting
- &&&08 — Configuration State
- &&%03 — Date/Datetime Boundary Handling
- &%%05 — History Read Model
- &%%06 — Settings-Owned Preferences
- &%%07 — Store Editing Workflow
- &%%08 — History Grouping Service Responsibility
- %%%04 — SQLite Settings Persistence
- %%%05 — PySide6 Editable Form Composition

### Concepts Reinforced From Cycle 01

- &&&02 — Raw Data Versus Derived Data
- &&&03 — Naming as Data Contract
- &&%01 — Optional Values and Nullable Fields
- &%%03 — Repository Result Shape
- &%%04 — Service-Owned Calculation Responsibility
- %%%01 — SQLite Schema Evolution
- %%%02 — SQLite PRAGMA
- %%%03 — PySide6 Read-Only Widget Composition

### Explicit Decisions

- Simple Key/Value Table is a glossary concept and lecture example under `%%%04 SQLite Settings Persistence`, not a standalone KANBAN concept in this cycle.
- SQLite PRAGMA moves from Red exploratory to Yellow reinforced knowledge after reuse in two successful migration cycles. It is still not Green until taught explicitly.
- Page sorting persistence exists, but page sorting behavior is not fully implemented; teaching must preserve that distinction.
- Operational month grouping is not plain calendar-month grouping; it depends on the first-Wednesday boundary.

### Recommended Next Lecture Sequence

1. Grouping versus sorting.
2. Time bucketing by business boundaries.
3. Aggregation and totals as derived data.
4. Configuration state and Settings-owned preferences.
5. Simple key/value settings table tradeoffs.
6. SQLite PRAGMA as migration introspection.
7. Read-only History UI versus editable Settings forms.

### Remaining Didactic Risks

- The learner may treat grouping as only visual sorting.
- Total rows may be mistaken for raw purchase rows.
- Settings may be mistaken as the owner of History calculations.
- Simple key/value tables may look easier than they are because values require parsing and validation.
- PRAGMA may still be mistaken for normal table data access rather than metadata introspection.

---

## 2026-07-09 — Cycle 03 Read-Model Consolidation Didactic Reconciliation

### Source Evidence

Primary:

- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

Validation / boundary context:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

### Learning Event

Cycle 03 consolidated Markei around service-owned read models. Lists replaced the public Storage/Shortage/Market tabs with one unified page and internal views. History gained embedded analytics driven by a date/store filtering frame. ProductService now owns status classification, latest/delta display values, analytics totals, percentages, average purchase timelapse, and product-cycle comparison. The UI renders prepared values without direct SQL or business calculation ownership.

### Concepts Promoted / Added As Staged Learning

- &&&09 — Percentage as Derived Aggregate
- &&&10 — Filtering Frame
- &&&11 — Comparative Metric
- &&&12 — Baseline Definition
- &&&13 — Status Classification Versus UI Filtering
- &&&14 — Mobile Readiness Without Rewrite
- &&%04 — Platform-Neutral Read-Model Shape
- &&%05 — Nullable Derived Display Values
- &&%06 — UI View State
- &%%09 — History Analytics Read Model
- &%%10 — Unified Lists Page With Internal Views
- &%%11 — Latest Value / Delta Calculation
- &%%12 — Service Contract Stability
- %%%06 — PySide6 Composition for Embedded Analytics
- %%%07 — PySide6 Unified Page View Controls
- %%%08 — SQLite Read Queries Versus Cached Columns

### Concepts Reinforced From Earlier Cycles

- &&&02 — Raw Data Versus Derived Data
- &&&03 — Naming as Data Contract
- &&&04 — Cached Summary Field
- &&&06 — Aggregation and Totals
- &&&07 — Grouping Versus Sorting
- &&%01 — Optional Values and Nullable Fields
- &&%03 — Date/Datetime Boundary Handling
- &%%01 — Markei Purchase Rhythm Versus Shelf-Life Rhythm
- &%%03 — Repository Result Shape
- &%%04 — Service-Owned Calculation Responsibility
- &%%05 — History Read Model
- %%%03 — PySide6 Read-Only Widget Composition

### Explicit Decisions / Boundaries

- Lists default view is the hybrid all-products view with Status column.
- Lists internal views are `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy`.
- Latest price and delta price are global per product in Cycle 03, not scoped to History frame filters.
- History analytics frame means date range plus optional store filter.
- Frame average purchase timelapse is the average interval between parsed purchases inside the selected frame.
- Product cycle means `average_duration_days` and does not use shelf-life fields.
- Analytics values remain read-time service derivations; no schema changes or persisted analytics cache were introduced.
- Mobile readiness is represented by platform-neutral service dictionaries/lists and UI separation, not by mobile implementation.

### Kept Explicitly Unstable

- detachable analytics widget lifecycle;
- store/frame-scoped price delta;
- configurable comparison tolerance;
- active `pages.order` tab ordering;
- mobile implementation architecture;
- API/backend rewrite;
- persisted analytics cache;
- deletion of old Storage/Shortage/Market page files.

### Recommended Next Lecture Sequence

1. Raw rows versus derived display/read-model values.
2. Filtering frame: date/store inclusion, excluded rows, and unparsed rows.
3. Aggregation before percentages.
4. Product unit price versus product total spent versus frame total spent versus expenditure percentage.
5. Baseline definition and frame average purchase timelapse.
6. Product cycle as purchase rhythm, not shelf-life.
7. Comparative metric as product cycle minus baseline.
8. Lists internal views as UI state over one shared read model.
9. Status classification versus UI filtering.
10. Platform-neutral service read models as mobile readiness without rewrite.

### Remaining Didactic Risks

- Invalid date text currently behaves like an omitted boundary; learners may miss the distinction between invalid input and no input.
- Same-day purchases can make frame average timelapse less than one day; this is a row-interval average, not necessarily a daily shopping habit.
- Store-filtered analytics may show many excluded rows; the learner may confuse excluded-by-frame rows with unparsed rows.
- Latest/delta price may be mistaken for store/frame-scoped analytics even though Cycle 03 makes it global per product.
- Mobile readiness may still be misread as a rewrite mandate rather than a boundary/separation concept.
