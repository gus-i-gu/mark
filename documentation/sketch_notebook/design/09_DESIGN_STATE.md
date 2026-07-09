# 09_DESIGN_STATE.md

> Version: 0.1
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat
> Scope: Low-token recovery surface for current Markei design state

---

# Current Design State

Markei's Product View feature has been materialized with preserved architecture boundaries.

Current accepted design:

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

# Boundary Status

- No architecture boundary drift was reported by Codex.
- RegisterPage now contains optional expiration input and hosts ProductDetailPanel; this is acceptable while calculations stay in ProductService.
- ProductDetailPanel must remain read-only and must not access persistence directly.

# Deferred Design Questions

- Where should store address entry/editing live?
- Should a future Store Management screen own address editing?
- Where should `expected_expiration_date` appear beyond Product View?
- Should shelf-life ever influence inventory list classification?

# Next Recovery Targets

- Canonical architecture: `documentation/sketch_notebook/design/01_ARCHITECTURE.md`
- Design history: `documentation/sketch_notebook/design/03_DECISION_LOG.md`
- Derived model map: `documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md`
- Codex evidence source: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
