# E_DDC_STAGE — C10-S03A-R3D1 Semantic Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: `190e9df78c285179d57a2b728b5cf07ecdd7aadb`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: evidence integrity and migration semantics

## 1. Purpose

R3D1 makes proof claims correspond exactly to observed evidence. It does not complete global local
security and must not upgrade a partial authorization/Flutter record to pass.

## 2. Required distinctions

```text
case-name-present != case-measured
producer-record-created != producer-valid
producer-valid != producer-passed
synthetic-complete-fixture != real-producer-success
body-stall-timeout != repeated-slow-progress-deadline
unavailable-result != owned-resource-closure-observed
security-definer-checked != function-owner-checked
readiness-call-allowed != all-other-runtime-execute-denied
migration-present != lifecycle-proved
R3D1-proved != R3-local-security-proved
local-proof != provider-proof
```

## 3. Closed producer meaning

A producer is passed only when:

- its schema and producer identity are exact;
- its required cases and results exactly match the canonical inventory;
- every case was executed and is true;
- every false case has one safe deterministic blocker;
- the top-level blocker list exactly represents false cases;
- `passed` is consistent with case truth and blockers;
- no unknown field/case/result is present.

Skipped, partial, unavailable, host-unvalidated and not-yet-implemented are false evidence states,
not missing text and not success.

## 4. Real versus synthetic evidence

`allPassed` fixtures may validate aggregator logic only. They cannot appear in a real proof record.
JWKS and route booleans come from executed named scenarios. Static booleans come from the exact
commands their case names represent. Migration booleans come from isolated database scenarios and
catalog/ACL observations.

The R3D1 aggregate is correctly false because authorization and Flutter remain intentionally
partial. It is valid only when all six records are real, structurally valid, and every other producer
passes.

## 5. Migration meanings

- **Fresh**: pristine database receives 001–006 in order.
- **Upgrade**: a usable 001–005 database receives only 006 afterward.
- **Duplicate**: repeating 006 preserves one correct ledger identity and compatible objects.
- **Failure rollback**: injected failure in a disposable copy leaves none of that transaction's
  ledger/function/ACL changes.
- **Owner**: `proowner` resolves to the expected migration identity; security mode is separate.
- **Runtime-ready-only**: runtime may call the narrow readiness capability while selected general
  history, DDL, role and unintended function capabilities remain denied.
- **Shadow resistant**: attacker-controlled temp/public names cannot change the qualified result.
- **Tampered/absent ledger**: readiness cannot return true.

Canonical migration source remains byte-identical.

## 6. Correction of prior wording

The existing Flutter test proves a body-delay deadline outcome, not yet repeated slow progress or
instrumented client closure. The existing migration probe proves security-definer/volatility/search
path but not owner. G/H/I must correct these earlier overstatements.

## 7. Terminal vocabulary

R3D1 success:

```text
PROOF_PIPELINE_INTEGRITY=true
MIGRATION_006_LIFECYCLE_ACL=true
C10-S03A_R3D1_PROVED
R3_LOCAL_SECURITY_PROVED=false
R3D2_AUTHORIZATION_PENDING
R3D3_FLUTTER_PENDING
MCG-02_PROVIDER_PROOF_PENDING
```

R3D1 incomplete:

```text
C10-S03A_R3D1_PARTIAL
R3_LOCAL_SECURITY_PROVED=false
```

Never claim hosted readiness, provider acceptance, MCG-02 completion, production readiness or Cycle
10 closure.

## 8. Privacy and learning boundary

Producer records/logs contain no tokens, claims, JWK bodies, credentials, URLs, passwords, source
payloads or private paths. No UI, KANBAN, glossary, learner maturity or permanent memory changes are
authorized. G/H/I remain observational evidence.
