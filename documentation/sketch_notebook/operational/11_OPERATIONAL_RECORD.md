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
