# Operational Record

## 2026-07-09 — Product View Codex Evidence Absorption

Source evidence:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`

### Operational Observation

- Product View was materialized as a read-only Register panel through a service-level read model.
- Optional purchase expiration date, shelf-life rhythm, store address persistence/display, and existing inventory classification were preserved as separate concerns.

### Validation Evidence

- Compile, migration, schema inspection, migrated-user-database reads, isolated registration workflow, and GUI startup checks passed.
- Full interactive UI validation remained pending at that point.

### Retained Risk

- Historical date-format drift and nullable expiration rendering required continued monitoring.

## 2026-07-09 — Cycle 02 History and Settings Knowledge Registration

Source evidence:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- Human validation after materialization.

### Operational Observation

- History and Settings were implemented from Main-approved stages.
- Settings became the store create/update and History-configuration surface.
- Settings persistence used SQLite `settings(key, value)` rows with idempotent defaults.
- MainWindow wired History and Settings into refresh flow.

### Validation Evidence

- Compile, non-destructive migration, settings-table inspection, History grouping, settings read/write, store create/update, startup, and human UI checks passed.
- First-Wednesday operational months and Wednesday week buckets were validated.

### Retained Limitations

- Store deletion, Register-based store management, active `pages.order`, arbitrary boundary configuration, and repair of unsupported date formats remained deferred.

## 2026-07-09 — Cycle 03 Lists and History Analytics Codex Evidence Absorption

Source evidence:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

### Operational Observation

- Public Storage/Shortage/Market tabs were consolidated into Lists internal views.
- Public tabs became Register / Lists / History / Settings.
- Lists gained a service-owned platform-neutral read model and shared row shape with latest/delta price.
- History gained embedded read-only analytics with service-owned filtering and aggregation.
- Repository/schema boundaries were preserved and no analytics cache/schema change was introduced.

### Validation Evidence

- Compile, existing-database smoke, Lists counts, price/status smoke, History grouping, analytics frames, imports, and offscreen startup passed.
- Store-filtered analytics safely returned an unknown average with fewer than two parsed purchases.

### Retained Risks

- Human interaction QA, Lists double-click across every view, receipt refresh, explicit invalid-date handling, same-day timelapse semantics, multi-store totals, old page cleanup, and automated PySide interaction coverage remained open.
- `pages.order` remained persisted but inert.

## 2026-07-09 — Cycle 04 Settings Stabilization Reconciliation

Source evidence:

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
- implementation commit `c9e9244a5187c32a2812641f05eac8856801a7d4`
- `app/core/services.py`
- `app/core/database.py`
- `app/database/seed.sql`
- `app/desktop/ui/pages/settings_page.py`

### Materialization Verified

- ProductService defines seven lowercase semantic weekday values.
- Canonical Settings keys were implemented:
  - `history.week_boundary`;
  - `history.month_boundary_mode`;
  - `history.month_boundary_weekday`;
  - `history.month_boundary_day`;
  - `time_reference.day_boundary_time`.
- Month modes are `first_weekday` and `day_of_month`; fixed month days are limited to 1-28.
- `save_history_settings()` performs strict pre-persistence validation.
- `validated_settings()` provides tolerant fallback for corrupt persisted values.
- Legacy `history.month_boundary_rule` maps to canonical month mode/weekday only when canonical month keys are absent.
- SettingsPage exposes seven week choices, two month modes, seven month-weekday choices, a 1-28 day spinbox, and masked `HH:MM` input.
- SettingsPage delegates validation and persistence to ProductService.
- Database migration inserts canonical defaults non-destructively.
- Seed data uses the canonical Cycle 04 settings keys.
- Store create/update code was preserved; no store deletion was added.
- `pages.order` remains persisted and inert; its visible editor was removed from the History settings save path.
- No mobile UI, backend, synchronization, external integration, or receipt-recognition work was introduced.

### Validation Evidence

- Compile passed with the explicit project interpreter.
- Temporary-database persistence passed.
- Invalid persisted settings fell back to defaults.
- Invalid `99:99` user-save input raised `ValueError`.
- Week boundary tests passed for Monday and Sunday.
- Month boundary tests passed for both modes.
- `operational_date()` passed with a `04:30` boundary.
- Legacy `first_friday` compatibility passed.
- Offscreen SettingsPage checks passed for control counts/ranges.
- Public tabs remained Register / Lists / History / Settings.
- Store create/update passed at service level.
- `git diff --check` produced only line-ending warnings.

### Validation Classification

Implemented and service/offscreen validated:

- settings defaults and persistence;
- strict user-save validation;
- tolerant persisted-value fallback;
- week/month grouping interpretation;
- operational-date helper;
- Settings controls and static public tabs;
- store create/update service regression.

Still requiring human interaction proof:

- Settings success/error feedback;
- masked time-input ergonomics;
- dependent-page refresh after save;
- store create/update through the actual Settings UI.

### Contradictions And Incomplete Reporting

- No source contradiction was found against D_OPS_STAGE or G_OPS_CODEX.
- D_OPS_STAGE requested manual Settings and store regression checks; G correctly reports those checks as skipped and replaced by offscreen/service evidence.
- Therefore Cycle 04 must not be described as fully human-validated.
- Current purchase rows remain date-only; `time_reference.day_boundary_time` does not materially alter existing History grouping.

### Operational Follow-Up

- Complete human Settings save-feedback QA.
- Complete human store create/update UI QA.
- Decide whether legacy `history.month_boundary_rule` should be migrated, removed, or left inert.
- Decide whether inert `pages.order` should be removed, migrated, or implemented.
- Consider time-of-day purchase support only in a later explicitly authorized cycle.
- Preserve all unresolved Cycle 03 UI, analytics, date-format, and transitional-page risks.

### Operational Classification

- Cycle 04 Settings Stabilization is implemented and validated at compile, service, persistence, compatibility, and offscreen-widget levels.
- Human interactive UI validation remains pending.
- Mobile readiness improved only through reusable service-owned semantic settings; mobile implementation readiness is not promoted.

## 2026-07-09 — Cycle 05 Sprint 01 Windows Desktop Installation Evidence Absorption

Source evidence:

- Human-provided accepted Cycle 05 Sprint 01 Codex evidence.
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

### Drift Observation

- The GitHub `G_OPS_CODEX.md`, `H_DDC_CODEX.md`, and `I_DSN_CODEX.md` available during absorption still described Cycle 04 rather than Cycle 05 Sprint 01.
- Current human direction explicitly classified the Sprint 01 evidence as verified.
- Operational memory was therefore reconciled from the accepted evidence while retaining the stale-report mismatch as drift requiring later Main/Codex correction.

### Implemented

- PyInstaller one-folder runtime.
- Schema-only, seed-free production initialization.
- External writable database under `%LOCALAPPDATA%\Markei`.
- Startup failure logging.
- Pinned PySide6 and PyInstaller dependencies.
- Inno Setup per-user installer configuration.

### Validated

- Frozen executable build and launch.
- Working-directory-independent schema discovery.
- Empty first-launch business state with six default settings.
- First receipt without a seeded store.
- Public page construction for Register, Lists, History, and Settings.
- Exclusion of seed, database, WAL/SHM, and sample records from the production runtime.

### Configured But Unvalidated

- Compiled installer artifact.
- Start Menu launch.
- Installed upgrade preservation.
- Uninstall preservation.
- Reinstall recovery.

### Blocked

- Inno Setup compilation and installed lifecycle validation because `ISCC.exe` was unavailable.

### Deferred

- SmartScreen and antivirus behavior.
- Production signing.
- Rollback.
- Automatic updating.
- Sprint 02 mobile preparation.

### Retained Risks

- Manual interactive UI walkthrough remains incomplete.
- Older Settings, store-editing, Lists interaction, analytics, date-format, legacy-setting, inert `pages.order`, and transitional-page risks remain open where not directly exercised by Sprint 01 evidence.

### Operational Classification

- The frozen application runtime is implemented and validated.
- The per-user installer is configured but unvalidated.
- Sprint 01 must not be described as a fully validated installed release until installer compilation and lifecycle testing pass.
