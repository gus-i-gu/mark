# Codex Report — Design Cycle 02

## Source Stage Files

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Architectural Decisions Materialized

- History uses a service-prepared read model.
- Repository retrieves purchase/store/settings data without deciding period semantics.
- Service owns first-Wednesday month grouping, Wednesday week grouping, aggregate meaning, settings interpretation, and read-model assembly.
- History page renders grouped sections, purchase rows, and total rows.
- Settings page owns History configuration and store editing surfaces.
- Store create/update lives in Settings, not RegisterPage.
- Settings persistence uses SQLite key/value storage.
- Cycle 01 Product View boundaries remain intact.

## Files Changed Or Created For Design Reasons

- `app/database/schema.sql`: settings persistence shape.
- `app/database/seed.sql`: default settings seed values.
- `app/core/database.py`: idempotent settings migration.
- `app/core/repository.py`: SQL ownership for settings, stores, and raw History rows.
- `app/core/services.py`: History and Settings meaning layer.
- `app/desktop/main_window.py`: page wiring and refresh.
- `app/desktop/ui/pages/history_page.py`: read-only History renderer.
- `app/desktop/ui/pages/settings_page.py`: configuration and store editing page.

## Responsibility Boundaries Preserved

- History page rendering versus service grouping: preserved.
- Repository retrieval versus service period semantics: preserved.
- Settings configuration surface versus History calculation: preserved.
- Store editing in Settings rather than RegisterPage: preserved.
- Total/aggregate rows as service read-model data: preserved.
- Product View and ProductDetailPanel unaffected: preserved.
- Purchase rhythm and shelf-life rhythm unaffected: preserved, with safer date parsing.

## Boundary Drift

- No intentional boundary drift.
- `pages.order` persistence was added, but MainWindow consumption was deferred to avoid expanding scope.

## History Read-Model Evidence

- Read model includes operational month sections.
- Each month contains week sections.
- Week sections contain ordered purchase rows.
- Sections include period labels, period boundaries, and summaries.
- Summaries include monetary total, average unit price, per-unit quantity totals, and store totals.

## Settings Persistence / Configuration Evidence

- `settings` table stores `key TEXT PRIMARY KEY` and `value TEXT NOT NULL`.
- Default keys: `history.week_boundary`, `history.month_boundary_rule`, and `pages.order`.
- Service reads settings before assembling History.
- Settings page writes settings through service/repository.

## Store Editing Placement Evidence

- Settings page exposes store ID, name, city, state, and address controls.
- Store create/update uses ProductService and Repository.
- RegisterPage was not modified for store-management controls.

## Aggregate / Total-Row Design Evidence

- Monetary total is explicitly tied to purchase `total_price`.
- Average unit price is computed as mean, not sum.
- Quantities are aggregated by unit.
- Total rows are rendered by History from service-prepared summaries.

## Deferred Decisions

- Store deletion deferred because purchase references require explicit referential behavior design.
- Full interactive page sorting UI and MainWindow tab reordering deferred; only persistence support exists.

## Open Design Questions

- Should `pages.order` drive tab order in MainWindow in a later cycle?
- Should History expose filters by store/product/date after grouping stabilizes?

## Suggested [D] Follow-Up

- Absorb Cycle 02 as evidence for the History read-model boundary.
- Decide the next design step for page sorting consumption and safe store deletion behavior.
