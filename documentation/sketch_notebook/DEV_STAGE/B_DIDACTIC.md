# B_DIDACTIC — C10-S03A-R2 Authorization and Hosted-Enrollment Semantics

> Sequence: FLX-INV-02
> Role: Didactic Chat [A]
> Baseline: `34bc032df26d4b6d727d3ba6f2e08bbb0b11e13f`
> Unit: C10-S03A-R2 local corrective investigation
> Status: provisional investigation for Main
> Materialization authority: none
> Provider authority: none
> Learner maturity: unchanged

## 1. Methodology retained

The controlling route was read as:

```text
INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
```

Retained rules:

- B owns semantic distinctions, truthful state language and misconception prevention.
- B may investigate source because implementation truth is the task, but it cannot select architecture.
- J at `34bc032` is Main's controlling contradiction record.
- G/H/I are Codex observations; passing reports cannot promote themselves.
- Source fact, report claim, inference and proposal remain distinct below.
- Implemented, validated, contradicted, partial and provider-pending are not synonyms.
- No source, permanent memory, D/E/F, J, KANBAN maturity or Lecture Register change is authorized.
- Cycle 11 presentation remains outside this correction.

## 2. Evidence inspected

Primary files:

- `hosted_authorization.ts` and its authorization/database/protocol imports;
- `app.ts`, all registered hosted/sync/recovery routes and called services;
- `jwt_verifier.ts`, `jose` use and hosted configuration/composition;
- migrations 003/004 and transaction retry/context support;
- hosted tests and the local hosted harness;
- Flutter hosted-auth ports, coordinator, HTTP transport, Drift repository and tests;
- J and G/H/I at the baseline.

The permanent Didactic checkpoint already owns the durable distinctions between authentication,
membership, enrollment, authorization, local proof and provider proof. This report refines their
observable R2 consequences; it does not promote new canon.

## 3. Claim classification

| Claim | Classification | Evidence boundary |
| --- | --- | --- |
| JWT verification returns an external principal | source fact | signature/token layer only |
| eight sync/recovery actions run through `authorizeOperation` | source fact | currently registered eight routes |
| every protected hosted route has declared policy | contradicted report claim | identity/enrollment/status/revoke routes are absent from the registry |
| membership and Device authority are transaction-time facts | intended semantics | membership is read without explicit lock; races unproved |
| revocation requires an authorized actor Device | contradicted | an unproved header can satisfy non-owner self-revocation |
| device status has a defined owner/member visibility policy | contradicted/incomplete | membership alone currently permits Account-scoped lookup |
| enrollment conflict is interoperable across Flutter and server | contradicted | server returns typed conflict with HTTP 200; Flutter expects 409 |
| coordinator's accepted token is the HTTP credential | contradicted/incomplete | coordinator obtains one token; transport reads another callback |
| JWT/JWKS failure floor is complete | partial/contradicted diagnostic | meaningful unit subset exists; diagnostic is unconditional |
| local registration survives hosted failure | design intent with narrow fake evidence | no real outbox-before/after HTTP proof |
| MCG-02 provider proof is ready | blocked | R2 and provider evidence absent |

## 4. Required identity spine

The truthful operation order is:

```text
credential presented
→ token verified
→ external principal established
→ active Markei identity established
→ active Account membership established
→ actor Device established when policy requires it
→ target resource/Device resolved under Account scope
→ named operation authorized
→ operation committed or denied in the same transaction
```

None of these arrows may be skipped in wording or diagnostics.

### Actor and target

- **Actor identity** is the active issuer+subject mapping making the request.
- **Actor membership** is the actor identity's active role in one Account.
- **Actor Device** is an active enrollment bound to that actor identity; a Device header is only a
  claim until the server proves this binding.
- **Target Device** is the Device whose status is read or changed.
- `actorDeviceId == targetDeviceId` means self-targeting only after actor ownership is proved.
- Owner authority is an Account role; it must not be inferred from Device possession.
- A target Device identifier is never a credential.

Source fact: non-owner `revoke` presently compares the header to the path target without proving
actor ownership. Proposal: R2 must define whether owners need an active actor Device and whether
members may inspect/revoke only their own Device. Main must select the policy; B requires the words
and tests to reveal it.

## 5. Membership and authorization timing

`token-valid`, `identity-active`, `membership-active`, `device-active` and
`operation-committed` are observations at different boundaries.

Source fact: sync/recovery uses a serializable transaction and locks enrollment/Device rows, but
membership resolution defaults to an unlocked read. Database retry is bounded to three attempts
within five seconds for serialization/deadlock SQL states.

Inference: serializable isolation may abort some races, but a sequential success cannot establish
the outcome of membership removal or Device revocation racing a mutation.

Proposal: an operation may claim `device-authorized-for-transaction` only when a named barrier test
shows either:

```text
authorization commits before removal/revocation
→ operation may commit under the selected ordering

or

removal/revocation commits first
→ protected operation is denied with no protected-state advancement
```

`race passed` is insufficient; evidence must record which transaction won, whether retry occurred,
and which state remained unchanged.

## 6. Route-policy vocabulary

Every hosted non-health route needs one declared policy containing at least:

```text
operation
principal required
membership policy
actor Device policy
target policy
role policy
transaction policy
privacy-safe failure contract
```

Source fact: `PROTECTED_ROUTE_POLICIES` lists eight sync/recovery operations but omits identity,
enroll, enrollment-status, device-status and revoke. Its test compares the list to another manually
written list, not actual Fastify registrations.

Proposal: call the corrected artifact an **enforceable hosted-route policy registry** only if route
registration consumes it or a test mechanically compares the Fastify route inventory to it.
`Protected route count` must name both included and deliberately public routes.

The older public `HostedAuthVerifier.verify` returns an independently committed `AuthContext`.
Source fact: current hosted sync routes use `authorizeOperation`; inference: future code can still
choose `verify` and reintroduce stale authority. R2 should remove, contain or make this path
unrepresentable in hosted composition before claiming omission-safe authorization.

## 7. Enrollment and unknown-outcome semantics

One transport contract must hold across server and Flutter:

| Outcome | Meaning | Safe action |
| --- | --- | --- |
| `device-enrolled` | one installation binding committed | persist returned binding |
| `duplicate-equivalent` | same request/content resolves to stored equivalent result | reuse binding |
| `conflict` | same request identity carries different content | stop; preserve request evidence |
| `not-found` | no queryable stored result under this actor/account | preserve local state; follow policy |
| `service-unavailable` | server could not give a reliable final result | query/replay same request identity |
| `unknown-outcome` | operation may have committed but response is absent | never create a replacement identity blindly |

Source fact: server returns a `ProtocolFailure(code=conflict)` as HTTP 200; Flutter treats only HTTP
409 as conflict and decodes other 2xx bodies as enrollment success. This can turn a truthful server
conflict into a client decoding failure.

Proposal: Main should select either a non-2xx typed failure or a discriminated 2xx response union.
Whichever is selected must be shared by server, Flutter decoder, harness and fixtures. Transport
status and domain outcome must not disagree.

Source fact: the coordinator obtains an access token, then calls a transport without passing it;
the HTTP transport independently calls its own token callback. Proposal: one operation-scoped
credential must flow through the tested port without storage or logging. `token-obtained` may be
claimed only for the token actually sent.

## 8. Revocation and local-first meaning

`Device revoked` means server authorization was withdrawn. It does not mean:

- the external identity was disabled;
- Account membership was removed;
- local Drift facts were erased;
- pending local events were rejected as invalid;
- a replacement Device was enrolled;
- every concurrent request was prevented without race evidence.

Required local behavior after denial:

```text
preserve authoritative local facts
preserve outbox identity and payload
record hosted denial without fabricating server acceptance
block further protected submission under the revoked Device
await an explicitly authorized recovery/replacement path
```

Source fact: Flutter tests use memory databases and a fake enrollment transport. They do not create
real outbox rows, use the HTTP transport, close/reopen a file-backed database or prove server
revocation propagation. Therefore `local work survives` remains narrow fake-adapter evidence.

## 9. JWT/JWKS truthful states

Required distinctions:

- `authentication-required`: bearer credential absent or structurally unusable;
- `token-rejected`: cryptographic/claim/key-source contract failed;
- `key-cache-current`: configured cache age has not elapsed;
- `key-refresh-required`: cache expired or key absent;
- `key-refresh-coalesced`: concurrent demand shared one refresh;
- `key-source-unavailable`: bounded retrieval failed;
- `stale-key-accepted`: allowed only if Main defines a separate maximum stale interval;
- `unknown-key`: refreshed set still lacks the requested key;
- `provider-validated`: prohibited until real provider evidence exists.

Source facts:

- RS256, issuer, audience, token time, subject, size, redirect and JWKS size/count checks exist.
- `validSubject` already bounds subject length to 256, but no named oversized-subject test exists.
- conflicting duplicate `kid` values are rejected; identical duplicates are accepted.
- refresh failure returns to any existing local cache even after normal expiry, with no independent
  maximum stale duration.
- an explicitly supplied JWKS URI is protocol-checked but not bound to issuer origin.
- the harness does not execute the JWT test suite before printing `JWKS_FAILURE_FLOOR=true`.

Proposal: R2 must name its stale-key policy. If stale verification is forbidden, expired cache plus
refresh failure is `token-rejected`. If bounded stale use is selected, its maximum interval and
diagnostic must be explicit. No wording should imply that an Auth0 outage invalidates local data.

## 10. Named semantic tests for R2

### Actor, target and policy

1. `member cannot revoke another identity Device by copying its DeviceId into the header`
2. `member may revoke own active Device only under the selected self policy`
3. `owner target action follows the explicit actor Device requirement`
4. `device status hides foreign and unknown target existence under one generic result`
5. `every registered hosted non-health route has exactly one declared policy`
6. `hosted protected routes cannot call independently committed verify authority`

### Transaction ordering

7. `membership removal winning the barrier denies mutation and advances no sync state`
8. `authorized mutation winning the barrier has a deterministic recorded ordering`
9. `Device revocation winning the barrier denies each protected operation without state advance`
10. `serialization retry preserves one idempotency identity and bounded outcome`
11. `retry exhaustion returns unknown or not-applied according to observed commit knowledge`

### Enrollment and Flutter

12. `server conflict status and Flutter decoder produce one typed conflict`
13. `same enrollment identity and hash replays the stored Device result`
14. `same enrollment identity with different hash mutates no binding`
15. `response loss queries or replays the same enrollment identity after restart`
16. `coordinator token is exactly the credential sent by real HTTP transport`
17. `HTTP timeout and oversized response preserve unknown outcome and local state`
18. `file-backed reopen preserves enrollment progress without storing token bytes`
19. `real outbox rows are byte-for-byte/identity stable across cancellation outage and denial`

### JWT/JWKS

20. `oversized subject is token-rejected`
21. `duplicate kid policy rejects ambiguous JWKS including identical duplicates if selected`
22. `genuine key rotation accepts new key only after bounded refresh`
23. `JWKS timeout is bounded and maps to generic token rejection`
24. `expired cache cannot be reused beyond the selected stale limit`
25. `refresh failure obeys cooldown and later bounded retry`
26. `unknown kid after successful refresh cannot trigger unbounded fetches`
27. `configured JWKS URI obeys the selected issuer-origin policy`

### Evidence language

28. `each proof diagnostic is emitted only by the suite that establishes it`
29. `denied operations leave cursor acknowledgement sequence and recovery state unchanged`
30. `provider-pending reports contain no hosted-ready or provider-validated wording`

## 11. Evidence and diagnostic rules

A diagnostic must identify its producer and evidence boundary. The TypeScript harness cannot claim
Flutter or the independent JWT suite merely because the repository contains them.

Acceptable examples:

```text
ROUTE_POLICY_INVENTORY=true producer=server-policy-test routes=<count>
ACTOR_TARGET_AUTHORIZATION=true producer=barrier-suite cases=<count>
JWT_JWKS_FAILURE_FLOOR=true producer=jwt-suite cases=<count>
FLUTTER_HTTP_ENROLLMENT=true producer=flutter-http-test reopen=file-backed
OUTBOX_PRESERVED=true before=<count> after=<count>
```

Forbidden shortcuts:

- `least privilege` from two differently named URLs without role/denial evidence;
- `two-Account isolation` from one denial generalized to every route;
- `Flutter hosted lab` from a TypeScript-only process;
- `race safe` from serializable configuration without barrier evidence;
- `provider ready` from local generated keys or dashboard preparation.

## 12. Privacy-safe failure language

Public failures should disclose only the safe action needed by the acting client. Foreign Account,
membership, identity, Device and enrollment-request existence must not be distinguishable where the
selected policy requires anti-enumeration.

Never log:

- bearer tokens, authorization headers or full JWT claims;
- raw issuer/subject pairs, email or profile claims;
- database/provider credentials or JWKS bodies;
- Purchase facts, snapshot content or full Device inventories.

Correlation aliases, operation, bounded status, counts and selected retry action are sufficient for
R2 evidence.

## 13. Main decisions required

1. Must an owner present an active actor Device to inspect or revoke a target Device?
2. May a member inspect/revoke only Devices enrolled to the same identity?
3. Which privacy-safe result represents foreign and unknown Device targets?
4. Which least-privilege mechanism orders membership mutation against protected operations?
5. Is old `verify` removed, hidden or separated into a fixture-only interface?
6. Does enrollment conflict use HTTP 409 or a discriminated 2xx union?
7. Is stale JWKS use forbidden or separately time-bounded?
8. Must an explicit JWKS URI share issuer origin, or follow another pinned allow-list rule?
9. Which diagnostics aggregate independent server, JWT and Flutter suites?

## 14. Boundary and disposition

R2 may correct ports, server contracts, transaction semantics, tests and neutral diagnostics. It
must not add login UI, Account selection UI, Device-management screens, provider mutation or
production invitation/signup behavior.

```text
source fact:
  bounded local mechanisms exist, but actor/target, route inventory and Flutter conflict seams are
  contradicted or incomplete

report claim:
  G/H/I correctly declare PARTIAL, while several individual proof diagnostics overstate evidence

proposal:
  use the named semantics and tests above for Main's R2 synthesis

provider status:
  MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED

learner maturity:
  unchanged

stage status:
  PROVISIONAL DIDACTIC INVESTIGATION — NOT CODEX AUTHORITY
```
