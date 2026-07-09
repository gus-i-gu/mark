# 09_DESIGN_STATE.md

> Version: 0.2
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat
> Scope: Low-token recovery surface for current Markei design state

---

# Current Design State

Markei has completed two boundary-preserving design cycles.

Cycle 01 Product View remains stable:

- Product View is a reusable read-only `ProductDetailPanel`.
- RegisterPage owns placement below the receipt form, not Product View calculations.
- ProductService owns Product View read-model assembly and shelf-life meaning.
- Repository owns SQL retrieval, persistence support, and row mapping.
- Product owns cached summaries: `average_duration_days`, `expected_next_purchase`, `average_shelf_life_days`, `expected_expiration_date`.
- Purchase owns optional `expiration_date` as receipt/batch history.
- Store owns nullable `address`.
- Average price remains derived from purchases.
- Purchase rhythm and shelf-life rhythm remain separate.
- Storage / Shortage / Market classification remains purchase-rhythm based unless later redesigned.

Cycle 02 History + Settings is now stable:

- History uses a service-prepared read model.
- ProductService owns History period grouping and read-model assembly.
- ProductService owns first-Wednesday operational month grouping and Wednesday week grouping semantics.
- ProductService owns aggregate/total-row meaning.
- Repository retrieves purchase/store/settings data without deciding period semantics.
- HistoryPage renders grouped sections, purchase rows, summaries, and total rows.
- SettingsPage owns configuration surfaces.
- SettingsPage owns store editing placement.
- Store create/update belongs in Settings, not RegisterPage.
- SQLite key/value settings persistence is accepted.
- `history.week_boundary` and `history.month_boundary_rule` affect History grouping through service interpretation.
- `pages.order` persistence exists, but MainWindow page-order consumption is deferred.

# Boundary Status

- No intentional architecture boundary drift was reported for Cycle 01 or Cycle 02.
- RegisterPage remains receipt-focused and should not become a store-management surface.
- ProductDetailPanel remains read-only and must not access persistence directly.
- HistoryPage must not group raw purchases or calculate totals directly.
- Repository must not own History period semantics.
- SettingsPage should route persistence through service/repository flow.

# Deferred Design Questions

- Should `pages.order` drive MainWindow tab/page order in a later cycle?
- What referential behavior is required before supporting store deletion?
- Should History expose filters by store/product/date after grouping stabilizes?
- Where should `expected_expiration_date` appear beyond Product View?
- Should shelf-life ever influence inventory list classification?

# Next Recovery Targets

- Canonical architecture: `documentation/sketch_notebook/design/01_ARCHITECTURE.md`
- Design history: `documentation/sketch_notebook/design/03_DECISION_LOG.md`
- Derived model map: `documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md`
- Latest Codex design evidence: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
