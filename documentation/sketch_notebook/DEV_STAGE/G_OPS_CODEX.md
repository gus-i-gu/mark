# G_OPS_CODEX - Closure Diagnostics Evidence

> Unit: C10-MCG02-CLOSURE-DIAGNOSTICS_20260721
> Starting SHA: 837028c2e312d9e902decf0ccd0b6377fd6718e3
> Required ancestor: bf78a3908ad05b3e7a0decc197fa2f99970059f1
> Final SHA: recorded in Codex terminal response after commit creation
> Result: C10_MCG02_CLOSURE_DIAGNOSTICS_IMPLEMENTED

## Scope And Cause

Closure previously exposed only one transient action/result string, so a human/provider failure with no hosted commit could not be localized to authentication, enrollment, local queue, Device sequence, transport, or terminal Sync phase from the client.

The selected architecture was implemented as a local-only diagnostic surface:

- `NativeClosurePage` renders immutable diagnostic view models;
- `NativeAuthClosureRunner` owns commands and user-initiated Sync attempt instrumentation;
- `ClosureDiagnosticsQuery` and `SyncAttemptRecorder` are application ports;
- `DriftClosureDiagnosticsRepository` performs scoped local reads, redaction, ordering, bounding, ledger writes and history clearing.

No provider access, provider Sync retry, deployment, server API change, event contract change, Settings merge, telemetry or export was performed.

## Changed Paths

- clients/markei_flutter/lib/application/closure_diagnostics.dart
- clients/markei_flutter/lib/app/markei_composition.dart
- clients/markei_flutter/lib/app/native_auth_closure_runner.dart
- clients/markei_flutter/lib/app/pages/native_closure_page.dart
- clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
- clients/markei_flutter/lib/infrastructure/local/local_database.dart
- clients/markei_flutter/lib/infrastructure/local/local_database.g.dart
- clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
- clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart
- clients/markei_flutter/test/infrastructure/local_database_migration_test.dart
- clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

Pre-existing unrelated tracked change preserved and not staged by this unit:

- .gitignore

## Schema And Migration

- Drift schema version increased from 8 to 9.
- Added local-only `sync_attempts` table.
- Added forward migration `v8-to-v9-sync-attempt-ledger`.
- Fresh database ledger marker changed to `create-v9`.
- Drift generated output was regenerated.
- Migration test proves v8-to-v9 creates an empty attempt ledger without resetting Device, pending queue or hosted-auth state.

The attempt ledger stores only:

- local integer ID;
- Account/environment scope;
- start/completion timestamps;
- bounded phase;
- stable result code;
- outcome class;
- sanitized recovery code.

It does not store tokens, Auth0 subjects, complete UUIDs, provider hosts, request/response bodies, payload JSON, SQL, filesystem paths, stack traces or raw exception messages.

## Focused Evidence

Command:

```text
flutter test test\infrastructure\closure_diagnostics_repository_test.dart test\app\native_closure_diagnostics_test.dart test\infrastructure\local_database_migration_test.dart
```

Result: passed, 19 tests.

Named evidence included:

- snapshot is scoped, ordered, bounded and redacted;
- clear history preserves queue, Device, binding and cursor state;
- Closure renders signed-out empty diagnostics;
- Closure renders enrolled pending failed unknown and history;
- Refresh diagnostics is local only and does not invoke Sync;
- Clear diagnostic history is confirmed and scoped to attempts;
- runner records auth-required Sync terminal outcome once;
- runner records no-new-events Sync terminal outcome once;
- runner records completed Sync terminal outcome once;
- runner records unavailable Sync terminal outcome once;
- runner records interrupted Sync terminal outcome once;
- migrates v8 database to v9 attempt ledger without reset.

Repository snapshot evidence:

- scoped Account A counts: pending 13, failed 12, unknown 0;
- cross-Account event excluded;
- recent attempts bounded to 20 newest rows;
- actionable events bounded to 20 newest rows;
- Device and event summaries use eight-character fingerprints, not full UUIDs;
- last successful Sync timestamp came only from local successful attempt ledger evidence.

## Full Validation

- `flutter pub run build_runner build --delete-conflicting-outputs`: passed; warning noted that the option was ignored by current build runner.
- `dart format --set-exit-if-changed lib test`: passed, 88 files, 0 changed.
- `flutter analyze`: passed with no issues.
- `flutter test`: passed, 147 passed and 4 lab-only skipped.
- `flutter build apk --debug`: passed; existing Auth0 Kotlin Gradle Plugin warning observed.
- `flutter build windows --release`: first run failed while a local `markei` process was running and locking build output; after stopping only process `18708`, rerun passed and built `build\windows\x64\runner\Release\markei.exe`; existing Boost CMP0167 warning observed.
- `npm run format:check` in `services/markei_sync_api`: passed.
- `npm run lint` in `services/markei_sync_api`: passed.
- `npm run typecheck` in `services/markei_sync_api`: passed.
- `npm test` in `services/markei_sync_api`: passed, 46 tests.
- `npm run build` in `services/markei_sync_api`: passed.
- `git diff --check`: passed.

## Privacy And Boundaries

- No Auth0, Render or Neon endpoint was accessed or mutated.
- No provider credential, connection string, token file, Auth0 subject, human Drift database, private operational file, provider Sync attempt, deployment, reenrollment or Device B enrollment was used.
- Diagnostics refresh is local-only and does not invoke transport or synchronization.
- Clear diagnostic history deletes only `sync_attempts` rows for the active Account/environment scope.
- The pre-implementation provider attempt is not synthesized into the new ledger; empty history displays `No locally recorded attempt history`.

## Residual Risks

- Provider/runtime acceptance against the human Windows database remains outside this commit.
- Docker-backed HTTP/PostgreSQL lab tests remained skipped because `MARKEI_RUN_SYNC_LAB=1` was not enabled for this UI/diagnostics unit.
