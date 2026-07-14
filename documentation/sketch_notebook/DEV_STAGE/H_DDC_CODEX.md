# H_DDC_CODEX — Cycle 09 Didactic Evidence

> Sequence: FLX-ORD-01
> Unit: C09-U02
> Status: Codex evidence only; no KANBAN maturity change

## Vocabulary Implemented

- Navigation now presents Home, Lists, Purchase, History, Catalogue, Analytics (PIN), Household (PIN), Guide, Documentation, and Settings.
- `Catalogue` names the Product destination; `Product details` is shown without exposing UUIDs or Drift rows.
- Settings uses `People`, `Person`, `Payment Methods`, `Payment Method`, `Nickname`, `Active`, `Archived`, and archived labels in History.
- Purchase keeps PACKAGED language as Package quantity and Packages bought.
- BULK hides Packages bought and treats package count as not applicable.
- Quantity accepts `kg`, `g`, `L`, `ml`, and `un`; tests cover comma/point input and COUNT fractional rejection.
- Lists language uses Storage, Shortage, Market, All, Not enough history, Estimate, Approximate, and Based on your history.
- History actions use Move to Analytics, Export CSV, Share list (PDF), Edit, and Delete, with planned actions disabled.

## Semantic Behavior Preserved

- Product UUID, visible Product code, and exact identification remain separate concepts.
- Exact code/identity lookup is separate from advisory similarity.
- Similarity still does not merge Products automatically.
- Product facts remain distinct from Purchase Item facts.
- Editing a staged Item preserves the original ProductReference and label while changing Item values.
- Existing Product ID retention and no duplicate Product creation are covered by widget regression.
- Person and Payment Method are local labels, not credentials.
- Purchase facts are distinct from personal Lists estimates.
- Export/share reads selected Purchases and does not mutate registered Purchase history.

## Error And Recovery Language

- Added typed `AppFailure` with code, operation, field, recovery, retryability, and known/unknown outcome.
- Registration failures preserve drafts and avoid raw database exceptions in UI copy.
- Known rollback language distinguishes not-applied failures from unknown outcomes.
- Missing Store/Product/reference and Product code collision now have typed recovery paths.

## Tests And Evidence

- `test/domain/quantity_display_test.dart` covers comma/point parsing, `un`, and fractional COUNT rejection.
- `test/app/markei_app_test.dart` covers Home-first navigation, responsive shell, existing Product staged edit identity preservation, Catalogue creation/search, History detail, and History state separation.
- `test/application/lists_and_export_test.dart` covers `personal-cycle-v1`, view classification, deterministic CSV, and PDF bytes.
- `test/local_purchase_repository_test.dart` covers aggregate rollback, file reopen, sync envelope, and archived Person label preservation.
- `test/infrastructure/local_database_migration_test.dart` covers fresh v3, v1 migration, v2-to-v3 file-backed migration, and reopen.

## Evidence Limits

- This report does not update KANBAN maturity or permanent Didactic memory.
- Tests prove implemented behavior, not learner maturity.
- Platform smoke does not prove complete manual runtime acceptance.
- Android behavior remains unvalidated because the host lacks Java.
