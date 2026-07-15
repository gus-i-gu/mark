# I_DSN_CODEX - C10-S03A Design Evidence

Sequence: FLX-INV-02 -> Main J/D/E/F -> Codex materialization report
Role: Codex design/architecture evidence
Round or unit: C10-S03A local hosted-authentication readiness
Branch: `intermid-cycle-recovery`
Baseline SHA: `7bf3bc1c7acf5d4077cedc42ea2162a1bba99e35`
Authority: `F_DSN_STAGE.md` plus J/D/E
Evidence boundary: local architecture materialized; provider proof deferred

## Dependency direction

```text
Flutter hosted-auth ports
-> Drift hosted identity repository
-> HTTP enrollment/sync transport boundary
-> Fastify hosted composition
-> JWT/JWKS verifier and authorization service
-> PostgreSQL 18 migration/RLS/transactions
```

Provider SDKs, platform callbacks, tokens and public Auth0 config remain outside the domain model.

## Migration 004

- Added `external_identities`, `account_memberships`, `device_enrollments`, `device_enrollment_requests` and `device_security_events`.
- Identity authority is exact bounded issuer+subject; email/profile claims are not authority.
- Runtime role can select identity/membership and mutate enrollment/device rows only through granted tables.
- RLS is enabled on every new Account-bearing table.
- Membership lookup uses transaction-local identity context; Account-bearing operations use transaction-local Account context.
- Runtime DDL and runtime membership provisioning were denied in probes.
- Migration ledger records `004_hosted_identity_enrollment`.

## Drift v7

- Added `hosted_auth_states` for environment alias, stable InstallationId, enrollment request/progress/result, AccountId, server DeviceId and generation.
- Existing v6 facts, local Device sequence, outbox, inbox, cursor, recovery sessions and chunks remain intact.
- Migration tests cover v1/v2 to v7, fresh v7, reopen, and no-reset behavior.

## JWT/JWKS rules

- Maintained library: `jose` 6.1.3.
- Verification pins issuer, audience and RS256.
- Bearer token is singular and size-bounded.
- Subject is bounded and required.
- JWKS is issuer-bound through configured/derived URI with timeout, cache max age and cooldown.
- Hosted verifier never logs token, claims or JWKS body.

## Identity and Device invariants

- Access token produces only `ExternalPrincipal`.
- AccountId is resolved from active external identity plus exactly one active Account membership.
- DeviceId is never derived from token claims.
- Enrollment may proceed without existing Device.
- Protected sync/recovery routes require active Installation/Device binding.
- Membership, enrollment and Device state are rechecked in route transactions.

## Enrollment and revocation

- `GET /v1/identity`
- `POST /v1/devices/enroll`
- `GET /v1/devices/enrollments/:requestId`
- `GET /v1/devices/:deviceId/status`
- `POST /v1/devices/:deviceId/revoke`

Enrollment is idempotent by Account, Identity and EnrollmentRequestId plus canonical request hash. Revocation is atomic across enrollment state, Device status and append-only security event.

## Hosted entrypoint

- `src/hosted.ts` validates config before listening.
- Uses bounded `pg.Pool`.
- Uses `Auth0JwtVerifier`, `HostedIdentityService` and `HostedAuthVerifier`.
- Imports no fixture verifier.
- Binds `0.0.0.0` with `PORT`.
- Runs no migrations automatically and accepts no migrator credential.
- Handles SIGTERM/SIGINT by closing Fastify and pool.
- Health endpoints are sanitized; ready checks migration ledger generically.

## Flutter SDK containment

- Added ports: `ExternalAuthenticationSession`, `AccessTokenSource`, `DeviceEnrollmentTransport`, `HostedIdentityRepository`, `HostedSyncGuard`.
- Added local repository for hosted state only.
- No Auth0 SDK invocation, callback handling, native secret, management credential, database URL, signing key or token storage was added.

## Decisive topology and threats

- Local RSA/JWKS fixture generated in memory.
- Loopback JWKS and Fastify used real HTTP.
- Disposable PostgreSQL 18 used real migrations and SQL probes.
- Harness proved identity resolution, enrollment replay/conflict, two Devices, upload/download/ack, revocation denial and generic health.
- SQL probes proved RLS no-context fail-closed, Account-context visibility, DDL denial and membership-provision denial.

## Deferred provider/Main decisions

- Auth0 live Universal Login/callback.
- Neon runtime/migrator credential split.
- Render deployment.
- Provider JWKS outage and production cache tuning.
- Full account-selection UI and Device management UI.
- MCG-02 provider proof.

Terminal state:

```text
C10-S03A_LOCAL_HOSTED_AUTH_READY
MCG-02_PROVIDER_PROOF_PENDING
```
