# G_OPS_CODEX — R04C01 Operational Evidence

Authority marker: C10-MCG02-R04C01_20260717T143908Z
Controlling J SHA: 2d85523952a3606ec80a3769817cb4ad8e647cb9
Controlling D/E/F SHA: 2d85523952a3606ec80a3769817cb4ad8e647cb9
Baseline remote SHA: 2f7272a8cacaa790ccfaad6c0c7523eede336460
Actual implementation start UTC/local: 2026-07-17T14:49:00.7290473Z / 2026-07-17T11:49:00.7780130-03:00
Actual implementation end UTC/local: 2026-07-17T15:05:21.3977466Z / 2026-07-17T12:05:22.8704211-03:00
Implementation tree SHA: pending at report authoring
Final commit status: pending before commit
Evidence environment: Windows host, Docker Desktop desktop-linux, Server OS/Arch linux/amd64, postgres:18-alpine PostgreSQL 18.4, Node/npm project services/markei_sync_api
Result classification: R04C01 vertical slice proved; authorization-race producer remains false by design

## Preflight

- `docker version`: Client 29.6.1, Server Docker Desktop 4.82.0, OS/Arch linux/amd64.
- Started loopback-only disposable `postgres:18-alpine` container `markei-c10-mcg02-r04c01-preflight-1449` on `127.0.0.1:55449`.
- `pg_isready -U postgres`: accepting connections.
- `select version();`: PostgreSQL 18.4 on x86_64-pc-linux-musl.
- Removed preflight container.
- Filtered inventory `docker ps -a --filter name=markei-c10-mcg02-r04c01-preflight-1449 --format "{{.Names}}"`: exit zero, empty stdout.

## Changed Paths

Production/application seams:

- `services/markei_sync_api/src/application/authorization_barrier.ts`
- `services/markei_sync_api/src/application/hosted_authorization.ts`
- `services/markei_sync_api/src/postgres/database.ts`

Proof/test infrastructure:

- `services/markei_sync_api/src/hosted_local_harness.ts`
- `services/markei_sync_api/src/proof/account_state_observer.ts`
- `services/markei_sync_api/src/proof/authorization_barrier_controller.ts`
- `services/markei_sync_api/src/proof/authorization_producer.ts`
- `services/markei_sync_api/src/proof/authorization_slice_scenarios.ts`
- `services/markei_sync_api/test/authorization_r04c01.test.ts`

Reports:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No migrations, lockfiles, dependencies, Flutter/UI files, A/B/C, J/D/E/F, methodology, or permanent memory files were edited.

## Scenario Evidence

Executed representative scenario:

- Case: `membership-disabled-before-fence`
- Route: real loopback Fastify `POST /v1/sync/submissions`
- Fixture: synthetic RS256 JWT, active external identity, active owner membership, active enrolled Device, valid `purchase.registered` payload v3.
- Barrier: participant `upload` reached `before-identity-membership-fence` inside an open transaction before membership resolution.
- Control transition: migrator/control connection updated Account membership to `disabled` and committed.
- Release: upload resumed and rechecked current membership state.
- HTTP result: status `403`, code `membership-required`, operation `hosted-authorization`, outcome `not-applied`.
- Before/after comparison: observer allowed only membership status change; submissions, sync events, cursor state, acknowledgements, recovery sessions/chunks, Devices, enrollment requests, and security events did not advance.

Producer record:

- `membership-disabled-before-fence`: true.
- Remaining 27 authorization cases: false with `pending-r04c`.
- `denied-no-state-advance`: false with `pending-r04c`.
- `AUTHORIZATION_RACE_PRODUCER=false` expected for R04C01.

## Validation

- Focused preflight: passed as above.
- `node --test --import tsx test/authorization_r04c01.test.ts`: 8 passed.
- `npm exec tsx -- src/proof/authorization_producer.ts`: expected exit 1; emitted closed authorization producer with `membership-disabled-before-fence` true and producer `passed:false`.
- `npm run format:check`: passed.
- `npm run lint`: passed after observer lint correction.
- `npm run typecheck`: passed.
- `npm test`: 45 passed.
- `npm run build`: passed.
- `npm audit --omit=dev`: 0 vulnerabilities.
- `git diff --check`: passed; only Git line-ending warnings were printed.

Exclusions: full Flutter/platform validation and all-producer R04 aggregation were not required because R04C01 did not change Flutter/shared mobile contracts and intentionally leaves the full authorization matrix pending.

## Resource And Privacy Evidence

- Debug PostgreSQL container `markei-c10-mcg02-r04c01-debug-pg` was removed.
- Final R04C01 Docker inventory prefix check was empty before report authoring.
- No Auth0, Neon, Render, or public provider was contacted.
- Private/provider helper files were not read: `.vscode/`, `documentation/NEON_DOC.md`, `documentation/NEON_SESSION.ps1`.
- Synthetic keys, identities, Accounts, memberships, Devices, and loopback URLs only.

## Remaining Blockers

The remaining authorization matrix cases are intentionally pending for later R04C units:

- Identity/member remainder, actor-Device route matrix, target Device authorization, enrollment concurrency, response-loss/restart/retry, and global denied-no-state-advance.
