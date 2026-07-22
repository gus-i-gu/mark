# G_OPS_CODEX

Authority marker: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722

Baseline HEAD: 22261751f2ef86a4a494a7748886d27211044fc0
Required ancestor: 5b364216375514f9e43bd58c265fbabf8000c2f8 confirmed ancestor of HEAD.
Final commit SHA: reported by Codex final response after commit.

Operational result: local reproduction identified a project-owned server cause and materialized a bounded correction. No Auth0, Render, Neon, provider credential file, human database, human unresolved submission retry, deployment or provider Sync was accessed or executed.

Exact cause:
- Protected submission accepted authentication/request shape and entered the Sync application path.
- With a valid Account/Device but no `account_cursor_state` row, the service updated zero cursor rows and then dereferenced the absent returned row.
- That unhandled server exception produced HTTP 500 and no durable submission/event/cursor/acknowledgement rows.
- The request-failed lifecycle event could report pre-error status 200 while the final response was 500.

Changed paths:
- clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
- clients/markei_flutter/lib/domain/sync/sync_event.dart
- clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart
- clients/markei_flutter/test/infrastructure/http_sync_transport_device_header_test.dart
- services/markei_sync_api/src/application/sync_service.ts
- services/markei_sync_api/src/http/app.ts
- services/markei_sync_api/test/protocol.test.ts
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

Pre-existing unrelated dirty path preserved and not staged: `.gitignore`.

Reproduction and correction evidence:
- Added failing regression before correction: protected submission with synthetic Account/Device and no cursor-state row returned 500 before the fix.
- After correction: same fixture returns HTTP 503 with bounded `service-unavailable`, `upload-submission`, `not-applied`, retryable false.
- No synthetic fixture insert into hosted events or submissions occurs when cursor state is missing.
- Unexpected protected-route exceptions still return final HTTP 500 but request-failed no longer carries successful status 200.
- Flutter transport now preserves observed `service-unavailable` protocol failures as `SyncStatusCode.serviceUnavailable`, distinct from timeout/unknown.

Validation:
- `git fetch origin`: passed.
- `git pull --ff-only origin intermid-cycle-recovery`: already up to date.
- `git merge-base --is-ancestor 5b364216375514f9e43bd58c265fbabf8000c2f8 HEAD`: passed.
- Pre-fix focused API regression: failed as expected with 500 instead of expected 503.
- `npm test -- --test-name-pattern "protected submission fails closed when account cursor state is missing"`: 50 passed after correction.
- `npm test -- --test-name-pattern "protected submission|unexpected protected submission"`: 51 passed.
- `npm test`: 51 passed.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm run build`: passed.
- `dart format --set-exit-if-changed lib test`: final run passed, 0 changed.
- `flutter test test/infrastructure/http_sync_transport_device_header_test.dart`: 2 passed.
- `flutter analyze`: passed, no issues.
- `flutter test`: 178 passed, 4 lab-gated skips; existing Drift multiple-database warnings observed.
- `MARKEI_RUN_SYNC_LAB=1 flutter test test/sync/real_convergence_harness_test.dart`: 3 passed; disposable PostgreSQL/HTTP convergence, ordered outbox and recovery orchestration proofs passed.
- `MARKEI_RUN_SYNC_LAB=1 flutter test test/sync/real_recovery_harness_test.dart`: 1 passed; disposable recovery proof passed.
- `python -m pytest tests/test_release_configuration.py`: unavailable, pytest not installed.
- `python -m unittest tests.test_release_configuration`: 5 passed.
- `flutter build apk --debug`: passed; existing auth0_flutter Kotlin Gradle Plugin future-compatibility warning observed.
- `flutter build windows --release`: passed; existing Boost/CMake CMP0167 developer warning observed.
- `git diff --check`: passed; Git emitted line-ending warnings only.

Residual operational risks:
- Provider success and MCG-02 closure are not claimed.
- The human provider retry remains pending.
- No PostgreSQL migration was added because the proved correction is runtime failure handling for missing account cursor state, not a schema-shape change.
