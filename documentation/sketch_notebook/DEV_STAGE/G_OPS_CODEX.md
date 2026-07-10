# Codex Report - Operational Cycle 04 Settings Stabilization

## Source Stage Files Read

- `AGENTS.md`
- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
- `documentation/sketch_notebook/methodology/FLUX.md`
- `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
- `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`
- `documentation/sketch_notebook/00_PROJECT_STATE.md`
- `documentation/sketch_notebook/06_SESSION_SCHEME.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Files Changed

- `app/core/services.py`: added service-owned settings defaults, strict save validation, tolerant persisted fallback validation, week/month boundary interpretation, and `operational_date()`.
- `app/desktop/ui/pages/settings_page.py`: expanded Settings controls for week boundary, month mode, month weekday, month day, and day-boundary time; removed visible page-order editing from the save path.
- `app/core/database.py`: added non-destructive defaults for new canonical settings keys.
- `app/database/seed.sql`: updated fresh-database seed settings to the Cycle 04 keys.
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`: updated this report.
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`: updated didactic evidence report.
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`: updated design evidence report.

## Files Created

- None.

## Files Deleted

- None.

## Commands Run

- `python -m compileall app` using the Windows app launcher; passed, but launcher later emitted Python install-manager messages.
- `C:\Users\gusrm\AppData\Local\Python\bin\python.exe -m compileall app`
- Temporary-`LOCALAPPDATA` service smoke for settings persistence, invalid persisted fallback, strict invalid save rejection, week/month boundaries, and operational-date helper.
- Temporary-`LOCALAPPDATA` legacy month-boundary compatibility smoke.
- Temporary-`LOCALAPPDATA` offscreen Qt smoke for `SettingsPage` controls and public tabs.
- Temporary-`LOCALAPPDATA` store create/update service regression smoke.
- `git diff --check`
- `git restore` for generated `__pycache__` files created by validation.

## Validation Results

- Compile passed with the explicit project interpreter.
- Settings persistence smoke passed on a temporary database.
- Invalid persisted settings fell back to defaults.
- Invalid UI-style save for `99:99` time raised `ValueError`.
- Week boundary smoke passed for Monday and Sunday boundaries.
- Month boundary smoke passed for `first_weekday` and `day_of_month`.
- `operational_date()` smoke passed for a `04:30` day boundary.
- Legacy `history.month_boundary_rule = first_friday` mapped to `history.month_boundary_mode = first_weekday` and `history.month_boundary_weekday = friday` when canonical month keys were absent.
- Offscreen SettingsPage smoke passed: 7 week choices, 2 month modes, 7 month weekday choices, day spinbox range 1-28.
- Public tab smoke passed: `['Register', 'Lists', 'History', 'Settings']`.
- Store create/update service smoke passed on a temporary database.
- Qt emitted a local PySide font-directory warning during offscreen smoke; no traceback.
- `git diff --check` reported only line-ending warnings for edited files.

## Settings Defaults / Validation Evidence

- Defaults are centralized in `ProductService.DEFAULT_SETTINGS`.
- Strict user-save validation is in `ProductService.validate_history_settings_input()`.
- Persisted corrupt values are normalized by `ProductService.validated_settings()`.
- New canonical settings keys are persisted through `ProductService.save_history_settings()`.
- Repository remains generic key/value persistence.

## Week Boundary Implementation Evidence

- Weekday values are lowercase semantic strings from Monday through Sunday.
- `SettingsPage` exposes all seven choices.
- `ProductService.week_start()` consumes the validated `history.week_boundary`.

## Month Boundary Implementation Evidence

- `history.month_boundary_mode` supports `first_weekday` and `day_of_month`.
- `history.month_boundary_weekday` supports all seven weekday values.
- `history.month_boundary_day` is constrained to 1-28.
- `get_history_view()` consumes the normalized month settings when building History month sections.

## Time Reference Implementation Evidence

- `time_reference.day_boundary_time` is persisted and validated as `HH:MM`.
- `ProductService.operational_date()` derives an operational date from date/datetime inputs and the configured boundary.
- Current purchase records are date-only, so this setting has no material grouping effect on existing History rows in this pass.

## Store Editor Regression Evidence

- Store create/update service smoke passed.
- Settings store editor UI code was not structurally changed beyond sharing the expanded Settings page.
- Store deletion was not added.

## Pages-Order Handling Evidence

- `MainWindow` still mounts static public tabs: Register, Lists, History, Settings.
- `pages.order` remains persisted but inert.
- The visible Settings page-order field was removed from the History settings save path.

## Instructions Completed

- Settings defaults and validation.
- Seven-day week boundary selector.
- Month boundary mode, weekday, and day controls.
- Day-boundary time setting.
- Service-owned History week/month grouping interpretation.
- Non-destructive seed/migration defaults.
- Store create/update preserved.
- G/H/I evidence reports.

## Instructions Skipped

- Manual interactive Settings UI QA was not performed beyond offscreen widget instantiation.
- Manual store create/update through the actual UI was not performed; service-level regression was run.
- Day-boundary time was not applied to date-only purchase grouping because existing purchases do not contain reliable time-of-day data.

## Failures Or Blockers

- No implementation blocker found.
- The generic `python` command resolved to the Windows app launcher and lacked `PySide6`; validation was rerun with the explicit project interpreter.

## Unresolved Operational Risks

- Full human UI QA remains needed for Settings save feedback and store editing interaction.
- Existing old `history.month_boundary_rule` data is not deleted; it is treated as legacy/inert once new canonical keys are present.
- `pages.order` remains an inert persisted setting.

## Suggested Follow-Up

- Operational Chat should classify manual UI QA results after human testing.
- A later cleanup can decide whether to migrate or remove the legacy `history.month_boundary_rule` key.
