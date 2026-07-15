# G_OPS_CODEX - C10-S03A-R3D1 Operational Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex materialization evidence
Unit: C10-S03A-R3D1 evidence contract and migration lifecycle completion
Branch: `intermid-cycle-recovery`
Baseline SHA: `b254b722014dd85871c03926789e6064d3635c88`
Accepted implementation baseline: `00b3c090d25bd2f266ec65d358090a876efcd5d9`
Final SHA: pending materialization commit
Authority: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Evidence boundary: local-only repository, loopback HTTP, disposable PostgreSQL 18 containers, synthetic identities only

## Result

```text
PROOF_PIPELINE_INTEGRITY=true
MIGRATION_006_LIFECYCLE_ACL=true
JWKS_STATE_MACHINE_PRODUCER=true
ROUTE_INVENTORY_PRODUCER=true
STATIC_REGRESSION_PRODUCER=true
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3D1_PROVED
R3D2_AUTHORIZATION_PENDING
R3D3_FLUTTER_PENDING
MCG-02_PROVIDER_PROOF_PENDING
```

R3 local security remains false by design. The aggregate blockers are only the intentionally deferred R3D2 authorization and R3D3 Flutter cases.

## Changed Paths

- `services/markei_sync_api/src/hosted_local_harness.ts`
- `services/markei_sync_api/src/proof/aggregate.ts`
- `services/markei_sync_api/src/proof/authorization_producer.ts`
- `services/markei_sync_api/src/proof/flutter_producer.ts`
- `services/markei_sync_api/src/proof/jwks_producer.ts`
- `services/markei_sync_api/src/proof/migration_006_probe.ts`
- `services/markei_sync_api/src/proof/producer.ts`
- `services/markei_sync_api/src/proof/r3d1_orchestrator.ts`
- `services/markei_sync_api/src/proof/route_inventory_producer.ts`
- `services/markei_sync_api/src/proof/scenario_result.ts`
- `services/markei_sync_api/src/proof/static_regression_producer.ts`
- `services/markei_sync_api/test/proof_aggregate.test.ts`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No dependency or lockfile version changed. Migrations 001-006, Drift schema v7, J/D/E/F, A/B/C, methodology and permanent memory were not edited.

## Producer Results

`authorization-race`: structurally valid partial producer. Passed observed cases:

- `owner-target-revoke`
- `foreign-target-denial`
- `cross-account-target-denial`
- `conflicting-enrollment-request-hash`

All remaining authorization cases are false with `not-yet-r3d2`.

`migration-006-lifecycle-acl`: passed all 25 cases, including fresh 001-006, upgrade 001-005 then 006, duplicate 006 ledger behavior, copied failure rollback, canonical migration hash preservation, exact ledger identity/checksum, function owner, security definer, stable volatility, fixed search path, qualified ledger reference, no dynamic SQL, public/runtime ACL probes, runtime DDL/role denial, hostile shadowing resistance, absent ledger not ready and tampered ledger not ready.

`jwks-state-machine`: passed all 10 cases using generated local RSA keys, injected clock and injected local fetch behavior.

`route-inventory`: passed all 6 Fastify readiness scenarios: valid inventory, late direct route rejection, encapsulated plugin route rejection, missing descriptor rejection, duplicate route rejection and wrong operation/classification rejection.

`flutter-http-file-backed`: structurally valid partial producer. Current observed file-backed HTTP cases pass; unmeasured full hosted-gate cases remain false with `not-yet-r3d3`.

`static-regression`: passed all 15 command cases, including server checks, Flutter checks/builds, Python regressions, diff check, changed-path secret scan and disposable-resource teardown.

## Aggregate Blockers

Only deferred blockers remain:

- R3D2: membership/external-identity/actor-device authorization barrier cases, owner/member status gaps, concurrent/replay/restart/serialization/no-state-advance gaps.
- R3D3: full Flutter hosted gate cases for redirect/oversize/response-loss/query replay, stalled headers, slow trickle, owned-client closure, borrowed-client preservation, late response fencing and local registration during API outage.

## Validation Results

- `git fetch origin`: passed.
- `git pull --ff-only`: already up to date.
- Required controlling commit ancestor check for `b254b722014dd85871c03926789e6064d3635c88`: passed.
- `git status --short --branch` before editing: clean on `intermid-cycle-recovery`.
- `npm run typecheck`: passed.
- `npm test`: passed 34 tests.
- `npm exec tsx -- src/proof/jwks_producer.ts`: passed; producer true.
- `npm exec tsx -- src/proof/route_inventory_producer.ts`: passed; producer true.
- `npm exec tsx -- src/proof/migration_006_probe.ts`: passed; producer true.
- `npm exec tsx -- src/proof/authorization_producer.ts`: completed expected partial; producer false only for R3D2 blockers.
- `npm exec tsx -- src/proof/flutter_producer.ts`: completed expected partial; producer false only for R3D3 blockers.
- `npm exec tsx -- src/proof/static_regression_producer.ts`: passed all static cases; producer true.
- `npm exec tsx -- src/proof/r3d1_orchestrator.ts`: passed with `PROOF_PIPELINE_INTEGRITY=true`.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run build`: passed.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `git diff --check`: passed with Git line-ending warnings only.

The static producer also executed: `dart format --set-exit-if-changed lib test`, `flutter analyze`, `flutter test`, `flutter build apk --debug`, `flutter build windows --release`, `python -m unittest discover -s tests`, changed-path secret scan and R3D1 disposable-resource teardown.

## Boundary And Teardown

Disposable PostgreSQL 18 containers were used for migration and authorization producers and removed in `finally`. Final container check for `markei-c10-s03a-r3d1*` returned no resources.

No Auth0, Neon, Render or public hosted service was contacted. No provider credential, private helper file, `.vscode/settings.json`, `documentation/NEON_DOC.md` or `documentation/NEON_SESSION.ps1` was read or modified. Provider proof, R3D2, R3D3, MCG-03, MCG-04, permanent-memory promotion and Cycle 10 closure were not started.
