# Codex Report — Didactic Cycle 03

## Source Stage Files Read

- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Coding Concepts Exposed

- Raw data versus derived display/read-model values.
- Date/store filtering frame before analytics aggregation.
- Aggregation, totals, percentages, and comparative metrics.
- Baseline definition for frame average purchase timelapse.
- Status classification versus UI view filtering.
- Nullable derived values for missing price, cycle, or frame average data.
- Platform-neutral service read-model shapes.
- PySide6 composition for unified views and embedded analytics.

## Concept Candidates By Marker

- `&&&`: Percentage as Derived Aggregate; Temporal / Spatial Filtering Frame; Comparative Metric; Baseline Definition; Status Classification Versus UI Filtering; Mobile Readiness Without Rewrite.
- `&&%`: Platform-neutral read-model shape; Nullable derived display values; UI view state; Date/datetime boundary handling.
- `&%%`: History Analytics Read Model; Unified Lists Page With Internal Views; Product Status Classification Versus UI Filtering; Latest Value / Delta Calculation; Service Contract Stability; Product Cycle Versus Shelf-Life; Mobile readiness through service/read-model contracts.
- `%%%`: PySide6 widget composition for embedded analytics; PySide6 unified page view controls; SQLite read queries versus cached columns.

## Existing Concepts Reinforced

- Raw Data Versus Derived Data: purchase/product rows remain raw inputs; Lists rows and analytics rows are derived service read models.
- Aggregation and Totals: analytics calculates selected-frame total spent and product totals before percentages.
- Service-Owned Calculation Responsibility: ProductService owns status, latest/delta, frame totals, percentages, average timelapse, and cycle comparison.
- Date/Datetime Boundary Handling: service parses date boundaries and excludes rows outside the selected frame.
- PySide6 Widget Composition: Lists and embedded analytics render service-prepared values without direct SQL.

## Lists Read-Model Consolidation Evidence

- Former Storage/Shortage/Market public meanings are now one Lists service read model plus internal views.
- Hybrid all-products view returns every product with a Status field.
- All internal views use the same 10-column row shape.
- Status is represented by `in-house`, `shortage`, or `to-buy` plus display label.
- Price and delta price are supplied by ProductService from global Product summary fields.
- Lists UI does not call repository or recalculate status, remaining days, latest price, or delta price.

## History Analytics Pipeline Evidence

```text
raw history rows
→ parsed date/store frame
→ total and interval aggregates
→ percentage and cycle comparison metrics
→ ProductService read model
→ embedded History UI presentation
```

- Date/store frame selection is collected in HistoryPage controls.
- Frame semantics are interpreted by ProductService.
- Total spent is sum of stored `total_price` for parsed rows inside frame.
- Product percentage is product total divided by selected-frame total.
- Average purchase timelapse is average gap between parsed purchases ordered by date.
- Product cycle comparison uses `average_duration_days - frame_average_timelapse_days`.
- Unparsed rows are excluded and counted separately; date/store exclusions are reported separately.

## Latest / Delta Price Evidence

- Lists read model exposes latest price from `current_unit_price`.
- Delta fields come from `get_price_variation(product)`.
- Values are global per product and not scoped to History date/store filters.
- Missing previous price returns nullable delta values and display `—`.

## Product Cycle Versus Shelf-Life Evidence

- Analytics uses `average_duration_days` as product cycle.
- No shelf-life fields are used for History analytics comparison.
- Existing shelf-life fields were not modified.

## Service vs Repository vs UI Responsibility Evidence

- Repository still owns SQL retrieval and row mapping.
- ProductService owns read-model assembly and all business/analytics meanings.
- ListsPage owns view selection, table rendering, refresh, and double-click routing.
- HistoryPage owns date/store controls, summary/table rendering, and apply events.
- UI code does not define analytics percentages, average timelapse, or comparison labels.

## Mobile-Readiness Boundary Evidence

- New service methods return plain dictionaries/lists with primitive values and labels.
- Lists and analytics semantics are not tied to PySide6 widgets.
- No mobile UI, API rewrite, backend rewrite, auth, sync, or mobile database work was added.

## Concepts Deferred / Not Ready For Canon

- Detachable analytics widget lifecycle.
- Store/frame-scoped price delta.
- Configurable comparison tolerance.
- Active `pages.order` consumption.
- Mobile implementation architecture.
- API/backend rewrite.
- Persisted analytics cache.
- Physical deletion of old Storage/Shortage/Market page files.

## Didactic Risks Or Remaining Confusions

- Invalid date text currently falls back to an omitted boundary.
- Frame average timelapse can be less than one day when many same-day purchases exist; teaching should distinguish row interval average from daily shopping habit.
- Store-filtered analytics may show many excluded rows; Didactic Chat may need to explain filtered frame membership versus unparsed data.

## Suggested Didactic Chat Follow-Up

- Classify Cycle 03 read-model consolidation into the KANBAN concepts staged in `B_DIDACTIC.md`.
- Teach the difference between product unit price, product total spent, frame total spent, and product expenditure percentage.
