# I_DSN_CODEX - C10-S03A-R3 Design Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex design/architecture evidence
Unit: C10-S03A-R3 local hosted-authorization correction and decisive proof
Branch: `intermid-cycle-recovery`
Authority: `F_DSN_STAGE.md` plus J/D/E
Evidence boundary: local architecture only; provider proof deferred

## Result

```text
C10-S03A_R3_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: the implementation advances R3 correction work, but decisive race and real Flutter HTTP/file-backed proof are not complete enough to claim local security proved.

## Dependency And Composition Direction

Authorization composition is now explicit:

- hosted: `HostedIdentityService` plus `HostedTransactionAuthorizer`;
- fixture: `AuthVerifier` only;
- disabled: protected work refused.

Hosted protected operations dispatch through the transaction authorizer. Fixture verification remains available only through the fixture composition branch. Disabled composition produces bounded authentication failure for protected work.

## Migration 006

Migration 006 adds one narrow runtime-readiness capability:

- identity: `006_hosted_authorization_r3`;
- checksum: `c10-s03a-r3-hosted-authorization-v1`;
- function: `public.markei_hosted_runtime_ready()`;
- arguments: none;
- result: one boolean;
- mode: `SECURITY DEFINER`, `STABLE`;
- search path: fixed;
- SQL: static, no dynamic SQL;
- runtime grant: execute on the new function only;
- runtime revocation: execute on `markei_required_migration_present(text)` revoked.

Migrations 001-005 are unchanged. Migration 005 objects are retained.

## Actor/Target Transaction Rules

Device management separates actor and target:

- actor Device is authenticated from the request header and locked with active enrollment/device state;
- target Device is selected from the path and locked in stable UUID order with the actor;
- identical actor/target uses one lock path;
- target snapshot may be active or revoked;
- owner/member policy is applied after actor authorization;
- active revoke updates Device and enrollment state in one transaction and inserts one security event for the transition.

## Route Inventory Mechanism

Application route registration uses typed descriptors carrying method, path, operation and authorization class. Fastify `onRoute` capture records actual registrations before application/plugin registration. Construction compares normalized actual method/path pairs with descriptors and rejects unexpected, missing or duplicate routes. Health routes and automatic HEAD forms are the only normalized exceptions.

## JWKS State Machine

The verifier still delegates cryptographic verification to `jose`. The bounded JWKS source now tracks semantic key-set revision using deterministic canonicalization and hashing over accepted JWK fields. Cache time and semantic identity are separate. Refresh outcomes are changed, unchanged or stale-retained. Unknown-key pressure uses per-key cooldown after unchanged/stale outcomes, global cooldown after failed refresh, and never accepts unknown keys from stale material.

## Flutter Transport

The hosted enrollment transport port exposes closed outcomes instead of exception-only success/failure flow. The HTTP adapter owns raw `package:http` behavior, redirect refusal, one absolute deadline, stream byte ceiling and malformed response rejection. Borrowed clients are not closed by failure. Coordinator obtains one token per attempt and passes it to enroll/query without storing it.

## Proof Architecture

Current machine-readable producers:

- TypeScript/JWT/unit producer: `npm test`, 22 passing tests.
- Hosted-local producer: route inventory and least privilege true, authorization race matrix partial, aggregate false.
- Flutter unit producer: 56 passing tests with 2 lab-gated skips.
- Platform build producers: Android debug and Windows release passed.

No orchestrator truthfully emitted `R3_LOCAL_SECURITY_PROVED=true`.

## Versions Retained

- Event payload v3 unchanged.
- Cursor `c10b:*` unchanged.
- Recovery snapshot format 1 unchanged.
- Hosted enrollment contract v1 unchanged.
- Drift schema v7 unchanged.
- Dependency and lockfile versions unchanged.
- No provider SDK, callback configuration, provider IDs, Account UI or Device-management UI added.

## Deviations And Deferrals

Deferred before full R3 success:

- full deterministic PostgreSQL barrier matrix for membership, identity and Device revocation races;
- owner/member target status/revoke race proof;
- full denied-no-state-advance proof;
- real Flutter HTTP/file-backed Drift proof against loopback Fastify;
- complete local producer aggregation with `R3_LOCAL_SECURITY_PROVED=true`.

Provider proof, MCG-03, MCG-04 and Cycle 10 closure were not started.
