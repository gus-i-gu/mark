# D_OPS_STAGE — C10-S03A Operational Materialization Authority

> Sequence: FLX-INV-02 → Main D/E/F activation
> Unit: local hosted-authentication readiness
> Baseline: `75ce8a10fd9e143ff421252796405b3d4a12cb2c`
> Authority: controlling Operational contract for Codex, jointly with E/F
> Provider authority: none

## 1. Objective and terminal boundary

Materialize a disposable local proof that the production-shaped Markei composition can:

```text
verify Auth0-compatible access tokens
→ resolve explicit Account membership
→ enroll/authorize one installation Device
→ run existing sync and recovery routes
→ revoke and deny a Device
→ compile and start through a hosted-safe entrypoint
```

Complete only when the decisive harness emits:

```text
HOSTED_AUTH_READY=true
```

and Codex reports:

```text
C10-S03A_LOCAL_HOSTED_AUTH_READY
MCG-02_PROVIDER_PROOF_PENDING
```

No Auth0, Render or Neon connection is allowed. A missing local decisive gate reports
`C10-S03A_PARTIAL` with the exact blocker.

## 2. Baseline controls

- Preserve event payload v3, opaque `c10b:*` cursors, recovery format 1 and Drift v6 facts.
- Preserve migrations 001–003 byte-for-byte.
- Preserve local-only operation and every existing C10-S01B/S02 test.
- Preserve fixture authentication only in tests and explicit loopback lab entrypoints.
- Never make fixture authentication selectable by hosted environment variables.
- Use synthetic identities, Accounts, Devices, keys and facts only.
- No production retention policy, live cleanup, object storage, UI redesign or Analytics.
- Keep ordinary handwritten source near 250 lines; split by responsibility. Generated code may
  exceed the ordinary boundary.

## 3. CP1 — Closed contracts and configuration

Implement closed, bounded TypeScript and Dart contracts for:

- verified external identity (`issuer`, `subject`, token metadata needed for authorization only);
- membership resolution and exactly-one-active-membership outcome;
- Device enrollment start/result/status;
- Device authorization and revocation;
- typed authentication/authorization failures;
- hosted configuration validation;
- neutral hosted-proof diagnostics.

Required server environment names:

```text
NODE_ENV
PORT
MARKEI_SYNC_DATABASE_URL
MARKEI_AUTH_ISSUER
MARKEI_AUTH_AUDIENCE
MARKEI_AUTH_JWKS_URI
MARKEI_PUBLIC_ORIGIN
MARKEI_LOG_LEVEL
```

`MARKEI_AUTH_JWKS_URI` may be omitted only when derived safely from the pinned issuer. Hosted
configuration must reject:

- non-HTTPS issuer/JWKS/public origin outside explicit loopback test composition;
- invalid or unbounded PORT;
- empty audience;
- credential-bearing origin/issuer/JWKS URLs;
- malformed database URL;
- unknown environment mode;
- any migrator-specific variable supplied to the web composition.

Errors name the invalid variable but never echo its value. Add a variable-name-only `.env.example`
only if consistent with repository conventions; it must contain no usable value or hostname.

Success evidence:

- valid synthetic config loads;
- each missing/malformed variable fails before listen;
- fixture fallback is impossible;
- configuration/log snapshots contain no values classified as secrets.

## 4. CP2 — Forward-only PostgreSQL migration 004

Create:

```text
services/markei_sync_api/migrations/004_hosted_identity_enrollment.sql
```

Do not edit 001–003. Use existing naming, ledger and role conventions.

Implement structures equivalent to:

### External identity

- opaque IdentityId;
- bounded exact issuer and subject;
- unique `(issuer, subject)`;
- status `active|disabled`;
- creation/update timestamps;
- no email/profile claim as identity authority.

### Account membership

- AccountId + IdentityId ownership;
- role `owner|member`;
- status `active|disabled|removed`;
- unique active relationship and bounded timestamps/version;
- no Auth0 role claim as database authority.

### Device enrollment

- AccountId + stable InstallationId unique binding;
- DeviceId composite FK to existing Account-scoped Device;
- state `active|revoked|replaced` with generation/timestamps;
- no implicit replacement or reactivation.

### Enrollment request

- EnrollmentRequestId bound to Account+Identity+Installation;
- canonical request hash;
- stored Device result and state;
- explicit expiry/created/completed timestamps;
- same identity/hash replay and different-hash conflict.

### Security event

- append-only synthetic-safe codes for membership/enrollment/revocation outcomes;
- actor identity, Account, optional Device, correlation alias and timestamp;
- no bearer token, email, raw claims, payload or provider credential.

Required migration properties:

- composite ownership FKs and indexes;
- bounded checks and monotonic states;
- least-privilege runtime grants;
- RLS on every Account-bearing new table;
- explicit Account/identity predicates;
- runtime can resolve membership, enroll its installation and read status;
- owner/member revocation rules remain application-authorized and transaction-checked;
- runtime cannot create memberships, alter identity status, perform DDL or cross Accounts;
- migration ledger records 004 exactly once;
- migration failure rolls back schema and ledger together.

Validate:

1. fresh 001→002→003→004;
2. existing 001→003 then 004;
3. repeated runner/ledger behavior;
4. deliberate mid-migration failure rollback on disposable copy;
5. runtime DDL and membership-provision denial;
6. per-table RLS isolation and no-context fail-closed behavior;
7. pooled-compatible transaction-local identity/Account/Device context;
8. migrator/runtime role separation.

## 5. CP3 — JWT/JWKS verification

Implement a production `Auth0JwtVerifier` behind a narrow verification port.

Required behavior:

- accept exactly one `Authorization: Bearer <access-token>` header;
- bound header/token/JWK response sizes;
- pin configured issuer, audience and `RS256`;
- validate signature, issuer, audience, `exp` and `nbf`;
- use an injected Clock and explicit small skew;
- select key by `kid` from issuer-bound HTTPS JWKS;
- bounded connect/request timeout and cache lifetime;
- coalesce concurrent refreshes;
- refresh once for unknown `kid`, then fail closed;
- continue through temporary JWKS outage only with a still-valid cached key capable of verifying;
- map failures to typed privacy-safe errors;
- never return raw token or full claims beyond the verifier boundary.

Use local generated RSA key/JWKS fixtures served from loopback. Never call Auth0 in tests.

Required cases:

- valid token;
- missing/duplicate/malformed bearer header;
- oversized token;
- invalid signature;
- wrong issuer/audience/algorithm;
- expired/not-yet-valid token;
- absent/malformed `sub`;
- absent/unknown `kid`;
- key rotation;
- cached-key success during bounded outage;
- outage with no valid key;
- timeout, malformed and oversized JWKS;
- concurrent unknown-key refresh does not stampede.

## 6. CP4 — Identity, membership and authorization

Split external verification from Markei authorization. The verifier must not fabricate AuthContext.

Required trust path:

1. verify token into ExternalPrincipal;
2. resolve exact issuer+subject to active ExternalIdentity;
3. resolve active memberships;
4. zero membership → `membership-required`;
5. more than one → `account-selection-required`;
6. exactly one → derive AccountId;
7. enrollment routes may proceed without an existing Device;
8. protected routes resolve Installation/Device binding and active existing Device;
9. only then create AccountId+DeviceId AuthContext;
10. recheck membership and Device inside the mutation transaction.

Do not accept AccountId or DeviceId from token claims. A body/header DeviceId may be treated only
as a requested identifier and must equal the database-authorized binding.

Apply authorization to every existing route:

- submission upload;
- incremental download;
- acknowledgement;
- capabilities;
- rebootstrap start/status/chunk/complete.

Keep explicit SQL predicates and transaction-local RLS context. Test membership disable/removal and
Device revocation racing an in-flight request; the mutation must fail or serialize before commit.

## 7. CP5 — Enrollment and revocation routes

Implement bounded versioned routes equivalent to:

```text
GET  /v1/identity
POST /v1/devices/enroll
GET  /v1/devices/enrollments/:requestId
GET  /v1/devices/:deviceId/status
POST /v1/devices/:deviceId/revoke
```

Enrollment request includes:

- contract version;
- stable UUIDv4 InstallationId;
- UUID EnrollmentRequestId;
- platform class `android|windows|test`;
- bounded app identifier/version metadata;
- canonical request hash derived server-side from closed fields.

Rules:

- active owner/member may enroll its own installation;
- server allocates DeviceId and initial Device state;
- one active Account+Installation binding;
- equivalent replay returns same Device result;
- hash mismatch conflicts;
- query resolves unknown outcome without creating another Device;
- concurrent equivalent enrollment creates one Device;
- expired/failed request cannot be silently reused;
- bounded per-principal enrollment attempt policy returns `rate-limited` without enumeration.

Revocation rules:

- owner may revoke a Device in the same Account;
- member may revoke only its currently authorized Device;
- same revocation replay is equivalent;
- foreign/unknown target returns the same denial;
- revoked Device immediately fails sync/recovery and no longer constrains retention eligibility;
- no endpoint reactivates, replaces or deletes Device/local facts.

## 8. CP6 — Hosted-safe Fastify entrypoint

Create a production entrypoint and composition distinct from `lab.ts` and `recovery_lab.ts`.

It must:

- load HostedConfig before allocating network resources;
- construct pooled `pg.Pool` with bounded size/timeouts;
- construct JWT verifier, repositories, authorization and existing sync/recovery composition;
- include no FixtureAuthVerifier import or selection path;
- bind `0.0.0.0` and `PORT`;
- use generic structured logs with redaction or keep logging disabled if safer;
- close Fastify and pool on SIGTERM/SIGINT;
- fail non-zero on invalid startup;
- expose minimal `/health/live` and generic `/health/ready`;
- refuse readiness if required migration 004 is absent or DB probe fails;
- never run migrations automatically.

Package scripts must provide:

```text
npm run build
npm start
npm run test:hosted-local
```

Compile to ignored output. `npm start` must run compiled JavaScript using production dependencies;
it must not require `tsx`, TypeScript or other devDependencies.

Production-start smoke must prove:

- invalid config fails before listen;
- valid synthetic local config listens;
- liveness reveals no provider/database details;
- readiness changes generically with database availability;
- signal shutdown releases port and pool;
- lab environment variables cannot switch hosted auth to fixtures.

## 9. CP7 — Drift v7 and Flutter ports

Add an additive Drift v7 migration only as needed for:

- stable UUIDv4 InstallationId independent from DeviceId;
- current hosted enrollment request/result/status metadata;
- public hosted environment alias if protocol state requires it.

Preserve all v6 facts, Device sequences, outbox, submissions, inbox, cursors and recovery progress.
Migration must never reset or reassign existing Device/Event identities. If an old installation lacks
InstallationId, generate one once during application logic after migration and persist atomically.

Add application ports equivalent to:

- `ExternalAuthenticationSession` — acquire/renew/logout credential without exposing SDK types;
- `AccessTokenSource` — return current API access token;
- `DeviceEnrollmentTransport` — identity/enroll/query/status/revoke;
- `HostedIdentityRepository` — durable InstallationId and enrollment result;
- `HostedSyncGuard` — prevent hosted sync until membership and Device are authorized.

Add an opt-in development hosted-auth lab composition. It may use a neutral lab-only surface to:

- start Auth0 Universal Login later in C10-S03B;
- display only typed states and sanitized aliases;
- enroll/query one installation;
- invoke existing synchronization ports;
- logout without deleting local facts.

No production page/navigation/dialog/banner/Device manager or visual polish. Normal composition
remains local-only unless an explicit development build flag and complete public configuration are
present. Native clients contain no client secret.

Tests use fake authentication/session adapters. Provider SDK calls must not occur in ordinary unit
tests or C10-S03A decisive proof. Add platform runner configuration only where the official SDK
requires it and verify no secret is embedded.

## 10. CP8 — Decisive local hosted-composition harness

Extend the disposable PostgreSQL 18 lab with a loopback RSA/JWKS issuer and production composition.
Do not call application services directly as a substitute for HTTP authorization.

Required story:

1. apply 001→004 and seed two Accounts plus synthetic identities/memberships through migrator
   fixtures;
2. Principal A valid token resolves exactly one Account;
3. Installation A enrolls; identical retry returns the same Device;
4. conflicting enrollment request is denied;
5. Installation B enrolls separately under the same Account;
6. A uploads a complete synthetic Purchase through HTTP;
7. B downloads, atomically applies and acknowledges it;
8. restart API/JWKS and prove identity continuity and idempotent retry;
9. owner A revokes B; B is denied upload/download/ack/recovery while local facts remain;
10. wrong-Account principal and forged Device cannot observe or mutate rows;
11. Auth/JWKS outage leaves local registration and pending submission available;
12. restored authorization reuses the same submission identity and converges;
13. health, logs and diagnostics remain sanitized;
14. close/reopen local databases and compare named facts;
15. emit `HOSTED_AUTH_READY=true`;
16. tear down keys, databases, containers, volumes, ports and generated artifacts.

Required fault floor:

- all CP3 token/JWKS cases;
- no/disabled/multiple membership;
- unknown, revoked, expired and mismatched Device;
- cross-Account identity, Device, event, acknowledgement, snapshot and session;
- enrollment replay/hash mismatch/concurrency/expiry/rate limit;
- revocation replay and authorization race;
- timeout after committed submission/enrollment;
- API/JWKS/database unavailable;
- pool exhaustion and bounded serialization retry;
- malformed/oversized body and response;
- runtime DDL/membership-provision denial;
- RLS no-context and per-table cross-Account denial;
- process interruption/startup/shutdown;
- v6→v7 migration/reopen/failure/no-reset;
- existing retention/recovery regression.

## 11. CP9 — Validation matrix

Run all applicable checks and record exact commands/results/counts:

### TypeScript/API

```text
npm ci
npm run format:check
npm run lint
npm run typecheck
npm test
npm run build
npm run test:hosted-local
npm audit --omit=dev
production dependency install/start smoke
```

### Flutter

```text
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build windows --release
flutter build apk --debug
```

Run platform builds only when host-supported and report exclusions precisely. A build is not real
Auth0 callback/runtime acceptance.

### Protected and repository checks

```text
python -m unittest discover -s tests
git diff --check
tracked and staged secret scan
disposable resource/port/process teardown
```

Do not install missing protected-project dependencies merely to improve a report unless already
authorized by repository conventions.

## 12. Security and file discipline

- Never log tokens, authorization codes, PKCE verifiers, raw claims, emails, database URLs,
  passwords, keys, provider hostnames, Purchase facts or snapshot bytes.
- Do not commit generated RSA private keys, databases, tokens, `.env`, compiled output or logs.
- Bind all disposable services to loopback.
- Keep identifiers synthetic and fixtures conspicuous.
- Do not modify permanent documentation, methodology, J/D/E/F, 00/05/06 or unrelated files.
- Do not edit protected Python/PySide6 application or database.
- Preserve `.vscode/` and untracked provider material without reading it.

## 13. G report requirements

Replace G/H/I only after implementation. G must include:

- baseline and final SHA;
- complete Git-derived changed-path inventory including G/H/I;
- dependency, migration, Drift and contract versions;
- exact validation commands/results/counts and host exclusions;
- JWT/JWKS, identity, membership, enrollment, revocation and denial matrix counts;
- migration/RLS/role and v6→v7 evidence;
- hosted start/shutdown and health evidence;
- two-installation HTTP convergence counts/cursors;
- secret scan and teardown;
- confirmation no Auth0/Neon/Render/provider credential or mutation occurred;
- deviations, unresolved risks and one J terminal state.

Commit implementation and G/H/I as one bounded commit unless a safe intermediate source-only
checkpoint is necessary. Push only `intermid-cycle-recovery`; never force-push.
