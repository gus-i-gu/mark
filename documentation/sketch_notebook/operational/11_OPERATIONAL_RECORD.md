# 11_OPERATIONAL_RECORD.md

> Version: Cycle 07 Sprint 02 observational record 0.4
> Status: Active observational history
> Persistence Class: Observational
> Knowledge Class: Operational
> Branch: `cycle-07-mobile-preparation`
> Scope: Chronological Operational recovery, materialization, validation, correction, and reconciliation evidence
> Truth boundary: Present rules belong to `12_OPERATIONAL_MODEL.md`, active work to `04_TODO.md`, and current state to `10_OPERATIONAL_STATE.md`.

---

# 1. Reading Rule

This file records what occurred. It does not independently define present Operational truth. Later reconciled canon and checkpoints govern when older observations become stale.

# 2. Recovery and Repopulation — 2026-07-10

The Operational domain was recovered on `sketch-notebook-recovery` after methodology boot from `INDEX.md` and the required methodology sequence.

The initial execution spine recovered was:

```text
main.py
→ app.main.main()
→ MainWindow
→ desktop pages
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

The first structural A stage was committed as:

```text
ce14d2549311f90144f95f0a54eafcbeb24bc126
```

An initial canonical promotion used an incorrect Main reference and was later replaced. The correct reconciliation route was restored through:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

Canonical, derived, and checkpoint reconstruction commits included:

```text
572f7043d2d721e70e6638713054b64237984661  corrected Operational canon
792a6bf32efb658127161e1a628f42a0731879f8  Operational TODO derivative
74e18af3fbedbf7508c4e808568681d5539fed40  first Operational checkpoint
72b6f6f2a6ca8506d1a4435a3f7d9558fec8142d  checkpoint routing correction
```

A temporary extra A-stage filename was created and later corrected. The durable routing rule remains that Operational Chat refreshes only `DEV_STAGE/A_OPERATIONAL.md` unless Main explicitly changes the file map.

The recovery also preserved the distinction between historical artifact success and coherent methodology-cycle closure. Main-branch Cycle 05 packaging claims were treated as history, not current recovery-branch validation.

# 3. Cycle 06 Sprint 01 — First Windows Release-Enablement Unit

## 2026-07-12 — Materialization and reconciliation

Sprint 01 changed or created:

```text
Markei.spec
scripts/build_windows.ps1
main.py
app/desktop/main_window.py
app/startup_diagnostics.py
requirements-build.txt
installer/Markei.iss
scripts/build_installer.ps1
tests/test_release_configuration.py
```

It established:

- `Markei.spec` as authoritative one-folder packaging source;
- schema-only production packaging;
- exclusion of seed, live database, WAL/SHM, logs, tests, and caches;
- per-user installer source and compile wrapper;
- startup diagnostics;
- focused release tests;
- bounded MainWindow shutdown coordination.

Observed toolchain:

```text
Python 3.14.6
PySide6 6.11.1
PyInstaller 6.21.0
```

Observed commands:

```text
python -m compileall app main.py       passed
python -m pytest                       blocked: pytest unavailable
python -m unittest discover -s tests  passed: 5 tests
scripts/build_windows.ps1             passed
scripts/build_installer.ps1           blocked: ISCC.exe unavailable
```

Frozen artifact evidence:

```text
dist\Markei\Markei.exe
SHA256 E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B
```

Focused shutdown validation initially failed because the isolated SQLite file remained open after `MainWindow.close()`. A bounded `MainWindow.closeEvent()` coordinator then closed all four page-owned services idempotently. Rerun evidence showed all repositories closed, the isolated database directory became removable, and immediate frozen reopen succeeded.

Sprint 01 ended with:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

Permanent Operational reconciliation was committed at:

```text
193a96e2202a649feb86d4259b626a8e553ad0cb
```

# 4. Cycle 06 Sprint 02 — Installer and Installed Lifecycle

## 2026-07-12 — Toolchain prerequisite resolved

Initial failure:

```text
scripts/build_installer.ps1
→ ISCC.exe not found
```

Inno Setup was installed through `winget`:

```text
JRSoftware.InnoSetup 6.7.3
```

Observed per-user compiler path:

```text
C:\Users\gusrm\AppData\Local\Programs\Inno Setup 6\ISCC.exe
```

Bounded correction:

```text
scripts/build_installer.ps1
→ add %LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe discovery
```

Rerun result:

```text
scripts/build_installer.ps1  passed
```

Inno Setup emitted a non-blocking warning that `x64` is deprecated and `x64compatible` is preferred.

## Structural production-default failure and correction

The fresh installed Register-equivalent workflow initially failed with:

```text
sqlite3.IntegrityError: FOREIGN KEY constraint failed
```

The schema-only production database lacked the category and store identifiers required by current Register defaults.

Bounded correction:

```text
category F / General
store 1 / Default Store
```

These rows were added idempotently through database compatibility handling. They are structural application defaults, not sample business data. Tests continue to require zero sample products and zero sample purchases.

After correction:

```text
python -m compileall app main.py       passed
python -m unittest discover -s tests  passed: 5 tests
scripts/build_windows.ps1             passed
scripts/build_installer.ps1           passed
```

## Sprint 02 artifact evidence

Frozen executable:

```text
dist\Markei\Markei.exe
SHA256 E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
size 2,173,220 bytes
```

Installer:

```text
dist\installer\Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

Distribution inspection confirmed `schema.sql` and excluded `seed.sql`, live database, WAL/SHM, and startup logs.

## Automated installed lifecycle evidence

Environment:

- current ordinary Windows user;
- existing `%LOCALAPPDATA%\Markei` backed up before lifecycle testing;
- original user state restored afterward;
- no dedicated clean account used.

Validated transitions:

```text
silent per-user install
→ installed executable under %LOCALAPPDATA%\Programs\Markei
→ Start Menu shortcut launch
→ external database creation
→ Register-equivalent ProductService persistence
→ Lists / History / Settings projection evidence
→ normal close
→ immediate reopen
→ same-version reinstall with retained data
→ uninstall with database retained
→ reinstall and retained-data recovery
```

Technical dataset evidence:

```text
category count  1
store count     1
product count   1
purchase count  1
product         T006 / Cycle 06 Test Product
quantity        2 unit
latest price    3.5
status          in-house
week boundary   wednesday
```

Installed close/reopen succeeded repeatedly, with `CloseMainWindow()` returning true and data remaining present.

## SmartScreen and antivirus boundary

Observed:

```text
Microsoft Defender enabled
real-time protection enabled
installer Authenticode: NotSigned
executable Authenticode: NotSigned
```

No SmartScreen prompt was observed during silent/programmatic execution. Human-visible SmartScreen behavior remains unknown.

## Evidence classification after Main reconciliation

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Human-visible installer wizard behavior, full visible Register/Lists/History/Settings walkthrough, visible close/reopen confirmation, SmartScreen interaction, and final human/Main acceptance remain pending.

# 5. Generated Installer Repository Contradiction

`G_OPS_CODEX.md` states that the installer was generated but not committed. Current branch evidence shows:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
blob SHA a586406f660e78a58ddf13cc09a061ddb7385269
```

The binary therefore exists in repository history. Operational classification:

```text
report statement: incorrect
repository state: generated installer binary committed
policy: generated release binaries should not remain ordinary source-controlled files
```

This documentation update does not remove the artifact. A separate authorized cleanup should remove it, add ignore coverage, and retain the binary through an approved release/artifact channel with its recorded hash and size.

# 6. Current Record Boundary

Sprint 02 technically completed the compiled-installer and automated installed-lifecycle route. Cycle 06 remains open because acceptance is a separate human/Main gate.

Retained debt:

- workflow atomicity across multi-commit user actions;
- Inno Setup `x64` deprecation warning;
- optional dedicated-account rerun if current-user evidence is later judged ambiguous;
- broader migration/reset failure validation;
- generated-artifact repository cleanup.

Future entries should record human-visible acceptance evidence, artifact cleanup, any bounded correction triggered by manual walkthrough, and final Cycle 06 closure.

# 7. Cycle 07 Sprint 01 — Mobile Portability Investigation and Reconciliation

## 2026-07-12 — Investigation boundary

Cycle 07 began on `cycle-07-mobile-preparation` from the accepted Cycle 06 closure baseline. Sprint 01 was investigation-only. No application code, framework project, toolchain, database, or ordinary desktop user data was modified or opened.

The investigation observed:

```text
reusable behavior exists
≠
the current desktop application is mobile-portable
```

Likely reusable surfaces were Python domain models, validation and calculation rules, workflow meanings, schema semantics, structural defaults, and deterministic desktop behavior as a fixture source. Coupled surfaces included concrete service/repository construction, SQLite lifecycle and global paths, presentation-shaped service projections, incomplete abstract contracts, and separately committed workflow mutations.

No Android/iOS runtime, package, lifecycle persistence, semantic-parity suite, accessibility behavior, or distribution path was demonstrated.

## Preserved pathway 1 — Operational challenger

Operational recorded a time-boxed Python-native Android experiment as the cheapest direct falsification test for existing Python reuse.

The apparent economy is direct: reuse the Python models, calculations, services, repository behavior, and possibly SQLite schema inside one Android package; initialize a fresh app-private store; execute one receipt workflow; close and reopen; verify persistence.

This pathway becomes expensive if the supposedly narrow experiment expands into broad construction refactoring, custom binary recipes, repeated SDK/NDK/JDK/WSL troubleshooting, native bridges, framework-specific lifecycle corrections, accessibility/platform-integration workarounds, or a separate iOS adaptation. Debugging may cross Python, framework runtime, packaging recipes, Gradle/Android tooling, and device behavior. An Android success would not prove iOS feasibility, maintainability, or distribution readiness.

Observed classification:

```text
cheapest direct experiment
bounded challenger
not final architecture evidence
not authorized
```

## Preserved pathway 2 — Design strategic direction

Design recorded a native/cross-platform client with explicit, language-neutral contracts and deterministic fixtures as the stronger current direction for maintained Android/iOS development.

Its cost begins earlier and is more visible: learn and configure another language/framework; establish Android and iOS SDK boundaries; reimplement relevant behavior and persistence; construct shared fixtures; and verify semantic parity with accepted desktop behavior.

That cost may reduce later expense when the mobile client has conventional ownership of navigation, accessibility, lifecycle, local persistence, packaging, and platform integration; contracts keep business facts separate from presentation labels; fixtures expose drift; and Android/iOS maintenance follows supported framework paths rather than a layered embedded-Python packaging boundary.

Android and iOS still have different operational environments. Android development may use Windows-supported tooling, while iOS build, signing, simulator/device, and distribution validation require macOS/Xcode. Cross-platform source does not remove separate platform gates.

Observed classification:

```text
stronger strategic candidate
higher initial setup and behavior-porting cost
potentially lower maintained-product cost
not empirically proven
framework not selected
not authorized
```

## Human/Main planning preference

Human/Main direction currently favors the Design pathway. This is recorded as a planning preference, not as empirical proof, framework acceptance, or implementation authorization.

The two pathways answer different questions:

```text
Operational:
What is the cheapest bounded experiment that can falsify direct Python reuse?

Design:
What architecture is strongest if mobile becomes a maintained Android/iOS product?
```

They remain preserved rather than collapsed into a false consensus.

## Unresolved cost assumptions

The following remain assumptions until measured:

- how much current Python behavior can execute unchanged in a mobile package;
- whether required construction and path seams remain narrow;
- how much business behavior a strategic client must reimplement;
- the cost of producing language-neutral contracts and golden fixtures;
- mobile SQLite/library maturity and migration ownership;
- suspend/resume and terminate/relaunch failure behavior;
- debugging cost across runtime and native-toolchain boundaries;
- accessible UI and platform-integration effort;
- Android-versus-iOS build and device differences;
- dependency upgrade and packaging maintenance over time.

A cheap prototype becomes expensive when success requires continuing exceptions, custom packaging, duplicated lifecycle work, or an architecture that cannot satisfy maintained-product requirements. A costly initial architecture reduces later cost only when its contracts, fixtures, persistence ownership, tests, and supported platform tooling actually prevent drift and repeated rework.

## Reconciliation result

```text
Cycle 06: accepted and closed
Cycle 07 Sprint 01: complete
strategic planning preference: Design pathway
bounded challenger: Operational Python-native Android experiment
backend: deferred
implementation authorization: none
D/E/F: postponed
next work: documentation, contract/fixture specification, and explicit later experiment gates
```

No stable Operational rule was promoted into `12_OPERATIONAL_MODEL.md` during this pass. The pathway comparison and cost assumptions remain observational; current state and active evidence gaps were refreshed separately.


# 8. Cycle 07 Sprint 02 — Flutter Shared-Beta Planning Reconciliation

## 2026-07-12 — Flutter client-basis supersession

Human/Main established Flutter/Dart as the primary planning basis for the maintained Windows/Android/iOS client. This superseded the earlier TypeScript-client exploration direction only at the client boundary.

TypeScript retained a favored role for the custom synchronization API and protocol harness. Neon Postgres remained favored managed shared persistence. Python/PySide6 remained the accepted Cycle 06 application, reference behavior, legacy migration source, and rollback. No embedded Python runtime or cross-language client IPC bridge was accepted.

## Domain-report reconciliation

Operational, Didactic, and Design restaging converged on:

```text
Flutter/Dart shared client
→ application-private local persistence
→ account-private reusable catalogue
→ atomic Purchase + Purchase Items + pending event
→ authenticated TypeScript synchronization API
→ Neon Postgres accepted account-scoped event history
```

The reports also preserved language-neutral JSON contracts, deterministic fixtures, immutable event/device/account identities, idempotent retry, per-device ordering, account-scoped cursor download, transactional local application, versioned analytics, and protected Cycle 06 data.

This was planning reconciliation only. No Flutter project, Dart model, TypeScript API, Postgres schema, authentication integration, external account, or infrastructure was created.

## Operational experiment candidates

The first persistence candidate for a later bounded experiment is Drift because its documented feature set aligns with transactions, migrations, typed queries, tests, and the three target platforms. `sqflite_common_ffi` remains a comparison candidate.

`flutter_secure_storage` is a credential-storage candidate for packaged evaluation. Its advertised targets do not establish secure or correct behavior for Markei. Backup, upgrade, logout, reinstall, token rotation, and platform-specific failure behavior remain untested.

The favored local protocol environment is:

```text
Dart fixtures + two isolated local stores
TypeScript API
disposable local Postgres
fake/test identity issuer
structured correlation logs
```

A later Neon test environment is permitted only after local protocol proof.

## Platform validation direction

Windows and Android are the first paired evidence targets because the current development context can address them without claiming iOS parity. Required evidence includes clean build/run, fresh local database, aggregate/event atomicity, close/reopen, secure storage, fixture parity, sync retry/gap/cursor/bootstrap/account isolation, and proof that the Cycle 06 database remains untouched.

iOS remains an explicit macOS/Xcode boundary. No iOS compatibility, plugin behavior, package, signing, Simulator/device, or lifecycle evidence exists.

## Evidence classification

```text
Flutter/Dart client basis: accepted planning decision
TypeScript API: favored planning decision
Neon Postgres: favored planning decision
Drift: first experiment candidate
sqflite_common_ffi: retained comparison
flutter_secure_storage: candidate
Windows/Android compatibility: assumption until execution
iOS compatibility: unvalidated pending macOS/Xcode
implementation/infrastructure evidence: none
D/E/F: postponed
```

Next Operational evidence target is Sprint 03 preparation: pinned environments, canonical fixtures, isolated local persistence, atomic Purchase/event, local TypeScript/Postgres protocol failures, Windows/Android execution, Cycle 06 isolation, and later iOS/Neon gates.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
# Cycle 07 Sprint 03 Unit 01 — Flutter Foundation Materialization

## 2026-07-12 — Environment and materialization

The authorized Sprint 03 Flutter Foundation was materialized on `cycle-07-mobile-preparation`.

Initial host state:

```text
flutter: unavailable
dart: unavailable
Android SDK: unavailable
Visual Studio C++ desktop workload: unavailable
macOS/Xcode: unavailable
```

After human-approved setup:

```text
Flutter 3.44.6 stable
revision ee80f08bbf
Dart 3.12.2
Windows host detected
Android/Windows build prerequisites incomplete
iOS host unavailable
```

Created implementation surfaces included:

- `clients/markei_flutter/` with Android, iOS, and Windows target directories;
- handwritten Dart domain/application/infrastructure source;
- Drift schema and generated `local_database.g.dart`;
- committed `pubspec.lock`;
- `contracts/shared_beta/v1/` semantic JSON examples.

## Commands and results

```text
flutter create                                      passed
flutter pub get                                     passed
dart run build_runner build --delete-conflicting-outputs  passed
dart format                                         passed
flutter analyze                                     passed, no issues
flutter test                                        passed, 9 tests
python -m unittest discover -s tests                passed, 5 tests
```

The tests evidenced exact packaged/bulk normalization examples, warning-only similarity behavior, dimensional quantity and money structures, atomic Purchase + Items + event + pending queue registration, invalid-item rollback, temporary-file close/reopen persistence, and a minimal analytic registry.

## Generated versus handwritten ownership

```text
handwritten Dart
    reviewed directly

Drift-generated Dart and Flutter platform runners
    reviewed through generator input/configuration
    plus clean regeneration/build evidence

pubspec.lock
    committed dependency-resolution evidence

build outputs and local databases
    generated runtime artifacts, not source truth
```

## Host limits and skipped scope

Android/iOS/Windows directories were generated but none was built or run. Windows was blocked by the missing Visual Studio desktop workload; Android by the missing SDK; iOS by the non-macOS host. No platform lifecycle claim was established.

TypeScript API, authentication/authorization, Postgres/Neon, actual upload/download, cross-device convergence, legacy import, full Purchase UI, and PySide6 retirement were skipped/deferred.

The Flutter implementation did not discover, open, copy, rename, migrate, hash, or inspect the ordinary Cycle 06 database. Python regression execution produced no tracked database change.

## Evidence-triggered defects and risks

Main reconciliation identified:

1. likely device-sequence reset/reuse on repeated registration;
2. missing account/device/sequence uniqueness evidence;
3. `\w`-based normalization risk for accented Portuguese text;
4. deterministic Product ID without fixed cross-language/RFC contract;
5. shallow Purchase/event fixtures rather than complete wire schemas;
6. unrehearsed Drift schema evolution and ambiguous ledger timestamp meaning;
7. exact-name-only Store reuse and no Store deduplication model.

These remain unresolved. Monotonic ordering, Unicode-safe identity, complete protocol contracts, platform execution, and distributed synchronization must not be described as validated.

## Main route orientation

J §19 favors a local shared-client vertical slice before the synchronization harness, with sequence correction and contract hardening first. This is Main orientation, not Sprint 04 implementation authority.

# Cycle 07 Sprint 04 — Operational PDR2 Reconciliation

## 2026-07-12 — Evidence reconciled

PDR2-O reconciled the Sprint 03 Operational Codex report, J §21, Sprint 04 A staging, current Flutter/Python source truth, and all four permanent Operational roles at branch head `32898f56f76895dc0f23d72cd132bcc24830e740`.

Confirmed execution evidence remains:

```text
Flutter 3.44.6 / Dart 3.12.2 installed
flutter pub get passed
Drift generation passed
format passed
flutter analyze passed
flutter test passed: 9
Python regression tests passed: 5
fresh Drift schema and temporary-file close/reopen passed
Windows build/run blocked by missing Visual Studio native-desktop workload
Android build/run blocked by absent SDK/device tooling
iOS host-unvalidated outside macOS/Xcode
```

Repository inspection confirmed that the Flutter presentation remains a foundation label; the local schema remains version 1; Device upsert can reset `nextSequence`; Product display fields and user Product code are absent; normalization v1 remains unsafe for Portuguese/Unicode identity; v1 JSON documents remain examples without executable schemas; and TypeScript/API/Postgres/Neon/authentication/synchronization remain absent. The Flutter store remains distinct from the protected Cycle 06 database.

J §21 accepted the Sprint 04 planning resolution: UUID v4 for new immutable internal Product identities; required account-private user Product code; Unicode NFKC normalization v2 with preserved display text; `shared_beta/v2` using JSON Schema Draft 7 and readable examples; Drift schema v2 migration; sequence uniqueness and 1,2,3 recovery proof; minimal multi-item UI/history; Windows build/run; conditional Android build only if tooling already exists. These are accepted instructions for forthcoming D/E/F, not implementation evidence.

No commands, installations, migrations, builds, tests, or application executions were performed during this reconciliation. No source or user database was modified.

# Cycle 07 Sprint 05 — Android Materialization and PDR2 Confrontation

## 2026-07-12 — Host, build, runtime, and regression evidence

PDR2-O reconciled `G_OPS_CODEX.md`, J §24, Sprint 05 A and D, repository comparison from `c2d74e445a6c7819b9c36573f6d63836d990c471`, current Android/Dart/tests, and all four permanent Operational roles at inspected head `ca53097b346ae42b216188dabc56a6eef45b051c`.

Host/tool evidence:

```text
selected Flutter SDK: H:\Users\Gus\develop\flutter
alternate C:\Users\gusrm\flutter: inspected, not modified
Android Studio: 2026.1.1.10 installed
Android SDK: C:\Users\gusrm\AppData\Local\Android\Sdk
Platform / target: Android 36
Build-Tools: 36.0.0
CMake: 3.22.1
NDK: 28.2.13676358
system image: android-36 google_apis x86_64
AVD: Markei_Sprint05_API36
licenses: accepted with human confirmation
flutter doctor: Android toolchain healthy
```

Materialized runtime identity includes `com.gusigu.markei`, label `Markei`, the moved Kotlin host, compile/target SDK 36, asynchronous composition bootstrap, and a Drift-backed UUID-v4 Device identity that is reused after database reopen. The repository contains tests for fresh identity, reopen reuse, distinct databases, monotonic sequence, historical non-UUID preservation, and a phone-width Purchase/History flow.

Validation evidence:

- formatting and analysis passed;
- 27 Flutter tests passed;
- debug APK built, badging inspected, installed, and launched;
- API-36 emulator booted as the intended target;
- app-private database observed at `/data/data/com.gusigu.markei/files/markei_shared_beta.sqlite`;
- runtime database contained one UUID-v4 Device, `next_sequence = 2`, and one Purchase;
- human confirmed Purchase registration on the emulator;
- Windows release build passed;
- five Python regressions passed;
- Cycle 06 source/database isolation remained reported.

The accepted operation is **Purchase registration**. G's phrase “purchase upsert/registration” is corrected here: source evidence does not support mutable Purchase replacement and “Purchase upsert” is not accepted terminology.

## Evidence limits and required supplement

ADB-driven form entry was blocked by emulator input/stylus overlays and Gboard behavior. Launch, force-stop/relaunch, database inspection, and the human registration prove a meaningful Android-local slice, but do not provide a complete checklist for keyboard obstruction, Android Back, rotation, background/resume, text scale, staged-state behavior, or a human-visible History check after process restart. Physical-device, Android release/signing, upgrade, backup, accessibility, and Play Store evidence are absent.

A supplemental Android lifecycle checklist is therefore required before Sprint 05 closure. It is evidence-first: no source change is authorized unless the checklist exposes a bounded defect and Main separately routes that correction.

## Repository/report contradiction

G says `clients/markei_flutter/devtools_options.yaml` was preserved untracked and not committed. Repository comparison shows it was added as a three-line DevTools extension configuration file. It has no enabled extension and no demonstrated build/runtime effect, but G's scope statement is inaccurate.

Intentional project ownership is not established. The file remains committed during this documentation pass. Main/human should later choose either to retain it as explicit shared DevTools configuration or remove/ignore it in a bounded hygiene change. No source cleanup is implied by PDR2-O.

## Installed-environment recovery and cost

The Android SDK and AVD are reproducible from the recorded component/version manifest; they are not source artifacts. Exact disk consumption was not recorded, so storage cost remains unknown. The system image, emulator, NDK, CMake, build tools, and Gradle caches are expected to be the major host-storage consumers, but no numeric cost is promoted.

Preserve the SDK and AVD until the lifecycle supplement is complete. Later recovery or cleanup must inventory installed SDK packages and AVDs first, remove only named components through supported SDK/AVD tooling under explicit authority, and never delete the whole SDK directory or unrelated user configurations merely to reclaim space.

No commands, installations, runtime actions, or source changes were performed by this reconciliation.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

# Cycle 08 C08-PB-01 — Operational PDR2 Reconciliation

## 2026-07-13 — Materialization and evidence classification

PDR2-O reconciled A, G, latest J orientation, repository comparison from directive head `4f5ef21cb0d31f5efbf386b3e51cff15c543a802` to implementation head `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc`, current Flutter source/tests, and all four permanent Operational roles.

Implemented repository behavior includes responsive Purchase/Products/History navigation; Product browse/search/create and advisory reuse/create-anyway; existing/new Store references; a session-only keyed Purchase draft with edit/remove/review; in-flight duplicate-submit mitigation; detailed History; and compatible same-Product price-change calculation. The existing atomic Drift registration transaction remains unchanged.

Validated automated evidence:

- focused Flutter widget path: 6 tests passed;
- Dart formatting: 34 files checked, none changed;
- Flutter analysis: no issues;
- complete Flutter suite: 31 tests passed;
- Windows release build produced `build\windows\x64\runner\Release\markei.exe`;
- Python regressions: 5 tests passed.

Evidence limits:

- the Windows artifact build passed, but no manual Windows launch or workflow smoke was performed;
- Android APK build is host-unvalidated because `JAVA_HOME` is unset and `java` is unavailable in `PATH`;
- Android runtime, keyboard, Back, rotation, background/resume, restart, and physical-device behavior were not revalidated for this materialization;
- phone-width automated coverage checks shell/local/empty states, while the long-form registration path is covered only at wide width;
- Product creation success is visible in repository/list state, but transient success copy is not asserted;
- duplicate-submit handling is mounted-session busy-state mitigation, not durable idempotency;
- export/restore, corruption recovery, performance budgets, production signing, distribution, and synchronization remain absent.

Repository comparison records tracked validation artifacts:

- `app/__pycache__/__init__.cpython-314.pyc`;
- `app/__pycache__/startup_diagnostics.cpython-314.pyc`;
- `app/core/__pycache__/config.cpython-314.pyc`;
- `app/core/__pycache__/database.cpython-314.pyc`;
- `tests/__pycache__/test_release_configuration.cpython-314.pyc`.

These are generated bytecode, not source truth. They were preserved because materialization prohibited cleanup. Removal and ignore-policy correction require a separate bounded hygiene change.

Source inspection found one existing-Product edit defect in `PurchasePage`: when a staged line was created by selecting a similar existing Product, `_editLine` restores quantity/price fields but not the existing Product selection/reference. The editor can fall into the new-Product path with cleared Product fields, so saving the edited line does not reliably retain the same existing Product. This defect is not covered by the six focused widget tests and remains blocked pending a bounded source fix.

No permanent reconciliation command rebuilt, launched, installed, migrated, or modified application data.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


## 2026-07-14 — Intermid Recovery existing-Product edit correction

Sequence: `FLX-PRM-04`  
Implementation commit: `409e5f1e013a282165efd5f31bed17a396ad6543`  
Reconciliation baseline: `84fc6e4e49dedc7ce629a97a78dd86486dbf0cf8`  
Evidence: `DEV_STAGE/G_OPS_CODEX.md`, latest `J_MAIN_STAGE.md` post-Codex reconciliation, repository source and widget regression

The bounded D/E/F unit corrected the staged-line edit path for an existing Product. Edit state now retains the original `ProductReference` and Product label while package count, purchased quantity/unit, and line total remain editable. Saving reuses the retained existing Product identity; the regression asserts that registration keeps the original Product ID and does not create a duplicate Product row.

Observed materialization scope:

```text
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/test/app/markei_app_test.dart
DEV_STAGE/G_OPS_CODEX.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/I_DSN_CODEX.md
```

Recorded command outcomes from G:

```text
dart format touched Dart files                 passed
flutter test test/app/markei_app_test.dart    passed: 7 tests
flutter test                                  passed: 32 tests
flutter analyze                               passed: no issues
```

Intermediate focused-test failures occurred while shaping the regression and were resolved before final validation. They are development chronology, not final blockers.

PRC-01 disposition:

- existing-Product edit defect: prior defective state superseded; corrected implementation accepted;
- existing-Product identity retention: validated by the named widget/repository regression;
- edited Item values and absence of duplicate Product: validated within the in-memory widget integration boundary;
- generic `ProductReference` retention for new-Product lines: implemented by source structure, but not separately regression-validated;
- Windows, Android, iOS, file-backed restart/migration, manual workflow, lifecycle, packaging, release, and distribution acceptance: unchanged and not established by this unit;
- schema, migration, dependency, synchronization, transaction-failure infrastructure, and generated-artifact behavior: unchanged.

No source, host, schema, migration, dependency, or permanent non-Operational surface was changed during this reconciliation.


---

## 2026-07-14 — Cycle 09 C09-U02 Operational reconciliation

Sequence: `FLX-PRM-04`  
Implementation commit: `e37cb700feeca4001cc7835b584c46bb81926af3`  
Instruction baseline: `06714d719c22ebd6b64008b7dcec745faee8fcd5`  
Sources: Cycle 09 A, controlling D, G, post-Codex J, implementation diff and targeted source/test inspection  
Evidence boundary: Codex-host commands plus repository inspection; this reconciliation reran no Flutter, platform or host command

Materialization changed 35 paths: 32 Flutter source/test paths and G/H/I. The protected Python/PySide6 source and database were unchanged.

Implemented repository evidence includes schema v3; People, Payment Methods and Account preferences; nullable Purchase references; nullable BULK package count; Product normalization v3; sequential v1/v2 migration handling; typed application failures; comma/point quantity parsing; kg/g/L/ml/un handling with fractional COUNT rejection; exact Product lookup ports; Home-first navigation; Lists projections; Catalogue details; Settings; History selection; deterministic selected-Purchase CSV; and PDF-byte generation/local save.

Recorded validation from G:

```text
flutter pub get                                      passed
Drift/build_runner regeneration                     passed
dart format lib test                                passed
flutter test                                        passed: 39
flutter analyze                                     passed: no issues
git diff --check                                    passed; CRLF notices only
python unittest release configuration               passed: 5
flutter build windows                               passed
Windows bounded five-second process launch          passed
flutter build apk                                   host-blocked: Java/JAVA_HOME absent
pytest                                              unavailable on Codex host
```

PRC-01 dispositions:

- schema v3, migration routes, local reference storage, quantity normalization, projection/export code and navigation: **implemented**;
- 39 Flutter tests and clean analysis: **validated within automated Codex-host scope**;
- Windows release artifact and bounded launch: **validated as build/smoke only**, not manual workflow or lifecycle acceptance;
- Android: **host-unvalidated**, not a product failure;
- Python: five repository `unittest` regressions passed; pytest coverage remains unavailable;
- BULK nullable package count: **implemented**; required price-per-unit entry/half-up total derivation: **contradicted as completed** because UI still requests Line total;
- PDF bytes/local temporary-file save: **implemented**; native/save-destination sharing: **partial/deferred**;
- typed `AppFailure` infrastructure: **implemented**; consistent user-facing code/field/recovery/outcome presentation: **partial** because pages still collapse many errors into generic copy;
- exact Product lookup ports: **implemented**; explicit exact-lookup Catalogue workflow: **partial** because visible search remains substring filtering;
- History checkbox/tap selection: **implemented**; select-all and desktop double-click shortcut: **not found**;
- Product detail panel: **implemented** through tap/long-press; shared adaptive detail route and desktop double-click: **not found**;
- active nickname uniqueness: **partially contradicted** because `(accountId, normalizedNickname, active)` also limits duplicate archived nicknames;
- Product codes: creation/migration populate them, but schema columns remain nullable; no database NOT NULL invariant is accepted;
- full manual Windows workflow, Android, dense phone-width UX, migration failure injection and native sharing: **unvalidated or absent**.

Deferred boundaries remain authentication, API/Neon/synchronization, external analytics, Product correction/merge, Store redesign, SubmissionId, persisted drafts, registered Purchase mutation, native share, Household behavior and production release.

No source, methodology, Main continuity or non-Operational memory changed during this reconciliation.
