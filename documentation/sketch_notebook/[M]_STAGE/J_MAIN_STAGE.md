# J_MAIN_STAGE — C10-S03A-R3C Post-Codex Reconciliation

> Sequence: FLX-ORD-01 Main reconciliation
> Branch: `intermid-cycle-recovery`
> Controlling D/E/F: `ecfea32c3d72d9a8de74893df7ad29929dcc5ee1`
> Codex implementation: `00b3c090d25bd2f266ec65d358090a876efcd5d9`
> Evidence: R3C G/H/I, Git delta and direct proof-source/test inspection
> Date: 2026-07-15
> Status: fail-closed proof scaffold accepted; decisive producers incomplete

## 1. Methodology retained

Main recovered through:

```text
INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
```

Retained:

- G/H/I are observational evidence, not promotion.
- Git owns exact ancestry and changed paths.
- A producer existing is not a producer passing.
- A named case may be accepted only when its implementation measures that exact meaning.
- Synthetic aggregator fixtures prove aggregator logic, not system behavior.
- Partial, contradicted, implemented, locally validated and provider-pending remain distinct.
- New D/E/F authority is required for the next bounded unit.

Round identity:

```text
R3C D/E/F authority           ecfea32
R3C implementation/evidence   00b3c09
R3C complete local proof       absent
```

## 2. Ancestry and exact delta

Git proves:

```text
ecfea32 → 00b3c09
```

Exactly nine paths changed:

```text
clients/markei_flutter/test/infrastructure/http_device_enrollment_transport_file_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
services/markei_sync_api/src/hosted_local_harness.ts
services/markei_sync_api/src/proof/aggregate.ts
services/markei_sync_api/src/proof/migration_006_probe.ts
services/markei_sync_api/src/proof/producer.ts
services/markei_sync_api/test/proof_aggregate.test.ts
```

No production protocol, dependency/lockfile, migration, Drift schema, methodology, permanent
memory, A/B/C, J or D/E/F file changed. G left Final SHA pending; Git establishes `00b3c09`.

## 3. Codex result accepted

G/H/I truthfully report:

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3C_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

The hosted-local producer remains:

```text
AUTHORIZATION_RACE_MATRIX=partial
ROUTE_AUTHORIZATION_INVENTORY=true
LEAST_PRIVILEGE_HTTP=true
R3_LOCAL_SECURITY_PROVED=false
```

The migration probe exits nonzero and reports partial. No complete real aggregate was emitted. Main
accepts this classification.

## 4. Progress accepted

### 4.1 Proof inventory and aggregator scaffold

`producer.ts` now owns six producer names and explicit case inventories. `aggregate.ts` rejects
missing producers, duplicate producers, malformed records, mismatched case sets and false cases.
Unit tests prove a synthetic complete set and several fail-closed inputs.

Accepted state: implemented scaffold and focused tests. It is not yet a closed evidence contract or
a real-producer orchestrator.

### 4.2 Authorization producer scaffold

The hosted-local harness emits a structured partial authorization producer. Four existing cases are
marked passed and all unobserved cases become `missing-case-result`, keeping the producer false.

Accepted state: truthful partial encoding. No deterministic barrier matrix or denied-no-state-
advance observer was added.

### 4.3 Migration-006 probe subset

The new probe checks the existing disposable database for ledger identity/checksum, function shape,
security mode/volatility/search path, qualified body, selected ACL denials and runtime DDL/role
denial. It does not edit migrations and correctly exits partial.

Accepted state: useful subset only.

### 4.4 Real HTTP/file-backed Flutter subset

The new Flutter test uses `LocalDatabase.file`, real local purchase/outbox repositories, real hosted
identity persistence, the coordinator and `HttpDeviceEnrollmentTransport` against loopback
`HttpServer`. Three focused tests pass for success/duplicate persistence, selected failure
persistence and a body-delay deadline outcome.

Accepted state: real package:http plus file-backed Drift subset. It is not the required full
Fastify/PostgreSQL-backed producer and emits no producer record.

## 5. Direct inspection corrections

### 5.1 Aggregator contract is not closed

`ProofProducerResult` declares `blockers`, but `parseRecord` neither validates it nor aggregation
uses it. A record can contain stale blockers while otherwise passing. `record.passed` is only checked
as a boolean; consistency with case truth and blocker emptiness is not enforced. CLI JSON parse
failure is not translated into a safe structured blocker. Unknown/skipped/partial/unavailable
representations lack complete named tests.

The aggregate currently remains false because producers are missing, but the evidence contract is
not yet sufficient for a future success claim.

### 5.2 Migration case labels overclaim checks

The case `owner-security-definer-stable-search-path` queries security-definer, volatility and config,
but never queries `proowner`. It therefore does not prove owner. `runtime-execute-ready-only` proves
the readiness call works, while other selected denials are separate; it does not enumerate all
runtime function execute privileges. These booleans must be split or the queries expanded before
the producer can pass.

### 5.3 Flutter test names exceed observed evidence

The slow-body fixture writes one partial body, stalls, then finishes. It proves a total-deadline
outcome during a body stall, not repeated slow progress. It does not instrument/assert owned-client
closure. The suite also lacks stalled headers, redirect/oversize, response-loss query/replay,
borrowed-client preservation, late-mutation fencing, local registration during API outage and a
machine-readable producer. It uses raw Dart `HttpServer`, not Fastify/PostgreSQL.

H's phrase “absolute deadline closes an owned request” is therefore stronger than the test.

### 5.4 Remaining producers are not wired

JWKS, route-inventory and static-regression case inventories exist, but real machine-readable
producer records are not generated. No orchestrator collects actual records and invokes the
aggregator.

## 6. Reported validation

Accepted within scope:

- TypeScript format/lint/typecheck/build passed;
- 30 TypeScript tests passed;
- production dependency audit reported zero vulnerabilities;
- focused Flutter file-backed test passed three tests;
- complete Flutter suite passed 61 tests with two existing lab-gated skips;
- Flutter analysis, Android debug and Windows release builds passed;
- five protected Python regressions passed;
- `git diff --check` passed;
- no provider/private helper access occurred.

Builds remain build evidence. Two skipped lab gates cannot satisfy local proof.

## 7. PRC-01 reconciliation

| Claim | State |
| --- | --- |
| versioned proof/case inventory | implemented |
| fail-closed aggregator scaffold | implemented; focused subset validated |
| closed producer/aggregator integrity | contradicted/incomplete |
| authorization producer | truthful partial scaffold |
| deterministic authorization matrix | absent |
| migration-006 metadata/ACL subset | locally validated subset |
| migration owner/lifecycle proof | incomplete; owner case overclaimed |
| real HTTP + file-backed Drift subset | locally validated subset |
| full Fastify/PostgreSQL Flutter producer | absent |
| real JWKS/route/static producer records | absent |
| complete real aggregation | absent |
| provider proof | not performed/unauthorized |

## 8. Main decision and sequence split

Main accepts `00b3c09` as fail-closed proof infrastructure progress and rejects R3C completion.
Repeating all four broad producers in one unit has twice produced partial evidence. The remaining
work is therefore split:

```text
R3D1 — Evidence Contract and Migration Lifecycle Completion
R3D2 — Authorization Barrier Matrix Completion
R3D3 — Full Flutter Hosted Gate and Real Aggregation
```

Only R3D1 is activated by the next D/E/F. It must:

1. close producer/aggregator schema integrity;
2. generate real JWKS, route and static producer records from named evidence;
3. complete the migration-006 lifecycle/ACL producer;
4. run the real aggregate and prove it remains false only because authorization and Flutter
   producers are intentionally incomplete.

R3D1 does not authorize completing authorization or Flutter cases, which remain R3D2/R3D3.

## 9. Boundaries

No migration edit/007, dependency/lockfile change, Drift schema change, provider access, UI work,
permanent promotion or unrelated refactor is authorized. Private files remain unread:

```text
.vscode/settings.json
documentation/NEON_DOC.md
documentation/NEON_SESSION.ps1
```

## 10. Terminal status

```text
C10-S03A_R3C_PARTIAL_ACCEPTED
C10-S03A_R3D1_RESTAGING_REQUIRED
PROOF_PIPELINE_INTEGRITY=false
MIGRATION_006_LIFECYCLE_ACL=false
R3_LOCAL_SECURITY_PROVED=false
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Confidence is high for Git inventory, producer incompleteness and the direct aggregator/migration/
Flutter findings.
