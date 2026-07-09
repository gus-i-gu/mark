# Codex Report — Design Cycle 03

## Source Stage Files Read

- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Architectural Decisions Materialized

- Cycle 03 extends the existing Desktop UI -> ProductService -> Repository -> SQLite boundary.
- Public inventory navigation is now one Lists page.
- Former Storage/Shortage/Market meanings are internal Lists views.
- History analytics starts embedded in HistoryPage.
- ProductService owns Lists classification/read-model assembly and History analytics derivation.
- Repository and schema were not expanded for cached analytics fields.
- Register remains purchase-entry-only; Settings remains store-management surface.
- `pages.order` remains inert for MainWindow tab ordering.

## Files Changed Or Created For Design Reasons

- `app/core/services.py`: service-owned Lists and analytics read models.
- `app/desktop/ui/pages/lists_page.py`: new public Lists rendering surface.
- `app/desktop/main_window.py`: static public tab remodel and compatibility navigation.
- `app/desktop/ui/pages/history_page.py`: embedded analytics controls/table.
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`: operational evidence.
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`: didactic evidence.
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`: this design evidence.

## Responsibility Boundaries Preserved

- Schema/storage: unchanged; no analytics cache or list-specific persisted fields.
- Repository: unchanged; still retrieves raw/supporting rows and does not define analytics semantics.
- ProductService: owns status, list rows, latest/delta meaning, frame interpretation, totals, percentages, average timelapse, and cycle comparison.
- ListsPage: owns view selection, table rendering, refresh, and double-click routing.
- HistoryPage: owns controls/rendering and passes frame selections to ProductService.
- MainWindow: owns tab mounting, refresh orchestration, and compatibility navigation helpers.
- Register and Settings responsibilities were not expanded.

## Boundary Drift

- No direct SQL was added to UI.
- No schema changes were introduced.
- No mobile implementation or API rewrite was introduced.
- Minor risk: HistoryPage formats analytics summary/table labels after receiving semantic values; calculations remain service-owned.
- Minor risk: invalid date boundaries parse as `None`, making invalid text behave like no boundary.

## ListsPage Architecture Evidence

- `ListsPage` is the only new public inventory page.
- It exposes required internal views through a combo box.
- It renders one standardized 10-column table for all views.
- It calls only `ProductService.get_lists_view(view_key)` and `ProductService.get_product(product_id)`.
- Double-click delegates selected product editing to MainWindow.

## Lists Read-Model Evidence

- `get_lists_view(view_key="all")` accepts `all`, `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy`.
- `list_row_model(product)` assembles identity, brand, quantity, latest price, delta price, cycle, next purchase, remaining days, status, and display labels.
- Legacy service methods `get_storage_products()`, `get_shortage_products()`, and `get_market_products()` were preserved.

## MainWindow Navigation / Remodel Evidence

- Public tabs now instantiate and mount Register, Lists, History, Settings.
- Offscreen startup probe returned `['Register', 'Lists', 'History', 'Settings']`.
- `open_storage()` routes to Lists `in-house`.
- `open_shortage()` routes to Lists `shortage`.
- `open_market()` routes to Lists `to-buy`.
- `refresh_pages()` refreshes Lists and History.
- `pages.order` is not consumed.

## Latest / Delta Price Boundary Evidence

- Latest price is read from Product summary `current_unit_price`.
- Delta price is derived through service `get_price_variation(product)`.
- UI only renders returned labels and color direction.
- No store/frame scoped delta behavior was added.

## History Analytics Read-Model Evidence

- `get_history_analytics_view(start_date=None, end_date=None, store_id=None)` returns frame, parsed/unparsed/excluded counts, total spent, frame average timelapse, product rows, and diagnostics.
- Product rows include product ID/name/brand, total spent, expenditure percentage, purchase count, product cycle, frame average, cycle difference, comparison label, and insufficient-data reason.
- Frame average is unknown when fewer than two parsed purchases exist.

## Embedded History Analytics UI Evidence

- HistoryPage now contains embedded analytics controls under the existing grouped history tree.
- Controls: start date text, end date text, optional store selector, Apply button.
- Display: summary label plus read-only product analytics table.
- Existing Month -> Week History tree remains in the same page.
- No detachable window/widget lifecycle was added.

## Persistence / Schema Decision Evidence

- No database schema files were modified.
- No Product model fields were added for latest price, delta price, percentage, frame average, or cycle comparison.
- Analytics values are read-time service derivations.

## Mobile-Readiness Boundary Evidence

- New service methods expose platform-neutral dictionaries.
- UI-specific code is limited to PySide6 rendering and event handling.
- Business meanings are available outside desktop widgets for future adapters.
- No mobile UI/backend implementation was attempted.

## Deferred Design Items

- Detachable History analytics.
- Active `pages.order` tab ordering.
- Store editing through Register.
- Store deletion.
- Mobile implementation.
- API/backend rewrite.
- Cloud sync.
- Persisted analytics cache.
- Store/frame-scoped latest or delta price.
- Configurable comparison tolerance.
- Deletion of old Storage/Shortage/Market page files.

## Open Design Questions

- Should invalid analytics date input surface an explicit UI validation error instead of acting as an omitted boundary?
- Should same-day purchase intervals be handled specially in average timelapse display?
- Should old page files be retired in a later cleanup cycle once Lists has manual QA evidence?

## Suggested Design Chat Follow-Up

- Absorb Cycle 03 as evidence for unified read-model boundaries.
- Decide whether date input validation belongs in HistoryPage, ProductService, or a shared UI validation helper in a later cycle.
