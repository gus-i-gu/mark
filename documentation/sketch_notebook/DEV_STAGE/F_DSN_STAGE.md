# Materialization Stage — Design

## 1. Scope

This stage gives Codex architectural guardrails for Cycle 03: Lists remodel, embedded History analytics, latest/delta price expansion, and mobile-readiness preparation.

It translates Design staging and Main synthesis into implementation boundaries. Permanent design domain files remain for later Design Chat absorption after Codex reports.

Codex must report design evidence into `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md` after materialization.

## 2. Source Inputs

Codex must read:

- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`

## 3. Accepted Design Decisions

- Cycle 03 extends the existing Desktop UI → ProductService → Repository → SQLite boundary.
- ProductService owns business meaning, read-model assembly, classification, analytics derivation, percentage calculation, cycle comparison, and list row assembly.
- Repository owns SQL retrieval, persistence support, settings access, and row mapping.
- UI pages/widgets own rendering, user events, layout, and passing selected controls/view keys to ProductService.
- UI must not own business calculations.
- ListsPage becomes the one public inventory/list tab.
- Former Storage/Shortage/Market meanings become internal Lists views.
- Old Storage/Shortage/Market page files are retained temporarily unless safe deletion is explicitly justified and reported.
- History analytics starts embedded in HistoryPage.
- Detachable analytics lifecycle is deferred.
- Latest price and delta price are global per product for Lists in Cycle 03.
- Product cycle for analytics means `average_duration_days`.
- Purchase rhythm and shelf-life rhythm remain separate.
- Register remains purchase-entry-only.
- Store management remains in Settings.
- `pages.order` remains persisted/inert if present but must not drive MainWindow tab ordering this cycle.
- Schema changes are avoided unless implementation discovers an unavoidable blocker.
- Mobile preparation means stable read-model/service boundaries, not mobile implementation.

## 4. Responsibility Map

### Schema / storage owns

- raw purchases
- products
- stores
- settings/config values
- relationships
- migration-visible persistence shape
- existing cached product summaries

Schema/storage should not receive new Cycle 03 analytics fields by default.

### Repository owns

- SQL retrieval
- persistence operations
- settings access
- row-to-model mapping
- optional supporting retrieval for purchase rows/date/store filters
- optional latest/previous purchase retrieval if needed

Repository must not define:

- Lists view semantics
- status classification
- analytics frame meaning
- percentage meaning
- average timelapse meaning
- cycle comparison meaning

### ProductService owns

- Lists read-model assembly
- product status classification
- remaining-days interpretation
- latest price / delta price meaning for Lists
- History analytics frame interpretation
- parsed-row inclusion/exclusion rules
- frame total spent
- product expenditure percentage
- frame average purchase timelapse
- product cycle comparison
- missing/insufficient-data semantic states
- platform-neutral read-model contracts

### ListsPage owns

- one public Lists tab
- internal view selection
- default all-products hybrid view
- view control rendering
- table rendering
- refresh events
- double-click event routing to MainWindow/product edit flow

ListsPage must not directly query Repository or duplicate ProductService calculations.

### HistoryPage / embedded analytics widget owns

- rendering date range controls
- rendering optional store selector
- passing frame controls to ProductService
- rendering analytics summary and rows
- rendering empty/insufficient-data states

History UI must not calculate percentages, timelapses, or cycle comparisons.

### MainWindow owns

- public tab mounting
- navigation helpers
- refresh orchestration
- edit-product routing

MainWindow should expose Register / Lists / History / Settings as public tabs in Cycle 03.

### Settings owns

- store create/update surface
- settings/configuration surfaces

Settings should not calculate History or Lists semantics.

### Register owns

- receipt/purchase entry
- loading selected product for edit

Register should not become a store-management surface.

## 5. Read Model Contract Guidance

Codex may implement with dictionaries, dataclasses, or existing project conventions. Names may vary, but meanings must remain clear.

### Lists read model

Preferred service surface:

```text
get_lists_view(view_key="all", reference_date=None)
```

Required view keys:

```text
all
in-house
shortage
to-buy
in-house + shortage
shortage + to-buy
```

Required Lists row meanings:

```text
product_id
product_name
brand
current_quantity
unit
latest_price
previous_price
delta_price
delta_price_percent or equivalent
average_duration_days
expected_next_purchase
remaining_days
status
status_label
price_label
delta_price_label
remaining_label
```

The UI may render labels directly, but semantic values should remain available where practical.

### History analytics read model

Preferred service surface:

```text
get_history_analytics_view(start_date=None, end_date=None, store_id=None)
```

Required view meanings:

```text
frame.start_date
frame.end_date
frame.store_id
frame.store_name or all-stores label
summary.total_spent
summary.parsed_purchase_count
summary.unparsed_or_excluded_count
summary.average_purchase_timelapse_days
summary.insufficient_data_reason
rows
unparsed_or_excluded_rows or equivalent diagnostics
```

Required analytics row meanings:

```text
product_id
product_name
brand
total_spent
expenditure_percentage
purchase_count
average_duration_days
frame_average_timelapse_days
cycle_difference_days
cycle_comparison  # faster / slower / equal / unknown
insufficient_data_reason
```

## 6. UI Architecture Guardrails

### ListsPage

- Use one public Lists tab.
- Default to all-products hybrid view.
- Support all required internal views.
- Use the same row shape for every internal view.
- Do not preserve Storage/Shortage/Market as independent public navigation surfaces.
- Retain old page files temporarily unless safe deletion is explicitly justified and reported.
- Avoid direct copy/paste growth from old table implementations if a simple shared renderer is feasible.

### History analytics

- Embed analytics in HistoryPage.
- A helper widget may be created if it reduces HistoryPage size, but it must remain embedded.
- Do not implement detachable behavior.
- Keep existing grouped History rendering intact.
- Keep analytics read-only.

### MainWindow

- Public tabs for Cycle 03: Register, Lists, History, Settings.
- Do not consume `pages.order`.
- Preserve compatibility helpers by routing old open methods to Lists internal views.
- Preserve product edit flow.

## 7. Persistence / Schema Position

No schema change is expected for Cycle 03.

Do not add persisted fields for:

```text
latest_price
delta_price
expenditure_percentage
frame_average_timelapse_days
cycle_comparison
history analytics cache
```

Use existing raw purchases, products, stores, settings, and cached product summaries.

If Codex finds an unavoidable schema blocker, it must:

1. keep the migration idempotent;
2. preserve existing user data;
3. explain why read-time derivation was insufficient;
4. report the design consequence in `I_DSN_CODEX.md`.

## 8. Mobile Preparation Boundary

Prepare now:

- stable ProductService methods
- platform-neutral read-model values
- shared list row semantics
- service-owned analytics semantics
- reduced duplication across former list pages
- UI independence from calculation logic
- repository/service boundary preservation

Defer:

- Android/mobile implementation
- API/backend rewrite
- authentication/account model
- cloud sync
- mobile database synchronization
- replacing PySide6
- mobile-specific UI framework choices

## 9. Boundary Drift Risks Codex Must Watch

Report any drift in `I_DSN_CODEX.md`.

High-risk drift:

- ListsPage recalculates product status or price delta.
- HistoryAnalyticsWidget calculates percentages/timelapses/comparisons.
- Repository becomes owner of frame semantics or product cycle comparison.
- Product model absorbs frame-dependent analytics fields.
- MainWindow activates stale `pages.order` values.
- Register gains store-management controls.
- Old Storage/Shortage/Market pages remain public navigation surfaces.
- Mobile preparation expands into mobile rewrite.
- Schema starts caching analytics without a blocker.

## 10. I_DSN_CODEX.md Report Shape

After materialization, write:

`documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Keep the report compact and evidence-oriented.

Required sections:

1. Source stage files read
2. Architectural decisions materialized
3. Files changed or created for design reasons
4. Responsibility boundaries preserved
5. Boundary drift, if any
6. ListsPage architecture evidence
7. Lists read-model evidence
8. MainWindow navigation/remodel evidence
9. Latest/delta price boundary evidence
10. History analytics read-model evidence
11. Embedded History analytics UI evidence
12. Persistence/schema decision evidence
13. Mobile-readiness boundary evidence
14. Deferred design items
15. Open design questions
16. Suggested Design Chat follow-up
