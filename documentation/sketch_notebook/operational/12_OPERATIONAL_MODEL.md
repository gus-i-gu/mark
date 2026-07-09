# Operational Model

## Product View Operational Model

- Product View is a read-only inspection surface displayed in the lower portion of Register after product navigation from inventory/List pages.
- Inventory/List pages initiate Product View loading through double-click row selection and `MainWindow.edit_product(product)`.
- Register remains the writable receipt/product page; Product View is observational display only.
- Product View consumes prepared service read-model data rather than querying persistence directly from UI code.
- Cycle 02 manual validation confirms Product View remains operational.

## Lists Operational Model

- Lists is the public inventory navigation surface after Cycle 03.
- Public desktop tabs are Register / Lists / History / Settings.
- Former Storage/Shortage/Market public meanings are internal Lists views:
  - Storage -> `in-house`
  - Shortage -> `shortage`
  - Market -> `to-buy`
- Lists also supports hybrid views:
  - `all`
  - `in-house + shortage`
  - `shortage + to-buy`
- Lists uses a shared service-prepared row shape for all internal views.
- Lists displays product identity, brand, quantity, global latest price, global price delta, cycle, next purchase, remaining time, status, and ID.
- Lists status filtering is derived from service-owned inventory classification, not UI-owned business logic.
- Lists double-click routes selected products through `MainWindow.edit_product(product)`.
- Compatibility navigation helpers may preserve old route names while selecting the matching internal Lists view.
- Old Storage/Shortage/Market page files may remain temporarily as transitional source files, but they are no longer public navigation surfaces.

## Rhythm and Expiration Model

- `average_duration_days` is the purchase-to-purchase rhythm and remains operationally distinct from shelf life.
- `expected_next_purchase` is predicted from purchase rhythm.
- `average_shelf_life_days` is the purchase-to-expiration rhythm.
- `expected_expiration_date` is predicted or summarized from shelf-life rhythm.
- `purchases.expiration_date` is optional, allowing older or unknown expiration data to remain valid.
- Inventory status classification remains tied to `expected_next_purchase` unless a future design decision changes it.
- History analytics product cycle comparison uses `average_duration_days`, not shelf-life fields.

## History Operational Model

- History is a read-only page assembled from service-prepared History read-model data.
- Repository retrieves purchase, product, time, and store data.
- Service groups purchases into operational Month -> Week sections.
- Default operational month boundary is the first Wednesday of the month.
- Default week boundary is Wednesday.
- History supports date-drift handling by reporting unsupported rows through `unparsed_rows` rather than repairing them.
- History totals use stored purchase values as service-prepared aggregates.
- Multi-store History/analytics totals require further validation before being considered fully validated.

## History Analytics Operational Model

- History analytics is embedded in HistoryPage after Cycle 03.
- Analytics is read-only and service-prepared.
- Analytics frame is date range plus optional store filter.
- Average purchase timelapse means the average interval between parsed purchases in the selected frame, ordered by date.
- Product cycle means `average_duration_days`.
- Cycle comparison means product cycle minus frame average timelapse.
- Product comparison display is simple faster/slower/equal/unknown without configurable tolerance.
- Analytics excludes unparsed rows from calculations and reports unparsed/excluded counts separately.
- Analytics uses stored `total_price` values for frame and product spending totals.
- Product expenditure percentage is product total spent divided by selected-frame total spent.
- Analytics values are derived at read time; no analytics cache or schema field exists.
- Invalid date input currently behaves like an omitted boundary and requires follow-up handling.
- Same-day purchase-heavy frames can produce sub-day average timelapse values and require semantic/display review.

## Settings Operational Model

- Settings is the user-facing page for implemented configuration and store create/update.
- Settings persistence uses SQLite-backed `settings(key, value)` rows.
- Implemented settings include:
  - `history.week_boundary`
  - `history.month_boundary_rule`
  - `pages.order`
- Default settings are inserted idempotently and existing user choices are preserved.
- History configuration UI currently exposes implemented defaults.
- Page sorting persistence exists, but MainWindow tab sorting behavior remains deferred.
- Store editing through Settings supports create/update for store name, city, state, and address.
- Store deletion remains deferred.
- Store editing through Register remains deferred; Register remains purchase-entry-only.

## Persistence and Migration Model

- Schema evolution must account for existing local SQLite databases.
- Database migration should be idempotent and inspect current table shape before adding missing columns/tables.
- Destructive reset is not the default operational path.
- Cycle 01 migration-relevant fields:
  - `purchases.expiration_date`
  - `products.average_shelf_life_days`
  - `products.expected_expiration_date`
  - `stores.address`
- Cycle 02 migration-relevant structure:
  - `settings(key, value)`
  - default settings insertion with existing-value preservation
- Cycle 03 introduced no schema changes.
- Lists and History analytics are read-time service/read-model changes, not persistence changes.

## Validation Model

- Operational validation proceeds in layers:
  - compile/syntax validation
  - database initialization/migration validation
  - schema inspection when persistence changes exist
  - service-level read/write validation
  - import/startup validation
  - manual interactive UI validation
- Product View has compile/database/service/startup evidence and Cycle 02 manual operational confirmation.
- History and Settings have compile/database/service/startup evidence and Cycle 02 manual operational confirmation.
- Lists and History analytics have Cycle 03 compile/database/service/import/offscreen startup evidence.
- Manual validation is still required for specific Cycle 03 interaction paths:
  - receipt save refresh behavior
  - Lists double-click in every internal view
  - History analytics frame interaction
  - Settings store save after the Lists remodel
  - Product View behavior after Lists navigation
- Automated Qt smoke tests are a possible future validation layer but are not yet standard coverage.

## Known Operational Boundaries

- Average price is derived for Product View and is not currently a cached product field.
- Latest price and delta price shown in Lists are global per product, not store/frame scoped.
- Date calculations assume stored data can be parsed by supported date handling.
- Unsupported date formats are reported, not automatically repaired.
- Invalid analytics date input is not yet surfaced as explicit UI validation feedback.
- Settings persistence must not be confused with completed UI behavior when a persisted key is not yet consumed.
- `pages.order` remains persisted but inert for tab ordering.
- Mobile preparation currently means platform-neutral service/read-model boundaries, not mobile implementation.
