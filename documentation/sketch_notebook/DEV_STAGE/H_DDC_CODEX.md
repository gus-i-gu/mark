# H_DDC_CODEX — Cycle 09 Sprint 02 Didactic Evidence

> Sequence: FLX-ORD-01
> Unit: C09-S02
> Status: Codex evidence only; no KANBAN maturity change

## Vocabulary Implemented

- Compact navigation now says Home, Lists, Purchase, History, More.
- Expanded navigation keeps the visible destinations, including disabled/planned Analytics and Household.
- People and Payment Methods render as `code · nickname`.
- Archived reference labels render as `code · nickname (archived)`.
- Product code is presented as required and immutable in Purchase.
- Purchase date and Time are visible as the buying moment, not insertion time.
- Purchase date helper uses `dd/mm/yyyy`; Time helper uses `HH:mm`.
- Purchase Product-code lookup says Product facts are filled and the user must still add a staged Item.
- BULK language uses Amount bought, Unit, Price per selected unit, and Calculated line total.
- Lists now distinguishes `No Purchase history` from `Not enough history`.
- History keeps selected-only CSV/PDF language and disabled Edit/Delete/Move to Analytics.

## Semantic Distinctions Preserved

- UUID remains separate from visible reference code and nickname.
- Product code remains separate from Product identity and advisory similarity.
- Product selection, Product details, and Add staged Item remain separate actions.
- Exact Product-code lookup does not automatically stage an Item.
- Purchase buying moment is separate from row creation time.
- BULK price-per-unit input is used only to calculate line total; no competing unit-price truth is persisted.
- Registered Purchase history is not edited or deleted.
- Lists estimates are not described as measured inventory.
- Implementation evidence in G/H/I is not semantic promotion.

## Recovery And Failure Language

- Invalid Purchase date reports the exact date format.
- Invalid Purchase time reports the exact time format.
- Unknown or failed Purchase registration preserves the draft and does not claim success.
- Product-code miss tells the user to check details or create a new Product.
- Native share is not silently implied; PDF output remains deterministic file generation.

## Tests And Evidence

- Purchase occurrence tests cover exact local civil parsing and UTC conversion boundary.
- BULK tests cover selected-unit calculation, comma decimal input, and mixed-unit rejection.
- Repository regression proves existing Product ID retention and no duplicate Product creation after Item values change.
- Widget tests cover Purchase registration, staged edit behavior, compact navigation, destination survival, Catalogue creation/search, History selection/detail, and empty/error states.
- Migration tests cover fresh v4, chained v1/v2 to v4, reserved legacy code backfill, and file-backed reopen.

## Evidence Limits

- No KANBAN maturity change was made.
- No permanent Didactic memory was changed.
- Native OS share language remains deferred/blocked because no native share dependency was adopted.
- Full manual accessibility and screen-reader validation were not run.
