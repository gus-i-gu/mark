# 14_MODEL_OVERVIEW.md

> Version: 0.2
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

Product must not own individual purchase history rows or History aggregate rows.

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

Store address editing is now placed in Settings/store-management UI rather than RegisterPage.

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

# 4. Derived History View Model

History View is not a persistent entity. It is a service-prepared read model rendered by HistoryPage.

Derived History data includes:

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

# 5. Temporal Model

Markei currently distinguishes purchase rhythm, shelf-life rhythm, and History display grouping.

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
```

Design invariant:

- Purchase rhythm answers when the user is expected to buy again.
- Shelf-life rhythm answers when the latest or typical bought batch expires.
- History grouping answers how purchases are bucketed for reading/reporting.
- Storage / Shortage / Market classification remains purchase-rhythm based unless a future decision changes list semantics.

---

# 6. UI Model Boundary

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

`HistoryPage` is a read-only renderer for grouped History read-model data.

It should not:

- group raw purchases into weeks/months;
- calculate total rows;
- interpret History settings;
- query repositories directly.

`SettingsPage` is the user-facing configuration and store-editing surface.

It should not:

- calculate History groupings;
- mutate HistoryPage directly;
- bypass service/repository persistence flow.
