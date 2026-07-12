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
