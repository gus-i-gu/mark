# 06_SESSION_SCHEME.md

> Version: Cycle 07 Sprint 04 forward checkpoint 0.4
> Status: Active Forward Checkpoint
> Persistence Class: Forward Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Working branch: `cycle-07-mobile-preparation`
> Baseline commit: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Current-state source: `00_PROJECT_STATE.md`
> Historical source: `05_SESSION_LOG.md`
> Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md` sections 19–20
> Cycle target: complete and execute the first local shared Flutter client workflow without destabilizing the accepted PySide6 beta

---

# 1. Entry State

Cycle 07 Sprint 02 is closed.

Completed:

```text
portable-core investigation
→ shared-application product direction
→ custom API + Neon direction
→ reusable catalogue
→ Purchase / Purchase Item aggregate
→ dimensional quantity and minor-unit money
→ append-only synchronization semantics
→ Flutter/Dart shared-client selection
→ TypeScript API preference
→ permanent Operational reconciliation
→ Didactic KANBAN promotion
→ permanent Design architecture reconciliation
→ Main-root refresh
```

Not materialized:

```text
Flutter project
Dart domain models
physical local schema
canonical fixture package
TypeScript API
physical Postgres schema
auth provider
Neon project
Windows/Android Flutter evidence
iOS evidence
legacy importer
D/E/F or G/H/I for Sprint 03
```

---

# 2. Sprint 03 Milestone

> Materialize and validate the first isolated Flutter/Dart local vertical slice and its fresh catalogue/purchase schema, while preserving the complete Python/PySide6 beta and preparing—but not yet requiring—the synchronization API boundary.

Sprint 03 should establish:

```text
isolated Flutter structure
→ Dart domain contracts
→ deterministic shared fixtures
→ fresh application-private local database
→ account-private reusable catalogue
→ atomic Purchase + Purchase Items + pending event
→ derived projection/analytics registry
→ close/reopen persistence
→ Windows and Android evidence
→ original Cycle 06 data untouched
```

A later Sprint 03 unit may introduce the local TypeScript/Postgres protocol harness only after the local Flutter model passes.

---

# 3. Transition Strategy

The transition is additive, not a rewrite-in-place.

```text
Existing Python/PySide6 implementation
    remains runnable
    remains packageable
    remains recoverable
    remains migration source
    remains rollback

New Flutter/Dart implementation
    uses fresh application-private data
    receives no privileged cloud credentials
    does not import Python runtime
    does not open the ordinary Cycle 06 database
    proves behavior through fixtures
```

No source file should be moved, renamed, or deleted merely to make room for Flutter.

The first D/E/F synthesis must authorize an exact repository layout before scaffolding. The intended responsibility topology is:

```text
existing Python desktop boundary
new Flutter shared-client boundary
language-neutral contracts/fixtures boundary
future TypeScript sync-API boundary
Sketch Notebook boundary
```

Candidate directory names are implementation decisions and must not be invented by Codex without D/E/F authorization.

---

# 4. First Materialization Units

Sprint 03 should be divided into bounded units.

## Unit 1 — Repository and toolchain isolation

Authorize:

- exact Flutter project path;
- pinned Flutter/Dart version;
- lockfile policy;
- Windows and Android host prerequisites;
- clean source-control scope;
- proof that Python entry points and tests remain unchanged;
- no iOS acceptance claim.

Pass:

```text
Flutter toolchain recorded
Flutter project analyzes/tests
Windows debug launch
Android emulator/device debug launch when available
Python beta still runs/tests
working tree contains only authorized scope
```

## Unit 2 — Contracts and fixtures

Define language-neutral fixture behavior for:

- packaged Product normalization;
- bulk Product normalization;
- exact identity equivalence;
- advisory fuzzy similarity;
- deterministic Product UUID candidate;
- one-item Purchase;
- multi-item Purchase;
- invalid Item rollback;
- dimensional quantity;
- minor-unit money;
- pending event envelope;
- projection/analytics version.

Pass requires identical expected semantics in fixture data independent of Python, Dart, or TypeScript classes.

## Unit 3 — Fresh Flutter-local schema

Materialize a new schema for the Flutter client. Do not modify the Cycle 06 schema in place.

Logical responsibilities:

```text
local account context
device identity and next sequence
Products
Stores
Purchases
Purchase Items
immutable events
pending upload queue
applied event identities
last account cursor
rebuildable projections
migration/import ledger
```

Physical table names, migration framework, and plugin APIs require D/E/F.

## Unit 4 — Local vertical slice

```text
initialize fresh local store
→ stage Purchase
→ select/create Store
→ resolve/create Product
→ add one Purchase Item through multi-item-capable aggregate
→ atomically commit facts + pending purchase.registered event
→ display rebuilt projection
→ close/reopen
→ verify facts, queue, and projection
```

No authentication, cloud, Neon, or TypeScript API is required for this first local slice.

## Unit 5 — Local protocol harness, only after Units 1–4

Candidate later unit:

```text
two isolated Flutter-local stores
+ local TypeScript API
+ disposable Postgres
+ fake/test account identity
→ upload
→ idempotent append
→ cursor download
→ second-device apply
```

Non-production Neon follows only after local protocol success.

---

# 5. Fresh Logical Data Model

The physical schema must be derived from these accepted responsibilities.

## Product

```text
product UUID
account UUID
normalization version
normalized name
normalized brand
PACKAGED or BULK
measurement kind
package amount
package unit
display values as required
lifecycle metadata
```

Identity:

```text
PACKAGED:
account + normalized name + brand + mode + kind + amount + unit

BULK:
account + normalized name + brand + mode
```

Fuzzy-similarity data is advisory and must not define unique identity.

## Store

```text
store UUID
account UUID
minimum display name
optional location metadata
lifecycle metadata
```

Store location may default currency but is not the sole persisted currency authority.

## Purchase

```text
purchase UUID
account UUID
store UUID
occurrence timestamp
currency code
aggregate-level observed facts
creation/source metadata
```

## Purchase Item

```text
item UUID
purchase UUID
product UUID
package count
purchased amount
measurement kind/unit
line total in minor units
promotion observation
optional bounded notes/expiration facts
```

## Synchronization event

```text
event UUID
account UUID
device UUID
device sequence
event type
payload version
purchase aggregate payload
occurrence timestamp
canonical content identity/hash as required
local queue state
server cursor after acceptance
```

## Projection and analytics metadata

Projections are rebuildable. When reproducibility requires it, cached analytical results record:

```text
analytic identifier
analytic version
input/fact boundary
calculation timestamp
rebuild status
```

Raw facts are never rewritten by analytic evolution.

---

# 6. Representation Rules

## Quantity

```text
measurement_kind:
    MASS | VOLUME | COUNT

canonical unit:
    KG | L | UNIT

normalized amount:
    fixed precision
```

Never infer mass from volume.

Open technical decisions for D/E/F:

- decimal implementation;
- scale/range;
- serialization;
- fractional COUNT policy.

## Money

```text
currency code
integer minor-unit amount
```

Account currency may default entry. Purchase retains explicit currency. Currency metadata must not assume every currency has two decimal places.

## Identity

UUIDs are required for account, device, Product, Store, Purchase, Item, and event.

Deterministic Product UUID remains provisional until canonicalization fixtures prove equivalence and version migration.

---

# 7. Flutter/Dart Architecture Boundary

Required inward dependency direction:

```text
Flutter presentation
→ application/use cases
→ domain contracts and analytics
→ repository interfaces
→ local persistence/event queue/sync adapters
```

Rules:

- widgets do not own SQL, transactions, or durable facts;
- use cases own workflow coordination;
- domain owns invariants and pure calculations;
- repository interfaces isolate storage;
- local transactions protect facts and queues;
- composition root owns platform adapters and lifecycle wiring;
- network calls never remain inside local database transactions;
- no Python IPC bridge;
- no direct Neon client credentials.

---

# 8. Candidate Dependencies

Experiment candidates:

```text
Drift
    first local-persistence candidate

sqflite_common_ffi
    retained comparison

flutter_secure_storage
    later credential candidate
```

They are not accepted dependencies until D/E/F authorize evaluation and G/H/I record evidence.

Sprint 03 local Units 1–4 do not require secure-token storage.

---

# 9. Validation Gates

## Repository safety

- branch is `cycle-07-mobile-preparation`;
- baseline remains an ancestor;
- Python source remains intact;
- ordinary Cycle 06 database path/hash remains untouched;
- no generated artifacts enter unrelated source scope.

## Dart and fixtures

- static analysis passes;
- unit tests pass;
- packaged/bulk normalization fixtures pass;
- Dart re-encoding preserves protocol semantics;
- fuzzy similarity never automatically merges;
- identity version is explicit.

## Local database

- fresh initialization;
- structural defaults only when required;
- foreign keys and uniqueness active;
- atomic Purchase/Items/event commit;
- invalid Item rolls back aggregate;
- close/reopen preserves data;
- migration from an empty/previous test schema is rehearsed;
- failure does not silently reset data.

## Projections and analytics

- facts remain authoritative;
- projections rebuild deterministically;
- analytic identifier/version is stable;
- expected Storage/Shortage/Market or bounded replacement projection matches fixture;
- package and normalized prices do not mutate raw facts.

## Platform

- Windows build/run;
- Android build/run when host/emulator/device is available;
- process termination/relaunch;
- app-private database path;
- iOS remains unvalidated until macOS/Xcode.

---

# 10. Explicit Non-Goals

Sprint 03 first transition does not include:

- purchase editing/deletion;
- product merge/alias workflow;
- global catalogue;
- household sharing;
- realtime/background synchronization;
- production auth;
- production Neon;
- app-store publication;
- PySide6 retirement;
- direct legacy database conversion;
- broad analytics suite;
- product-family/supersession UI;
- complete desktop parity;
- destructive repository reorganization.

---

# 11. D/E/F Authorization Boundary

This forward checkpoint prepares Sprint 03; it does not itself authorize materialization.

Main must prepare:

```text
D_OPS_STAGE
    exact commands, tools, environment, validation, and stop gates

E_DDC_STAGE
    learner checkpoints, fixtures, concept reinforcement, and evidence limits

F_DSN_STAGE
    exact repository topology, ownership, contracts, schema boundary,
    and permitted source files
```

Codex must stop if D/E/F:

- omit the exact Flutter project path;
- disagree on schema ownership;
- permit ordinary Cycle 06 data access;
- mix local Flutter slice with cloud provisioning;
- expand into deferred features;
- fail to name validation and rollback gates.

---

# 12. Sprint 03 Exit Boundary

The first Sprint 03 materialization unit succeeds only when:

```text
Flutter/Dart structure is isolated
Python/PySide6 remains recoverable
canonical fixtures exist
fresh Flutter-local schema initializes
catalogue identity behavior passes
one atomic Purchase with Item persists
pending event persists
projection rebuilds
close/reopen passes
Windows evidence exists
Android evidence exists or a precise host blocker is recorded
Cycle 06 database remains untouched
G/H/I report exact evidence
```

Synchronization API and Neon may remain unimplemented at this boundary. Cycle 07 itself remains open until the synchronized shared slice is eventually evidenced.

---

# 13. Recovery Route

```text
1. AGENTS.md
2. INDEX.md and methodology boot
3. 00_PROJECT_STATE.md
4. this file
5. relevant domain checkpoint
6. J sections 17–18
7. D/E/F once prepared
8. source files named by D/E/F only
```

Recovery warnings:

```text
Flutter selected for planning ≠ Flutter validated
logical schema ≠ physical schema
fresh Flutter database ≠ migrated desktop database
fixture parity ≠ full UI parity
Windows/Android evidence ≠ iOS evidence
local event queue ≠ synchronized cloud state
Sprint 03 local success ≠ Cycle 07 closure
```

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.

# Cycle 07 Sprint 04 Forward Checkpoint

> This section supersedes earlier Sprint 03 forward planning below the latest temporal boundary.

## 1. Entry state

Sprint 03 Unit 01 and its permanent-domain reconciliation are complete.

```text
Flutter/Dart local foundation: implemented and unit-tested
Drift fresh schema: implemented
Purchase aggregate transaction: implemented
local event/pending queue: implemented
Flutter UI: foundation label only
Windows/Android/iOS runtime: unvalidated
TypeScript API/Postgres/Neon: absent
Sprint 04 D/E/F: not yet prepared
```

## 2. Sprint 04 milestone

> Correct the local foundation defects, harden its language-neutral contracts, implement the first user-visible multi-item Purchase workflow, and validate the shared Flutter client on Windows while preserving Android as a required target or precisely evidenced host blocker.

Sprint 04 is not a cloud-sync sprint.

## 3. Required implementation units

### Unit A — Sequence and identity correctness

Required outcomes:

- Device creation does not overwrite an existing sequence.
- Purchase registrations allocate durable monotonic sequences.
- Repeated registration proves `1, 2, 3`.
- Account/device/sequence uniqueness is explicit.
- Allocation rollback and close/reopen are tested.
- Product display name and brand remain available separately from normalized identity.
- Unicode normalization policy covers Portuguese accented text.
- Normalization version is explicit and migration-sensitive.
- Fixed Product-ID fixtures establish deterministic output.

Open human decision:

```text
Product ID semantics:
A. standards-defined deterministic UUID
B. opaque stable deterministic identifier
```

Main recommends A only if Dart and future TypeScript libraries reproduce identical standards-compliant fixtures; otherwise use B and avoid the UUID label.

### Unit B — Contract hardening

Required outcomes:

- preserve readable JSON examples;
- expand complete valid/invalid catalogue, Purchase, and event cases;
- specify types, ranges, nullability, enums, timestamps, decimals, unknown-field policy, and version compatibility;
- add an executable structural validator;
- defer TypeScript parity execution to the protocol unit unless a tiny validator-only check is economical.

Preferred planning choice: JSON Schema plus readable example documents.

Open human decision: approve JSON Schema or name another schema mechanism.

### Unit C — Local Flutter Purchase workflow

Required user-visible flow:

```text
launch Markei
→ initialize fresh app-private Drift database
→ begin Purchase
→ select/create Store
→ select/create Product
→ stage one or more Purchase Items
→ review totals
→ register atomically
→ show success
→ show local Purchase history/projection
→ close/reopen
→ verify persisted result
```

Boundaries:

- Product similarity warns only;
- Store exact-name behavior may remain bounded and explicitly described;
- no editing/deletion, merge/alias, login, network, sync, or legacy import;
- widgets call application boundaries and own neither SQL nor durable transactions.

### Unit D — Runtime and regression evidence

Required commands/evidence:

```text
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
flutter run -d windows
python -m unittest discover -s tests
```

Android evidence when tooling is available:

```text
flutter doctor -v
flutter devices
flutter build apk --debug
flutter run -d <device-id>
```

Record database path, termination/relaunch, persistence, error handling, and working-tree scope.

iOS remains unvalidated until macOS/Xcode.

## 4. Human/manual prerequisites

Before Windows execution:

1. install or modify Visual Studio 2022 with **Desktop development with C++**;
2. include MSVC build tools, Windows SDK, and CMake tools selected by that workload;
3. restart the terminal/VS Code;
4. run `flutter doctor -v`;
5. require the Visual Studio Windows-development line to pass.

Before Android execution:

1. install Android Studio or an equivalent supported Android SDK setup;
2. install SDK platform/build tools, command-line tools, and emulator;
3. create/start an emulator or connect a developer-enabled test device;
4. accept required Android licenses through the Flutter/Android tooling;
5. run `flutter doctor -v` and `flutter devices`.

These are host changes and require human approval. Codex may diagnose them but must not install system tooling without explicit approval.

## 5. Current run command

From the repository root:

```powershell
cd clients/markei_flutter
flutter pub get
flutter run -d windows
```

This is the Flutter equivalent of the earlier `python main.py` entry.

Current expected visual result before Sprint 04 implementation:

```text
Markei shared client foundation
```

The current screen is a scaffold confirmation, not a working Purchase interface.

If Windows tooling remains unavailable, validate the current source with:

```powershell
cd clients/markei_flutter
flutter analyze
flutter test
```

## 6. Prohibited Sprint 04 expansion

Do not combine this milestone with:

- production authentication or authorization;
- TypeScript synchronization API;
- Postgres or Neon provisioning;
- real upload/download or cursor bootstrap;
- household collaboration;
- editing/deletion or Product merge;
- legacy database conversion;
- PySide6 retirement;
- app-store publication;
- broad analytics expansion.

## 7. Exit criteria

Sprint 04 local-client work succeeds only when:

```text
sequence defect corrected and tested
Unicode identity policy fixture-tested
contract examples structurally validated
minimal multi-item Purchase UI runs
atomic registration is used by the UI
local history/projection is visible
close/reopen preserves facts
Windows build and launch pass
Android passes or has a precise host blocker
Python regression suite passes
Cycle 06 data remains untouched
G/H/I distinguish implementation from platform evidence
```

A generated project, passing unit tests without a user workflow, or documentation alone is insufficient.

## 8. Next methodology route

```text
human confirms Sprint 04 decisions and host actions
→ Main writes new D/E/F
→ Codex materializes bounded units
→ G/H/I report
→ functional chats reconcile
→ Main closes Sprint 04
```

The local TypeScript/Postgres synchronization harness remains the candidate next sprint or following bounded unit after this exit boundary.
