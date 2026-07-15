# J_MAIN_STAGE — C10-S03A-R2 Local Hosted-Authorization Correction

> Sequence: FLX-INV-02 Main reconciliation
> Branch: `intermid-cycle-recovery`
> Baseline: `34bc032df26d4b6d727d3ba6f2e08bbb0b11e13f`
> Evidence: A/B/C R2 investigations plus R1 source and G/H/I
> Date: 2026-07-15
> Status: accepted Main synthesis and bounded Codex-preparation authority

## 1. Methodology retained

Main retained the complete route:

```text
INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
```

- A/B/C are provisional domain investigations.
- J reconciles cross-domain conflicts and selects the bounded direction.
- D/E/F jointly become Codex materialization authority.
- G/H/I will be observational evidence, not self-promotion.
- Implemented, validated, contradicted, provider-pending and host-unvalidated remain distinct.
- Source and local tests cannot prove Auth0, Neon, Render or production acceptance.

## 2. Reconciled R1 result

Main accepts that R1 added useful transaction-scoped authorization for eight sync/recovery routes,
bounded JWT/JWKS retrieval, separate lab database URLs and provider-neutral Flutter enrollment
scaffolding.

Main rejects the R1 decisive proof because source inspection establishes:

1. Device status/revocation does not prove an active actor Device.
2. A member can present a foreign DeviceId as both actor header and target.
3. Membership/identity state is not fenced with protected mutations.
4. The public precommitted `verify` path can reintroduce authorization TOCTOU.
5. Route policy inventory is detached from registration and omits hosted identity/Device routes.
6. Enrollment conflict is HTTP 200 on the server but only HTTP 409 in Flutter.
7. The coordinator-obtained token is not the credential used by the transport contract.
8. JWKS stale keys have no final ceiling; issuer-origin and unknown-key pressure remain open.
9. Harness proof flags are emitted without their claimed probes.
10. Migration 003 requires a recovery-worker role the accepted Neon migrator cannot create.
11. `/health/ready` reads `migration_ledger` using a runtime role without the corresponding grant.

Therefore:

```text
C10-S03A_R1_CONTRADICTED_STOP
C10-S03A_R2_AUTHORIZED_LOCAL_ONLY
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

## 3. Main decisions for R2

### 3.1 Actor and target policy

Every Device status/revocation request requires:

```text
valid principal
→ active external identity
→ exactly one active membership
→ active actor enrollment owned by that identity
→ active actor Device
→ target policy
```

- Owner: may inspect or revoke any Device in the same Account.
- Member: may inspect or revoke only its own actor Device.
- Actor Device comes only from validated `x-markei-device-id`; the target path never authenticates
  the actor.
- Actor and target rows are locked in deterministic UUID order; identical actor/target locks once.
- Missing, foreign, revoked or mismatched rows return bounded non-enumerating failure.
- Repeated revocation is idempotent and emits at most one `device-revoked` security event.

### 3.2 Authorization concurrency fence

Add forward-only migration 005. Do not edit migrations 001–004.

Migration 005 shall create a narrowly scoped security-definer function that resolves and locks the
active external identity and its active membership rows for the current transaction. Requirements:

- owned by the migration identity;
- fixed safe `search_path` and fully qualified objects;
- no dynamic SQL;
- explicit issuer/subject predicates;
- returns only identity, Account and role identifiers needed by authorization;
- `PUBLIC` execute revoked; execute granted only to `markei_runtime`;
- no membership mutation authority granted to runtime;
- all future membership/identity state writers must acquire the same fence before changing state.

The R2 lab must include a controlled membership/identity writer that acquires this fence and proves
commit ordering against protected operations. Broad `UPDATE` on membership/identity tables is
forbidden.

### 3.3 Readiness capability

Migration 005 shall also expose a narrow readiness function that answers whether the required
migration identifier exists. Runtime may execute it but may not directly read or mutate
`migration_ledger`. `/health/ready` uses this function and reveals only `ready` or `not-ready`.

### 3.4 Hosted authorization composition

Hosted composition must require a transaction-scoped authorizer structurally. Fixture/non-hosted
tests may retain `AuthVerifier.verify`, but hosted routes must not use capability detection or fall
back to a precommitted `AuthContext`. Remove or contain the public hosted `verify` authority.

### 3.5 Route registry

One typed route descriptor registry must participate in actual Fastify registration and name the
authorization class for every non-health route:

- principal-only;
- active-membership;
- active-actor-Device management;
- transaction-scoped protected operation.

A construction/test inventory derived from actual Fastify routes must fail on unregistered,
duplicated, mismatched or weakly classified routes. A constant compared with another constant is
insufficient.

### 3.6 HTTP failure contract

Use 2xx only for successful enrollment/status results. A conflicting enrollment request is a typed
HTTP 409 failure. Missing enrollment result remains a bounded non-success response. Flutter decodes
the same closed failure schema and preserves local state on all non-success/unknown outcomes.

### 3.7 Flutter token coherence

The enrollment coordinator owns one ephemeral access token per attempt and passes it explicitly to
`enroll` or `query`. The transport must not independently fetch another token. Token bytes are never
persisted, logged, placed in exception text or included in equality/debug output.

The real HTTP transport must implement bounded timeout, bounded response bytes, closed JSON,
explicit lifecycle ownership and generic failures. Its proof uses loopback Fastify, a file-backed
Drift database, close/reopen and a real pending outbox row that remains unchanged on failure.

### 3.8 JWT/JWKS policy

- Production JWKS URI must be HTTPS and same-origin with the normalized issuer unless a later Main
  decision explicitly authorizes an allowlist.
- Cache has explicit fresh and stale-if-error ceilings under injected Clock.
- Expired stale ceiling always rejects, even if old keys remain in memory.
- Unknown `kid` refresh is coalesced and negatively cooled down, including successful unchanged
  refreshes.
- Any duplicate `kid`, identical or conflicting, is rejected.
- Genuine rotation must accept the new valid key after bounded refresh.
- Timeout, abort, outage/recovery, oversized subject/JWKS and repeated unknown-key pressure require
  named tests.
- Cryptography remains delegated to `jose`.

### 3.9 Migration 003 provider boundary

Codex must not modify migration 003 and must not contact Neon. Local disposable setup may create its
own lab roles.

Before later Neon application, a human owner must create the exact `markei_recovery_worker` role as
`NOLOGIN`, non-elevated and without inherited provider administration. Sanitized evidence must show
its attributes. Only then may the NOCREATEROLE migrator apply immutable migrations. This manual
step is not part of R2 success.

### 3.10 Diagnostics

A proof flag may be emitted only by the executable gate that performed the named assertions. The
TypeScript harness cannot claim Flutter execution or the JWT failure floor unless it runs them.
Skipped or host-blocked gates report `false`, `skipped` or `host-unvalidated`, never `true`.

## 4. Required R2 evidence

The local unit must prove:

1. owner/member status and revocation policy with active actor binding;
2. cross-Account, foreign Device, revoked actor and forged-header denial;
3. membership and identity disable barriers against each protected route class;
4. actor/target revocation races and idempotent security-event count;
5. equivalent/conflicting concurrent enrollment, response loss and restart replay;
6. actual route inventory has no unclassified non-health route;
7. hosted composition cannot select precommitted authorization;
8. JWT/JWKS rotation, bounded outage, stale expiry, timeout and refresh-pressure cases;
9. distinct migrator/runtime identities and runtime DDL/role/ledger/worker denials;
10. readiness succeeds through only the narrow capability;
11. real Flutter HTTP enrollment uses the coordinator token and aligned failure schema;
12. file-backed Drift close/reopen preserves enrollment progress, facts and outbox;
13. denied requests do not advance events, cursors, acknowledgements, recovery sessions or
    security events;
14. all disposable resources are torn down and no secrets enter output or Git.

## 5. Implementation boundary

R2 may change only files needed for:

- migration 005 and its migration tests;
- hosted authorization/JWT/route composition;
- local hosted harness and tests;
- Flutter hosted enrollment ports/coordinator/transport/repository tests;
- G/H/I reports.

R2 must not:

- contact or mutate Auth0, Neon, Render or GitHub provider settings;
- add Auth0 Flutter SDK/native callbacks;
- deploy the API;
- implement Account signup, invitations or production membership administration;
- implement Device-management UI;
- edit migrations 001–004;
- edit permanent domain memory, methodology, A/B/C, J or unrelated code;
- begin MCG-03/04 or claim Cycle 10 closure.

## 6. Reports and terminal condition

Codex replaces only G/H/I after implementation. Reports must contain final SHA, complete changed
paths, migration 005 checksum, named commands/results, barrier outcomes, role/privilege evidence,
Flutter HTTP/file-reopen evidence, diagnostic ownership, exclusions and teardown.

Success requires:

```text
C10-S03A_R2_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

Otherwise report:

```text
C10-S03A_R2_PARTIAL
```

with the exact blocker. Main reconciliation remains required before any provider action.
