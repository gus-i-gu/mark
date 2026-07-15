# F_DSN_STAGE — C10-S03A-R3B Design Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: `2468c3912f1d0f3582e5eb241f104226b14c876f`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: bounded local architecture correction and proof

## 1. Selected architecture

R3B completes the accepted R3 architecture through five narrow corrections and decisive proof:

```text
per-attempt owned Flutter transport resources
+ lossless enrollment result mapping/persistence
+ one-refresh normalized JWKS state machine
+ readiness-bound Fastify route comparison
+ Device-row status projection
+ deterministic multi-producer proof
```

No dependency/version change, migration, Drift schema, provider SDK or new product surface is
selected. If direct compile evidence proves the pinned libraries cannot support the boundary, Codex
stops for Main rather than expanding scope.

## 2. Dependency direction

Retain:

```text
closed domain/application contracts
    ↑
coordinators and authorization services
    ↑
HTTP / Fastify / PostgreSQL / Drift adapters
    ↑
hosted / fixture / disabled / local-proof composition roots
```

Responsibilities:

- `jose`: signature/JWT/JWK cryptography;
- Markei JWT adapter: issuer/audience policy, bounded retrieval, normalization and cooldown;
- `package:http`: HTTP request/response mechanics;
- Markei transport: deadline, client ownership, byte ceiling and outcome translation;
- Drift: durable local facts/outbox/enrollment progress;
- Fastify: route lifecycle and request dispatch;
- Markei app builder: typed route policy and readiness equality;
- PostgreSQL: transactions, locks, RLS and migration capability;
- Markei authorization service: predicates, actor/target policy and state transitions.

Do not reproduce JOSE cryptography, parse Fastify route text or move raw HTTP/SQL details into
application ports.

## 3. Flutter transport ownership model

Preferred hosted construction:

```text
HttpDeviceEnrollmentTransport
  depends on HttpClientFactory
  one enroll/query attempt
    → create owned http.Client
    → establish one monotonic deadline
    → send/read using remaining time
    → close client on completion or failure
```

The factory may be a narrow typedef/function; a new broad abstraction is unnecessary. Tests may
inject an owned fake/factory.

If a borrowed-client constructor is retained:

- mark it explicitly as borrowed;
- never close that client;
- do not use it as evidence for request cancellation;
- preserve it only where existing tests/composition require it.

Deadline algorithm:

1. capture monotonic start/end once;
2. before send, headers and every body wait, calculate `end - now`;
3. fail immediately when remaining is non-positive;
4. race the complete operation against the same end condition;
5. close owned client on expiry so late network work cannot continue as owned work;
6. ignore any late completion through a settled-attempt guard;
7. return one closed unavailable/unknown result; throw no raw HTTP exception across the port.

A renewable stream timeout is allowed only as an additional inactivity defense, never as the total
deadline proof.

## 4. Enrollment contract model

The transport result must preserve wire meaning:

```text
sealed DeviceEnrollmentTransportResult
  success(status: deviceEnrolled | duplicateEquivalent)
  conflict
  unavailable
  unknownOutcome
```

Equivalent separate success subclasses are acceptable. A boolean or undifferentiated success is
not.

Coordinator mapping remains exhaustive. Both enroll and replay/query paths call one persistence
transition before returning a known outcome. Repository state must leave `enrolling` when a known
conflict, unavailable or unknown result is observed.

Use existing Drift v7 columns/states. If they cannot encode the closed mapping, stop: R3B does not
authorize v8 or an implicit lossy mapping.

Identity invariants:

- one Recovery/EnrollmentRequestId survives retry, query and reopen;
- token is never part of durable state;
- facts, outbox and sync cursor are independent of hosted enrollment outcome;
- transition persistence is idempotent for the same request/result;
- unknown outcome never creates a new server request identity automatically.

## 5. JWKS normalized state machine

Retain the existing cache/cooldown object and coalesced fetch. Add explicit per-lookup context:

```text
lookup(kid)
  → inspect usable cache
  → maybe consume one refresh budget
  → re-inspect requested kid
  → return key OR install miss/failure cooldown and reject
```

An expired-cache refresh and an unknown-key refresh are alternative uses of the same budget, not two
sequential fetches.

Normalize fetched entries before revision/storage:

```text
NormalizedRsaSigningJwk {
  kty: "RSA"
  kid: bounded non-empty string
  use: "sig"
  alg: "RS256"
  n: bounded base64url string
  e: bounded base64url string
}
```

Reject duplicate `kid`, private components, unsupported key type/use/algorithm, missing fields,
excess keys and oversized fields before cache replacement. Sort normalized keys by stable `kid`
and hash canonical JSON of only the closed projection. Feed only accepted normalized public keys to
the local `jose` resolver.

State transitions:

| Event | Cache/revision | Cooldown |
| --- | --- | --- |
| normalized set changed | replace, new revision | requested miss still gets per-kid cooldown |
| normalized set unchanged | refresh freshness only | requested miss gets per-kid cooldown |
| fetch failure with valid stale known key | retain within window | global failure cooldown |
| fetch failure without usable key | do not authorize | global failure cooldown |
| irrelevant metadata changes | same normalized revision | normal requested-key result |

Use injected clock and fetcher; no real provider/JWKS endpoint.

## 6. Fastify readiness inventory model

Retain typed route descriptors and root-level `onRoute` capture. Register one exact assertion in the
Fastify readiness lifecycle:

```text
install root capture
→ register application/plugins/routes
→ Fastify materializes plugin graph
→ onReady exact comparison
→ ready/listen/inject allowed or rejected
```

The assertion owns normalized actual `{method,path}` pairs and compares them with descriptors that
also carry operation/authorization class. It must not run only inside the synchronous tail of
`buildApp`.

Fastify normally rejects new route registration after readiness; therefore validating at readiness
closes the pre-service registration window. Verify this against the pinned Fastify version.

Tests must add:

- one direct route after `buildApp` but before `ready()`;
- one route through a registered encapsulated plugin;
- one missing/duplicate/misclassified descriptor case;
- the valid current application inventory.

All invalid cases must reject readiness or first `inject` before route execution.

## 7. Device status projection

The transaction authorizer already locks a target snapshot containing distinct fields. Public
status projection becomes:

```text
TargetDeviceSnapshot.deviceStatus → active | revoked
```

`enrollmentState` remains internal to enrollment workflow and revoke transition coordination. Do
not coerce it into public Device state. Preserve transaction/locking and existing authorization
policy; this is a projection correction, not a new workflow.

Use a deliberately divergent test fixture to prevent accidental equality from hiding regression.

## 8. Authorization transaction invariants

Retain the accepted path:

```text
verify JWT outside transaction
→ serializable bounded-retry transaction
→ identity/membership fence
→ Account/identity context
→ active actor enrollment + Device lock
→ Device/operation context
→ target policy/locks when applicable
→ protected operation
→ commit once or rollback all
```

Deterministic barrier hooks belong to lab/test infrastructure, not production API contracts. Place
them at named transaction points so tests can change membership/identity/Device state before the
relevant authorization lock. Do not use sleeps as race proof.

State snapshots for denied-no-advance proof should be produced by one reusable lab observer with
Account-scoped counts/identities, avoiding payload logs.

Revoke invariant:

```text
active target → atomic Device/enrollment revoke + exactly one security event
revoked target + active authorized actor → duplicate-equivalent, no event
self-revoked actor on later request → denied before target handling
```

## 9. Migration 006 evidence architecture

Migration files are immutable for R3B. Add/extend disposable proof infrastructure only.

Run separate scenarios from pristine databases for:

```text
fresh 001→006
upgrade 001→005→006
duplicate runner
failure-injected copy rollback
runtime ACL
owner/migrator ACL
temp/public shadowing
ledger absent/tampered
```

Never modify the canonical SQL to inject failure. Copy migrations to a disposable directory and
alter only the disposable copy. Hash canonical migrations before/after.

The runtime probe calls only `public.markei_hosted_runtime_ready()` and records a boolean. It must
also prove denial of direct ledger and old parameterized function.

## 10. Flutter file-backed system proof

Add a lab-gated test/harness that composes:

```text
temporary file-backed Drift v7
→ real HostedIdentityRepository/coordinator
→ real HttpDeviceEnrollmentTransport
→ loopback Fastify enrollment/status routes
→ synthetic disposable PostgreSQL where required
```

This proof may use fixture authentication only in the explicit loopback composition. It must not
contact provider services.

Seed real facts and a pending outbox through application/repository APIs where possible. Capture
stable IDs/counts before attempt, close/reopen the database, then compare facts/outbox/request state.
Delete temporary files and tear down services in `finally` paths.

The slow-response server must support deterministic header/body barriers so deadline tests are not
wall-clock flaky.

## 11. Producer and aggregate architecture

Each decisive producer emits a closed machine-readable record containing version, required case
names and booleans. At minimum:

```text
authorization-race
migration-006-acl
jwks-state-machine
route-inventory
flutter-http-file-backed
static-regression
```

One aggregator validates producer version/schema, exact required case set and all booleans. Unknown,
duplicate, missing, skipped, partial or false records make the aggregate false. It emits the complete
success diagnostic only after all producers pass.

Avoid a second hand-maintained truth list drifting from tests: keep required case names adjacent to
their producer contract and have the aggregator consume the exported contracts.

## 12. Versions and files

Retain:

```text
PostgreSQL migrations: 001–006
event payload: v3
cursor: c10b:*
recovery snapshot: format 1
hosted enrollment contract: v1
Drift schema: v7
JWT algorithm: RS256
```

Expected source impact is limited to the existing R3 Flutter transport/coordinator/ports/tests,
JWT verifier/tests, Fastify app/tests, Device authorization/tests and local harness/probes. New test
helpers may be split by responsibility. No dependency or lockfile change is expected.

## 13. Security and privacy boundaries

- no tokens, claims, JWK bodies, credentials, connection strings or fact payloads in logs/reports;
- no database/provider credentials in Flutter;
- no Auth0, Neon, Render or public endpoint access;
- no private helper/editor-file reads;
- loopback binding and synthetic data only;
- runtime remains least privilege;
- fixture authentication remains test/lab-only;
- temporary databases/files are always torn down.

Credential rotation and repository-history containment are a separate human/provider sequence and
do not count as R3B evidence.

## 14. Rollback and stop boundary

R3B rollback is the single bounded implementation commit. Migration state is unchanged, so no SQL
rollback migration is created. Preserve accepted R3 behavior if a proof mechanism fails.

Stop for Main if:

- correct cancellation requires dependency/version change;
- outcome persistence requires Drift v8;
- migration 006 requires editing or migration 007;
- Fastify lifecycle cannot provide a readiness-time closed inventory;
- provider/private data becomes necessary;
- a new product/account/device workflow is implied.

Report architectural deviations in I. Do not silently relax a contract or convert incomplete proof
into local-security success.
