# 14_MODEL_OVERVIEW.md

> Version: 0.1
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

Product must not own individual purchase history rows.

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

Store address editing remains outside the Product View milestone.

---

# 2. Derived Product View Model

Product View is not a persistent entity. It is a service-prepared read model rendered by `ProductDetailPanel`.

Derived Product View data includes:

- product identity line: name, brand, ID
- summary line: average price, average shelf-life, expected expiration
- store rows: store name, store ID, address, latest price, latest purchase date
- last purchase rows: date, price, quantity, expiration date

Average price remains derived from Purchase rows.

---

# 3. Temporal Model

Markei currently distinguishes purchase rhythm from shelf-life rhythm.

```text
Purchase rhythm
    average_duration_days
    expected_next_purchase

Shelf-life rhythm
    average_shelf_life_days
    expected_expiration_date
```

Design invariant:

- Purchase rhythm answers when the user is expected to buy again.
- Shelf-life rhythm answers when the latest or typical bought batch expires.
- Storage / Shortage / Market classification remains purchase-rhythm based unless a future decision changes list semantics.

---

# 4. UI Model Boundary

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
