<!-- TEMPORAL_MARKER:C10-S03A-R2-OPERATIONAL-INVESTIGATION-2026-07-15 -->
# A_OPERATIONAL — C10-S03A-R2 Local Authorization Correction

Sequence: FLX-INV-02
Role: Operational [O]
Branch: `intermid-cycle-recovery`
Inspected HEAD: `34bc032df26d4b6d727d3ba6f2e08bbb0b11e13f`
Implementation parent: `02d6f1fb76ef28492038c054fdd4c0f8da898fcb`
Evidence date: 2026-07-15
Status: provisional Operational investigation for Main; not Codex authority

## 1. Methodology retained

Read root and notebook `AGENTS.md`, `INDEX.md`, and the complete route
`METHOD_FOUNDATIONS -> FLUX -> PROMOTION_RULES -> CHAT_PROTOCOL`, followed by permanent
Operational memory.

Retained:

- Operational owns executable topology, failure ordering, validation, rollback, provider boundaries
  and honest diagnostics.
- A stages investigation for Main; only D/E/F may authorize Codex materialization.
- G/H/I are observational claims and must be reconciled against source and named evidence.
- PRC-01 keeps implemented, validated, contradicted, blocked and provider-pending claims distinct.
- No source, permanent memory, provider resource or credential is mutable through this report.

## 2. Scope and evidence classes

Primary source inspection:

- `services/markei_sync_api/src/application/hosted_authorization.ts`
- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/src/application/jwt_verifier.ts`

Traced dependencies/callers:

- `application/auth.ts`, `hosted_contracts.ts`, `hosted_config.ts`
- `postgres/database.ts`, migrations 001–004
- `sync_service.ts`, `recovery_service.ts`
- `hosted.ts`, `hosted_local_harness.ts`, `package.json`
- `test/hosted_auth.test.ts`
- Flutter hosted ports, coordinator, HTTP enrollment transport, Drift repository and their tests.

Evidence labels used below:

- **Source fact**: directly visible in repository code.
- **Report claim**: stated by G/H/I, not independently promoted here.
- **Inference**: consequence of inspected execution/privilege behavior.
- **Proposal**: candidate R2 correction requiring Main selection.

## 3. Current executable graph

```text
hosted.ts
  -> parseHostedConfig
  -> pg runtime pool
  -> Auth0JwtVerifier
  -> HostedAuthVerifier + HostedIdentityService
  -> buildApp

protected sync/recovery route
  -> protectedOperation
  -> HostedAuthVerifier.authorizeOperation
  -> serializable transaction
  -> identity + membership lookup
  -> enrollment + Device row lock
  -> sync/recovery callback on same PoolClient

identity/Device route
  -> HostedIdentityService method
  -> separate serializable transaction
```

**Source fact:** the eight sync/recovery callbacks now run inside the transaction that checks
enrollment and Device state. **Accepted bounded progress:** this corrects the earlier precommitted
authorization context for that route subset.

## 4. Blocking authorization defects

### 4.1 Actor Device is not authenticated for management operations

`HostedIdentityService.revoke` resolves membership, but a non-owner is accepted when the supplied
`x-markei-device-id` text equals the target path DeviceId. It never proves that header Device is
active or enrolled to the actor identity. An owner also need not prove an active actor Device.

`deviceStatus` resolves membership and selects an Account Device without an actor-Device check or
an explicit owner/member policy.

**Inference:** a member can potentially present another Account DeviceId as both actor header and
target and revoke it. Device management is therefore source-contradicted, not merely under-tested.

**Proposal:** freeze one rule:

```text
every status/revoke actor -> active identity + active membership + active actor enrollment + active actor Device
owner                  -> may inspect/revoke any Device in the same Account
member                 -> may inspect/revoke only its own active actor Device
```

Lock actor and target deterministically; when identical, lock once. Cross-Account and foreign
Device results remain bounded and non-enumerating.

### 4.2 Membership is not locked with the protected operation

`authorizeOperation` calls `resolveOneMembership` with its default `lock=false`; only enrollment and
Device rows use `FOR UPDATE`. A membership disable/removal may race a protected mutation.

Changing the call to `lock=true` is not independently executable: migration 004 grants runtime only
`SELECT` on `account_memberships`, while PostgreSQL row locking requires suitable write privilege.

**Proposal:** Main should choose a least-privilege ordering mechanism, preferably a narrow migration
005 function/lock contract or an equally reviewable transaction lock shared by:

- protected-route authorization;
- Device status/revocation;
- future membership disable/removal administration.

Do not broadly grant runtime membership mutation. The race test writer must use the same ordering
contract as the eventual membership writer; a migrator-only update is insufficient proof by itself.

External identity disable needs the same explicit ordering decision or a documented bounded
revocation-latency rule.

### 4.3 Unsafe alternate authorization API remains callable

`HostedAuthVerifier.verify` still returns `AuthContext` from a transaction that commits before a
later operation. Current hosted sync routes prefer `authorizeOperation`, but the public method and
feature-detection fallback allow a future route/composition to reintroduce TOCTOU authorization.

**Proposal:** make transaction-scoped authorization an explicit required hosted port. Contain legacy
`AuthVerifier.verify` to fixture/non-hosted composition rather than detecting capability with
`"authorizeOperation" in authVerifier`.

## 5. Route-registration defect

`PROTECTED_ROUTE_POLICIES` lists eight sync/recovery routes, but route handlers are registered
separately. Its test compares that constant to another hard-coded operation list. It cannot detect a
new route, a missing wrapper, or a mismatched operation string.

The inventory also excludes five hosted identity/Device routes, whose requirements differ:

```text
/v1/identity                                principal-only
/v1/devices/enroll                          active identity + one active membership
/v1/devices/enrollments/:requestId          same identity/membership + request ownership
/v1/devices/:deviceId/status                active actor Device + management policy
/v1/devices/:deviceId/revoke                active actor Device + management policy
```

**Proposal:** define one typed route registry that drives actual Fastify registration and names its
authorization class. At minimum, inspect `app.printRoutes()`/Fastify route metadata in a test and
compare every non-health hosted route against the registry. Unknown protected routes must fail
construction or validation, not silently use a weaker path.

## 6. JWT/JWKS evidence and residual gaps

Accepted source progress:

- RS256, issuer, audience, time and subject checks;
- token/JWKS byte ceilings;
- request timeout and redirect refusal;
- bounded key count and `kid` length;
- cache, cooldown and concurrent fetch coalescing;
- generic public rejection.

Residual operational gaps:

1. Explicit `MARKEI_AUTH_JWKS_URI` is HTTPS-checked by production config but is not constrained to
   the configured issuer origin.
2. Once cached keys expire, refresh failure returns the old local set without a final stale ceiling;
   repeated outage can therefore reuse stale keys indefinitely.
3. An unknown `kid` followed by a successful unchanged refresh resets cooldown, allowing repeated
   refresh pressure; negative-key cooldown is absent.
4. Identical duplicate `kid` entries are accepted; only conflicting duplicates are rejected.
5. Tests do not name genuine key rotation, timeout abort, expired-cache outage, stale-limit expiry,
   refresh recovery, duplicate-identical `kid`, oversized subject or repeated unknown-key pressure.
6. The hosted harness does not run the JWT suite before printing `JWKS_FAILURE_FLOOR=true`.

**Proposal:** bind production JWKS origin to issuer origin unless Main explicitly accepts a separate
allowlist; define fresh/stale/rejected time windows with an injected Clock; reject all duplicate
`kid`s; add bounded negative-key refresh state; prove rotation and outage transitions deterministically.

## 7. HTTP and Flutter interoperability blocker

**Source fact:** server enrollment returns a typed `ProtocolFailure` as HTTP 200 on conflicting
request identity. The local harness expects 200. Flutter recognizes conflict only at HTTP 409 and
otherwise decodes the failure object as a successful enrollment, causing missing-field failure.

**Source fact:** the coordinator obtains one token, but `DeviceEnrollmentTransport.enroll` does not
receive it. The HTTP transport calls a separate synchronous token callback, so same-token coherence
is unproved.

Other missing evidence:

- no test instantiates the real HTTP enrollment transport;
- no response-byte ceiling or request timeout in that transport;
- no owned `close()` lifecycle for its HTTP client;
- tests use in-memory Drift only;
- no real pending outbox row is compared before/after failure;
- the TypeScript harness executes no Flutter process.

**Proposal:** select one HTTP failure contract (prefer status consistent with the typed failure), pass
an explicit authorization value/request context through the transport call, bound HTTP behavior,
and run a loopback Fastify-to-real-Flutter-transport test with file-backed close/reopen and outbox
non-mutation evidence.

## 8. Neon migration and readiness blockers

### 8.1 Recovery-worker role bootstrap

Migration 003 executes `CREATE ROLE markei_recovery_worker` when absent. Accepted MCG-01 evidence
says real `markei_migrator` is `NOCREATEROLE`; the disposable lab migrator required `CREATEROLE`.

Migration 001 has the same pattern for `markei_runtime`, but the real runtime role already exists, so
that branch should be skipped. Migration 003 still requires the worker role to pre-exist.

**Proposal for later human SQL Editor action, not active authority:** a Neon owner pre-creates the
exact bounded `NOLOGIN`, non-elevated worker role; the migrator then applies immutable 001–004. The
role attributes, ownership and migration checksums must be sanitized evidence. Codex receives no
provider credential.

### 8.2 Readiness cannot read the ledger under stated privileges

`readyStatus` queries `migration_ledger` through the runtime pool. No migration grants runtime
`SELECT` on that table. The catch converts permission denial to `not-ready`.

**Inference:** a genuinely least-privilege hosted runtime can remain permanently not-ready even after
migration 004 succeeds.

**Proposal:** migration 005 should expose only a narrow readiness function/view or another bounded
capability check while preserving runtime denial of migration-ledger reads/writes. Do not solve this
with broad ledger access.

## 9. False-positive diagnostics

After one sequential HTTP flow, `hosted_local_harness.ts` unconditionally prints five `true` flags.

| Diagnostic | What the harness actually proves | Result |
| --- | --- | --- |
| `LOCAL_TRANSACTION_AUTHORIZATION` | one upload/download/ack path plus later revoked denial | partial |
| `LEAST_PRIVILEGE_HTTP` | two supplied URLs; no `current_user` or denial matrix | contradicted as decisive |
| `TWO_ACCOUNT_ISOLATION` | one foreign Device/event request denied | partial |
| `JWKS_FAILURE_FLOOR` | one generated key and successful fetch | false-positive |
| `FLUTTER_HOSTED_LAB` | no Flutter execution | false-positive |

The harness does not assert distinct database identities, runtime DDL/role/provisioning/worker
denials, no-context RLS, recovery routes, concurrency barriers, restart, or denied-state
non-advancement.

G correctly ends `PARTIAL`, but leaves Final SHA pending and overstates several individual proofs.

## 10. Required R2 race/failure matrix

Use deterministic barriers/hooks, bounded timeouts and post-transaction state checks.

| Race/failure | Required result |
| --- | --- |
| membership disabled/removed vs each protected route class | ordered commit or denial; never accepted after revocation commits |
| identity disabled vs protected mutation | selected ordering/latency contract demonstrated |
| actor Device revoked vs upload/download/ack/recovery | deterministic denial/rollback |
| target revoke vs actor revoke/status | no foreign/self policy bypass; idempotent terminal state |
| equivalent concurrent enrollment | one Device/result, replay equivalent |
| same request ID with different hash | conflict; no accepted mutation |
| same installation with different request IDs | one defined Device/generation outcome |
| response loss after enrollment commit | query/replay recovers the same result |
| restart between request persistence and response | durable equivalent recovery |
| JWT cache expiry + outage | only time-bounded stale policy; then rejection |
| unknown-key burst and key rotation | bounded refresh; new valid key accepted |
| denied request | no cursor, event, acknowledgement, session or security-event advancement |

Exercise all eight sync/recovery operations by policy class; use per-route cases where mutation or
rollback consequences differ.

## 11. Least-privilege proof floor

The decisive local lab must create/receive separate named roles and assert:

```text
migrator current_user != runtime current_user
migrator applies reviewed 001 -> 002 -> 003 -> 004 -> optional 005
runtime owns no schema/table and cannot CREATE/ALTER/DROP
runtime cannot create/alter/grant roles
runtime cannot read/write migration ledger directly
runtime cannot provision external identity or membership
runtime cannot invoke snapshot build/cleanup worker authority
runtime with empty Account/Device/identity context sees no tenant facts
runtime cross-Account and cross-Device access is denied per affected table
hosted Fastify receives only the runtime pool
```

Capture role names, server version, migration IDs/checksums, counts and pass/fail only. Do not print
URLs, passwords, tokens, claims, facts or JWKS bodies.

## 12. Bounded R2 execution plan

1. Freeze Device-management actor/target policy and transaction-lock mechanism in Main D/E/F.
2. Add forward-only migration 005 only if needed for narrow locking/readiness; never edit 001–004.
3. Replace feature-detected hosted authorization with an explicit transaction-authorizer boundary.
4. Make the typed route registry control or mechanically verify actual route registration.
5. Correct actor binding, membership/identity ordering and Device-management behavior.
6. Close JWKS origin, stale-window, negative-refresh and rotation gaps.
7. Align server/Flutter failure status and bind the coordinator token to the real HTTP request.
8. Add deterministic unit, route, race, denial, restart and real-transport tests.
9. Rebuild the disposable dual-role PostgreSQL harness and truthful diagnostic aggregation.
10. Run full TypeScript/Flutter/Python/build validation and write exact G/H/I evidence.

Recommended split inside one local unit:

```text
R2A server authorization + migration 005 + JWT/JWKS + dual-role proof
R2B Flutter real HTTP enrollment + file-backed persistence/outbox proof
R2 reconciliation only after both pass
```

Do not let R2 expand into Auth0 SDK integration, Account signup/invitations, management UI, Render,
Neon migration execution or provider proof.

## 13. Validation commands/evidence expected

Repository checks:

```text
npm run format:check
npm run lint
npm run typecheck
npm test
npm run build
npm audit --omit=dev
explicit dual-role hosted/race harness
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --debug
flutter build windows --release (host-supported)
python -m unittest discover -s tests
git diff --check
tracked/staged secret scan
disposable-resource teardown check
```

Evidence must bind each diagnostic to its producing command and named assertions. Build results do
not prove runtime/provider behavior. Host-blocked checks remain `host-unvalidated`.

## 14. Rollback and stopping rules

- Stop on J/D/E/F contradiction, route-policy ambiguity, broad privilege expansion, migration
  mutation, provider dependency or inability to construct deterministic barriers.
- No provider URL, password, token, client secret or private configuration enters Git or reports.
- R2 rollback is its bounded source/migration-005 commit plus disposable database teardown.
- Forward migration 005 is not manually reversed on shared/provider state; provider application is
  outside this unit.
- Preserve local outbox/facts on every authentication, enrollment, timeout and unknown outcome.
- Do not print a proof flag when its own executable gate was skipped or failed.

## 15. Operational classification

| Claim | Classification |
| --- | --- |
| same-transaction sync/recovery Device check exists | implemented; narrow path exercised |
| membership/identity revocation ordering | contradicted/incomplete |
| safe Device status/revocation actor binding | contradicted by source |
| route-wide enforceable policy inventory | not implemented |
| bounded JWT/JWKS subset | implemented; partial validation |
| complete JWT/JWKS failure floor | contradicted diagnostic |
| distinct least-privilege runtime proof | not validated |
| Flutter authenticated HTTP enrollment | contradicted/incomplete |
| Neon migrations executable by accepted migrator alone | blocked by role bootstrap |
| provider proof readiness | blocked |

Recommended Main status remains:

```text
C10-S03A_R1_CONTRADICTED_STOP
C10-S03A_R2_RESTAGING_REQUIRED
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Confidence: high for source-level authorization, readiness and Flutter-contract defects; high for
missing diagnostics/race evidence; medium-high for the proposed least-privilege migration-005 shape
until Design and Main select its exact ownership contract.
