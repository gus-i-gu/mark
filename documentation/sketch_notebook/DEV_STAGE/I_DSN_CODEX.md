# I_DSN_CODEX — R04C02 Design Evidence

Authority marker: C10-MCG02-R04C02_20260717T151546Z
Controlling staging SHA: f1fe19135ba47c652cd2575d7256a74f871f78bb
Controlling D/E/F authority SHA: f1fe19135ba47c652cd2575d7256a74f871f78bb
Baseline implementation SHA: 40e0a7097fef7f8a7abfe172cc867b670dfec196
Actual implementation start UTC/local: 2026-07-17T15:28:19.9012372Z / 2026-07-17T12:28:19.9500907-03:00
Actual implementation end UTC/local: 2026-07-17T15:42:54.4630188Z / 2026-07-17T12:42:54.4929972-03:00
Implementation tree SHA: pending before commit
Final commit status: pending before commit
Evidence environment: services/markei_sync_api, loopback Fastify/JWKS, disposable Docker PostgreSQL 18.4
Result classification: R04C02 core authorization matrix implemented

## Architecture

- R04C02 reuses R04C01 `AuthorizationBarrierController`, no-op production barrier composition, and canonical Account observer.
- Scenario functions now cover cases 2-24 and return structured `ScenarioResult` records consumed directly by `makeProducerResult`.
- The hosted local harness executes case 1 plus cases 2-24, prints case evidence lines, and emits producer schema v1 with exact 28-case inventory.
- The authorization producer owns R04C02 container prefix `markei-c10-mcg02-r04c02-auth-pg`.

## Production Deviation

Retained failing scenario: `actor-device-revoked-before-device-status` timed out waiting for `before-actor-device-lock`, proving Device management routes lacked that lab phase before their actor/target lock helper.

Narrow correction: `HostedIdentityService.deviceStatus` and `HostedIdentityService.revoke` now call `barrier.reach("before-actor-device-lock", transactionContext)` immediately before `authorizeActorAndTargetDevice`. Authorization rules, locks, schema versions, route contracts, and producer schema were unchanged.

## Scenario Mechanics

- CP-A actor cases register and pre-release prerequisite identity/membership phases, then pause at actor Device lock.
- Recovery route cases build valid snapshot/session/chunk fixtures before revocation.
- CP-B target cases use real route calls for status/revoke and inspect transition/event counts.
- CP-C enrollment cases use contract v1 request identity/hash behavior and assert Device/result counts.

## Retained Versions

Retained unchanged: migrations 001-006, event payload v3, cursor `c10b:*`, recovery snapshot format 1, hosted enrollment contract v1, Drift schema v7, JWT RS256, producer schema version 1, dependencies, and lockfiles.

Deferred: R04C04 response-loss/restart/retry/global aggregate, R05 Flutter proof, provider proof, deployment, and Cycle 10 closure.
