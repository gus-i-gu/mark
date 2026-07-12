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
# Cycle 07 Sprint 04 — Active Operational Gates

> Reconciled at implementation head `32898f56f76895dc0f23d72cd132bcc24830e740`
> Authority: planning accepted in J §21; execution awaits new D/E/F

## P0 — Safe host preflight

- pin or explicitly revise Flutter 3.44.6 and Dart 3.12.2;
- authorize only the exact Visual Studio 2022 Native Desktop workload/components;
- capture `flutter doctor -v` before and after host change;
- do not install Android tooling in this unit;
- if Android tooling already exists, capture `flutter devices` and attempt a debug build;
- keep iOS deferred to macOS/Xcode.

## P0 — Sequence and schema-v2 migration

- stop Device registration from overwriting existing `nextSequence`;
- add account/device/sequence uniqueness;
- prove 1, 2, 3 across repeated registration and close/reopen;
- rehearse Drift v1→v2 from fresh and representative v1 stores;
- preserve Product and Purchase references and pending events;
- backfill temporary account-unique legacy Product codes without inventing meaning;
- record migration execution using runtime time;
- prove failed migration leaves prior state or a recoverable copy.

## P0 — Product identity and contract gates

- preserve display name and brand;
- create immutable UUID-v4 internal IDs for new Products;
- add required account-scoped user Product code and normalized uniqueness key;
- implement normalization v2 using NFKC, case conversion, whitespace collapse, documented punctuation, and accent preservation;
- retain v1 identities without silent reinterpretation;
- create `contracts/shared_beta/v2/` with Draft 7 schemas and readable valid/invalid examples;
- run Dart structural validation and separate domain-invariant tests.

## P0 — Local user workflow and lifecycle

- replace the foundation label with the bounded multi-item Purchase form;
- use the existing application/repository transaction rather than widget-owned SQL;
- show success/error state and local history with ID, time, Store, currency, total, and item count;
- prove application-support database path, termination/relaunch, sequence persistence, facts, queue, and history;
- verify the ordinary Cycle 06 database remains untouched.

## P0 — Required validation

```text
flutter doctor -v
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
flutter run -d windows
python -m unittest discover -s tests
```

Record versions, exit results, generated-source diff, database paths, lifecycle observations, and changed-file scope. Windows build and launch are required. Android is a conditional build attempt only when tooling already exists.

## Deferred

Authentication, secure token storage, TypeScript API, Postgres/Neon, real synchronization, central catalogue assignment, Product-code editing/retirement, legacy import, iOS, production packaging, and PySide6 retirement remain deferred.

## Stop conditions

Stop on ambiguous tool-install scope, Cycle 06 database access, migration data loss, sequence reuse, schema/example divergence, UI bypass of the transaction boundary, unexplained generated diffs, Windows build/run failure after authorized prerequisites, or expansion into deferred work.
