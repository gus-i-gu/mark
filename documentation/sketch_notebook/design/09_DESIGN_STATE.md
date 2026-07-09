# 09_DESIGN_STATE.md

> Version: 0.3
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat
> Scope: Low-token recovery surface for current Markei design state

---

# Current Design State

Markei has completed three boundary-preserving design cycles.

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

Cycle 02 History + Settings remains stable:

- History uses a service-prepared grouped read model.
- ProductService owns History period grouping and read-model assembly.
- ProductService owns first-Wednesday operational month grouping and Wednesday week grouping semantics.
- ProductService owns aggregate/total-row meaning.
- Repository retrieves purchase/store/settings data without deciding period semantics.
- HistoryPage renders grouped sections, purchase rows, summaries, and total rows.
- SettingsPage owns configuration surfaces and store editing placement.
- Store create/update belongs in Settings, not RegisterPage.
- SQLite key/value settings persistence is accepted.
- `history.week_boundary` and `history.month_boundary_rule` affect History grouping through service interpretation.
- `pages.order` persistence exists, but MainWindow page-order consumption remains deferred.

Cycle 03 Lists + History Analytics is now absorbed as stable design state:

- ListsPage is now the public inventory surface.
- Former Storage / Shortage / Market meanings are internal Lists views.
- Internal Lists views are `in-house`, `shortage`, and `to-buy`.
- Combined Lists views include `in-house + shortage` and `shortage + to-buy`.
- Lists default view is the hybrid all-products list with Status column.
- ProductService owns Lists read-model assembly, product status classification, global latest price meaning, global delta price meaning, and list row labels.
- History analytics is embedded in HistoryPage and read-only.
- ProductService owns History analytics read-model assembly, date/store frame interpretation, total spent, expenditure percentage, frame average purchase timelapse, and product-cycle comparison.
- Analytics frame means date range plus optional store filter.
- Average purchase timelapse means the average interval between parsed purchases in the selected frame, ordered by date.
- Product cycle means `average_duration_days`.
- Cycle comparison remains simple faster/slower/equal; configurable tolerance is deferred.
- Repository/schema were not expanded for analytics caching or list-specific persisted fields.
- Register remains purchase-entry-only.
- Settings remains the store-management surface.
- `pages.order` remains deferred and is not consumed by MainWindow tab ordering.
- Old Storage/Shortage/Market page files remain a deferred cleanup topic.
- Mobile readiness improved through service/read-model contracts, but mobile implementation is not ready.

# Boundary Status

- No intentional architecture boundary drift was reported for Cycle 01, Cycle 02, or Cycle 03.
- UI owns rendering, controls, view selection, navigation hooks, and event handling.
- UI must not calculate product status, latest/delta price meaning, History grouping, analytics percentages, average timelapse, or cycle comparison.
- ProductService owns Product View, Lists, grouped History, and History analytics read-model assembly.
- Repository owns SQL retrieval, persistence support, settings access, and row mapping.
- Repository must not own period semantics, list classification semantics, or analytics semantics.
- Schema/storage owns persisted facts; Cycle 03 did not add analytics cache fields.
- RegisterPage remains receipt-focused and should not become a store-management surface.
- SettingsPage remains the configuration and store-management surface.

# Mobile Readiness Classification

Current classification: prepared for future mobile discussion, not ready for mobile implementation.

Prepared now:

- service-owned Lists read model;
- service-owned History analytics read model;
- platform-neutral dictionary/list outputs from service methods;
- UI logic reduced to PySide6 rendering and events;
- business meanings available outside desktop widgets.

Not yet ready:

- Android/mobile implementation;
- API/backend rewrite;
- authentication or sync design;
- mobile persistence strategy;
- typed service contracts;
- service factory/dependency injection boundary;
- formal date validation strategy;
- automated service-level test coverage;
- explicit separation between UI labels and semantic values.

# Deferred Design Questions

- Should invalid analytics date input surface explicit UI validation instead of acting like an omitted boundary?
- Should same-day purchase intervals be handled specially in average timelapse display?
- Should old Storage/Shortage/Market page files be retired in a later cleanup cycle after manual QA evidence?
- Should future Lists delta price support store/frame scoping?
- Should cycle comparison gain configurable tolerance?
- Should detachable History analytics become a separate lifecycle later?
- Should `pages.order` drive MainWindow tab/page order in a later cycle?
- What referential behavior is required before supporting store deletion?
- Where should `expected_expiration_date` appear beyond Product View?
- Should shelf-life ever influence inventory list classification?

# Next Recovery Targets

- Canonical architecture: `documentation/sketch_notebook/design/01_ARCHITECTURE.md`
- Design history: `documentation/sketch_notebook/design/03_DECISION_LOG.md`
- Derived model map: `documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md`
- Latest Codex design evidence, if reconciling recent materialization: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
