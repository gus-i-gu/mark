# Codex Report — Didactic Cycle 02

## Source Stage Files

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Coding Concepts Exposed

- Time bucketing by business boundaries.
- Grouping as a read-model structure distinct from sorting.
- Aggregate rows as derived data.
- Durable configuration state in SQLite.
- Store editing through service/repository orchestration.
- PySide6 editable forms and read-only tree rendering.

## Concept Candidates By Marker

- `&&&` Time Bucketing
- `&&&` Aggregation and Totals
- `&&&` Grouping Versus Sorting
- `&&&` Configuration State
- `&&&` Simple Key/Value Table
- `&&%` Date/Datetime Boundary Handling
- `&%%` History Read Model
- `&%%` Settings-Owned Preferences
- `&%%` Store Editing Workflow
- `&%%` History Grouping Service Responsibility
- `%%%` SQLite Settings Persistence
- `%%%` PySide6 Editable Form Composition

## Existing Cycle 01 Concepts Reused

- Raw Data Versus Derived Data: purchase rows are raw history; History sections/totals are derived.
- Naming as Data Contract: row keys use explicit meanings such as `purchase_date`, `total_price`, and `average_unit_price`.
- Repository Result Shape: repository returns explicit raw row facts for service interpretation.
- Service-Owned Calculation Responsibility: History grouping and totals are not calculated in UI.
- SQLite Schema Evolution and PRAGMA: settings migration follows the same idempotent migration path.
- PySide6 Widget Composition: History and Settings pages compose focused controls without moving business logic into widgets.

## Grouping Versus Sorting Evidence

- Purchases are sorted chronologically by parsed purchase date and ID.
- Grouping then assigns those sorted rows into operational month and week sections.
- Sorting order does not define the period membership.

## Time Bucketing Evidence

- First Wednesday defines operational month start.
- Purchases before the first Wednesday are assigned to the previous operational month.
- Wednesday starts the operational week.
- Service tests confirmed Tuesday/Wednesday/Thursday boundary behavior around `07/07/2026`, `08/07/2026`, and `09/07/2026`.

## Aggregation And Total-Row Evidence

- Monetary total is a sum of stored `total_price`.
- Average unit price is a mean over `unit_price`.
- Quantity totals are grouped by unit, not collapsed across incompatible units.
- Store totals are grouped by store label.

## Simple Key/Value Table Note

A simple key/value settings table stores each setting as a named key plus a text value. It is useful when settings are small, independent, and may grow over time. Example: `history.week_boundary = wednesday`. It avoids creating many columns before the settings model is stable. Its tradeoff is that values need parsing and validation in service code.

## Settings / Configuration State Evidence

- `settings.key` identifies the setting.
- `settings.value` stores the persisted text value.
- Default values are inserted without overwriting user choices.
- Settings changes affect later History interpretation through service reads.

## Service Vs Repository Vs UI Responsibility Evidence

- Repository persists and retrieves settings, stores, and joined purchase/store rows.
- Service interprets settings, date boundaries, grouping, and aggregate meaning.
- History UI renders the service read model.
- Settings UI exposes editable controls and delegates persistence to service.

## Didactic Risks Or Confusions Remaining

- Page sorting persistence exists, but page sorting behavior is not implemented; this distinction should be explicit in later teaching.
- Operational month names are based on the first-Wednesday start date, which differs from plain calendar-month grouping.

## Suggested [A] Follow-Up

- Consider KANBAN entries for Time Bucketing, Aggregation and Totals, and Configuration State.
- Consider a glossary derivative for simple key/value settings tables.
