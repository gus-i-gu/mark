# I_DSN_CODEX - C10-S03A-R2 Design Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex design/architecture evidence
Unit: C10-S03A-R2 local hosted-authorization correction
Branch: `intermid-cycle-recovery`
Authority: `F_DSN_STAGE.md` plus J/D/E
Evidence boundary: local architecture only; provider proof deferred

## Result

```text
C10-S03A_R2_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: the complete deterministic R2 race/failure matrix and real Flutter loopback HTTP/file-backed proof remain incomplete.

## Migration and ACL design

Migration 005 adds:

- `markei_authorize_identity_membership(text,text)` security-definer function;
- `markei_required_migration_present(text)` security-definer function;
- runtime execute grants only for those functions;
- runtime direct `migration_ledger` access revocation;
- runtime identity/membership mutation revocation;
- RLS adjustment for explicit Device-management operation context.

Functions use fixed `search_path`, qualified table references, no dynamic SQL and bounded issuer/subject input. The authorization function locks the active external identity and active memberships in deterministic Account order.

## Transaction ownership

Hosted protected sync/recovery operations now follow:

```text
verify JWT/JWKS
-> ExternalPrincipal
-> begin serializable bounded-retry transaction
-> authorization fence
-> exactly one active membership
-> set identity/account context
-> lock active actor enrollment and Device
-> set Device/operation context
-> execute operation callback with same PoolClient
-> commit once or roll back all state
```

Hosted composition uses `HostedTransactionAuthorizer` explicitly. The hosted entrypoint passes `RefusingAuthVerifier` for non-hosted fallback so hosted protected operations cannot silently use an independently committed `AuthContext`.

## Route registry

Route registration is descriptor-driven. Each descriptor records method, path, operation and authorization class:

- `principal-only`
- `active-membership`
- `active-actor-device-management`
- `transaction-scoped-operation`

Fastify registration uses these descriptors, and construction verifies described routes are present in Fastify. Current descriptor count is 13, covering identity, enrollment, Device management, sync and recovery routes.

## Actor/target policy

Device status/revoke now separates actor and target:

- actor source: validated `x-markei-device-id` plus active database binding;
- target source: path parameter only;
- owner: same-Account target allowed;
- member: actor Device only;
- locks: stable UUID order, one lock when identical;
- revoked/missing/foreign targets: bounded non-enumerating failure;
- revoke updates enrollment and Device state atomically and inserts a security event only on active-state transition.

## JWT/JWKS state machine

The verifier still delegates cryptography to `jose`. The bounded JWKS source now includes:

- RS256, issuer and audience pinning;
- HTTPS same-origin JWKS requirement when issuer is HTTPS;
- token and JWKS byte ceilings;
- timeout and redirect refusal;
- explicit fresh cache and stale-if-error ceilings;
- global refresh cooldown;
- per-key unknown-`kid` cooldown state;
- concurrent refresh coalescing;
- duplicate `kid` rejection, identical or conflicting;
- generic public failure errors.

Unit tests cover existing JWT/JWKS failure floor cases, but the full R2 rotation/outage/stale-expiry pressure suite is not complete enough to claim full local proof.

## Flutter credential flow

`DeviceEnrollmentTransport` now accepts the bearer credential as an explicit method parameter. `HostedEnrollmentCoordinator` obtains one token per enroll/replay attempt and passes that same value to transport. `HttpDeviceEnrollmentTransport` uses injected origin/client, disables redirects, bounds timeout and response bytes, rejects malformed/additional/missing success fields and maps 409/non-2xx failures without decoding them as success.

## Versions and boundaries

- Event payload v3 unchanged.
- Cursor `c10b:*` unchanged.
- Recovery snapshot format 1 unchanged.
- Hosted enrollment contract remains v1.
- Drift remains v7.
- PostgreSQL migrations 001-004 unchanged; only migration 005 added.
- No provider SDK, callbacks, native secrets, provider IDs, Account UI or Device-management UI added.
- Migration 003 provider worker-role bootstrap remains deferred to human/provider work.

## Deviations and deferrals

Deferred before full R2 success:

- barrier/hook race tests for membership removal/disable across upload, download, acknowledgement and recovery;
- barrier/hook race tests for external identity disable;
- barrier/hook race tests for actor Device revocation across protected routes;
- owner/member target status/revoke race tests;
- full denied-no-state-advance matrix;
- real Flutter HTTP/file-backed hosted enrollment test against loopback Fastify;
- complete JWT rotation, outage/recovery, stale expiry and unknown-key burst suite.

Provider proof, MCG-03, MCG-04 and Cycle 10 closure were not started.
