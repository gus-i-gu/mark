# I_DSN_CODEX — Cycle 09 Sprint 02 Design Evidence

> Sequence: FLX-ORD-01
> Unit: C09-S02
> Status: Architecture evidence only; not permanent Design memory

## Topology

- Preserved Flutter layering: app widgets call application ports/read models; repositories adapt Drift; domain owns Product/Purchase/quantity rules.
- Added SDK-first app design surface under `lib/app/design/` and reusable widgets under `lib/app/widgets/`.
- `MarkeiComposition` remains the dependency composition root.
- Generated Drift code remains derived from `local_database.dart`.
- Python/PySide6 application and protected database topology were not intentionally changed.

## Schema v4

- `Products.userProductCode` and `Products.normalizedUserProductCode` are database-level NOT NULL.
- People have immutable account-scoped `visibleCode` with `@` prefix.
- Payment Methods have immutable account-scoped `visibleCode` with `#` prefix.
- Account preferences hold `nextPersonCode` and `nextPaymentMethodCode` counters.
- Unique constraints enforce `(accountId, visibleCode)` for People and Payment Methods.
- Product code uniqueness remains account-scoped through normalized Product code.

## Migration Design

- v1/v2 migrations add Product-code columns as transitional nullable columns only.
- v4 rebuilds Products to enforce NOT NULL code columns.
- v4 backfills only missing/blank Product codes with reserved deterministic `legacy:` codes.
- v4 rebuilds People and Payment Methods to assign deterministic visible codes by account, creation time, and UUID.
- v4 rebuilds AccountPreferences to seed next-code counters from archived and active rows.
- Migration tests cover chained legacy paths and reopen.

## Application And Domain Design

- `purchase_occurrence.dart` owns exact date/time parsing and UTC conversion.
- `bulk_pricing.dart` owns fixed-point BULK line-total calculation.
- `LocalReference` owns `displayLabel` and archived history label composition.
- Product-code reservation is enforced in `product_code.dart`.
- Lists still uses the existing joined projection; zero-history language was refined.
- Local repositories allocate reference codes inside a Drift transaction.

## Presentation Design

- `markeiTheme()` defines cream/white surfaces, dark-green primary, and lavender secondary.
- Compact navigation maps to Home / Lists / Purchase / History / More.
- Expanded navigation keeps direct destination labels.
- Purchase keeps date/time after Store and preserves draft controllers through Review/Back.
- Product-code lookup fills immutable facts but leaves staging explicit.
- Catalogue tap selects; View details and double-click open details.
- History adds select-all and double-click details while keeping edit/delete disabled.

## Dependency Decisions

- No new dependency was added.
- Native share dependency was not adopted because dependency/platform validation was not completed safely in this pass.
- Existing dependency audit was recorded with `flutter pub outdated`.

## Invariants

- No Product auto-merge.
- No Product edit/merge/delete UI.
- No registered Purchase edit/delete.
- No authentication, cloud/API sync, Store redesign, Analytics implementation, Household implementation, dark mode, or production release expansion.
- No database error-description table.

## Deviations And Risks

- Native OS PDF sharing remains deferred; deterministic PDF bytes and file save behavior remain.
- UI foundation and target hierarchy improved but are not a complete mockup-level composition pass.
- Android build/runtime/share evidence is host-blocked by missing Java.
- Windows evidence is release build plus bounded smoke, not manual acceptance.
