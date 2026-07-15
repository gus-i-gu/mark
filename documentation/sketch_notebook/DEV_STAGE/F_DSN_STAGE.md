# F_DSN_STAGE — C10-S03A-R3D1 Design Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: `190e9df78c285179d57a2b728b5cf07ecdd7aadb`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: proof pipeline integrity and migration lifecycle architecture

## 1. Selected architecture

R3D1 completes this bounded topology:

```text
executed scenario/command
→ closed versioned producer record
→ deterministic record validation
→ fail-closed aggregation
```

Migration evidence adds an isolated scenario runner. No production runtime architecture changes.

## 2. Dependency direction

```text
production components
    ↑ exercised by
test/lab scenarios and command runners
    ↑ emit
closed producer records
    ↑ consumed by
aggregator/CLI
```

Production code does not depend on proof modules. Producer inventory may be imported by scenario
code and aggregator. No new dependency, migration or Drift schema is selected.

## 3. Producer schema architecture

Retain schema version 1 but make runtime validation closed and structural.

Equivalent invariant:

```text
passed = exactCasesPresent
         AND everyCasePassed
         AND blockers.isEmpty
```

For a false producer, `blockers` is the canonical sorted unique projection of false-case blockers.
The builder derives this field; callers do not supply an independent truth. Parser validation
recomputes and compares it.

Use bounded safe identifiers. Reject extra object keys recursively. Canonical serialization sorts
producer/case/blocker fields deterministically. File/JSON errors become safe error categories at the
CLI boundary.

Aggregator unit tests may construct synthetic records. Runtime producer paths must use executed
scenario results.

## 4. Real JWKS and route producers

Refactor existing named scenarios into reusable test-local functions only where needed:

```text
scenario assertion
→ boolean/captured safe failure
→ makeProducerResult
```

Ordinary unit tests and producer execution must call the same scenario function so they cannot
drift. Do not parse Node test-runner prose or mark a case true because a test file exists.

JWKS uses generated local RSA keys, injected clock/fetch and existing `jose`. Route inventory uses
real Fastify construction/readiness. Scenario helpers remain test/proof infrastructure.

## 5. Static command producer

Implement a bounded command runner with:

- fixed repository-owned command definitions;
- explicit working directory per command;
- bounded execution and captured exit status;
- safe blocker ID per failed command;
- no shell interpolation from external input;
- no secret environment/output in producer records;
- cleanup/resource verification after commands.

Command exit is evidence because the static case is defined as that exact command passing. It does
not establish provider/runtime claims beyond the command.

## 6. Migration scenario runner

Use one local PostgreSQL 18 disposable environment with independent databases/scenarios, or separate
containers if simpler. The runner owns:

```text
provision loopback lab
→ create migration/runtime identities
→ execute isolated scenario
→ query ledger/catalog/ACL/behavior
→ emit case result
→ drop scenario resources
→ tear down lab
```

Passwords are generated in memory and never logged. Runtime/migrator connections remain distinct.

Scenario groups:

- fresh and upgrade migration paths;
- duplicate application;
- copied-migration injected rollback;
- canonical hash preservation;
- ledger/function owner/mode/config/body catalog inspection;
- exhaustive selected runtime/migrator ACL behavior;
- temp/public shadowing;
- absent/tampered ledger readiness.

Failure-copy architecture:

```text
hash tracked migrations
→ copy to temporary directory
→ inject failure into copied 006 only
→ apply copied set to disposable database
→ prove transaction rollback
→ remove copy
→ re-hash tracked migrations
```

Do not edit tracked SQL or infer owner from security-definer metadata. Query `proowner` explicitly.
Enumerate relevant function privileges to support `ready-only` wording.

## 7. Partial producer integration

Authorization continues emitting its observed four cases plus false deferred cases. Flutter maps its
three current tests only to meanings they actually prove. Both use the closed schema and remain
false.

Use blocker category `not-yet-r3d2` for authorization cases and `not-yet-r3d3` for Flutter cases.
Do not rename unmeasured cases to match existing tests.

## 8. Aggregation architecture

One R3D1 orchestrator collects six actual record files/objects in a private temporary directory,
validates them, runs aggregation and deletes them in `finally`.

R3D1 acceptance requires:

- migration, JWKS, route and static producers true;
- authorization and Flutter producers false only for their declared future-unit cases;
- no missing/malformed/schema/consistency blockers;
- global aggregate false;
- explicit pipeline-integrity true.

The orchestrator must never transform expected partial producer results into global pass.

## 9. Versions and boundaries

Retain:

```text
migrations 001–006
event v3
cursor c10b:*
recovery format 1
hosted enrollment contract v1
Drift v7
JWT RS256
existing dependency/lockfile set
```

Expected changes are proof modules/tests/scripts, migration lab helpers and G/H/I. Production source
changes require a directly failing R3D1 integration test and must remain narrow.

## 10. Security, rollback and stop

- loopback/synthetic/disposable resources only;
- no provider or private helper access;
- no secrets/fact payloads in records;
- all containers/databases/roles/files/processes close in `finally`;
- R3D1 rollback is one bounded commit; migrations do not change.

Stop if completion requires provider behavior, dependencies, migration 007, editing 001–006, Drift
v8, authorization barrier work, full Flutter hosted work or a production architecture change.

I must report the final schema, migration runner, real producer flow, aggregate blockers, resource
ownership, exact versions and any narrow deviation.
