# H_DDC_CODEX - C10-S03A-R2 Semantic Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex semantic/test evidence
Unit: C10-S03A-R2 local hosted-authorization correction
Branch: `intermid-cycle-recovery`
Authority: `E_DDC_STAGE.md` plus J/D/F
Evidence boundary: local proof only; provider proof and learner-memory promotion excluded

## Result

```text
C10-S03A_R2_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: deterministic barrier proof is incomplete for the full membership, identity, Device revocation, owner/member target management and denied-state-no-mutation matrix. Real Flutter HTTP/file-backed hosted enrollment proof against loopback Fastify was not added.

## Materialized distinctions

- `token-obtained != principal-verified`
- `principal-verified != active-identity`
- `active-identity != membership-confirmed`
- `membership-confirmed != actor-device-authorized`
- `actor-device-authorized != target-device-authorized`
- `transaction-authorized != operation-committed`
- `local-proof-passed != provider-proof-passed`

The hosted server now treats JWT verification as `ExternalPrincipal` only. Active identity, membership, actor Device, target Device and operation authority are resolved within the same serializable transaction that executes protected sync/recovery operations.

## Named semantic evidence

- Principal verification is not membership: identity and hosted operations use the database authorization fence for active identity/membership.
- Membership is not actor Device authority: protected sync/recovery requires the actor Device header and active enrollment/device state.
- Actor Device is not target Device: Device status/revoke distinguishes header actor from path target.
- Owner/member target policy is explicit: owner can inspect/revoke same-Account targets; member only its actor Device.
- Authorization is not commit: protected route callbacks run through `HostedTransactionAuthorizer` and commit once after callback success.
- Conflict is closed: enrollment request-hash conflict returns HTTP 409 and Flutter maps it to conflict, not success.
- Token is not durable client state: coordinator passes one token per attempt into transport; transport never fetches or persists a second token.
- Local proof is not provider proof: reports keep provider proof pending and do not claim hosted provider readiness.

## Privacy and local-first behavior

- Normal local registration and local-first Flutter composition were not changed.
- Pending local event identity is not reassigned by hosted enrollment code.
- Cancellation, token rejection and service-unavailable paths preserve local hosted enrollment progress without storing token bytes.
- New server errors remain generic and bounded to public failure codes and correlation IDs.
- No token, claims, provider URI, JWKS body, generated credential or fact payload was intentionally logged by new code.

## Unsupported wording absent

No successful report claims:

```text
Auth0 success
Render success
Neon acceptance
MCG-02 complete
provider proof passed
production authentication ready
Cycle 10 closed
```

## Didactic boundary

No KANBAN, glossary, Concept Map, Lecture Register, permanent didactic memory, methodology, A/B/C or J file was modified. Learner maturity and Cycle 11 state remain unchanged.
