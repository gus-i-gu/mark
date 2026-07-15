# D_OPS_STAGE — C10-S02 Operational Materialization Authority

> Sequence: FLX-INV-02 → Main D/E/F
> Unit: disposable local retention, snapshot and rebootstrap proof
> Baseline: `f6ecf800d736f0d77dd1754eded4f5544462ea83`
> Authority: controlling Operational instructions for Codex
> Provider boundary: MCG-01 active externally; no provider access authorized

## 1. Objective and stop rule

Implement and validate the J/F hybrid mechanism entirely inside disposable local infrastructure.
The application must remain runnable with synchronization and cleanup disabled.

Do not contact Neon, deploy, choose production auth, create real identities, inspect provider notes
or request secrets. Stop on contradiction, data-reset risk, unavailable required local tooling,
fixture-auth escape, cross-Account access or cleanup without verified snapshot coverage.

## 2. CP0 — recovery and baseline

1. Read root/notebook AGENTS, INDEX and full methodology route.
2. Read J/D/E/F together; A/B/C are evidence, G/H/I historical observation.
3. Confirm branch, clean overlap and required ancestor.
4. Inventory Flutter/Dart, Node/npm, Docker/PostgreSQL, Java/Android and Python.
5. Run existing focused sync tests before mutation.
6. Inventory current containers, volumes, ports, ignored artifacts and untracked user files.

Gate: retain one runnable commit and do not alter unrelated/untracked work.

## 3. CP1 — contracts and deterministic fixtures

Create closed schemas and shared fixtures for recovery format 1:

- capabilities/retention metadata;
- typed incremental cursor expiry;
- snapshot manifest and chunk descriptor;
- start/query/complete rebootstrap;
- typed recovery failures and phase states;
- deterministic Account snapshot with facts and covered cursor.

Use canonical recursively sorted UTF-8 JSON and SHA-256. Prove Dart/TypeScript fixture/hash parity.
Test valid, missing, extra, oversized, wrong-format, bad-index and bad-hash cases.

Gate: event payload version remains 3; recovery format is independently versioned 1.

## 4. CP2 — forward-only server migration

Add `003_retention_snapshot_recovery.sql`; never edit 001/002. Add only structures justified by F:

- Account earliest incremental cursor/current snapshot state;
- Device last-seen/lease data;
- immutable snapshot manifests and bounded chunks;
- cleanup run ledger;
- Device-bound rebootstrap sessions.

Create least-privilege worker authority distinct from runtime. Apply RLS and explicit Account
predicates to every new Account table. Runtime cannot publish snapshots, invoke physical cleanup,
perform DDL or manage roles. Worker cannot enroll/revoke Devices or read another Account.

Prove fresh 001→002→003, replay refusal/idempotent ledger behavior, failure rollback, runtime DDL
denial and original 001/002 database reopen after a failed disposable 003 copy.

Gate: cleanup remains disabled and no event is deleted during migration.

## 5. CP3 — policy and snapshot application services

Implement a framework-independent injected `RetentionPolicy` and `Clock`. No production duration
or implicit default. Test fixtures may use named durations only inside test composition.

Implement ports/services for:

- Device retention classification;
- consistent Account snapshot build;
- chunk store/read-back verification;
- snapshot publication/replacement;
- cleanup planning and bounded execution;
- rebootstrap session lifecycle.

Snapshot builder must use one consistent Account view and cut cursor. Events appended after the cut
remain retained. Failed/corrupt/incomplete snapshots never become available or authorize cleanup.
Keep the previous available generation until the replacement is verified.

Gate: physical cleanup callable only from explicit lab/worker composition.

## 6. CP4 — API and authorization

Implement J routes with Fastify closed schemas, bounded request/query/body/response sizes and typed
failures. Update download so a cursor before the retained floor returns `cursor-expired`, never an
empty page. A compatible snapshot yields `full-rebootstrap-required`; otherwise return
`recovery-unavailable`.

Every sync and recovery call must:

- derive Account/Device from `AuthVerifier`;
- verify enrolled, non-revoked Device state in PostgreSQL;
- set transaction-local RLS context;
- retain explicit Account/Device predicates;
- reject cross-Account SnapshotId/session/chunk access;
- keep retry identities stable after unknown outcomes.

Normal runtime retains `RefusingAuthVerifier`. Lab entrypoint remains loopback-only.

Gate: no endpoint exposes physical cleanup, storage credentials, SQL errors or fact payload logs.

## 7. CP5 — additive Drift v6 recovery boundary

Add only durable recovery session/chunk progress and format compatibility needed by F. Preserve all
v5 facts and synchronization state. Ambiguous or unsupported migration fails without reset.

Implement fresh-target rebootstrap:

1. start/query the same server session;
2. download bounded chunks with resumable progress;
3. validate Account, manifest, ordering, lengths, hashes and versions;
4. apply complete facts and covered cursor atomically to a fresh target;
5. catch up later events through existing remote applier;
6. acknowledge only after committed catch-up;
7. reopen and compare.

Before recovery, inspect pending/uploading/unknown local work. Return
`local-changes-block-rebootstrap`; never reset, merge, discard or auto-export it. Do not implement
production database file swap.

Gate: interruption/corruption leaves the prior database and target facts/cursor unchanged.

## 8. CP6 — decisive system harness

Extend the lab harness with deterministic time and at least Devices A/B/C:

- create multiple events before/after the snapshot cut;
- inject an append during/after snapshot construction;
- verify manifest/chunk read-back and publication;
- prove a lagging eligible Device blocks cleanup;
- expire that fixture lease and acknowledge the safe boundary;
- run explicit cleanup and assert only old covered events are removed;
- prove old cursor returns expiry rather than empty success;
- interrupt and resume C chunk transfer using the same session;
- reject corrupt/reordered/truncated chunks;
- apply/catch up/ack/reopen C and compare Account facts;
- confirm A/B local Purchase history survives server cleanup;
- prove pending/unknown local work blocks rebootstrap.

Required terminal diagnostic:

```text
RECOVERY_CONVERGED=true
```

Gate: direct service calls alone do not satisfy the HTTP/PostgreSQL/Drift system proof.

## 9. Failure-injection floor

Cover at least:

- valid empty page versus expired cursor;
- wrong Account and forged SnapshotId/session;
- unknown/revoked/expired Device;
- incompatible/obsolete recovery format;
- snapshot append race and failed build;
- corrupt, missing, duplicate, reordered, truncated and oversized chunk;
- interruption before/during/after download, apply, catch-up and completion;
- same recovery identity replay versus different request hash;
- eligible lagging Device and premature-cleanup attempt;
- duplicate cleanup workers and bounded SQL retry/exhaustion;
- cross-Account SELECT/INSERT/UPDATE denial on new tables;
- runtime cleanup/DDL denial and worker privilege boundary;
- v5→v6 fresh/reopen/failure/no-reset behavior;
- API unavailable while local registration continues.

## 10. Validation matrix

Run all applicable repository checks:

- Dart format check, Drift regeneration, Flutter analyze and complete Flutter tests;
- explicit lab-gated recovery/convergence harness;
- TypeScript format, lint, typecheck, tests and `npm audit --omit=dev`;
- migrations 001→002→003, privilege/RLS/constraint/transaction probes;
- Windows release build and Android debug build when host-supported;
- protected Python regressions;
- `git diff --check`;
- tracked/staged secret scan;
- final container/volume/port/temporary-file teardown inventory.

Record exact command, environment, result, counts and exclusions. A build is not runtime acceptance.

## 11. File and security discipline

- Split handwritten source by responsibility; keep ordinary files near 250 lines.
- Generated Drift output may exceed the ordinary limit.
- Add no telemetry, analytics, payload logging or polished UI.
- Use synthetic fixtures only.
- Ignore generated credentials, databases, chunks, logs and build outputs.
- `.env.example` may contain variable names only.
- Preserve protected Python/PySide6 source and database.
- Do not edit permanent documentation, methodology, J/D/E/F, 00/05/06 or unrelated files.

## 12. Codex report

Replace only G/H/I after implementation. G must include:

- baseline/final SHA and complete changed-path inventory derived from Git;
- dependency and migration versions;
- exact commands/results and platform boundary;
- snapshot/event/Device/session/chunk counts and cursor ranges;
- cleanup safety and recovery fault results;
- v5→v6 and 001→002→003 evidence;
- role/RLS/secret-scan/teardown results;
- confirmation Neon/auth/deployment were unused;
- deviations and one terminal state from J.

Commit and push one bounded implementation plus G/H/I. Never force-push.
