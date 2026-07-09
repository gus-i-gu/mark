# Materialization Stage — Operational

## 1. Scope

This stage gives Codex the operational implementation instructions for the Markei Product View refactor. It materializes source/schema changes and validation evidence only. It does not promote permanent domain memory and does not edit methodology files.

## 2. Source Inputs

- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- Human correction from Main Chat: use uniform `expiration_date`; store address is plain `TEXT`; expiration date is optional but always displayed; average price is derived; migration should be stress-tested.

## 3. Accepted Operational Decisions

- Preserve `average_duration_days` as purchase-to-purchase rhythm.
- Preserve `expected_next_purchase` as prediction from purchase rhythm.
- Add `average_shelf_life_days` separately as purchase-to-expiration rhythm.
- Use uniform field name `expiration_date`.
- Add purchase-level `expiration_date` as nullable text.
- Add store-level `address` as nullable text.
- Product-level `expected_expiration_date` may be added as nullable cached/summary field for future collective product-market analysis, but current end-user Product View must primarily display purchase-level expiration data.
- Average price must be derived from collected purchase prices, not cached on Product for this milestone.
- Existing cached product price fields and purchase price fields remain as they are.
- Migration is required; do not rely on destructive reset as the default path.

## 4. Implementation Targets

Inspect and update only as needed:

- `app/database/schema.sql`
- `app/core/database.py`
- `app/core/models.py`
- `app/core/contracts.py`
- `app/core/repository.py`
- `app/core/services.py`
- `app/desktop/main_window.py`
- `app/desktop/ui/pages/register_page.py`
- `app/desktop/ui/pages/storage_page.py`
- `app/desktop/ui/pages/shortage_page.py`
- `app/desktop/ui/pages/market_page.py`
- Create `app/desktop/ui/widgets/product_detail_panel.py` if no equivalent widget exists.

Do not edit permanent domain folders in this pass.
Do not edit methodology files.
Do not create new Sketch Notebook files outside the named G/H/I report files.

## 5. Database and Migration Requirements

Implement an idempotent migration path in `app/core/database.py` or the existing database-management layer.

The migration must preserve existing user data and must be safe to run multiple times.

At minimum, ensure these nullable columns exist:

```sql
purchases.expiration_date TEXT
products.average_shelf_life_days INTEGER
products.expected_expiration_date TEXT
stores.address TEXT
```

Recommended mechanism:

- Inspect current columns with `PRAGMA table_info(<table>)`.
- Run `ALTER TABLE ... ADD COLUMN ...` only when the column is missing.
- Call the migration from the normal connection/initialization path so existing local databases are upgraded.
- Keep destructive `reset()` behavior explicit only.

## 6. Model Requirements

Update dataclasses and row mappers so the new fields are represented without breaking existing records:

- `Purchase.expiration_date: Optional[str]`
- `Store.address: Optional[str]`
- `Product.average_shelf_life_days: Optional[int]`
- `Product.expected_expiration_date: Optional[str]`

Use defaults compatible with existing code paths.

## 7. Repository Requirements

Update SQL insert/select/update/mappers for new fields.

Repository may retrieve raw rows and joined view data, but must not decide business meaning.

Add repository helpers only if needed for Product View, for example:

- product purchase history with store fields
- average unit price for a product
- latest store price rows for a product

Use explicit names in returned dictionaries or dataclasses. Avoid vague keys like `date` when the meaning is `purchase_date` or `expiration_date`.

## 8. Service Requirements

ProductService owns calculations and Product View read-model assembly.

Implement or extend service behavior so:

- `calculate_average_duration` remains purchase-to-purchase.
- A separate shelf-life calculation computes average days between `purchase_date` and `expiration_date` for purchases that have expiration data.
- Product summary update writes `average_shelf_life_days` and, if implemented, `expected_expiration_date` without changing `average_duration_days` semantics.
- Product View data includes product identity, derived average price, shelf-life summary, store/latest-price rows, and last purchases.
- Product View data handles missing expiration dates gracefully.

## 9. UI Requirements

RegisterPage should host a lower Product View panel.

Preferred implementation:

- Create reusable `ProductDetailPanel` under `app/desktop/ui/widgets/`.
- RegisterPage creates and places the panel below the existing form/buttons/status area.
- RegisterPage calls the panel refresh/load method from `load_product(product)`.
- Existing double-click navigation through MainWindow should remain intact.
- Product View must always display the expiration-date column, even when values are empty/placeholder.

Display requirements:

```text
[Product Name], [Product Brand], [ID]
[Average Price] [Average Shelf-Life / Expiration Timing] | [Stores] [StoreID] [Store address] - [Latest Price]
Last Purchases:
[Purchase Date] | [Price] | [Quantity] | [Expiration Date]
```

## 10. Validation Requirements

Run and report results for available commands, adapting to the local environment:

```bash
python -m compileall app
python -m app.core.database
python -m app.main
```

Also inspect or report migration evidence, such as:

```sql
PRAGMA table_info(purchases);
PRAGMA table_info(products);
PRAGMA table_info(stores);
```

Manual validation checklist to report:

- Existing database is migrated without destructive reset.
- A product can be registered without `expiration_date`.
- A product can be registered with `expiration_date` if UI support is implemented.
- Double-clicking an inventory row opens Register and loads the product.
- Lower Product View renders identity, average price, store/address/latest price, last purchases, and expiration date column.
- Products with missing expiration dates do not crash.
- Storage/Shortage/Market classification remains driven by `expected_next_purchase`.

## 11. Codex Report Requirement

After materialization, write `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md` with:

- Source stage files read
- Files changed
- Files created
- Files deleted
- Commands run
- Validation results
- Migration evidence
- Instructions completed
- Instructions skipped
- Failures/blockers
- Unresolved operational risks
- Suggested follow-up
