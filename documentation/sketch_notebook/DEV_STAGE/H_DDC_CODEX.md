# H_DDC_CODEX - Cycle 07 Sprint 04 Didactic Codex Report

> Status: Sprint 04 concept fixtures and executable evidence implemented
> Branch: `cycle-07-mobile-preparation`
> Source stage: `E_DDC_STAGE.md`
> Date: 2026-07-12

## Fixture Evidence

Created `contracts/shared_beta/v2/`:

- `catalogue_identity.schema.json`
- `catalogue_identity.json`
- `purchase_aggregate.schema.json`
- `purchase_aggregate.json`
- `sync_event.schema.json`
- `sync_event.json`
- `README.md`

The v2 examples distinguish user Product code, internal Product ID, semantic identity key, normalization version, warn-only similarity, Purchase aggregate totals, rollback expectations, close/reopen expectations, and `purchase.registered` payloadVersion 2.

## Concept Evidence Implemented And Tested

- User Product code is a user-facing account-local code with its own normalized key.
- Internal Product ID is immutable local UUID state and is not derived from semantic identity.
- Semantic Product identity normalizes name/brand/mode/package facts.
- Unicode normalization uses NFKC collapse for Product code and semantic text.
- PACKAGED products include measurement kind and canonical package quantity in identity.
- BULK products exclude package quantity from identity.
- Similarity warnings are advisory only and do not merge or reuse IDs.
- Device sequence increments monotonically across repeated registrations and rollback does not consume a sequence.
- Drift v1 to v2 migration backfills legacy Product-code/display columns and records migration ledger evidence.
- JSON Schema validates structural contract examples; Dart domain tests retain cross-field semantic responsibility.
- Multi-item Purchase UI stages local items and registers one aggregate transaction.
- Local history displays persisted Purchase summary from query ports.
- Widget test covers register and history display flow.

## Validation Evidence

- `flutter analyze`: passed, no issues.
- `flutter test`: passed, 21 tests.
- `flutter build windows`: passed.
- Windows launch smoke: executable remained running after startup.
- Python unittest suite: passed, 5 tests.

## Evidence Classification

- Implemented and tested: Product-code separation, Unicode normalization, sequence correction, v1 to v2 migration, v2 fixtures/schemas, contract validation, query ports, composition root, multi-item UI, local history, widget test.
- Implemented and host-validated: Windows build and smoke launch.
- Implemented but host-unvalidated: iOS generated target on Windows host.
- Blocked/deferred: Android build because Android SDK is unavailable and Android tooling installation is prohibited.
- Human-required: manual UI acceptance remains open.

## No Maturity Change

No permanent didactic maturity update is authorized or implied by this report.
