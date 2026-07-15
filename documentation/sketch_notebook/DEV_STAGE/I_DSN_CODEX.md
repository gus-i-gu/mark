# I_DSN_CODEX - C10-S03A-R3D1 Design Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex design/architecture evidence
Unit: C10-S03A-R3D1 evidence contract and migration lifecycle completion
Branch: `intermid-cycle-recovery`
Authority: `F_DSN_STAGE.md` plus J/D/E
Evidence boundary: local architecture only; provider proof deferred

## Result

```text
PROOF_PIPELINE_INTEGRITY=true
C10-S03A_R3D1_PROVED
R3_LOCAL_SECURITY_PROVED=false
R3D2_AUTHORIZATION_PENDING
R3D3_FLUTTER_PENDING
MCG-02_PROVIDER_PROOF_PENDING
```

## Dependency Direction

Retained architecture:

```text
executed scenario/command
→ closed versioned producer record
→ deterministic record validation
→ fail-closed aggregation
```

Production code does not depend on proof modules. No production authorization, enrollment, JWT, route or HTTP contract was changed.

## Closed Producer Schema

One record has exactly:

```text
schemaVersion, producer, requiredCases, resultsByCase, blockers, passed
```

One case result has exactly:

```text
passed
blocker only when passed=false
```

The parser rejects unknown fields, malformed schema, unknown producers, case-set mismatch, result-key mismatch, stale blockers, unsafe blockers, inconsistent `passed` and inconsistent top-level blockers. Builder-derived blockers are canonical sorted `case:blocker` pairs.

## Real Producer Flow

- JWKS producer executes generated RSA/JWKS scenarios with injected clock/fetch and existing `jose`.
- Route producer executes real Fastify construction/readiness scenarios using typed descriptors and `onReady` inventory comparison.
- Static producer executes fixed repository command definitions with explicit working directories and safe blocker IDs.
- Migration producer starts disposable PostgreSQL 18, creates migrator/runtime roles and isolated databases, applies tracked or copied migrations, queries catalog/ACL state and tears down in `finally`.
- Authorization producer starts disposable PostgreSQL 18 and runs the existing hosted-local harness to emit a truthful partial record.
- Flutter producer runs the focused file-backed HTTP test and maps only observed meanings to true.

## Aggregation Behavior

`r3d1_orchestrator.ts` runs all six producers, parses their `PROOF_PRODUCER` records, validates schema integrity, aggregates all records and accepts R3D1 only when:

- migration/JWKS/route/static producers pass;
- authorization and Flutter producers are valid but false;
- aggregate is false only because blockers end in `not-yet-r3d2` or `not-yet-r3d3`.

## Migration Scenario Runner

The runner proves fresh, upgrade, duplicate and failure-copy lifecycle paths. Failure injection copies migrations to a temporary directory and modifies only copied 006. Canonical migration hashes are captured before copying and after cleanup. The tracked SQL files are not edited.

Catalog/ACL checks separately cover owner, `SECURITY DEFINER`, `STABLE`, fixed search path, qualified ledger reference, no dynamic SQL, `PUBLIC` denial, runtime readiness execute, old probe denial, direct ledger denial, runtime DDL/role denial, migrator authority, hostile shadowing and absent/tampered ledger behavior.

## Resource Ownership

Proof modules own disposable containers, databases, roles and temporary files. Containers are named with the `markei-c10-s03a-r3d1` prefix and are removed in `finally`. Static teardown verifies no R3D1 disposable resources remain.

## Versions Retained

- PostgreSQL migrations 001-006 unchanged.
- Event payload v3 unchanged.
- Cursor `c10b:*` unchanged.
- Recovery snapshot format 1 unchanged.
- Hosted enrollment contract v1 unchanged.
- Drift schema v7 unchanged.
- JWT RS256 retained.
- Dependency and lockfile versions unchanged.

## Deferred Boundaries

R3D2 owns authorization barrier/race completion. R3D3 owns the full Fastify/PostgreSQL Flutter hosted gate and final global aggregation. Provider proof, MCG-03, MCG-04 and Cycle 10 closure were not started.
