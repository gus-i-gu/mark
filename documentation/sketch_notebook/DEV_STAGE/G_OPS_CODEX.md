# G_OPS_CODEX - Hosted Binding and Scoped Sync Evidence

- Authority marker: C10-MCG02-HOSTED-BINDING-R2_20260720T131954Z
- Branch: intermid-cycle-recovery
- Baseline after fast-forward: 9e7af2e306a5159eb51eba9169f5fe0c5f60b5e7
- Required ancestor confirmed: 9e7af2e306a5159eb51eba9169f5fe0c5f60b5e7
- Pre-report implementation tree: 277e44d199748fee60e88153fe9abae9cc1cb603
- Final commit SHA: resolved after commit; Codex terminal response reports it.
- Provider access: none. No Auth0, Render, Neon, provider credential, token, connection string, real Enroll, Query or Sync endpoint was accessed.

## Changed Paths

- `clients/markei_flutter/lib/app/markei_composition.dart`
- `clients/markei_flutter/lib/app/native_auth_closure_runner.dart`
- `clients/markei_flutter/lib/application/hosted_auth_ports.dart`
- `clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart`
- `clients/markei_flutter/lib/infrastructure/local/hosted_identity_repository.dart`
- `clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart`
- `clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_event_applier.dart`
- `clients/markei_flutter/test/infrastructure/flutter_http_file_backed_proof_test.dart`
- `clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart`
- `clients/markei_flutter/test/infrastructure/http_device_enrollment_transport_file_test.dart`
- `clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart`
- `clients/markei_flutter/test/infrastructure/native_closure_sync_path_test.dart`
- `clients/markei_flutter/test/sync/real_convergence_harness_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Preserved untracked files:

- `clients/markei_flutter/Exact Auth0 API audience`
- `clients/markei_flutter/Windows Native Application Client ID`

## Commands and Results

- `git branch --show-current`: `intermid-cycle-recovery`.
- `git fetch origin`: passed; remote advanced to `9e7af2e`.
- `git pull --ff-only`: passed; fast-forwarded from `4382c09` to `9e7af2e`.
- `git merge-base --is-ancestor 9e7af2e306a5159eb51eba9169f5fe0c5f60b5e7 HEAD`: passed.
- `git status --short --branch`: showed only two preserved untracked provider-note files before editing.
- Methodology and stage boot reads completed for root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, J/D/E/F and previous G/H/I.
- `dart format ...`: passed after formatting edited files.
- First `flutter test test/infrastructure/hosted_identity_repository_test.dart test/infrastructure/native_closure_sync_path_test.dart`: failed at compile expectations during implementation; corrected.
- Final focused hosted tests: passed, 9 tests.
- `flutter analyze`: passed, no issues.
- `flutter test test/infrastructure/native_auth_composition_test.dart test/app/native_closure_surface_test.dart`: passed, 19 tests.
- First `dart format --set-exit-if-changed lib test`: failed because it formatted `lib/application/hosted_auth_ports.dart`.
- Final `dart format --set-exit-if-changed lib test`: passed, 82 files, 0 changed.
- `flutter test`: passed, 93 tests and 2 expected skipped disposable lab tests.
- `npm test` in `services/markei_sync_api`: passed, 46 tests.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm run build`: passed.
- `flutter build apk --debug`: passed; built `build\app\outputs\flutter-apk\app-debug.apk`; retained existing Auth0 Flutter Kotlin Gradle Plugin warning.
- `flutter build windows --release`: passed; built `build\windows\x64\runner\Release\markei.exe`; retained existing Boost CMP0167 developer warning.
- `$env:MARKEI_RUN_SYNC_LAB='1'; flutter test test/sync/real_convergence_harness_test.dart`: passed, 1 test; printed `CONVERGED=true`; disposable Docker/PostgreSQL lab was torn down.
- `git diff --check`: passed.
- `git diff --name-only`: listed only changed source/test/report paths.
- Tracked generated/binary scan: found pre-existing tracked desktop/package binaries under `app/database`, `build/Markei`, and `dist/`; no Flutter build output, APK, Windows runner output, database, provider artifact or new binary is tracked by this unit.
- Diff secret scan: no matches for token, bearer, password, PostgreSQL URL, provider secret, private key, Neon or Render patterns in the diff.

## Identity Fixtures and Evidence

- Hosted Account fixture: `11111111-1111-4111-8111-111111111111`.
- Hosted server Device A: `22222222-2222-4222-8222-222222222222`.
- Hosted server Device B: `33333333-3333-4333-8333-333333333333`.
- Foreign Account rejection fixture: `99999999-9999-4999-8999-999999999999`.
- Preserved local/foreign pending Device fixture: `bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb`.

Focused proof in `native_closure_sync_path_test.dart` verifies:

- scoped outbox returns no submission before hosted restart activation;
- successful hosted enrollment state is stored but enrollment reports `hosted-restart-required`;
- reopened file-backed Drift loads the exact hosted Account and server Device binding;
- new hosted purchase event embeds the exact hosted Account and server Device;
- `purchase.registered` v3 `contentHash` remains canonical and valid;
- older local-only pending work remains `pending` and is excluded;
- unknown submission replay is scoped and cannot be completed from another Device scope;
- cross-Account page returns conflict without purchases, inbox or cursor advance;
- hosted upload/download/apply/ack succeeds for the binding;
- close/reopen preserves hosted facts and inbox.

Docker/PostgreSQL real loopback proof in `real_convergence_harness_test.dart` verifies:

- scoped hosted upload uses the real lab API authorization path;
- one older pending event from a non-bound Device is preserved and excluded;
- server accepts exactly one hosted event;
- second Device downloads, applies and acknowledges through the real loopback API;
- reopened databases preserve two Device convergence evidence.

## Exclusions

- No Drift schema change or generated Drift source update was required.
- No PostgreSQL migration was added or edited.
- No dependency upgrade was performed.
- No real Auth0 login, Render/Neon access, provider mutation, provider Enroll, provider Query or provider Sync was performed.
- No permanent documentation, methodology, J/D/E/F, provider file, credential file, MCG-03 or MCG-04 work was performed.

## Terminal

~~~text
MCG-02_HOSTED_IDENTITY_BINDING=true
MCG-02_HOSTED_OUTBOX_SCOPED=true
MCG-02_HOSTED_CURSOR_APPLIER_SCOPED=true
MCG-02_LOCAL_ONLY_EVENTS_PRESERVED=true
MCG-02_TWO_DEVICE_BINDING_CONVERGED=true
MCG-02_DECISIVE_PROVIDER_PROOF_READY
~~~
