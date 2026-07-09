# Operational State

> Checkpoint refreshed from Cycle 03 Codex operational evidence.

## Current Implementation State

- Cycle 01 Product View remains implemented and operational.
- Register remains operational and remains purchase-entry-only.
- Settings remains the store-management surface.
- Store editing through Settings remains implemented and reflected across pages.
- Public desktop tabs are now:
  - Register
  - Lists
  - History
  - Settings
- Former public Storage/Shortage/Market pages are now internal Lists meanings:
  - Storage -> `in-house`
  - Shortage -> `shortage`
  - Market -> `to-buy`
- Lists page is implemented as the unified inventory page.
- Lists default view is the hybrid all-products view.
- Lists exposes internal views:
  - `all`
  - `in-house`
  - `shortage`
  - `to-buy`
  - `in-house + shortage`
  - `shortage + to-buy`
- Lists uses a shared 10-column row shape including Price and Δ Price.
- Lists uses global product latest price and delta price values; no store/frame-scoped price delta exists.
- Lists double-click fetches product by ID and routes through `MainWindow.edit_product(product)`.
- Compatibility helpers route old navigation names into Lists internal views.
- Product View read model remains service-driven and read-only.
- Inventory classification remains based on `expected_next_purchase`.
- Purchase rhythm remains separate from shelf-life rhythm:
  - `average_duration_days` / `expected_next_purchase`
  - `average_shelf_life_days` / `expected_expiration_date`
- History page remains implemented and functional with service-driven Month -> Week grouping.
- History analytics is now embedded in HistoryPage.
- Service-level History analytics read model is implemented.
- Analytics frame is date range plus optional store filter.
- Analytics average purchase timelapse is the average interval between parsed purchases in the selected frame, ordered by date.
- Analytics excludes unparsed rows and reports unparsed/excluded counts.
- No schema changes were introduced for Cycle 03 Lists or analytics.
- SQLite-backed settings persistence exists through `settings(key, value)`.
- Page sorting persistence exists through `pages.order`, but tab-reordering UI behavior remains deferred and is not consumed.

## Validation Evidence

- Cycle 03 Codex validation passed `python -m compileall app`.
- Database smoke opened existing user DB without destructive reset.
- Lists smoke returned counts for all required internal views:
  - `all=16`
  - `in-house=13`
  - `shortage=2`
  - `to-buy=1`
  - `in-house + shortage=15`
  - `shortage + to-buy=3`
- Status/price smoke returned status and global price variation for first five products.
- History read-model smoke returned `months=1`, `unparsed=0`.
- Analytics smoke returned parsed/unparsed/excluded counts, totals, frame average, and product rows for all-frame, July-frame, and July-plus-store frames.
- Store-filtered analytics frame with one parsed purchase returned unknown average timelapse rather than crashing.
- Import probes for `MainWindow`, `ListsPage`, and `HistoryPage` passed.
- Offscreen Qt startup probe returned top-level tabs `['Register', 'Lists', 'History', 'Settings']`.
- Qt emitted a font-directory warning during offscreen startup, but no traceback occurred.

## Remaining Operational Work

- Perform full manual UI QA for Register, Lists, History analytics, Settings, and Product View double-click/edit flow.
- Validate Lists double-click from every internal view.
- Validate receipt save refresh behavior for Lists and History.
- Add explicit invalid analytics date input handling.
- Review same-day average timelapse behavior for dense same-day purchase data.
- Decide later whether old Storage/Shortage/Market page files should be deleted or retained.
- Consider automated Qt smoke tests for core widgets without entering the full event loop.
- Continue monitoring unsupported historical date formats surfaced through `unparsed_rows`.
- Validate multi-store analytics totals with richer fixture data.
- Continue mobile-prep validation of platform-neutral service read models.

## Known Implementation Limitations

- Manual interactive UI validation remains incomplete after Cycle 03 Codex materialization.
- Invalid analytics date input currently behaves like an omitted date boundary.
- Same-day purchases can produce sub-day frame average timelapse values.
- Store deletion remains intentionally deferred.
- Page sorting is persisted but not applied to MainWindow tab ordering.
- Existing unsupported date formats are reported, not repaired.
- Store/frame-scoped price delta remains deferred.
- Old Storage/Shortage/Market page files remain present as transitional source files.
- Full automated PySide6 interaction coverage is not present.

## Active Operational Risks

- UI regression may still exist until real manual interaction checks are completed.
- Lists double-click/edit flow may hide row-index or selection bugs not covered by offscreen startup.
- Invalid analytics date input can mislead users because it silently broadens the frame.
- Same-day average timelapse may require clearer display or semantic adjustment.
- Multi-store analytics totals may need correction or clearer validation.
- Stale `pages.order` values still contain old public page names but remain inert.
- Retained old inventory page files may confuse future source inspection.
- Generated `__pycache__` and zip-file drift existed around Codex validation and should not be staged as project changes.
