# Operational TODO

## Product View Follow-Up

- Manually verify double-click navigation from Storage into Register Product View.
- Manually verify double-click navigation from Shortage into Register Product View.
- Manually verify double-click navigation from Market into Register Product View.
- Confirm lower Register Product View displays product name, brand, ID, average price, store/latest price, last purchases, and expiration fields.
- Confirm Register still supports receipt registration with and without optional expiration date.
- Confirm existing purchase rhythm remains stable after UI usage: `average_duration_days` and `expected_next_purchase` must not be replaced by shelf-life values.
- Confirm shelf-life rhythm appears separately: `average_shelf_life_days` and `expected_expiration_date`.
- Verify older purchases without expiration dates render safely with blank/placeholder expiration values.

## Validation Gaps

- Full interactive desktop UI validation remains incomplete.
- GUI startup was validated only to the Qt event loop without traceback.
- Date-format compatibility should be checked with older seed or manually edited historical data.

## Deferred Operational Items

- Store address editing UI is deferred to a later store-management milestone.
- Decide later whether any automated UI smoke test is worthwhile for PySide6 behavior.
- Monitor whether Product View read model needs additional regression coverage after further UI changes.
