# 03_DECISION_LOG.md

> Version: 0.1
> Status: Draft
> Persistence Class: Observational
> Knowledge Class: Design History
> Authority: Design Chat
> Scope: Architectural decisions, observations, drift, and deferred design questions

---

# Product View Design Absorption — Codex Evidence

Source evidence: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`.

Codex reported that the Product View feature was materialized as a reusable read-only panel, with RegisterPage owning placement, ProductService owning read-model assembly, Repository owning SQL/retrieval/mapping, Product owning cached summaries, Purchase owning optional expiration history, Store owning nullable address, and average price remaining derived.

---

## 1. Canonical Design Decisions

- Product View is a reusable read-only `ProductDetailPanel`.
- RegisterPage owns ProductDetailPanel placement below the writable receipt form.
- RegisterPage does not own Product View calculations.
- ProductService owns Product View read-model assembly.
- Repository owns SQL retrieval, persistence-shape support, and row mapping.
- Product owns cached summary fields for purchase rhythm and shelf-life summary.
- Purchase owns optional `expiration_date` as receipt/batch history.
- Store owns nullable `address`.
- Average price remains derived from purchases.

---

## 2. Architectural Observations

- MainWindow double-click navigation was reported as unchanged.
- ProductDetailPanel renders dictionaries and does not access repositories or services directly.
- RegisterPage now collects optional receipt expiration input and loads the panel.
- Repository provides explicit SQL read helpers for average price, latest store rows, and last purchase rows.
- ProductService centralizes shelf-life calculation and Product View read-model assembly.
- The Product View identity line renders product name, brand, and ID.
- The store table renders store name, store ID, address, latest price, and latest purchase date.
- The last purchases table includes the expiration-date column.

---

## 3. Derived Architecture Summary

The materialized feature preserves the intended boundary:

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

The design remains coherent because UI composition, business meaning, and persistence retrieval are separated.

---

## 4. Checkpoint Update

- Current design state should identify Product View as materialized and boundary-preserving.
- Current checkpoint should mention that no architecture boundary drift was reported.
- Current checkpoint should preserve the remaining question of store address editing.

---

## 5. Deferred Design Questions

- Where should store address entry/editing live?
- Should a future Store Management screen own address editing?
- Where should `expected_expiration_date` become user-facing beyond Product View?
- Should shelf-life ever affect Storage / Shortage / Market classification, or should those remain purchase-rhythm based?

---

## 6. Implementation Drift

- No intentional architecture boundary drift was reported by Codex.
- Watch point: RegisterPage now has both writable receipt input and Product View placement. This remains acceptable only while calculations stay in ProductService and rendering stays in ProductDetailPanel.
