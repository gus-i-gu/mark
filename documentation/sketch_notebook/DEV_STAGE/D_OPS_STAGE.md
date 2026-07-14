# D_OPS_STAGE — C10-S01 Execution and Evidence Contract

> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITH E/F
> Unit: Disposable local `purchase.registered` synchronization proof
> Reconciled baseline: `ad7107b602bd3820e8ef357491f57b1aab2ba632`
> Controlling synthesis: `[M]_STAGE/J_MAIN_STAGE.md`
> Terminal gate: `WAITING_FOR_MCG_01`

## 1. Authority

Codex may modify repository source, contracts, tests, local lab configuration and G/H/I only as
required by D/E/F. Codex may install/pin repository dependencies and run disposable local services.

Codex may not create, configure or contact Neon, deploy an API, provision authentication, request
human secrets, use ordinary user data, alter permanent notebook memory or consume Cycle 11 UI work.

If D/E/F disagree, a schema migration risks reset/data loss, fixture auth could run outside tests,
or a provider credential becomes necessary, stop before mutation and report to Main.

## 2. Required preflight

Before editing:

1. read root/Sketch Notebook AGENTS, INDEX and the full methodology boot;
2. read J and D/E/F together;
3. verify branch `intermid-cycle-recovery`, clean/understood status and required ancestry;
4. inventory Flutter/Dart, Node/npm, container runtime, PostgreSQL client and Java/Android state;
5. run available baseline Flutter analysis/tests and protected Python tests;
6. inspect schema-v4 migration fixtures and back up any file fixture before migration tests;
7. secret-scan tracked files and confirm no provider `.env` is present;
8. record unavailable host capabilities without substituting live infrastructure.

Do not delete/stash/reset unrelated work. Do not modify the protected Python/PySide6 database.

## 3. Checkpointed implementation order

### CP0 — Baseline and protocol inventory

- Record exact tool/dependency versions and available commands.
- Reconcile `contracts/shared_beta/v2` with runtime JSON and define v3 ownership.
- Add a concise lab README and ignored-artifact inventory.
- Keep app runnable and all baseline tests green before schema work.

Gate: v2 behavior and current local database can be reproduced.

### CP1 — Executable v3 contracts

Create `contracts/shared_beta/v3/` with JSON Schema and deterministic examples for:

- `purchase.registered` event envelope/full aggregate;
- upload Submission request/result;
- download page/cursor;
- acknowledgement request/result;
- typed protocol failure.

Define canonical UTF-8 JSON hashing consistently in Dart and TypeScript. Fixtures must cover
equivalent duplicate, ID/hash mismatch, sequence gap, invalid version, unknown field, size/batch
limit and optional Person/Payment facts.

Gate: Dart and TypeScript validate the same fixtures and compute identical hashes.

### CP2 — Local schema v5 and repositories

Add handwritten Drift schema/migration for:

- singleton InstallationMetadata/current Device;
- durable SyncSubmissions/attempt results;
- SubmissionEvents membership;
- SyncInbox applied-event ledger;
- cursor/apply bookkeeping and extended PendingEvent lifecycle where needed.

Backfill one deterministic valid UUID Device only when the existing single-installation state is
unambiguous. Preserve all historical Devices/events. Ambiguous or absent valid Device states return
a typed blocker; never create a replacement by silently discarding history.

Add repository/application operations for:

- load/create current installation idempotently under concurrency;
- lease/read a bounded pending batch;
- persist/retry the same SubmissionId after unknown outcome;
- accept/reject stored Submission outcomes;
- insert inbox + apply facts + advance cursor atomically;
- acknowledge only greatest contiguous applied cursor;
- release expired local leases safely.

Gate: fresh/v4→v5/reopen/failure/rollback/concurrency/crash-replay tests pass before HTTP work.

### CP3 — Disposable local PostgreSQL/API

Create a bounded service under `services/markei_sync_api/` and lab infrastructure under
`infra/sync_lab/`:

- Node 24 LTS / TypeScript;
- Fastify JSON-schema routes;
- `pg` transactions;
- forward-only SQL migrations;
- pinned lockfile, lint/typecheck/test scripts;
- loopback-bound Docker Compose PostgreSQL 18 lab;
- generated ignored lab secrets, never committed/logged;
- separate migration and runtime roles.

Implement health/readiness plus upload, download and acknowledgement endpoints from F. Test runtime
DDL denial and Account isolation. Fixture authentication is injected only in tests; the normal
server must refuse to start without a non-fixture AuthVerifier.

Gate: local migrations, privilege probes, API unit/integration tests and deterministic teardown pass.

### CP4 — Flutter transport and synchronization engine

Implement ports/adapters/use cases without page redesign:

- authenticated SyncTransport interface;
- HTTP adapter configurable only through explicit non-secret base URL plus injected token source;
- upload pending batch with timeout-safe Submission retry;
- download after cursor;
- atomic apply/inbox/cursor transaction;
- acknowledgement after commit;
- typed results matching E;
- synchronization disabled by default unless the composition receives an explicit adapter/config.

Do not embed database URLs, provider tokens, fixture credentials or a production authentication
implementation. Local-only app startup and Purchase registration must behave unchanged.

Gate: fake-transport unit tests pass before cross-process lab testing.

### CP5 — Full local vertical slice and failures

Run two isolated Drift files against the disposable API/Postgres lab:

1. A registers a deterministic offline Purchase.
2. A uploads one v3 Event.
3. Inject timeout after server commit and retry the same SubmissionId.
4. Confirm equivalent stored response and one server Event.
5. B downloads and atomically applies facts/cursor/inbox.
6. Replay/reorder the Event and confirm no duplicate effect.
7. B acknowledges its contiguous cursor.
8. Reopen both local files and compare stable facts/derived Lists.
9. Tear down only inventoried disposable resources.

Run negative/failure cases named in J. Never log payloads.

Gate: convergence passes or is reported as a blocking defect; do not weaken assertions to continue.

### CP6 — Regression, evidence and stop

Run, when available:

```text
dart format --output=none --set-exit-if-changed lib test tool
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs
npm ci
npm run format:check
npm run lint
npm run typecheck
npm test
docker compose ... up --wait
docker compose ... down --volumes
flutter build windows --release
flutter build apk --debug
python -m unittest discover tests
git diff --check
```

Use actual repository scripts in reports rather than copying placeholders. Do not run live Neon probes.

## 4. Failure-injection floor

Required tests:

- disconnect before request, mid-request and after server commit/before response;
- same SubmissionId/Event/hash replay and ID/hash mismatch;
- wrong Account, unknown/revoked Device and fixture-auth escape prevention;
- DeviceSequence duplicate/gap and concurrent submissions;
- invalid/unknown protocol version, malformed/oversized payload and batch overflow;
- duplicate, reordered and cursor-gapped downloads;
- crash after inbox insert, during fact apply, before cursor and after commit/before ack;
- migration failure, v4 original reopen and no silent reset;
- runtime DDL denial, RLS/cross-Account denial, serialization retry and pool exhaustion simulation;
- local-only startup with API unavailable.

Each failure must yield typed applied/not-applied/unknown state and safe retry/non-retry behavior.

## 5. Secrets, logs and artifacts

- Add `.gitignore` entries for generated lab env, databases, volumes, tokens and logs.
- `.env.example` contains names/descriptions only, never working values.
- Generate lab-only random credentials into an ignored file; bind published ports to loopback.
- Logs may contain redacted Account/Device/Event/Submission IDs, cursor, code, count, duration and
  content-hash prefix; never tokens, URLs with credentials, payload JSON or Purchase descriptions.
- Secret-scan the staged diff before commit.

## 6. Human/manual stop points

Codex may ask the human only to start/approve an installed local container service or approve a
missing local tool installation. Codex must not ask for Neon credentials.

After CP6, produce `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`, then stop. Include a
sanitized MCG-01 checklist but perform none of it.

## 7. G evidence requirements

G must report:

- exact baseline/final SHA and complete changed-path inventory;
- installed/pinned dependencies and licenses if relevant;
- migrations and rollback/no-reset evidence;
- commands with pass/fail/skip counts and host boundaries;
- local two-Device event/cursor/fact counts;
- fault-injection results;
- secret-scan and disposable-resource teardown;
- skipped live provider/auth/deployment actions;
- remaining risks and terminal status `WAITING_FOR_MCG_01`.

## 8. Exit criteria

Successful exit requires executable local proof, preserved local-only behavior, green available
regressions, no tracked secrets, no live provider use and G/H/I completed. A host-blocked local lab
may exit only as partial with unit/static evidence and an explicit blocker; it may not claim protocol
or convergence validation.
