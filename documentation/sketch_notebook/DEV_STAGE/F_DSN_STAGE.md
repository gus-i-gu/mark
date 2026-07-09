# Materialization Stage — Design

## 1. Scope

This stage gives Codex architectural guardrails for Cycle 02: History UI page and Settings page. It translates the Design functional report and Main/human decisions into implementation boundaries. Permanent design domain files remain for later [D] absorption after Codex reports.

## 2. Source Inputs

- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- Main Chat synthesis for Cycle 02.

## 3. Accepted Design Decisions

- History uses a service-prepared read model.
- Repository retrieves purchase/time/store/settings data but does not decide week/month period semantics.
- Service owns History grouping, time bucketing, aggregate/total semantics, sorting interpretation, and read-model assembly.
- History page renders prepared grouped sections, purchase rows, and total/aggregate rows.
- Settings page owns the configuration surface.
- Store editing belongs in Settings for this milestone, not RegisterPage.
- Settings should host or contain focused store editing behavior without moving store persistence out of service/repository.
- Settings persistence should use SQLite with a simple key/value table for MVP unless an existing better project mechanism is found.
- Page sorting preference may be persisted, but full interactive page-sorting UI may be deferred if scope risk is high.
- MainWindow should eventually consume page sorting configuration, but this cycle may report partial support if full implementation is unsafe.
- Cycle 01 Product View boundaries must remain intact.

## 4. Responsibility Map

Schema/storage owns:

- purchases
- stores
- settings/config values
- relationships
- migration-visible persistence shape

Repository owns:

- purchase/store/settings SQL
- ordered raw History row retrieval
- store create/update persistence
- settings read/write persistence
- row/model mapping

Service owns:

- History read-model assembly
- operational month grouping
- weekly grouping
- first-Wednesday boundary interpretation
- Wednesday week-boundary interpretation
- total/aggregate row meaning
- page sorting setting interpretation
- store editing validation/orchestration

History page owns:

- rendering grouped History sections
- rendering purchase rows
- rendering total/aggregate rows
- triggering refresh through service-prepared data

Settings page owns:

- store editing surface
- time-reference configuration surface
- page sorting configuration surface if implemented
- saving configuration through service/repository flow

RegisterPage does not own store editing and should not gain store-management controls.

## 5. History Read Model Requirements

Codex should prefer an explicit History read model. Dataclasses or explicit dictionaries are acceptable if names preserve domain meaning.

Minimum model shape should represent:

- operational month sections
- week sections within month sections
- period label
- period start/end when available
- purchase rows ordered sequentially
- store identity on purchase rows
- monetary total for store/timeframe
- aggregate rows or section summaries

Total/aggregate rows should be service-prepared. They should not be calculated ad hoc in the History UI.

## 6. Time Boundary Design

Default rules:

- week starts Wednesday
- purchase on Wednesday belongs to the new week
- operational month starts at first Wednesday of calendar month
- purchases before the first Wednesday belong to previous operational month

These are business period rules, not visual formatting rules.

They belong in service-level grouping logic or a focused helper used by service.

## 7. Aggregate Design

History needs aggregate information, but not every value is a sum.

Design guidance:

- monetary total should derive from purchase `total_price`
- average price or average unit value should use mean/average if implemented
- quantities should be aggregated only when units are compatible or grouped by unit
- aggregate labels must make the meaning visible to users

Do not cache History totals on Product.
Do not treat History totals as raw purchase rows.

## 8. Settings Design

Settings should include:

- store creation/update for name, city, state, and address
- History time-reference configuration
- page sorting preference support if safe

Store deletion is deferred unless Codex can guarantee safe referential behavior and report it. Design preference for this cycle is create/update only.

Simple key/value settings table is acceptable as a flexible MVP persistence surface.

Examples of settings keys:

- `history.week_boundary`
- `history.month_boundary_rule`
- `pages.order`

Settings should change History behavior through service/config access, not by making Settings calculate History.

## 9. Path Normalization

Use current implementation paths under `app/desktop/`.

Primary UI targets:

- `app/desktop/main_window.py`
- `app/desktop/ui/pages/history_page.py`
- `app/desktop/ui/pages/settings_page.py`

Possible widget targets if useful:

- `app/desktop/ui/widgets/store_editor.py`
- `app/desktop/ui/widgets/history_table.py`
- `app/desktop/ui/widgets/history_section.py`
- `app/desktop/ui/widgets/settings_time_reference.py`
- `app/desktop/ui/widgets/page_sorting_editor.py`

Do not use `app/desktop/ui/main_window.py` unless repository inspection proves that path exists.

## 10. Design Evidence to Report

Codex should report in `I_DSN_CODEX.md` whether implementation preserved these boundaries:

- History page rendering versus service grouping.
- Repository retrieval versus service period semantics.
- Settings configuration surface versus History calculation.
- Store editing in Settings rather than RegisterPage.
- Total/aggregate rows as service read-model data.
- Page sorting preference support and any deferred UI work.
- Product View and ProductDetailPanel unaffected.
- Purchase rhythm and shelf-life rhythm unaffected.

## 11. I_DSN_CODEX.md Report Shape

After materialization, write `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md` with:

- Source stage files
- Architectural decisions materialized
- Files changed or created for design reasons
- Responsibility boundaries preserved
- Boundary drift, if any
- History read-model evidence
- Settings persistence/configuration evidence
- Store editing placement evidence
- Aggregate/total-row design evidence
- Deferred page sorting or store deletion decisions
- Open design questions
- Suggested [D] follow-up

Keep the report compact and evidence-oriented.
