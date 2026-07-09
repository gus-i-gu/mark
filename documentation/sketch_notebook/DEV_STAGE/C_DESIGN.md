# C_DESIGN.md

[D] Design Chat

## Bootstrap validation

The Sketch Notebook was partially sufficient to recover the previous project state. The methodology and INDEX clearly define the Design Chat role, the canonical notebook root, and the write boundary for this file. However, the current `C_DESIGN.md` was empty, and no permanent design documents were found through repository search, so there was no prior staged design report to continue from.

Repository inspection revealed architectural information not yet reflected in the notebook stage: the stores table already exists, purchases already own `store_id`, Product already carries current price and delta price as cached summary state, and Shortage/Market currently lag behind Storage in UI columns.

Notebook drift detected: mild documentation drift. The notebook routing is current, but the design folder appears empty or unindexed, while the implementation already contains domain decisions that should be captured by Main Chat before becoming permanent design memory.

---

## Recovered architectural state

The current source architecture remains layered:

```text
Desktop UI
↓
ProductService
↓
Repository
↓
SQLite
```

The model file explicitly states that models only describe domain entities and must not execute SQL, calculate business rules, or manipulate the database. The service layer coordinates repository operations, enforces business rules, registers receipts, maintains product lifecycle, recalculates Product summaries, and exposes read services to the UI. The repository owns SQL operations and row-to-model mapping.

The existing UI tab structure is:

```text
Register
Storage
Shortage
Market
History
Settings
```

There is currently no Stores page in `MainWindow`.

The current `HistoryPage` is only a placeholder label and does not yet expose purchase filtering, store navigation, or purchase table behavior.

---

## Current domain model

### Product

Product is the permanent inventory record.

It owns:

- editable product metadata;
- inventory state;
- cached analytical summary.

Relevant cached summary fields already present in the schema/model:

- `current_quantity`
- `current_unit_price`
- `previous_unit_price`
- `current_purchase_date`
- `previous_purchase_date`
- `average_daily_consumption`
- `average_duration_days`
- `expected_next_purchase`
- `price_delta`
- `price_delta_percent`

Design interpretation:

Product may expose current purchase-derived values as a summary of latest known state, but Product must not become the historical purchase ledger.

### Purchase

Purchase is the immutable purchase ledger.

It owns the historical facts of a receipt line:

- `product_id`
- `store_id`
- `purchase_date`
- `quantity`
- `unit`
- `unit_price`
- `total_price`
- `promotion`
- `notes`

Design interpretation:

Every receipt line creates a Purchase. Purchase remains the source of truth for historical price, quantity, date, and store relationship.

### Store

Store currently exists with:

- `id`
- `name`
- `city`
- `state`

Current milestone adds only:

- `address`

Design interpretation:

Store is a reference entity. It identifies where purchases happened. It should support navigation and filtering, not replace Purchase as the history owner.

---

## Stores responsibility

The Stores table should preserve the existing fields:

```text
id
name
city
state
```

and add only:

```text
address
```

`address` should be treated as optional descriptive store metadata. It belongs to Store because it describes the store itself, not a purchase event and not a product state.

Recommended field semantics:

```text
address TEXT
```

No product redesign should be attached to this field. No purchase redesign is required beyond ensuring the existing `store_id` relationship can still point to a Store row.

---

## Relationship between Products, Purchases and Stores

Canonical relationship for this milestone:

```text
Products
   ↓ product_id
Purchases
   ↓ store_id
Stores
```

More precisely:

```text
products.id        ← purchases.product_id
stores.id          ← purchases.store_id
```

Design rule:

`purchases.store_id` remains the owner of the Product/Purchase/Store relationship.

A Product may have a current associated store only as a cached summary when appropriate, derived from its latest Purchase. Such a field may be considered later, but it must never replace Purchases as the historical source.

For this milestone, do not add a Product store field unless Main Chat explicitly promotes it. The safer design is to keep Store history reachable through Purchases and defer Product-level current-store cache until there is a concrete UI need.

---

## Stores page responsibilities

The new Stores page should be a navigation hub for store-related purchase history.

It should:

1. list every registered store;
2. display primary store information:
   - name;
   - city;
   - state;
   - address;
   - internal id if useful for debugging/navigation;
3. allow the user to select a store;
4. navigate to History filtered by that `store_id`;
5. remain read-oriented for this milestone unless Main Chat later authorizes store creation/editing UI.

The Stores page should not:

- calculate Product summaries;
- duplicate History tables internally;
- become the owner of purchase history;
- edit Product or Purchase architecture;
- introduce weekly/monthly expense grouping yet unless that becomes the active History milestone.

---

## History navigation model

The navigation model should be:

```text
Stores page
↓ user selects store
MainWindow navigation helper
↓ passes store_id
History page
↓ calls service/repository history query filtered by store_id
Purchases displayed for that store
```

Required design capabilities:

- `MainWindow` should gain a navigation helper such as `open_history(...)`.
- `HistoryPage` should accept or expose a method to apply a `store_id` filter.
- `ProductService.get_history(...)` should eventually support `store_id` as an optional filter in addition to the existing `product_id` filter.
- `Repository.get_purchases(...)` should eventually support filtering by `store_id` without breaking the existing `product_id` behavior.

Preferred filter shape for later implementation:

```text
get_history(product_id: str | None = None, store_id: int | None = None)
get_purchases(product_id: str | None = None, store_id: int | None = None)
```

Design rule:

Filtering History by Store must filter Purchases, not Products. Products are current inventory summaries; History is a ledger view.

---

## UI consistency recommendations

Storage already displays Product summary pricing fields:

- `Price`, derived from `product.current_unit_price`;
- `Δ Price`, derived through `ProductService.get_price_variation(product)`.

Shortage and Market should expose the same Product summary fields with the same presentation rule.

Recommended shared Product summary table columns for Storage, Shortage and Market:

```text
Product
Brand
Quantity
Price
Δ Price
Cycle
Next Purchase
Remaining
Status
ID
```

This is UI parity only.

It should not trigger:

- new Product summary calculations;
- new purchase semantics;
- a product/purchase redesign;
- a new price table.

The existing Product summary state is already the correct source for current price and delta display.

---

## Implementation boundaries

Do not implement code in this Design Chat.

Do not redesign Products/Purchases yet.

Do not move `store_id` from Purchases to Products.

Do not make Product the source of historical Store data.

Do not introduce History weekly/monthly expense grouping in this milestone unless Main Chat promotes it as the next active design scope.

Do not edit permanent notebook files from this chat.

Do not edit application source files from this chat.

---

## Files expected to change

Likely Codex/application files for the eventual implementation:

```text
app/database/schema.sql
app/core/models.py
app/core/contracts.py
app/core/repository.py
app/core/services.py
app/desktop/main_window.py
app/desktop/ui/pages/stores_page.py
app/desktop/ui/pages/history_page.py
app/desktop/ui/pages/shortage_page.py
app/desktop/ui/pages/market_page.py
```

Possibly affected if imports/package exports exist elsewhere:

```text
app/desktop/ui/pages/__init__.py
app/core/database.py
app/database/seed.sql
```

Expected changes by file:

### app/database/schema.sql

- Add `address` to `stores`.
- Preserve `id`, `name`, `city`, `state`.
- Preserve `purchases.store_id` foreign key.

### app/core/models.py

- Add `address` to `Store`.
- Do not add Product historical store ownership.

### app/core/contracts.py

- Consider adding Store field contract or repository/service methods for stores/history filtering.
- Preserve Product calculated fields as current summary state.

### app/core/repository.py

- Map `stores.address` in `row_to_store`.
- Ensure `get_stores()` returns Store objects with address.
- Add or extend purchase filtering by `store_id`.

### app/core/services.py

- Expose store list service if UI should not call repository directly.
- Extend History read service to accept optional `store_id`.
- Keep Product summary recalculation focused on Product fields.

### app/desktop/main_window.py

- Import and instantiate `StoresPage`.
- Add Stores tab.
- Add navigation helper from Stores to History.
- Refresh Stores/History if needed.

### app/desktop/ui/pages/stores_page.py

- New page.
- List stores.
- Show name/city/state/address/id.
- Trigger History navigation filtered by selected `store_id`.

### app/desktop/ui/pages/history_page.py

- Replace placeholder with purchase-history display.
- Accept optional `store_id` filter.
- Display Purchase rows as historical facts.

### app/desktop/ui/pages/shortage_page.py

- Add `Price` and `Δ Price` columns matching Storage.
- Use `current_unit_price` and `get_price_variation(product)`.

### app/desktop/ui/pages/market_page.py

- Add `Price` and `Δ Price` columns matching Storage.
- Use `current_unit_price` and `get_price_variation(product)`.

---

## Design conclusion

The next milestone is additive and should remain narrow.

The store architecture is already conceptually present: Stores are reference entities, Purchases own the historical `store_id`, and Products expose current purchase-derived values only as cached summaries.

The main design work is to make this architecture visible in the UI:

```text
Stores page = store navigation hub
History page = purchase ledger filtered by store_id
Storage / Shortage / Market = Product summary views with pricing parity
```
