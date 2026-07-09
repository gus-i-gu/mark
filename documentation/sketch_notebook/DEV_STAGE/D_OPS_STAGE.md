# DEV_STAGE/D_OPS_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Scope: Cycle 04 Settings boundary correction

---

# Cycle 04 Operational Materialization Stage

## 1. Purpose

This stage prepares Codex to implement the operational part of Cycle 04 from the current repository-backed A/B/C stage files.

The scope is Settings stabilization. It is not mobile implementation.

Codex may edit application source files required by this stage and must report execution evidence into `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`.

Codex must not edit methodology files or permanent domain memory during this pass.

## 2. Required Bootstrap and Source Inputs

Read first:

- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/00_PROJECT_STATE.md`
- `documentation/sketch_notebook/06_SESSION_SCHEME.md`

Then read:

- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`

Use `documentation/sketch_notebook/` as the active notebook root. Treat bare `sketch_notebook/` prompt references as path drift.

## 3. Main Synthesis Decisions

Accepted for materialization:

1. Settings remains the user-facing configuration and store-management surface.
2. SettingsPage edits values; it does not own business interpretation.
3. ProductService validates and interprets settings that affect History or Lists behavior.
4. Repository persists settings through the existing key/value settings flow.
5. Existing user data must be preserved.
6. History week boundary must support all seven weekdays.
7. History month boundary must be generalized beyond the current fixed first-Wednesday behavior.
8. Time reference is staged as an operational-day boundary preference.
9. Mobile work remains deferred.

Resolved key choice for Cycle 04:

- Canonical new key: `time_reference.day_boundary_time`
- Do not introduce `history.time_reference_time` as the canonical key.

## 4. Implementation Tasks

### 4.1 Settings defaults and validation

Create or centralize service-level validation/default behavior for these Settings values:

- `history.week_boundary`
- `history.month_boundary_mode`
- `history.month_boundary_weekday`
- `history.month_boundary_day`
- `time_reference.day_boundary_time`

Recommended defaults:

- `history.week_boundary = wednesday`
- `history.month_boundary_mode = first_weekday`
- `history.month_boundary_weekday = wednesday`
- `history.month_boundary_day = 1`
- `time_reference.day_boundary_time = 00:00`

Allowed values:

- weekday fields: monday through sunday, stored as lowercase semantic values;
- month mode: `first_weekday` or `day_of_month`;
- month day: integer from 1 to 28;
- time reference: normalized 24-hour `HH:MM`.

Repository should remain low-level persistence. ProductService should own validation and interpretation.

### 4.2 SettingsPage controls

Update the current Settings page.

Required UI behavior:

- week boundary selector with seven weekdays;
- month boundary mode selector;
- month weekday selector used by `first_weekday` mode;
- month day selector or numeric input for day 1-28;
- time reference input for `HH:MM`;
- save/load behavior through service/repository flow;
- dependent pages refresh after save where refresh orchestration already exists;
- existing store create/update behavior preserved.

Keep the store editor compact where practical. Do not add store deletion in this pass.

### 4.3 History grouping consumption

Update ProductService History grouping behavior so persisted week/month settings affect grouped History.

Required behavior:

- `history.week_boundary` controls weekly bucket boundary.
- `history.month_boundary_mode = first_weekday` starts operational months at the first configured weekday of the month.
- `history.month_boundary_mode = day_of_month` starts operational months at the configured day of month, limited to 1-28.
- invalid persisted values fall back to defaults rather than breaking History.

### 4.4 Time reference handling

Implement `time_reference.day_boundary_time` as a persisted and validated setting.

Cycle 04 behavior limit:

- Provide a ProductService helper or equivalent internal function for deriving an operational date from a date or datetime and the configured boundary time.
- Apply it only where the current data model safely supports it.
- Do not change purchase rhythm, expected next purchase, Lists status, or depletion prediction in this pass unless existing code already uses reliable datetime values.
- If current purchases only store dates with no time of day, report that the setting is persisted and validated but has no material grouping effect yet.

### 4.5 Pages order

Do not activate `pages.order` in MainWindow during this pass.

Codex may hide or de-emphasize a stale page-order UI control if the change is small. Otherwise, leave it unchanged and report the risk.

## 5. Explicit Deferrals

Do not implement:

- mobile UI;
- server/shared backend;
- synchronization;
- store deletion;
- destructive database reset;
- permanent notebook domain updates;
- methodology edits;
- active MainWindow tab ordering from `pages.order`.

## 6. Validation Requirements

Run and report available validation. Minimum expected checks:

- compile all application files;
- non-destructive Settings persistence smoke;
- Settings page import/open smoke;
- History grouping smoke for changed week boundary;
- History grouping smoke for changed month boundary;
- invalid settings fallback smoke;
- manual Settings UI check;
- manual store create/update regression check;
- public tabs remain Register, Lists, History, Settings.

Report exact commands used and their results.

## 7. G_OPS_CODEX.md Report Shape

After materialization, write `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`.

Required sections:

1. Source stage files read.
2. Files changed.
3. Files created.
4. Files deleted.
5. Commands run.
6. Validation results.
7. Settings defaults/validation evidence.
8. Week boundary implementation evidence.
9. Month boundary implementation evidence.
10. Time reference implementation evidence.
11. Store editor regression evidence.
12. Pages-order handling evidence.
13. Instructions completed.
14. Instructions skipped.
15. Failures or blockers.
16. Unresolved operational risks.
17. Suggested follow-up.
