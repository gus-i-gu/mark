# G_OPS_CODEX - Hosted Purchase Registration Correction Evidence

- Authority marker: C10-MCG02-HOSTED-PURCHASE-CORRECTION_20260720T193745Z
- Branch: intermid-cycle-recovery
- Baseline HEAD before correction: be0462a7de79de706420dbbeb9686f01579baed6
- Final commit SHA: resolved after commit; Codex terminal response reports it.
- Provider access: none. No Auth0, Render, Neon, provider credential, token, connection string, real Enroll, Query or Sync endpoint was accessed.

## Changed Paths

- `clients/markei_flutter/lib/app/markei_app.dart`
- `clients/markei_flutter/lib/app/pages/products_page.dart`
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/lib/application/catalogue_queries.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart`
- `clients/markei_flutter/test/app/markei_app_test.dart`
- `clients/markei_flutter/test/catalogue_store_repository_test.dart`
- `clients/markei_flutter/test/local_purchase_repository_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Preserved untracked files:

- `clients/markei_flutter/Exact Auth0 API audience`
- `clients/markei_flutter/Windows Native Application Client ID`

## Commands and Results

- `git branch --show-current`: `intermid-cycle-recovery`.
- `git fetch origin`: passed.
- `git pull --ff-only`: passed; already up to date.
- `git merge-base --is-ancestor a3d2c782584054fdd53a71a90aab0d8ead78e12f HEAD`: passed.
- `git status --short --branch`: clean tracked state before editing; two private untracked provider-note files preserved.
- Methodology and stage boot reads completed for root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, current J/D/E/F and latest G/H/I.
- `dart format ...`: passed during implementation.
- Focused Store/Purchase tests: `flutter test test/catalogue_store_repository_test.dart test/local_purchase_repository_test.dart test/app/markei_app_test.dart`: passed, 26 tests.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed, 106 tests and 2 existing disposable lab skips.
- `dart format --set-exit-if-changed lib test`: passed, 83 files, 0 changed.
- `flutter build apk --debug`: passed; built `build\app\outputs\flutter-apk\app-debug.apk`; retained existing Auth0 Flutter Kotlin Gradle Plugin warning.
- `flutter build windows --release`: passed; built `build\windows\x64\runner\Release\markei.exe`; retained existing Boost CMP0167 developer warning.
- Focused app rerun after diagnostic fixture correction: `flutter test test/app/markei_app_test.dart`: passed, 11 tests.
- `git diff --check`: passed.
- `git diff --name-only`: listed only changed Flutter source/test paths before G/H/I replacement.
- Diff secret scan: no real provider secret matches. One synthetic diagnostic fixture initially contained secret-shaped words and was corrected before final scan.
- Tracked binary/generated scan: found pre-existing tracked desktop/package binaries under `app/database`, `build/Markei`, and `dist/`; no Flutter build output, APK, Windows runner output, database, provider artifact or new binary is tracked by this unit.

No Drift schema or generated source changed. No TypeScript/API test was required because no shared server contract changed.

## Failure Reproduced and Diagnosed

The deterministic local reproduction boundary is the hosted-bound Purchase registration path with:

- hosted Account fixture `11111111-1111-4111-8111-111111111111`;
- hosted server Device fixture `22222222-2222-4222-8222-222222222222`;
- active `provider-native` binding state;
- existing packaged Product `ARROZ-001`;
- existing Store `Mercado Central`;
- one Purchase registration and one `purchase.registered` payload-version-3 pending event.

The correction identifies the local failure class as an Account-scoped catalogue relationship problem, not a provider or server authorization failure: Purchase registration could still attempt Store creation inline while Catalogue had no independent hosted Store surface, and production diagnostics collapsed typed failures into a generic message. Registration also used upsert semantics for local Account and SyncState rows, which could rewrite existing hosted/cursor state during purchase registration.

## Counts and Evidence

- Hosted-bound successful registration produced exactly 1 Purchase, 1 SyncEvent, and 1 PendingEvent.
- `purchase.registered` payload version remained 3 and the stored content hash revalidated from canonical JSON.
- Rollback test using a missing same-Account Store preserved 0 Stores, 0 Purchases, 0 PurchaseItems, 0 SyncEvents, 0 PendingEvents, and 0 Devices from the failed transaction.
- Close/reopen file-backed Drift preserved 1 Store, 1 Purchase, 1 SyncEvent, 1 PendingEvent, the active hosted binding, and Device sequence `2`.
- Local-only purchase registration still succeeded with 1 Purchase, 1 SyncEvent, and 1 PendingEvent.
- UI tests prove staged draft lines remain after typed and unexpected registration failures.

## Exclusions

- No provider resources were accessed or mutated.
- No PostgreSQL migration, Drift migration, generated Drift source, dependency, server authorization, event payload version, navigation architecture, Analytics, PIN, Settings, deployment, permanent documentation, MCG-03 or MCG-04 work was performed.

## Terminal

~~~text
C10_MCG02_HOSTED_PURCHASE_REGISTRATION_CORRECTED
~~~
