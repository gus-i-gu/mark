# F_DSN_STAGE — C10-S03A-R3 Design Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: `421d79405e0435d150b61ca092a6923fc603e53e`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: local project architecture and proof only

## 1. Selected architecture

R3 is one bounded correction/proof unit:

```text
closed HTTP authorization composition
+ operation-specific Device target semantics
+ actual Fastify route inventory
+ semantic JWKS key-set revision
+ closed Flutter transport result under an absolute deadline
+ migration-006 exact readiness capability
+ deterministic multi-producer local proof
```

No external dependency/version change is selected. Existing Fastify, `jose`, `pg`, PostgreSQL,
Dart `http`, Drift and Flutter primitives are sufficient unless compilation proves a specific
missing cancellation primitive. In that case Codex stops for Main; it does not upgrade silently.

## 2. Dependency direction

Retain:

```text
domain contracts
    ↑
application ports/use cases
    ↑
Fastify / PostgreSQL / HTTP / Drift adapters
    ↑
hosted / fixture / disabled / local-proof composition roots
```

`jose` verifies JOSE/JWT/JWK cryptography. Markei owns issuer/audience policy, JWKS retrieval and
cache/cooldown behavior. `package:http` performs request/stream mechanics. Markei owns deadlines,
resource lifecycle and application outcome translation. PostgreSQL provides locks/RLS/functions;
Markei owns predicates, ACLs and transaction ordering.

Do not extract broad new ports merely to remove existing `FastifyRequest`/`PoolClient` coupling;
those couplings are not causes of the six defects. Small types/helpers may be added where they make
invalid R3 states unrepresentable.

## 3. HTTP composition model

Replace capability detection with an exhaustive discriminated union equivalent to:

```text
type AuthorizationComposition =
  | { kind: "hosted"; identityService; transactionAuthorizer }
  | { kind: "fixture"; verifier }
  | { kind: "disabled" };
```

Constraints:

- hosted identity/enrollment/Device routes use the hosted identity service;
- hosted protected sync/recovery routes require the transaction authorizer;
- fixture verification exists only in the fixture branch;
- disabled composition refuses protected work;
- no independent optional hosted authorizer remains;
- branch selection is exhaustive and construction-time checked;
- all composition roots select explicitly;
- shared route behavior may remain centralized.

The current hosted entrypoint's safe convention is retained through the stronger type; the unsafe
fallback is removed, not merely guarded by a runtime warning.

## 4. Transaction and Device-management model

Protected operation path remains:

```text
verify JWT outside DB transaction
→ begin bounded-retry serializable transaction
→ invoke migration-005 identity/membership fence
→ require exactly one active membership
→ set Account/identity context
→ lock identity-bound active actor enrollment and Device
→ set Device/operation context
→ execute protected callback on same PoolClient
→ commit once or roll back all
```

Device-management path becomes:

```text
principal
→ fenced membership
→ active actor authorization
→ stable actor/target locks
→ locked same-Account target snapshot(active|revoked)
→ status or conditional revoke transition
```

Separate responsibilities:

- actor helper proves identity binding, active enrollment/Device and owner/member target scope;
- target snapshot records current state without requiring target active;
- status maps the snapshot;
- revoke conditionally updates active→revoked and inserts one event;
- already-revoked target maps to duplicate-equivalent for an active authorized actor.

Self-revoke is one accepted transition. After commit the actor is revoked and cannot authenticate a
retry. Do not add a durable revoke request/result contract or active-actor exception in R3.

Stable UUID lock order and one lock for identical IDs are required. Enrollment, Device state and
security event share one transaction. A unique event constraint is unnecessary for the selected
single-transition model; tests prove the locked conditional update.

## 5. Actual route registry

One project-owned route registration gateway records:

```text
method
path
operation
authorization class
```

Install a root Fastify `onRoute` hook before application/plugin routes. Capture normalized actual
registrations independently from descriptor intent, then compare exact sets before readiness/use.

Rules:

- descriptor drives or wraps every application route;
- actual non-health inventory equals the descriptor set;
- `/health/live` and `/health/ready` are named exceptions or explicit descriptors;
- Fastify automatic HEAD forms are normalized only through evidence for the pinned version;
- duplicates, extras, missing routes, wrong operation/class and hosted-authorizer absence reject;
- an injected direct `app.get`/plugin route must be detected;
- never use `printRoutes()` text parsing.

An optional `src/http/route_registry.ts` extraction is allowed if it keeps `app.ts` reviewable. Do
not create a generalized framework.

## 6. JWKS state machine

Retain `Auth0JwtVerifier`/`BoundedJwksSource`, injected Clock/fetch and `jose`. Introduce a stable
semantic key-set revision.

Pipeline:

```text
bounded fetch
→ JSON parse
→ closed JWK validation
→ reject any duplicate kid
→ normalize accepted public JWK fields
→ deterministic order-independent canonical bytes/hash
→ changed | unchanged
→ createLocalJWKSet(validated set)
```

Cache state includes:

```text
local key set
semantic revision
fresh-until
absolute stale-until
global next-refresh-after
per-kid negative-until
one shared refresh promise
```

State rules:

- time changes never imply key-set change;
- successful unchanged refresh preserves revision and sets negative cooldown for a still-absent
  requested key;
- failed refresh may retain known cached keys only before absolute stale expiry;
- forced unknown-key refresh cannot bypass global failure cooldown;
- concurrent refreshes share one promise;
- genuine revision change invalidates only negative entries affected by the new set;
- a changed set still lacking the requested key establishes negative cooldown;
- stale expiry rejects even when memory retains the local set;
- unknown key is never resolved from stale material.

Use Node's existing cryptographic hash only for deterministic cache identity, never as token
signature verification. Keep public failures generic.

## 7. Flutter closed transport model

Prefer a closed application port result over raw adapter exceptions, equivalent to:

```text
sealed DeviceEnrollmentTransportResult
  success(result)
  conflict
  unavailable
  unknownOutcome
```

The exact Dart representation may use sealed classes or an equally exhaustive typed structure. It
must be exhaustively handled by `HostedEnrollmentCoordinator`.

Ownership:

- coordinator: authentication session, one token, durable enrollment state transition;
- transport port: closed result vocabulary, no HTTP types;
- HTTP adapter: request construction, redirect refusal, absolute deadline, cancellation, response
  ceiling, closed decode and raw exception translation;
- Drift repository: progress/result persistence only; facts/outbox remain authoritative and intact.

One deadline is calculated at attempt start. Every connect/header/body wait consumes remaining time.
Slow chunks cannot renew it. On expiry cancel request-owned resources.

Client lifecycle options:

1. use a proven request-scoped abort/cancel primitive from pinned `http 1.6.0`; or
2. inject an owned per-attempt client factory and close only that client.

A borrowed shared client must not be closed by one attempt. Codex must compile/test the selected
mechanism. Do not catch all objects or translate programmer errors to service-unavailable.

No Drift schema change is selected. File-backed tests use existing v7 tables and real pending
outbox/facts.

## 8. Migration 006 exact capability

Create forward migration:

```text
006_hosted_authorization_r3.sql
```

It registers `006_hosted_authorization_r3` with an explicit repository-style checksum and creates:

```sql
public.markei_hosted_runtime_ready()
```

Contract:

- no arguments;
- returns boolean only;
- checks only the exact migration condition selected for this hosted R3 binary;
- language SQL unless evidence requires PL/pgSQL;
- `SECURITY DEFINER`, `STABLE`;
- fixed `search_path = pg_catalog, public` and qualified table references;
- no dynamic SQL or caller-selected identifiers;
- owner is the migration identity used by the disposable harness;
- execute revoked from `PUBLIC` and granted to `markei_runtime` only;
- runtime execute on `markei_required_migration_present(text)` revoked;
- runtime direct ledger access remains revoked.

The migration ledger insert, function/ACL changes and revocation occur in one transaction. Do not
edit/drop migration 005 objects. Application readiness calls only the qualified no-argument function.

The exact readiness predicate must be internally constant and include the R3 migration identity;
Codex must align it with the existing migration runner/ledger semantics. It may not expose an array,
identifier or general history result.

Application rollback is allowed while migration 006 remains forward history. An R2 binary may
report not-ready after old-probe execute is revoked; rollback/deployment evidence must state this.

## 9. Evidence architecture

Use four producer families:

```text
TypeScript/Fastify/JWT unit producer
disposable PostgreSQL authorization/migration producer
Flutter real-HTTP/file-backed producer
bounded aggregate orchestrator
```

Each producer emits named machine-readable case IDs and a truthful terminal result. The orchestrator
consumes producer exit/results and prints `R3_LOCAL_SECURITY_PROVED=true` only when every D/E case
ran and passed.

Authorization races use explicit test-only phase hooks/barriers or controlled SQL sessions:

- no sleeps;
- bounded waits;
- same migration-005 fence for controlled membership/identity writers;
- stable lock-order assertions;
- before/after database state queries;
- bounded serialization/deadlock retry and exhaustion.

Flutter proof must cross the real boundaries:

```text
HostedEnrollmentCoordinator
→ HttpDeviceEnrollmentTransport
→ loopback Fastify
→ disposable PostgreSQL
and LocalDatabase.file close/reopen
```

Fake transport or in-memory-only Drift remains useful unit evidence but cannot satisfy the decisive
gate.

## 10. Authorization and privacy boundaries

- Auth0 subject becomes `ExternalPrincipal`, never AccountId/DeviceId.
- Active identity/membership/Device database rows remain required on every protected request.
- Cross-Account and cross-Device access fails closed.
- Runtime receives only the runtime pool; migrator/worker credentials never enter Fastify.
- Fixture authentication remains test/loopback-only.
- No token, claim, URI, key, password, connection string, fact/snapshot payload or generated
  credential is logged.
- Provider helper files remain unread and untouched.
- No Auth0, Neon or Render request occurs.

## 11. Versions and compatibility

Unchanged:

```text
event payload v3
cursor c10b:*
recovery snapshot format 1
hosted enrollment contract v1
Drift schema v7
migrations 001–005
package-lock/pubspec.lock dependency set
```

Added:

```text
PostgreSQL migration 006
local R3 diagnostic/case vocabulary
```

No provider SDK, callback protocol, platform secret, UI contract, Device replacement/reactivation,
Account selection UI or Cycle 11 feature is introduced.

## 12. Rollback and stopping boundary

Rollback is application rollback/hosted disablement; migration 006 remains inert forward history.
No destructive down migration.

Stop before mutation or report partial if:

- D/E/F conflict;
- self-revoke requires weakening the active actor rule;
- hosted fallback remains representable;
- actual inventory cannot reject an injected extra route;
- JWKS fingerprint is based only on time/`kid` or forced refresh bypasses global cooldown;
- one absolute deadline/cancellation cannot be proven with pinned APIs;
- a broad runtime grant, provider access or dependency upgrade is required;
- migrations 001–005, Drift schema or permanent memory would need editing;
- race proof depends on sleeps;
- any decisive producer is unavailable/skipped;
- repository credential containment is unresolved for provider work.

## 13. I report requirements

I must report:

- final dependency/composition direction;
- exact changed source boundaries;
- migration 006 identity, checksum, function definition, owner and ACLs;
- actor/target state and scoped idempotence rules;
- actual route capture/normalization rules;
- JWKS semantic fingerprint and complete state transitions;
- Flutter result type, deadline/cancellation and client ownership;
- transaction/barrier/aggregate proof architecture;
- versions retained;
- deviations, partial gates and deferred provider/self-replay decisions.
