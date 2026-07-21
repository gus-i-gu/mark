# G_OPS_CODEX - Unknown Recovery Evidence

> Unit: C10-MCG02-UNKNOWN-RECOVERY_20260721
> Starting SHA: 0832b1f32104fdfbd3b6f9e5d4978ef38915f695
> Required ancestor: 0832b1f32104fdfbd3b6f9e5d4978ef38915f695
> Final commit/tree SHA: reported by Codex terminal response after commit creation; these values cannot be embedded in the committed file without changing the identifiers.
> Result: C10_MCG02_UNKNOWN_RECOVERY_IMPLEMENTED

## Scope And Cause

The retained runtime baseline showed authenticated, enrolled Closure diagnostics with no pending/uploading/failed work and unresolved unknown work at local Device sequences 1 and 2, next local sequence 3, and no locally recorded attempt history. Provider state was not queried or treated as current truth.

The selected correction keeps unknown recovery local-first and guarded:

- Closure exposes an explicit confirmed `Retry unresolved submission` action.
- A read-only preflight verifies authenticated state, active hosted binding, scoped Account/environment/Device, exactly one unknown submission, complete ordered membership, contiguous Device sequences, pending rows in `unknown`, payload/content consistency and exact stored request identity.
- The normal `UploadPendingEvents` path reuses the original unknown submission ID, request hash, ordered members, event identity/content and Device sequences.
- Terminal upload persistence keeps accepted and duplicate-equivalent as accepted, keeps repeated unknown as unknown with the same retry identity, and records stable not-applied conflicts as failed.

No provider access, provider Sync, real unknown recovery, deployment, human database edit, reenrollment, migration, event version change or server API change was performed.

## Changed Paths

- clients/markei_flutter/README.md
- clients/markei_flutter/lib/app/markei_app.dart
- clients/markei_flutter/lib/app/native_auth_closure_runner.dart
- clients/markei_flutter/lib/app/pages/native_closure_page.dart
- clients/markei_flutter/lib/application/closure_diagnostics.dart
- clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
- clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart
- clients/markei_flutter/test/app/markei_app_test.dart
- clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
- clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart
- clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
- clients/markei_flutter/test/infrastructure/windows_protocol_registration_contract_test.dart
- clients/markei_flutter/test/sync/local_sync_application_test.dart
- clients/markei_flutter/tool/register_windows_auth0flutter_protocol.ps1
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

Pre-existing unrelated tracked change preserved and not staged by this unit:

- .gitignore

## Persisted Recovery Shape

Disposable file-backed tests materialized the human-equivalent local shape without private data:

- one scoped unknown submission;
- two immutable member events inserted in reversed physical order;
- membership ordered by stored position as Device sequences 1, then 2;
- pending-event rows for both members in `unknown`;
- request identity recomputed from the existing submission identity, scoped Device identity and ordered event JSON;
- local next Device sequence 3.

Evidence:

- preflight returned `unknown-retry-eligible`;
- sanitized submission fingerprint length was 8;
- leased upload reused the original submission identity and stored request hash;
- transport order was 1,2;
- submission and pending rows remained `unknown` until a terminal upload result was persisted.

No payloads, complete identifiers or request hashes are recorded here.

## Focused Tests

Command:

```text
flutter test --reporter compact test\infrastructure\closure_diagnostics_repository_test.dart test\app\native_closure_diagnostics_test.dart test\sync\local_sync_application_test.dart test\infrastructure\windows_protocol_registration_contract_test.dart test\infrastructure\windows_runner_callback_contract_test.dart test\app\markei_app_test.dart
```

Result before the final outcome-matrix expansion: passed, 69 tests.

Additional focused command after adding terminal unknown outcome persistence:

```text
flutter test --reporter compact test\sync\local_sync_application_test.dart
```

Result: passed, 25 tests.

Named evidence added or retained:

- `unknown retry preflight proves exact persisted submission shape`;
- `unknown retry preflight blocks malformed persisted identity`;
- `unknown retry preflight fails closed for ambiguous candidates`;
- `unknown retry preflight blocks unauthenticated and non-isolated queues`;
- `file-backed unknown retry reuses exact submission for sequences one and two`;
- `same-submission unknown retry persists accepted`;
- `same-submission unknown retry persists duplicate-equivalent`;
- `same-submission unknown retry persists repeated-unknown`;
- `same-submission unknown retry persists stable-not-applied`;
- `ordinary sync cannot bypass a scoped unknown submission with pending work`;
- `ordinary sync fails closed for multiple unknown submissions`;
- `Retry unresolved submission cancellation does not start Sync`;
- `Retry unresolved submission confirms and refreshes diagnostics`;
- `Retry unresolved submission blocked preflight is non-mutating`;
- `runner retry blocks before ledger when preflight is ineligible`;
- `desktop rail reaches Closure at short height without overflow`;
- `desktop rail reaches Closure at tall height without overflow`;
- `Windows auth0flutter protocol registration contract`.

## Full Validation

- `dart format --set-exit-if-changed lib test`: passed, 89 files, 0 changed.
- `flutter analyze`: passed with no issues.
- `flutter test --reporter compact`: passed, 167 tests, 4 skipped.
- `flutter build apk --debug`: passed; existing Auth0 Kotlin Gradle Plugin warning observed.
- `flutter build windows --release`: passed; existing Boost CMP0167 warning observed.
- `npm run format:check` in `services/markei_sync_api`: passed.
- `npm run lint` in `services/markei_sync_api`: passed.
- `npm run typecheck` in `services/markei_sync_api`: passed.
- `npm test` in `services/markei_sync_api`: passed, 46 tests.
- `npm run build` in `services/markei_sync_api`: passed.
- `git diff --check`: passed.

Flutter test output included existing Drift multiple-database debug warnings in file-backed tests; they did not fail the suite.

## Windows Corrections

- Added `tool/register_windows_auth0flutter_protocol.ps1`.
- The script writes the `auth0flutter` protocol handler under current-user registry scope only.
- The executable path and `%1` argument are quoted.
- The script has no tenant, credential, callback or provider configuration values.
- Existing callback-prefix validation and current-user forwarding remain in product code; no callback runtime behavior was relaxed.
- Desktop `NavigationRail` is now scrollable so Closure and all existing destinations remain reachable at short and tall Windows heights.
- Developer Windows setup guidance now documents vcpkg/cpprestsdk discovery, Closure feature flag and placeholder-only protocol registration.

## Privacy And Boundaries

- No Auth0, Render or Neon endpoint was accessed or mutated.
- No private provider files, credentials, connection strings, callback URLs, tokens, complete Account/Device/Event/Submission identifiers, payloads, request/response bodies, SQL, stack traces or human database contents were read or disclosed.
- The targeted changed-file scan found only expected placeholder/test-policy terms and public documentation URLs.
- No migration was added; Drift schema remains at the prior local version.
- No disposable artifact was intentionally tracked.

## Deviations And Residual Risks

- The final commit SHA and tree SHA are reported in the terminal response after commit, not embedded here, because embedding them would change the commit/tree identities.
- The real Windows provider retest and actual unknown recovery invocation remain human-controlled follow-up and are not claimed by this unit.
