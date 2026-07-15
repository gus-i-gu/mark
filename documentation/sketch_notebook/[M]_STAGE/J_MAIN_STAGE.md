# J_MAIN_STAGE — C10-S03A-R1 Post-Codex Reconciliation

> Sequence: FLX-ORD-01 → Main evidence reconciliation
> Cycle/unit: Cycle 10 / C10-S03A-R1
> Staging baseline: `8b84c4442e2e7be2a28fc1b34bdc60d45256d25d`
> Codex commit: `02d6f1fb76ef28492038c054fdd4c0f8da898fcb`
> Status: `C10-S03A_R1_CONTRADICTED_STOP`
> Provider authority: none

## 1. Methodology retained

Main retained:

- D/E/F jointly defined the materialization contract.
- G/H/I are observational evidence and cannot promote their own terminal claim.
- PRC-01 keeps implemented, validated, partial, host-unvalidated and contradicted states distinct.
- Source inspection may contradict reports; the contradiction must remain visible.
- Provider dashboards, local mechanisms and hosted validation are separate evidence classes.
- Permanent promotion and learner maturity do not follow automatically from code changes.

The human requested parallel domain studies. Operational, Didactic and Design reviews were run
read-only while Main inspected source, tests, reports and Git history. They did not edit A/B/C or
permanent memory. J owns the cross-domain reconciliation below.

## 2. Evidence inventory

Git ancestry:

```text
d411e4e  recovered permanent Cycle 10 memory
8b84c44  C10-S03A-R1 D/E/F authority
02d6f1f  Codex R1 implementation and G/H/I
```

Codex changed 13 paths:

- five Flutter application/infrastructure/test paths;
- five TypeScript authorization/JWKS/harness/HTTP/test paths;
- G/H/I.

No migration, dependency lockfile, permanent domain file, methodology file, J or D/E/F changed.
Migrations 001–004, Drift v7, event payload v3, cursor format and recovery format remain unchanged.

Controlling evidence read together:

- D/E/F at `8b84c44`;
- G/H/I at `02d6f1f`;
- changed source and tests;
- migration 003/004 and database transaction helper;
- current permanent Operational, Didactic and Design checkpoints;
- three independent read-only domain studies.

## 3. Codex result and Main disposition

Codex correctly reported:

```text
C10-S03A_R1_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

and named the missing barrier/hook race matrix. Main accepts the honesty of that partial result but
finds additional source/report contradictions that make the controlling status stricter:

```text
C10-S03A_R1_CONTRADICTED_STOP
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

The contradiction is not that all R1 work failed. Substantial local mechanisms exist. The
contradiction is that decisive diagnostics and some G/H/I wording claim proof beyond the paths and
tests actually exercised, while Device-management authorization contains a live flaw.

## 4. Materialized progress accepted within bounds

### 4.1 Transaction callback for sync/recovery

The eight existing synchronization/recovery routes now call `protectedOperation`, and hosted
composition delegates to `HostedAuthVerifier.authorizeOperation`. JWT verification yields an
external principal; membership, enrollment and Device state are read inside a serializable
transaction; the protected service callback uses the same `PoolClient`.

This corrects the earlier two-transaction shape for those eight routes. It is accepted as
implemented and locally exercised for the narrow sequential upload/download/acknowledgement path.

It does not yet establish every hosted route, concurrency outcome or future route registration.

### 4.2 Bounded JWT/JWKS source

The verifier now includes:

- `RS256`, issuer, audience, time and subject checks;
- bounded bearer/token and JWKS response bytes;
- timeout/abort path;
- cache maximum age and refresh cooldown;
- redirect refusal;
- bounded key count/identifier;
- conflicting-key rejection;
- refresh coalescing;
- generic token-rejected errors.

Named local generated-key tests cover a meaningful adversarial subset. Main accepts this as a major
implemented and locally validated mechanism, not Auth0/provider acceptance.

### 4.3 Separate connection variables

The harness now requires `LAB_MIGRATOR_URL` and `LAB_RUNTIME_URL`, applies migrations/seeding
through the first, closes its migrator pool, and starts Fastify using the second.

This is implemented topology. It is not yet decisive least-privilege proof because the harness does
not verify the connected role identities or perform the required runtime-denial probes.

### 4.4 Synthetic Account/Device topology

The harness creates:

```text
2 Markei Accounts
2 external identities
3 installations
3 Devices
```

It exercises sequential enrollment/replay/conflict, two Devices for Account A, one Device for
Account B, one cross-Account Device denial, upload/download/acknowledgement and one sequential
revocation denial. These are accepted local facts within that exact path.

### 4.5 Flutter scaffolding

R1 adds:

- lab authentication/token sources;
- hosted enrollment coordinator;
- HTTP enrollment transport;
- Drift identity repository/guard behavior;
- cancellation, token rejection, outage and replay tests using a fake transport.

This is accepted as provider-neutral scaffolding and local state-machine evidence. End-to-end
authenticated HTTP enrollment, file-backed reopen and real outbox non-mutation remain unproved.

### 4.6 Regression reports

G reports passing TypeScript checks, 21 tests, hosted-local harness, Flutter analysis, 56 Flutter
tests, Android debug build, Windows release build and five Python regressions. It also reports
container teardown and no provider access.

Main preserves these as Codex-recorded evidence. Independent npm execution in this reconciliation
checkout could not install dependencies because the host npm cache/filesystem repeatedly failed;
therefore Main adds no independent test result and does not reinterpret that host failure as a
product failure.

## 5. Controlling security contradictions

### 5.1 Non-owner Device revocation trusts an unproved actor header

`HostedIdentityService.revoke` verifies principal and membership, but for a non-owner it permits
revocation when the request header DeviceId equals the path target. It does not prove that the
header Device is actively enrolled to the acting identity.

An ordinary member can therefore present another DeviceId as both header and target and satisfy the
self-revocation comparison. Owner revocation also does not require an active actor Device.

This contradicts F's actor/target ownership rule and D's transaction-scoped Device authorization
requirement. It is a source-level authorization flaw, not merely missing evidence.

Required correction:

```text
resolve active actor identity/membership
→ resolve and lock active actor enrollment/Device when Device-authenticated action is required
→ validate actor role
→ resolve and lock target Account/Device
→ revoke target and append security event in the same transaction
```

The exact owner action policy must be explicit; an untrusted header cannot prove actor ownership.

### 5.2 Device status lacks identity ownership

Device status verifies Account membership and then queries by AccountId+DeviceId. It does not bind
the requested Device to the acting identity or apply an explicit owner/member policy.

Main does not assume every member may enumerate every Account Device. R2 must freeze and test the
policy, with generic foreign/unknown results.

### 5.3 Membership/removal ordering is not proved

`authorizeOperation` runs under serializable isolation and locks enrollment/Device rows, but calls
`resolveOneMembership` with its default `lock=false`. Identity/membership rows are not explicitly
locked in the required order.

Serializable isolation may reject an unsafe race, but no barrier-controlled membership
disable/remove race proves that behavior or bounded retry. The implementation therefore does not
establish E/F's deterministic ordering claim.

Simply changing the call to `lock=true` is not yet an approved fix: migration 004 grants runtime
only `SELECT` on `account_memberships`, while a row-locking clause may require additional table
privilege. R2 must select a least-privilege concurrency mechanism shared with future membership
administration—potentially a narrowly scoped database function/lock contract or additive migration
005—without granting broad membership mutation authority to runtime. External-identity disable has
the same concurrency question.

### 5.4 Unsafe `verify` authority remains public

`HostedAuthVerifier.verify` still creates and commits an authorization context independently.
Hosted sync/recovery currently take the newer `authorizeOperation` path, but the old public method
remains usable and future route code could reintroduce the original time-of-check/time-of-use defect.

R2 must either remove/contain that authority from hosted composition or make omission structurally
impossible through a typed protected-operation interface.

## 6. Route-inventory contradiction

`PROTECTED_ROUTE_POLICIES` lists only eight sync/recovery routes. It omits:

```text
/v1/identity
/v1/devices/enroll
/v1/devices/enrollments/:requestId
/v1/devices/:deviceId/status
/v1/devices/:deviceId/revoke
```

D/F required all protected hosted routes to declare authentication, membership, Device, role and
transaction policy.

The current test compares the manually maintained eight-entry constant with another hard-coded
eight-operation list. It does not compare actual Fastify registrations with policy declarations and
cannot detect a newly added unguarded route.

Classification: eight-route callback conversion implemented; enforceable route inventory
contradicted/incomplete.

## 7. Concurrency and restart proof gaps

No named barrier/hook tests prove:

- membership disable/remove versus each protected operation;
- Device/enrollment revocation versus each protected operation;
- concurrent equivalent enrollment;
- concurrent conflicting enrollment;
- deterministic serialization/deadlock retry and exhaustion;
- restart followed by server enrollment replay/revocation;
- denied operation leaving every cursor/ack/sequence/recovery state unchanged.

The sequential harness cannot substitute for this matrix. Codex correctly marked this blocker.

## 8. JWT/JWKS residual gaps

The new verifier is materially stronger, but D's complete named floor is not exhausted. Missing or
insufficiently isolated evidence includes:

- oversized subject;
- identical duplicate `kid` handling (current validation rejects conflicting duplicates but permits
  identical duplicates);
- genuine key rotation from old to new key;
- explicit timeout test;
- refresh failure followed by cooldown and bounded retry;
- issuer-origin binding for an explicitly configured JWKS URI;
- a bounded stale-cache outage: current refresh failure accepts any existing local cache even after
  its declared expiry, allowing repeated outage use without a separately enforced stale limit;
- repeated unknown-`kid` refresh control after successful refreshes that still lack the key;
- exact public failure mapping for every case.

The harness prints `JWKS_FAILURE_FLOOR=true` without executing the JWT/JWKS suite. Main classifies
the verifier/test subset as locally validated and the complete floor diagnostic as contradicted.

## 9. Least-privilege proof contradiction

Two URL variable names do not prove distinct roles or least privilege. The harness does not assert:

```text
current_user differs
runtime DDL denial
runtime migration-ledger denial
runtime identity/membership provisioning denial
runtime worker snapshot/cleanup denial
RLS no-context failure
```

`LEAST_PRIVILEGE_HTTP=true` is printed after a successful sequential HTTP path regardless of those
missing probes. G's claim that decisive least privilege passed is stronger than source evidence.

Classification: split connection topology implemented; decisive least-privilege proof contradicted.

## 10. Flutter integration contradictions

### 10.1 Token seam is disconnected

The coordinator obtains an access token but calls `DeviceEnrollmentTransport.enroll(command)`
without passing that credential. `HttpDeviceEnrollmentTransport` separately reads a token from a
different injected callback. Tests use a fake transport and do not prove the token obtained by the
coordinator is the token sent by HTTP enrollment/query.

### 10.2 HTTP conflict contract is inconsistent

The server enrollment conflict is a typed `ProtocolFailure` returned with HTTP 200; the harness
explicitly expects 200. The Flutter transport recognizes conflict only for HTTP 409 and otherwise
decodes the 200 failure object as a success result with missing fields.

This is a concrete interoperability defect.

### 10.3 Real HTTP/reopen/outbox proof is absent

- No test instantiates `HttpDeviceEnrollmentTransport`.
- Coordinator tests use an in-memory database and do not close/reopen a file-backed database.
- Local cancellation/outage state is tested, but real pending outbox rows are not created and
  compared before/after enrollment attempts.
- The HTTP transport does not show explicit response-size/timeout bounds.

`FLUTTER_HOSTED_LAB=true` is emitted by the TypeScript harness without executing Flutter code.
Main accepts the scaffolding/tests and rejects the decisive Flutter-lab diagnostic.

## 11. Diagnostic and report integrity

The harness unconditionally prints:

```text
LOCAL_TRANSACTION_AUTHORIZATION=true
LEAST_PRIVILEGE_HTTP=true
TWO_ACCOUNT_ISOLATION=true
JWKS_FAILURE_FLOOR=true
FLUTTER_HOSTED_LAB=true
```

after one narrow sequential server flow. It does not execute recovery routes, races, privilege
denials, JWT failure suite or Flutter code. Diagnostics must be emitted only by the evidence that
proves them, or aggregated by a runner that verifies each independent result.

G also leaves `Final SHA` pending and omits exact environment-safe role/container creation commands,
migration hashes, denial probes, barrier inventory and file-backed Flutter reopen evidence required
by D.

Classification: G/H/I preserve useful evidence and the correct PARTIAL terminal result; several
individual proof claims/diagnostics are contradicted or incomplete.

## 12. Neon migration authority conflict

Migration 003 creates `markei_recovery_worker`. The accepted MCG-01 evidence says the real Neon
`markei_migrator` is `NOCREATEROLE`. I reports that the disposable lab migrator needed
`CREATEROLE` to execute migration 003.

Therefore the current MCG-02 migration sequence cannot simply run 001→004 as the real migrator.
Before provider activity, Main must select a human-controlled bootstrap such as:

```text
Neon owner pre-creates bounded NOLOGIN recovery-worker role
→ markei_migrator applies immutable migrations
```

or another reviewed least-privilege mechanism compatible with immutable migration 003.

Codex must not receive owner/migrator credentials. No Neon action is authorized by this J.

## 13. PRC-01 claim classification

| Claim | Result |
| --- | --- |
| eight sync/recovery callbacks share authorization transaction | implemented; narrow local path exercised |
| route-wide hosted authorization | contradicted/incomplete |
| active actor Device required for revocation | contradicted by source |
| deterministic membership/revocation race ordering | provisional; decisive evidence absent |
| bounded JWT/JWKS source | implemented; meaningful local subset validated |
| complete JWT/JWKS floor | partial/contradicted diagnostic |
| separate migrator/runtime URL topology | implemented |
| decisive least-privilege HTTP topology | contradicted diagnostic |
| two-Account model and one denial | locally exercised subset |
| complete cross-Account matrix | partial |
| Flutter provider-neutral scaffolding | implemented; fake-adapter tests passed per G |
| Flutter authenticated HTTP enrollment | contradicted/incomplete |
| file-backed Flutter reopen/outbox preservation | not validated |
| migrations 001–004 unchanged | accepted by Git evidence |
| no provider access | accepted from scope/report/source |
| `C10-S03A_R1_LOCAL_SECURITY_PROVED` | rejected |
| MCG-02 provider readiness | blocked |

## 14. MCG-01 and MCG-02 status

MCG-01 remains accepted only as sanitized development-environment capability:

- isolated development branch/database;
- PostgreSQL 18.4 and TLS;
- separate `NOCREATEROLE` migrator/runtime identities;
- rollback, runtime CRUD and runtime DDL denial probes.

It does not prove migration 003/004 application, recovery-worker bootstrap, pooled RLS, hosted API or
production behavior.

MCG-02 remains:

```text
MCG-02_PROVIDER_DASHBOARD_PREPARATION_PARTIAL
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Do not:

- apply migrations to Neon;
- pre-create provider roles;
- enter real secrets into Render;
- deploy Render;
- provision real Auth0 users/memberships;
- begin Android/Windows callback proof.

The prepared provider UI runbook remains inactive.

## 15. Required next corrective unit

Authorize investigation/restaging for one narrow `C10-S03A-R2` only. It must address:

1. Active actor Device/identity authorization for Device status and revocation.
2. Explicit owner/member Device-management policy.
3. Identity/membership lock or demonstrably equivalent concurrency ordering.
4. Barrier-controlled removal/revocation/enrollment/retry tests.
5. One enforceable policy registry bound to actual Fastify route registration.
6. Removal/containment of the unsafe hosted `verify` authority.
7. Complete remaining JWT/JWKS cases, issuer binding and time-bounded stale-cache policy.
8. Distinct-role identity checks and runtime denial probes in the harness.
9. One consistent HTTP enrollment failure contract.
10. Token flow bound from coordinator to real HTTP transport.
11. Real HTTP transport tests, bounded response/timeout behavior and file-backed reopen.
12. Explicit outbox-before/after non-mutation evidence.
13. Honest diagnostics emitted only after their own proof passes.
14. Correct G final SHA, commands, hashes, counts and exclusions.
15. A separately reconciled human recovery-worker bootstrap decision for later MCG-02.

R2 remains local-only. It must not contact providers or broaden into production Account signup,
invitation, Account-selection UI or Device-management UI.

## 16. Permanent memory and future gates

Permanent Operational/Didactic/Design memory already records the prior contradiction and MCG-02
boundary. No permanent promotion is authorized from this J until R2 produces and Main reconciles
new G/H/I. Domain chats may later append observational correction history without promoting
readiness.

MCG-03/04 remain undefined/inactive. Cycle 10 remains open. No Cycle 11 work is activated.

## 17. Terminal Main result

```text
C10-S03A_R1_CONTRADICTED_STOP
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Confidence is high for source-level contradictions and medium-high for recorded validation results.
Independent test execution in this checkout was host-blocked by dependency installation/cache
failure; that exclusion does not weaken the directly inspected authorization/interoperability flaws.
