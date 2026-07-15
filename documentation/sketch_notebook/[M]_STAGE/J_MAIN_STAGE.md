# J_MAIN_STAGE — C10-S03A Hosted Authentication Readiness Reconciliation

> Sequence: FLX-INV-02 → Main synthesis and materialization activation
> Role: Main Chat
> Cycle/unit: Cycle 10 / C10-S03A
> Branch: `intermid-cycle-recovery`
> Reconciled HEAD: `75ce8a10fd9e143ff421252796405b3d4a12cb2c`
> Implementation baseline: `de1319dc05e1f04ba84b6cfd681f5b72a4568f88`
> Status: ACTIVE CODEX AUTHORITY THROUGH JOINT D/E/F
> Line ceiling: each J/D/E/F stage remains at or below 600 lines

## 1. Methodology retained

Main loaded `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, then the canonical
`METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL` route.

Retained controls:

- A/B/C are provisional functional investigations, not implementation authority.
- Main owns cross-domain selection and activates Codex only through coherent D/E/F.
- Codex materializes and validates; G/H/I remain observational evidence.
- PRC-01 distinguishes repository existence, local validation, manual provider evidence and
  production acceptance.
- Provider mutation, credentials and interactive identity remain human-controlled.
- Learner maturity and permanent domain memory do not change in this staging action.
- Cycle 11 owns product authentication/Device-management presentation and Analytics.

## 2. Evidence reconciled

### 2.1 C10-S02

Claim: bounded local retention, snapshot, cursor-expiry and fresh-target rebootstrap are proved.

- Source: commit `de1319dc`, G/H/I, named recovery harness.
- Evidence: `RECOVERY_CONVERGED=true`; 52 Flutter tests; 5 TypeScript tests; migration/RLS role
  probes; Windows release and Android debug builds; teardown evidence.
- Boundary: synthetic loopback/Docker PostgreSQL only; no Auth0, Render or Neon use.
- Classification: `implemented + locally validated`.
- Exclusions retained: production policy durations, worker scheduling, object storage, database
  switching, hosted authentication and provider backup.

The G changed-path list omitted G/H/I themselves although Git confirms they changed. This is a
reporting defect, not invalidation of the implementation. `pytest` was host-unavailable while the
protected `unittest` suite passed. Both facts must remain visible in later reports.

### 2.2 Sanitized MCG-01

Claim: a separated Neon development environment and least-privilege identities were manually
probed on 2026-07-15.

- Sanitized evidence: Free plan; `us-west-2`; PostgreSQL 18.4; isolated development branch;
  disposable `markei_sync_dev`; direct `markei_migrator`; pooled-intended `markei_runtime`; TLS;
  transactional rollback; explicit runtime CRUD; runtime DDL denial; probe teardown.
- Boundary: human-observed provider configuration; no connection string, hostname, password,
  endpoint ID or token entered repository evidence.
- Classification: `SANITIZED_EVIDENCE_READY / operationally accepted for C10-S03 planning`.
- Not proved: migration 003/004 on Neon, pooled RLS behavior, backup/PITR, hosted service,
  authentication or production readiness.
- Gate: human must reconfirm branch lifetime and exact target before C10-S03B mutation.

### 2.3 C10-S03 investigations

- A (`c71f450` ancestry via later commits): truthful hosted-readiness gaps, OP1–OP10,
  implementation/provider split, rollback and MCG-02 matrix.
- B (`c71f450`): authentication/authorization/Device vocabulary, state evidence, privacy and
  Cycle 10/11 boundary.
- C (`75ce8a1`): three trust-chain alternatives, migration 004, JWT/JWKS, membership and
  installation enrollment architecture.

Classification: `provisional inputs reconciled into the decisions below`.

## 3. Selected milestone split

Cycle 10 retains one C10-S03 milestone with two authority gates:

```text
C10-S03A — Codex local hosted-auth readiness
  repository implementation + disposable proof
  no provider access

C10-S03B — Human MCG-02 hosted development proof
  reviewed Neon migration + Render + real Auth0 + Android/Windows
  activated only after Main reconciles S03A G/H/I
```

C10-S03A is active. C10-S03B is not Codex authority and remains blocked on S03A evidence.

## 4. Architecture selected

Select investigation Alternative C:

```text
Auth0 issuer + subject
→ Markei ExternalIdentity
→ active AccountMembership
→ stable local InstallationId
→ idempotent server Device enrollment
→ authorized AccountId + DeviceId
→ existing sync/recovery transaction and RLS context
```

Identity meanings remain separate:

- Auth0 issuer+subject identifies an external identity.
- AccountMembership authorizes that identity in one Markei Account.
- InstallationId identifies one app installation and is not a credential or hardware fingerprint.
- DeviceId is the server-authorized synchronization actor.
- AccountId and DeviceId never derive from unverified client claims.

## 5. Main decisions frozen for C10-S03A

### 5.1 Membership and Account selection

- Migration 004 supports multiple memberships structurally.
- C10-S03 hosted composition proceeds only when exactly one active membership resolves.
- Zero active memberships returns `membership-required`.
- More than one returns `account-selection-required`; no Account-selection UI is implemented.
- Roles are stored in Markei PostgreSQL, not trusted from Auth0 claims.
- Initial roles: `owner | member`; both may enroll their own installation.
- Membership provisioning/removal is not exposed as a public API in S03A. Local fixtures seed it;
  S03B uses a reviewed human-controlled migration/admin procedure with synthetic identity only.

### 5.2 Enrollment

- Flutter persists one UUIDv4 InstallationId independently of DeviceId.
- Authenticated active membership may enroll its own InstallationId.
- Request uses EnrollmentRequestId plus canonical request hash.
- Same request identity/hash returns the stored equivalent result.
- Same identity with different hash returns conflict.
- Unique Account+Installation binding prevents duplicate active Device creation.
- Server allocates DeviceId and returns it; client stores it atomically with enrollment state.
- Reinstall without InstallationId creates a new installation and Device; it never silently reuses
  or replaces the previous Device.
- Enrollment is bounded and rate-limited in application policy; no hardware fingerprint or native
  client secret is introduced.

### 5.3 Revocation

- Every protected route rechecks membership and Device status in the transaction.
- Owner role may revoke a Device in the same Account through a typed idempotent operation.
- Member may self-revoke its currently authorized Device only.
- Foreign/unknown Device targets use the same non-enumerating denial.
- Revocation blocks future sync/recovery but does not erase local Drift facts or Auth0 identity.
- Reactivation, replacement approval, invitations and administrative UI are deferred.

### 5.4 JWT contract

- Accept bearer access tokens only, never ID tokens as API credentials.
- Pin configured HTTPS issuer, API audience and `RS256`.
- Validate signature, issuer, audience, expiry and not-before with explicit bounded skew.
- Use issuer-bound remote JWKS with response size/time limits, bounded cache, concurrent refresh
  coalescing and one refresh for unknown `kid`.
- Fail closed when no valid cached key can verify.
- Do not require Auth0 Management API or a Machine-to-Machine credential.
- Local tests use generated deterministic/ephemeral RSA/JWKS fixtures, never live Auth0.

### 5.5 HTTP and anti-enumeration

- `401`: missing/malformed/unverifiable/expired/wrong-issuer/wrong-audience token.
- `403`: authenticated but membership, role or Device authorization denied.
- `409`: idempotency/hash conflict or invalid state transition.
- Foreign and absent Account/Device resources share a bounded non-enumerating response.
- Typed code, outcome, retryability, safe action and correlation alias remain distinct from HTTP.

### 5.6 Hosted configuration

Production-safe server configuration names are:

```text
NODE_ENV
PORT
MARKEI_SYNC_DATABASE_URL
MARKEI_AUTH_ISSUER
MARKEI_AUTH_AUDIENCE
MARKEI_AUTH_JWKS_URI        optional, must remain issuer-bound HTTPS
MARKEI_PUBLIC_ORIGIN
MARKEI_LOG_LEVEL
```

`MARKEI_SYNC_DATABASE_URL` is the pooled least-privilege runtime URL in hosted composition. A
migrator URL is never accepted by the web-service entrypoint. Missing/invalid configuration fails
before listen without echoing values.

### 5.7 Health and lifecycle

- `/health/live`: unauthenticated static liveness, no provider/database/version detail.
- `/health/ready`: generic ready/not-ready after bounded database/configuration checks; no detail.
- Hosted entrypoint binds `0.0.0.0` and Render `PORT`.
- SIGTERM/SIGINT stop acceptance, close Fastify and close `pg.Pool` within a bounded interval.
- Lab entrypoints remain separate and cannot be selected by hosted start scripts.

### 5.8 Flutter boundary

- Additive Drift v7 may add stable InstallationId and hosted enrollment metadata only.
- Preserve all v6 facts, outbox, inbox, cursor, recovery and local Device data.
- Add application ports for external authentication credentials and Device enrollment.
- Add an opt-in development hosted-auth composition and neutral lab entrypoint sufficient for later
  Android/Windows MCG-02 operation.
- Public Auth0 domain, Native ClientId and audience may be supplied through build-time development
  configuration; no client secret exists.
- Credential storage uses the official native SDK credential facility where supported and is
  abstracted for tests.
- Normal application remains local-first when hosted development mode is absent.
- No product login page, navigation, Device manager, banners, visual polish or Analytics.

## 6. C10-S03A required materialization

Codex must implement and prove locally:

1. closed hosted-auth/enrollment contracts and typed failures;
2. forward-only migration `004_hosted_identity_enrollment.sql` without editing 001–003;
3. external identity, membership, enrollment request/binding and security-event persistence;
4. strict Auth0-compatible JWT/JWKS verifier with local issuer fixtures;
5. request authorization that resolves identity→membership→Device before existing transactions;
6. idempotent enrollment/status and authorized revocation endpoints;
7. route-wide membership/Device recheck for sync and recovery;
8. fail-closed hosted configuration and production-safe server entrypoint;
9. build/start scripts producing compiled JavaScript without `tsx` at runtime;
10. Drift v7 InstallationId/enrollment state with no reset;
11. Flutter authentication/enrollment ports plus opt-in neutral hosted-auth lab composition;
12. disposable PostgreSQL/JWKS two-installation proof through real HTTP;
13. invalid-token, cross-Account, replay, revocation, outage and restart failures;
14. Windows/Android builds when host-supported;
15. G/H/I reports with complete Git-derived inventory.

## 7. Provider boundary

Codex must not:

- read or request Auth0, Neon or Render credentials;
- inspect local secret-bearing MCG files;
- connect to Neon or Auth0;
- create/configure/deploy Render services;
- apply migration 004 outside disposable local PostgreSQL;
- generate real provider tokens;
- use ordinary user data;
- create Machine-to-Machine or management credentials;
- expose fixture authentication through hosted composition.

C10-S03B begins only after Main reconciles S03A G/H/I. Human provider actions then follow a
separate explicit checklist and sanitized evidence contract.

## 8. Validation authority

D/E/F jointly require:

- TypeScript format, lint, typecheck, tests, build and production-start smoke;
- JWT/JWKS fixture matrix and local hosted-composition system proof;
- 001→002→003→004 migration, failure rollback, role, grant and RLS probes;
- Drift v6→v7 fresh/migrate/reopen/failure/no-reset evidence;
- Flutter format, analysis and full tests;
- Android debug and Windows release builds when supported;
- protected Python unittest regression;
- npm audit, secret scans, `git diff --check` and disposable teardown.

Build success remains distinct from interactive Auth0/platform acceptance.

## 9. Terminal states

Complete local proof:

```text
C10-S03A_LOCAL_HOSTED_AUTH_READY
MCG-02_PROVIDER_PROOF_PENDING
```

Any missing decisive local gate:

```text
C10-S03A_PARTIAL
```

Codex must report the exact blocker and must not proceed into provider mutation.

## 10. Deferred Main decisions

Deferred beyond S03A:

- real Auth0/Render/Neon behavior and provider plan limits;
- Account-selection product UX and household invitation/pairing;
- passwordless/social providers and account linking;
- refresh/offline-access lifetime policy for production;
- production rate limits, audit retention and support operations;
- Device reactivation, replacement approval and remote local-data handling;
- production cleanup worker, object storage and backup/PITR integration;
- Account deletion/tombstones and production rollout;
- all Cycle 11 authentication/synchronization presentation.

## 11. Exit condition

J, D, E and F must agree on scope, vocabulary, architecture, validation and provider exclusions.
After Codex reports G/H/I, Main reconciles S03A before issuing any MCG-02 migration or deployment
instructions. This staging action does not close Cycle 10 or authorize C10-S03B.
