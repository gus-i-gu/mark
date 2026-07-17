# E_DDC_STAGE — C10-MCG02-R04B Semantic Materialization Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04B_20260717T133814Z
> Staged at UTC: 2026-07-17T13:38:14Z
> Staged at America/Sao_Paulo: 2026-07-17T10:38:14-03:00
> Controlling reconciliation: 0765255c07e3381f74cd9b4e90bc2f9ddd3b13dc
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Governing distinction

Use exactly:

~~~text
environment available
≠ scenario implemented
≠ scenario executed
≠ case passed
≠ producer passed
≠ R04 passed
≠ local security passed
≠ provider accepted
~~~

Docker unavailability is an environmental blocker. It neither proves nor disproves authorization.

## 2. Retained accepted meanings

- resource-teardown means successful query plus zero matching resources;
- irrelevant-metadata-preserves-revision means preserved observable unknown-kid cooldown/fetch
  behavior;
- token-not-persisted-or-logged remains false until R05;
- authorization producer true requires every declared case true;
- R04 success remains distinct from global local-security success.

## 3. Barrier meaning

A deterministic barrier is a lab-only synchronization point that proves ordering through explicit
reach and release signals.

It is not:

- an arbitrary sleep;
- a production debug route;
- a database flag exposed to clients;
- evidence by itself.

Barrier evidence must identify the reached phase and the control transition committed before
release.

## 4. Fence meaning

The transaction-time authorization fence requires current:

- active external identity;
- active matching Account membership;
- active actor Device belonging to the Account and identity;
- role permission for the operation;
- target permission where applicable.

Previously verified JWT claims are authenticated input, not current database authority.

## 5. Valid denial

A denial case passes only when:

1. the request is otherwise valid;
2. required recovery/session state exists;
3. the authority change occurs at the declared barrier;
4. the expected closed authorization result occurs;
5. protected state is unchanged.

Malformed input, missing fixtures, recovery-unavailable or generic infrastructure failure is not an
authorization denial.

## 6. Protected state

Denied-no-state-advance covers:

- authoritative facts/events;
- cursors/high-water and acknowledgements;
- recovery sessions/chunks;
- Device state;
- enrollment request/result state;
- security events.

State equality must be canonical and Account-scoped.

## 7. Target semantics

- owner may inspect and revoke an Account Device;
- ordinary member may inspect and revoke only their own Device;
- foreign target is denied without existence disclosure;
- cross-Account target is denied without existence disclosure;
- self-revocation prevents subsequent protected action.

One successful active-to-revoked transition produces one security event.

Equivalent later replay returns duplicate-equivalent truth without another transition/event.

## 8. Enrollment semantics

Equivalent concurrent enrollment means same:

- identity;
- Account;
- installation identity;
- request identity;
- canonical request hash.

It converges on one durable meaning.

Same request identity with a different hash is a conflict. It preserves the first accepted truth and
creates no second Device/result.

## 9. Unknown outcome semantics

Response-loss means the server committed but delivery was suppressed. The client cannot classify it
as a normal rejection.

Same-identity query/replay must recover the committed result without duplicate state.

Restart replay requires a new application composition over persisted database state. Reusing the
same service instance does not prove restart recovery.

## 10. Retry exhaustion semantics

Serialization/deadlock exhaustion requires the real bounded retry path. Passing means:

- every configured attempt is observed;
- the ceiling is respected;
- final result fails closed;
- no protected state advances.

An exception before transaction entry does not prove retry exhaustion.

## 11. Case evidence shape

Each case must retain:

- case ID;
- valid setup;
- barrier/direct action;
- observed response/result;
- exact before/after comparison;
- safe blocker if false.

A broad harness or test-file exit cannot silently promote several meanings.

## 12. Completion language

Allowed on R04B success:

~~~text
Authorization barrier matrix proved locally.
All 28 authorization producer cases passed.
Flutter and provider proof remain pending.
Global local security remains false.
~~~

Forbidden:

~~~text
MCG-02 complete
Auth0 verified
Neon accepted
Render deployed
production ready
Cycle 10 closed
~~~

## 13. Privacy

Reports may contain safe case IDs, booleans, blocker categories and synthetic aliases.

Do not expose tokens, claims, JWK bodies, passwords, URLs, provider IDs, connection strings or fact
payloads. Add no telemetry.

## 14. Didactic boundary

Do not change learner maturity, permanent didactic memory, KANBAN, glossary, Concept Map, Lecture
Register or Cycle 11 UI semantics.

H reports meanings actually executed and meanings still deferred.
