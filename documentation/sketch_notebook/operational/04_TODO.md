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

## Completed In Cycle 03

- Public inventory navigation consolidated into `Lists`.
- Public tabs changed to Register / Lists / History / Settings.
- Former Storage/Shortage/Market meanings moved into internal Lists views.
- Lists default hybrid all-products view implemented.
- Lists 10-column shared row shape implemented with Price and Δ Price.
- Service-level Lists read model implemented.
- History analytics embedded in HistoryPage.
- Service-level History analytics read model implemented.
- Compatibility navigation helpers preserved for Storage/Shortage/Market routes.
- No schema changes introduced for Lists or analytics.
- Compile, database smoke, service smoke, History smoke, analytics smoke, import, and offscreen startup validation passed.

## Remaining TODO

- Perform full manual UI QA for Register, Lists, History analytics, Settings, and Product View double-click/edit flow.
- Validate Lists double-click behavior in every internal view.
- Validate receipt save refreshes Lists and History in real UI interaction.
- Add explicit invalid analytics date input handling instead of treating invalid text as an omitted boundary.
- Review same-day average timelapse behavior because dense same-day purchases can produce sub-day averages.
- Decide when old `storage_page.py`, `shortage_page.py`, and `market_page.py` files should be removed or retained as transitional reference.
- Consider automated Qt smoke tests that instantiate core widgets without entering the full event loop.
- Continue checking History behavior with older or manually edited date formats.
- Validate multi-store analytics totals with richer manual fixture data.
- Continue mobile-prep validation by checking that new read models remain platform-neutral and not PySide-specific.

## Validation Gaps

- Manual interactive UI validation was not completed by Codex beyond offscreen startup/tab verification.
- Analytics invalid date input currently falls back to an omitted boundary.
- Same-day purchase-heavy data can make frame average timelapse less than one day; semantics need review.
- Multi-store aggregate analytics need more evidence.
- Old inventory page files remain in the repository while no longer mounted as public tabs.
- Automated PySide6 interaction testing remains future work.

## Deferred Operational Items

- Store deletion remains deferred until referential behavior is explicitly designed.
- Full tab/page sorting behavior from persisted `pages.order` remains deferred.
- Broader History configuration UI remains deferred; current UI exposes implemented defaults plus Cycle 03 analytics frame controls.
- Store editing through Register remains deferred; Register remains purchase-entry-only.
- Mobile implementation remains deferred; Cycle 03 only preserved service/read-model readiness.
- Store/frame-scoped price delta remains deferred.
