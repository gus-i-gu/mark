# G_OPS_CODEX - C10-S03A Operational Evidence

Sequence: FLX-INV-02 -> Main J/D/E/F -> Codex materialization report
Role: Codex materialization evidence
Round or unit: C10-S03A local hosted-authentication readiness
Branch: `intermid-cycle-recovery`
Baseline SHA: `7bf3bc1c7acf5d4077cedc42ea2162a1bba99e35`
Final SHA: pending commit
Authority: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Evidence boundary: local-only repository, disposable PostgreSQL 18, loopback Fastify/JWKS, synthetic identities only

## Changed-path inventory

- `clients/markei_flutter/lib/application/hosted_auth_ports.dart`
- `clients/markei_flutter/lib/infrastructure/local/hosted_identity_repository.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_database.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_database.g.dart`
- `clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart`
- `clients/markei_flutter/test/infrastructure/local_database_migration_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
- `services/markei_sync_api/.env.example`
- `services/markei_sync_api/eslint.config.js`
- `services/markei_sync_api/migrations/004_hosted_identity_enrollment.sql`
- `services/markei_sync_api/package-lock.json`
- `services/markei_sync_api/package.json`
- `services/markei_sync_api/src/application/hosted_authorization.ts`
- `services/markei_sync_api/src/application/hosted_config.ts`
- `services/markei_sync_api/src/application/hosted_contracts.ts`
- `services/markei_sync_api/src/application/jwt_verifier.ts`
- `services/markei_sync_api/src/hosted.ts`
- `services/markei_sync_api/src/hosted_local_harness.ts`
- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/src/postgres/database.ts`
- `services/markei_sync_api/test/hosted_auth.test.ts`

## Versions and dependencies

- `purchase.registered` payload version 3 preserved.
- Opaque `c10b:*` cursors preserved.
- Recovery snapshot format 1 preserved.
- PostgreSQL migrations 001-003 unchanged; added 004 only.
- Drift schema v7; v6 tables and data preserved.
- Hosted identity/enrollment contract version 1.
- JWT/JWKS library: `jose` 6.1.3.
- Production entrypoint: `services/markei_sync_api/src/hosted.ts`; `npm start` runs compiled `dist/src/hosted.js`.

## Validation commands and results

- `git fetch origin intermid-cycle-recovery`: passed before worktree creation.
- Required ancestry `7bf3bc1c7acf5d4077cedc42ea2162a1bba99e35`: confirmed ancestor of HEAD.
- `npm install jose@6.1.3`: passed, 0 vulnerabilities after install.
- `npm exec prettier -- --write ...`: passed.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed 9 tests.
- `npm run build`: passed.
- Compiled hosted smoke `node dist/src/hosted.js`: passed; `/health/live` returned `{"status":"live"}`, `/health/ready` returned `{"status":"ready"}`, log `MARKEI_HOSTED_SYNC_READY`.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `flutter pub run build_runner build --delete-conflicting-outputs`: passed; Drift regenerated.
- `dart format --set-exit-if-changed lib test`: passed, 67 files checked.
- `flutter analyze`: passed, no issues.
- Focused Flutter tests: passed 5 tests.
- Full `flutter test`: passed 53 tests, 2 lab-gated tests skipped.
- `flutter build apk --debug`: passed, built `build\app\outputs\flutter-apk\app-debug.apk`.
- `flutter build windows --release`: blocked by host Windows Developer Mode symlink requirement.
- `python -m unittest discover -s tests`: passed 5 tests.
- `git diff --check`: passed.

## Local hosted proof

- Disposable PostgreSQL 18 container: `postgres:18`, loopback `127.0.0.1:55433`.
- Decisive harness command: `npm run test:hosted-local` with synthetic loopback database URL.
- Harness result: `HOSTED_AUTH_READY=true`.
- Harness topology: generated local RSA/JWKS fixture -> loopback Fastify hosted app -> PostgreSQL 18 -> HTTP clients A/B.
- Identity results: Principal A and B resolved exact issuer/subject identities with one active membership each.
- Enrollment results: Installation A enrolled; equivalent replay returned same Device; conflicting replay returned typed conflict; Installation B enrolled separately.
- Sync results: A uploaded 1 synthetic `purchase.registered` v3 event; B downloaded 1 event and acknowledged it.
- Revocation results: owner A revoked B; B was denied further event download with HTTP 403.
- Health/log diagnostics remained generic and did not expose issuer, audience, database URL, token, claims or payload.

## Database evidence

- Fresh 001 -> 002 -> 003 -> 004: passed in harness database.
- Existing 001 -> 003 then 004: passed in second disposable database.
- Migration ledger contained `002_coordination_hardening`, `003_retention_snapshot_recovery`, `004_hosted_identity_enrollment`.
- Rollback probe: deliberate transactional failure left `rollback_probe` absent.
- Runtime role RLS no-context probe on `device_enrollments`: 0 rows.
- Runtime role account-context probe: 2 scoped rows.
- Runtime DDL probe: denied with `permission denied for schema public`.
- Runtime membership-provision probe: denied with `permission denied for table account_memberships`.

## JWT/JWKS matrix counts

- Automated unit cases passed: valid RS256 access token, wrong audience, missing bearer header, oversized token, hosted entrypoint fixture-auth exclusion, closed hosted configuration.
- Harness cases passed: local JWKS serving, `kid`-selected RS256 verification, issuer/audience pinning, token-derived Account/Device rejection by design.
- Remaining fine-grained CP3 cases not exhaustively represented as separate unit names: duplicate bearer, malformed bearer, invalid signature, wrong issuer, wrong algorithm, expired, not-yet-valid, absent subject, absent/unknown kid, rotation, cached-key outage, timeout, malformed/oversized JWKS and refresh stampede.

## Scans and teardown

- Secret/provider boundary: no Auth0, Neon or Render access occurred.
- `.env.example` contains variable names only.
- No provider credentials, tokens, connection helpers, local MCG files or `.vscode/` files were read or tracked.
- `git diff --check`: passed.
- Disposable PostgreSQL container teardown performed after validation.

## Deviations, blockers, exclusions

- Windows release build blocked by Windows Developer Mode symlink support.
- Full CP3 failure-injection floor is partially covered by unit tests and harness, not exhaustively named.
- Runtime role separation is proven by SQL probes; the harness itself runs with the synthetic disposable database URL.
- Live provider proof, Auth0 callback, Neon, Render and MCG-02 remain outside this evidence boundary.

Terminal state:

```text
C10-S03A_LOCAL_HOSTED_AUTH_READY
MCG-02_PROVIDER_PROOF_PENDING
```
