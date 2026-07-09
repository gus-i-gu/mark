# Operational Model

## Product View Operational Model

- Product View is a read-only inspection surface displayed in the lower portion of Register after product navigation from inventory pages.
- Inventory pages initiate Product View loading through double-click row selection and `MainWindow.edit_product(product)`.
- Register remains the writable receipt/product page; Product View is observational display only.
- Product View should consume prepared service read-model data rather than querying persistence directly from UI code.

## Rhythm and Expiration Model

- `average_duration_days` is the purchase-to-purchase rhythm and remains operationally distinct from shelf life.
- `expected_next_purchase` is predicted from purchase rhythm.
- `average_shelf_life_days` is the purchase-to-expiration rhythm.
- `expected_expiration_date` is predicted or summarized from shelf-life rhythm.
- `purchases.expiration_date` is optional, allowing older or unknown expiration data to remain valid.

## Persistence and Migration Model

- Schema evolution must account for existing local SQLite databases.
- Database migration should be idempotent and inspect current table shape before adding missing columns.
- Destructive reset is not the default operational path.
- Migration-relevant fields from the Product View milestone are:
  - `purchases.expiration_date`
  - `products.average_shelf_life_days`
  - `products.expected_expiration_date`
  - `stores.address`

## Validation Model

- Operational validation proceeds in layers:
  - compile/syntax validation
  - database initialization/migration validation
  - schema inspection
  - service-level read/write validation
  - application startup validation
  - manual interactive UI validation
- For Product View, compile/database/service/startup validation has evidence.
- Manual interaction validation remains required before treating the UI workflow as fully accepted.

## Known Operational Boundaries

- Store address editing is outside the completed Product View materialization.
- Average price is derived for Product View and is not currently a cached product field.
- Inventory status classification remains tied to `expected_next_purchase` unless a future design decision changes it.
- Date calculations assume the configured project date format is respected by stored data.
