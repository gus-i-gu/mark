<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


<!-- ROUND_MARKER:IRC-R01-O-2026-07-14 -->

# Operational Ordinary-Sequence Investigation

Sequence: FLX-ORD-01 — Ordinary Sequence  
Role: Operational [O]  
Round or unit: Intermid Cycle Recovery operational evidence pass  
Branch: `intermid-cycle-recovery`  
Baseline / inspected boundary: branch compared against `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc`  
Authority: investigation and Operational staging only  
Writable surface: `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`  
Evidence boundary: GitHub repository inspection; no host commands rerun

## 1. Bounded objective and sequence status

The bounded objective was to recover current execution truth for the shared Flutter client and protected Python beta, classify existing validation, and identify the smallest next Operational gates.

The invoking human prompt selects the Ordinary Sequence. `J_MAIN_STAGE.md` remains provisional orientation and labels its seed as FLX-INV-02/IRC-R01. That inherited label was not allowed to broaden authority: this report performs one bounded Operational pass and requests Main synthesis before any D/E/F materialization.

Comparison of `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc` to `intermid-cycle-recovery` reports 34 commits and only Sketch Notebook documentation paths. No path under `clients/markei_flutter/`, `app/`, `tests/`, or packaging changed. Therefore current application source equals the inspected Cycle 08 implementation boundary.

## 2. Newly observed repository evidence

### Environment and reproducibility surface

- `clients/markei_flutter/pubspec.yaml` requires Dart `^3.12.2` and declares Flutter, Drift, SQLite, path-provider, UUID, normalization, crypto, and test/build dependencies.
- `clients/markei_flutter/pubspec.lock` pins the resolved graph and records Dart `>=3.12.2 <4.0.0` and Flutter `>=3.38.4`. Examples include Drift `2.34.1`, sqlite3 `3.4.0`, sqlite3_flutter_libs `0.5.42`, path_provider `2.1.6`, and uuid `4.5.3`.
- The Python desktop surface still exposes `requirements.txt` with PySide6. `tests/test_release_configuration.py` continues to protect packaging identity, schema inclusion, exclusion of transient database files, user-data preservation, version consistency, and local-app-data diagnostics.
- The Flutter README remains generated starter text. It does not provide Markei-specific checkout, build, run, database-location, migration, or recovery instructions. Reproducibility currently depends on notebook evidence and known commands rather than a client-local operational guide.

### Startup, runtime, and persistence

- `clients/markei_flutter/lib/main.dart` initializes Flutter bindings, awaits `MarkeiComposition.appPrivate()`, and starts `MarkeiApp`.
- `lib/app/markei_composition.dart` opens `LocalDatabase.appPrivate()`, loads or creates a persistent Device identity, composes local registration/query repositories, and uses the placeholder account ID `local-account`. This is local-beta composition, not authentication.
- `lib/infrastructure/local/local_database.dart` places `markei_shared_beta.sqlite` beneath the platform application-support directory returned by `getApplicationSupportDirectory()`. The repository defines the location algorithm but does not establish the exact absolute path for the current host.
- The same database file contains accounts, devices, products, stores, purchases, purchase items, sync events, pending events, sync state, and a migration ledger. Event/queue persistence is preparation only; no upload, download, remote cursor processing, or synchronization runtime is present.

### Schema and migration behavior

- `LocalDatabase.schemaVersion` is 2.
- Fresh creation calls `createAll()` and inserts a `create-v2` migration-ledger entry.
- The only handwritten upgrade is v1→v2. It adds Product code/display columns and migration-ledger metadata, then backfills legacy Product codes from the first eight hyphen-stripped Product-ID characters.
- Any upgrade whose starting version is not 1 throws `UnsupportedError`.
- Foreign keys are enabled in `beforeOpen`.
- Observed limitation: the v1→v2 branch is selected by `from == 1`; it does not explicitly guard `to == 2`. This is harmless for the current schema target but should be made an explicit migration-chain concern before schema v3.
- No repository evidence in this pass demonstrates representative on-disk upgrade fixtures, collision handling for generated legacy codes, interrupted-upgrade recovery, downgrade behavior, corruption recovery, backup/restore, or no-silent-reset acceptance.

### Transaction and failure behavior

- `LocalPurchaseRepository.registerPurchase()` wraps account/sync-state/device preparation, Store resolution, Product resolution, Purchase and Item insertion, device-sequence allocation, SyncEvent insertion, PendingEvent insertion, and result construction in one Drift transaction.
- Empty purchases, missing cross-account Store/Product references, invalid domain values, and duplicate Product codes raise errors inside that transaction. Source structure supports rollback intent across these writes.
- A transaction boundary is observed; rollback behavior under injected mid-transaction failure was not newly executed or independently demonstrated in this pass.
- UI submission uses a mounted-state `_submitting` guard. This prevents a second tap during one in-flight call but is not durable idempotency and does not protect retries across process restart or separate registration attempts.

### Tests and defect evidence

- `clients/markei_flutter/test/app/markei_app_test.dart` contains six focused widget tests covering:
  - multi-item registration and History presentation;
  - phone-width shell plus local/empty states;
  - selected-destination preservation across narrow/wide layout change;
  - History loading/error/retry/empty states;
  - Product creation/search/no-match behavior;
  - History detail and a price-change result.
- These tests use `LocalDatabase.memory()`; they exercise repository/UI integration without proving file-backed persistence, application-support paths, process restart, migration, host packaging, or device lifecycle.
- The phone-width test does not complete the long Purchase form. Wide layout performs registration.
- `PurchasePage._editLine()` restores price, package count, amount, and unit but does not restore or retain the line's Product selection/reference. Saving then depends on the currently selected or newly entered Product path. The existing-Product edit defect reported by J remains directly visible in current source.
- The draft remains mounted-widget/session state in `_lines`; no file-backed draft recovery exists.
- Registration failure deliberately leaves the in-memory draft available and reports a generic safe error. Process death still loses it.

### Repository hygiene

- The implementation commit comparison `4f5ef21…fb3b7f21` contains tracked Python `__pycache__` and `.pyc` files under `app/`, `app/core/`, and `tests/`.
- Those generated validation artifacts remain part of the current application tree because later branch commits changed documentation only.
- A root `.gitignore` was not found at the inspected branch path. Whether ignore policy exists in another scoped file remains unresolved; tracked bytecode cleanup still requires a bounded, explicitly authorized hygiene unit.

## 3. Inherited evidence, not rerun

The archived Cycle 08 `G_OPS_CODEX.md` at implementation commit `fb3b7f21…` records:

- 6 focused widget tests passed;
- formatting checked 34 files with no change;
- Flutter analysis reported no issues;
- 31 Flutter tests passed;
- Windows release build produced `build\\windows\\x64\\runner\\Release\\markei.exe`;
- 5 Python unittest regressions passed;
- Android debug APK build could not run because that host lacked `JAVA_HOME` and a `java` command.

These results remain historically attributable to the unchanged source boundary, but they were not reproduced on a current host in this pass. They establish inherited build/test evidence, not present-host acceptance.

No manual Windows product smoke, Android runtime/lifecycle run, physical-device run, or iOS run was inherited for the final product materialization.

## 4. Operational conclusions

### Observed

- The branch retains a local-first Flutter/Drift client plus a protected Python/PySide6 regression and packaging reference.
- Application source has not changed since the recorded Cycle 08 validation.
- File-backed persistence uses a platform application-support directory and schema v2.
- Purchase registration has one source-level transaction spanning Purchase facts and local event-queue facts.
- The existing-Product staged-line edit path remains defective.
- Tracked Python bytecode remains repository hygiene debt.

### Inference, explicitly bounded

- Because application paths are unchanged, prior passing results remain relevant regression evidence. They do not guarantee that current SDKs, host configuration, generated files, packaging, or runtime behavior still reproduce.
- Drift transaction semantics plus the single transaction callback make all-or-nothing registration the intended behavior. Acceptance still requires a failure-injection test or equivalent executable evidence.
- The platform-support database location should survive ordinary application restarts, but source inspection alone does not prove close/reopen, upgrade, uninstall, backup, or restore behavior on a target host.

### Acceptance status

Implemented in source:
- responsive Purchase/Products/History shell;
- local Product and Store reuse/creation;
- multi-line session draft and review;
- atomic-intent local registration;
- detailed History and narrow compatible price comparison;
- schema v2 and persistent Device identity.

Validated historically:
- focused and full Flutter tests;
- static analysis and formatting;
- Windows release build;
- Python regressions.

Host-unvalidated now:
- all command reproduction in this IRC pass;
- manual Windows runtime;
- Android build/runtime/lifecycle and physical device;
- iOS;
- exact current database path and file-backed restart behavior.

Not accepted:
- existing-Product edit correctness;
- durable submission idempotency;
- process-death draft recovery;
- schema-v3 evolution;
- migration failure/collision recovery;
- export/restore;
- production signing/distribution;
- authentication or synchronization.

## 5. Unresolved questions

1. What exact Flutter/Dart, Java, Android SDK, Windows toolchain, and Python versions are available on the next validation host?
2. Does the final product build, launch, register, close, reopen, and show History correctly using the app-private file database?
3. Do injected failures after Purchase, Item, sequence, event, and pending-event writes leave no partial state and preserve sequence correctness?
4. Can representative v1 databases upgrade to v2 without collision or data loss, and what explicit chain will govern v2→v3?
5. What catalogue and History volumes cause measurable query or render degradation?
6. Which ignore file, if any, is intended to govern Python bytecode, and should already tracked artifacts be removed?
7. Will the existing-Product edit defect close in this recovery unit or enter the next implementation cycle?

## 6. Prospective bounded work

Main should synthesize one narrow D/E/F unit before any mutation. Recommended order:

1. correct existing-Product draft editing and add a regression test that edits an existing Product line without changing Product identity;
2. add executable transaction rollback/failure-injection coverage;
3. add file-backed close/reopen and representative v1→v2 migration fixtures;
4. remove tracked Python bytecode and establish explicit ignore policy;
5. rerun format, analysis, focused/full Flutter tests, Python regressions, and Windows build;
6. perform a manual Windows register→restart→History smoke;
7. restore Java/Android tooling only under explicit host authority, then build/install/run and execute lifecycle checks.

Stop if migration fixtures reveal collision/data-loss risk, rollback leaves partial rows or sequence gaps, the host requires uncontrolled mutation, or the defect fix requires an unapproved schema/design decision.

## 7. Deferred

Deferred beyond this bounded Operational unit:

- Store normalization and branch identity;
- durable SubmissionId;
- persistent drafts;
- broad query/index redesign before measurement;
- authentication, API, Neon, upload/download, and multi-device convergence;
- production signing, store distribution, backup/support contract;
- PySide6 retirement.

## 8. Ordinary-Sequence handoff

Recovered: current source boundary, dependency surface, persistence path algorithm, schema/migration code, transaction scope, focused tests, inherited command evidence, confirmed defect, and hygiene debt.

Still uncertain: current-host reproducibility, manual runtime, file-backed restart, migration/rollback fixtures, performance thresholds, and target-cycle ownership of the defect.

Next valid transition: Main synthesis of this Operational report with Didactic and Design evidence, followed by a controlling D/E/F instruction if materialization is accepted.

Authority remains insufficient for source, schema, host, permanent-memory, J, methodology, or cross-domain changes.
