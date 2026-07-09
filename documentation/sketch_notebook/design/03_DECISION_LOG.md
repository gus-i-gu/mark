# 03_DECISION_LOG.md

> Version: 0.2
> Status: Draft
> Persistence Class: Observational
> Knowledge Class: Design History
> Authority: Design Chat
> Scope: Architectural decisions, observations, drift, and deferred design questions

---

# Product View Design Absorption — Codex Evidence

Source evidence: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`.

Codex reported that the Product View feature was materialized as a reusable read-only panel, with RegisterPage owning placement, ProductService owning read-model assembly, Repository owning SQL/retrieval/mapping, Product owning cached summaries, Purchase owning optional expiration history, Store owning nullable address, and average price remaining derived.

## Canonical Design Decisions

- Product View is a reusable read-only `ProductDetailPanel`.
- RegisterPage owns ProductDetailPanel placement below the writable receipt form.
- RegisterPage does not own Product View calculations.
- ProductService owns Product View read-model assembly.
- Repository owns SQL retrieval, persistence-shape support, and row mapping.
- Product owns cached summary fields for purchase rhythm and shelf-life summary.
- Purchase owns optional `expiration_date` as receipt/batch history.
- Store owns nullable `address`.
- Average price remains derived from purchases.

## Architectural Observations

- MainWindow double-click navigation was reported as unchanged.
- ProductDetailPanel renders dictionaries and does not access repositories or services directly.
- RegisterPage now collects optional receipt expiration input and loads the panel.
- Repository provides explicit SQL read helpers for average price, latest store rows, and last purchase rows.
- ProductService centralizes shelf-life calculation and Product View read-model assembly.
- The Product View identity line renders product name, brand, and ID.
- The store table renders store name, store ID, address, latest price, and latest purchase date.
- The last purchases table includes the expiration-date column.

## Derived Architecture Summary

```text
Inventory selection
    ↓
RegisterPage placement
    ↓
ProductDetailPanel rendering
    ↓
ProductService read-model assembly
    ↓
Repository retrieval/mapping
    ↓
Product / Purchase / Store persistence
```

## Deferred Design Questions

- Where should `expected_expiration_date` become user-facing beyond Product View?
- Should shelf-life ever affect Storage / Shortage / Market classification, or should those remain purchase-rhythm based?

## Implementation Drift

- No intentional architecture boundary drift was reported by Codex.
- Watch point: RegisterPage has both writable receipt input and Product View placement. This remains acceptable only while calculations stay in ProductService and rendering stays in ProductDetailPanel.

---

# Cycle 02 History + Settings Design Absorption — Codex Evidence

Source evidence: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md` after Cycle 02 materialization.

Codex reported that History and Settings were materialized with a service-prepared History read model, service-owned time bucketing, repository retrieval boundaries, SQLite settings persistence, Settings-owned configuration surfaces, and Settings-placed store create/update.

## Canonical Design Decisions

- History uses a service-prepared read model.
- ProductService owns first-Wednesday month grouping and Wednesday week grouping semantics.
- ProductService owns History aggregate/total-row meaning.
- Repository retrieves purchase/store/settings data without deciding period semantics.
- HistoryPage renders grouped sections, purchase rows, summaries, and total rows.
- SettingsPage owns History configuration surfaces.
- SettingsPage owns store editing placement.
- Store create/update belongs in Settings rather than RegisterPage.
- SQLite key/value settings persistence is accepted.
- Product View architecture remains unchanged.
- RegisterPage remains receipt-focused and does not become a store-management surface.

## Architectural Observations

- Settings persistence includes keys for `history.week_boundary`, `history.month_boundary_rule`, and `pages.order`.
- Service reads settings before assembling History.
- Settings page writes settings through service/repository.
- Store editing controls include store ID, name, city, state, and address.
- Total rows are rendered by History from service-prepared summaries.
- Monetary total is tied to purchase `total_price`.
- Average unit price is computed as mean, not sum.
- Quantities are aggregated by unit.
- Manual UI observations validate that History renders grouped sections and Settings exposes store/configuration controls, but do not add new architecture beyond the boundaries above.

## Derived Architecture Summary

```text
SettingsPage
    ↓ edits settings / stores
ProductService
    ↓ interprets settings and validates store flow
Repository
    ↓ persists settings / stores
SQLite
```

```text
HistoryPage
    ↓ requests read model
ProductService
    ↓ groups raw rows using settings
Repository
    ↓ retrieves purchase / store / settings data
SQLite
```

## Deferred Design Questions

- Should `pages.order` drive MainWindow tab/page order in a later cycle?
- Should History expose filters by store/product/date after grouping stabilizes?
- What referential behavior is required before supporting store deletion?

## Implementation Drift

- No intentional boundary drift was reported.
- `pages.order` persistence exists, but MainWindow consumption is deferred and should not be treated as active page-order behavior yet.
