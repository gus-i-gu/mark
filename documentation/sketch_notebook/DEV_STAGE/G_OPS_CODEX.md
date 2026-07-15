# G_OPS_CODEX - C10-S03A-R3 Operational Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex materialization evidence
Unit: C10-S03A-R3 local hosted-authorization correction and decisive proof
Branch: `intermid-cycle-recovery`
Baseline SHA: `6fc8e8d783400397025337da13ae346fd2d843cc`
Final SHA: pending materialization commit
Authority: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Evidence boundary: local-only repository, generated loopback JWKS, disposable PostgreSQL, synthetic identities only

## Result

```text
C10-S03A_R3_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: the full deterministic authorization race matrix and real Flutter HTTP/file-backed loopback proof were not completed. The hosted-local producer reports `AUTHORIZATION_RACE_MATRIX=partial` and `R3_LOCAL_SECURITY_PROVED=false`, so the aggregate success diagnostic is not emitted.

## Changed paths

- `clients/markei_flutter/lib/application/hosted_auth_ports.dart`
- `clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart`
- `clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart`
- `clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart`
- `services/markei_sync_api/migrations/006_hosted_authorization_r3.sql`
- `services/markei_sync_api/src/application/hosted_authorization.ts`
- `services/markei_sync_api/src/application/jwt_verifier.ts`
- `services/markei_sync_api/src/hosted.ts`
- `services/markei_sync_api/src/hosted_local_harness.ts`
- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/src/lab.ts`
- `services/markei_sync_api/src/main.ts`
- `services/markei_sync_api/test/hosted_auth.test.ts`
- `services/markei_sync_api/test/protocol.test.ts`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No dependency or lockfile version changed. Migrations 001-005 were not modified. No permanent memory, methodology, A/B/C or J file was modified.

## Migration 006

- File: `services/markei_sync_api/migrations/006_hosted_authorization_r3.sql`
- Migration identity: `006_hosted_authorization_r3`
- Checksum marker: `c10-s03a-r3-hosted-authorization-v1`
- Added `public.markei_hosted_runtime_ready()` as a no-argument `SECURITY DEFINER STABLE` readiness function with fixed search path and qualified ledger reference.
- Runtime execute is granted only on the new readiness function; runtime execute on `markei_required_migration_present(text)` is revoked.
- Existing direct `migration_ledger` denial remains required.

## Implementation Evidence

- Device status/revoke now separates actor authorization from path target state. Actor comes from `x-markei-device-id`; target comes from the path.
- Target snapshot may be active or revoked. Active-to-revoked changes enrollment and Device state atomically; repeated authorized revoke of a revoked target returns duplicate-equivalent.
- Hosted application composition is closed into hosted, fixture and disabled branches. Hosted protected work requires `HostedIdentityService` plus `HostedTransactionAuthorizer`; disabled composition refuses protected work.
- Fastify route inventory is captured with `onRoute` before application registration and compared against typed route descriptors, with health routes and automatic HEAD normalization handled explicitly.
- JWKS cache state now uses a deterministic semantic key-set revision over accepted JWK fields, separates freshness from semantic identity, and treats unchanged/stale unknown-key refreshes as negative-cooldown cases.
- Flutter hosted enrollment transport returns closed outcomes: success, duplicate-equivalent, conflict, unavailable and unknown-outcome. The coordinator obtains one access token per attempt and passes that same in-memory credential to transport.
- HTTP transport owns redirect refusal, absolute attempt deadline, streamed body ceiling, malformed response rejection and client ownership behavior.

## Hosted-Local Harness

Disposable PostgreSQL ran on loopback with separate migrator/runtime roles. The harness was executed against a fresh disposable database.

Diagnostics:

```text
AUTHORIZATION_RACE_MATRIX=partial
ROUTE_AUTHORIZATION_INVENTORY=true
LEAST_PRIVILEGE_HTTP=true
R3_LOCAL_SECURITY_PROVED=false
```

Least-privilege and route inventory evidence passed. Full R3 race and Flutter HTTP/file-backed evidence remain incomplete.

## Validation Results

- `git fetch origin`: passed.
- `git pull --ff-only`: passed.
- Required controlling commit ancestor check for `6fc8e8d783400397025337da13ae346fd2d843cc`: passed.
- `git status --short --branch` before editing: clean on `intermid-cycle-recovery`.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed 22 tests.
- `npm run build`: passed.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `npm run test:hosted-local`: completed with partial diagnostics shown above.
- `dart format --set-exit-if-changed lib test`: passed, 69 files, 0 changed.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed 56 tests, 2 lab-gated skips; existing Drift multiple-database debug warnings appeared in unrelated sync tests.
- `flutter build apk --debug`: passed.
- `flutter build windows --release`: passed.
- `python -m unittest discover -s tests`: passed 5 tests.
- `git diff --check`: passed with line-ending warnings only.

## Incomplete R3 Gates

- Full deterministic PostgreSQL barrier matrix across membership disable/remove, external identity disable, actor Device revoke and owner/member target races.
- Full denied-no-state-advance matrix for facts/events, cursors/acks, recovery sessions, Device/enrollment state and security-event counts.
- Real Flutter `HttpDeviceEnrollmentTransport` proof against loopback Fastify with file-backed Drift and a real pending outbox row.
- Truthful multi-producer aggregation cannot emit `R3_LOCAL_SECURITY_PROVED=true` while those gates are incomplete.

## Boundary And Teardown

No Auth0, Neon, Render or public hosted service was contacted. No provider credential, private helper file, `.vscode/settings.json`, `documentation/NEON_DOC.md` or `documentation/NEON_SESSION.ps1` was read or modified. Provider proof, MCG-03, MCG-04 and Cycle 10 closure were not started.
