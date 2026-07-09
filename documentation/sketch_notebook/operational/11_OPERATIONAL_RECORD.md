# Operational Record

## 2026-07-09 — Product View Codex Evidence Absorption

Source evidence:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`

### Operational Observation

- Codex materialized Product View implementation from Main-approved stage files.
- Product View is now reported as a read-only lower panel in Register, implemented through a reusable widget.
- Register accepts optional expiration date input for purchases.
- Product View data is reported as a service-level read model, not direct UI database access.
- Existing inventory page classification remains based on `expected_next_purchase`.
- Store address persistence/display support was added, but store address editing was not added.

### Validated Implementation Fact

- Compile validation passed with `python -m compileall app`.
- Database initialization/migration command passed without destructive reset.
- PRAGMA inspection confirmed new columns on `purchases`, `products`, and `stores`.
- Product View service read passed on migrated user database.
- Isolated temp-`LOCALAPPDATA` registration workflow passed.
- Isolated workflow preserved purchase rhythm at 10 days and separately calculated shelf-life average at 10 days.
- `expected_next_purchase` and `expected_expiration_date` were both reported as `21/07/2026` in the test case because both rhythms were 10 days, not because the fields were merged.
- Average price was derived as `11.0` from purchases.
- `git diff --check` passed with line-ending normalization warnings only.
- GUI startup reached Qt event loop without import/startup traceback; processes were stopped afterward.

### Remaining TODO

- Perform manual desktop UI validation by double-clicking Storage, Shortage, and Market rows.
- Inspect Register lower Product View panel after navigation.
- Verify optional expiration dates display correctly in Last Purchases.
- Verify older records without expiration dates display safely.
- Decide later whether store address editing belongs in a store-management milestone.

### Validation Gap

- Full interactive UI validation was not completed in terminal session.
- GUI launch evidence proves startup/import viability, not user interaction correctness.
- Historical date-format drift remains untested.

### Operational Risk

- Mixed date formats in older data may affect shelf-life recalculation because calculation expects configured date format.
- Nullable expiration fields require placeholder-safe UI rendering.
- Store address can be stored/displayed but not edited through UI yet.

### Checkpoint Update

- Operational checkpoint refreshed to mark Product View as implemented by Codex, validated at compile/database/service level, and pending manual UI validation.

## 2026-07-09 — Cycle 02 History and Settings Knowledge Registration

Source evidence:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- Manual validation evidence supplied after Codex materialization.

### Operational Observation

- Cycle 02 materialized History and Settings from Main-approved stage files.
- History page was replaced from placeholder with grouped read-only History rendering.
- Settings page was replaced from placeholder with History configuration and store create/update UI.
- MainWindow now wires History and Settings pages into refresh flow.
- Settings persistence uses SQLite-backed `settings(key, value)` storage.
- Settings defaults are inserted idempotently and preserve existing user choices.
- Store editing is implemented through Settings, not Register.
- Register remains operational.
- Product View remains operational.

### Validated Operational Facts

- History page is implemented and functional.
- Settings page is implemented and functional.
- Store editing updates are reflected across pages.
- Register remains operational.
- Product View remains operational.
- Product View regression check returned expected Cycle 01 keys.
- Inventory regression check returned normal `product_status()` behavior.
- History grouping supports first-Wednesday operational months and Wednesday week buckets.
- History totals are service-prepared from stored purchase data.
- Settings persistence exists for `history.week_boundary`, `history.month_boundary_rule`, and `pages.order`.
- Page sorting persistence exists, but MainWindow does not yet consume it for tab order.

### Validation Evidence

- `python -m compileall app`: passed.
- `python -m app.core.database`: passed; existing user database opened/migrated without destructive reset.
- `PRAGMA table_info(settings)` returned `key`, `value`.
- Existing user DB contained default History/settings values.
- Existing user DB History service read returned one month section and zero unparsed purchase dates.
- Isolated boundary validation grouped `30/06/2026` into Operational June 2026.
- Isolated boundary validation grouped `01/07/2026` into Operational July 2026.
- Isolated boundary validation started a new Wednesday week on `08/07/2026`.
- Settings read/write survived SQLite-backed service readback.
- Store create/update succeeded through service/repository.
- `python -m app.main` launched Qt event loop without traceback; processes were stopped after startup.
- Manual validation confirmed History page, Settings page, Store editing reflection, Register, and Product View.

### Completed TODO Items

- Product View manual validation is no longer globally open as an unvalidated UI feature; manual evidence confirms Product View remains operational.
- Store address editing is no longer deferred as a general milestone; Settings now provides store create/update UI.
- Register operational regression was manually confirmed.
- History and Settings placeholder state is resolved.
- Settings persistence for implemented defaults is resolved.

### Remaining TODO Items

- Investigate store update through Register.
- Investigate multi-store History totals.
- Decide whether persisted `pages.order` should be consumed by MainWindow in a later cycle.
- Continue manual QA for History/Settings after further UI changes.
- Continue monitoring and testing unsupported historical date formats.

### Validation Gaps

- Multi-store History totals require investigation.
- Store update through Register requires investigation.
- Page sorting persistence exists, but UI behavior remains deferred.
- History configuration UI currently exposes only implemented defaults.
- Unsupported date formats are reported, not repaired.

### Known Implementation Limitations

- Store deletion was intentionally skipped.
- RegisterPage was not given store-management controls.
- MainWindow does not yet reorder tabs from `pages.order`.
- History configuration does not yet expose arbitrary boundary customization beyond implemented defaults.

### Operational Risks

- Store editing behavior may diverge between Settings and Register paths.
- Multi-store total rows may hide aggregation mistakes until tested with richer data.
- Date-format drift remains relevant for History bucketing.
- Persisted settings can create user expectations before all UI behavior consumes them.

### Implementation Drift

- No blocking implementation drift recorded.
- Expected limitation: `pages.order` persistence exists while tab-order behavior is deferred.
- Expected limitation: unsupported date formats are surfaced through `unparsed_rows` rather than repaired.
