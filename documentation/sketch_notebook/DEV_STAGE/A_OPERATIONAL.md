# A_OPERATIONAL.md

[O] Operational Chat

## Bootstrap Validation

- Sketch Notebook recovery: sufficient for procedural recovery, but not sufficient for implementation state. The notebook bootstrap route, functional chat authority, and canonical paths were recovered from `documentation/sketch_notebook/INDEX.md` and `documentation/sketch_notebook/methodology/FLUX.md`.
- Repository inspection: revealed implementation details not yet reflected in `A_OPERATIONAL.md`, because the operational stage file was empty before this update.
- Notebook drift detected: no canonical path drift was detected. `INDEX.md` and `FLUX.md` agree that the canonical root is `documentation/sketch_notebook/` and that Operational Chat writes only `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`.
- Operational folder recovery: no additional permanent operational file was found through repository code search during this session; the current operational state is therefore reconstructed from methodology + source inspection.

## Recovered Operational State

Current milestone concerns Stores, History navigation, and Product summary display consistency across Storage / Shortage / Market.

The implementation already contains:

- a `stores` table;
- a `Store` model;
- repository store read methods;
- a `purchases.store_id` relationship;
- product cached summary fields for current price and price delta;
- Storage UI display for current price and price delta;
- Shortage and Market pages that still omit current price and price delta;
- a placeholder History page with no table and no filtering behavior;
- no Stores page wired into `MainWindow`.

## Implementation Evidence

### Schema

Source: `app/database/schema.sql`

- `products` owns cached Product summary fields:
  - `current_unit_price`
  - `previous_unit_price`
  - `current_purchase_date`
  - `previous_purchase_date`
  - `average_daily_consumption`
  - `average_duration_days`
  - `expected_next_purchase`
  - `price_delta`
  - `price_delta_percent`
- `purchases` owns historical purchase facts and relationships:
  - `product_id TEXT NOT NULL`
  - `store_id INTEGER`
  - `purchase_date`
  - `quantity`
  - `unit_price`
  - `total_price`
- `purchases.product_id` references `products(id)`.
- `purchases.store_id` references `stores(id)`.
- `stores` currently has:
  - `id`
  - `name`
  - `city`
  - `state`
- `stores` does not yet have `address`.

Operational conclusion: add `address` to `stores`; do not move store relationship into Product. Purchases own the relationship to Stores.

### Models

Source: `app/core/models.py`

- `Store` currently contains:
  - `id`
  - `name`
  - `city`
  - `state`
- `Store` does not yet contain `address`.
- `Purchase` already contains `store_id`.
- `Product` already contains cached summary fields including current price and price delta.

Operational conclusion: update `Store` only for the new `address` field. No Product model field is required for store-based history.

### Contracts

Source: `app/core/contracts.py`

- `ProductContract` already separates editable fields from calculated fields.
- `PurchaseContract` includes `store_id`.
- `RepositoryContract.get_purchases(product_id=None)` only supports product filtering.
- `ServiceContract.get_history(...)` is not explicitly declared, but ProductService exposes it.
- No Store contract exists.

Operational conclusion: either minimally extend existing repository/service read surfaces without expanding contracts aggressively, or add only the smallest contract additions required for store listing and filtered history.

### Repository

Source: `app/core/repository.py`

- Repository imports `Store`.
- Store read methods exist:
  - `get_stores()`
  - `get_store(store_id)`
  - `exists_store(store_id)`
  - `count_stores()`
- `row_to_store()` maps only:
  - `id`
  - `name`
  - `city`
  - `state`
- `get_purchases(product_id=None)` supports only product-based filtering.

Operational conclusion: update row mapping for `address`; add store filter support to purchase history without disrupting existing product filter behavior.

### Service

Source: `app/core/services.py`

- `register_receipt(...)` accepts `store_id` and creates a `Purchase` with `store_id`.
- `recalculate_product(...)` recalculates Product cached summary from purchases.
- `price_delta` calculation is current unit price minus previous unit price.
- `get_history(product_id=None)` delegates to repository `get_purchases(product_id)`.
- `get_storage_products`, `get_shortage_products`, and `get_market_products` all return Product objects.
- No service method currently exposes stores directly.
- No service method currently filters history by `store_id`.

Operational conclusion: preserve price delta calculation; add read-only store listing and store-filtered history service path.

### Main Window

Source: `app/desktop/main_window.py`

- Current tabs:
  - Register
  - Storage
  - Shortage
  - Market
  - History
  - Settings
- There is no Stores tab.
- Navigation helpers exist for Register, Storage, Shortage, Market.
- No `open_history` helper exists.
- `refresh_pages()` refreshes Storage, Shortage, Market only.

Operational conclusion: add Stores page import, instantiate it, add Stores tab, and wire a helper that lets Stores open History filtered by store_id.

### Storage Page

Source: `app/desktop/ui/pages/storage_page.py`

- Storage uses 10 columns.
- Storage displays:
  - Product
  - Brand
  - Quantity
  - Price
  - Δ Price
  - Cycle
  - Next Purchase
  - Remaining
  - Status
  - ID
- Storage formats current price from `product.current_unit_price`.
- Storage formats delta using `service.get_price_variation(product)`.
- Storage has local `price_variation_color(...)`.

Operational conclusion: Storage already satisfies the current price / delta display requirement.

### Shortage Page

Source: `app/desktop/ui/pages/shortage_page.py`

- Shortage currently uses 8 columns.
- Shortage currently displays:
  - Product
  - Brand
  - Quantity
  - Cycle
  - Next Purchase
  - Remaining
  - Status
  - ID
- Shortage does not display Price or Δ Price.
- Shortage does not define `price_variation_color(...)`.
- Product ID is currently read from column 7 during edit navigation.

Operational conclusion: increase to 10 columns like Storage, insert Price and Δ Price after Quantity, and move ID lookup from column 7 to column 9.

### Market Page

Source: `app/desktop/ui/pages/market_page.py`

- Market currently mirrors Shortage’s 8-column structure.
- Market does not display Price or Δ Price.
- Market does not define `price_variation_color(...)`.
- Product ID is currently read from column 7 during edit navigation.

Operational conclusion: apply the same minimal UI patch as Shortage.

### History Page

Source: `app/desktop/ui/pages/history_page.py`

- History is currently only a placeholder widget with a `QLabel("History")`.
- No ProductService is used.
- No table exists.
- No purchase loading exists.
- No `store_id` filter exists.

Operational conclusion: History must become an actual read-only Purchase view before Stores can navigate to store-filtered purchase history.

### Register Page Extra Evidence

Source: `app/desktop/ui/pages/register_page.py`

- Register is currently the only writable page.
- It accepts `Store ID` through a raw `QLineEdit` defaulting to `1`.
- `store_id()` returns integer `1` when blank.
- `add_receipt()` passes `store_id=self.store_id()` to `ProductService.register_receipt(...)`.

Operational conclusion: Register is already capable of assigning a purchase to a store ID, but it is not yet user-friendly or tied to a Stores page. This milestone does not require changing Register unless Main later decides to replace raw Store ID with a dropdown.

## Affected Source Files

Must inspect / modify in materialization stage:

1. `app/database/schema.sql`
   - Add `address` to `stores` table while preserving `id`, `name`, `city`, `state`.

2. Existing database / migration path
   - If development database already exists, schema.sql alone will not alter it.
   - Need either a migration command/script or a documented reset strategy.

3. `app/core/models.py`
   - Add `address: Optional[str] = None` to `Store`.

4. `app/core/repository.py`
   - Update `row_to_store()` to map `address`.
   - Keep existing store read methods.
   - Add store-aware purchase history filtering.

5. `app/core/services.py`
   - Add `get_stores()` read service.
   - Extend `get_history(...)` to accept `store_id` without breaking product filtering.
   - Preserve `recalculate_product(...)` and `get_price_variation(...)` unless a real bug is found.

6. `app/core/contracts.py`
   - Optional/minimal update if contracts are being kept as canonical API documentation.
   - Add store listing / store-filtered history only if implementation changes would otherwise drift from contract.

7. `app/desktop/main_window.py`
   - Import and instantiate Stores page.
   - Add Stores tab.
   - Provide navigation from Stores to History filtered by store_id.
   - Consider refreshing Stores and History in `refresh_pages()` if both pages implement load methods.

8. `app/desktop/ui/pages/stores_page.py`
   - New page.
   - Read-only list of stores.
   - Double-click or button navigates to History filtered by selected store.

9. `app/desktop/ui/pages/history_page.py`
   - Replace placeholder with purchase table.
   - Add `load_purchases(store_id=None, product_id=None)` or equivalent.
   - Display enough columns to understand purchase history and store filtering.

10. `app/desktop/ui/pages/shortage_page.py`
    - Add Price and Δ Price columns and formatting.

11. `app/desktop/ui/pages/market_page.py`
    - Add Price and Δ Price columns and formatting.

12. Optional tests or smoke scripts if project has test structure.

## Dependency Graph

```text
Products
  owns product identity, editable metadata, inventory state, cached summary
  does NOT own store relationship

Purchases
  owns historical purchase facts
  owns product_id relationship to Products
  owns store_id relationship to Stores
  source of truth for product price history

Stores
  owns store identity and location metadata
  should contain id, name, city, state, address
  does NOT own purchases directly in schema; purchases reference stores

Product cached summary
  derived from Purchases
  current_unit_price, previous_unit_price, price_delta, expected_next_purchase
  should not be recalculated from Stores
```

Navigation dependency:

```text
StoresPage
  ↓ selected store_id
MainWindow.open_history_for_store(store_id)
  ↓
HistoryPage.load_purchases(store_id=store_id)
  ↓
ProductService.get_history(store_id=store_id)
  ↓
Repository.get_purchases(store_id=store_id)
  ↓
purchases WHERE store_id = ?
```

UI summary display dependency:

```text
StoragePage / ShortagePage / MarketPage
  ↓
ProductService.get_*_products()
  ↓
Product cached summary fields
  ↓
current_unit_price + get_price_variation(product)
```

## Minimal Patch Sequence

1. Schema
   - Add `address TEXT` to `CREATE TABLE stores` after `name` or after `state`.
   - Recommended order for readability:
     - `id`
     - `name`
     - `address`
     - `city`
     - `state`
   - Preserve existing fields exactly.

2. Migration / database compatibility
   - For existing SQLite DB, run:
     - `ALTER TABLE stores ADD COLUMN address TEXT;`
   - Only run if `address` does not already exist.
   - Do not recreate data unless the project intentionally resets dev DB.

3. Store model + mapper
   - Add `address` to `Store` dataclass.
   - Update `row_to_store()` with `address=row["address"]`.

4. Repository read API
   - Keep current `get_stores()` and `get_store()`.
   - Extend `get_purchases(...)` to support `store_id`.
   - Minimal safe signature candidate:
     - `get_purchases(product_id: str | None = None, store_id: int | None = None)`
   - Query behavior:
     - no filters: all purchases;
     - product only: purchases for product;
     - store only: purchases for store;
     - both: purchases for product at store.
   - Preserve ordering: `ORDER BY purchase_date DESC, id DESC`.

5. Service read API
   - Add `get_stores()` delegating to repository.
   - Extend `get_history(product_id=None, store_id=None)` and delegate both filters.
   - Leave Product summary recalculation untouched.

6. History page
   - Replace placeholder with a read-only `QTableWidget`.
   - Use `ProductService.get_history(store_id=...)`.
   - Add a method such as `load_purchases(store_id=None)`.
   - Store the active filter in `self.current_store_id` or pass each time.
   - Display at minimum:
     - purchase id
     - product id
     - store id
     - purchase date
     - quantity
     - unit
     - unit price
     - total price
     - promotion
     - notes

7. Stores page
   - Create `app/desktop/ui/pages/stores_page.py`.
   - Use `ProductService.get_stores()`.
   - Display at minimum:
     - id
     - name
     - address
     - city
     - state
   - On double-click or button, call a MainWindow navigation helper with selected `store_id`.

8. MainWindow wiring
   - Import `StoresPage`.
   - Instantiate `self.stores_page = StoresPage(self)`.
   - Add `Stores` tab before History or after Market.
   - Add `open_history()` and `open_history_for_store(store_id)` helpers.
   - `open_history_for_store` should call `self.history_page.load_purchases(store_id=store_id)` then switch to History tab.

9. Shortage page UI
   - Change column count from 8 to 10.
   - Add headers `Price`, `Δ Price` after `Quantity`.
   - Copy Storage’s current price rendering.
   - Copy or share Storage’s price delta rendering using `service.get_price_variation(product)`.
   - Adjust all subsequent column indices.
   - Change product ID lookup from column 7 to column 9.

10. Market page UI
    - Same as Shortage.

11. Optional cleanup after functionality
    - Avoid copy-pasting price display helpers into three pages long term; a shared table helper can come later.
    - Do not introduce abstraction in this milestone unless Main approves.

## Migration Considerations

- `schema.sql` affects new databases only if the app initializes schema from scratch.
- Existing `database/market.sqlite` will not gain `stores.address` automatically.
- Safe SQLite migration command:

```sql
ALTER TABLE stores ADD COLUMN address TEXT;
```

- Risk: running this twice causes `duplicate column name: address`.
- Recommended migration validation:

```sql
PRAGMA table_info(stores);
```

- Confirm `address` exists before running app-level row mapping that expects it.
- Because `address` is nullable, existing rows remain valid.
- No Product cached summary migration is required.
- No purchase recalculation is required for adding `Store.address`.

## Validation Strategy

Run after materialization:

```bash
python -m compileall app
```

Expected:

- no syntax errors;
- especially check indentation-sensitive pages copied from Storage/Shortage/Market.

Database schema check:

```bash
python - <<'PY'
from app.core.database import connect
conn = connect()
rows = conn.execute('PRAGMA table_info(stores)').fetchall()
print([row['name'] for row in rows])
conn.close()
PY
```

Expected:

```text
['id', 'name', 'address', 'city', 'state']
```

or the same fields in the chosen schema order.

Repository smoke check:

```bash
python - <<'PY'
from app.core.repository import Repository
repo = Repository()
print(repo.count_stores())
print(repo.get_stores())
repo.close()
PY
```

Expected:

- no `IndexError: No item with that key` from `row_to_store`;
- stores print as `Store(...)` objects.

History filter smoke check:

```bash
python - <<'PY'
from app.core.services import ProductService
service = ProductService()
print(service.get_history(store_id=1))
service.close()
PY
```

Expected:

- no TypeError from unexpected `store_id`;
- list of purchases filtered by store 1, or empty list.

UI smoke check:

```bash
python -m app
```

Expected:

- app opens;
- Stores tab appears;
- Stores table lists stores;
- selecting a store opens History filtered by that store;
- Storage still shows Price and Δ Price;
- Shortage shows Price and Δ Price;
- Market shows Price and Δ Price;
- double-click edit still opens Register for the correct product from Storage/Shortage/Market.

Manual UI regression checks:

1. Register a purchase with `Store ID = 1`.
2. Confirm purchase appears in History with store_id 1.
3. Open Stores.
4. Activate store 1.
5. Confirm History shows only purchases for store 1.
6. Confirm product current price and delta did not change unexpectedly.

## Implementation Risks

1. Existing DB schema drift
   - If code expects `address` but local SQLite DB lacks it, `row_to_store()` will fail.
   - Migration or DB reset must happen before UI smoke test.

2. Contract drift
   - Repository and service contracts currently do not describe store listing or store-filtered history.
   - If implementation changes but contracts remain unchanged, the architecture documentation becomes stale.

3. History is underbuilt
   - Stores navigation depends on History becoming a real table, not a placeholder.
   - This is more than a one-line tab addition.

4. Filter ambiguity
   - `get_purchases(product_id=None, store_id=None)` must preserve existing callers.
   - Avoid breaking current product history paths.

5. UI column index regressions
   - Adding Price and Δ Price to Shortage/Market shifts ID column from 7 to 9.
   - If edit handlers are not updated, double-click edit will read the wrong cell.

6. Price delta duplication
   - Storage computes display text via `get_price_variation(product)` even though cached `product.price_delta` exists.
   - This is acceptable for now because the requirement says not to change the calculation unless a bug is found.
   - Long-term, the app may need one single display formatter.

7. Date format inconsistency risk
   - Register uses `dd/MM/yyyy` when submitting purchase dates.
   - Service calculations appear to rely on configured `DATE_FORMAT`.
   - This is outside the current milestone unless History filtering exposes date parse failures.

8. Multiple ProductService instances
   - Each page currently creates its own `ProductService` / Repository connection.
   - This is existing architecture and should not be changed in this milestone.

## Operational Conclusion

The milestone is implementation-ready after Main synthesis.

Minimum work is:

1. add nullable `address` to Stores schema and existing DB;
2. update Store model and mapper;
3. expose store listing through service;
4. extend purchase history filtering by `store_id`;
5. build a read-only Stores page;
6. make History a real purchase table with a store filter;
7. wire Stores → History navigation in MainWindow;
8. copy Storage’s Price and Δ Price display behavior into Shortage and Market without changing price delta calculation.

Do not update Product cached summaries for Stores. Stores are historical purchase context through `purchases.store_id`, not Product summary state.
