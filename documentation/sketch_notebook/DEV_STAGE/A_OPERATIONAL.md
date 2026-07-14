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


---

<!-- ROUND_MARKER:C09-R01-O-2026-07-14 -->

# Cycle 09 Operational Investigative Round — Local Product and Database Expansion

Sequence: FLX-INV-02 — Investigative Sequence  
Role: Operational Chat [O]  
Round or unit: C09-R01  
Branch: `intermid-cycle-recovery`  
Baseline / inspected HEAD: GitHub branch state immediately before this isolated stage commit; the connector did not expose the parent tip SHA as a local `HEAD`  
Required ancestry: `801e3940c972bac88b039e18357dbe006e94760a` verified as the merge base; branch was 23 commits ahead and 0 behind  
Authority: investigation and append-only Operational staging  
Writable surface: `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`  
Evidence boundary: GitHub repository objects and source inspection; no local checkout, host toolchain, generated-code regeneration, build, test, emulator, or manual runtime command was available or rerun

## 1. Baseline and recovery

The connected GitHub repository resolves the requested branch. Remote comparison establishes the required ancestor exactly. The supplied execution workspace was not a Git repository, so local branch, local working-tree cleanliness, tracking configuration, and local/remote divergence could not be observed. No unrelated local work could therefore be overwritten; publication uses the current remote file blob SHA as a concurrency guard.

Recovery used `INDEX.md`, direct canonical FLX-INV-02 methodology, `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, `operational/10_OPERATIONAL_STATE.md`, the latest active `J_MAIN_STAGE.md`, and current A/G evidence. `PROMPT_COLLECTION.md` was not invoked.

Inherited toolchain evidence remains Flutter 3.44.6/Dart 3.12.2 on the earlier host; current `pubspec.yaml` requires Dart `^3.12.2`. Current-host versions were not observable. The latest G evidence records 7 focused widget tests, 32 total Flutter tests, and clean analysis for the staged-line edit correction. That evidence is not Windows, Android, file-backed, manual, or release acceptance.

## 2. Inspected implementation surfaces

Inspected directly:

- `lib/app/markei_app.dart`: three-destination Purchase/Products/History shell and 720 px rail threshold.
- `lib/app/pages/purchase_page.dart`: Product draft creation, quantity/money parsing, staging, generic feedback, review and registration.
- `lib/app/pages/products_page.dart`: catalogue listing, client-side substring search, creation and similarity warnings.
- `lib/app/pages/history_page.dart`: single-row tap selection, detail and first-item price comparison.
- `lib/application/catalogue_queries.dart`, `register_purchase.dart`, and `purchase_history.dart`: current ports and projections.
- `lib/domain/catalogue/product.dart` and `domain/shared/quantity.dart`: exact identity, similarity, dimensions, units and fixed-decimal parsing.
- `lib/infrastructure/local/local_database.dart`, `local_query_repository.dart`, `local_purchase_repository.dart`, and composition: schema v2, migration, lookup/collision code, query limits and transaction boundary.
- `test/app/markei_app_test.dart`: seven widget tests, including one phone-width shell state and the corrected existing-Product edit regression.
- `pubspec.yaml`: no CSV, PDF, share, printing, file-picker, or equivalent export dependency was found.

No Cycle 09 source, schema, generated Drift artifact, or test was modified or executed.

## 3. Reproductions and code-path diagnoses

### L and un rejection

The domain already recognizes MASS kg/g, VOLUME L/ml, and COUNT unit/un. `normalizeDisplayQuantity` lowercases input, so uppercase `L` would be accepted if the caller supplied `MeasurementKind.volume`.

Both `PurchasePage._productDraft()` and `ProductsPage._draft()` hard-code `MeasurementKind.mass`. `PurchasePage._stageItem()` also hard-codes MASS for every purchased quantity. Consequently:

- `L`/l reaches the MASS branch and throws “unsupported unit” instead of the VOLUME branch;
- `un` reaches MASS and throws instead of COUNT;
- ml fails for the same reason;
- the UI exposes a free-text unit without a dimension control, so the domain cannot select its supported path.

This is a presentation-to-domain mapping defect, not absent domain-unit support. COUNT additionally rejects fractional values by design.

### Comma and dot parsing

Quantity parsing in `_parseDecimalMicrounits` accepts only a dot through `^(\\d+)(?:\\.(\\d{1,6}))?$`; commas are rejected for package quantity and purchased quantity. Money parsing in `PurchasePage._parseMinorUnits` explicitly replaces comma with dot and therefore accepts both up to two decimals. The normalization must be centralized at the UI/application boundary so Product creation, Purchase staging, corrections and future settings use one rule; stored quantity text should remain canonical dot-decimal.

### Product-code-only and exact-combination lookup

No application port exposes `findByCode` or `findByExactIdentity`. Catalogue search loads every Product and filters name/brand/code substrings in the widget. Purchase selection is a full dropdown. Therefore code-only lookup and complete-combination lookup are absent as operations.

Creation does perform two exact database checks:

1. exact identity key first returns the existing Product;
2. normalized Product-code collision then throws.

This partially satisfies collision reuse during creation, but does not let a caller resolve by code alone and does not return structured collision context. Exact identity key correctly distinguishes account, normalization version, normalized name/brand and mode; PACKAGED adds measurement kind, normalized package amount and canonical unit; BULK omits package facts. Internal ID, visible code and exact identity are distinct. There is no accepted correction/edit Product workflow, so stable-identity drift and correction collision checks remain unimplemented rather than validated.

### Similar spelling and exact collisions

`similarityWarnings()` lists all Products, builds a draft Product and uses edit distance/containment. It excludes exact identity and never auto-merges. UI offers “use existing” or “create anyway,” preserving advisory semantics. Its full-catalogue in-memory scan is an O(n) risk.

Exact identity collision returns an existing Product even if the submitted visible code differs; this can surprise the user and does not explain which Product won. Code collision throws `ArgumentError`. The UI catches all objects and collapses these distinct cases into generic text, so the existing Product is not reliably exposed to the user for every exact collision.

### Unclear registration failures

There is no typed application error catalogue. Domain, repository, Drift and state errors cross the port as exceptions. Purchase and Products pages catch `Object` and replace details with generic strings. `_PurchaseFeedback` has only message and error boolean: no stable code, title, field/operation, recovery action, or retryability classification.

A typed application catalogue is schema-free and currently sufficient. A database table would retain descriptive metadata without improving occurrence handling, while adding migration and privacy surface. No evidence requires it. Error occurrences must remain local/transient and must not enter pending events or analytics.

## 4. Schema and migration capacity

Drift schema v2 contains Accounts, Devices, Products, Stores, Purchases, PurchaseItems, local sync-preparation tables, and MigrationLedger. It has no Person, Payment Method, Product cycle/projection, export job, or error-description table. Purchases require a Store and contain no nullable organizational references.

The sole handwritten upgrade is v1→v2; any starting version other than 1 throws. The branch is selected by `from == 1` without an explicit `to == 2` chain. Before schema v3, representative v2 fixtures, sequential migration structure, uniqueness/backfill rules, rollback/no-silent-reset evidence, and generated Drift regeneration are required.

One optional Person and one optional Payment Method per Purchase is the smallest scope matching current evidence: two nullable foreign keys on Purchase, with immutable IDs and nickname plus active/archived state in separate local tables. Archiving must not invalidate historical references. Null must remain valid through registration, queries, Lists and export. Multiple people and split payments are deferred.

## 5. Export, share and package capacity

History currently supports one selected Purchase through ordinary tap and details; it has no checkbox/multi-selection model, keyboard selection action, double-click shortcut, action bar, Analytics command, CSV export, PDF creation, share integration, or edit/delete command. Current dependencies expose none of the required CSV/PDF/share capability. Export requires an application projection independent of UI widgets; PDF/share will require a dependency and platform capability review. The commands must remain read-only over registered Purchase facts.

## 6. Lists/cycle projection and performance

No Lists destination, cycle repository, cycle algorithm, Storage/Shortage/Market/All classification, expected-next-Purchase projection, remaining-time calculation, or explicit insufficient-history status exists. The only derived analysis is Product price change. It reads every observation for one Product without a limit, sorts/filters in application code, and History first loads 50 Purchases plus grouped counts.

A Lists implementation must derive from immutable Purchase/Product facts and explicitly classify insufficient history. It should avoid per-row detail/price queries and repeated full-table scans. Query budgets, indexes and paging require measurement, but likely risks are O(products × purchase-history), full-catalogue similarity scans, and unbounded per-Product price observations.

## 7. Platform and responsive evidence

Windows: inherited release build/startup evidence exists from prior cycles; no current C09 build or manual navigation/export/List smoke was run.

Android: earlier accepted evidence covers debug APK, one API 36 emulator launch/install, app-sandbox database observation, Device bootstrap and human-confirmed Purchase registration. C09 pages and schema do not yet exist and have no Android evidence.

Phone width: one 390×844 widget test verifies bottom navigation, local notice and empty History; another verifies selected destination across narrow/wide change. It does not complete the long Purchase form, test keyboard/Back/rotation/larger text/accessibility, new navigation density, row selection, details, Settings, Lists, export or PDF/share.

## 8. Schema-free versus schema-bearing work

Schema-free first:

- Home and bundled offline copy;
- accepted navigation shell and PIN placeholders;
- typed application errors and UI recovery mapping;
- comma/dot UI normalization;
- explicit dimension/unit controls wired to existing domain support;
- code/exact lookup application ports and repository queries using existing columns;
- Product details routes/actions;
- History accessible selection state and inactive Analytics action;
- CSV projection/serializer and export tests;
- Lists projection contract/algorithm prototypes derived from current facts;
- insufficient-history classification and performance fixtures.

Schema-bearing:

- Person and Payment Method tables;
- nullable single references from Purchase;
- schema v3 migration/ledger/generated Drift update;
- any indexes justified by measured lookup/List queries;
- persisted Product correction responsibilities only after identity/collision policy is accepted.

Dependency-bearing:

- PDF generation, system share/file-save integration and associated platform configuration.

No error table, persisted analytics occurrence, authentication, API, Neon, upload/download or convergence is justified.

## 9. Ordered implementation units

1. Freeze Product identity/correction semantics, Lists cycle rule, Person/Payment cardinality, and error taxonomy.
2. Add schema-free numeric normalization plus explicit MASS/VOLUME/COUNT and kg/g/L/ml/un UI controls; split PACKAGED package count from BULK amount/price-per-unit behavior.
3. Add code-only and exact-combination lookup ports/queries, collision result types, details actions and focused tests.
4. Add typed application failures and field/operation recovery presentation; prove no error analytics/event retention.
5. Expand navigation with Home landing, placeholder destinations and Catalogue rename/details while retaining responsive selection.
6. Add History accessible multi-selection and read-only action surface; implement CSV first.
7. Implement schema-free Lists projections and insufficient-history state against fixtures; measure query budgets.
8. Introduce schema v3 Person/Payment Method persistence and nullable Purchase references with upgrade fixtures.
9. Add PDF/share only after dependency/platform approval.
10. Run full regression, generated-code checks, file-backed migration/restart, Windows and Android/manual responsive validation.

## 10. Validation, recovery gates and stop conditions

Validation matrix:

- Domain: kg/g/L/ml/un, comma/dot equivalence, COUNT integrality, PACKAGED/BULK invariants.
- Repository: code lookup, exact lookup, similarity non-merge, exact/code collisions, correction collision, account scope.
- Migration: fresh v3 plus representative v2→v3, null backfill, archived-reference retention, failure rollback, no silent reset.
- Application/UI: typed error fields/retryability, draft retained after rejection, Product details via tap/button/keyboard, History multi-selection and read-only actions, CSV escaping/decimal/date encoding, insufficient-history Lists.
- Performance: bounded Product/history fixtures and query-count/time budgets before indexes.
- Platform: Flutter format/analyze/focused/full tests; Windows build and manual restart/export/PDF smoke; Android build/install/runtime, phone-width keyboard/Back/rotation/share; file-backed close/reopen.
- Privacy: no error occurrence, Person/Payment nickname, or payment secret leaves local persistence/export intent; export is explicit user action.

Rollback/recovery gates:

- preserve protected Python beta and existing Flutter database;
- back up representative v2 files before migration testing;
- never reset or recreate user data on upgrade failure;
- keep schema-free units independently revertible;
- gate dependencies and platform configuration separately;
- retain Purchase draft on retryable rejection.

Stop if identity policy is ambiguous; migration loses/rewrites Purchase/Product identity; null organizational fields block a workflow; exact collisions create duplicates; Lists invent projections; export mutates facts or leaks unselected data; typed errors require retaining occurrences; performance remediation demands unapproved schema; or platform work requires uncontrolled host mutation.

## 11. FLX-INV-02 claim classification

Retained:

- local-first Flutter/Drift boundary; protected Python beta; immutable Purchase facts; advisory similarity; schema v2; deferred authentication/API/Neon/synchronization/distribution.
- staged-line Product-reference edit is corrected within 7 focused/32 total/analysis evidence.

Corrected:

- L and un are not absent from the domain; they fail because UI supplies MASS universally.
- comma parsing is not uniformly absent: money accepts comma/dot, quantities accept dot only.
- exact collision handling exists during creation, but general exact/code lookup does not.
- phone-width evidence covers shell states, not complete mobile workflow acceptance.

Contradicted:

- accepted Cycle 09 navigation, Lists, History actions, details routes, Person/Payment settings and structured errors are not present in current source.
- current UI does not implement BULK-specific omission of packages bought or price-per-unit entry.

Unresolved:

- exact cycle algorithm/thresholds and status boundary;
- Product correction/code mutability and exact-collision UX;
- CSV/PDF field selection and save/share behavior;
- schema-v3 migration chain and index need;
- final error codes/retryability ownership;
- exact current remote parent SHA and local worktree/toolchain, due connector-only evidence boundary.

Prospective:

- schema-free vertical slice through units 2–7, then bounded v3 organizational metadata, followed by dependency-bearing PDF/share.

Deferred:

- multiple people, split payments, Purchase edit/delete, manual lists, persisted error analytics/table, authentication, TypeScript API, Neon, upload/download, convergence, production distribution and PySide6 retirement.

## 12. Main/human decisions and next handoff

Main/human authority is required to freeze:

1. cycle calculation and insufficient-history/status rules;
2. Product correction/code mutability and collision presentation;
3. one optional Person and one optional Payment Method per Purchase;
4. stable error taxonomy and retryability policy;
5. CSV/PDF contents, storage destination and share semantics;
6. PDF/share dependencies;
7. whether schema-free work is one Ordinary unit or split into navigation/input, identity/errors, History/export and Lists units;
8. schema-v3 migration and performance budgets.

Round improvement: the investigation reduces the unit failures to an explicit UI dimension-mapping defect, a quantity-only decimal-normalization gap, absent lookup ports, generic exception collapse, and clearly separated schema/dependency surfaces.

Next valid route: Main reconciles C09-R01 O/A/D into J and refreshes provisional D/E/F. FLX-INV-02 remains non-authorizing; no Codex/source authority exists until an explicit transition freezes controlling instructions.
