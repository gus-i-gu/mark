# H_DDC_CODEX — R04C02 Semantic Evidence

Authority marker: C10-MCG02-R04C02_20260717T151546Z
Controlling staging SHA: f1fe19135ba47c652cd2575d7256a74f871f78bb
Controlling D/E/F authority SHA: f1fe19135ba47c652cd2575d7256a74f871f78bb
Baseline implementation SHA: 40e0a7097fef7f8a7abfe172cc867b670dfec196
Actual implementation start UTC/local: 2026-07-17T15:28:19.9012372Z / 2026-07-17T12:28:19.9500907-03:00
Actual implementation end UTC/local: 2026-07-17T15:42:54.4630188Z / 2026-07-17T12:42:54.4929972-03:00
Implementation tree SHA: pending before commit
Final commit status: pending before commit
Evidence environment: local loopback proof, Docker PostgreSQL 18.4, synthetic identities/JWKS only
Result classification: core matrix checkpoint passed; full authorization producer pending R04C04

## Meanings Materialized

- CP-A proves current identity/membership and actor-Device database authority are rechecked inside real route transactions before protected work.
- CP-B proves target authorization boundaries: owner Account scope, member self-scope, foreign/cross-Account denial, revoke idempotency, concurrent one-transition/one-event truth, and self-revoked actor denial.
- CP-C proves hosted enrollment contract v1 concurrency for equivalent requests and fail-closed conflicting canonical request hashes.
- The authorization producer remains false because R04C04 cases are deliberately false: response-loss replay, process-restart replay, serialization retry exhaustion, and global denied-no-state-advance.

## Evidence Distinctions

All 24 true cases came from structured ScenarioResults invoked by the hosted local harness and producer path. They were not inherited from broad command success, test prose, or prior observational records.

Denied routes used valid synthetic tokens, identities, memberships, Devices, request bodies, recovery snapshots, sessions, and chunks before the authority transition. Malformed input and recovery-unavailable responses were not accepted as authorization proof.

## Privacy And Unsupported Claims

Observer evidence remains payload-free and credential-free. JWTs, claims, provider credentials, passwords, fact payloads, and connection strings were not reported.

R04C02 does not claim complete R04 authorization, complete Flutter proof, R3 local security, provider acceptance, production readiness, MCG-02 completion, or Cycle 10 closure. Learner maturity and permanent memory were unchanged.
