# H_DDC_CODEX - C10-S03A Semantic Evidence

Sequence: FLX-INV-02 -> Main J/D/E/F -> Codex materialization report
Role: Codex semantic/test evidence
Round or unit: C10-S03A local hosted-authentication readiness
Branch: `intermid-cycle-recovery`
Baseline SHA: `7bf3bc1c7acf5d4077cedc42ea2162a1bba99e35`
Authority: `E_DDC_STAGE.md` plus J/D/F
Evidence boundary: local proof only; no provider proof or learner-memory promotion

## Materialized vocabulary and states

- `signed-in`: represented only by Flutter authentication-session port state.
- `token-obtained`: represented only by token-source result.
- `token-accepted`: external principal verified by JWT/JWKS.
- `membership-confirmed`: exact issuer/subject identity has exactly one active Account membership.
- `enrollment-required`: protected route has no active Device binding.
- `device-enrolled`: server allocated and persisted Device for stable InstallationId.
- `device-authorized`: active membership plus active Device enrollment inside route transaction.
- `request-accepted`: sync submission accepted by existing protocol.
- `acknowledged`: existing acknowledgement protocol preserved.
- `converged`: local HTTP proof downloaded and acknowledged the synthetic event.
- `hosted-auth-ready`: local provider-free S03A proof only.

## Semantic test results

- JWT accepted valid RS256 access token and rejected wrong audience.
- Missing bearer and oversized token rejected as hosted authentication failures.
- Config parser rejected missing and non-HTTPS production-shaped keys by variable name only.
- Fixture authentication remained direct-test/lab only; hosted entrypoint contains no `FixtureAuthVerifier`.
- Identity endpoint distinguishes membership-required, account-selection-required and membership-confirmed outcomes.
- Enrollment replay kept the same Device result.
- Enrollment hash mismatch returned typed conflict.
- Owner revocation denied the revoked member Device immediately.
- Flutter v7 migration created hosted auth state without resetting existing v6 facts, events, queues, cursors or recovery state.

## HTTP/domain failure mapping

- Authentication-required/token-rejected map to generic hosted authorization failures.
- Missing Device binding maps to `device-enrollment-required`.
- Disabled/absent membership maps to `membership-required`.
- Multiple membership maps to `account-selection-required`.
- Revoked/unknown Device maps to `device-revoked`.
- Foreign/unauthorized operation maps to `forbidden`.
- Enrollment mismatch maps to `conflict`.

## Neutral diagnostics and privacy

- Health reports only `live`, `ready` or `not-ready`.
- Hosted errors expose code, operation, outcome, retryable, safeAction and correlationId only.
- No token, JWT claims, JWKS body, provider URLs, database URLs, emails, profiles, PKCE values or Purchase payloads are logged.
- `.env.example` contains no usable hostname, identifier, credential or secret.

## Local-first behavior

- Normal Flutter composition remains local-first.
- Hosted auth is represented by ports and additive local state only.
- Existing local Device/Event identities are not rewritten.
- Pending local events are not silently reassigned to server Device identity.

## Unsupported wording intentionally absent

- No claim of MCG-02 completion.
- No claim of Auth0 callback, Neon, Render, live hosted development or production acceptance.
- No UI wording for completed hosted login or provider readiness.

## No Cycle 11 or learner promotion

- No Cycle 11 UI/UX, navigation, Device management UI, account selection UI, Analytics or polished retry UX was added.
- Didactic KANBAN, glossary, concept map, lecture register and learner maturity files were unchanged.

Terminal state:

```text
C10-S03A_LOCAL_HOSTED_AUTH_READY
MCG-02_PROVIDER_PROOF_PENDING
```
