# G_OPS_CODEX — R04C02 Operational Evidence

Authority marker: C10-MCG02-R04C02_20260717T151546Z
Controlling staging SHA: f1fe19135ba47c652cd2575d7256a74f871f78bb
Controlling D/E/F authority SHA: f1fe19135ba47c652cd2575d7256a74f871f78bb
Baseline implementation SHA: 40e0a7097fef7f8a7abfe172cc867b670dfec196
Actual implementation start UTC/local: 2026-07-17T15:28:19.9012372Z / 2026-07-17T12:28:19.9500907-03:00
Actual implementation end UTC/local: 2026-07-17T15:42:54.4630188Z / 2026-07-17T12:42:54.4929972-03:00
Implementation tree SHA: pending before commit
Final commit status: pending before commit
Evidence environment: Windows host, Docker Desktop desktop-linux linux/amd64, postgres:18-alpine PostgreSQL 18.4, services/markei_sync_api
Result classification: R04C02 core authorization matrix proved; authorization-race producer remains false pending R04C04

## Changed Paths

- `services/markei_sync_api/src/application/hosted_authorization.ts`
- `services/markei_sync_api/src/hosted_local_harness.ts`
- `services/markei_sync_api/src/proof/authorization_producer.ts`
- `services/markei_sync_api/src/proof/authorization_slice_scenarios.ts`
- `services/markei_sync_api/test/authorization_r04c01.test.ts`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No migrations, dependencies, lockfiles, Flutter/UI, A/B/C, J, D/E/F, methodology, permanent memory, provider, or private helper files were changed.

## Preflight And Teardown

- `docker version`: client/server available; server OS/Arch `linux/amd64`.
- Disposable preflight container `markei-c10-mcg02-r04c02-preflight-1528` started loopback-only on `127.0.0.1:55452`.
- `pg_isready`: accepting connections.
- `select version();`: PostgreSQL 18.4.
- Container removed; exact filtered inventory empty.
- Final R04C02 inventory `docker ps -a --filter name=markei-c10-mcg02-r04c02 --format "{{.Names}}"`: empty.

## Case Results

CP-A:

| Case | Route/operation | Barrier | Response | State |
| --- | --- | --- | --- | --- |
| membership-disabled-before-fence | POST `/v1/sync/submissions` upload-submission | before-identity-membership-fence | 403 membership-required | no protected sync advance |
| membership-removed-before-fence | POST `/v1/sync/submissions` upload-submission | before-identity-membership-fence | 403 membership-required | no protected sync advance |
| external-identity-disabled-before-mutation | POST `/v1/sync/submissions` upload-submission | before-identity-membership-fence | 403 membership-required | no protected sync advance |
| actor-device-revoked-before-upload | POST `/v1/sync/submissions` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-download | GET `/v1/sync/events` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-acknowledgement | POST `/v1/sync/acknowledgements` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-capabilities | GET `/v1/sync/capabilities` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-rebootstrap-start | POST `/v1/sync/rebootstrap` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-rebootstrap-status | GET `/v1/sync/rebootstrap/:sessionId` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-rebootstrap-chunk | GET `/v1/sync/rebootstrap/:sessionId/chunks/0` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-rebootstrap-complete | POST `/v1/sync/rebootstrap/:sessionId/complete` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-device-status | GET `/v1/devices/:deviceId/status` | before-actor-device-lock | 403 device-revoked | no protected sync advance |
| actor-device-revoked-before-device-revoke | POST `/v1/devices/:deviceId/revoke` | before-actor-device-lock | 403 device-revoked | no protected sync advance |

CP-B:

| Case | Result |
| --- | --- |
| owner-target-status | 200; owner inspected Account Device |
| owner-target-revoke | 200; one target revoke transition |
| member-self-status | 200; member inspected own Device |
| member-self-revoke | 200; member revoked own Device |
| foreign-target-denial | 403 forbidden; member denied other member target |
| cross-account-target-denial | 403 forbidden; cross-Account target denied |
| concurrent-target-revoke-one-transition-one-event | two authorized attempts converged to one revoked truth and one device-revoked event |
| independent-repeat-revoke-duplicate-equivalent | second revoke returned duplicate-equivalent with no second event |
| self-revoked-actor-denied-later | later protected upload denied 403 device-revoked |

CP-C:

| Case | Result |
| --- | --- |
| equivalent-concurrent-enrollment | two equivalent concurrent enrollments converged on one Device and one result |
| conflicting-enrollment-request-hash | second same request identity/different hash returned 409 conflict; first truth preserved |

Producer shape:

- Cases 1-24: true.
- Cases 25-28: false with `pending-r04c04`.
- `AUTHORIZATION_CASES_TRUE=24`.
- `AUTHORIZATION_CASES_PENDING=4`.
- `AUTHORIZATION_RACE_PRODUCER=false`.

## Validation

- Focused R04C02 visible harness: passed all CP-A/B/C cases.
- `npm exec tsx -- src/proof/authorization_producer.ts`: expected exit 1; emitted closed producer record with 24 true and four `pending-r04c04`.
- `node --test --import tsx test/authorization_r04c01.test.ts`: 9 passed.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: 46 passed.
- `npm run build`: passed.
- `npm audit --omit=dev`: 0 vulnerabilities.
- `git diff --check`: passed with only line-ending warnings.
- Secret scan: clean with localhost lab PostgreSQL URLs allowlisted.

Migration SHA-256:

- 001: F48A9E5D097BE5BD758FF76FF83D8CE8F81F364050F7DF4E3B463D26C18BD0CD
- 002: 32A0215E553585F48C8F9A8D50A622E34296A3F0D94FCDAF60A9DED278BED923
- 003: B5BA579866CF0C2B3376EB3FB35D208772970ADF6F570D9CB8A5569CBBD80C1D
- 004: 3B4826EAC93E5A77285AA68F804DBB8E6E83922B46C53BE209E7CBB3C9E39A09
- 005: E99F20BC7C718BA8B4614DB0E370F0E1535E5B357770DC2E402D0A8BBC5B312C
- 006: 7B83DC34464559D9BA7335E27CDA106B34D64EBB49BC2FAC155112A2E78DF87F

## Boundaries

No Auth0, Neon, Render, provider credentials, `.vscode/`, `documentation/NEON_DOC.md`, or `documentation/NEON_SESSION.ps1` were accessed. Full Flutter/platform/global aggregation remains deferred.
