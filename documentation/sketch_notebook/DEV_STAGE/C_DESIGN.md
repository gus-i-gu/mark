# C_DESIGN — C10-S03A-R2 Hosted Authorization Correction

> Sequence: FLX-INV-02 investigative round
> Role: Design/Architecture [D]
> Branch / inspected HEAD: `intermid-cycle-recovery` / `34bc032df26d4b6d727d3ba6f2e08bbb0b11e13f`
> Source implementation: `02d6f1fb76ef28492038c054fdd4c0f8da898fcb`
> Authority: provisional investigation and Main handoff only
> Writable surface: `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX, PROVIDER MUTATION OR PROMOTION

## 1. Methodology and evidence retained

The complete `INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL` route was
read after both AGENTS files. Design owns architecture investigation, not source mutation or
semantic promotion. PRC-01 distinctions used below are:

- **source fact:** directly inspected repository behavior or structure;
- **report claim:** G/H/I statement not independently promoted by this report;
- **inference:** consequence derived from inspected facts;
- **proposal:** candidate architecture requiring Main selection and later evidence.

J at `34bc032` controls the stop boundary:

```text
C10-S03A_R1_CONTRADICTED_STOP
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```
Permanent Design memory retains the offline-first port/adaptor direction, separate external
identity/membership/InstallationId/DeviceId concepts, direct-migrator/runtime separation, and the
requirement that authorization remain valid through the protected database transaction. No source,
migration, permanent memory, J, A/B, D–I, provider, commit or push is authorized here.

## 2. Inspected responsibility graph

```text
hosted.ts
  → Auth0JwtVerifier (PrincipalVerifier)
  → HostedAuthVerifier (AuthVerifier + authorizeOperation)
  → HostedIdentityService
  → buildApp

app.ts
  → sync_service / recovery_service callbacks
  → protectedOperation
  → HostedAuthVerifier.authorizeOperation OR AuthVerifier.verify fallback
  → database.inTransactionWithContext

hosted_authorization.ts
  → hosted_contracts + protocol
  → database transaction/retry helper
  → external_identities / account_memberships / devices / device_enrollments
  → enrollment requests + security events

jwt_verifier.ts
  → jose JWT/JWK primitives
  → hosted_config issuer/audience/JWKS values
  → PrincipalVerifier consumed by both hosted services

Flutter coordinator
  → AccessTokenSource + DeviceEnrollmentTransport ports
  → HttpDeviceEnrollmentTransport + DriftHostedIdentityRepository
```

Supporting evidence inspected: migrations 001–004; `database.ts`; hosted/main/lab composition;
sync and recovery services; hosted contracts/config; Flutter enrollment ports/coordinator/HTTP/Drift
adapters; hosted unit tests and local harness; G/H/I; permanent Design files.

## 3. Accepted R1 structure and current contradictions

### 3.1 Accepted within bounds

**Source facts:** the eight sync/recovery handlers pass a `PoolClient` callback through
`authorizeOperation`; JWT verification precedes a serializable transaction; enrollment and Device
rows are then checked and locked before the service callback. JWT/JWKS input now has byte, timeout,
cache, cooldown, redirect and coalescing controls. Hosted composition does not import fixture auth.

**Report claim retained:** G records passing local TypeScript, Flutter, build and harness checks.
This C does not promote provider or hosted readiness from that evidence.

### 3.2 Actor/target authorization is unsound

**Source fact:** `revoke` proves membership, then lets a non-owner revoke when the untrusted
`x-markei-device-id` equals the path target. It never proves that header Device belongs to the
acting identity or is active. `deviceStatus` similarly applies membership plus target lookup without
an actor-identity or owner/member policy.

**Source fact:** `devices` RLS is constrained by both Account and current Device, while
`device_enrollments` is Account-scoped. A cross-Device owner action cannot inspect actor and target
`devices` under one static Device context.

**Required invariant proposal:** Device-authenticated management begins with an active actor
enrollment belonging to the principal. A member may inspect/revoke only that actor Device. An owner
may inspect/revoke any Device in the Account but must still use an active actor Device. The service
locks actor first, then switches transaction-local Device context and locks target. Foreign/absent
targets have one non-enumerating failure. Self-revocation may commit; subsequent requests fail.

Main must explicitly accept or replace that owner/member policy.

### 3.3 Membership concurrency is unresolved under least privilege

**Source fact:** `resolveOneMembership` defaults to an unlocked membership read.

**Source fact:** migration 004 grants runtime only `SELECT` on `account_memberships`. PostgreSQL
row-locking reads require privilege beyond this current grant; blindly enabling `FOR UPDATE` is not
a least-privilege correction. External identity status has the same ordering question.

**Inference:** serializable isolation alone can serialize an overlapping protected action before a
membership removal; it does not create an explicit authorization/mutation ordering protocol shared
by every future membership writer.

Alternatives:

1. **Grant UPDATE and lock membership directly.** Smallest code delta; broadens authority on
   security-owned rows and couples runtime to membership storage. Reject.
2. **Application advisory lock keyed by IdentityId/AccountId.** No table grant; efficient. Every
   membership/identity writer must voluntarily acquire the same lock, which the database schema
   does not enforce. Retain only as a lab technique, not the preferred production invariant.
3. **Additive authorization fence/procedure in migration 005.** A narrow security-definer function
   with fixed `search_path`, revoked PUBLIC execution, bounded result and audited ownership acquires
   a transaction lock and resolves active identity/membership. Membership mutations use a paired
   procedure/lock. Runtime receives EXECUTE only, not membership UPDATE. This is the recommended
   hypothesis, subject to privilege/RLS tests and Main approval of migration 005.

Alternative 3 must prove owner, function owner, `SECURITY DEFINER`, RLS, search-path, SQL-injection,
cross-Account and concurrent-writer boundaries. If this cannot be made simpler than broad grants,
R2 should stop rather than weaken membership protection.

### 3.4 Hosted authority remains structurally optional

**Source fact:** `HostedAuthVerifier` still implements public `verify`, which independently commits
an `AuthContext`. `app.ts` chooses transaction-scoped behavior through runtime property detection;
the generic fallback remains valid for fixture tests and can accidentally accept a hosted verifier.

Alternatives:

1. Keep duck typing and add tests. Low cost, omission remains possible. Reject.
2. Delete hosted `verify`, introduce `HostedOperationAuthorizer`, and make `buildApp` accept a
   discriminated composition: hosted routes require authorizer; fixture lab routes require the
   legacy verifier. Recommended.
3. Merge JWT, authorization and all handlers into one service. Strong containment but reverses
   dependency separation and harms testability. Reject.

Hosted production must have no path from token directly to a committed `AuthContext` outside the
operation transaction. Fixture fallback remains explicitly loopback/test-only.

## 4. Route authorization model

**Source fact:** `PROTECTED_ROUTE_POLICIES` lists eight sync/recovery routes, omits five identity and
Device routes, and is not the structure used to register routes. Its test compares the list with a
second hard-coded operation list rather than actual Fastify registrations.

**Recommended proposal:** one typed route descriptor owns method, path, operation, authentication
level, membership rule, actor-Device rule, role/target rule and handler. Registration consumes that
descriptor; it is not parallel documentation. Fastify `onRoute` capture or an equivalent exported
registration inventory then fails tests/startup when any `/v1` route lacks a descriptor.

Minimum policy classes:

| Route family | Principal | Membership | Actor Device | Target/role |
| --- | --- | --- | --- | --- |
| `/v1/identity` | required | queried, not prerequisite | none | own identity only |
| enroll/query enrollment | required | one active | none before enrollment | identity-bound request |
| Device status/revoke | required | one active | active and identity-bound | self member; any owner |
| sync/recovery | required | one active | active and identity-bound | same Account/Device operation |
| health | none | none | none | bounded generic result |

The registry must prevent a newly added protected route from compiling/registering without policy;
an after-the-fact hard-coded equality test is insufficient.

## 5. JWT/JWKS correction alternatives

**Source facts:** issuer/audience/RS256/time are passed to `jose`; explicit `jwksUri` accepts HTTPS
on any origin; duplicate `kid` is rejected only when JSON differs; refresh failure can retain a
local set after normal expiry without a separate stale deadline; unknown-key refresh can repeat
after successful refreshes that still omit the key.

Recommended bounded policy:

- derive JWKS from issuer in production, or require exact issuer origin and approved path;
- reject every duplicate `kid` and non-RSA/non-signing/non-RS256 key;
- bound subject by UTF-8 bytes as well as a closed character/string ceiling;
- distinguish `freshUntil` and optional `staleIfErrorUntil`; after the latter, fail closed;
- never satisfy unknown `kid` from stale keys; coalesce and cooldown its refresh attempts;
- allow one forced refresh per bounded cooldown window, then reject generically;
- preserve timeout, response-byte, redirect and key-count limits;
- never expose issuer, key IDs, claims, token or JWKS body in public errors/logs.

Alternative policies are strict expiry (simplest/security-first, lower outage tolerance) or a short
explicit stale-if-error grace (recommended availability balance). Unlimited stale use is rejected.
Tests need real two-key rotation, old/new tokens, identical duplicate ID, oversized subject,
timeout, refresh failure/cooldown/retry, unknown-key storm and stale-deadline exhaustion.

## 6. Flutter/server contract coherence

**Source fact:** the coordinator obtains a token but does not pass it through the transport port;
the HTTP adapter calls a separate synchronous token callback. Replay obtains no fresh token.

**Source fact:** server enrollment returns a typed conflict body with HTTP 200; the HTTP adapter
recognizes conflict only at 409 and then assumes every 2xx body is a successful enrollment.

Alternatives:

1. Transport owns token acquisition; coordinator stops acquiring tokens. Simple adapter, but auth
   state and enrollment orchestration split unpredictably.
2. Coordinator acquires one ephemeral token and passes a typed credential to `enroll/query` ports;
   transport only sends it and never stores it. Replay acquires a fresh token. Recommended.

Use one closed response contract: 2xx contains only a validated success union; typed failure bodies
map to non-2xx status (409 for conflicting identity, appropriate 401/403/404/503 elsewhere).
Flutter should decode the body discriminant before fields, bound response bytes and timeout, reject
unknown/additional malformed success shapes, and preserve unknown outcome for safe replay.

Proof must instantiate the real HTTP adapter against loopback Fastify, capture that the exact
coordinator token was sent, exercise conflict/status/replay, close/reopen a file-backed Drift DB,
and compare real outbox rows before/after cancellation, rejection, outage and unknown outcome.

## 7. Migration 003 and Neon bootstrap boundary

**Source fact:** migrations 001 and 003 conditionally create `markei_runtime` and
`markei_recovery_worker`. Accepted MCG-01 roles are SQL-created `NOCREATEROLE`; therefore the real
`markei_migrator` cannot create a missing recovery-worker role. Migration 003 is immutable.

Options:

1. Give migrator `CREATEROLE`. Rejected: conflicts with accepted role separation.
2. Edit migration 003. Rejected: breaks forward-only migration integrity.
3. Neon owner pre-creates a bounded `NOLOGIN`, `NOSUPERUSER`, `NOCREATEDB`, `NOCREATEROLE`,
   `NOINHERIT`, `NOREPLICATION`, `NOBYPASSRLS` `markei_recovery_worker`; migrator then applies
   immutable 001–004 and, if approved, 005. Recommended human bootstrap.

The SQL Editor action is a later human MCG step, not Codex work. Before it is activated, evidence
must show role absence/presence, closed attributes, no `neon_superuser` membership, migration hashes,
migrator/runtime identities, runtime DDL/ledger/provisioning/worker denial, RLS with no context and
cross-Account denial. No credential is provided to Codex or committed.

Rollback is provider-branch teardown or disabling hosted composition; never drop/alter shared roles
or edit applied migrations without separate human/Main authority.

## 8. Transaction and dependency invariants for R2

```text
Bearer bytes
→ PrincipalVerifier (cryptographic identity only)
→ hosted operation authorizer
→ authorization fence / active membership
→ actor enrollment + actor Device lock
→ explicit role/target policy
→ Account/Device RLS context
→ protected handler on same PoolClient
→ commit OR generic denial, never both
```

- JWT subject is neither AccountId nor DeviceId.
- Membership chooses Account; header/path values never grant authority.
- Actor Device and target Device are distinct variables even when equal.
- Lock order is fixed: identity/fence → membership → actor enrollment/Device → target Device →
  operation rows.
- Denied transactions leave events, submissions, cursor, acknowledgement, recovery, enrollment and
  security-event state unchanged.
- Bounded retry applies only to serialization/deadlock errors; exhausted retry is an unknown outcome
  with replay-safe action.
- The application layer depends on ports and domain contracts; Fastify/PostgreSQL/HTTP/Drift remain
  adapters. Provider SDKs and credentials do not enter domain code.

## 9. Truthful evidence composition

**Source fact:** the hosted harness emits five `=true` diagnostics after one sequential server path,
without executing the JWT suite, Flutter process, privilege-denial matrix, recovery routes or races.

Recommended evidence architecture:

- each unit/harness emits only its own named result after its assertions pass;
- an aggregator receives machine-readable result files/process exit codes, verifies required case
  IDs and commit/migration hashes, then emits a terminal diagnostic;
- TypeScript cannot claim Flutter proof unless it actually invokes and validates the Flutter suite;
- role proof queries `current_user` and explicit denials, not URL variable names;
- barrier hooks control membership removal, actor/target revocation, equivalent/conflicting
  enrollment, retries and unknown outcomes;
- route matrix covers every registry descriptor and verifies denial makes no state advance;
- G records exact commands, environment, counts, hashes, final SHA, exclusions and teardown.

Tests should be separated by responsibility but invoked by one decisive local runner. An
unconditional success print is rejected as architecture because it makes evidence forgeable by
control flow omission.

## 10. Recommended bounded correction and rollback

Recommended `C10-S03A-R2` materialization hypothesis:

1. freeze owner/member actor-target policy;
2. add a least-privilege authorization fence/procedure only if migration 005 is selected;
3. split hosted operation authorization from fixture `AuthVerifier` fallback;
4. register all `/v1` routes through the typed policy registry;
5. correct actor-bound status/revocation in one transaction;
6. enforce issuer-bound, rotation-safe and time-bounded JWKS caching;
7. bind one ephemeral Flutter token through the enrollment transport and normalize HTTP failures;
8. add real HTTP/file-backed/outbox and barrier-controlled server tests;
9. replace unconditional diagnostics with proof-owned aggregation;
10. retain migrations 001–004 unchanged and leave Neon/Render/Auth0 untouched.

Rollback: disable hosted composition; retain additive migration 005 structures inert; preserve all
local facts, outbox, cursors, recovery and hosted enrollment state; correct later only forward. Do
not reset Drift, edit migration history, weaken runtime privileges or discard security events.

## 11. Risks, confidence and unresolved Main decisions

| Item | Classification | Confidence |
| --- | --- | --- |
| non-owner header-based revocation flaw | source fact | high |
| status actor-policy gap | source fact | high |
| direct membership lock conflicts with current grant | source fact/inference | high |
| typed registry removes parallel route inventory | proposal | high |
| authorization fence/procedure is least-privilege fit | proposal | medium-high |
| owner must use active actor Device | proposed product/security rule | medium |
| bounded stale-if-error grace | proposed availability policy | medium |
| owner pre-created NOLOGIN worker unblocks immutable 003 | proposal | high |

Main decisions required before active D/E/F:

1. Accept owner/member status and revocation policy, including owner actor requirement.
2. Select migration-005 authorization fence/procedure or another proven least-privilege mechanism.
3. Select strict JWKS expiry or the exact stale-if-error grace.
4. Select 2xx-success/non-2xx-failure enrollment semantics.
5. Approve later human Neon owner bootstrap; it remains inactive during R2.
6. Define whether R2 is one unit or split into server-security and Flutter/evidence units.

## 12. Round result

Performance improvement: the investigation narrows the earlier generic race concern to a concrete
actor/target model, a privilege-compatible concurrency choice, one enforceable route registry and
closed JWT/Flutter/migration/evidence boundaries.

```text
C10-S03A_R2_DESIGN_INVESTIGATED
IMPLEMENTATION_AUTHORITY_INACTIVE
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```
