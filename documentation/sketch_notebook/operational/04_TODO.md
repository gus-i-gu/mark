# 04_TODO.md

> Version: Cycle 07 Sprint 03 preparation derivative 0.5
> Status: Active operational derivative
> Persistence Class: Derived
> Knowledge Class: Operational
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Branch: `cycle-07-mobile-preparation`
> Current checkpoint: `operational/10_OPERATIONAL_STATE.md`

---

# 1. Fast Recovery Card

```text
Flutter/Dart client basis: accepted for planning
TypeScript API: favored
Neon Postgres: favored
Sprint 02 planning/restaging/reconciliation: complete
experiment dependencies: provisional
implementation: not authorized
D/E/F: postponed
next target: Sprint 03 evidence preparation
```

# 2. P0 — Reproducible Environments

Before implementation authorization, specify and pin:

- Flutter channel/SDK and Dart versions;
- `pubspec.lock` policy and generated-code reproducibility;
- Visual Studio C++/Windows SDK requirements;
- Android SDK, build-tools, JDK, ADB, emulator image and physical-device expectations;
- TypeScript, Node, package manager and lockfile;
- disposable Postgres version and migration runner;
- later macOS/Xcode/iOS version boundary.

Capture clean-environment verification commands and failure classifications. Do not install them during this documentation phase.

# 3. P0 — Canonical Cross-Language Fixtures

Define versioned Dart/TypeScript JSON fixtures for:

- catalogue normalization and deterministic identity;
- PACKAGED versus BULK products;
- within-dimension unit equivalence;
- similarity warning without automatic merge;
- Purchase with one and multiple Purchase Items;
- currency and integer minor units;
- event envelope, UUID, device sequence, account cursor and stable errors;
- projection output;
- analytic identifier/version/result.

Specify nullability, enums, canonical decimal serialization, timestamp roles, unknown-field policy, protocol/schema versions, and semantic equality rules.

# 4. P0 — Local Persistence Comparison

Evaluate Drift first and retain `sqflite_common_ffi` as comparison. Required gates:

- fresh application-private database;
- schema creation and foreign keys;
- uniqueness for exact normalized identities;
- transactions and rollback;
- ordered migrations from representative prior schemas;
- release-mode native-library packaging;
- close/reopen after process termination;
- two isolated device stores;
- deterministic projection rebuild.

Candidate selection remains provisional until Windows and Android packaged evidence passes.

# 5. P0 — Secure Credential Storage

Evaluate the secure-storage candidate on Windows and Android for:

- create/read/update/delete;
- locked-device and unavailable-store failures where applicable;
- token rotation and logout deletion;
- corrupted entry recovery;
- application upgrade;
- backup/restore behavior;
- reinstall/uninstall behavior;
- secret redaction in logs.

Repeat on iOS only after macOS/Xcode becomes available. Do not describe package platform metadata as validation.

# 6. P0 — Atomic Local Purchase and Event

Prove in one local transaction:

```text
catalogue resolution/create
+ Purchase
+ one or more Purchase Items
+ pending purchase.registered event
+ device sequence allocation
```

Inject failure at each boundary. Pass only when all facts persist together or none do. The ordinary Cycle 06 database must remain unreachable and unchanged.

# 7. P0 — Local TypeScript Protocol Harness

Prepare a local TypeScript API with fake/test account identities and disposable Postgres. Required protocol gates:

- identical retry returns prior acceptance without duplicate;
- conflicting content under the same event UUID is rejected;
- device-sequence gap is rejected and missing sequence requested;
- cursor download is ordered and account-scoped;
- download event application and cursor advancement commit together locally;
- second device bootstraps from cursor zero in bounded pages;
- API/Postgres restart preserves accepted events/cursors;
- cross-account read/write is denied;
- malformed/version-incompatible events produce stable errors;
- request/batch/event correlation logs redact credentials and sensitive data.

# 8. P1 — Platform Evidence

Windows and Android evidence must include clean build, debug/release-relevant launch, local persistence, lifecycle/process-kill reopen, secure storage, fixture parity, protocol interaction, artifact diagnostics, and Cycle 06 isolation.

iOS remains a later independent gate requiring macOS/Xcode, Simulator/device, plugin validation, signing boundary, and the same persistence/security/protocol tests.

# 9. P1 — Neon Advancement Gate

Advance from disposable Postgres to a non-production Neon environment only after local protocol and migration gates pass. Then test TLS, roles, pooled application versus direct migration connections, cold start, transient failure, quotas, logs, migration rehearsal, rollback/recovery, and strict environment separation.

Neon remains favored, not validated or provisioned.

# 10. Completion Boundary

Sprint 03 preparation is ready for Main when the environment manifest, fixtures, validation matrices, failure injections, migration/rollback route, isolation assertions, and stop conditions can be converted into one bounded D/E/F unit.

Until then:

```text
no source implementation
no tool installation
no databases
no external accounts or infrastructure
no D/E/F
```

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
# Cycle 07 Sprint 05 — Remaining Operational Gates

> Inspected head: `ca53097b346ae42b216188dabc56a6eef45b051c`
> Evidence: `DEV_STAGE/G_OPS_CODEX.md`
> Main classification: J §24
> Implementation: inactive pending reconciliation/authority

## P0 — Supplemental Android lifecycle checklist

Run on the existing `Markei_Sprint05_API36` emulator with controlled data and without clearing app data:

- confirm the Purchase form remains usable with the keyboard open and closed;
- confirm focused/invalid fields remain visible;
- record Android Back behavior from Purchase and History;
- rotate portrait→landscape→portrait and record committed and unsaved staged state;
- background/resume and verify no duplicate or partial registration;
- test at least default and enlarged text scale for blocking overflow;
- register a controlled Purchase, confirm History, force-stop/terminate, relaunch, and confirm History again;
- register a second Purchase and verify the same Device UUID and monotonic sequence;
- record pass/fail, human-observed versus tool-observed evidence, screenshots/log references where permitted, and any bounded defect.

A source correction is not authorized by this checklist alone. If a failure requires code, stop and route a bounded Main patch.

## P0 — Close the evidence wording

- use “Purchase registration,” never “Purchase upsert,” unless update-or-insert behavior is later implemented;
- distinguish phone-width widget coverage from Android lifecycle evidence;
- distinguish database-row persistence from human-visible History-after-restart;
- retain emulator-only and debug-only qualifications.

## P1 — DevTools configuration disposition

Main/human must decide one later hygiene action for `clients/markei_flutter/devtools_options.yaml`:

1. retain and document it as intentional shared DevTools configuration; or
2. remove it and, if appropriate, ignore future local generation.

Do not alter it during permanent reconciliation. Any hygiene commit must inspect whether editor/DevTools workflows regenerate it and must update G-style scope reporting accurately.

## P1 — Host recovery and storage inventory

Before cleanup or reproduction, record:

```text
selected Flutter SDK revision
Android SDK root
installed SDK package list
AVD list and definition
license/doctor result
measured SDK, AVD, Gradle-cache, and build-output sizes
```

Preserve the current SDK and AVD until lifecycle evidence closes. Later cleanup must be separately authorized and remove only named SDK packages/AVDs through supported tools. Do not delete `C:\Users\gusrm\AppData\Local\Android\Sdk`, alternate Flutter clones, unrelated AVDs, or IDE settings wholesale.

## Deferred validation

- physical Android device;
- additional emulator/API/device classes;
- Android release build and production signing;
- install/upgrade/backup/restore/data-clear lifecycle;
- formal accessibility and final visual acceptance;
- Play Store;
- iOS;
- authentication, API, Postgres/Neon, and real synchronization.

## Closure boundary

Sprint 05 can close as Android debug-development parity only after the supplemental lifecycle checklist is recorded or Main explicitly narrows acceptance with the remaining items carried as named debt. Physical-device and release evidence remain later gates either way.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

# Cycle 08 C08-PB-01 — Remaining Operational Gates

> Branch: `cycle-08-shared-client-product-beta`
> Inspected implementation head: `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc`
> Evidence: `DEV_STAGE/G_OPS_CODEX.md`
> Paired staging: `DEV_STAGE/A_OPERATIONAL.md`
> Authority: permanent reconciliation complete; source work inactive

## P0 — Existing-Product edit defect

Route a bounded source/test correction for the existing-Product draft edit path:

- reproduce through similar-Product “Use this Product”;
- edit the staged line;
- preserve `ExistingProductReference`;
- save, review, and register;
- assert no empty/new Product draft is created;
- rerun focused and complete Flutter suites.

## P0 — Host validation

1. Configure or recover the approved Java/JDK environment without installing or deleting tools implicitly.
2. Rerun `flutter build apk --debug`; keep Android host-unvalidated until it passes.
3. Perform a manual Windows release launch and Purchase/Products/History smoke.
4. Run Android launch and lifecycle checks only after a successful artifact build and recognized target.
5. Preserve automated, build, manual runtime, lifecycle, and physical-device classifications separately.

## P0 — Widget-path completion

Add or extend evidence for:

- phone-width long-form Purchase registration;
- existing Product edit/save path;
- transient Product-creation success copy;
- loading/empty/error/retry states;
- draft retention across destination changes;
- larger text, keyboard/focus, overflow, and Back behavior.

## P1 — Repository hygiene

In a separate authorized commit:

- inventory tracked `__pycache__` and `.pyc`;
- confirm they are generated;
- remove only those artifacts;
- add/verify ignore policy;
- rerun Python regressions;
- verify no handwritten or user-data file is removed.

## P1 — Product-beta hardening

Still required:

- bounded Catalogue/History volume and query-cost evidence;
- migration-failure/no-silent-reset recovery;
- export/restore decision and restore evidence if called backup;
- Store duplicate/identity policy;
- durable idempotency decision;
- Device-installation relation timing;
- Windows/Android manual acceptance matrix.

## Deferred

Authentication/API/Neon/synchronization, iOS, production signing/distribution, physical-device breadth, PySide6 retirement, forecasting, and broad analytics remain deferred.

## Next route

```text
Operational/Didactic/Design permanent reconciliation
→ Main evidence reconciliation
→ bounded defect/host-validation staging if authorized
→ Codex correction and G/H/I
→ renewed PDR2
```

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.

# Intermid Cycle Recovery — Remaining Operational Gates

> Branch: `intermid-cycle-recovery`
> Corrected implementation: `409e5f1e013a282165efd5f31bed17a396ad6543`
> Evidence: `DEV_STAGE/G_OPS_CODEX.md`
> Main classification: latest `[M]_STAGE/J_MAIN_STAGE.md` post-Codex reconciliation
> Authority: permanent Operational reconciliation complete; implementation inactive

## Closed in this unit

- Existing-Product staged-line editing now preserves the original Product reference and label.
- Edited package count, quantity/unit, and line total reach registration.
- The existing Product row is reused and no duplicate Product is created.
- Focused widget suite passed with 7 tests.
- Full Flutter suite passed with 32 tests.
- Flutter analysis reported no issues.

This closure is local widget/repository regression evidence. It does not close platform, file-backed, manual, lifecycle, packaging, or release acceptance.

## P0 — Current-host and manual validation

1. Record exact Flutter/Dart, Java/JDK, Android SDK, Windows toolchain, and Python versions on the next validation host.
2. Rerun format, focused/full Flutter tests, Flutter analysis, Python regressions, and Windows build where authorized.
3. Perform a manual Windows Purchase → Products → History smoke.
4. Register through the app-private file database, close/reopen, and verify History without treating in-memory widget tests as restart evidence.
5. Configure or recover Java/Android tooling only under explicit host authority; then build, install, launch, and classify each Android gate separately.

## P0 — Persistence, migration, and atomicity

- add file-backed close/reopen evidence;
- add representative v1→v2 migration fixtures, collision handling, and no-silent-reset evidence;
- define the explicit migration chain before schema v3;
- inject failures across Product/Store resolution, Purchase, Items, device sequence, SyncEvent, and PendingEvent writes;
- verify all facts persist together or none do, with no sequence corruption;
- preserve the Cycle 06 Python database boundary.

## P0 — Remaining presentation and lifecycle evidence

- execute the long Purchase workflow at phone width;
- verify larger text, keyboard/focus, overflow, Back, rotation, background/resume, and cold relaunch;
- distinguish destination-mounted draft retention from process-death recovery;
- assert transient Product-success copy if it remains part of acceptance;
- retain separate classifications for widget, host, manual, lifecycle, physical-device, and release evidence.

## P1 — Repository hygiene

In a separately authorized unit:

- inventory tracked `__pycache__` and `.pyc`;
- identify the intended ignore-policy owner;
- remove only confirmed generated bytecode;
- rerun Python regressions;
- verify no handwritten source or user data is removed.

## P1 — Product-beta hardening

- measure Catalogue and History query/render cost before selecting indexes or pagination;
- decide Store duplicate/identity policy;
- decide durable submission identity and retry behavior;
- decide installation–Device lifecycle timing;
- define export/restore and corruption-recovery boundaries before calling the data backed up;
- keep local pending events classified as synchronization preparation only.

## Deferred

Deferred to later authorized cycles:

- schema v3 and unrelated database expansion;
- persistent Purchase drafts;
- authentication, API, Neon, upload/download, and multi-device convergence;
- iOS and physical-device breadth;
- production signing, distribution, backup/support contract;
- PySide6 retirement;
- forecasting and broad analytics.

## Next route

```text
Operational permanent reconciliation
→ Main reconciles refreshed domain checkpoints
→ select one bounded executable gate
→ controlling D/E/F
→ Codex materialization and G/H/I
→ renewed FLX-PRM-04 reconciliation
```

No source, host, schema, or staging authority is active.
