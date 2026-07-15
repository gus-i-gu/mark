# F_DSN_STAGE — C10-S03A Design Materialization Authority

> Sequence: FLX-INV-02 → Main D/E/F activation
> Unit: local hosted-authentication readiness architecture
> Baseline: `75ce8a10fd9e143ff421252796405b3d4a12cb2c`
> Authority: controlling Design contract for Codex, jointly with D/E
> Provider authority: none

## 1. Selected topology

Preserve and extend the dependency direction:

```text
Flutter domain/application
  ├─ local registration/outbox/recovery ports
  └─ external-auth + enrollment ports
        ↓
Drift / Auth0 SDK adapter / HTTP adapters
        ↓ bearer token + Installation/Device protocol identifiers
Fastify hosted composition
        ↓
JWT verifier → identity resolver → membership authorizer → Device authorizer
        ↓ authorized AuthContext(AccountId, DeviceId)
existing sync/recovery application services
        ↓
PostgreSQL transactions + explicit predicates + RLS
```

Flutter never connects to PostgreSQL, receives database credentials, verifies its own authorization
or embeds a native client secret. Auth0 authenticates an external subject; Markei PostgreSQL owns
membership and Device authorization.

## 2. Version boundaries

- Event: `purchase.registered`, payload version 3, unchanged.
- Cursor: `c10b:<integer>`, unchanged.
- Recovery snapshot: format 1, unchanged.
- Server migration: additive forward-only 004 after immutable 001–003.
- Drift schema: additive v7 after v6; authoritative facts and protocol queues unchanged.
- Hosted identity/enrollment API contract: version 1.
- JWT algorithm: pinned `RS256` for C10-S03A.

Do not introduce event v4, recovery v2, production retention defaults or protocol renaming.

## 3. Identity model

Keep five distinct identities:

```text
ExternalPrincipal = verified issuer + subject
ExternalIdentity  = Markei opaque identity mapped from principal
AccountMembership = authorization relationship and role
InstallationId    = stable UUID stored by one app installation
DeviceId          = server-authorized synchronization actor
```

Rules:

- issuer+subject uniqueness is provider-scoped and exact;
- subject/email/profile data never becomes AccountId or Person;
- membership, not token claims, yields Account authority;
- exactly one active membership is required by this composition;
- InstallationId is not secret, hardware identifier or Device proof by itself;
- Device binding requires verified identity, membership and idempotent enrollment;
- DeviceId remains the actor for sequence, event, acknowledgement, lease and recovery records;
- uninstall/lost InstallationId creates a new installation; no silent old-Device reuse;
- revocation affects server authorization, not local fact ownership.

## 4. Server data model — migration 004

Use repository-consistent UUID/text/check/timestamp conventions and composite Account ownership.
Exact names may vary only when existing conventions require it; invariants may not weaken.

### 4.1 `external_identities`

Candidate columns:

```text
identity_id UUID PK
issuer TEXT bounded NOT NULL
subject TEXT bounded NOT NULL
status active|disabled
created_at / updated_at
UNIQUE(issuer, subject)
```

This table contains no password, token, authorization code, email authority or Auth0 management
credential. Runtime may resolve only exact verified principal input through the repository contract.

### 4.2 `account_memberships`

Candidate identity:

```text
(account_id, identity_id)
role owner|member
status active|disabled|removed
version
created_at / updated_at
```

Account FK is composite where needed. Multiple memberships are structurally supported, but hosted
composition refuses zero or multiple active results. Runtime cannot provision/change membership.

### 4.3 `device_enrollments`

Candidate identity:

```text
(account_id, installation_id)
device_id
identity_id who enrolled it
state active|revoked|replaced
generation
enrolled_at / revoked_at / updated_at
```

`(account_id, device_id)` references existing Devices. Only one active binding exists per
Account+Installation. Device status and enrollment state must agree; any disagreement fails closed.

### 4.4 `device_enrollment_requests`

Candidate identity:

```text
(account_id, identity_id, enrollment_request_id)
installation_id
request_hash
state pending|completed|failed|expired
device_id nullable until completed
stored_result bounded JSON or normalized result columns
expires_at / created_at / completed_at
```

Same key/hash replays one result; key/hash mismatch conflicts. Do not use token hash, access-token
identifier or mutable platform metadata as the idempotency identity.

### 4.5 `device_security_events`

Append-only Account-scoped event codes for enrollment/revocation and denied state transitions.
Record opaque identities, correlation alias and timestamp only. This is operational audit evidence,
not a synchronization event stream and not exposed to Flutter in S03A.

## 5. RLS and privilege boundary

Existing request transactions set AccountId and DeviceId with transaction-local `set_config`.
Extend context only where required with an opaque IdentityId.

Authorization transaction must:

1. begin with bounded isolation/retry;
2. resolve exact verified principal to active Identity;
3. set transaction-local identity context if used by policy;
4. resolve active memberships;
5. require exactly one Account;
6. for enrollment, lock Account+Installation/request identities and create/replay Device atomically;
7. for protected operations, lock/recheck membership, enrollment and Device status;
8. set Account/Device RLS context;
9. execute existing operation with explicit Account/Device predicates;
10. commit authorization and mutation consistently.

Do not authorize once outside the transaction and then mutate without recheck. Existing bounded
serialization/deadlock retry remains. Retries preserve EnrollmentRequestId, SubmissionId and
RecoverySessionId.

Runtime role may:

- resolve exact external identity and memberships;
- enroll/query its authorized installation;
- create/read bounded enrollment request results;
- execute existing sync/recovery operations;
- perform authorized revocation under application rules.

Runtime may not:

- create/enable/disable/remove external identities or memberships;
- alter roles, schema, policies or migration ledger independently;
- build snapshots/cleanup through public routes;
- bypass RLS or own protected tables;
- read across Accounts or enumerate identities.

Migration and fixture provisioning remain direct migrator responsibilities. C10-S03A uses only
disposable local migrator fixtures.

## 6. Authentication ports and implementation

Refactor the current broad `AuthVerifier` boundary into responsibilities equivalent to:

```text
AccessTokenVerifier
  verify(request) → ExternalPrincipal

RequestAuthorizer
  authorizeIdentity(principal) → MembershipContext
  authorizeDevice(principal, requested identifiers) → AuthContext

EnrollmentService
  enroll/query/revoke under MembershipContext
```

Existing application services continue receiving the internal `AuthContext`; they do not learn
Auth0/JWT/JWKS types.

`Auth0JwtVerifier` requirements:

- bearer access token only;
- configured HTTPS issuer/audience;
- exact `RS256` allow-list;
- signature/issuer/audience/exp/nbf/sub validation;
- bounded token and JWKS inputs;
- issuer-bound JWKS URI;
- injected Clock, fetcher and cache policy;
- bounded TTL and stale-key rejection;
- concurrent refresh coalescing;
- one unknown-`kid` refresh;
- deterministic typed failure mapping;
- no raw token/claim logging.

Use a maintained JWT/JWK library rather than implementing RSA/JWT parsing or cryptography.
Dependencies must be pinned according to repository policy and recorded in I.

## 7. Enrollment API version 1

### 7.1 Identity status

```text
GET /v1/identity
```

Requires valid token. Returns only Markei status needed by the client:

- contract version;
- `membership-required | membership-confirmed | account-selection-required`;
- opaque AccountId only when exactly one membership is active;
- enrollment requirement/status for supplied installation context if contractually included.

No raw subject, email, role list for other Accounts or provider claims.

### 7.2 Enroll

```text
POST /v1/devices/enroll
```

Closed body:

```text
contractVersion
installationId
enrollmentRequestId
platformClass
applicationId
applicationVersion
```

Account authority derives from membership. Server canonicalizes/hash-checks closed content and
allocates DeviceId. Response contains DeviceId, enrollment state/generation, outcome and safe action.

### 7.3 Enrollment query

```text
GET /v1/devices/enrollments/:requestId
```

Bound to the same verified identity and Account. Unknown/foreign use one denial. Query never creates
a Device or changes request identity.

### 7.4 Device status

```text
GET /v1/devices/:deviceId/status
```

Returns only current caller-authorized Device status and retention/recovery eligibility class needed
by protocol. Foreign and absent IDs are indistinguishable.

### 7.5 Revoke

```text
POST /v1/devices/:deviceId/revoke
```

Closed request carries operation identity/reason code, not free text. Owner may revoke same-Account
Device; member may self-revoke current Device. Commit updates enrollment+Device status and appends
security event atomically. Replay is equivalent. No reactivation/delete/replace route.

## 8. Route integration

Every sync/recovery route uses a shared authorization pre-handler/orchestrator. Do not duplicate
partial token parsing or membership logic per route.

Request sequence:

```text
parse bounded request
→ verify external access token
→ resolve membership
→ resolve requested Installation/Device binding
→ transactionally recheck authorization
→ call existing service
→ map typed result to HTTP
```

For upload, request DeviceId and every event AccountId/DeviceId must match derived AuthContext.
For download/ack/recovery, only derived AuthContext scopes queries. Malicious acknowledgement cannot
advance beyond existing Account high-water and authorized Device checks.

## 9. Hosted configuration and process composition

Implement modules equivalent to:

```text
HostedConfig parser
HostedDependencies factory
HostedServer lifecycle
```

Configuration is immutable after startup. `MARKEI_SYNC_DATABASE_URL` is accepted only as the
least-privilege pooled runtime connection in the hosted process. The process has no migration
runner, worker cleanup authority, Auth0 Management API token or fixture-auth option.

Hosted entrypoint:

```text
validate config
→ allocate bounded pg.Pool
→ construct remote JWKS verifier
→ construct repositories/authorizer/recovery composition
→ build Fastify
→ listen 0.0.0.0:PORT
→ drain and close Fastify/pool on signal
```

Build compiles TypeScript to ignored JavaScript output. Start executes compiled JS under Node 24
without devDependencies. Lab entrypoints keep explicit `lab` names and cannot be deployed by the
production start script.

`/health/live` proves process liveness only. `/health/ready` performs bounded generic configuration,
migration-ledger and database availability checks. It does not expose role, database, branch,
provider, issuer, audience, key, version or exception details. Readiness does not prove auth or sync.

## 10. Flutter/Drift architecture

### 10.1 Drift v7

Extend installation metadata with:

- stable InstallationId UUIDv4;
- hosted enrollment request identity/result as protocol metadata;
- server DeviceId binding state where distinct from existing local Device record;
- updated timestamp/environment alias only if needed to prevent cross-environment reuse.

Preserve local facts and all v6 queues/cursors/recovery progress. A migration must not reinterpret
existing local DeviceId as server proof. When migrating, retain it as local actor data until explicit
enrollment returns the authorized Device mapping; do not discard events or silently rewrite their
Device identity. If synchronization requires rebinding pre-enrollment pending events, stop and report
the conflict rather than inventing a rewrite rule. Tests must cover this boundary.

### 10.2 Application ports

Use provider-neutral ports:

```text
ExternalAuthenticationSession
AccessTokenSource
DeviceEnrollmentTransport
HostedIdentityRepository
HostedSyncGuard
```

Auth0 Flutter SDK, platform callback configuration and HTTP remain infrastructure. Domain Purchase
registration does not depend on authentication availability.

### 10.3 Opt-in lab composition

Add a development-only hosted-auth lab entrypoint/composition selected by explicit build flag and
complete public configuration. It may provide neutral controls/status for later real login,
enrollment, logout and sync probe. It must never replace normal navigation or claim provider proof.

Public build configuration may include Auth0 domain, Native ClientId and API audience. It must not
include client secret, management token, database URL, signing key or Render secret. Credential
storage is behind the official SDK/adapter and must be testable without printing credentials.

## 11. Local decisive topology

```text
Flutter/HTTP test clients A and B
        ↓
production Fastify composition on loopback
        ↓
local Auth0-compatible RSA issuer/JWKS fixture
        ↓
disposable PostgreSQL 18 with 001→004 and least-privilege roles
```

The decisive harness must cross real HTTP and PostgreSQL boundaries. Direct service invocation may
supplement unit tests but cannot establish `HOSTED_AUTH_READY=true`.

Use two Accounts and multiple principals/installations to prove isolation. Test authorization with
the runtime role and migrations/provisioning with distinct local migrator authority. Preserve
C10-S02 recovery/retention behavior after authorization is added.

## 12. Threat model

| Threat | Required control |
| --- | --- |
| forged/wrong token | strict signature/issuer/audience/algorithm/time validation |
| ID token used as API token | audience/token-contract rejection |
| JWKS substitution | issuer-bound HTTPS URI and local explicit fixture override only |
| stale/unknown key | bounded cache, one refresh, fail closed |
| refresh stampede | coalesced concurrent fetch |
| token/claim leakage | redaction and no raw auth logging |
| cross-issuer subject collision | unique exact issuer+subject pair |
| Account enumeration | membership-derived Account and uniform foreign denial |
| forged Installation/Device | membership check plus stored binding and request hash |
| enrollment replay/race | unique keys, lock, idempotent stored result |
| unauthorized replacement | no implicit replacement; generation/state checks |
| revoked Device reuse | transaction-time membership/enrollment/Device recheck |
| membership removal race | membership lock/recheck before mutation commit |
| malicious acknowledgement | existing cursor bounds after derived AuthContext |
| runtime escalation | least privilege, RLS, no DDL/membership provision/worker rights |
| migration partial failure | transaction + ledger + failure rehearsal |
| secret environment leakage | fail-safe parser and value-redacted logs/errors |
| API/JWKS/DB outage | bounded timeout, typed unavailable, local-first queue preserved |
| process interruption | graceful drain, idempotent identities and restart tests |
| cross-environment Device reuse | explicit development environment binding/guard |

## 13. Rollback and compatibility

- Migration 004 is additive and forward-only; never edit/reverse 001–004.
- Hosted composition may be disabled by not selecting the hosted entrypoint/build.
- Prior local-only composition and lab tests remain available.
- A failed provider-ready implementation cannot fall back to fixture auth.
- Identity/membership/enrollment rows may remain inert when hosted service is disabled.
- Corrections after applied migration use migration 005+, never history rewrite.
- Drift v7 cannot reset/downgrade user facts; migration failure preserves the original database.
- Provider rollback is outside S03A and later means disable Render/provider development resources,
  not destructive local data rewrite.

## 14. Explicit exclusions

No live Auth0 token, Auth0 Management API, social/passwordless provider, Render deployment, Neon
migration, production secrets, production cleanup worker, object storage, backup/PITR integration,
Account invitation/pairing, Account-selection product flow, Device replacement/reactivation,
production database swap, Account deletion, UI redesign, Analytics or telemetry.

## 15. I report requirements

I must record:

- final dependency direction and port split;
- exact migration 004 tables, grants, policies and ledger behavior;
- Drift v7 schema and migration compatibility;
- JWT library/version, validation, cache/rotation/timeout rules;
- identity/membership/installation/Device invariants;
- enrollment/revocation idempotency and transaction boundaries;
- route-wide authorization and RLS behavior;
- hosted configuration, build/start/health/shutdown composition;
- Flutter SDK containment and public-versus-secret configuration;
- local decisive topology and threat results;
- architectural deviations and deferred provider/Main decisions;
- confirmation no provider was contacted or mutated.

Any deviation that weakens trust separation, route-wide recheck, local-first preservation or fixture
containment is a blocker, not an implementation detail.
