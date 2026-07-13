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
