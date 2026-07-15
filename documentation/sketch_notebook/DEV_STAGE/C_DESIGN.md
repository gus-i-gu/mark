# C_DESIGN — C10-S03A-R3 Hosted Authorization Design Investigation

> Sequence: FLX-INV-02 investigative round
> Role: Design/Architecture [D]
> Branch / inspected HEAD: `intermid-cycle-recovery` / `06d694aa8fb88a43c47fca3eccd02c909c193f2f`
> Prior implementation: `032e13ae7c19f2639d2a60ff6c12c6104c59fd54`
> Authority: provisional Design investigation and Main handoff only
> Writable surface: `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> Evidence boundary: repository inspection and local-only architecture; no execution/provider proof
> Status: **PROVISIONAL — NOT AUTHORIZED FOR CODEX, MIGRATION, PROVIDER MUTATION OR PROMOTION**

## 1. Retained state and round delta

The required methodology route and current J/D/E/F/G/H/I were read. J accepts R2 as partial and
identifies six source flaws. Direct inspection confirms all six at current HEAD. Migration 005 is
forward history and must not be edited; R3 implementation still requires new Main D/E/F authority.

This round narrows R3 to project-owned boundary corrections. No external package/version change is
architecturally required. Existing Fastify/Node APIs, injected `fetch`/Clock, `jose`, Dart `http`
1.6.0, and Drift v7/file databases are sufficient; implementation must compile-prove the chosen
request-abort primitive rather than upgrade dependencies speculatively.

## 2. Current ownership and dependency graph

```text
hosted.ts / hosted_local_harness.ts                 composition roots
  ├─ Auth0JwtVerifier                              principal adapter (`jose`, fetch, Clock)
  ├─ HostedIdentityService                         identity/enrollment/Device use cases
  ├─ HostedTransactionAuthorizer                   sync/recovery transaction authorization
  └─ buildApp                                      Fastify route composition

app.ts
  ├─ independent options: auth + hosted? + hostedAuthorizer? + database
  ├─ RouteDescriptor[] → app.route
  ├─ described-route hasRoute check (one-way only)
  └─ protectedOperation
       ├─ hostedAuthorizer? → one authorization/operation transaction
       └─ otherwise auth.verify → later database transaction

hosted_authorization.ts
  ├─ PrincipalVerifier + Database application dependencies
  ├─ migration-005 authorization fence
  └─ PostgreSQL tables through PoolClient

jwt_verifier.ts → jose + fetch + Clock

Flutter HostedEnrollmentCoordinator
  → AccessTokenSource + DeviceEnrollmentTransport + HostedIdentityRepository ports
  → HttpDeviceEnrollmentTransport (`package:http`) / DriftHostedIdentityRepository adapters
```

Intended dependency direction remains:

```text
domain contracts ← application ports/use cases ← Fastify/PostgreSQL/HTTP/Drift adapters
                 ← hosted, fixture and local-proof composition roots
```

Current leaks retained for bounded R3: application authorization contracts accept
`FastifyRequest`, and application services issue SQL through `PoolClient`. They are pre-existing
couplings, not causes of the six flaws; broad port extraction would enlarge R3 without improving
its decisive proof.

## 3. Six flaw diagnoses and minimal choices

### 3.1 Revocation idempotence is blocked by authorization policy

`authorizeActorAndTargetDevice` requires both actor and target `devices.status='active'`. Thus a
second revoke and status of a revoked target fail before the transition-aware update. The helper
owns both **who may target** and **which target states an operation accepts**.

Alternatives:

1. Add `allowRevokedTarget` boolean. Smallest diff, but hides operation semantics in a flag.
2. Return a locked actor/target snapshot after validating active actor, identity binding,
   same-Account and owner/member scope; let status/revoke decide target-state semantics.
   **Recommended.** Revoke changes active→revoked once and inserts one event only when that locked
   transition occurs; already-revoked returns `duplicate-equivalent` without a second event.
3. Move Device management into a new security-definer procedure. Atomic but unnecessary privilege
   and migration expansion; reject for R3.

Main contradiction: universal self-revoke replay cannot coexist with “actor Device must be active.”
After self-revoke, the same Device cannot authenticate its retry. Main must choose either:

- scoped idempotence: an active actor (normally another owner Device) may repeat a target revoke;
  self-revoke retries are denied; **recommended minimal policy**; or
- universal exact replay: add a durable revoke-request identity/result contract and authorize that
  replay separately without restoring Device authority. This is schema/contract-bearing and larger.

No unique event index is recommended: a target row lock plus conditional active-state update gives
one event per transition without preventing a future generation/reactivation policy.

### 3.2 Hosted transaction authorization is optional in the type

Production `hosted.ts` composes safely, but `buildApp` independently accepts `auth`, `hosted`, and
optional `hostedAuthorizer`; `protectedOperation` therefore preserves the forbidden precommitted
fallback for any future mis-composition.

Alternatives:

1. Runtime assertion when `hosted` lacks `hostedAuthorizer`. Detects but does not remove invalid
   states from callers.
2. One discriminated composition, **recommended**:

   ```text
   authorization = hosted { identityService, transactionAuthorizer }
                 | fixture { verifier }
                 | disabled
   ```

   `protectedOperation` switches exhaustively; hosted cannot supply/consume fixture `AuthVerifier`.
   `hosted.ts`, `hosted_local_harness.ts`, `lab.ts`, `main.ts`, and tests select an explicit branch.
3. Separate hosted and fixture app builders. Strong but duplicates route construction.

The union belongs at the HTTP composition boundary (`app.ts` or a small project-owned composition
type beside it), while verification/transaction behavior stays in application services.

### 3.3 Route inventory proves presence, not absence

Routes are registered from local descriptor values, but the exported expected list is parallel
metadata and `hasRoute` only proves every described route exists. An extra direct Fastify route is
not enumerated or rejected.

Alternatives:

1. Parse `printRoutes()`. Couples proof to presentation text; reject.
2. Require one registration wrapper only. Improves ownership but cannot detect bypass by itself.
3. **Recommended:** keep one classified registration gateway and also install a root `onRoute`
   capture before registrations. At `ready`, normalize actual method/path pairs, exclude only the
   two named health routes (and explicitly handled automatic HEAD forms), and compare actual
   non-health routes exactly with descriptor-derived inventory. Reject duplicate, missing, extra,
   wrong-operation, and wrong-class entries.

The actual capture is Fastify-adapter responsibility and may live in `src/http/route_registry.ts`
if extracting it makes `app.ts` reviewable. Tests must inject an extra route after app construction
and prove `ready`/`inject` fails; comparing two constants is insufficient.

### 3.4 Unknown-`kid` cooldown compares timestamps, not key-set identity

`getKey` records `freshUntil`, forces refresh, and infers “changed” from a new `freshUntil`.
Every successful unchanged fetch moves that timestamp and clears negative state, so repeated
unknown keys can refresh repeatedly.

Alternatives:

1. Compare sorted `kid` values. Misses changed key material under the same ID; reject.
2. Compare response bytes. Property order/whitespace create false changes; reject.
3. **Recommended:** validate and normalize the accepted JWK fields, compute a deterministic
   key-set fingerprint/revision, and have refresh return `changed | unchanged | stale-retained`.
   Set per-key negative cooldown whenever the requested key is still absent after the one allowed
   refresh; genuine rotation changes the revision and succeeds when the new key is present.

Keep cache times separate from key identity. Honor global failure cooldown for unknown-key refresh,
coalesce the shared refresh promise, and never satisfy an unknown key from stale material. Node
`crypto` plus existing `jose`/Clock/fetch seams suffice; no dependency is needed.

### 3.5 Flutter transport failures escape the application contract

`_send` can leak `TimeoutException`, `http.ClientException`, and stream failures. The coordinator
catches only two custom exceptions, may leave durable state at `enrolling`, and its two `.timeout`
calls form renewable phase/inter-chunk limits rather than one absolute attempt deadline.

Alternatives:

1. Catch every `Object` in the coordinator. Hides programming defects and leaks adapter ownership;
   reject.
2. Translate known IO/timeout/parse/size/status failures to existing exceptions in the adapter.
   Minimal, but exception categories remain ambiguous.
3. **Recommended:** make the transport port return a closed success/conflict/unavailable/unknown
   outcome (or an equally closed typed failure), and make the HTTP adapter own all raw exception
   translation. Coordinator persists the matching terminal/replay state and never sees HTTP types.

Use one deadline created at attempt start across connect, headers and body. On expiry trigger
request-scoped cancellation; do not close a borrowed shared client. If the installed HTTP API cannot
cancel one request, use an injected per-attempt owned client factory and close that client. Preserve
the existing explicit credential flow and owned/borrowed lifecycle. Drift remains v7: the existing
hosted state and outbox tables already support close/reopen proof; no Flutter schema change is shown.

### 3.6 Readiness capability accepts caller-selected migration IDs

Migration 005 grants runtime execute on `markei_required_migration_present(text)`; the function
reads no rows directly but exposes arbitrary ledger membership queries. This violates the selected
exact-capability boundary.

Alternatives:

1. Application validates the argument. Runtime can still call SQL directly; reject.
2. Keep the function but revoke runtime and grant a view. A view broadens ledger exposure; reject.
3. Add migration 006 with a no-argument exact readiness function, **recommended**.

## 4. Prospective migration 006 boundary

R3 may add exactly one forward migration, provisionally
`006_hosted_authorization_r3` (Main owns the final identifier/checksum). It should:

- create a no-argument function such as `markei_hosted_runtime_ready()` that checks only the exact
  R3-required ledger condition;
- use the migration owner, `SECURITY DEFINER`, fixed safe `search_path`, qualified references,
  `STABLE`, scalar boolean return, and no dynamic SQL;
- revoke `PUBLIC`, grant only runtime execute on the new function, and revoke runtime execute on
  `markei_required_migration_present(text)` without dropping or editing migration-005 objects;
- preserve runtime denial of direct `migration_ledger` access;
- insert its own ledger identity transactionally and roll back all DDL/ledger state on failure.

`readyStatus` calls only the no-argument capability. Fresh 001→006, 001→005→006, duplicate apply,
owner/mode/ACL/search-path/object-shadowing, old-function runtime denial, direct-ledger denial, and
failure rollback are required seams. No other R3 flaw requires SQL unless Main selects universal
self-revoke replay; that decision must not be smuggled into 006.

## 5. Recommended R3 call paths

```text
Hosted branch
Bearer → PrincipalVerifier
       → HostedTransactionAuthorizer
       → migration-005 fence
       → active actor lock
       → protected callback on same PoolClient
       → one commit/rollback

Device management
Principal → fence/membership → active actor authorization
          → locked target snapshot (active or revoked)
          → operation-specific status/revoke transition

Flutter enrollment
Coordinator → one ephemeral credential → closed transport outcome
            → HTTP adapter absolute deadline + bounded decode
            → Drift state transition; facts/outbox untouched
```

Fixture verification exists only in the fixture union branch and loopback lab root. Provider SDKs,
callbacks, credentials, UI, event v3, cursor `c10b:*`, recovery format 1, hosted contract v1, and
Drift v7 remain outside the change.

## 6. Test seams and truthful proof ownership

- **Composition:** typecheck invalid hosted/fixture combinations plus runtime branch tests; hosted
  protected routes must be unable to reach `AuthVerifier.verify` fallback.
- **Route registry:** `onRoute` actual inventory; injected extra route, missing descriptor,
  duplicate method/path, wrong operation/class, health exception, all 13 current routes.
- **Authorization barriers:** optional no-op test hook at fence/actor/target/action boundaries or
  controlled PostgreSQL barriers; no sleeps. The privileged writer acquires the same fence before
  identity/membership mutation. Parameterize upload/download/ack/all recovery classes and snapshot
  protocol/security-event state before/after denial.
- **Device management:** active owner/member, revoked target status, scoped repeated revoke, one
  transition/event, actor/target race, and the selected self-revoke policy.
- **JWT:** injected Clock/fetch with semantic fingerprint; unchanged unknown-key burst, distinct-key
  pressure, changed set without requested key, genuine rotation, outage/recovery, stale ceiling,
  timeout/abort, duplicate key, and generic error output.
- **Flutter:** real `HttpDeviceEnrollmentTransport` against loopback Fastify, exact bearer capture,
  conflict, connect/header/body timeout, slow trickle beyond absolute deadline, malformed/oversized
  body, request cancellation, and borrowed-client survival. Use `LocalDatabase.file`, create a real
  pending outbox row, close/reopen, and compare outbox/facts/enrollment request identity.
- **Aggregation:** server/PG, JWT, and Flutter producers emit only their own machine-readable case
  IDs. One local orchestrator may start disposable services and invoke Flutter, but terminal
  `R3_LOCAL_SECURITY_PROVED=true` is allowed only after every required producer passed. G must use
  Git-derived paths and final SHA.

## 7. Rollback, stops and unresolved Main decisions

Rollback is application rollback/hosted disablement; migration 006 remains inert forward history.
Never edit 001–005, reset Drift, weaken grants, discard facts/outbox/security events, or use a
destructive down migration.

Stop R3 on: broad table/ledger grant; inability to make hosted fallback unrepresentable; inventory
that cannot reject an injected extra route; renewable rather than absolute Flutter timeout;
uncontrolled race/sleep; required provider contact; dependency upgrade without a demonstrated API
gap; migration/history mutation; or any incomplete decisive producer. Auth0/Neon/Render, deployment,
provider proof, permanent memory, MCG-03/04 and Cycle closure remain unauthorized.

Main decisions before active D/E/F:

1. Is revoke idempotence scoped to a currently active actor, or must exact self-revoke replay work?
2. Accept the three-branch hosted/fixture/disabled composition union.
3. Accept Fastify `onRoute` actual-inventory auditing and the named health/HEAD normalization.
4. Accept semantic JWKS fingerprint/revision and closed Flutter transport outcomes.
5. Freeze migration-006 identifier, exact readiness condition/function name, and R3 proof case list.

Confidence: high for all six diagnoses, call paths, no-dependency conclusion, migration-006 ACL
boundary, and route/composition recommendations; medium-high for the exact Flutter cancellation
mechanism until compiled against the installed package; medium for product semantics of self-revoke.

```text
C10-S03A_R3_DESIGN_INVESTIGATED_LOCAL_ONLY
IMPLEMENTATION_AUTHORITY_INACTIVE
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```
