# I_DSN_CODEX - Cycle 07 Sprint 04 Design Codex Report

> Status: Windows local vertical slice materialized
> Branch: `cycle-07-mobile-preparation`
> Source stage: `F_DSN_STAGE.md`
> Date: 2026-07-12

## Implemented Topology

```text
clients/markei_flutter/
├── lib/
│   ├── app/
│   │   ├── markei_app.dart
│   │   ├── markei_composition.dart
│   │   └── pages/
│   ├── application/
│   │   ├── catalogue_queries.dart
│   │   ├── purchase_history.dart
│   │   └── register_purchase.dart
│   ├── domain/
│   └── infrastructure/local/
├── test/
│   ├── app/
│   ├── contracts/
│   ├── domain/
│   └── infrastructure/
├── android/
├── ios/
└── windows/

contracts/shared_beta/v2/
```

## Schema And Migration

- Drift schema version is now 2.
- `products` gained Product-code and display columns.
- Product uniqueness is account-scoped by normalized Product code and exact identity key.
- `sync_events` uniqueness is account/device/sequence scoped.
- `migration_ledger` records from/to version and migration ID.
- v1 to v2 migration adds new columns, backfills legacy Product codes, preserves existing Product IDs, and records `v1-to-v2-product-code-display`.
- Migration test creates a v1 database, opens it through v2 Drift, verifies backfill/ledger, closes, and reopens.

## Dependencies

- Runtime added: `unorm_dart`.
- Dev added: `json_schema`.
- Existing Drift/build dependencies retained.
- Visual Studio Build Tools 2022 installed/modified on the host for Windows build validation.

## Boundary Decisions

- Domain remains independent of Flutter widgets, Drift, Python, HTTP, and platform APIs.
- Widgets call application/repository ports and do not issue SQL.
- Local persistence remains a fresh Flutter database and does not access the Cycle 06 SQLite database.
- Synchronization remains event/queue preparation only; no networking or cloud sync exists.
- JSON Schema provides structural validation only; Dart tests carry semantic invariants.

## Implemented Surface

- Product normalization v2.
- Product-code value object.
- Product reference model for new/existing Product references.
- Local query repository for catalogue warnings and purchase history.
- Local composition root.
- Multi-item Purchase page.
- History page.
- Contract validation test suite.
- Device sequence and migration tests.
- Windows buildable Flutter desktop app.

## Validation Evidence

- `flutter pub get`: passed.
- `dart format --output=none --set-exit-if-changed .`: passed.
- `flutter analyze`: passed.
- `flutter test`: passed, 21 tests.
- `flutter build windows`: passed.
- Windows startup smoke: built `markei.exe` remained running after 5 seconds.
- `python -m unittest discover -s tests`: passed, 5 tests.

## Deviations And Host Limits

- Visual Studio Community 2022 was incomplete/canceled; Build Tools 2022 was installed and used for Windows validation.
- Android build was skipped because no Android SDK is installed and Android tooling installation is prohibited.
- iOS remains unvalidated on this Windows host.
- Manual human UI acceptance remains required.

## Deferred By Scope

TypeScript, API, Postgres, Neon, authentication, authorization, real synchronization, central catalogue identity, Product-code editing, legacy import, PySide6 retirement, merge/alias, deletion/edit workflows, and full Purchase UI remain out of scope.
