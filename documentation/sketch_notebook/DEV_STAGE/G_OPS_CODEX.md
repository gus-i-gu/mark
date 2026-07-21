# G_OPS_CODEX - Hosted Device Header Evidence

> Unit: C10-MCG02-HOSTED-DEVICE-HEADER-CORRECTION_20260721T124452Z
> Starting SHA: 59d4f944bfb7c34e1a67525902cdddfe4a4eb87b
> Final SHA: recorded in Codex terminal response after commit creation
> Result: HOSTED_DEVICE_HEADER_ALL_PROTECTED_ROUTES=true

## Git And Authority

- Branch confirmed: `intermid-cycle-recovery`.
- `git fetch origin`: passed.
- `git pull --ff-only origin intermid-cycle-recovery`: already up to date.
- Local HEAD equaled `origin/intermid-cycle-recovery` before editing.
- `git merge-base --is-ancestor 59d4f944bfb7c34e1a67525902cdddfe4a4eb87b HEAD`: passed.
- D/E/F all carried `C10-MCG02-HOSTED-DEVICE-HEADER-CORRECTION_20260721T124452Z`.
- D/E/F were mutually consistent and sufficient after the user's Git sequencing clarification.

## Changed Paths

- clients/markei_flutter/lib/app/markei_composition.dart
- clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
- clients/markei_flutter/lib/domain/sync/sync_event.dart
- clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart
- clients/markei_flutter/test/infrastructure/http_sync_transport_device_header_test.dart
- clients/markei_flutter/test/infrastructure/native_closure_sync_path_test.dart
- clients/markei_flutter/test/sync/local_sync_application_test.dart
- clients/markei_flutter/test/sync/real_convergence_harness_support.dart
- clients/markei_flutter/test/sync/real_convergence_harness_test.dart
- clients/markei_flutter/test/sync/real_recovery_harness_test.dart
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

## Implementation Evidence

- `HttpSyncTransport` now requires one hosted server Device ID at construction.
- Upload, download, acknowledgement, `startRecovery`, `queryRecovery`, `downloadChunk`, and `completeRecovery` all send `x-markei-device-id`.
- Production native hosted composition constructs `HttpSyncTransport` with `activeBinding.serverDeviceId`.
- Hosted composition fails closed without an active binding by retaining the existing guarded unavailable outcome and not constructing a usable transport.
- Protocol code `device-enrollment-required` is preserved as `SyncStatusCode.deviceEnrollmentRequired` and mapped to the existing hosted Device enrollment outcome.
- Authentication, correlation, timeout, JSON content negotiation, event identity, Device sequence, hashing, ordered outbox recovery, and server transaction behavior were not redesigned.
- No Drift migration, PostgreSQL migration, schema change, event renumbering, Device reenrollment, Device B enrollment, UI work, provider Sync, deployment, or human database edit was performed.

## Focused Assertions

Command:

```text
flutter test test\infrastructure\http_sync_transport_device_header_test.dart test\infrastructure\native_closure_sync_path_test.dart
```

Result: pass, 4 tests.

Focused coverage:

- transport sends `x-markei-device-id` on upload;
- transport sends `x-markei-device-id` on download;
- transport sends `x-markei-device-id` on acknowledgement;
- transport sends `x-markei-device-id` on start recovery;
- transport sends `x-markei-device-id` on query recovery;
- transport sends `x-markei-device-id` on recovery chunk download;
- transport sends `x-markei-device-id` on complete recovery;
- native closure hosted fixture rejects missing Device header with `device-enrollment-required`;
- native closure hosted fixture rejects wrong Device header with `device-enrollment-required` and performs no upload.

## Regression Evidence

Command:

```text
flutter test test\sync\local_sync_application_test.dart test\sync\real_convergence_harness_test.dart test\sync\real_recovery_harness_test.dart
```

Result: pass, 18 passed and 4 lab-only tests skipped.

Command:

```text
flutter test
```

Result: pass, 135 passed and 4 skipped.

Existing recovery/orchestration, convergence, Purchase/history, local-first, hosted binding, ordered outbox, typed server-code, and native closure paths remained passing.

## Validation Results

- `dart format` on changed Dart files: completed; repeated `--set-exit-if-changed` checks reported line-ending normalization on four files, while the applied formatting, analysis, and tests were stable.
- `flutter analyze`: passed with no issues.
- `npm run format:check` in `services/markei_sync_api`: passed.
- `npm run lint` in `services/markei_sync_api`: passed.
- `npm run typecheck` in `services/markei_sync_api`: passed.
- `npm test` in `services/markei_sync_api`: passed, 46 tests.
- `npm run build` in `services/markei_sync_api`: passed.
- `flutter build apk --debug`: passed; existing Auth0 Kotlin Gradle Plugin warning observed.
- `flutter build windows --release`: passed; existing Boost CMake CMP0167 warning observed.
- `git diff --check`: passed.

## Privacy And Teardown

- No Neon, Auth0, Render, provider credential, private provider file, or human Drift database was accessed.
- No disposable provider Sync attempt was performed.
- No tracked private database, binary package, credential, or provider artifact was intentionally added.
- Docker-backed sync lab tests remained skipped because `MARKEI_RUN_SYNC_LAB=1` was not enabled for this correction.
- Windows provider retest remains pending and human-controlled.
