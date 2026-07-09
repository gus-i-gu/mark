# Design Stage — Cycle 03 Coordinated Staging

## 1. Methodology Recovery

`documentation/sketch_notebook/INDEX.md` was read first.

The current INDEX route defines the methodology boot order as:

```text
INDEX
↓
METHOD_FOUNDATIONS
↓
FLUX
↓
PROMOTION_RULES
↓
CHAT_PROTOCOL
```

The Design Chat loaded the boot route in that order:

1. `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
2. `documentation/sketch_notebook/methodology/FLUX.md`
3. `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
4. `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`

`CHAT_BEHAVIOUR.md` and `METHOD_GLOSSARY.md` were not required for this stage because the Design Chat role, active-stage route, and terminology were sufficiently clear from the required boot files.

Active-stage authority is limited to:

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

No source code, methodology files, Main stage files, Codex report files, other functional stage files, permanent design memory files, created files, or renamed files are in scope for this active-staging materialization.

## 2. Recovered Design State

Design recovery followed hierarchical recovery.

The first recovery surface was:

```text
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

The checkpoint was sufficient to recover the stable Cycle 01 and Cycle 02 design state, but deeper design files were also read because Cycle 03 introduces coordinated responsibility boundaries for Lists, History analytics, and mobile preparation:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
```

Recovered architecture:

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
SQLite schema / storage
```

Current stable boundary rules:

- Desktop UI owns rendering, user events, page composition, and navigation hooks.
- ProductService owns business meaning, calculations, workflow coordination, settings/configuration interpretation, and UI-facing read-model assembly.
- Repository owns SQL retrieval, persistence operations, settings persistence access, and row-to-model mapping.
- Schema/storage owns persisted facts, relationships, migration-visible data shape, and application settings storage.
- Models describe domain entities and may hold cached summaries, but must not execute SQL or perform business orchestration.

Recovered Cycle 01 Product View state:

- Product View is a reusable read-only `ProductDetailPanel`.
- RegisterPage owns placement below the receipt form, not Product View calculations.
- ProductService owns Product View read-model assembly and shelf-life meaning.
- Repository owns SQL retrieval, persistence support, and row mapping.
- Product owns cached summaries: `average_duration_days`, `expected_next_purchase`, `average_shelf_life_days`, and `expected_expiration_date`.
- Purchase owns optional `expiration_date` as receipt/batch history.
- Store owns nullable `address`.
- Average price remains derived from purchases.
- Purchase rhythm and shelf-life rhythm remain separate.
- Storage / Shortage / Market classification remains purchase-rhythm based unless explicitly redesigned.

Recovered Cycle 02 History + Settings state:

- History uses a service-prepared read model.
- ProductService owns History period grouping and read-model assembly.
- ProductService owns first-Wednesday operational month grouping and Wednesday week grouping semantics.
- ProductService owns aggregate/total-row meaning.
- Repository retrieves purchase/store/settings data without deciding period semantics.
- HistoryPage renders grouped sections, purchase rows, summaries, and total rows.
- SettingsPage owns configuration surfaces.
- SettingsPage owns store editing placement.
- Store create/update belongs in Settings, not RegisterPage.
- SQLite key/value settings persistence is accepted.
- `history.week_boundary` and `history.month_boundary_rule` affect History grouping through service interpretation.
- `pages.order` persistence exists, but MainWindow page-order consumption remains deferred.

Cycle 03 should extend the same architecture rather than replacing it.

## 3. Main Decisions Accepted

Main has resolved the first coordination decisions for Cycle 03. These are accepted as design constraints:

1. History analytics starts embedded in HistoryPage.
2. Detachable History analytics behavior is deferred.
3. Analytics frame means date range plus optional store filter.
4. Average purchase timelapse means the average interval between all parsed purchases in the selected date/store frame, ordered by date.
5. Product cycle means `average_duration_days`, the existing purchase recurrence rhythm.
6. Cycle comparison means product cycle minus frame/store average timelapse.
7. Cycle comparison display is simple faster/slower/equal.
8. No configurable comparison tolerance is introduced in Cycle 03.
9. Latest price and delta price are global per product for Lists in Cycle 03.
10. Latest price and delta price are not scoped to selected store/frame in Cycle 03.
11. Lists default view is the hybrid all-products list with a Status column.
12. Lists must expose the internal views:
    - `in-house`
    - `shortage`
    - `to-buy`
    - `in-house + shortage`
    - `shortage + to-buy`
13. `pages.order` remains deferred.
14. Persisted tab ordering must not be activated this cycle.
15. Register remains purchase-entry-only.
16. Store management stays in Settings.
17. Old Storage/Shortage/Market page files should be retained temporarily unless safe deletion is explicitly justified.
18. Schema changes for analytics and Lists should be avoided unless an unavoidable implementation blocker is discovered.

Design direction to preserve:

- ProductService owns read-model assembly, business meaning, History grouping, analytics derivation, percentage calculation, cycle comparison, inventory classification, and list row assembly.
- Repository owns SQL retrieval, persistence support, settings access, and row mapping.
- UI pages/widgets render prepared data and own interaction/layout only.
- Mobile preparation means portable service/read-model contracts, not a mobile rewrite.

## 4. Responsibility Boundaries

### ListsPage view selection/layout

Owner: `ListsPage`.

`ListsPage` owns:

- the public Lists tab surface;
- default hybrid all-products view selection;
- switching between internal views;
- adjacent grouped view layout;
- table/widget composition;
- empty states;
- user interaction events;
- rendering service-prepared rows.

`ListsPage` must not own:

- product status classification;
- date/threshold comparison;
- latest price lookup;
- delta price calculation;
- purchase rhythm interpretation;
- direct SQL or Repository access.

### Product status classification

Owner: `ProductService`.

Product status classification remains purchase-rhythm based unless a later design cycle explicitly changes list semantics.

The service should classify rows into:

```text
in-house
shortage
to-buy
```

Classification should use the existing product purchase-rhythm semantics, including `expected_next_purchase`, threshold behavior, and the current/reference date as interpreted by the service.

### Shared Lists row read model

Owner: `ProductService`.

The shared Lists row read model should be assembled once and reused across:

- hybrid all-products view;
- `in-house` view;
- `shortage` view;
- `to-buy` view;
- `in-house + shortage` view;
- `shortage + to-buy` view.

Internal views should filter or group prepared rows by status, not recalculate status or price fields.

### Latest price / delta price

Owner: `ProductService` for meaning and row assembly.

Repository may retrieve latest and previous purchase rows or provide raw supporting query results. ProductService owns:

- latest price meaning;
- previous price selection meaning;
- delta price calculation;
- delta display direction;
- missing-data fallback behavior.

Cycle 03 scope defines latest price and delta price as global per product for Lists, not scoped by selected store/frame.

These values should be read-model fields, not new Product cached summaries.

### History analytics frame interpretation

Owner: `ProductService`.

The analytics frame is:

```text
date range + optional store filter
```

HistoryPage or the embedded analytics component may collect the frame from user controls, but ProductService interprets it.

Repository may accept date/store filter parameters for retrieval, but it must not decide frame semantics.

### Percentage expenditure

Owner: `ProductService`.

Percentage expenditure is derived within the selected analytics frame:

```text
product_total_spent / frame_total_spent
```

The service owns:

- numerator meaning;
- denominator meaning;
- zero-total fallback behavior;
- percentage row assembly.

The UI renders the percentage only.

### Frame/store average timelapse

Owner: `ProductService`.

Main-defined meaning:

```text
average interval between all parsed purchases in the selected date/store frame, ordered by date
```

The service owns:

- ordering by purchase date;
- exclusion of unparsed or invalid rows;
- interval calculation;
- average interval calculation;
- insufficient-data handling.

Repository retrieves purchase rows and may filter by date/store, but it does not calculate or define the timelapse meaning.

### Product cycle comparison

Owner: `ProductService`.

Product cycle means:

```text
average_duration_days
```

Cycle comparison means:

```text
product average_duration_days - frame/store average purchase timelapse
```

Cycle display is simple:

```text
faster
slower
equal
```

No configurable tolerance exists in Cycle 03.

The service owns missing-data states, such as no product cycle, no frame average, or insufficient parsed purchases.

### Mobile-readiness boundaries

Owner split:

- ProductService owns platform-neutral semantics and read-model contracts.
- Repository owns persistence isolation and raw data access.
- Desktop UI owns PySide6 rendering and interaction only.
- Domain models preserve platform-neutral meanings.
- Future mobile/API adapters may consume the same service/read-model contracts later.

Mobile preparation in Cycle 03 means contract discipline, not Android implementation, API rewrite, cloud sync, or a new backend.

## 5. Read Model Contracts

These are plain read-model shapes, not code requirements.

### Lists service method

Proposed service method:

```text
get_lists_view(reference_date=None, view_key="all")
```

Possible input meanings:

- `reference_date`: date used for remaining-days/status classification; defaults to current date if omitted.
- `view_key`: requested presentation filter.

Supported `view_key` values:

```text
all
in-house
shortage
to-buy
in-house+shortage
shortage+to-buy
```

The service may return all rows plus grouped subsets so the UI can switch views without recalculating.

### Lists view model shape

```text
ListsView
    reference_date
    default_view_key
    available_views
    rows
    groups
        in-house
        shortage
        to-buy
    combined_groups
        in-house+shortage
        shortage+to-buy
    empty_states
```

### Lists row shape

Required row fields:

```text
ListProductRow
    product_id              # ID
    product_name            # Product
    brand                   # Brand
    current_quantity        # Quantity
    latest_price            # Price
    delta_price             # Δ Price
    average_duration_days   # Cycle
    expected_next_purchase  # Next Purchase
    remaining_days          # Remaining
    status                  # Status: in-house / shortage / to-buy
```

Recommended supporting fields:

```text
    unit
    latest_purchase_date
    previous_price
    delta_price_direction   # up / down / equal / unavailable
    status_label
    remaining_label
    price_label
    delta_price_label
    missing_data_reason
```

The UI may render labels directly if provided, but the semantic values should remain available for sorting/filtering.

### History analytics service method

Proposed service method:

```text
get_history_analytics_view(start_date, end_date, store_id=None)
```

Input meanings:

- `start_date`: inclusive frame start.
- `end_date`: inclusive frame end.
- `store_id`: optional store filter; omitted or null means all stores.

### History analytics view model shape

```text
HistoryAnalyticsView
    frame
        start_date
        end_date
        store_id
        store_name
        label
    summary
        total_spent
        purchase_count
        parsed_purchase_count
        unparsed_or_excluded_count
        average_purchase_timelapse_days
        insufficient_data_reason
    rows
    unparsed_or_excluded_rows
```

### History analytics row shape

```text
HistoryAnalyticsProductRow
    product_id
    product_name
    brand
    total_spent
    expenditure_percentage
    purchase_count
    average_duration_days
    frame_average_timelapse_days
    cycle_difference_days
    cycle_comparison        # faster / slower / equal / unavailable
    insufficient_data_reason
```

### Unparsed / excluded rows shape

If needed, unparsed or excluded rows should be surfaced as diagnostic read-model data, not silently hidden:

```text
ExcludedAnalyticsRow
    purchase_id
    product_id
    product_name
    purchase_date
    store_id
    reason
```

Possible reasons:

```text
missing_purchase_date
outside_frame
store_filter_mismatch
missing_total_price
invalid_total_price
insufficient_interval_data
```

This protects analytics interpretation from silent data loss.

## 6. UI Architecture

### ListsPage public tab

Cycle 03 should replace the public Storage, Shortage, and Market navigation surfaces with one public Lists tab.

`ListsPage` is the public page. It should host internal views:

```text
all
in-house
shortage
to-buy
in-house + shortage
shortage + to-buy
```

Default view:

```text
all-products hybrid list with Status column
```

The hybrid view should use the same service-prepared `ListProductRow` shape as every internal view.

### Old page files

Old Storage/Shortage/Market page files should be retained temporarily unless safe deletion is explicitly justified.

During transition, they may be:

- left unused;
- wrapped by ListsPage;
- converted into internal renderer components;
- kept as compatibility references while public navigation moves to ListsPage.

They should not remain independent public navigation surfaces once ListsPage is active.

They should not continue to own separate business logic.

### History analytics component

History analytics starts embedded in HistoryPage.

Recommended structure:

```text
HistoryPage
    grouped History read model rendering
    embedded HistoryAnalyticsWidget
```

`HistoryAnalyticsWidget` owns:

- control rendering for date range and optional store filter;
- refresh events;
- table/summary rendering;
- empty/insufficient-data display.

`HistoryAnalyticsWidget` must not own:

- frame interpretation;
- percentage calculation;
- frame average timelapse calculation;
- product cycle comparison;
- SQL retrieval.

Detachable behavior is deferred and should not be introduced in Cycle 03.

### No UI-owned calculations

Cycle 03 must preserve the existing UI boundary:

- UI renders prepared data.
- UI emits user events.
- UI passes selected filters/view keys to ProductService.
- UI does not compute business values.

This applies to ListsPage, internal list views, HistoryPage, and the embedded History analytics component.

## 7. Persistence / Schema Position

### Raw purchase data

Raw persisted purchase data belongs to Purchase / SQLite persistence:

- purchase date;
- quantity;
- unit;
- unit price;
- total price;
- promotion flag;
- product relationship;
- store relationship;
- optional expiration date.

Repository retrieves this data and maps rows.

### Cached product summaries

Existing Product cached summaries remain:

- `average_duration_days`;
- `expected_next_purchase`;
- `average_shelf_life_days`;
- `expected_expiration_date`.

Cycle 03 uses `average_duration_days` as Product cycle for analytics comparison.

No new Product cached fields are required for latest price, delta price, expenditure percentage, or analytics comparison.

### Derived list rows

Derived Lists values include:

- status;
- latest price;
- previous price;
- delta price;
- delta price direction;
- remaining days;
- list grouping;
- display labels.

These are service-prepared read-model values.

They should not require schema changes in Cycle 03.

### Derived analytics metrics

Derived analytics values include:

- frame total spent;
- product total spent in frame;
- expenditure percentage;
- frame/store average purchase timelapse;
- product cycle comparison;
- cycle difference days;
- unparsed/excluded-row counts.

These are service-prepared analytics read-model values.

They should not be cached or persisted in Cycle 03.

### Display-only percentages/comparisons

Display-only values include:

- formatted percentages;
- faster/slower/equal labels;
- formatted price strings;
- formatted delta price strings;
- empty/insufficient-data messages.

They may be prepared by the service or lightly formatted by UI, but the semantic value must come from the service read model.

### Schema decision

Schema changes are not required for Cycle 03 unless implementation discovers an unavoidable blocker.

Avoid adding schema fields for:

```text
latest_price
delta_price
expenditure_percentage
frame_average_timelapse_days
cycle_comparison
```

Avoid introducing persisted analytics cache in this cycle.

Avoid activating `pages.order` consumption in MainWindow this cycle.

## 8. Mobile Preparation

Cycle 03 should prepare mobile portability by strengthening boundaries, not by starting a mobile rewrite.

Prepare now:

- stable service methods such as `get_lists_view(...)` and `get_history_analytics_view(...)`;
- platform-neutral read models composed of simple values, rows, groups, labels, and status keys;
- reduced duplication across former Storage/Shortage/Market views;
- Repository/Service boundary preservation;
- UI independence from classification, analytics, and price delta calculation;
- stable domain terms that can later be reused by another interface.

Recommended portability target:

```text
PySide6 UI
    ↓
ProductService read-model contracts
    ↓
Repository / SQLite
```

Future portability path:

```text
Mobile UI
    ↓
API or application-service adapter
    ↓
ProductService read-model contracts
    ↓
Repository / persistence
```

Remain deferred:

- Android/mobile implementation;
- API/backend rewrite;
- authentication/account model;
- cloud sync;
- detachable analytics lifecycle;
- persisted analytics cache;
- replacing PySide6 pages;
- activating persisted page/tab ordering;
- mobile-specific database synchronization.

## 9. Drift / Boundary Risks

### Risk: ListsPage duplicates former page business logic

Avoidance:

- ListsPage should request one service-prepared Lists read model.
- Internal views should render/filter prepared rows.
- Status classification must remain in ProductService.

### Risk: latest price and delta price are recalculated per view

Avoidance:

- Add latest/delta fields to the shared Lists row read model.
- Use the same row shape for all list view modes.
- Repository may retrieve latest/previous purchases, but ProductService owns delta meaning.

### Risk: Repository becomes analytics owner

Avoidance:

- Repository may filter and retrieve raw purchase rows.
- Repository may expose simple supporting retrieval helpers.
- ProductService must calculate or at least semantically own frame interpretation, average timelapse, percentages, and comparisons.

### Risk: HistoryAnalyticsWidget becomes calculation-heavy

Avoidance:

- Widget should pass date/store selections to ProductService.
- Widget should render returned summary and rows.
- Widget should not calculate expenditure percentages, timelapses, or faster/slower/equal comparison.

### Risk: Product model absorbs frame-dependent analytics

Avoidance:

- Keep frame-dependent analytics in read models.
- Do not add Product fields for analytics percentages, frame averages, or cycle comparison.

### Risk: `pages.order` accidentally becomes active

Avoidance:

- Do not modify MainWindow to consume persisted tab ordering in Cycle 03.
- Lists navigation changes should be explicit and static for this cycle.

### Risk: Register becomes store-management surface again

Avoidance:

- Keep Register purchase-entry-only.
- Keep store create/update in Settings.
- Lists and History analytics may display store information but should not become store-management surfaces.

### Risk: mobile preparation becomes rewrite pressure

Avoidance:

- Prepare read-model contracts only.
- Keep PySide6 stable.
- Defer API, mobile app, sync, and backend redesign.

## 10. GitHub Materialization Result

`documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md` was updated directly through the GitHub connector as the Design Chat active-stage file for Cycle 03 coordinated staging.

Commit message:

```text
Stage design plan for Cycle 03
```

Commit SHA should be recorded from the GitHub connector response after successful materialization.
