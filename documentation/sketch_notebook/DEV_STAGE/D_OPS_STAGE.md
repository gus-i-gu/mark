# Materialization Stage — Operational

## 1. Scope

This stage gives Codex the operational implementation instructions for Cycle 02: History UI page and Settings page. It materializes source/schema/config/UI changes and validation evidence only. It does not promote permanent domain memory and does not edit methodology files.

## 2. Source Inputs

- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- Main Chat synthesis for Cycle 02.

## 3. Accepted Operational Decisions

- History shows purchases in chronological sequential order inside grouped sections.
- History grouping is nested Month -> Week.
- The default week boundary is Wednesday; a purchase on Wednesday starts a new operational week.
- The default operational month starts at the first Wednesday of the calendar month.
- Purchases before the first Wednesday belong to the previous operational month.
- Repository retrieves purchase, store, time, and settings data.
- Service owns time bucketing, History period construction, total/aggregate row semantics, and History read-model assembly.
- UI renders service-prepared History sections, rows, and aggregate rows.
- Settings owns store editing and configuration surfaces so RegisterPage is not polluted with store-management responsibilities.
- Store editing belongs in Settings for this milestone.
- Settings persistence should use SQLite and the existing idempotent migration path.
- Use a simple key/value settings table for MVP unless repository inspection shows an existing better settings mechanism.
- Page sorting persistence may be added, but full page sorting UI implementation may be deferred if it risks scope expansion.
- Product View, purchase rhythm, shelf-life rhythm, receipt registration, and inventory classification must not regress.

## 4. Implementation Targets

Inspect and update only as needed:

- `app/database/schema.sql`
- `app/database/seed.sql`
- `app/core/database.py`
- `app/core/config.py`
- `app/core/models.py`
- `app/core/contracts.py`
- `app/core/repository.py`
- `app/core/services.py`
- `app/desktop/main_window.py`
- `app/desktop/ui/pages/history_page.py`
- `app/desktop/ui/pages/settings_page.py`
- `app/desktop/ui/pages/register_page.py` only if refresh wiring requires it
- create focused widgets only if useful, for example store editor or history table components under the current `app/desktop/ui/widgets/` path.

Do not use older `app/desktop/ui/main_window.py` path unless repository inspection proves it exists.
Do not edit permanent domain folders in this pass.
Do not edit methodology files.
Do not create new Sketch Notebook files outside the named G/H/I report files.

## 5. Database and Migration Requirements

If persistent settings are not already present, add a settings table through schema and migration.

Preferred MVP shape:

```sql
settings (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL
)
```

Required default settings should support at least:

- history week boundary weekday = Wednesday
- history month boundary rule = first Wednesday
- page order value if page sorting persistence is implemented

Migration must be idempotent and preserve existing user data.
Use the existing PRAGMA-based pattern from Cycle 01.

Store address already exists; do not add duplicate store-address fields.

## 6. History Requirements

Implement or extend service behavior so History data is returned as a read model.

The read model should include:

- operational month sections
- week sections inside each operational month
- ordered purchase rows
- aggregate/summary rows or section totals
- store identity for rows and totals
- period labels and period boundaries

Repository may return ordered raw purchase/store rows, but must not own first-Wednesday or weekly-Wednesday business semantics.

## 7. Aggregation Requirements

Do not reduce the History aggregate model to only one generic `SUM` without preserving room for other aggregate meanings.

For this milestone:

- monetary total should use the stored purchase `total_price` when available.
- quantity totals may be grouped only when units are compatible; otherwise they should be omitted or displayed per unit group.
- average-like values should use mean/average where the meaning is average price or average unit value, not sum.
- Codex should choose a minimal clear aggregate set and report any skipped aggregate types.

The visible Total row must at minimum make clear which monetary total it represents for a store/timeframe.

## 8. Settings Requirements

Settings page should include:

- store editing area for store name, city, state, and address
- time-reference configuration for History grouping defaults
- page sorting configuration persistence if safe, with full interactive page-sorting UI allowed to be deferred

Store editing should support creating and updating stores.
Do not implement store deletion unless referential behavior is explicitly safe and reported.

Settings changes should refresh History immediately when practical; persisted settings must survive restart.

## 9. Date and Time Requirements

Use the configured project date format where possible.

History grouping must handle or report date-format drift. If existing seed/user data contains ISO-like dates while the configured date format is `%d/%m/%Y`, implement safe parsing or report records that cannot be parsed.

Validation must include known dates around Wednesday boundaries.

## 10. Validation Requirements

Run and report available commands, adapting to the local environment:

```bash
python -m compileall app
python -m app.core.database
python -m app.main
```

Also run or report schema inspection for settings migration, for example:

```sql
PRAGMA table_info(settings);
```

Validation should include service-level checks for:

- dates before the first Wednesday of a month
- dates on the first Wednesday
- dates after the first Wednesday
- Tuesday/Wednesday/Thursday week boundary behavior
- store/timeframe monetary totals
- average/mean aggregate behavior if implemented
- store create/update through service/repository
- settings persistence read/write
- History refresh after settings changes if implemented
- Product View and inventory logic not regressed

Manual UI validation to report:

- History tab opens and renders grouped sections.
- Settings tab opens and exposes store editing and time-reference configuration.
- Creating/updating a store works or skipped reason is reported.
- History totals are visible and understandable.
- App startup has no traceback.

## 11. Codex Report Requirement

After materialization, write `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md` with:

- Source stage files read
- Files changed
- Files created
- Files deleted
- Commands run
- Validation results
- Migration evidence
- History grouping evidence
- Settings persistence evidence
- Store editing evidence
- Aggregate/total semantics implemented
- Instructions completed
- Instructions skipped
- Failures/blockers
- Unresolved operational risks
- Suggested follow-up
