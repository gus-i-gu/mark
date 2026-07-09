# Didactic Stage — Cycle 03 Coordinated Staging

## 1. Methodology Recovery

`documentation/sketch_notebook/INDEX.md` was read first.

Methodology boot was then loaded according to the current INDEX route:

```text
INDEX
↓
METHOD_FOUNDATIONS
↓
FLUX
↓
PROMOTION_RULES
↓
CHAT_PROTOCOL
```

The loaded methodology confirms the following operating constraints for this stage:

- Didactic Chat observes the project as learning.
- Functional staging is non-canonical working material awaiting Main synthesis.
- Didactic Chat active-stage write authority is limited to `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`.
- Permanent didactic memory is not modified during this active-staging phase.
- Source files, methodology files, Main stage files, Codex report files, and other functional stage files are outside this task authority.

No consultation of `CHAT_BEHAVIOUR.md` or `METHOD_GLOSSARY.md` was required because the role perspective and methodology vocabulary were sufficiently defined by the boot route.

## 2. Recovered Didactic State

Didactic recovery began with the checkpoint:

```text
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

Main corrected the first-round Didactic primary concern: the live `08_CONCEPT_MAP.md` on `main` is not empty. The earlier recovery gap should therefore be treated as a snapshot/tooling mismatch, not as absent didactic memory.

The recovered concept map identifies the current didactic milestone as Cycle 02 — History + Settings. Its learning focus is the move from Product View learning into service-prepared History read models, time bucketing, aggregation, grouping versus sorting, durable configuration state, store editing, and SQLite-backed settings persistence.

Recovered stable state:

- No concept is fully Green yet.

Recovered active concepts:

- `&&&01` — Domain Model Field Semantics
- `&&&02` — Raw Data Versus Derived Data
- `&&&03` — Naming as Data Contract
- `&&&04` — Cached Summary Field
- `&&%01` — Optional Values and Nullable Fields
- `&&%02` — Dataclass Field Evolution
- `&%%02` — Product View Read Model
- `&%%03` — Repository Result Shape
- `&%%04` — Service-Owned Calculation Responsibility
- `%%%01` — SQLite Schema Evolution
- `%%%02` — SQLite PRAGMA
- `%%%03` — PySide6 Read-Only Widget Composition

Recovered new / unstable concepts:

- `&&&05` — Time Bucketing
- `&&&06` — Aggregation and Totals
- `&&&07` — Grouping Versus Sorting
- `&&&08` — Configuration State
- `&&%03` — Date/Datetime Boundary Handling
- `&%%05` — History Read Model
- `&%%06` — Settings-Owned Preferences
- `&%%07` — Store Editing Workflow
- `&%%08` — History Grouping Service Responsibility
- `%%%04` — SQLite Settings Persistence
- `%%%05` — PySide6 Editable Form Composition

Recovered Cycle 02 decisions relevant to Cycle 03:

- History totals are derived display aggregates, not cached summary fields unless future Design/Main synthesis chooses persistence.
- Settings owns preference editing and persistence.
- History service owns interpretation of Settings preferences.
- SQLite PRAGMA is reinforced but not yet Green.
- Simple Key/Value Table is not a standalone KANBAN concept in Cycle 02.

Recovered dependency spine:

```text
Domain Model Field Semantics
↓
Naming as Data Contract
↓
Raw Data Versus Derived Data
↓
Grouping Versus Sorting
↓
Time Bucketing
↓
Date/Datetime Boundary Handling
↓
Aggregation and Totals
↓
History Read Model
↓
Service-Owned Calculation Responsibility
↓
History Grouping Service Responsibility
↓
Configuration State
↓
Settings-Owned Preferences
↓
SQLite Settings Persistence
↓
SQLite PRAGMA
```

Cycle 03 should therefore be understood as a continuation of Cycle 02, not as a fresh didactic start. The new cycle extends History + Settings learning into read-model consolidation across History analytics, unified Lists views, latest/delta display fields, and mobile-readiness boundaries.

## 3. Main Decisions Accepted

Main’s Cycle 03 coordination decisions are accepted in learning terms as follows.

1. History analytics starts embedded in `HistoryPage`.

   Didactic meaning: embedded analytics should be taught as an extension of PySide6 page composition and History read-model display, not as a separate detachable-window lifecycle yet.

2. Analytics frame means date range plus optional store filter.

   Didactic meaning: the calculation frame must be taught before aggregates, percentages, or comparisons. The frame decides which raw purchase rows are included.

3. Average purchase timelapse means the average interval between all parsed purchases in the selected date/store frame, ordered by date.

   Didactic meaning: this resolves the baseline for comparative analytics. The baseline is frame-level purchase rhythm, not product-specific recurrence.

4. Product cycle means existing `average_duration_days`.

   Didactic meaning: the product cycle is an existing product recurrence rhythm, not a new shelf-life field.

5. Cycle comparison means product cycle minus frame/store average timelapse, with simple faster/slower/equal display.

   Didactic meaning: comparison is a derived metric created from two already-derived values. No configurable tolerance is part of Cycle 03.

6. Latest price and delta price are global per product for Lists in Cycle 03.

   Didactic meaning: latest/delta display fields are read-model values derived from product purchase history, not scoped by the selected History analytics frame.

7. Lists default view is the hybrid all-products list with a Status column.

   Didactic meaning: the default Lists view should teach status as a product classification displayed inside a unified list, not as separate page ownership.

8. Lists must expose internal views:

   - `in-house`
   - `shortage`
   - `to-buy`
   - `in-house + shortage`
   - `shortage + to-buy`

   Didactic meaning: internal views are UI filtering/grouping states over shared read-model data.

9. `pages.order` remains deferred.

   Didactic meaning: page-order persistence is not a Cycle 03 learning target.

10. Register remains purchase-entry-only. Store management stays in Settings.

    Didactic meaning: purchase entry, settings management, and analytical display remain separate responsibilities.

11. Old Storage/Shortage/Market page files should be retained temporarily unless safe deletion is explicitly justified.

    Didactic meaning: conceptual page consolidation does not automatically require immediate physical deletion.

12. Avoid schema changes for analytics and Lists unless an unavoidable implementation blocker is discovered.

    Didactic meaning: Cycle 03 should reinforce read-time derivation and service/read-model contracts before introducing persistence changes.

Cycle 03 framing accepted:

```text
Markei is entering a read-model consolidation cycle.
```

Core learning axis:

```text
raw data
→ filtered frame
→ aggregate
→ derived metric
→ read model
→ UI presentation
```

## 4. Concepts To Reinforce

### `&&&02` — Raw Data Versus Derived Data

Cycle 03 strongly reinforces the distinction between raw database facts and derived display meaning.

Raw data examples:

- purchase rows;
- product rows;
- store rows;
- entered price;
- purchase date;
- stored `average_duration_days` product recurrence rhythm.

Derived data examples:

- selected-frame totals;
- expenditure percentage;
- average purchase timelapse;
- cycle comparison result;
- latest price display;
- delta price display;
- Lists status labels;
- internal Lists filtered views.

This remains the central concept for the cycle.

### `&&&03` — Naming as Data Contract

Cycle 03 adds names that must not blur responsibilities:

- `latest_price`
- `delta_price`
- `average_purchase_timelapse`
- `average_duration_days`
- `cycle_comparison`
- `in-house`
- `shortage`
- `to-buy`
- `Status`

The didactic emphasis should be that naming is not cosmetic. Names decide what the UI, services, repositories, and future mobile boundary believe a value means.

### `&%%02` / `&%%05` — Read Models

Cycle 03 extends Product View and History read-model learning into a broader read-model consolidation layer.

History analytics needs a read model shaped for embedded analytical display.

Lists needs a read model shaped for hybrid all-products display and internal filtered views.

The read model should remain conceptually distinct from raw SQL rows and from database schema changes.

### `&%%03` — Repository Result Shape

Repository outputs must remain explicit enough for services to derive:

- chronological purchase intervals;
- product totals;
- latest price;
- previous comparable price;
- product status;
- list display rows.

Cycle 03 should reinforce that unclear repository result shapes cause confusion in services and UI.

### `&%%04` — Service-Owned Calculation Responsibility

Cycle 03 should preserve the principle that services own calculation meaning.

Services should own or prepare:

- analytics frame interpretation;
- aggregate totals;
- average purchase timelapse;
- product cycle comparison;
- latest price and delta price derivation;
- status classification;
- Lists read-model preparation.

UI should render and select views; it should not become the owner of business calculations.

### `&&&04` — Cached Summary Field

Cycle 03 should reinforce cached summary fields by contrast.

Analytics totals, percentages, latest price, delta price, and comparison values should be taught as read-time derived display/read-model values unless Main/Design later decide persistence is necessary.

This is especially important because Cycle 03 explicitly avoids schema changes unless blocked.

### `&&%01` — Optional Values and Nullable Fields

Cycle 03 may require nullable display behavior when:

- no previous price exists for delta calculation;
- a product lacks `average_duration_days`;
- a selected analytics frame has too few purchases to calculate an interval;
- optional store filter is not selected.

The teaching target is safe display of missing values without inventing fake data.

### `&&%03` — Date/Datetime Boundary Handling

The analytics frame depends on date ranges. Cycle 03 should reinforce careful handling of inclusive/exclusive boundaries, purchase ordering, empty frames, and frames with only one purchase.

### `&&&07` — Grouping Versus Sorting

Cycle 03 uses grouping/filtering in Lists and chronological sorting in analytics.

Teaching distinction:

```text
sorting = order of rows
grouping = membership under a category
filtering = which rows are included
```

### `&&&06` — Aggregation and Totals

History analytics directly extends Cycle 02 aggregation learning.

Cycle 03 adds second-level derived metrics:

```text
raw rows
→ totals / averages
→ percentages / comparisons
```

### `%%%03` / `%%%05` — PySide6 Widget Composition

History analytics starts embedded in `HistoryPage`, and Lists becomes a unified page with internal views. This reinforces PySide6 composition, page layout, view selectors, tables, and read-only display areas.

## 5. New Concept Candidates

### `&&&` Foundational CS Concepts

#### `&&&09` — Percentage as Derived Aggregate

A percentage is a derived aggregate calculated from a part and a whole.

Cycle 03 example:

```text
product expenditure in selected frame
÷
total expenditure in selected frame
×
100
```

Staging status: Yellow.

Reason: builds directly on `&&&02 Raw Data Versus Derived Data` and `&&&06 Aggregation and Totals`, but the user may still confuse raw price, product total, and percentage.

#### `&&&10` — Temporal / Spatial Filtering Frame

A filtering frame defines the subset of records included before calculation.

Cycle 03 frame:

```text
date range + optional store filter
```

Staging status: Yellow.

Reason: extends time bucketing and date/datetime boundary handling, but now adds optional spatial/store filtering.

#### `&&&11` — Comparative Metric

A comparative metric is a derived value whose meaning depends on comparing one measurement with a baseline.

Cycle 03 example:

```text
product cycle - frame average purchase timelapse
```

Display meaning:

```text
faster / slower / equal
```

Staging status: Yellow.

#### `&&&12` — Baseline Definition

A baseline is the reference value used to interpret a comparison.

Cycle 03 baseline:

```text
average interval between all parsed purchases in the selected date/store frame, ordered by date
```

Staging status: Yellow.

Reason: Main has resolved the baseline for Cycle 03, but it needs explicit teaching to avoid ambiguity.

#### `&&&13` — Status Classification Versus UI Filtering

Status classification assigns meaning to product state. UI filtering decides which classified records appear in a selected view.

Cycle 03 example:

```text
Status column = classification
Lists internal view = filtering/grouping state
```

Staging status: Yellow.

#### `&&&14` — Mobile Readiness Without Rewrite

Mobile readiness means preserving portable boundaries before choosing a mobile implementation path.

Cycle 03 teaching target:

```text
stable service contracts + platform-neutral read models + UI separation
```

Staging status: Red / Yellow.

Reason: concept is important but should not become a premature mobile architecture decision.

### `&&%` Python / Language Concepts

#### `&&%04` — Platform-Neutral Read-Model Shape

A Python read model can be represented by dataclasses, dictionaries, named tuples, or typed objects, but its conceptual shape should not depend on PySide6 widgets.

Cycle 03 example:

```text
ListProductRow
HistoryAnalyticsSummary
HistoryAnalyticsProductRow
```

These names are examples only, not implementation mandates.

Staging status: Yellow.

#### `&&%05` — Nullable Derived Display Values

Some derived values may not exist for a given row or frame.

Cycle 03 examples:

- no previous price means no delta price;
- too few purchases means no average interval;
- missing product recurrence means no cycle comparison.

Python may represent these absences as `None`, with UI placeholders handled separately.

Staging status: Yellow.

#### `&&%06` — UI View State

The selected internal Lists view is application/UI state, not a data owner.

Cycle 03 examples:

```text
all-products
in-house
shortage
to-buy
in-house + shortage
shortage + to-buy
```

Staging status: Yellow.

### `&%%` Markei Implementation Concepts

#### `&%%09` — History Analytics Read Model

The embedded History analytics widget should consume a service-prepared read model that distinguishes:

```text
raw purchase rows
filtered frame
aggregate totals
percentage metrics
comparative metrics
UI display values
```

Staging status: Yellow.

#### `&%%10` — Unified Lists Page With Internal Views

The former Storage/Shortage/Market pages conceptually merge into one Lists surface.

Default view:

```text
hybrid all-products list with Status column
```

Internal views:

```text
in-house
shortage
to-buy
in-house + shortage
shortage + to-buy
```

Staging status: Yellow.

#### `&%%11` — Latest Value / Delta Calculation

Latest price is the most recent collected price for a product. Delta price is the difference between the latest price and a previous comparable product price.

Cycle 03 scope:

```text
global per product for Lists
not scoped to History date/store frame
```

Staging status: Yellow.

#### `&%%12` — Service Contract Stability

Cycle 03 should teach stable service contracts as the agreement between UI and business/data logic.

The UI should ask services for meaningful read models rather than directly reconstructing SQL, status rules, analytics rules, or delta rules.

Staging status: Yellow.

#### `&%%13` — Product Cycle Versus Shelf-Life

Product cycle in Cycle 03 means existing `average_duration_days`, the product purchase recurrence rhythm.

It should not be confused with physical shelf-life or expiration.

Staging status: Yellow.

### `%%%` Dependency / Tool Concepts

#### `%%%06` — PySide6 Widget Composition for Embedded Analytics

History analytics starts embedded in `HistoryPage`, so the didactic focus should be page composition, embedded summary/display widgets, and read-only analytical presentation.

Staging status: Yellow.

#### `%%%07` — PySide6 Unified Page View Controls

Lists needs one page with internal view controls and a display table/list that refreshes from the selected view state.

Staging status: Yellow.

#### `%%%08` — SQLite Read Queries Versus Cached Columns

Cycle 03 should reinforce that analytics and Lists display values can be derived through read queries and service logic without immediate schema changes.

Staging status: Yellow.

#### `%%%09` — SQLite Aggregation for Analytics

History analytics may require SQL-level or service-level use of:

```text
SUM
COUNT
AVG
ORDER BY
WHERE date range
WHERE optional store
```

Staging status: Red / Yellow.

Reason: the concept extends existing SQLite learning but requires careful sequencing after aggregates and frames.

## 6. Concepts Not Ready For Canon

The following concepts should remain staged / unstable and should not be promoted into permanent didactic canon yet.

### Detachable Widget Lifecycle

Main deferred detachable behavior. Didactics should not teach window detachment, widget lifetime, or cross-window synchronization as Cycle 03 canon.

### Store/Frame-Scoped Price Delta

Cycle 03 latest price and delta price are global per product for Lists. Store/frame-scoped price delta is explicitly outside the current accepted scope.

### Configurable Comparison Tolerance

Cycle comparison uses simple faster/slower/equal display with no configurable tolerance. Tolerance design should remain deferred.

### Active Page-Order Persistence

`pages.order` remains deferred. Didactics should not treat page ordering or persisted navigation state as a Cycle 03 concept.

### Mobile Implementation Architecture

Mobile readiness is a boundary concept, not an architecture decision. Do not canonize Flutter, React Native, Qt mobile, BeeWare, Kivy, web rewrite, API server, cloud sync, or any other mobile path yet.

### Persisted Analytics Cache

Analytics values should remain read-time derived unless future Main/Design synthesis identifies a performance or workflow reason to cache them.

### Physical Deletion of Old Page Files

Old Storage/Shortage/Market page files should be retained temporarily unless safe deletion is explicitly justified. Conceptual consolidation does not itself teach physical deletion.

## 7. Teaching Order

Cycle 03 should use the following teaching sequence.

1. Raw rows versus derived values.

   Teach purchase/product/store rows separately from totals, percentages, comparisons, statuses, latest values, and UI display fields.

2. Date/store filtering frame.

   Teach that date range plus optional store filter determines which rows participate in analytics.

3. Aggregates.

   Teach sum, count, average, grouped total, and average interval before introducing percentages or comparisons.

4. Percentage from aggregate totals.

   Teach percentage as part divided by whole inside the selected frame.

5. Comparative metric and baseline.

   Teach product cycle compared against the frame average purchase timelapse. Emphasize that the baseline is now explicitly defined by Main.

6. Product cycle versus shelf-life.

   Teach `average_duration_days` as purchase recurrence rhythm, not physical expiration or shelf-life.

7. Unified Lists page as one UI surface with internal views.

   Teach Lists as one page with several view states over shared product read-model data.

8. Product status classification versus UI filtering.

   Teach Status as classification and internal views as filters/groupings.

9. Latest price and delta price as read-model fields.

   Teach these as global per-product display values for Lists, not database fields and not History-frame-scoped values.

10. Service contracts and mobile readiness as separation discipline.

    Teach that future mobile preparation begins by keeping services, read models, and business meaning separate from PySide6 widget details.

## 8. Didactic Risks

### Raw Price Versus Total Spent Versus Percentage

Risk: the learner may treat a product’s unit price, total product expenditure, and percentage of total spending as the same kind of value.

Mitigation:

```text
raw price
→ product total in frame
→ all-products total in frame
→ percentage
```

### Product Cycle Versus Shelf-Life

Risk: `average_duration_days` may be misunderstood as physical shelf-life.

Mitigation: teach product cycle as purchase recurrence rhythm. Shelf-life/expiration is a different concept and is not the Cycle 03 accepted meaning.

### Baseline Average Timelapse Ambiguity

Risk: average purchase timelapse could be confused with product-specific average, store-specific product rhythm, or category rhythm.

Mitigation: repeat the accepted Cycle 03 baseline:

```text
average interval between all parsed purchases in the selected date/store frame, ordered by date
```

### UI View Grouping Versus Persistence

Risk: the internal Lists views may be mistaken for separate stored lists or separate data owners.

Mitigation:

```text
database stores records
services classify and derive
UI filters/groups for display
```

### Derived Display Field Versus Cached Database Field

Risk: latest price, delta price, analytics percentages, and comparison results may be treated as new columns by default.

Mitigation: teach them first as read-model/display values. Persistence remains deferred unless implementation blockers appear.

### Mobile Preparation Versus Mobile Rewrite

Risk: mobile readiness may be misunderstood as immediate full-stack rewrite.

Mitigation: teach mobile readiness as separation discipline:

```text
stable service contracts
platform-neutral read models
UI layer separation
portable business meaning
```

### Embedded Analytics Hidden as “Just a Widget”

Risk: the History analytics widget may look like a UI-only task.

Mitigation: teach the analytics pipeline:

```text
raw rows
→ selected frame
→ aggregates
→ derived metrics
→ read model
→ embedded PySide6 display
```

## 9. GitHub Materialization Result

`documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md` updated through the GitHub connector.

Commit message:

```text
Stage didactic plan for Cycle 03
```

Commit SHA: pending connector response at time of staged content composition.
