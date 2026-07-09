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

## 2026-07-09 — Cycle 03 Lists and History Analytics Codex Evidence Absorption

Source evidence:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

### Operational Observation

- Cycle 03 materialized the unified Lists page and embedded History analytics from Main-approved stage files.
- Public inventory tabs were remodeled from Storage / Shortage / Market into one Lists tab.
- Public tabs are now Register / Lists / History / Settings.
- Former Storage/Shortage/Market meanings are internal Lists views.
- Lists default view is the hybrid all-products view.
- Lists exposes `all`, `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy`.
- Lists uses a shared 10-column row shape including Price and Δ Price.
- Lists uses global latest price and delta price from product summary/service calculations.
- History analytics is embedded in HistoryPage with date inputs, optional store selector, apply button, summary label, and product analytics table.
- ProductService owns Lists read-model assembly and History analytics derivation.
- Repository/schema boundaries were preserved; no analytics cache or schema change was introduced.
- Register and Settings source files were not modified; Register remains purchase-entry-only and Settings remains store-management surface.
- `pages.order` remains inert for MainWindow tab ordering.

### Validated Operational Facts

- `app/core/services.py` was changed to add Lists and History analytics read models.
- `app/desktop/main_window.py` was changed to mount Register / Lists / History / Settings and preserve compatibility navigation helpers.
- `app/desktop/ui/pages/history_page.py` was changed to embed read-only analytics controls/table.
- `app/desktop/ui/pages/lists_page.py` was created as the unified Lists page.
- No files were deleted.
- Legacy service methods `get_storage_products()`, `get_shortage_products()`, and `get_market_products()` were preserved.
- Lists double-click fetches product by ID and calls `MainWindow.edit_product(product)`.
- History grouped Month -> Week rendering remains in `HistoryPage.load_history()`.
- Analytics reports unparsed rows separately from date/store excluded rows.
- Store-filtered analytics returns unknown frame average when fewer than two parsed purchases exist rather than crashing.

### Validation Evidence

- `python -m compileall app`: passed.
- `python -m app.core.database`: passed; existing DB opened without destructive reset.
- Lists smoke returned: `all=16`, `in-house=13`, `shortage=2`, `to-buy=1`, `in-house + shortage=15`, `shortage + to-buy=3`.
- Status/price smoke returned status and global price variation for first five products.
- History read-model smoke returned `months=1`, `unparsed=0`.
- Analytics all-frame smoke returned `parsed=19`, `unparsed=0`, `excluded=0`, `total=289.74`, `avg gap=0.4444444444444444`, `products=16`.
- Analytics July-frame smoke matched all-frame for current data.
- Analytics July plus store `2` smoke returned `parsed=1`, `unparsed=0`, `excluded=18`, `total=9.49`, `avg gap=None`, `products=1`.
- Import probes for `MainWindow`, `ListsPage`, and `HistoryPage` passed.
- Offscreen Qt startup probe returned top-level tabs `['Register', 'Lists', 'History', 'Settings']`.
- Qt emitted a font-directory warning during offscreen startup, but no traceback occurred.
- Reference search checked old page references in active files.

### Completed TODO Items

- Unified Lists page implemented.
- MainWindow public tab remodel implemented.
- Former Storage/Shortage/Market meanings moved into internal Lists views.
- Lists shared 10-column display implemented.
- Global latest/delta price display implemented for Lists.
- Service-level History analytics read model implemented.
- Embedded read-only History analytics UI implemented.
- No schema changes introduced for Cycle 03 analytics or Lists.

### Remaining TODO Items

- Perform full manual UI QA for Register, Lists, History analytics, Settings, and Product View.
- Validate Lists double-click/edit flow in every internal Lists view.
- Validate receipt save refreshes Lists and History through real UI interaction.
- Add explicit invalid analytics date input handling.
- Review same-day average timelapse semantics and display.
- Decide later whether old Storage/Shortage/Market page files should be removed.
- Consider automated Qt smoke tests that instantiate widgets without entering the full app event loop.
- Validate multi-store analytics totals with richer fixture data.
- Continue mobile-prep validation by confirming new service read models remain platform-neutral.

### Validation Gaps

- Manual interactive UI checks were not performed beyond offscreen startup/tab verification.
- `python -m app.main` was not left running because it enters the Qt event loop.
- Invalid analytics date input currently behaves like an omitted boundary because service parsing returns `None`.
- Same-day purchases can produce sub-day average timelapse values.
- Multi-store analytics totals need richer manual validation.

### Operational Risks

- UI interaction regressions may exist until manual QA covers real clicks, edits, receipt saves, and filters.
- Lists double-click behavior may hide row-index errors not caught by offscreen startup.
- Invalid analytics dates can silently broaden analytics frames.
- Same-day frame average timelapse may be mathematically valid but confusing operationally.
- Retained old page files can confuse future source inspection if not clearly treated as transitional.
- `pages.order` remains persisted with old public page concepts but is intentionally not consumed.
- Worktree/generated bytecode and zip-file drift were noted around Codex validation and should not be staged.

### Implementation Drift

- No blocking implementation drift found between Main Cycle 03 decisions and Codex evidence.
- Expected limitation: manual interactive UI QA remains incomplete.
- Expected limitation: invalid analytics date handling is not yet explicit.
- Expected limitation: same-day average timelapse requires review.
- Expected limitation: old Storage/Shortage/Market page files remain present as transitional files.

### Cross-Domain Awareness

- Didactic evidence confirms Cycle 03 introduced read-model consolidation, derived aggregates, date/store frame filtering, and platform-neutral service read-model concepts.
- Design evidence confirms boundaries were preserved: UI renders, ProductService owns semantics, Repository/schema were not expanded, and mobile implementation was not attempted.
- H/I reports do not contradict G_OPS_CODEX; they reinforce the same unresolved risks around invalid date input, same-day timelapse, and old page cleanup.
