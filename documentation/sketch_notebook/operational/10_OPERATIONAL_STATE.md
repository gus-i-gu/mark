# Operational State

> Checkpoint refreshed from `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`.

## Current Implementation State

- Product View materialization has been reported by Codex and is operationally classified as implemented with remaining manual UI validation.
- Schema now includes nullable `purchases.expiration_date`, `products.average_shelf_life_days`, `products.expected_expiration_date`, and `stores.address`.
- Database migration is reported as idempotent through `PRAGMA table_info(...)` checks and `ALTER TABLE ... ADD COLUMN ...` only when columns are missing.
- `average_duration_days` remains the purchase-to-purchase rhythm.
- `expected_next_purchase` remains the purchase-rhythm prediction.
- `average_shelf_life_days` is now separate purchase-to-expiration rhythm.
- `expected_expiration_date` is now separate expiration prediction.
- Product View read model is assembled in service layer and rendered read-only in Register through a reusable panel.
- Average price is derived from purchases for Product View rather than cached as product state.
- Inventory classification remains based on `expected_next_purchase`.

## Validation State

- `python -m compileall app`: passed.
- `python -m app.core.database`: passed without destructive reset.
- PRAGMA schema inspection: passed for new product, purchase, and store columns.
- Product View service read on migrated user database: passed.
- Isolated temp-`LOCALAPPDATA` write workflow: passed.
- `python -m app.main`: reached Qt event loop with no startup/import traceback, then spawned GUI processes were stopped.
- `git diff --check`: passed; line-ending normalization warnings only.

## Remaining Operational Work

- Manually verify desktop UI behavior after double-click from Storage, Shortage, and Market into Register.
- Manually inspect lower Register Product View panel contents for identity, average price, store/latest price, purchase history, and expiration fields.
- Decide later whether store address editing belongs in a store-management milestone.
- Watch for mixed historical date formats affecting shelf-life recalculation.

## Active Risks

- Manual GUI validation is incomplete.
- Existing historical records may contain date-format drift.
- Store address persistence/display exists, but no editing UI exists yet.
- Shelf-life fields are nullable, so older purchases may display blank expiration values.
