# Functional Stage — Design

## 1. Scope

Design staging for the Product View feature in Markei. The feature adds a reusable product detail panel, initially displayed in the lower portion of RegisterPage after a product row is double-clicked from Storage, Shortage, Market, or another inventory table.

## 2. Accepted Facts

- Product View must show product identity: product name, brand, and ID.
- Product View must show summary values: average price and average consumption/expiration timing.
- Product View must show store rows: store name, store ID, store address, and latest price.
- Product View must show last purchases: date, price, quantity, and expiring date.
- `average_duration_days` means purchase-to-purchase rhythm.
- `average_shelf_life_days` means purchase-to-expiration rhythm.
- `expected_next_purchase` belongs to purchase rhythm prediction.
- `expected_expiration_date` belongs to shelf-life prediction or latest known expiration state.
- Store address belongs to Store, not Product or Purchase.
- Expiring date belongs to Purchase because it describes a specific bought batch.
- Product may cache calculated product-level summaries, but must not absorb purchase-specific history.
- Product View should be a separate reusable detail panel embedded in RegisterPage for this milestone.

## 3. Requirements for Main Synthesis

- Preserve the current layer boundary: UI renders, service coordinates meaning, repository persists and maps, schema stores facts.
- Add a service-owned derived read model for Product View data.
- Keep Product View rendering separate from RegisterPage form logic.
- Route double-click selection through product ID, not visible name/brand text.
- Let MainWindow coordinate navigation from inventory pages to RegisterPage.
- Let RegisterPage host and refresh the reusable ProductDetailPanel.
- Ensure UI does not calculate averages, latest prices, shelf life, product status, or predictions.
- Ensure repository does not decide business meaning for summaries.
- Ensure ProductService assembles Product, Purchase, and Store data into the Product View read model.

## 4. Risks / Open Questions

- Decide whether Store address is one `address TEXT` field for MVP or structured address fields.
- Decide whether purchase `expiring_date` is mandatory or optional.
- Decide whether `expected_expiration_date` is cached on Product or only derived for the detail view.
- Decide whether average price remains derived or becomes cached later.
- Confirm the exact UI event API between inventory tables, MainWindow, RegisterPage, and ProductDetailPanel.
- Risk: RegisterPage may drift into owning product-detail calculations if the panel is not separated.
- Risk: Product may become overloaded if purchase-specific history is copied into Product fields.

## 5. Recommended Materialization Targets

- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`
- `documentation/sketch_notebook/design/09_DESIGN_STATE.md`
- `documentation/sketch_notebook/design/01_ARCHITECTURE.md`
- `documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md`
- `documentation/sketch_notebook/design/03_DECISION_LOG.md`
- `app/database/schema.sql`
- `app/core/models.py`
- `app/core/contracts.py`
- `app/core/repository.py`
- `app/core/services.py`
- `app/ui/main_window.py`
- `app/ui/pages/register_page.py`
- `app/ui/widgets/product_detail_panel.py`
- Inventory table page files for Storage, Shortage, Market, and later History.

## 6. Handoff Summary

- Treat Product View as a reusable detail panel, not RegisterPage business logic.
- Product owns identity, editable metadata, inventory state, and cached product-level summaries.
- Purchase owns immutable receipt facts, including expiring date.
- Store owns store identity and address.
- ProductService owns Product View read-model assembly.
- Repository owns SQL retrieval and row mapping only.
- MainWindow owns cross-page navigation.
- RegisterPage owns placement of the lower detail panel.
- Inventory tables must emit product ID on double-click.
- Keep purchase rhythm and shelf-life rhythm separate throughout schema, models, services, and UI.
