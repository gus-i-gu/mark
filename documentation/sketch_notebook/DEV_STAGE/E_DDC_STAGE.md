# E_DDC_STAGE — C10-S03A-R2 Semantic Materialization Authority

> Baseline: `34bc032df26d4b6d727d3ba6f2e08bbb0b11e13f`
> Joint authority: J + D/E/F
> Learner maturity: unchanged
> UI authority: none

## 1. Purpose

Materialize truthful, closed semantics for hosted identity, Device management, enrollment,
transaction authorization, JWT/JWKS recovery and evidence. E does not authorize UI or permanent
didactic promotion.

## 2. Required distinctions

Code, contracts, tests and reports must preserve:

```text
token-obtained != principal-verified
principal-verified != active-identity
active-identity != membership-confirmed
membership-confirmed != actor-device-authorized
actor-device-authorized != target-device-authorized
transaction-authorized != operation-committed
device-enrolled != device-perpetually-authorized
enrollment-request-accepted != response-received
local-proof-passed != provider-proof-passed
runtime-ready != migration-authorized
```

## 3. Identity spine

Use these meanings consistently:

- External principal: verified issuer/subject/audience from one access token.
- External identity: server row corresponding to the external principal.
- Membership: Account-scoped relationship and owner/member role.
- Actor Device: Device named by the authenticated request header and bound to the acting identity.
- Target Device: Device named by the management-route path.
- Installation: local installation identity; not authentication or Device authorization.
- Enrollment request: durable idempotent request identity and canonical hash.
- Authorization fence: transaction ordering mechanism, not a membership grant.

Never infer AccountId or DeviceId directly from Auth0 subject or token possession.

## 4. Device-management semantics

Required outcomes:

- owner + active actor + same-Account target → target operation permitted;
- member + active actor + same actor target → self-operation permitted;
- member + foreign target → `operation-denied`;
- absent/revoked/mismatched actor → `device-revoked` or generic denial according to the closed
  contract;
- cross-Account target → generic non-enumerating denial;
- repeated successful revoke → `duplicate-equivalent`, with no second security event.

The request header authenticates the actor only after database binding. Equality between header and
path text alone never proves ownership.

## 5. Enrollment and HTTP outcomes

Use a closed distinction:

```text
device-enrolled              successful committed new binding; HTTP 2xx
duplicate-equivalent         same committed binding/result; HTTP 2xx
conflict                     same identity with different canonical request; HTTP 409
enrollment-required          no authorized binding; non-2xx
device-revoked               binding no longer authorizes; non-2xx
service-unavailable          known not-applied or unavailable; non-2xx
unknown-outcome              commit/result cannot be known; retry/query same identity
```

Flutter must not decode a failure body as `DeviceEnrollmentResult`. On conflict, cancellation,
timeout, malformed/oversized response or unknown outcome, it preserves facts/outbox and the durable
request identity needed for safe query/replay.

## 6. Authorization timing

Required temporal rule:

```text
fence acquired
→ active identity/membership resolved
→ actor/target policy resolved
→ protected operation executes
→ one transaction commits or rolls back
```

If identity/membership revocation commits first, the protected operation is denied. If the protected
operation commits first under the selected lock order, revocation becomes effective for later
transactions. Reports must not describe serializable isolation alone as proof of this ordering.

## 7. Route-policy vocabulary

Every non-health route has exactly one declared class:

```text
principal-only
active-membership
active-actor-device-management
transaction-scoped-operation
```

“Protected route” means its declared policy is enforced by the registration mechanism. A separate
documentation constant does not make a route protected.

## 8. JWT/JWKS semantic states

Use internal/test states where helpful:

```text
jwks-fresh
jwks-stale-within-limit
jwks-refreshing
jwks-refresh-cooldown
jwks-unknown-key-cooldown
jwks-stale-expired
token-rejected
```

No client-facing response reveals provider URL, key ID, cache contents, token claims or raw provider
error. Stale-within-limit is bounded resilience; it is not fresh verification. After the stale
ceiling, verification rejects.

## 9. Local-first and privacy behavior

- Token bytes exist only in memory for the immediate request.
- Do not persist/log token, claims, issuer URL, JWKS body, credentials or fact payloads.
- Authentication or network failure does not erase or reassign local facts/outbox events.
- Device revocation stops hosted authorization; it does not delete local Purchase history.
- Provider unavailability does not disable ordinary local registration.
- Correlation identifiers remain bounded and non-secret.

## 10. Named semantic tests

At minimum implement named cases equivalent to:

### Actor/target

- `member_cannot_revoke_foreign_device_by_forging_actor_header`
- `member_can_revoke_only_bound_actor_device`
- `owner_active_actor_can_revoke_same_account_target`
- `revoked_actor_cannot_read_status_or_revoke`
- `cross_account_target_is_not_enumerated`
- `duplicate_revoke_emits_one_security_event`

### Ordering/routes

- `membership_disable_and_operation_obey_one_fence`
- `identity_disable_and_operation_obey_one_fence`
- `denied_operation_does_not_advance_protocol_state`
- `every_registered_non_health_route_has_one_policy`
- `hosted_route_cannot_use_precommitted_verify_fallback`

### Enrollment/Flutter

- `server_and_flutter_agree_on_409_conflict`
- `coordinator_token_is_transport_bearer_token`
- `transport_does_not_fetch_a_second_token`
- `unknown_outcome_replays_same_enrollment_identity`
- `file_reopen_preserves_enrollment_progress`
- `failed_enrollment_preserves_real_outbox_row`
- `oversized_or_malformed_response_is_not_success`

### JWT/JWKS

- `jwks_uri_must_match_issuer_origin`
- `stale_key_is_accepted_only_within_frozen_window`
- `stale_key_is_rejected_after_final_ceiling`
- `unknown_key_burst_performs_bounded_refresh`
- `genuine_rotation_accepts_new_valid_key`
- `any_duplicate_kid_is_rejected`
- `timeout_aborts_without_provider_detail`

### Evidence

- `diagnostic_true_requires_its_own_passing_gate`
- `typescript_harness_does_not_claim_flutter_execution`
- `provider_pending_is_not_hosted_ready`

## 11. Report wording

G/H/I may say implemented or locally validated only when named evidence supports it. They must not
say:

```text
Auth0 configured and accepted
Neon migrations applied
Render deployment validated
production authentication ready
MCG-02 complete
Cycle 10 closed
```

Required successful semantic conclusion:

```text
C10-S03A_R2_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

If a gate is incomplete, use `C10-S03A_R2_PARTIAL` and name it. No phase before transaction commit
may claim `operation-committed`; no request before safe replay resolution may claim restored or
complete.

## 12. Presentation boundary

Do not add pages, dialogs, banners, Device controls, Account selection, retry UI, analytics,
accessibility redesign or Cycle 11 presentation. Neutral lab/test diagnostics are allowed.

Do not modify KANBAN, glossary, Concept Map, Lecture Register or learner maturity. E authorizes only
contract/state names and semantic tests required by the local correction.
