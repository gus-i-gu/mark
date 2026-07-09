# 14_MODEL_OVERVIEW.md

> Version: 0.3
> Status: Draft
> Persistence Class: Derived
> Knowledge Class: Design / Model Overview
> Authority: Design Chat
> Scope: Compact model ownership summary for Markei

---

# 1. Domain Entities

## Product

Product is the permanent inventory record.

Owns:

- product identity
- editable product metadata
- current inventory state
- cached product-level summaries

Relevant summary fields:

- `average_duration_days`
- `expected_next_purchase`
- `average_shelf_life_days`
- `expected_expiration_date`

Product must not own individual purchase history rows, History aggregate rows, Lists display rows, or History analytics rows.

## Purchase

Purchase is the immutable receipt/batch history record.

Owns:

- purchase date
- quantity
- unit
- unit price
- total price
- promotion flag
- product relationship
- store relationship
- optional `expiration_date`

Expiration belongs to Purchase because it describes a specific bought batch.

## Store

Store is the store identity/location record.

Owns:

- store ID
- store name
- city
- state
- nullable address

Store address editing is placed in Settings/store-management UI rather than RegisterPage.

---

# 2. Settings Model

Settings is application configuration, not product data.

Current persisted settings are key/value records in SQLite.

Accepted keys include:

- `history.week_boundary`
- `history.month_boundary_rule`
- `pages.order`

Ownership:

- SQLite stores setting records.
- Repository reads/writes settings values.
- ProductService interprets settings values.
- Settings page presents and edits settings values.

`pages.order` persistence exists, but MainWindow consumption remains deferred.

---

# 3. Derived Product View Model

Product View is not a persistent entity. It is a service-prepared read model rendered by `ProductDetailPanel`.

Derived Product View data includes:

- product identity line: name, brand, ID
- summary line: average price, average shelf-life, expected expiration
- store rows: store name, store ID, address, latest price, latest purchase date
- last purchase rows: date, price, quantity, expiration date

Average price remains derived from Purchase rows.

---

# 4. Derived Lists View Model

Lists View is not a persistent entity. It is a service-prepared read model rendered by `ListsPage`.

Lists is now the public inventory surface.

Internal Lists meanings:

```text
in-house  -> former Storage meaning
shortage  -> former Shortage meaning
to-buy    -> former Market meaning
```

Supported presentation views:

- all-products hybrid list with Status column;
- `in-house`;
- `shortage`;
- `to-buy`;
- `in-house + shortage`;
- `shortage + to-buy`.

Derived Lists row data includes:

- Product / product name
- Brand
- Quantity
- Price / latest price
- Δ Price / latest delta price
- Cycle / `average_duration_days`
- Next Purchase / `expected_next_purchase`
- Remaining days
- Status
- ID / product ID
- display labels for missing or nullable values

Summary ownership:

- ProductService owns product status classification.
- ProductService owns global latest price and delta price meaning for Lists.
- ProductService owns remaining-days and display-label assembly.
- ListsPage owns view selection and rendering only.
- Repository retrieves supporting rows but does not decide status or delta semantics.

Latest/delta price values are derived read-model values, not Product cached fields.

---

# 5. Derived History View Model

History View is not a persistent entity. It is a service-prepared read model rendered by HistoryPage.

Derived grouped History data includes:

- operational month sections
- week sections inside month sections
- ordered purchase rows inside week sections
- period labels
- period boundaries
- summaries / total rows

Summary ownership:

- Monetary total is derived from purchase `total_price`.
- Average unit price is a mean, not a sum.
- Quantities are aggregated by unit.
- Store totals belong to the History read model.

History total rows must not become Product cached fields.

---

# 6. Derived History Analytics View Model

History Analytics is not a persistent entity. It is a service-prepared read model rendered by an embedded read-only component inside HistoryPage.

Analytics frame:

```text
date range + optional store filter
```

Derived analytics summary data includes:

- frame start date
- frame end date
- optional store ID / store name
- parsed purchase count
- unparsed row count
- date/store excluded row count
- total spent
- average purchase timelapse for the selected frame

Derived analytics product rows include:

- product ID
- product name
- brand
- total spent in frame
- expenditure percentage
- purchase count
- product cycle from `average_duration_days`
- frame average timelapse
- cycle difference
- comparison label
- insufficient-data reason when needed

Summary ownership:

- ProductService owns frame interpretation.
- ProductService owns total spent, percentages, frame average timelapse, and cycle comparison.
- HistoryPage owns controls and rendering only.
- Repository retrieves supporting purchase/store rows.
- Schema/storage does not persist analytics cache fields.

---

# 7. Temporal Model

Markei currently distinguishes purchase rhythm, shelf-life rhythm, History display grouping, and analytics frame timelapse.

```text
Purchase rhythm
    average_duration_days
    expected_next_purchase

Shelf-life rhythm
    average_shelf_life_days
    expected_expiration_date

History grouping
    history.week_boundary
    history.month_boundary_rule

Analytics frame timelapse
    average interval between parsed purchases in selected date/store frame
```

Design invariant:

- Purchase rhythm answers when the user is expected to buy again.
- Shelf-life rhythm answers when the latest or typical bought batch expires.
- History grouping answers how purchases are bucketed for reading/reporting.
- Analytics frame timelapse answers how dense parsed purchases are inside a selected date/store frame.
- Lists classification remains purchase-rhythm based unless a future decision changes list semantics.
- History analytics product cycle comparison uses purchase rhythm, not shelf-life rhythm.

---

# 8. UI Model Boundary

`ProductDetailPanel` is a reusable read-only renderer.

It should receive prepared data and render placeholders for missing values.

It should not:

- query repositories;
- call SQL;
- calculate averages;
- infer shelf life;
- decide product status;
- own store address editing.

`RegisterPage` composes this panel but does not own its business meaning.

`ListsPage` is the public inventory renderer.

It should not:

- calculate product status;
- calculate latest price or delta price;
- infer remaining days;
- query repositories directly;
- own old Storage/Shortage/Market business logic.

`HistoryPage` is a renderer for grouped History and embedded History analytics read-model data.

It should not:

- group raw purchases into weeks/months;
- calculate total rows;
- interpret History settings;
- calculate analytics percentages;
- calculate average purchase timelapse;
- calculate product-cycle comparison;
- query repositories directly.

`SettingsPage` is the user-facing configuration and store-editing surface.

It should not:

- calculate History groupings;
- mutate HistoryPage directly;
- bypass service/repository persistence flow.

---

# 9. Mobile Readiness Overview

Cycle 03 improved mobile readiness through service/read-model contracts.

Prepared:

- Lists read model available outside the UI.
- History analytics read model available outside the UI.
- Business meanings are no longer tied to separate Storage/Shortage/Market pages.
- UI-specific behavior remains in PySide6 pages/widgets.

Not ready:

- mobile app implementation;
- API/backend rewrite;
- sync/auth design;
- typed contracts;
- dependency injection/service factory;
- date validation model;
- automated service tests;
- UI-label versus semantic-value separation.
