# H_DDC_CODEX - C10-S03A-R3 Semantic Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex semantic/test evidence
Unit: C10-S03A-R3 local hosted-authorization correction and decisive proof
Branch: `intermid-cycle-recovery`
Authority: `E_DDC_STAGE.md` plus J/D/F
Evidence boundary: local proof only; provider proof and learner-memory promotion excluded

## Result

```text
C10-S03A_R3_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: full deterministic race/failure proof and real Flutter HTTP/file-backed hosted enrollment proof remain incomplete. The local aggregate is therefore false.

## Materialized Distinctions

- `token-obtained != principal-verified`
- `principal-verified != active-identity`
- `active-identity != membership-confirmed`
- `membership-confirmed != actor-device-authorized`
- `actor-device-authorized != target-device-authorized`
- `transaction-authorized != operation-committed`
- `local-proof-passed != provider-proof-passed`

Hosted code continues to treat JWT verification as an external principal only. Active identity, membership, actor Device, target policy and operation authority are separate states.

## Scoped Revoke Semantics

- Actor authorization is sourced from `x-markei-device-id` and active identity-owned enrollment.
- Target authorization is sourced from the path and same-Account policy.
- Owner may inspect or revoke a same-Account target Device.
- Member may inspect or revoke only the actor Device.
- Foreign and cross-Account targets remain bounded non-enumerating failures.
- Active-to-revoked target transitions are atomic across enrollment and Device state.
- Authorized repeat revoke of an already revoked target returns duplicate-equivalent.
- After self-revoke commits, that actor is no longer active for later protected operations.

## Named Semantic Evidence

- Closed composition: hosted, fixture and disabled authorization branches are explicit construction states.
- Hosted fallback denial: hosted protected operations cannot use fixture or precommitted authorization fallback.
- Route inventory: Fastify actual registrations are compared to typed descriptors rather than to another hard-coded constant.
- Unknown-key behavior: unchanged and stale-retained JWKS refreshes do not authorize unknown keys and establish bounded negative cooldown.
- Closed Flutter outcomes: conflict, unavailable and unknown-outcome are not decoded as success.
- Credential flow: one token is obtained per attempt, passed in memory to transport and never persisted by the new code.

## Privacy And Local-First Behavior

- Normal local registration and local-first Flutter composition were not changed.
- Existing local event identities and pending outbox behavior are preserved by the coordinator failure paths.
- No token, claims, JWKS body, provider URL, generated credential, connection string or fact payload was intentionally logged by the new code.
- Public failures remain generic and bounded.

## Unsupported Wording Absent

No report claims:

```text
HOSTED_AUTH_READY=true
Auth0 success
Render success
Neon acceptance
MCG-02 complete
provider proof passed
production authentication ready
Cycle 10 closed
```

## Didactic Boundary

No KANBAN, glossary, Concept Map, Lecture Register, permanent didactic memory, methodology, A/B/C or J file was modified. Learner maturity and Cycle 11 state remain unchanged.
