# G_OPS_CODEX - C10-MCG02-R04 Partial Operational Evidence

Authority marker: C10-MCG02-R04_20260717T130804Z
Controlling J SHA: fd73da6fddf3cc308655c41e0640b045d710d983
Controlling D/E/F commit SHA: cb177621db82cde6be6d658c58daef590e5b9548
Baseline remote SHA: cb177621db82cde6be6d658c58daef590e5b9548
Actual implementation start UTC/local: 2026-07-17T13:19:36.6430880Z / 2026-07-17T10:19:38.0330606-03:00
Actual implementation end UTC/local: 2026-07-17T13:28:17.2098489Z / 2026-07-17T10:28:21.5013124-03:00
Final commit SHA: pending before commit
Evidence environment: Windows PowerShell, Node server workspace, Docker Desktop Linux engine unavailable
Result classification: C10-MCG02-R04_PARTIAL

## Source Stage Files

- documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md
- documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
- documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
- documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md

## Changed Paths

Production/test/proof paths changed but not committed:

- services/markei_sync_api/src/hosted_local_harness.ts
- services/markei_sync_api/src/proof/authorization_producer.ts
- services/markei_sync_api/src/proof/flutter_producer.ts
- services/markei_sync_api/src/proof/jwks_producer.ts
- services/markei_sync_api/src/proof/r3d1_orchestrator.ts
- services/markei_sync_api/src/proof/static_regression_producer.ts
- services/markei_sync_api/src/proof/static_regression_support.ts
- services/markei_sync_api/test/hosted_auth.test.ts
- services/markei_sync_api/test/proof_aggregate.test.ts
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

No A/B/C, J/D/E/F, methodology, permanent memory, migrations, dependencies, lockfiles, UI, provider, or private Neon helper files were intentionally read or modified.

## Completed Corrections

- Static teardown predicate now requires exit code 0 and empty trimmed stdout.
- Added focused regression: exit zero with non-empty disposable inventory fails teardown.
- JWKS irrelevant metadata case now installs an unknown-kid cooldown, applies metadata-only JWK change, retries the same unknown kid, and asserts fetch count does not advance.
- Flutter `token-not-persisted-or-logged` is false with blocker `not-yet-r05`.
- Authorization producer wrapper now reports true only when the emitted authorization producer record has `passed: true`.
- R04 orchestrator acceptance now expects authorization true, Flutter false with only `not-yet-r05`, and global aggregate false.

## Validation Run

- `git fetch origin`: pass.
- `git pull --ff-only`: pass, already up to date.
- branch: `intermid-cycle-recovery`.
- remote HEAD: `cb177621db82cde6be6d658c58daef590e5b9548`.
- `fd73da6fddf3cc308655c41e0640b045d710d983` ancestor: true.
- `7ed037db586d4e257eaa88783bec2c146a409230` ancestor: true.
- initial worktree: clean.
- `npm run typecheck`: pass.
- `npm test`: pass, 36 tests.
- `npm run format:check`: initially failed on two touched files; after Prettier, pass.
- `npm run lint`: pass.
- `npm exec tsx -- src/proof/jwks_producer.ts`: pass, `JWKS_STATE_MACHINE_PRODUCER=true`.
- `npm exec tsx -- src/proof/flutter_producer.ts`: expected nonzero, structurally valid false producer with only `not-yet-r05` blockers.
- `npm exec tsx -- src/proof/authorization_producer.ts`: fail, `AUTHORIZATION_RACE_BLOCKER=postgres-unavailable`.
- `docker version`: fail, Docker Desktop Linux engine unavailable.
- final disposable-resource inventory: not proven; Docker API unavailable.

## Authorization Results

All 28 R04 authorization cases remain unproved because disposable PostgreSQL 18 could not start:

1. membership-disabled-before-fence: false, blocker `postgres-unavailable`
2. membership-removed-before-fence: false, blocker `postgres-unavailable`
3. external-identity-disabled-before-mutation: false, blocker `postgres-unavailable`
4. actor-device-revoked-before-upload: false, blocker `postgres-unavailable`
5. actor-device-revoked-before-download: false, blocker `postgres-unavailable`
6. actor-device-revoked-before-acknowledgement: false, blocker `postgres-unavailable`
7. actor-device-revoked-before-capabilities: false, blocker `postgres-unavailable`
8. actor-device-revoked-before-rebootstrap-start: false, blocker `postgres-unavailable`
9. actor-device-revoked-before-rebootstrap-status: false, blocker `postgres-unavailable`
10. actor-device-revoked-before-rebootstrap-chunk: false, blocker `postgres-unavailable`
11. actor-device-revoked-before-rebootstrap-complete: false, blocker `postgres-unavailable`
12. actor-device-revoked-before-device-status: false, blocker `postgres-unavailable`
13. actor-device-revoked-before-device-revoke: false, blocker `postgres-unavailable`
14. owner-target-status: false, blocker `postgres-unavailable`
15. owner-target-revoke: false, blocker `postgres-unavailable`
16. member-self-status: false, blocker `postgres-unavailable`
17. member-self-revoke: false, blocker `postgres-unavailable`
18. foreign-target-denial: false, blocker `postgres-unavailable`
19. cross-account-target-denial: false, blocker `postgres-unavailable`
20. concurrent-target-revoke-one-transition-one-event: false, blocker `postgres-unavailable`
21. independent-repeat-revoke-duplicate-equivalent: false, blocker `postgres-unavailable`
22. self-revoked-actor-denied-later: false, blocker `postgres-unavailable`
23. equivalent-concurrent-enrollment: false, blocker `postgres-unavailable`
24. conflicting-enrollment-request-hash: false, blocker `postgres-unavailable`
25. response-loss-query-replay: false, blocker `postgres-unavailable`
26. process-restart-replay: false, blocker `postgres-unavailable`
27. serialization-retry-exhaustion-fails-closed: false, blocker `postgres-unavailable`
28. denied-no-state-advance: false, blocker `postgres-unavailable`

No before/after authorization state evidence, race counts, replay counts, restart counts, retry counts, or event counts were produced for R04 because the disposable database gate did not open.

## Skipped Validation

Full server build, audit, migration producer, route producer, static producer, R04 orchestrator, Flutter analyze/tests/builds, Python regressions, migration hash comparison, git diff check, staged/tracked secret scan, commit and push were not run after the Docker blocker. No commit was created.

## Terminal Evidence

C10-MCG02-R04_PARTIAL
AUTHORIZATION_RACE_PRODUCER=false
R3_LOCAL_SECURITY_PROVED=false
