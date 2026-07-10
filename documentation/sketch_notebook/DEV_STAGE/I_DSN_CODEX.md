# Codex Report - Design Cycle 04 Settings Stabilization

## Source Stage Files Read

- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Architectural Decisions Materialized

- Settings remains the user-facing configuration and store-management surface.
- SettingsPage owns controls and save events.
- ProductService owns settings validation, fallback, and behavior-affecting interpretation.
- Repository remains generic key/value persistence.
- SQLite schema remains unchanged.
- `time_reference.day_boundary_time` is the canonical operational-day boundary key.
- `pages.order` remains inactive for MainWindow tab ordering.

## Files Changed Or Created For Design Reasons

- `app/core/services.py`: service-owned settings contract, validators, grouping interpretation, and operational-date helper.
- `app/desktop/ui/pages/settings_page.py`: presentation controls for semantic settings values.
- `app/core/database.py`: non-destructive defaults for canonical settings keys.
- `app/database/seed.sql`: fresh-database defaults for canonical settings keys.
- No new application files were created.

## Responsibility Boundaries Preserved

- SettingsPage renders and collects values.
- ProductService validates, normalizes, and interprets settings.
- Repository reads/writes setting rows only.
- SQLite stores persisted facts and key/value settings.
- HistoryPage renders service-prepared grouped History output.
- ListsPage was not changed and does not interpret time reference.
- MainWindow still owns static public tab mounting.

## Boundary Drift, If Any

- No direct SQL was added to UI.
- Repository was not given date or grouping semantics.
- HistoryPage did not gain bucket calculations.
- ListsPage did not gain time-reference behavior.
- MainWindow did not activate `pages.order`.
- Minor remaining drift: old persisted `history.month_boundary_rule` can still exist as legacy data.

## SettingsPage Boundary Evidence

- Weekday and month controls store lowercase semantic values as combo item data.
- The day-of-month field is a 1-28 spinbox.
- The day-boundary time field is a masked `HH:MM` input.
- SettingsPage delegates save validation/persistence to `ProductService.save_history_settings()`.
- Store create/update UI remains in Settings.

## ProductService Settings Interpretation Evidence

- `DEFAULT_SETTINGS` defines the service contract.
- `validate_history_settings_input()` rejects invalid UI-submitted values.
- `validated_settings()` provides safe fallback for invalid persisted values.
- `get_history_view()` consumes week/month settings for grouped History.
- `operational_date()` provides the future-ready operational-day boundary helper.

## Repository Persistence Boundary Evidence

- `Repository.get_settings()` and `Repository.set_setting()` remain generic.
- No Repository method decides weekdays, month modes, month days, or boundary times.

## History Grouping Boundary Evidence

- Weekly grouping uses `history.week_boundary`.
- Monthly grouping uses `history.month_boundary_mode`, `history.month_boundary_weekday`, and `history.month_boundary_day`.
- The grouping implementation remains inside ProductService.

## Time Reference Boundary Evidence

- `time_reference.day_boundary_time` is persisted and validated.
- The helper applies only to date/datetime interpretation.
- Date-only purchase rows are not reinterpreted in this pass, avoiding unsupported behavior changes.

## Persistence / Schema Decision Evidence

- No schema change was required.
- Defaults were added through seed and idempotent migration insertion.
- Existing user settings are not overwritten by migration.

## Mobile-Readiness Boundary Evidence

- Semantic settings values are independent of desktop labels.
- Validation and interpretation are reusable outside PySide6.
- No mobile UI, backend, sync, or platform decision was introduced.

## Deferred Design Items

- Mobile UI.
- Server/shared backend.
- Synchronization.
- Receipt recognition.
- Store deletion.
- Active `pages.order` tab ordering.
- Operational-date effects on Lists status, purchase rhythm, depletion prediction, or expected next purchase.
- Cleanup/migration of legacy `history.month_boundary_rule`.

## Open Design Questions

- Should future purchase records store time-of-day so `time_reference.day_boundary_time` can materially affect grouping?
- Should legacy settings be migrated forward or left inert after new keys are present?
- Should Settings eventually split into smaller internal sections if the page grows further?

## Suggested Design Chat Follow-Up

- Absorb Cycle 04 as evidence that Settings is a presentation boundary and ProductService is the settings interpretation boundary.
- Decide later whether legacy month-boundary settings need a formal migration or removal cycle.
