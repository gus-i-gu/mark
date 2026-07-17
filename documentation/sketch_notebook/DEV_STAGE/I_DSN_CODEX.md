# I_DSN_CODEX — R04C01 Design Evidence

Authority marker: C10-MCG02-R04C01_20260717T143908Z
Controlling J SHA: 2d85523952a3606ec80a3769817cb4ad8e647cb9
Controlling D/E/F SHA: 2d85523952a3606ec80a3769817cb4ad8e647cb9
Baseline remote SHA: 2f7272a8cacaa790ccfaad6c0c7523eede336460
Actual implementation start UTC/local: 2026-07-17T14:49:00.7290473Z / 2026-07-17T11:49:00.7780130-03:00
Actual implementation end UTC/local: 2026-07-17T15:05:21.3977466Z / 2026-07-17T12:05:22.8704211-03:00
Implementation tree SHA: pending at report authoring
Final commit status: pending before commit
Evidence environment: services/markei_sync_api, loopback Fastify/JWKS, disposable Docker PostgreSQL 18.4
Result classification: R04C01 infrastructure slice materialized

## Dependency Direction

- Production exports only the `AuthorizationBarrier` interface and inert no-op default.
- Lab controller lives under `src/proof/` and is injected only by proof composition.
- Normal hosted composition remains no-op and exposes no HTTP control route.

## Corrected Phase Placement

- `before-identity-membership-fence`: reached after transaction begin and before `markei_authorize_identity_membership`.
- `after-membership-lock`: reached after the migration-005 function, which locks active external identity and active membership rows with `FOR UPDATE`.
- `before-actor-device-lock`: reached immediately before actor Device/enrollment `FOR UPDATE`.
- `before-target-transition`: moved to after actor/target authorization and locks, immediately before revoke transition update.
- `before-protected-mutation`: reached before the first durable write; enrollment now reaches before Device, enrollment, security-event, and request-result writes.
- `before-commit`: provided through a context-aware database hook carrying operation/scenario/participant context.

## Controller And Observer

- Controller contract: `reach`, `waitUntilReached`, `release`, `close`.
- Controller containment: scenario/participant keys, known phase validation, bounded timeout, unknown key rejection, close cleanup, closed reuse denial.
- Observer architecture: separate committed-view pool connection, canonical sorted safe rows, membership-excluded protected-state comparison.
- Observer scope: submissions, sync events, cursor state, acknowledgements, recovery sessions/chunks, Devices, enrollment requests, security events, and membership status.

## Scenario And Resource Lifecycle

- Scenario runner path seeds synthetic authority, starts loopback Fastify and JWKS, captures before state, starts upload participant, waits at barrier, commits membership disable through control connection, releases upload, captures HTTP response and after state, compares protected families, and closes app/controller/pools/JWKS/container owners in `finally`.
- Authorization producer owns the R04C01 PostgreSQL container prefix `markei-c10-mcg02-r04c01-auth-pg` and removes it in `finally`.

## Retained Versions And Deviations

- Retained: migrations 001-006, event payload v3, cursor `c10b:*`, recovery snapshot format 1, hosted enrollment contract v1, Drift schema v7, JWT RS256, producer schema version 1, dependencies and lockfiles.
- Narrow production deviations: barrier context gained scenario/participant fields; transaction before-commit hook now receives context; enrollment barrier placement moved before first durable write; device revoke target-transition barrier moved after authorization/locks.
- Deferred: remaining 27 authorization cases, global denied-no-state-advance, R05 Flutter proof, provider proof, deployment, and Cycle 10 closure.
