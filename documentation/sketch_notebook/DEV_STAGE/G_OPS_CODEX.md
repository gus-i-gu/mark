# G_OPS_CODEX — C10-S01B Operational Evidence

Sequence: FLX-ORD-01
Role: Codex materialization evidence
Unit: C10-S01B Local Synchronization Convergence Completion
Branch: `intermid-cycle-recovery`
Baseline HEAD: `cb890dcdaf86cefa875e6984f20a71e20a912f60`
Source stages: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Terminal status: `C10-S01B_LOCAL_CONVERGENCE_PROVED`

## Changed Paths

Modified:
`clients/markei_flutter/lib/domain/sync/sync_event.dart`,
`clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`,
`clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart`,
`clients/markei_flutter/pubspec.yaml`,
`clients/markei_flutter/pubspec.lock`,
`clients/markei_flutter/test/sync/local_sync_application_test.dart`,
`clients/markei_flutter/test/sync/two_device_system_harness_test.dart`,
`clients/markei_flutter/tool/sync_lab.dart`,
`contracts/shared_beta/v3/fixtures/purchase_registered.valid.json`,
`contracts/shared_beta/v3/purchase_registered.schema.json`,
`services/markei_sync_api/package.json`,
`services/markei_sync_api/src/application/sync_service.ts`,
`services/markei_sync_api/src/http/app.ts`,
`services/markei_sync_api/src/postgres/database.ts`.

Created:
`clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_event_applier.dart`,
`clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_fact_writer.dart`,
`clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart`,
`clients/markei_flutter/test/sync/real_convergence_harness_test.dart`,
`infra/sync_lab/.gitignore`,
`services/markei_sync_api/migrations/002_coordination_hardening.sql`,
`services/markei_sync_api/src/domain/cursor.ts`,
`services/markei_sync_api/src/lab.ts`.

Pre-existing untracked `.vscode/settings.json` and `documentation/NEON_DOC.md` were preserved and not staged.

## Versions

Dart `3.12.2`; Flutter `3.44.6`; Node `v24.18.0`; npm `11.16.0`; Docker Desktop engine `29.6.1`; PostgreSQL image `postgres:18`; Dart HTTP dependency `http 1.6.0`; Fastify `5.10.0`; `pg 8.16.3`; TypeScript `5.9.3`.

## Validation

Passed:
`flutter pub get`; `dart run build_runner build --delete-conflicting-outputs`; `dart format --set-exit-if-changed .`; `flutter analyze`; `flutter test` (`52 passed, 1 lab-gated skipped`); `MARKEI_RUN_SYNC_LAB=1 flutter test test/sync/real_convergence_harness_test.dart` (`CONVERGED=true`); `npm run format:check`; `npm run lint`; `npm run typecheck`; `npm test` (`3 passed`); `npm audit --omit=dev` (`0 vulnerabilities`); `python -m unittest discover tests` (`5 passed`); `flutter build windows`; `flutter build apk --debug`; `git diff --check`; credential-pattern scan; `docker compose ps` after harness (`no running services`).

Drift regeneration wrote no schema-authority change. Windows build produced `build\windows\x64\runner\Release\markei.exe`; Android debug build produced `build\app\outputs\flutter-apk\app-debug.apk`.

## Migration And Isolation

`001_init.sql` was not edited. New forward-only `002_coordination_hardening.sql` adds composite Account/Device ownership FKs, download/replay/ack indexes, migration ledger row, revoked `PUBLIC` schema privileges, runtime grants, and RLS on Account-bearing coordination tables.

The real harness applied 001 then 002 on fresh disposable PostgreSQL 18, generated ignored lab credentials, seeded one synthetic Account and Devices A/B through the migrator role, then connected API child processes as `markei_runtime`.

## Convergence Counts

Harness topology: isolated Drift A/B files, loopback Fastify child process for A, disposable PostgreSQL 18, loopback Fastify child process for B, Flutter HTTP transport on both sides.

Observed assertions: A registered one offline Purchase; timeout-after-commit persisted `unknown-outcome`; retry reused the same SubmissionId and replayed the stored server-accepted response; server `sync_events` count was `1`; B downloaded one event, applied one Store/Product/Purchase/Item set, replay ignored duplicate, emitted no outbound pending event, acknowledged one cursor; server `device_acknowledgements` count was `1`; reopened A/B each had one Purchase and one Item.

## Fault Evidence

Covered by focused tests/harness: API unavailable while local registration continues; unknown upload outcome retry identity; duplicate inbox/event effect; complete remote Purchase application; unsafe max-cursor acknowledgement replaced by committed cursor; fixture-auth escape prevention; normal runtime auth verifier refusal; same fixture hash in Dart/TypeScript; timeout after server commit; disposable teardown.

Not fully exhaustive beyond the implemented floor: serialization/deadlock exhaustion, every malformed/oversized schema branch, and per-table cross-Account DML probes are represented by constraints/RLS and harness path but not expanded into a full matrix.

## Security And Teardown

No Neon credentials were requested or used. No Neon resources, deployment, production authentication, telemetry, or payload logging were added. Fixture data is synthetic. Generated lab credentials, databases, volumes and build artifacts are ignored/untracked. Secret scan found no committed credential literals.
