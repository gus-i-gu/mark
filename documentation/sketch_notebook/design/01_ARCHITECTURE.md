# 01_ARCHITECTURE.md

> Version: 0.1
> Status: Draft
> Persistence Class: Canonical
> Knowledge Class: Design / Architecture
> Authority: Design Chat
> Scope: Markei architectural boundaries and responsibility ownership

---

# 1. Layer Boundaries

Markei currently follows a desktop layered architecture:

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
SQLite schema / storage
```

Canonical boundary rules:

- Desktop UI owns rendering, user events, page composition, and navigation hooks.
- Services own business meaning, calculations, workflow coordination, and UI-facing read-model assembly.
- Repository owns SQL retrieval, persistence operations, and row-to-model mapping.
- Schema/storage owns persisted facts, relationships, and migration-visible data shape.
- Models describe domain entities and may hold cached summaries, but must not execute SQL or perform business orchestration.

---

# 2. Product View Architecture

The Product View is a reusable read-only `ProductDetailPanel`.

Canonical decision:

- `ProductDetailPanel` owns display of product detail data.
- `RegisterPage` owns placement of the panel below the writable receipt form.
- `RegisterPage` does not own Product View calculations.
- `ProductService` owns Product View read-model assembly.
- Repository owns the SQL/retrieval/mapping needed to support that assembly.

Current composition:

```text
Inventory table double-click
    ↓ product_id
MainWindow navigation
    ↓
RegisterPage placement/loading
    ↓
ProductDetailPanel rendering
    ↓
ProductService read model
    ↓
Repository retrieval
    ↓
SQLite persistence
```

The Product View may later be reused by Storage, Shortage, Market, or History without moving business logic into those pages.

---

# 3. Product / Purchase / Store Ownership

Canonical ownership:

- Product owns product identity, editable product metadata, inventory state, and cached product-level summaries.
- Purchase owns immutable receipt/batch facts.
- Store owns store identity and location facts.
- Product View owns no domain facts; it renders service-prepared data.

Specific accepted ownership:

- Product owns `average_duration_days` and `expected_next_purchase` as purchase-rhythm summaries.
- Product owns `average_shelf_life_days` and `expected_expiration_date` as shelf-life summaries.
- Purchase owns optional `expiration_date` as a receipt/batch-level fact.
- Store owns nullable `address`.
- Average price remains derived from purchases and is not a cached Product field.

---

# 4. Rhythm Separation

Markei separates two temporal meanings:

- Purchase rhythm: how often the user buys the product.
- Shelf-life rhythm: how long a purchased batch lasts before expiration.

Canonical mapping:

```text
average_duration_days      -> purchase-to-purchase rhythm
expected_next_purchase     -> prediction from purchase rhythm
average_shelf_life_days    -> purchase-to-expiration rhythm
expected_expiration_date   -> prediction/state from shelf-life rhythm
```

Purchase classification for Storage / Shortage / Market remains based on `expected_next_purchase` unless a later design decision explicitly changes list semantics.

---

# 5. Boundary Drift Guards

- UI must not calculate averages, shelf-life summaries, latest store prices, product status, or predictions.
- Repository must not decide business meaning for returned rows or aggregates.
- ProductService must remain the owner of Product View read-model assembly.
- Product must not absorb purchase-specific history beyond cached summaries.
- Purchase expiration remains purchase-level history.
- Store address editing is deferred to a future store-management design surface.
