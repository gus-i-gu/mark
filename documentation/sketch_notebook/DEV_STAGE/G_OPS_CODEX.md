# G_OPS_CODEX - Persistent Purchase Transaction Diagnostic Evidence

- Authority marker: C10-MCG02-PURCHASE-TRANSACTION-DIAGNOSTIC_20260720T205714Z
- Branch: intermid-cycle-recovery
- Baseline HEAD before diagnostic: 3bad6f819776094a0e621231c2bee3d4a252a1ff
- Final commit SHA: self-referential Git SHA is reported in the Codex terminal response.
- Provider/private data access: none. No Auth0, Render, Neon, credential, provider file, private helper file, human database, real Enroll, Query or Sync endpoint was accessed.

## Changed Paths

- `clients/markei_flutter/lib/application/app_failure.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`
- `clients/markei_flutter/test/local_purchase_repository_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Preserved untracked private files:

- `clients/markei_flutter/Exact Auth0 API audience`
- `clients/markei_flutter/Windows Native Application Client ID`

## Reproduction Topology

Added a disposable file-backed Drift fixture in `local_purchase_repository_test.dart`:

1. creates a supported historical v2 schema;
2. seeds a local Account, legacy local Device, Store, Product, one historical Purchase, one local pending event, one pre-existing hosted-device event, SyncState cursor and migration ledger;
3. opens through `LocalDatabase` so production migration upgrades to schema v7;
4. saves a valid hosted binding through `DriftHostedIdentityRepository`;
5. calls `ensureLocalHostedIdentity` through the existing application port;
6. closes and reopens;
7. lists the migrated Store/Product through `LocalQueryRepository`;
8. attempts registration through `LocalPurchaseRepository`;
9. closes and reopens;
10. verifies History, Purchase, event, outbox, cursor and Device sequence state.

## First Failing Phase

The first closed failing phase is:

~~~text
purchase-registration-insert-purchase-failed
~~~

The underlying synthetic fixture cause is a migrated schema defect: after v2-to-v7 migration, `purchases` still has foreign keys to dropped `people_old` and `payment_methods_old`; `purchase_items` also retains a foreign key to dropped `products_old`. A direct schema inspection of the disposable fixture confirmed those references. New Purchase insertion fails before any new Purchase row is committed.

This matches the human evidence boundary: explicit Store selection succeeds, an Item is staged, registration reports failure, and the Purchase is absent from History. Absence from History is therefore `not-applied`, not an unknown successful commit.

## Materialized Diagnostics

- `LocalPurchaseRepository.registerPurchase` now tracks closed phases: `ensure-account`, `ensure-sync-state`, `ensure-device`, `resolve-store`, `resolve-references`, `resolve-product`, `build-purchase`, `insert-purchase`, `insert-items`, `allocate-sequence`, `serialize-event`, `insert-event`, `insert-outbox`.
- Typed `AppFailure` is preserved and rethrown unchanged.
- Unexpected failures become `purchase-registration-<phase>-failed` with `FailureOutcome.notApplied`.
- `AppFailure.debugCause` retains the original exception only in memory for tests; `userMessage` and `toString()` remain sanitized.
- Existing Store selection and draft-preservation behavior is unchanged.

No schema repair was applied because D/E/F prohibit a Drift schema migration and F states that a cause needing one must stop for Main restaging.

## Commands and Results

- `git branch --show-current`: `intermid-cycle-recovery`.
- `git fetch origin`: passed.
- `git pull --ff-only`: passed; already up to date.
- `git merge-base --is-ancestor 3bad6f819776094a0e621231c2bee3d4a252a1ff HEAD`: passed.
- `git merge-base --is-ancestor bf824cea0648202cf9e04ad98553239c00dab6e0 HEAD`: passed.
- `git status --short --branch`: clean tracked state before editing; two private untracked provider-note files preserved.
- Methodology and stage boot reads completed for root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, current J/D/E/F.
- `flutter test test/local_purchase_repository_test.dart --name "migrated hosted lifecycle registers after pre-existing sequence and cursor state"` before final test adjustment: failed with `AppFailure(purchase-registration-insert-purchase-failed, Purchase registration)`.
- Disposable fixture schema inspection: confirmed `purchases` foreign keys to `payment_methods_old` and `people_old`, and `purchase_items` foreign key to `products_old`.
- `flutter test test/local_purchase_repository_test.dart`: passed, 12 tests.
- `flutter test test/app/markei_app_test.dart`: passed, 20 tests.
- `flutter test test/infrastructure/local_database_migration_test.dart`: passed, 4 tests.
- `flutter analyze`: passed, no issues.
- `dart format --set-exit-if-changed lib test`: passed, 83 files, 0 changed.
- `flutter test`: passed, 116 tests and 2 existing disposable lab skips; retained existing Drift multi-database debug warnings in sync tests.
- `flutter build apk --debug`: passed; built `build\app\outputs\flutter-apk\app-debug.apk`; retained existing Auth0 Flutter Kotlin Gradle Plugin warning.
- `flutter build windows --release`: passed; built `build\windows\x64\runner\Release\markei.exe`; retained existing Boost CMP0167 developer warning.
- `git diff --check`: passed.
- Diff secret scan: no matches for credential assignments, connection strings, provider URLs, API keys, or authorization header values.
- Changed-path artifact scan: no changed binary, APK, database, provider artifact or generated credential file.

No TypeScript/API regression was required because no shared server contract, API, event version or authorization path changed.

## Counts and Evidence

For the migrated failure fixture after attempted registration:

- History remains 1 existing Purchase.
- `purchases` remains 1.
- `sync_events` remains 2.
- `pending_events` remains 2.
- SyncState cursor remains `cursor-before-hosted-purchase`.
- Hosted server Device `nextSequence` remains 1.
- The hosted binding remains loadable.

The transaction is not applied and does not advance sequence, event or outbox state.

## Exclusions

No provider resources, private database, production resources, Drift schema migration, PostgreSQL migration, API/event/protocol change, dependency upgrade, UI redesign, deployment, permanent documentation, MCG-03 or MCG-04 work was performed.

## Terminal

~~~text
C10_MCG02_PERSISTENT_PURCHASE_TRANSACTION_PARTIAL
~~~

Blocker: the reproduced root cause is a malformed migrated Drift schema requiring an authorized schema repair/restaging. Safe phase diagnostics are ready for one human retest; the expected surfaced code is `purchase-registration-insert-purchase-failed` if the human database has the same migrated-schema defect.
