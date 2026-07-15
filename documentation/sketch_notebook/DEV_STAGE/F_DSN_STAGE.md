# F_DSN_STAGE — C10-S03A-R2 Design Materialization Authority

> Baseline: `34bc032df26d4b6d727d3ba6f2e08bbb0b11e13f`
> Joint authority: J + D/E/F
> Scope: local hosted-authorization correction

## 1. Selected architecture

R2 is one bounded local unit with two internal proof slices:

```text
R2A server authorization + migration 005 + route registry + JWT/JWKS
R2B Flutter real HTTP enrollment + file-backed persistence
```

Both must pass before the unit may report local-security proof.

## 2. Dependency direction

Preserve:

```text
domain contracts
  ← application ports/services
  ← PostgreSQL, Fastify, HTTP and Drift adapters
  ← hosted/lab composition roots
```

Provider SDKs and provider credentials remain absent. `jose` remains the cryptographic adapter.
Fastify types must not leak into domain contracts beyond existing application boundaries where a
bounded refactor can remove them safely.

## 3. Hosted authorization ports

Replace capability detection with explicit composition types equivalent to:

```text
FixtureAuthorization
  verify(request) -> AuthContext

HostedTransactionAuthorizer
  authorize(request, operation, callback(client, AuthContext)) -> result
```

Hosted composition requires `HostedTransactionAuthorizer`; it cannot accept fixture authorization.
Fixture/non-hosted composition may use its existing verifier through a separate registration path.
Do not expose a hosted method that returns a trusted `AuthContext` after its transaction commits.

## 4. Migration 005 authorization fence

Add a forward-only SQL migration. Exact names may follow repository conventions, but its logical
contract is fixed.

### Authorization function

A security-definer function accepts bounded issuer and subject, resolves the active external
identity, and locks that identity plus all active membership rows in deterministic Account order.
It returns only:

```text
identity_id
account_id
role
```

Constraints:

- owner is the migration role that owns the referenced objects;
- fixed `search_path` and qualified table/function names;
- no dynamic SQL or caller-selected function/schema;
- explicit status predicates;
- row locks survive until caller transaction end;
- multiple/zero memberships are returned faithfully for application-level closed handling;
- revoke execute from `PUBLIC`; grant execute to runtime;
- runtime receives no identity/membership write privilege;
- test the function definition, owner, ACL, row-lock ordering and rollback behavior.

All controlled identity/membership state writers used by R2 must acquire this function’s fence
before update. Production membership administration remains deferred, but future writers inherit
the invariant.

### Readiness function

A second security-definer function returns one boolean for the exact required migration identity.
It must not accept arbitrary SQL or expose ledger rows/checksums. Runtime receives execute only;
direct ledger SELECT/INSERT/UPDATE/DELETE remains denied.

### Security-definer safety

Functions must use bounded scalar inputs, safe search path, qualified references, minimal return
shape and no provider/environment secrets. Include tests against search-path/object-shadowing and
unauthorized function invocation.

## 5. Transaction invariants

For every hosted protected operation:

1. verify bearer token outside the database transaction;
2. begin bounded-retry serializable transaction;
3. invoke authorization fence;
4. require exactly one active membership;
5. set identity and Account context from database result;
6. lock active actor enrollment and Device bound to identity;
7. set Device/operation context;
8. perform target policy and deterministic locks if management route;
9. execute protected callback using the same `PoolClient`;
10. commit once or roll back all state.

Principal verification outside the transaction is acceptable because identity/membership/Device
authorization is re-resolved and fenced inside it. Token expiry remains verified at request entry.

## 6. Device-management invariants

- Actor identity comes from verified principal plus database rows.
- Actor Device comes from header plus identity-owned active enrollment/Device rows.
- Target Device comes from path and never authenticates actor.
- Owner may target any same-Account Device; member only the actor Device.
- Lock actor and target by stable UUID ordering; identical target uses one lock.
- Revoke updates enrollment and Device state and inserts its security event in one transaction.
- A unique/idempotency condition or locked-state check ensures one revocation event per transition.
- Status/revoke failures do not reveal foreign existence.

Do not implement replacement/reactivation or UI.

## 7. Route registry

Create one typed descriptor model containing at least:

```text
method
path
operation
authorizationClass
handler registration
```

Use descriptor helpers to register actual routes. If Fastify typing makes a fully data-driven table
unreasonably unsafe, a single wrapper may register each route and record the same descriptor; no
route may bypass it.

At build/test time compare Fastify’s actual non-health route inventory with descriptors. Reject
duplicates and missing/extra classifications. Identity/Device routes and all sync/recovery routes
must be included.

## 8. HTTP contract

The server response is a discriminated contract:

- 2xx: closed `DeviceEnrollmentResult` success variants only;
- 409: typed `conflict` failure;
- other 4xx: closed non-retryable authorization/request failure;
- 5xx/timeout/connection loss: retryable or unknown outcome with safe replay action.

The route layer owns HTTP status mapping. Application services return typed success/failure data and
must not rely on Flutter-specific behavior.

## 9. Flutter ports and transport

Change the port so a request credential is explicit, equivalent to:

```text
enroll(command, accessToken)
query(requestId, accessToken)
```

or one immutable request context containing only the ephemeral credential and request values.

The coordinator:

- signs in/checks state;
- obtains one accepted token for that attempt;
- passes that same token to transport;
- never persists it;
- stores only provider-neutral enrollment progress/result;
- re-acquires a new token for a later retry/query attempt.

The HTTP adapter:

- accepts an injected client/base URI and bounded policy;
- sends the supplied bearer token once;
- uses streamed reading with a byte ceiling and timeout;
- rejects redirects, malformed/extra/missing fields and unexpected statuses;
- maps closed failures to typed application exceptions/results;
- has explicit owned/borrowed client lifecycle.

Do not modify ordinary local registration or reassign existing outbox event identity.

## 10. JWT/JWKS state machine

Model deterministic state with injected Clock:

```text
no-cache
→ fresh
→ expired-but-stale-allowed
→ stale-expired
```

Rules:

- production JWKS normalized origin equals normalized issuer origin and uses HTTPS;
- a successful fetch records fresh expiry and absolute stale expiry;
- refresh failure may retain cached keys only before absolute stale expiry;
- after absolute stale expiry, key lookup rejects even if cache memory exists;
- concurrent refresh is one promise;
- failed refresh sets global cooldown;
- unknown `kid` sets bounded per-key negative cooldown even if refresh succeeded unchanged;
- genuine rotation clears relevant negative state and accepts the new key;
- any duplicate `kid` rejects the document;
- cache/cooldown defaults are explicit, bounded and overrideable only through validated config;
- public errors/logs contain no token, claims, URI, key IDs or bodies.

## 11. Readiness and role topology

Hosted topology remains:

```text
controlled migrator session → migrations/fixture provisioning → close
runtime pool only → Fastify
```

Runtime readiness calls only the narrow function. Runtime never receives migrator URL or recovery
worker authority.

Migration 003 remains immutable. Local lab may pre-create the worker role. Later Neon application
requires a human owner to pre-create exact `NOLOGIN` non-elevated `markei_recovery_worker`; this is
outside R2 and must not be automated or simulated as provider success.

## 12. Evidence architecture

Split proof producers by responsibility:

- TypeScript unit tests: JWT, contracts, registry, authorization services;
- PostgreSQL/HTTP harness: migrations, roles, RLS, barriers and API operations;
- Flutter test: real HTTP transport, token coherence, Drift file reopen/outbox;
- optional aggregator: invokes all gates and prints final result only if each returned success.

No producer claims another producer’s work. Diagnostics carry no secrets or fact payloads.

## 13. Version and compatibility boundary

- Event payload remains v3.
- Cursor remains `c10b:*`.
- Recovery snapshot remains format 1.
- Hosted identity/enrollment contract remains v1 unless the closed HTTP mapping requires an
  additive versioned contract; prefer retaining v1 with corrected status semantics.
- Drift remains v7 unless durable schema change is genuinely necessary. If v8 is unavoidable,
  prove v7→v8 migrate/reopen/failure/no-reset; do not reset databases.
- PostgreSQL adds migration 005 only.

## 14. Rollback and stop boundary

- Source rollback is the bounded R2 commit.
- Migration 005 is forward history; application rollback must tolerate it remaining installed.
- No destructive down migration.
- Stop if security-definer ownership cannot be made least privilege, if a broad table grant is
  required, if route inventory cannot be mechanically verified, or if decisive proof depends on a
  provider.
- Do not edit 001–004, permanent memory, methodology, J, A/B/C or unrelated code.
- Do not begin provider SDK, deployment, MCG-03/04 or Cycle closure work.

## 15. Design report requirements

I must report final dependency direction, migration/function names and ACLs, transaction/lock order,
route descriptor model, actor/target policy, JWT state machine, Flutter credential flow, protocol and
Drift versions, fixture containment, deviations and deferred provider decisions.
