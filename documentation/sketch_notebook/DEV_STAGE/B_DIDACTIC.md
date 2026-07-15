# B_DIDACTIC — C10-S03A-R3 Semantic Correction Investigation

> Sequence: FLX-INV-02
> Role: Didactic Chat
> Round: C10-S03A-R3 investigation before Main restaging
> Branch: `intermid-cycle-recovery`
> Baseline / inspected HEAD: `06d694aa8fb88a43c47fca3eccd02c909c193f2f`
> Authority: human R3 investigation request plus current J; no Codex authority
> Writable surface: this file only
> Evidence boundary: project-owned source, tests, manifests and R2 stage/report evidence; local-only
> Status: **PROVISIONAL — NOT AUTHORIZED FOR CODEX OR PROMOTION**

## 1. Recovery and semantic boundary

Recovered in the required order:

```text
AGENTS → INDEX → sketch_notebook/AGENTS
→ METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
→ current J → D/E/F → G/H/I
```

The current J accepts meaningful R2 progress but identifies source contradictions. D/E/F authorized
R2 only; G/H/I are R2 observational evidence. This R3 report explains the contradictions and the
proof needed to close them. It does not implement R3, restage D/E/F, change learner maturity,
promote permanent memory, contact a provider or claim validation.

Inspected implementation surfaces were limited to the relevant TypeScript server, migration 005,
hosted harness/tests, Flutter hosted-enrollment ports/coordinator/HTTP adapter/tests, local Drift
database/repository entry points and dependency/toolchain manifests. Private editor/provider helper
files and secrets were not read.

## 2. R3 learning result

The seven R2 problem areas share one lesson:

> A safe component is not enough when its caller, composition type, time boundary, capability shape
> or proof producer can still express the unsafe case.

R2 added useful mechanisms, but several guarantees are weaker than their names:

| Intended guarantee | Current observable meaning | R3 semantic target |
| --- | --- | --- |
| idempotent revoke | first revoke succeeds; repeat is denied before update | repeat reaches an equivalent terminal result; one transition/event |
| status is authoritative | active target can be read; revoked target is hidden | authorized actor can observe the target's terminal revoked state |
| hosted authorization is mandatory | current hosted root supplies it | hosted type cannot be built without it or fall back to fixture auth |
| route inventory is complete | every listed descriptor is registered | every actual non-health route has exactly one descriptor |
| unknown-`kid` cooldown is bounded | refreshes coalesce, but unchanged success clears negative state | unchanged key set activates per-key cooldown |
| Flutter transport is bounded | send and each stream gap have timeouts | one absolute attempt deadline and typed failure closure |
| readiness is least privilege | runtime cannot read the ledger directly | runtime can ask only the one exact readiness question |

## 3. Vocabulary and closed outcomes

### Idempotence

Repeating the same valid request after its first success returns an equivalent terminal result and
does not repeat the state transition or its security event. Idempotence does not mean skipping actor
authorization: the actor must still be active and permitted on every call.

### Actor-active versus target-terminal

The actor Device proves present authority. The target Device is the managed object. The actor must
remain active; the target may already be `revoked` because that is the terminal state status/revoke
must report idempotently. Applying the actor predicate to the target erases this distinction.

### Composition safety

A composition is structurally safe when an invalid combination cannot be represented through the
public constructor/type. A production entrypoint that happens to pass the right optional argument
is conventionally safe, not structurally safe.

### Actual route inventory

The inventory is the set of routes Fastify actually registered, excluding the explicitly bounded
health routes. A descriptor list is a policy declaration. Equality must be bidirectional:

```text
descriptor → actual route exists
actual non-health route → exactly one descriptor exists
```

### Key-set identity

Key-set identity means a stable comparison of the validated JWKS keys, not the time at which they
were fetched. A successful fetch can advance freshness while returning the same key set.

### Absolute deadline

One deadline bounds the complete attempt: connection/send, response headers and all response-body
chunks. An inter-chunk timeout bounds only silence between chunks; a slow trickle can keep resetting
it indefinitely.

### Exact readiness capability

An exact capability answers one fixed question, such as “is the R3-required migration state
present?”. A function accepting any migration identifier exposes a family of questions even when it
returns only a boolean.

### Closed Flutter outcomes

Every bounded transport failure must become an application-owned outcome. Conservative semantics:

```text
conflict                     known not applied; preserve local state
service-unavailable          known unavailable before application is possible
unknown-outcome              commit/result cannot be known; query/replay same request identity
duplicate-equivalent         committed terminal result already exists
```

Timeout, response loss and ambiguous connection failure must not be called `not-applied` unless the
test can establish that the server could not have committed.

## 4. Failure A — revoke and status reject the terminal target

### Current call path

```text
Fastify POST /v1/devices/:deviceId/revoke
→ HostedIdentityService.revoke
→ principal verification
→ inTransactionWithContext
→ resolveOneMembership
→ authorizeActorAndTargetDevice
→ require actor active AND target Device status active
→ conditional active→revoked update
→ security event only if update changed a row
```

`authorizeActorAndTargetDevice` rejects a revoked target before `revoke` reaches its conditional
update. Therefore the existing event guard is useful but unreachable on a repeat. `deviceStatus`
uses the same helper, so an authorized owner cannot read the already-revoked target's status.

### Learner-friendly cause map

```text
shared helper means “both Devices must be active”
→ target terminal state is treated as failed authentication
→ repeat exits before idempotent write/result logic
→ “one event” may hold while “idempotent revoke” does not
```

R3 needs separate predicates: actor binding/activity remains strict; target existence/account/policy
is checked without requiring target activity. Status may then return `revoked`; revoke may return a
duplicate-equivalent terminal result without a second event. Foreign targets must remain
non-enumerating.

Project ownership: Markei SQL queries, policy helper and outcome mapping. PostgreSQL supplies row
locks and atomic transaction behavior; `pg` supplies `PoolClient.query`. Neither defines which row
must be active or what repeat means.

## 5. Failure B — hosted authorization is optional at the composition boundary

### Current call path

```text
hosted.ts
→ buildApp({ RefusingAuthVerifier, HostedTransactionAuthorizer, database, hosted })
→ protectedOperation(... optional hostedAuthorizer ...)
→ if present: authorizeOperation in one transaction
→ if absent: auth.verify then inTransaction
```

The current hosted root is safely assembled. The exported `buildApp` option object is not: `hosted`,
`auth` and `hostedAuthorizer` are independent, and `hostedAuthorizer` is optional. Another caller can
enable hosted identity routes while protected sync/recovery silently uses the fixture/precommitted
branch.

R3 needs a discriminated composition boundary, for example conceptually separate hosted and
fixture variants. Hosted must require `HostedTransactionAuthorizer`; fixture must not accept hosted
identity services. The exact API name is a Main/design choice, but the invalid combination must fail
at TypeScript construction/type checking rather than at convention review.

Project ownership: `buildApp`, its option types, composition roots and tests. Fastify constructs and
serves the app; TypeScript checks the union/interface. No Fastify change is indicated.

## 6. Failure C — the route check proves presence, not completeness

### Current call path

```text
ROUTE_AUTHORIZATION_DESCRIPTORS (13 expected policies)
↕ assertRouteDescriptors compares the project `routes` array
routes loop → app.route(...)
assertFastifyRouteInventory → app.hasRoute for each descriptor
```

This proves that each expected descriptor appears in the project array and each array entry exists
in Fastify. It never asks whether Fastify contains an additional non-health route registered outside
that array. Thus an injected bypass can coexist with all 13 passing checks.

R3 must compare the actual registered non-health method/path set with the classified set, or make a
single project-owned registration wrapper the only route-registration surface and prove the actual
set at construction/test time. Fastify owns route registration and exposes route metadata/checks;
Markei owns the “no unclassified route” invariant and health exclusion. `@fastify/sensible` adds
HTTP conveniences; it does not classify authorization.

## 7. Failure D — unknown-`kid` state compares time, not keys

### Current call path

```text
Auth0JwtVerifier.verify
→ jose.decodeProtectedHeader / jose.jwtVerify
→ BoundedJwksSource.getKey
→ jose local JWK lookup raises JWKSNoMatchingKey
→ remember previousFreshUntil
→ forced refresh
→ successful fetch always recalculates freshUntil
→ timestamp differs, so negative kid state is deleted
→ local lookup still rejects unknown kid
```

The refresh can be successful yet unchanged. Comparing `freshUntil` mislabels it as key rotation,
so repeated unknown keys can force repeated network refreshes after successful unchanged responses.

R3 needs a stable identity/fingerprint of the validated key set. Unchanged identity sets the
per-`kid` negative cooldown; genuine rotation changes identity and clears only the negative state
made obsolete by the new keys. Fresh/stale timestamps continue to model time, not content.

`jose` correctly owns JOSE parsing, signature verification, claims checks, local JWK selection and
its no-matching-key error. Markei owns fetch limits, cache lifetimes, refresh/coalescing, key-set
comparison and cooldown policy. Replacing or upgrading `jose` is not indicated.

## 8. Failure E — Flutter exceptions and time are not closed

### Current call path

```text
HostedEnrollmentCoordinator.enroll/replay
→ mark state / load durable request identity
→ HttpDeviceEnrollmentTransport.enroll/query
→ http.Client.send(...).timeout(_timeout)
→ streamed.stream.timeout(_timeout)
→ bounded bytes / closed response decoder
→ coordinator catches only DeviceEnrollmentConflict or DeviceEnrollmentUnavailable
```

`TimeoutException`, `http.ClientException` and other bounded transport failures can escape `_send`.
The coordinator can then return no `HostedEnrollmentOutcome` and leave persisted progress at
`enrolling`. Separately, stream `timeout` is an inter-chunk timer, so a response can exceed the
advertised total duration by continuously producing small chunks.

R3 needs one absolute deadline for the whole request and a transport boundary that translates
expected network/timeout/response failures into project-owned typed outcomes. The coordinator must
persist the matching terminal/unknown progress and always return its bounded outcome. Response loss
after possible commit should remain `unknown-outcome`, preserving the request identity for query or
replay.

The Dart `http` package owns sockets, request sending, response streams and `ClientException`.
Dart async owns `Future`, `TimeoutException` and deadline primitives. Markei owns total deadline
composition, byte/status/schema limits, exception translation, persistence and replay meaning.
Flutter supplies the runtime/test framework; it does not close these application semantics.

## 9. Failure F — readiness can probe arbitrary migration identifiers

### Current call path

```text
GET /health/ready
→ readyStatus
→ runtime pool.query(markei_required_migration_present($1), "005...")
→ migration-005 security-definer function
→ existence lookup for caller-supplied migration identifier
```

Direct ledger access is denied, but the runtime may ask the function about any identifier. That is
narrower than ledger `SELECT` and broader than the selected exact readiness capability.

R3 must preserve migration 005 and add forward migration 006. The new function should encode the
exact required condition without a caller-selected migration identifier; runtime gets execute on
the exact function and loses execute on the arbitrary probe. `/health/ready` calls only the exact
capability. Migration 006 must also prove owner, ACL, safe search path, qualified lookup and rollback
behavior.

PostgreSQL owns security-definer execution, ACLs and transactional DDL. `pg` sends the query.
Markei owns the function shape, grants/revokes, migration history and readiness meaning. No database
driver change is indicated.

## 10. Named evidence: current tests versus R3 tests

Current evidence is narrower than the intended claims:

- `protected route policy inventory covers hosted sync and recovery routes` checks the exported
  operations list; it does not inject an extra Fastify route.
- `Auth0JwtVerifier coalesces parallel refresh for one unknown key` actually verifies three valid
  known-key requests share the initial fetch; it does not prove an unchanged unknown-`kid` cooldown.
- `coordinator preserves local state on cancellation, rejection and outage` uses a fake adapter that
  throws only `DeviceEnrollmentUnavailable` and uses `LocalDatabase.memory()`.
- the hosted-local harness performs one sequential owner target revoke and later denial; it does not
  repeat revoke, count the event under repeat, or execute barrier races.
- the harness calls the migration-005 readiness function with the selected identifier; success does
  not prove that other identifiers are unqueryable.

R3 should add named cases equivalent to:

### Device management and composition

1. `duplicate_revoke_returns_equivalent_result_and_emits_one_security_event`
2. `authorized_status_reports_revoked_target_without_reactivating_it`
3. `revoked_actor_cannot_read_status_or_revoke_target`
4. `foreign_revoked_target_remains_non_enumerating`
5. `hosted_composition_requires_transaction_authorizer_at_type_boundary`
6. `fixture_composition_cannot_accept_hosted_identity_routes`

### Routes and JWT/JWKS

7. `injected_extra_non_health_route_fails_actual_inventory`
8. `health_routes_are_the_only_inventory_exclusion`
9. `unknown_kid_unchanged_refresh_enters_per_key_cooldown`
10. `unknown_kid_burst_performs_bounded_refresh`
11. `genuine_rotation_changes_key_set_identity_and_accepts_new_key`
12. `stale_expiry_and_refresh_recovery_do_not_confuse_key_set_identity`

### Flutter and readiness

13. `send_timeout_maps_to_typed_unknown_outcome`
14. `client_exception_maps_to_typed_bounded_outcome`
15. `absolute_deadline_bounds_slow_trickle_response`
16. `coordinator_never_leaves_enrolling_after_transport_failure`
17. `real_loopback_http_failure_preserves_pending_outbox_and_facts`
18. `file_reopen_preserves_enrollment_request_and_unknown_outcome`
19. `runtime_readiness_calls_exact_no_argument_capability`
20. `runtime_cannot_execute_arbitrary_migration_probe_after_006`

The wider R2 barrier floor remains required: membership/identity/actor revocation races across all
protected route classes, owner/member management races, enrollment replay/conflict/restart cases,
denied-state non-advancement, JWKS outage/rotation/stale-expiry pressure, security-definer shadowing
and one aggregator that emits success only after the TypeScript, PostgreSQL/HTTP and real Flutter
producers all pass.

## 11. Framework, package and toolchain responsibility map

| Imported/runtime component | Its legitimate role | Markei responsibility it cannot prove |
| --- | --- | --- |
| Fastify / `@fastify/sensible` | register/dispatch HTTP routes and provide HTTP helpers | route-policy completeness or hosted composition safety |
| `pg` | pool/client access and SQL transport | transaction policy, SQL predicates, function ACL design |
| PostgreSQL | locks, isolation, RLS, functions and privileges | application outcome vocabulary and exact capability selection |
| `jose` | JOSE/JWT cryptography, claims and JWK selection | refresh cache, key-set identity and cooldown policy |
| Dart `http` | HTTP request/stream mechanics | absolute application deadline and typed durable outcome |
| Drift / SQLite | local persistence and reopen mechanics | proof that hosted failure preserves the real outbox/facts |
| Flutter / `flutter_test` | client runtime, build and test execution | server authorization or provider acceptance |
| npm scripts / Node test / TypeScript | invoke formatting, linting, compilation and server tests | Flutter execution or PostgreSQL/provider proof unless explicitly aggregated |
| Gradle / Android JVM 17 toolchain | compile/package the Android host | hosted transport semantics or platform runtime acceptance |

No external package, Flutter SDK, Gradle/JVM target or provider SDK change is indicated by these
failures. The current dependencies already expose the primitives R3 needs. Package changes would
require new evidence that an existing primitive is missing or defective; none was found here.

## 12. Unsupported claims and confidence

Until R3 code and named evidence exist, do not claim:

```text
revoke is idempotent
revoked-target status is supported
hosted fallback is structurally impossible
every actual non-health route is classified
unknown-kid pressure is bounded
Flutter hosted transport has one absolute deadline
all transport failures become typed outcomes
runtime readiness is an exact capability
R3 local security proof passed
real Flutter HTTP/file-backed proof passed
Auth0, Neon or Render accepted the system
MCG-02 complete, production authentication ready or Cycle 10 closed
learner maturity changed
```

Confidence:

- **High** — the six source contradictions and their call paths; each is directly visible in
  project-owned code.
- **High** — current test/proof gaps; the named R2 tests and harness boundaries were inspected.
- **High** — no dependency change is presently indicated; failures are in project composition,
  policy, state and proof code.
- **Medium-high** — the proposed semantic targets; Main must freeze exact R3 types, outcome mapping,
  key-set identity representation and migration-006 names/grants before Codex.
- **Not established** — any R3 implementation, local R3 validation, provider proof, deployment or
  learner maturity.

## 13. Round delta and handoff

Newly established: each R2 contradiction now has an explicit call path, learner-facing cause,
project/framework ownership boundary and named proof target. Retained: R2 is partial, provider work
is stopped, migration 005 is immutable and permanent didactic memory is unchanged. Corrected:
successful current production composition is not structural composition safety; a passing
descriptor-presence test is not an actual-route completeness proof; inter-chunk timeout is not an
absolute deadline.

Performance improvement: the R3 question is reduced from seven broad symptoms to six owned source
seams plus a bounded evidence matrix. No external dependency investigation remains open.

```text
Next sequence: FLX-INV-02 Main reconciliation, then FLX-ORD-01 only after explicit activation
Next authority needed: Main-restaged D/E/F marked ACTIVE — CODEX IMPLEMENTATION AUTHORIZED
Writable implementation scope: not selected by this report
Stop condition: any provider contact, migration-005 edit, broad privilege, permanent-memory edit,
                dependency/SDK addition without evidence, or claim beyond named local proof
```
