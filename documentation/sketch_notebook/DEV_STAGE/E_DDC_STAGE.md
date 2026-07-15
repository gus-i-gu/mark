# E_DDC_STAGE — C10-S03A-R3 Semantic Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: `421d79405e0435d150b61ca092a6923fc603e53e`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: local semantics and named evidence only

## 1. Purpose

Materialize truthful, closed semantics for the R3 authorization, Device-management, JWKS,
readiness and Flutter boundaries. This file governs vocabulary, outcomes, test claims and report
wording. It does not authorize learner promotion, UI work or provider acceptance.

## 2. Required distinctions

Preserve exactly:

```text
token-obtained != principal-verified
principal-verified != active-identity
active-identity != membership-confirmed
membership-confirmed != actor-device-authorized
actor-device-authorized != target-device-authorized
target-authorized != target-active
authorization-completed != operation-committed
described-route-present != actual-route-inventory-complete
JWKS-cache-time-changed != semantic-key-set-changed
phase-timeout != absolute-attempt-deadline
transport-failed != programming-defect
runtime-ready != runtime-ledger-authority
local-proof-passed != provider-proof-passed
```

## 3. Device-management vocabulary and outcomes

- **Actor Device**: header Device bound in the database to the verified identity; it must be active.
- **Target Device**: path Device selected for management; it may be active or revoked after the actor
  is authorized.
- **Scoped idempotence**: an active authorized actor repeats a target revoke and receives the same
  terminal meaning without a second transition/event.
- **Self-revoke boundary**: after self-revoke commits, that Device is no longer an authorized actor;
  its retry is denied rather than treated as universal replay.
- **Duplicate-equivalent**: no new transition occurred and the terminal target meaning is already
  satisfied; it does not mean a duplicate security event was inserted.
- **Non-enumerating denial**: response does not reveal whether a foreign/cross-Account target exists.

Required outcomes:

```text
owner + active actor + same-Account active/revoked target
  → status allowed

owner + active actor + active target
  → revoke commits active→revoked and one event

owner + active actor + already-revoked target
  → duplicate-equivalent; no transition/event

member + active actor + same actor target
  → first self-revoke allowed

same actor after self-revoke
  → device-revoked/operation-denied; not universal replay

member + other target OR foreign/cross-Account target
  → operation-denied without enumeration
```

Do not describe R3 as universally idempotent revocation.

## 4. Composition semantics

Closed authorization modes:

```text
hosted
fixture
disabled
```

- `hosted`: principal verification and database authorization are different phases; protected
  operations execute only through `HostedTransactionAuthorizer` in the same transaction.
- `fixture`: local test/lab verifier; it is not production authentication.
- `disabled`: refuses protected authentication/authorization safely.

Invalid mixed states must be unrepresentable or rejected at construction. A safe current entrypoint
does not prove structural composition safety.

## 5. Route-policy semantics

Every actual non-health route has one classification:

```text
principal-only
active-membership
active-actor-device-management
transaction-scoped-operation
```

An inventory is complete only if actual Fastify method/path registrations exactly equal the
descriptor-derived set after explicit health/automatic-HEAD normalization.

Required closed failures:

```text
unclassified actual route
extra actual route
missing actual route
duplicate method/path
wrong operation
wrong authorization class
hosted route without hosted authorizer
```

Comparing descriptors to another expected constant is not actual-inventory proof.

## 6. JWT/JWKS state vocabulary

`jose` owns cryptographic verification. Markei owns retrieval, validation, caching and pressure
policy.

Required refresh outcomes:

```text
changed         validated semantic key set changed
unchanged       fetch succeeded; semantic key set did not change
stale-retained  refresh failed but bounded cached material remains within stale ceiling
```

Required distinctions:

- cache expiry timestamps express time, not key-set identity;
- a semantic fingerprint covers normalized accepted JWK material, not only `kid` values;
- unknown `kid` after unchanged/stale-retained refresh enters per-key negative cooldown;
- forced unknown-key refresh cannot bypass global failure cooldown;
- genuine rotation changes the semantic fingerprint;
- stale material may validate a known cached key only inside policy; it never creates an unknown
  requested key;
- stale ceiling expiry rejects even if memory still holds keys.

Public/log outcomes remain generic `token-rejected`; never expose token, claims, issuer/JWKS URI,
key identifiers or documents.

## 7. Flutter transport semantics

The transport/application boundary is closed:

```text
success               committed typed enrollment/query result
duplicate-equivalent  previously committed equivalent result
conflict              request identity/hash conflict; not applied
unavailable           known service/network inability; safely retryable
unknown-outcome       commit/result cannot be known; query/replay same identity
```

One absolute attempt deadline begins before request send and covers connection, headers and complete
bounded body consumption. It cannot restart per phase or per chunk.

Rules:

- timeout/network/stream/redirect/malformed/oversized behavior becomes a closed transport outcome;
- coordinator never observes raw `http.ClientException`/`TimeoutException` as domain state;
- coordinator cannot remain durably `enrolling` after a returned/known failure;
- expected transport failures are normalized, but programming defects still fail visibly;
- conflict is never decoded as success;
- one ephemeral bearer token is used per attempt and never persisted/logged;
- local facts/outbox and durable request identity survive cancellation, denial and unknown outcome;
- a borrowed client survives one request failure; owned attempt resources are torn down.

## 8. Readiness semantics

`markei_hosted_runtime_ready()` is an exact capability, not a general ledger query.

```text
true  → exact migration condition selected by migration 006 exists
false → that condition is absent
```

It does not mean:

```text
provider accepted
all migrations are correct
authentication works
Account/Device enrollment works
deployment is healthy
runtime may inspect migration history
```

Runtime cannot supply a migration identifier, read the ledger directly or execute the old arbitrary
probe after migration 006.

## 9. Authorization and race semantics

Authorization is transaction-sensitive:

```text
verify principal
→ begin serializable bounded-retry transaction
→ acquire identity/membership fence
→ require one active membership
→ lock active actor binding/Device
→ authorize/lock target when applicable
→ execute protected action on same PoolClient
→ commit once or roll back all
```

A denied or losing race must not advance facts, events, cursors, acknowledgements, recovery sessions,
Device/enrollment state or security-event counts beyond the winning authorized transition.

Barrier tests use controlled synchronization and bounded waits, not sleeps. A serialization retry
is not a duplicate business operation when final state remains correct.

## 10. Named semantic evidence

Device/composition:

- `active actor reads revoked same-Account target status`;
- `active owner repeat revoke is duplicate-equivalent with one event`;
- `self-revoked actor cannot authenticate its replay`;
- `member cannot target another Device`;
- `hosted composition cannot express verifier fallback`;
- `fixture and disabled modes remain explicit`.

Routes/JWKS:

- `injected actual route is rejected as unclassified`;
- `actual inventory equals all thirteen classified routes`;
- `unchanged JWKS establishes negative kid cooldown`;
- `forced unknown kid obeys global failed-refresh cooldown`;
- `semantic rotation accepts the new key`;
- `stale ceiling rejects retained memory`.

Flutter/readiness:

- `slow trickle exceeds one absolute deadline`;
- `raw transport errors become closed outcomes`;
- `borrowed HTTP client survives failed attempt`;
- `unknown outcome preserves request identity facts and outbox after reopen`;
- `runtime readiness has no caller-selected identifier`;
- `runtime cannot execute old probe or read ledger`.

Evidence claims must include environment, command/case ID, pass/fail/skip and exclusions.

## 11. Report wording

G/H/I may claim R3 local proof only if the aggregator and every producer pass. Otherwise they must
state `C10-S03A_R3_PARTIAL` and the exact missing case.

Before decisive proof, do not claim:

```text
universal revoke idempotence
all routes secure
JWKS pressure bounded
Flutter attempt absolutely bounded
runtime/provider ready
Auth0 success
Neon migration accepted
Render deployment accepted
MCG-02 complete
production authentication ready
Cycle 10 closed
```

Required successful report wording:

```text
C10-S03A_R3_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

## 12. Didactic, privacy and UI boundary

No KANBAN, glossary, Concept Map, Lecture Register, learner maturity, methodology or permanent
didactic memory may change. No pages, dialogs, Device controls, progress UI, Analytics or Cycle 11
presentation work is authorized.

Tests/diagnostics must not log tokens, claims, key material, provider URLs, passwords, connection
strings, fact payloads or snapshot bytes. Correlation IDs and bounded machine-readable case names are
allowed.
