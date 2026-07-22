# G_OPS_CODEX

Authority marker: C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR_20260722

Baseline HEAD: bca5800007453d3bef9f7178c1f534069550a0df.
Required ancestors confirmed: bca5800007453d3bef9f7178c1f534069550a0df and 75dc7bed0789d693af93abb3ed15e107fd77433a.
Final commit and tree SHA: reported by Codex final response after commit.

Early implementation recovery:
- Observed dirty candidate implementation before staging reload: migration 007, server readiness caller, hosted harness/proof fixtures, proof registry/orchestrators.
- Classified as aligned but incomplete: migration 007, readiness-v2 caller, migration-list updates, trigger-backed fixtures.
- Completed missing proof producer, strict readiness-v2 malformed-result handling, and case registry coverage.
- Preserved unrelated `.gitignore` exactly and excluded it from implementation scope.

Operational cause and correction:
- Cause addressed by this unit: migrations 001-006 allowed Accounts without `account_cursor_state`; first protected submission then failed closed after 75dc7be but still had no provisioning invariant.
- Added forward-only migration `007_account_cursor_provisioning` with checksum `c10-mcg02-account-cursor-provisioning-v1`.
- Added `public.markei_hosted_runtime_ready_v2()` while preserving `public.markei_hosted_runtime_ready()`.
- New runtime readiness uses v2 only and fails closed for missing, false, or malformed v2 result.

Migration/backfill/trigger proof:
- `npm exec tsx src/proof/migration_007_account_cursor_provisioning_probe.ts`: passed, 29/29 cases.
- Failing-first 006 evidence passed: Account can commit without cursor state; incomplete Account remains incomplete; readiness-v1 true; runtime cursor INSERT allowed.
- 007 evidence passed: fresh 001->007; 001->006->007 with no Accounts; no-events backfill next_cursor 1; existing-events high-water next_cursor max(server_cursor)+1; existing row preserved; mixed complete/incomplete Accounts repaired.
- Trigger evidence passed: AFTER INSERT trigger creates exactly one cursor row; Account rollback removes cursor; concurrent Account creation provisions cursors deterministically.
- Rollback evidence passed: injected migration failure left no 007 ledger row, no backfill, no trigger and no readiness-v2 function.
- ACL/RLS evidence passed: runtime Account INSERT denied; cursor INSERT/DELETE denied; scoped cursor SELECT/UPDATE allowed; ledger, DDL and role admin denied.
- Catalog evidence passed: trigger function owner lab_migrator in fixture, SECURITY DEFINER, fixed `pg_catalog, public` search path, qualified object access, no dynamic SQL, direct EXECUTE denied to PUBLIC/runtime.
- Readiness evidence passed: v2 true/false/absent; v1 remains callable on 007.
- Protected submission evidence passed: provisioned Account accepted first two events and advanced cursor from 1 to 3; deliberately incomplete Account returned sanitized HTTP 503/not-applied with no partial event/submission rows.

Validation commands:
- `npm exec prettier -- --write ...`: passed for touched TypeScript files.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed, 53/53.
- `npm run build`: passed.
- `npm audit --omit=dev`: initially failed on transitive `fast-uri`; corrected package-lock to patched 3.1.4/4.1.1 within existing ranges; final audit passed, 0 vulnerabilities.
- `npm run test:hosted-local` with disposable PostgreSQL URLs: passed; 28 authorization cases true, 0 pending.
- `npm exec tsx src/proof/r3_local_orchestrator.ts`: partial; migration-006, migration-007, JWKS, route inventory, static regression and authorization producers true; existing Flutter producer false with `query-replay-same-request-id:case-failed`.
- `dart format --set-exit-if-changed lib test` at repo root: no root lib/test directories.
- `dart format --set-exit-if-changed lib test` in `clients/markei_flutter`: passed, 93 files, 0 changed.
- `flutter analyze` at repo root and Flutter package: passed, no issues.
- `flutter test` at repo root: not applicable, no root test directory.
- `flutter test` in `clients/markei_flutter`: passed, 178 passed, 4 lab-gated skips.
- `MARKEI_RUN_SYNC_LAB=1 flutter test test/sync/real_convergence_harness_test.dart`: passed, 3/3.
- `MARKEI_RUN_SYNC_LAB=1 flutter test test/sync/real_recovery_harness_test.dart`: passed, 1/1.
- `flutter build windows`: passed; existing Boost/CMake CMP0167 developer warning.
- `flutter build apk --debug`: passed; existing auth0_flutter Kotlin Gradle Plugin future-compatibility warning.
- `python -m pytest`: unavailable, pytest not installed.
- `python -m unittest discover -s tests`: passed, 5/5.
- `git diff --check`: passed with Windows LF-to-CRLF warnings only.

Changed paths for implementation:
- services/markei_sync_api/migrations/007_account_cursor_provisioning.sql
- services/markei_sync_api/package-lock.json
- services/markei_sync_api/src/hosted_local_harness.ts
- services/markei_sync_api/src/http/app.ts
- services/markei_sync_api/src/proof/authorization_slice_scenarios.ts
- services/markei_sync_api/src/proof/flutter_producer.ts
- services/markei_sync_api/src/proof/migration_007_account_cursor_provisioning_probe.ts
- services/markei_sync_api/src/proof/producer.ts
- services/markei_sync_api/src/proof/r3_local_orchestrator.ts
- services/markei_sync_api/src/proof/r3d1_orchestrator.ts
- services/markei_sync_api/test/protocol.test.ts
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

Operational boundaries:
- No Auth0, Render or Neon access.
- No provider deployment, provider migration, real Sync, enrollment, or human unresolved-submission retry.
- No human database or private provider files inspected.
- Migration 007 is local materialization only; applying it to Neon and redeploying Render remain future human-controlled gates.
- `.gitignore` remains a preserved unrelated local modification and is not part of the implementation commit.
