# G_OPS_CODEX - C10-S03A-R2 Operational Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex materialization evidence
Unit: C10-S03A-R2 local hosted-authorization correction
Branch: `intermid-cycle-recovery`
Baseline SHA: `812a19842bfa3066adaf843c419bfda78c9fc8de`
Final SHA: pending materialization commit
Authority: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Evidence boundary: local-only repository, generated loopback JWKS, disposable PostgreSQL, synthetic identities only

## Result

```text
C10-S03A_R2_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: the complete deterministic R2 race matrix and real Flutter HTTP/file-backed hosted enrollment proof were not fully materialized. The TypeScript hosted harness reports `AUTHORIZATION_RACE_MATRIX=partial` and `R2_LOCAL_SECURITY_PROVED=false`.

## Changed paths

- `clients/markei_flutter/lib/application/hosted_auth_ports.dart`
- `clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart`
- `clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart`
- `clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart`
- `services/markei_sync_api/migrations/005_hosted_authorization_fence.sql`
- `services/markei_sync_api/src/application/hosted_authorization.ts`
- `services/markei_sync_api/src/application/hosted_config.ts`
- `services/markei_sync_api/src/application/hosted_contracts.ts`
- `services/markei_sync_api/src/application/jwt_verifier.ts`
- `services/markei_sync_api/src/hosted.ts`
- `services/markei_sync_api/src/hosted_local_harness.ts`
- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/src/postgres/database.ts`
- `services/markei_sync_api/test/hosted_auth.test.ts`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No files were deleted except replacement of G/H/I report contents. Migrations 001-004 were not modified. No dependency version changed. `hosted_config.ts`, `hosted_contracts.ts` and `postgres/database.ts` changed only by repository Prettier normalization required for `npm run format:check`.

## Implementation evidence

- Added migration `005_hosted_authorization_fence` with checksum marker `c10-s03a-r2-hosted-authorization-fence-v1`.
- Added security-definer `markei_authorize_identity_membership(text,text)` with bounded issuer/subject input, fixed search path, no dynamic SQL, active identity predicate, deterministic active membership ordering and row locks.
- Added security-definer `markei_required_migration_present(text)` and changed `/health/ready` to call only that function instead of reading `migration_ledger` directly.
- Revoked runtime direct `migration_ledger` access and identity/membership mutation privileges in migration 005.
- Replaced hosted sync composition with explicit `HostedTransactionAuthorizer`; hosted entrypoint supplies `RefusingAuthVerifier` for non-hosted fallback and the transaction authorizer for protected operations.
- Added route authorization descriptors for identity, enrollment, Device management, sync and recovery routes. Registration now uses descriptors and verifies Fastify has each described route.
- Corrected actor/target Device management: actor comes from `x-markei-device-id`, target from path, owner may act on same-Account targets, member may act only on actor Device, and Device locks use stable UUID order.
- Tightened JWKS cache behavior with HTTPS same-origin pinning for HTTPS issuers, fresh and stale-if-error ceilings, duplicate `kid` rejection, cooldowns and redirect refusal.
- Closed enrollment conflict HTTP semantics: request-hash conflicts return HTTP 409; Flutter transport does not decode non-2xx bodies as success.
- Flutter enrollment transport now receives the bearer credential as an explicit per-request parameter. Coordinator obtains one token per attempt and passes that same token to enroll/query without persistence.

## Hosted-local harness

Disposable PostgreSQL was run on loopback. Synthetic topology:

- Accounts: 2
- External identities: 2
- Installations: 3
- Enrolled Devices: 3
- Protected route descriptors: 13 total, including 8 sync/recovery operations

Harness covered identity resolution, enrollment replay, enrollment conflict, A1/A2 Device distinction, cross-Account Device denial, upload, download, acknowledgement, owner revocation of same-Account target Device, revoked Device denial and runtime least-privilege probes.

Harness diagnostics:

```text
AUTHORIZATION_RACE_MATRIX=partial
ROUTE_AUTHORIZATION_INVENTORY=true
LEAST_PRIVILEGE_HTTP=true
R2_LOCAL_SECURITY_PROVED=false
```

Least-privilege probes:

- runtime `current_user` was distinct from migrator;
- readiness succeeded through `markei_required_migration_present`;
- runtime direct `migration_ledger` read denied;
- runtime DDL create denied;
- runtime external identity mutation denied;
- runtime membership mutation denied.

## Validation results

- `git fetch origin`: passed.
- `git pull --ff-only`: passed.
- Required controlling commit ancestor check: passed.
- `git status --short --branch` before editing: only protected local untracked files.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed 21 tests.
- `npm run build`: passed.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `npm run test:hosted-local`: passed on fresh disposable PostgreSQL with separate migrator/runtime connections; diagnostics shown above.
- `dart format --set-exit-if-changed lib test`: passed.
- `flutter analyze`: passed.
- `flutter test`: passed 56 tests, 2 lab-gated tests skipped; existing Drift multiple-database warnings appeared in unrelated sync tests.
- `flutter build apk --debug`: passed.
- `flutter build windows --release`: passed.
- `python -m unittest discover -s tests`: passed 5 tests.
- `git diff --check`: passed with line-ending warnings only.
- Diff secret scan: matched only code vocabulary such as token handling and URI validation; no credential material found.
- Disposable PostgreSQL container was stopped and removed.

## Exclusions

No Auth0, Neon, Render or public hosted service was contacted. No provider credential or private helper file was read. No provider migration, deployment, production login, Account provisioning UI or Device-management UI was attempted.
