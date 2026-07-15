# 10_OPERATIONAL_STATE.md

> Version: Cycle 10 recovered Operational checkpoint
> Branch: `intermid-cycle-recovery`
> Evidence head: `75fbba66d19df722820b8667ac7886c09b64fb2b`
> Status: Active Operational checkpoint

# Current State

## Accepted local implementation evidence

C10-S01B proved one disposable local synchronization path across isolated Drift databases, Flutter HTTP transport, loopback Fastify and PostgreSQL. The accepted boundary includes durable Submission retry identity, duplicate equivalence, ordered cursor download, atomic remote Purchase application, acknowledgement and reopen comparison.

C10-S02 proved the local retention/recovery mechanism: forward-only migration 003, Device retention classification, compatible snapshot build and verification, coverage-gated cleanup, typed cursor expiry, resumable fresh-target rebootstrap, catch-up, acknowledgement and reopen convergence. Cleanup remains disabled in normal composition and no provider behavior follows from the local harness.

C10-S03A added migration 004, additive Drift v7 hosted-identity state, a production-shaped compiled server entrypoint without fixture-auth fallback, JWT/JWKS-shaped verification, database membership/enrollment structures and basic synthetic enrollment/sync/revocation evidence. These components exist, but the unit is not hosted-ready.

## Active contradiction and stop state

```text
C10-S03A_CONTRADICTED_STOP
MCG-02_HOSTED_PROOF_NOT_PERFORMED
```

Hosted authorization is resolved and committed before the protected operation transaction instead of rechecking membership, enrollment and Device authority inside that same mutation transaction. Membership-removal and revocation races therefore remain open. JWT/JWKS failure coverage, least-privilege decisive HTTP topology, two-Account isolation, concurrency/restart cases and Flutter hosted-auth composition are also incomplete.

No Auth0, Render or Neon hosted synchronization proof is accepted. Cycle 10 remains open.

## Sanitized manual provider evidence

MCG-01 is accepted only as sanitized development-environment evidence: an isolated Neon development branch and disposable database were used with PostgreSQL 18.4 in `us-west-2`; separate migration and runtime identities were observed; TLS, transactional rollback, explicit runtime CRUD, runtime DDL denial and probe cleanup passed. The development branch expiry requires reconfirmation.

This does not prove migration 003/004 application, pooled RLS, hosted authentication, backup/PITR, provider availability or production acceptance.

MCG-02 reached provider-dashboard preparation only: provisional Auth0 Native Applications and API/audience preparation occurred for Android and Windows, and Render reached repository/service setup. No approved hosted secret set, Render deployment, Neon migration, real login, token acceptance, Device enrollment or hosted synchronization proof was completed.

## Provider and secret boundary

Fixture authentication remains confined to tests/local laboratory composition. Distributed clients receive no database credentials or native client secret. Migration authority uses a direct migrator connection; web runtime uses a separately scoped pooled-intended runtime identity. Provider mutations are human-controlled and become project evidence only after sanitized capture, PRC-01 classification and Main reconciliation.

## Next

Execute a separately authorized C10-S03A-R1 corrective round. Only after corrected local evidence and new Main reconciliation may MCG-02 be reactivated. MCG-03 and MCG-04 are undefined and inactive.

Recovery: read `04_TODO.md`, the latest Cycle 10 entry in `11_OPERATIONAL_RECORD.md`, the provider/manual-gate rules in `12_OPERATIONAL_MODEL.md`, and `J_MAIN_STAGE.md` at `75fbba6`.
