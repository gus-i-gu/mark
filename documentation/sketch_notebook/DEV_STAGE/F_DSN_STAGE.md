# Materialization Stage — Design

## 1. Scope

This stage gives Codex architectural guardrails for the Product View refactor. It translates the Design functional report and Main/human decisions into implementation boundaries. Permanent design domain files remain for later [D] absorption after Codex reports.

## 2. Source Inputs

- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- Main Chat synthesis
- Human correction: store address is regular text; use uniform `expiration_date`; purchase expiration is optional but always displayed; product-level expiration summary may exist for future market/product analysis; average price is derived.

## 3. Accepted Design Decisions

- Product View is a reusable detail panel embedded in RegisterPage for this milestone.
- RegisterPage owns panel placement.
- MainWindow owns cross-page navigation.
- Inventory tables resolve product ID on double-click.
- ProductService owns Product View read-model assembly.
- Repository owns SQL retrieval and row mapping.
- UI renders prepared data and does not calculate averages, shelf life, latest price, status, or predictions.
- Store owns `address`.
- Purchase owns optional `expiration_date` as a batch/receipt fact.
- Product may own cached summary fields, including `average_shelf_life_days` and `expected_expiration_date`.
- Current Product View display still depends primarily on purchase-level expiration history.
- Average price is derived from purchase records and is not cached on Product in this milestone.

## 4. Responsibility Map

Product owns identity, editable metadata, inventory state, and cached product-level summaries:

- `average_duration_days`
- `expected_next_purchase`
- `average_shelf_life_days`
- `expected_expiration_date`

Purchase owns receipt/batch facts:

- purchase date
- quantity
- unit and price facts
- store relationship
- optional `expiration_date`

Store owns store identity and address:

- store ID
- store name
- existing city/state fields
- MVP `address TEXT`

Repository owns persistence:

- SQL
- joins
- row mapping
- inserts/updates/selects

ProductService owns meaning:

- purchase rhythm calculation
- shelf-life calculation
- product summary recalculation
- average price derivation for Product View
- latest store price interpretation
- Product View read-model assembly

UI owns display:

- RegisterPage places the lower detail panel.
- ProductDetailPanel renders prepared Product View data.

## 5. Product View Read Model

Codex should prefer a clear read-model shape. Dataclasses or explicit dictionaries are acceptable if names preserve domain meaning.

Minimum Product View data:

- product ID
- product name
- brand
- average price derived from purchases
- average shelf-life days if available
- expected expiration date if available
- store/latest-price rows
- last purchase rows

Store/latest-price row fields:

- store ID
- store name
- store address
- latest unit price
- latest purchase date

Last purchase row fields:

- purchase date
- unit price
- quantity
- unit
- expiration date

## 6. UI Composition Requirements

- Add or reuse `app/desktop/ui/widgets/product_detail_panel.py`.
- Embed the panel in `app/desktop/ui/pages/register_page.py` below the existing editable form/button/status area.
- RegisterPage should load the panel when `load_product(product)` is called.
- The expiration-date column is always present in the last-purchases table.
- Empty values render as a simple placeholder such as `—`.
- RegisterPage remains the writable receipt form.
- ProductDetailPanel remains a read-only detail view.

## 7. Path Normalization

Use current implementation paths under `app/desktop/`, not older `app/ui/` paths, unless repository inspection proves otherwise.

Primary UI targets:

- `app/desktop/main_window.py`
- `app/desktop/ui/pages/register_page.py`
- `app/desktop/ui/widgets/product_detail_panel.py`

Inventory-page targets only if needed:

- `app/desktop/ui/pages/storage_page.py`
- `app/desktop/ui/pages/shortage_page.py`
- `app/desktop/ui/pages/market_page.py`

## 8. Design Evidence to Report

Codex should report in `I_DSN_CODEX.md` whether the materialized implementation preserved these boundaries:

- RegisterPage placement versus business calculation.
- ProductDetailPanel display versus persistence access.
- Repository retrieval versus service calculation.
- Product summary fields versus Purchase history fields.
- Derived average price versus cached price fields.
- Purchase rhythm versus shelf-life rhythm.
- Uniform `expiration_date` naming.
- Reusable Product View panel composition.

## 9. I_DSN_CODEX.md Report Shape

After materialization, write `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md` with:

- Source stage files
- Architectural decisions materialized
- Files changed or created for design reasons
- Responsibility boundaries preserved
- Boundary drift, if any
- Product/Purchase/Store ownership evidence
- Product View UI composition evidence
- Open design questions
- Suggested [D] follow-up

Keep the report compact and evidence-oriented.
