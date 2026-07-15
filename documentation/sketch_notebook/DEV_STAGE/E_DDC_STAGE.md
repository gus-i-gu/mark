# E_DDC_STAGE — C10-S03A-R3B Semantic Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: `2468c3912f1d0f3582e5eb241f104226b14c876f`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: local semantics, durable outcomes and named evidence only

## 1. Purpose

Close the remaining R3 semantic contradictions without changing product scope. This file governs
vocabulary, outcome mappings, test meanings and report wording. It does not authorize learner
promotion, UI work, provider proof or Cycle 10 closure.

## 2. Required distinctions

Preserve these distinctions in types, state, tests and reports:

```text
deadline != inactivity-timeout
stopped-waiting != request-cancelled
owned-client != borrowed-client
server-success != device-enrolled
device-enrolled != duplicate-equivalent
known-replay-outcome != enrolling
unknown-outcome != failure-known
key-set-changed != requested-key-present
cache-refreshed != lookup-may-refresh-again
provider-metadata-changed != public-signing-key-changed
route-construction-snapshot != readiness-inventory
Device-state != enrollment-state
implemented != validated
local-proof-passed != provider-proof-passed
```

Existing identity distinctions remain binding:

```text
token-obtained != principal-verified
principal-verified != active-identity
active-identity != active-membership
membership-authorized != actor-Device-authorized
actor-authorized != target-authorized
authorization-passed != operation-committed
```

## 3. Flutter deadline and ownership meanings

**Absolute attempt deadline** means one monotonic end time bounds connect, headers and the complete
bounded body. Each asynchronous wait uses remaining time. Receiving a chunk does not renew it.

**Inactivity timeout** means a wait may restart after progress. It cannot satisfy the absolute
attempt claim.

**Request cancellation** means request-owned network resources are actively closed/aborted after
deadline; merely ignoring a late Future is not cancellation.

**Owned client** means the attempt created the client and must close it. **Borrowed client** means
the caller retains ownership and it must remain usable. Reports must state which mode a test proves.

Required outcomes:

```text
complete response before deadline → decode closed response
headers/body exceed total deadline → unavailable(timeout)
slow trickle exceeds total deadline → unavailable(timeout)
oversized/malformed/redirect response → unknown-outcome or closed protocol failure
late response after deadline → no repository mutation
```

Do not call a renewable `Stream.timeout` an absolute deadline.

## 4. Enrollment success and replay meanings

Transport success is not one undifferentiated value. Preserve:

```text
device-enrolled
duplicate-equivalent
```

Coordinator outcome mapping:

| Transport/server meaning | Coordinator meaning | Durable meaning |
| --- | --- | --- |
| `device-enrolled` | `applied` | enrolled/applied |
| `duplicate-equivalent` | `duplicate-equivalent` | duplicate-equivalent |
| `conflict` | conflict | conflict |
| unavailable | unavailable | unavailable/interrupted as selected existing state |
| ambiguous response/loss | unknown-outcome | unknown-outcome/query-required |

Every known replay result replaces stale `enrolling` with its truthful durable state. Replaying does
not create a new request identity and does not alter facts, outbox or cursors.

`unknown-outcome` means the client cannot establish whether the server committed. It must not be
described as rejection, rollback, success or safe retry with a new identity.

`duplicate-equivalent` means the same request meaning is already satisfied without a second
transition. It is a success variant, but it is not `applied`.

## 5. JWKS state meanings

One lookup has one refresh budget. An expiry refresh consumes it even if the requested `kid` is
absent. The same lookup must not immediately fetch again.

After the eligible refresh:

```text
requested key present → return candidate to jose
requested key absent → install per-kid negative cooldown
fetch failed → install global failed-refresh cooldown
```

The negative cooldown is required whether the overall key-set revision is changed or unchanged.

**Semantic key revision** is the deterministic hash of validated, normalized public RSA signing
material only. Provider-specific or irrelevant metadata is outside that meaning. A change to
`kid`, key membership, `n` or `e` is semantic; a change to ignored metadata is not.

`jose` remains the cryptographic authority. A cache hit does not itself prove signature, issuer,
audience or expiry validity.

## 6. Route-inventory meanings

**Construction snapshot** observes routes registered at one synchronous point.

**Readiness inventory** observes the actual registrations after relevant Fastify plugins/routes
materialize and before the app serves/injects requests.

The claim `ROUTE_AUTHORIZATION_INVENTORY=true` requires:

- exact equality between readiness inventory and typed descriptors;
- explicit normalization only for health and automatic HEAD behavior;
- rejection of direct late and encapsulated plugin routes;
- rejection before protected requests are served;
- no reliance on `printRoutes()` text or a second hand-maintained list.

A direct construction-time injected-route test alone does not satisfy the claim.

## 7. Device status meanings

**Device status** is exactly:

```text
active | revoked
```

**Enrollment state** may contain enrollment-workflow meanings, including values not valid as Device
status. The public Device status response must use the locked target Device row, not enrollment
state. `replaced` must never be emitted as Device status.

Scoped revoke meanings remain:

- an independently active authorized actor may repeat a completed target revoke and receive
  `duplicate-equivalent`;
- an actor that revoked itself is denied on later protected work;
- one active→revoked transition creates exactly one security event;
- foreign/cross-Account denials remain non-enumerating.

## 8. Authorization race semantics

A protected operation is authorized by the database state observed under its transaction/locks,
not by a prior HTTP/JWT decision alone.

Required barrier meanings:

```text
membership disabled/removed before fence → operation denied
identity disabled before mutation → operation denied
actor Device revoked before operation authorization → operation denied
authorized transaction commits → state may advance exactly as operation specifies
authorization/SQL failure → all protected state remains unchanged
```

For each denial, “no state advance” includes facts/events, cursors/acks, recovery sessions, Device
and enrollment state, and security-event count.

Concurrent target revoke success means one transition and one event. It does not mean both callers
must receive `applied`; the second authorized caller may receive `duplicate-equivalent`.

## 9. Migration readiness semantics

`runtime-ready` means the exact no-arg migration-006 capability evaluates successfully under its
defined ledger state. It does not mean runtime can read the migration ledger, call the old
parameterized probe, perform DDL or administer roles.

A migration-006 completion claim requires fresh, upgrade, duplicate, failure rollback, owner/ACL,
search-path and shadowing evidence. The existence of migration 006 alone is `implemented`, not the
complete lifecycle proof.

## 10. Closed result vocabulary

Use closed meanings equivalent to:

```text
applied
duplicate-equivalent
conflict
unavailable
unknown-outcome
operation-denied
device-active
device-revoked
```

Unknown fields/statuses, malformed bodies and oversized bodies never decode as success. Public
denials remain bounded and non-enumerating. Internal diagnostics may name a safe error class but
must not contain tokens, claims, credentials, provider URLs, connection strings or fact payloads.

## 11. Required named semantic tests

Names may follow repository convention but must prove these meanings explicitly:

- absolute deadline is not renewed by slow chunks;
- timeout closes an owned attempt client;
- borrowed client remains usable;
- late completion cannot mutate durable state;
- server `device-enrolled` maps to applied;
- server `duplicate-equivalent` remains distinct;
- replay conflict/unavailable/unknown replaces stale enrolling;
- close/reopen preserves request identity and outcome;
- expired JWKS miss refreshes once;
- changed set still missing key installs cooldown;
- irrelevant JWK metadata does not change revision;
- genuine public-key change changes revision;
- plugin and late route fail readiness;
- valid route inventory passes readiness;
- Device status reads Device state, not enrollment state;
- divergent enrollment fixture cannot emit `replaced` as Device status;
- each identity/membership/actor barrier denies without state advance;
- owner/member target races produce one transition/event;
- migration 006 lifecycle and ACL matrix passes;
- file-backed Drift preserves facts/outbox across every enrollment outcome.

## 12. Aggregate and report wording

The only complete local diagnostic is:

```text
R3_LOCAL_SECURITY_PROVED=true
C10-S03A_R3B_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

It is permitted only when every named producer/case passes. Otherwise use:

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3B_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Forbidden unless separately proven later:

```text
HOSTED_AUTH_READY=true
Auth0 verified
Neon accepted
Render deployed
MCG-02 complete
production ready
Cycle 10 closed
```

Build success must be called build success. Local loopback success must be called local loopback
success. Host-unvalidated remains explicit.

## 13. Privacy, local-first and learning boundary

- access tokens remain in memory for one attempt and are never persisted/logged;
- local facts/outbox remain available when hosted authentication/API is unavailable;
- failures do not delete, reset or rewrite local purchases;
- no provider credential/private helper is inspected;
- no UI, Account picker, Device-management UX or Cycle 11 work is authorized;
- no KANBAN, glossary, Concept Map, Lecture Register or learner maturity change is authorized;
- G/H/I are evidence only and cannot promote permanent memory.

## 14. Stop rule

Stop and report to Main if a requested type/state cannot be represented in Drift v7, if cancellation
requires a dependency change, if migration 006 must be altered, or if a local claim would depend on
provider behavior. Do not weaken the vocabulary to obtain a passing diagnostic.
