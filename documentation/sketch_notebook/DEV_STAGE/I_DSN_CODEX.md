# I_DSN_CODEX - C10-MCG02-R04 Partial Design Evidence

Authority marker: C10-MCG02-R04_20260717T130804Z
Controlling J SHA: fd73da6fddf3cc308655c41e0640b045d710d983
Controlling D/E/F commit SHA: cb177621db82cde6be6d658c58daef590e5b9548
Baseline remote SHA: cb177621db82cde6be6d658c58daef590e5b9548
Actual implementation start UTC/local: 2026-07-17T13:19:36.6430880Z / 2026-07-17T10:19:38.0330606-03:00
Actual implementation end UTC/local: 2026-07-17T13:28:17.2098489Z / 2026-07-17T10:28:21.5013124-03:00
Final commit SHA: pending before commit
Evidence environment: Windows PowerShell, Node server workspace, Docker Desktop Linux engine unavailable
Result classification: C10-MCG02-R04_PARTIAL

## Architecture Materialized

- Static teardown evidence was factored through a small proof support predicate used by producer and regression test.
- JWKS producer keeps production opacity and proves metadata irrelevance through externally visible fetch/cooldown behavior.
- Flutter producer keeps the file-backed producer structurally valid while deferring log/persistence proof to R05.
- Authorization producer wrapper fails closed unless the emitted producer record passes.
- Orchestrator acceptance was updated from R3D1 partial authorization semantics to R04 authorization-required semantics while retaining global aggregate false.

## Architecture Not Materialized

- Lab-only authorization barrier port and phases were not implemented.
- Account-scoped state observer was not implemented.
- Transaction fence ordering was not instrumented with deterministic barriers.
- Concurrency, replay, restart and retry-exhaustion architecture was not completed.
- No narrow production authorization deviation was made.

## Retained Boundaries

Retained versions: migrations 001-006, event payload v3, cursor `c10b:*`, recovery snapshot format 1, hosted enrollment contract v1, Drift schema v7, JWT RS256, producer schema version 1, current dependencies and lockfiles.

Resource ownership remains blocked by Docker availability. The final disposable-resource inventory could not be proven because the Docker API could not connect to the Docker Desktop Linux engine.

R05 Flutter and provider proof remain deferred.
