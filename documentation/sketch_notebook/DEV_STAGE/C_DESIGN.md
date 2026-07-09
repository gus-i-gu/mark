# Functional Stage — Design

## 1. Scope

Design staging for Cycle 02: History UI page and Settings page. This cycle extends the existing Markei layer boundaries by adding service-prepared History grouping/read models and a Settings surface for store editing, page sorting configuration, and History time-reference configuration.

## 2. Accepted Facts

- History page must show purchases ordered sequentially.
- History page must group/trench purchases by month and week.
- Default month boundary is the first Wednesday of the month.
- Default week boundary is every Wednesday.
- History page must include Total rows showing cumulative product values for a store under a timeframe.
- Repository retrieves purchase/time/store data.
- Service groups purchases into history periods.
- UI renders grouped history sections and total rows.
- Settings persists configuration and editing preferences.
- Time-reference configuration affects History grouping/bucketing rules.
- Cycle 01 established that UI renders, ProductService owns meaning/read-model assembly, and Repository owns SQL/retrieval/mapping.

## 3. Responsibility Map

- Schema/storage owns persisted purchases, stores, settings/config values, and relationships.
- Repository owns SQL retrieval, store persistence, settings persistence, and row/model mapping.
- Service owns History grouping, period construction, total-row meaning, sorting interpretation, and settings-mediated configuration use.
- History page owns rendering of service-prepared History sections, purchase rows, and total rows.
- Settings page owns the configuration surface but should host focused editor components rather than accumulating all editing logic directly.
- Store editor component owns store edit UI behavior; Repository/Service still own persistence and validation flow.
- MainWindow owns page/tab construction and should consume page sorting configuration.
- Product/Purchase/Store retain Cycle 01 ownership: Purchase owns receipt facts, Store owns address, Product owns cached product summaries.

## 4. Requirements for Main Synthesis

- Define a service-prepared History read model rather than letting UI group raw purchases.
- Keep week/month bucketing in service, not repository and not UI.
- Let repository retrieve ordered purchase/store/time data without deciding period semantics.
- Represent Total rows as service read-model rows or section summaries, not UI-only calculations.
- Persist History time-reference settings through a settings/config path.
- Ensure Settings time-reference configuration drives History grouping defaults.
- Ensure page sorting configuration affects MainWindow/tab/page construction, not individual page internals.
- Ensure Settings hosts store editing while store persistence remains service/repository-owned.
- Preserve Product View boundary pattern: UI renders prepared data; service owns meaning; repository owns retrieval/mapping.

## 5. Continuity from Cycle 01

- Store address persistence/display already exists from Cycle 01.
- Store address editing was deferred and can now be continued through Settings or a Store editor hosted by Settings.
- ProductDetailPanel remains reusable/read-only and should not be affected by History or Settings implementation.
- Average price remains derived; History totals may use purchase values but should not create new Product cached fields.
- Purchase expiration and Product shelf-life rhythm remain separate from History purchase grouping unless explicitly surfaced.
- Cycle 02 extends boundaries by adding configuration ownership, not by moving calculations into UI.

## 6. Risks / Open Questions

- Confirm whether Settings directly owns store editing or hosts a reusable StoreEditor component; design preference: host component.
- Confirm exact persisted shape for time-reference config: weekday enum/name, month boundary rule, and week boundary rule.
- Confirm whether History total rows are per store, per product, per period, or nested combinations of those.
- Confirm whether purchases are displayed globally or filtered by store/product/page controls.
- Risk: UI may drift into grouping purchases if History page receives raw purchase rows only.
- Risk: repository may drift into business grouping if SQL encodes first-Wednesday/week-boundary semantics.
- Risk: Settings may become an unbounded page if store editing, sorting, and time rules are not separated into components.

## 7. Recommended Materialization Targets

- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`
- `app/database/schema.sql`
- `app/core/models.py`
- `app/core/contracts.py`
- `app/core/repository.py`
- `app/core/services.py`
- `app/desktop/ui/main_window.py`
- `app/desktop/ui/pages/history_page.py`
- `app/desktop/ui/pages/settings_page.py`
- `app/desktop/ui/widgets/store_editor.py`
- `app/desktop/ui/widgets/history_section.py`
- `app/desktop/ui/widgets/history_table.py`
- `app/desktop/ui/widgets/settings_time_reference.py`
- `app/desktop/ui/widgets/page_sorting_editor.py`

## 8. Handoff Summary

- Build History around a service-owned read model.
- Service owns month/week grouping and Total row semantics.
- Repository retrieves purchase/store/time data but does not decide period meaning.
- UI renders grouped sections and total rows from prepared data.
- Settings owns configuration surface and persists time-reference/page-sorting preferences through service/repository flow.
- Settings should host a Store editor component to continue Cycle 01 deferred store address editing.
- MainWindow should consume page sorting configuration when constructing or ordering pages/tabs.
- Keep Cycle 01 Product View boundaries intact.
- Avoid caching History totals or average price on Product unless a future design explicitly promotes that need.
- Treat this file as functional staging only; permanent design memory should wait for Codex evidence absorption.
