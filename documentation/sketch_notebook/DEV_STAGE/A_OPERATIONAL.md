# Operational State of Union — Cycle 07 Sprint 04

> Role: Operational Chat [O]
> Status: Temporary functional staging for Main reconciliation
> Repository: `gus-i-gu/markei`
> Branch: `cycle-07-mobile-preparation`
> Accepted baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Inspected remote head: `faf62fff1b3b9266934a8295891fd386e7d36371`
> Date: 2026-07-12
> Classification vocabulary: proposed, provisional, accepted, implemented, validated, host-unvalidated, blocked, deferred

## 1. Recovered Main State

Cycle 06 remains accepted and closed. Its Python/PySide6 Windows beta, one-folder distribution, per-user installer, external SQLite data, recovery evidence, and ordinary user database are protected. They remain the runnable behavioral reference, rollback boundary, and future migration source; nothing in Sprint 04 authorizes Flutter to open or convert that database.

Cycle 07 Sprint 03 Unit 01 is closed. The repository now contains an additive Flutter/Dart foundation, a fresh Drift schema, Dart domain and application boundaries, account-private catalogue concepts, an atomic Purchase/Purchase Item/event/queue transaction, versioned semantic JSON examples, and local unit evidence. Recorded execution used Flutter 3.44.6 and Dart 3.12.2; `flutter analyze` passed, nine Flutter tests passed, and five Python regression tests passed. Those results validate source-level and local-database behavior only.

Sprint 04 planning is active; implementation is inactive pending new D/E/F and human approval for exact host changes. Main’s accepted order is local-client correctness before synchronization: fix device sequencing, establish Unicode-safe versioned identity, harden contracts, implement the minimal multi-item Purchase interface and local history, prove close/reopen, then obtain Windows build/run evidence. Android build must be attempted when tooling is available, but full Android execution is not required for Sprint 04 acceptance. TypeScript API, Postgres/Neon, authentication, and real synchronization remain deferred.

## 2. Hierarchical Recovery Path

Recovery followed PRI-O and PMC-01, then the MSU-02 route:

`AGENTS.md → INDEX.md → PROMPT_COLLECTION.md/MSU-02 → latest J reconciliation → 00_PROJECT_STATE.md → latest 05_SESSION_LOG segment → active 06_SESSION_SCHEME.md → operational/10_OPERATIONAL_STATE.md → G_OPS_CODEX.md → bounded repository inspection`.

The Operational checkpoint was sufficient for the permanent-domain state. No read of `04_TODO.md`, `11_OPERATIONAL_RECORD.md`, or `12_OPERATIONAL_MODEL.md` was necessary: exact Sprint 04 defects and human decisions were more current in J and 06, while this task does not promote permanent memory.

## 3. Repository Surfaces Inspected

Protected Python beta evidence included root and application entrypoints, `app/core` models/contracts/services/repository/database/configuration boundaries, `app/database/schema.sql`, PySide6 dependency declaration, PyInstaller specification, and Python regression evidence. Its database manager resolves bundled schema separately from writable `%LOCALAPPDATA%/Markei`, configures SQLite foreign keys/WAL, performs idempotent column/table/default migrations, and exposes an explicit destructive reset function that must not be invoked during Flutter work.

Flutter evidence included `pubspec.yaml` and lockfile; `lib/main.dart`; the current one-label `MarkeiApp`; handwritten catalogue, identity, quantity, money, purchase, store, sync, analytics, use-case, Drift schema, and repository sources; local tests; and generated Android/iOS/Windows topology. Generated Drift and platform files were identified but not reviewed line by line.

Contract evidence included the three readable `contracts/shared_beta/v1` JSON documents. They coordinate examples but are not complete wire contracts and presently have no JSON Schema validation.

## 4. Operational Current State of Union

### Protected Python beta

The desktop beta is **accepted** and previously **validated** on Windows. Its run boundary remains `python main.py`; its package boundary is PyInstaller plus the existing installer/recovery procedure. The application database is persistence-specific and mutable at `%LOCALAPPDATA%/Markei/market.sqlite`. Repository methods commit individual writes, while database startup performs additive migrations. Operationally, this is a functioning reference, not a schema for Flutter reuse.

Regression cost remains: every Sprint 04 source unit must run the Python suite and prove the ordinary database path is neither opened nor changed. Because running the Python application can initialize or migrate the ordinary database, validation should use isolated test configuration where available and treat manual beta launch as a deliberate gate, not incidental setup.

### Flutter client

The Flutter project is **implemented** as a foundation and dependencies are locked. The app entrypoint is real, but presentation is only a static scaffold label; no user-visible Purchase workflow is implemented. Drift creates `markei_shared_beta.sqlite` in the platform application-support directory and enables foreign keys. Fresh creation and temporary-file close/reopen are **validated**; upgrade, failed-migration recovery, packaged path behavior, termination/relaunch, and concurrent lifecycle behavior are **host-unvalidated**.

The Purchase repository correctly groups account/store/product/Purchase/Items/event/pending-queue work in one Drift transaction and rollback evidence exists. However, it upserts a Device with `nextSequence: 1` before every allocation. Repeated registration can therefore reuse sequence 1. Monotonic device order is **defective**, not implemented. The schema also lacks an explicit account/device/sequence uniqueness gate.

Current Product persistence stores normalized name and brand but not separate display name, display brand, or the new user-designable opaque Product code. Normalization uses a `\w`-based policy whose Portuguese/Unicode behavior is unproven. The deterministic Product identifier is UUID-shaped but its standards/version contract and cross-language reproducibility are unvalidated.

### Host and toolchain

Flutter/Dart source tests were previously reproducible with the recorded SDK versions. Windows target files are generated, but Windows build/run is **blocked** on the inspected host by the missing Visual Studio 2022 Desktop development with C++ workload, MSVC tools, Windows SDK, and CMake integration. Android is **blocked** by the absent Android SDK/emulator/device setup. iOS is **host-unvalidated** and necessarily blocked on this Windows host until macOS/Xcode.

Tool installation is not authorized by this exploration. The forthcoming D/E/F must name exact installations, versions/components, commands, scope, expected evidence, and stop/rollback behavior. General permission to “install Flutter tools” is insufficient.

## 5. Agreement with J, 00, 05, and 06

Repository truth agrees with Main continuity that Flutter coexists additively with PySide6, Drift owns a fresh isolated store, local transaction and tests exist, and platform targets remain unrun. It also confirms the reported sequence reset, shallow contract examples, static UI, missing cloud stack, and protected Cycle 06 boundary.

The previous A report is stale because it describes Sprint 02 planning and proposes a Sprint 03 experiment that has already been partly materialized. This report supersedes that staging without changing permanent Operational memory.

One documentation drift remains in earlier portions of 00/06 that still describe Flutter physical implementation or D/E/F as not started; their appended Sprint 03 closure/Sprint 04 sections explicitly supersede those historical passages. Recovery must use the latest temporal section.

## 6. Drift, Defects, Contradictions, and Stale Documentation

- **Defective:** Device upsert can reset `nextSequence`; no repeated `1,2,3` proof or explicit sequence uniqueness.
- **Defective/provisional:** `\w` normalization may damage accented Portuguese identity; no normalization migration rehearsal.
- **Provisional:** Product ID format lacks fixed cross-language and standards evidence.
- **Missing:** user-designable opaque Product code and separate immutable record identity are not represented in current Flutter persistence.
- **Missing:** display name and brand are not stored separately from normalized identity.
- **Incomplete:** JSON examples omit executable type/range/nullability/additional-property/version rules and complete expected payloads.
- **Host-unvalidated:** Windows, Android, and iOS generated projects have not been built or run.
- **Untested:** Drift schema upgrade, interrupted migration, backup/restore, and failure recovery.
- **Missing:** Purchase UI, history/projection screen, process termination/relaunch evidence, and actionable user error handling.
- **Deferred:** authentication, secure token storage, TypeScript API, Postgres/Neon, upload/download, cursor bootstrap, and second-device synchronization.
- **Stale staging:** former A still treated Drift and Flutter as candidates rather than implemented Sprint 03 foundations.

## 7. Human Decisions Already Supplied

These are requirements for Sprint 04 planning, not empirical validation:

1. The private account catalogue exposes a user-designable opaque Product code.
2. That code is distinct from the immutable internal Product record identity.
3. A future central Product catalogue may assign a system-controlled UUID against the versioned Name + Brand + Package Quantity identification set; Sprint 04 must not collapse that future identity into the user code.
4. Sprint 04 adopts JSON Schema while retaining readable JSON examples.
5. Windows build and run are required.
6. Android build is attempted when tooling is available; full Android execution is not required for Sprint 04 acceptance.
7. Tool installation may be authorized only by forthcoming D/E/F with exact scope and validation.

## 8. Questions Requiring Main or Human Resolution

- What uniqueness and edit policy applies to the opaque user Product code within one account: required or optional, case-sensitive or normalized, reusable after retirement, and collision behavior?
- Does Sprint 04 retain the current deterministic account-private Product ID temporarily, or replace it with a random immutable internal UUID while reserving deterministic UUID semantics for a future central catalogue?
- Which Unicode normalization form, case-fold policy, punctuation/whitespace rules, and normalization-version migration are authoritative?
- Which JSON Schema draft and validator command are canonical, and which examples must be valid versus intentionally invalid?
- What exact Windows host modifications may D_OPS authorize, and is a clean-machine/package gate inside Sprint 04 or later?
- If Android tooling is unavailable, what evidence constitutes the precise accepted blocker: `flutter doctor -v`, SDK discovery, device list, and failed build transcript?
- What minimum visible history/projection is sufficient: raw registered Purchases, calculated totals, or a named rebuildable projection?
- What backup/recovery rule applies before the first Drift schema upgrade test?

## 9. Recommended Next Bounded Materialization Scope

Sprint 04 should remain one local, Windows-first vertical slice:

1. Correct device creation/allocation and add repeated, rollback, close/reopen, and uniqueness tests.
2. Define Unicode-safe normalization v2 fixtures, preserve display fields, and introduce the distinct opaque user Product code without confusing it with immutable record identity.
3. Add JSON Schema files plus readable valid/invalid catalogue, Purchase, and event examples; validate them locally.
4. Wire the existing application/repository boundary into a minimal responsive Flutter flow: create/select Store and Product, stage at least two Items, review totals, register atomically, display success and local Purchase history.
5. Terminate and reopen the application and prove facts, pending event, sequence, and displayed history persist.
6. Run locked analysis/tests and Python regressions.
7. Build and run Windows after explicitly authorized host setup.
8. Attempt Android debug build only when approved tooling is present; otherwise record the exact host blocker.

Do not combine TypeScript/Postgres work with this slice. Correct local events are a prerequisite for synchronization, and separating the units keeps failure diagnosis and rollback bounded.

## 10. Explicit Non-Goals

No authentication, secure-storage integration, API, Postgres/Neon, real synchronization, background work, editing/deletion, catalogue merge/alias, global catalogue materialization, household sharing, legacy import, ordinary database conversion, PySide6 retirement, app-store publication, production packaging claim, broad analytics expansion, or iOS acceptance.

## 11. Evidence Matrix

| Claim | Classification | Source |
| --- | --- | --- |
| Cycle 06 Python/PySide6 beta remains protected | accepted/validated | 00, 06, J, G; Python database/package surfaces |
| Flutter/Dart is the shared-client basis | accepted | 00, 06, latest J |
| Flutter foundation and Drift schema exist | implemented | `clients/markei_flutter`, G |
| Analysis and local tests passed | validated | G_OPS_CODEX |
| Atomic Purchase/Items/event/queue transaction | implemented/validated | repository source and local tests |
| Device sequence is monotonic | defective, not accepted | `local_purchase_repository.dart` |
| Unicode identity is stable | provisional | Product source and J |
| Product user code exists | proposed/required, not implemented | human decision; schema inspection |
| JSON Schema governs contracts | accepted for Sprint 04, not implemented | human decision; contracts inspection |
| Windows build/run works | blocked | G and 06 host prerequisites |
| Android build works | blocked/conditional | G and 06 |
| iOS works | host-unvalidated | generated project only |
| Flutter DB is isolated from Cycle 06 DB | implemented/local evidence | distinct paths and G |
| Drift upgrade/recovery is safe | host-unvalidated | schemaVersion 1/onCreate only |
| TypeScript API/Neon sync exists | deferred | 00, 06, G, repository topology |

## 12. Proposed D/E/F Gates

### D_OPS_STAGE

D_OPS should pin Flutter 3.44.6/Dart 3.12.2 or explicitly authorize an upgrade; list exact Visual Studio workload/components and any Android components; require pre/post `flutter doctor -v`; forbid unscoped installs; name all commands, expected exits, data paths, logs, and stop conditions; require no ordinary Cycle 06 database access; require Windows build/run and lifecycle evidence; define conditional Android build evidence; and require a changed-file audit.

Proposed command sequence, to execute only after authorization:

```text
cd clients/markei_flutter
flutter doctor -v
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
flutter run -d windows
python -m unittest discover -s tests
flutter devices
flutter build apk --debug
```

The Android commands are conditional on authorized available tooling. D_OPS must define how to capture the app-private database path, close/reopen result, sequence values, JSON Schema validation output, and original database isolation without exposing user data.

### E_DDC_STAGE

E should bind each new concept to observable evidence: opaque user code versus immutable record ID versus future central-catalogue UUID; Unicode normalization and version migration; JSON Schema validation; aggregate transaction; durable monotonic sequence; lifecycle persistence; generated project versus executed platform. It must not change KANBAN maturity merely because code is written.

### F_DSN_STAGE

F should name the exact authorized Flutter files and schema/fixture paths, settle Product identity/code fields and invariants, preserve dependency direction, define sequence uniqueness and allocation ownership, choose JSON Schema draft/validator boundaries, define the minimal projection, and prohibit source changes outside the local slice. It must keep Flutter storage physically separate and avoid API/cloud topology.

## 13. Operational Stop Conditions

Stop materialization if D/E/F disagree on Product identity, code uniqueness, normalization version, schema ownership, or permitted files; if host installation scope is vague; if the ordinary Cycle 06 database may be opened; if a migration can silently reset data; if sequence correction lacks rollback/reopen proof; if JSON Schema and examples diverge; if UI bypasses the application transaction; if Windows cannot build/run after the authorized prerequisites; or if scope expands into cloud synchronization or PySide6 retirement.

## 14. Handoff to Main

A is now current enough for Sprint 04 synthesis. Main should reconcile the user Product-code decision, internal/future UUID distinction, JSON Schema choice, Windows-required/Android-conditional acceptance, and exact tool-install authority into new D/E/F. Operationally, the cheapest defensible next unit is the corrected and schema-hardened local Flutter Purchase flow, proven on Windows with Cycle 06 isolation; Android is an attempted build when tooling exists, while TypeScript/Postgres and iOS remain later boundaries.
