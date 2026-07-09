# Operational TODO

## Completed In Cycle 02

- History page implemented and manually validated as functional.
- Settings page implemented and manually validated as functional.
- Store editing through Settings implemented.
- Store editing updates confirmed across pages.
- Register confirmed operational after Cycle 02.
- Product View confirmed operational after Cycle 02.
- Product View regression check completed through service read model.
- Inventory status regression check completed.
- History first-Wednesday operational month behavior validated at service level.
- Wednesday week bucketing validated at service level.
- SQLite-backed settings persistence validated.
- Settings table migration validated without destructive reset.

## Remaining TODO

- Investigate store update through Register.
- Investigate multi-store History totals.
- Decide whether Cycle 03 should make MainWindow consume persisted `pages.order`.
- Add/perform deeper manual UI QA for multi-store History rendering.
- Add/perform deeper manual UI QA for Settings store editing after further changes.
- Continue checking History behavior with older or manually edited date formats.
- Keep Product View double-click workflow in regression checks when MainWindow/refresh wiring changes.

## Validation Gaps

- Terminal validation launched the Qt event loop but did not fully automate UI interaction.
- Multi-store aggregate semantics need more evidence.
- Store update through Register has not been verified.
- `pages.order` persistence is validated, but visible page sorting behavior is deferred.
- Unsupported historical date formats are reported through `unparsed_rows` but not repaired.

## Deferred Operational Items

- Store deletion remains deferred until referential behavior is explicitly designed.
- Full tab/page sorting behavior from persisted settings remains deferred.
- Broader History configuration UI remains deferred; current UI exposes implemented defaults.
- Automated PySide6 interaction testing remains optional future work.
