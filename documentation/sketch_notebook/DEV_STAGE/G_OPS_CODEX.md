# G_OPS_CODEX

Authority marker: C10-MCG02-TRANSPORT-OBSERVABILITY_20260721

Baseline HEAD: a866676c2d556a1db707bd4d466bfcef9898a85a

Operational result: implemented privacy-bounded transport observability for the next human Closure retry. No Auth0, Render, Neon, provider credential file, private database, human database, ordinary Sync, or unknown recovery was accessed or executed.

Changed paths:
- clients/markei_flutter/lib/app/markei_composition.dart
- clients/markei_flutter/lib/app/native_auth_closure_runner.dart
- clients/markei_flutter/lib/app/pages/native_closure_page.dart
- clients/markei_flutter/lib/application/closure_diagnostics.dart
- clients/markei_flutter/lib/application/hosted_connection_check.dart
- clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
- clients/markei_flutter/lib/infrastructure/local/local_database.dart
- clients/markei_flutter/lib/infrastructure/local/local_database.g.dart
- clients/markei_flutter/lib/infrastructure/remote/hosted_http_policy.dart
- clients/markei_flutter/lib/infrastructure/remote/http_hosted_connection_check.dart
- clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
- clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart
- clients/markei_flutter/test/infrastructure/http_hosted_connection_check_test.dart
- clients/markei_flutter/test/infrastructure/local_database_migration_test.dart
- clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
- services/markei_sync_api/src/hosted.ts
- services/markei_sync_api/src/http/app.ts
- services/markei_sync_api/test/protocol.test.ts

Pre-existing unrelated path preserved and not staged: .gitignore.

Evidence:
- Added Closure action: Check hosted connection.
- Health order: GET /health/live, then GET /health/ready only after live parses as live.
- Health authorization: no bearer Authorization header is sent.
- Health mutation boundary: tests verify no Sync attempt, no outbox lease, and no queue mutation for the health action.
- Diagnostic ledger: one durable hosted-connection-check attempt begins before transport and finalizes once.
- Migration: Drift schema version 10 adds only nullable/default Sync attempt observability columns; v9 historical rows preserve sync-interrupted / transport-or-closure without retrospective evidence.
- Client correlation: one transient correlation value per invocation; persisted/displayed value is an 8-character fingerprint.
- API lifecycle logging: Fastify logger remains false; hosted entrypoint installs sanitized lifecycle observer.

Validation run:
- git fetch origin: passed.
- git pull --ff-only origin intermid-cycle-recovery: already up to date.
- required ancestor a866676c2d556a1db707bd4d466bfcef9898a85a: ancestor check passed.
- flutter pub run build_runner build --delete-conflicting-outputs: passed, 178 generated outputs; build_runner reported the delete-conflicting option was ignored.
- flutter test test/infrastructure/http_hosted_connection_check_test.dart: 7 passed.
- flutter test test/app/native_closure_diagnostics_test.dart: 14 passed.
- flutter test test/infrastructure/closure_diagnostics_repository_test.dart test/infrastructure/local_database_migration_test.dart test/infrastructure/native_auth_composition_test.dart: 33 passed.
- dart format --set-exit-if-changed lib test: first two runs formatted changed files; final rerun passed with 0 changed.
- flutter analyze: passed, no issues.
- npm exec prettier -- --write src/**/*.ts test/**/*.ts: formatted server changes.
- npm run format:check: passed.
- npm run lint: passed.
- npm run typecheck: passed.
- npm test: 49 passed.
- npm run build: passed.
- flutter test: 177 passed, 4 lab-gated skips.
- flutter build apk --debug: passed; emitted existing auth0_flutter Kotlin Gradle Plugin future-compatibility warning.
- flutter build windows --release: passed; emitted existing Boost/CMake CMP0167 developer warning.

Pending final checks after report replacement: git diff --check, staged path review, staged secret scan, commit, push. Exact final commit and tree SHA are reported by Codex after commit because they cannot be embedded in the committed report without changing the values.
