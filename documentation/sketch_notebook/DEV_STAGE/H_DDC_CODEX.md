# H_DDC_CODEX — R04C01 Semantic Evidence

Authority marker: C10-MCG02-R04C01_20260717T143908Z
Controlling J SHA: 2d85523952a3606ec80a3769817cb4ad8e647cb9
Controlling D/E/F SHA: 2d85523952a3606ec80a3769817cb4ad8e647cb9
Baseline remote SHA: 2f7272a8cacaa790ccfaad6c0c7523eede336460
Actual implementation start UTC/local: 2026-07-17T14:49:00.7290473Z / 2026-07-17T11:49:00.7780130-03:00
Actual implementation end UTC/local: 2026-07-17T15:05:21.3977466Z / 2026-07-17T12:05:22.8704211-03:00
Implementation tree SHA: pending at report authoring
Final commit status: pending before commit
Evidence environment: local loopback proof, Docker PostgreSQL 18.4, synthetic RS256/JWKS, no provider access
Result classification: reusable proof slice passed; authorization matrix remains pending

## Meanings Materialized

- Barrier versus fence: the barrier is a lab-only coordination point; the authorization fence remains the production transaction-time database recheck.
- Valid denial: the representative upload started from a valid token, identity, membership, Device, body, and route, then failed only after the control transaction disabled membership.
- Expected membership transition: before/after comparison explicitly allowed `account_memberships.status` to change from `active` to `disabled`.
- No protected state advance: submissions, sync events, cursor state, acknowledgements, recovery sessions/chunks, Devices, enrollment requests, and security events remained equivalent.
- Vertical-slice distinction: R04C01 proves reusable infrastructure plus one case, not the full authorization race matrix.
- Producer distinction: `authorization-race` remains false because 27 cases and global `denied-no-state-advance` remain pending.

## Named Semantic Tests

- `R04C01 controller reaches and releases the intended participant`
- `R04C01 controller rejects unknown phase and participant keys`
- `R04C01 controller times out and close rejects waiters`
- `normal hosted composition remains no-op for authorization barriers`
- `R04C01 enrollment protected-mutation signal precedes first durable write`
- `R04C01 before-commit hook receives operation and participant context`
- `R04C01 observer comparison is canonical and excludes payload data`
- `R04C01 producer marks only the measured case true and remains false`

## Privacy And Unsupported Claims

- Observer output excludes JWTs, claims, credentials, connection strings, passwords, and fact payloads.
- No bearer token logging proof was claimed here; Flutter remains deferred to R05.
- Unsupported readiness wording is intentionally absent: no Auth0 acceptance, Neon acceptance, Render deployment, production readiness, MCG-02 completion, R3 local security proof, or Cycle 10 closure is claimed.
- Learner maturity and permanent memory were unchanged.
