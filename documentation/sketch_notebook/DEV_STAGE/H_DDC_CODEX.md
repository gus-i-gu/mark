# H_DDC_CODEX - C10-MCG02-R04 Partial Semantic Evidence

Authority marker: C10-MCG02-R04_20260717T130804Z
Controlling J SHA: fd73da6fddf3cc308655c41e0640b045d710d983
Controlling D/E/F commit SHA: cb177621db82cde6be6d658c58daef590e5b9548
Baseline remote SHA: cb177621db82cde6be6d658c58daef590e5b9548
Actual implementation start UTC/local: 2026-07-17T13:19:36.6430880Z / 2026-07-17T10:19:38.0330606-03:00
Actual implementation end UTC/local: 2026-07-17T13:28:17.2098489Z / 2026-07-17T10:28:21.5013124-03:00
Final commit SHA: pending before commit
Evidence environment: Windows PowerShell, Node server workspace, Docker Desktop Linux engine unavailable
Result classification: C10-MCG02-R04_PARTIAL

## Meanings Materialized

- `resource-teardown` now means command exit code zero plus empty trimmed disposable-resource inventory.
- `irrelevant-metadata-preserves-revision` now means externally observable unknown-kid cooldown preservation across metadata-only JWK refresh, with no extra fetch before cooldown expiry.
- `token-not-persisted-or-logged` is not proved in R04 and remains `false` with blocker `not-yet-r05`.
- `authorization-race` cannot pass unless the authorization producer record itself passes.
- R04 orchestration now distinguishes authorization producer completion from global R3 local security completion.

## Semantic Tests

- `static teardown rejects successful non-empty disposable inventory`: passed.
- `Auth0JwtVerifier preserves unknown kid cooldown across irrelevant JWK metadata`: passed.
- Flutter producer structural mapping: observed false with only `not-yet-r05` blockers.

## Deferred Meanings

The 28-case authorization matrix was not semantically proved. No denied-no-state-advance, one-transition, one-event, duplicate-equivalent, unknown-outcome, restart replay, or retry-exhaustion meaning was validated because the PostgreSQL lab did not start.

The following claims remain intentionally absent:

- complete Flutter proof;
- complete R3 local security;
- Auth0 acceptance;
- Neon acceptance;
- Render deployment;
- MCG-02 completion;
- production readiness;
- Cycle 10 closure.

Learner maturity and permanent didactic memory were unchanged.
