# E_DDC_STAGE — C10-S03A-R3C Semantic Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: `51e1db09e9c00bf2650d1cf791b571cfa4f6a0c6`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: decisive local evidence semantics only

## 1. Purpose

R3C proves already selected contracts. It does not introduce new product vocabulary or relax a
meaning to obtain a passing aggregate.

## 2. Evidence distinctions

Preserve:

```text
source-corrected != decisive-proof-complete
unit-test-passed != system-producer-passed
build-passed != runtime-passed
deadline-wait-ended != request-resource-cancelled
in-memory-database != file-backed-reopen
fixture-success != real-adapter-success
denial-response != denied-no-state-advance
migration-present != migration-lifecycle-proved
producer-exited-zero != producer-schema-and-cases-passed
local-proof-passed != provider-proof-passed
```

## 3. Authorization meanings

An operation is authorized only by identity, membership and actor Device state observed inside the
accepted transaction boundary. A previously verified JWT does not freeze later database authority.

Required meanings:

```text
membership disabled/removed before fence → operation denied
identity disabled before mutation → operation denied
actor Device revoked before authorization → operation denied
authorization or SQL failure → transaction rolled back
```

`Denied without state advance` means facts/events, cursors/acks, recovery sessions, Device rows,
enrollment rows and security-event count are identical before and after the attempt.

Concurrent target revoke means exactly one active→revoked transition and one event. An independently
active authorized repeat may be `duplicate-equivalent`. A self-revoked actor is denied later.

## 4. Migration evidence meanings

Migration-006 validation requires more than the function returning true once. It includes fresh and
upgrade paths, duplicate handling, atomic failure rollback, immutable canonical hashes, exact owner
and function attributes, least-privilege ACLs, hostile shadowing resistance and tamper/absence
failure behavior.

`Runtime ready` means the exact no-argument capability reports the selected ledger condition. It
does not mean runtime may read migration history, call the old general probe, perform DDL or manage
roles.

## 5. Flutter system meanings

The decisive Flutter producer must cross all real local boundaries:

```text
coordinator → real HTTP adapter → loopback Fastify → durable file-backed Drift → close/reopen
```

It must contain real authoritative facts and a pending outbox row. Failure outcomes preserve them.

An absolute deadline spans connection, headers and the entire body. Slow progress cannot renew it.
Cancellation means request-owned resources are closed, not merely that the caller stopped awaiting.
A borrowed client remains caller-owned and usable.

Enrollment meanings remain closed:

```text
device-enrolled → applied
duplicate-equivalent → duplicate-equivalent
conflict → conflict
known unavailable → unavailable
commit ambiguity/response loss → unknown-outcome and query-required
```

Replay uses the same request identity. None of these failures implies facts/outbox reset.

## 6. Producer semantics

Each producer record has:

```text
producer name
schema version
exact case identifiers
case boolean results
safe blocker identifiers
terminal producer boolean
```

Missing, duplicate, unknown, malformed, skipped, partial, unavailable or false input makes the
aggregate false. Exit code alone is not evidence. A synthetic successful aggregator fixture proves
aggregator logic only, not system completion.

## 7. Required named evidence

Reports/tests must name at least:

- membership-disable and membership-remove barriers for every operation class;
- external-identity and actor-Device barriers;
- owner/member/cross-Account target cases;
- concurrent revoke one-transition/one-event;
- denied-no-state-advance snapshots;
- migration fresh, upgrade, duplicate, rollback, ACL, shadow and tamper cases;
- real HTTP success, duplicate, conflict, unavailable and unknown outcome;
- slow-trickle absolute timeout and owned-resource closure;
- borrowed-client preservation and no late mutation;
- file-backed close/reopen fact/outbox/request preservation;
- aggregator missing/unknown/duplicate/skipped/partial/false rejection;
- aggregator over real producer outputs.

## 8. Completion wording

Only complete real producer results permit:

```text
R3_LOCAL_SECURITY_PROVED=true
C10-S03A_R3C_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

Otherwise:

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3C_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Never claim `HOSTED_AUTH_READY`, Auth0/Neon/Render acceptance, MCG-02 completion, production
readiness or Cycle 10 closure.

## 9. Privacy, learning and UI boundary

- tokens remain ephemeral and absent from durable state/logs;
- producer output excludes payloads, claims, credentials, URLs and secrets;
- local registration remains available during hosted failure;
- no Account/Device UI or Cycle 11 work is authorized;
- no KANBAN, glossary, Lecture Register, learner maturity or permanent-memory change is authorized;
- G/H/I remain observational evidence.

## 10. Stop rule

Do not weaken definitions when a producer fails. Report the precise evidence boundary and stop if
proof requires provider behavior, migration/schema/dependency changes or a new architecture.
