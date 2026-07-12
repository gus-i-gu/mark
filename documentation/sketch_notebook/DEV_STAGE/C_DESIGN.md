# C_DESIGN — Cycle 07 Sprint 04 Functional State of Union

> Role: Design Chat [D]  
> Cycle: 07  
> Sprint: 04 exploration  
> Branch: `cycle-07-mobile-preparation`  
> Inspected remote head: `faf62fff1b3b9266934a8295891fd386e7d36371`  
> Date: 2026-07-12  
> Status: Functional Design stage; temporary and non-canonical  
> Sources: J sections 19–20; `00_PROJECT_STATE.md`; latest `05_SESSION_LOG.md` segment; `06_SESSION_SCHEME.md`; `design/09_DESIGN_STATE.md`; G/H/I; protected Python source; handwritten Flutter source, schema, manifests, fixtures, and tests

## 1. Recovered Main State

**Accepted:** Cycle 06 remains a recoverable PySide6/SQLite Windows beta. Cycle 07 Sprint 03 closed with an additive Flutter/Dart foundation, fresh Drift persistence, account-private catalogue structures, Purchase/Purchase Item aggregation, local event preparation, and pending queue persistence.

**Implemented and validated locally:** the independent Dart domain/application boundary, fresh Drift schema, atomic local Purchase transaction, invalid-item rollback, close/reopen persistence, dimensional quantity, minor-unit money, and minimal versioned analytics. Nine Flutter tests, clean analysis, and five Python regressions passed.

**Host-unvalidated:** generated Windows, Android, and iOS targets. No platform build/run or responsive lifecycle evidence exists.

**Accepted Sprint 04 direction:** correct identity and sequence defects, harden contracts, implement the local Flutter Purchase workflow and visible history/projection, prove close/reopen, and require Windows build/run. Android build is attempted only when tooling is available; complete Android execution is not an acceptance requirement.

**Deferred:** TypeScript/Postgres synchronization harness, authentication, Neon, distributed convergence, legacy import, editing/deletion, household sharing, background/realtime sync, parity, and PySide6 retirement.

Implementation remains inactive until Main writes and the human approves fresh D/E/F, including any host-tool installation.

## 2. Hierarchical Recovery

Recovery followed Main continuity first: J section 20 → 00 → latest 05 segment → 06. The Design checkpoint was then required because Main explicitly carried unresolved sequence, normalization, Product identity, contract, migration, and Store boundaries into Sprint 04.

No deeper permanent Design file was required. `design/09_DESIGN_STATE.md` already distinguishes accepted topology, implemented evidence, host-unvalidated targets, defects, and the recommended route. Repository inspection was required because MSU-02 asks Design to compare intended architecture with current Python and Flutter implementation truth.

## 3. Repository Surfaces Inspected

Protected Python boundary:

- root and `app/main.py` entrypoints;
- Python Product/Purchase models;
- ProductService and concrete Repository coupling;
- Windows/PyInstaller-shaped database manager;
- Cycle 06 SQLite schema;
- PySide6 dependency manifest.

Flutter boundary:

- `pubspec.yaml`, lock/dependency ownership, and Dart entrypoint;
- placeholder `MarkeiApp`;
- Register Purchase command and repository port;
- Product, Purchase, Item, Store, ID, quantity, money, event, and analytics domain models;
- handwritten Drift schema and local Purchase repository;
- catalogue and repository tests;
- human-readable shared-beta JSON fixtures.

Generated Drift and platform-runner files were not read line by line. Their ownership is evaluated through schema/configuration, dependency lock, regeneration evidence, and G/H/I validation.

## 4. Current Design State of Union

### Protected Python beta

The Python application remains a coherent desktop-only layered system:

```text
PySide6
→ ProductService
→ concrete Repository
→ Windows-shaped Database Manager
→ Cycle 06 SQLite
```

Its Product ID is user-entered text and its Purchase row directly references one Product. It does not implement the new Purchase aggregate, dimensional quantity, internal/user code separation, or shared synchronization model. That mismatch is expected: Python is the protected behavioral reference and migration source, not the target schema.

### Flutter foundation

Implemented dependency direction matches the accepted inward architecture:

```text
Flutter composition
→ application port
→ infrastructure-independent Dart domain
→ repository boundary
→ Drift local adapter
```

The UI is still only a foundation screen. It does not construct the Drift database or expose catalogue, Store, Purchase staging, registration, or history.

The local repository atomically persists Store/Product references, Purchase/Items, `purchase.registered`, and pending queue state. This is a validated local transaction boundary, not synchronization.

## 5. Product Identity and Catalogue Responsibilities

Human direction establishes three separate identifiers:

1. **User Product code — accepted product direction.** An account-private, user-designable opaque code displayed to the user. It is a catalogue handle, not a derivation of Product meaning.
2. **Internal Product record identity — accepted architectural distinction.** Immutable identity used by local relations, events, and future synchronization. Users do not redefine it by editing the Product code.
3. **Future central Product UUID — deferred future catalogue identity.** A system-controlled identifier may later be assigned against a versioned Name + Brand + Package Quantity production identification set.

The current Flutter `Product.id` conflates internal identity with a SHA-256-derived identity-set result. Sprint 04 should separate these responsibilities before adding UI.

Recommended provisional local model:

```text
Product
    internalProductId      immutable opaque record ID
    userProductCode        account-private user-facing code
    normalized identity fields
    normalizationVersion
    display name / brand
    mode and package quantity
```

The user code must not be the primary/foreign key. Whether it is required, unique per account, mutable, reusable after retirement, case-sensitive, or history-snapshotted requires Main/human definition. Design recommends account-scoped uniqueness after a documented normalization rule, mutability through an explicit catalogue operation, and immutable Purchase references to `internalProductId`.

The future central UUID must not be introduced into Sprint 04 storage as if the central catalogue exists. A nullable future mapping boundary may be designed later.

## 6. Defects, Drift, and Contradictions

**Defective — device sequence.** `registerPurchase` uses an upsert that resets `nextSequence` to 1 before allocation. Repeated purchases can reuse sequence 1. The schema also lacks explicit account/device/sequence uniqueness. Sprint 04 must correct and test 1, 2, 3 allocation, rollback, reopen, and uniqueness.

**Defective/provisional — normalization.** `[^\w\s]` may remove accented Portuguese letters. Display text is also not stored separately from normalized identity in the Product schema. Sprint 04 requires explicit Unicode normalization, Portuguese fixtures, stable canonical bytes, and separation of display/normalized fields.

**Provisional — Product ID.** The current SHA-256 output is formatted like a UUID without an accepted UUID-version/variant contract. With the new human decision, it should be treated as an internal opaque candidate rather than a user code. Deterministic identity-set derivation may later belong to the central catalogue instead.

**Incomplete — contracts.** Catalogue fixtures test useful semantics, but Purchase and event files contain mainly counts and required-field names. They do not define a wire contract.

**Unvalidated — migration.** Drift schema version 1 creates fresh data only. Upgrade rehearsal and Cycle 06 import remain separate.

**Incomplete — Store.** Exact display-name reuse is not stable Store identity or deduplication.

**Stale staging:** the prior C report described Sprint 02 planning before implementation. This report supersedes it while preserving its contract-first, protected-migration, and local-first findings.

## 7. Human Decisions Applied

- **Accepted:** private catalogue exposes a user-designable opaque Product code.
- **Accepted:** user code is distinct from immutable internal Product identity.
- **Deferred:** central catalogue may later assign a system UUID for a versioned production identification set.
- **Accepted:** Sprint 04 uses JSON Schema and retains readable examples.
- **Required validation:** Windows build and launch.
- **Conditional evidence:** Android build should be attempted when tooling exists; full Android execution is not required.
- **Authority constraint:** host-tool installation requires exact D/E/F scope, permission, and validation.

These decisions supersede J’s earlier binary choice between opaque deterministic Product ID and standards-defined UUID: Sprint 04 needs an opaque internal record identity plus a separate user code; central semantic UUID assignment remains future work.

## 8. JSON Schema Contract Boundary

Sprint 04 should add schemas for Product catalogue input/output, Purchase aggregate, and `purchase.registered` envelope while retaining readable valid and invalid examples.

Schema ownership should define:

- required fields and types;
- nullability;
- enums and ranges;
- timestamps;
- fixed decimal strings and integer minor units;
- additional-property policy;
- schema and payload versions;
- user Product code versus internal identity;
- valid/invalid examples.

JSON Schema validates structural interchange, not all domain meaning. Cross-field invariants—currency agreement, package-mode rules, Product-code policy, aggregate totals, and normalization—remain domain/fixture tests. No TypeScript service belongs in this unit.

## 9. Recommended Sprint 04 Materialization Scope

### Unit A — correctness and identity

- preserve Device state and allocate monotonic sequence atomically;
- add account/device/sequence uniqueness;
- add repeat, rollback, reopen, and recovery tests;
- introduce immutable internal Product ID and separate user Product code;
- preserve display name/brand independently;
- replace unsafe normalization and add accented Portuguese fixtures;
- retain advisory-only similarity.

### Unit B — contract hardening

- adopt JSON Schema;
- retain human-readable examples;
- cover valid/invalid Product, Purchase, and event cases;
- include fixed expected canonical identity values where still relevant;
- validate schemas in tests;
- avoid API/Postgres work.

### Unit C — local Flutter workflow

- composition root opens app-private Drift storage;
- minimal responsive Purchase page;
- Product and Store select/create;
- one-or-more Item staging;
- user Product-code entry/selection;
- atomic Register Purchase;
- visible local history/projection;
- close/reopen persistence.

### Unit D — platform evidence

- analysis, formatting, code generation, and tests;
- Python regression suite;
- Windows build and launch required;
- verify app-private path and reopen lifecycle;
- Android build attempt only when tooling is available;
- record Android blocker without making full execution a Sprint 04 failure;
- keep iOS unvalidated.

The units may share one D/E/F package but require separate pass/fail evidence.

## 10. Alternatives and Development Cost

Adding the Product-code/internal-ID split now costs a schema migration within the new Flutter database, model changes, fixtures, and UI fields. Deferring it would be cheaper immediately but would let the first UI and JSON contracts harden the wrong identity semantics, making later migration more expensive.

JSON Schema adds validator/tooling and maintenance cost, but reduces ambiguity before Dart/TypeScript divergence. Readable examples remain necessary because schemas alone are poor scenario documentation.

Windows-first evidence narrows toolchain work and gives visible shared-client progress. Requiring Android execution simultaneously would expand SDK/emulator cost and risk hiding local architecture defects behind environment setup. A conditional Android build preserves evidence without making two platforms one acceptance gate.

The TypeScript/Postgres harness remains strategically important but should follow the local workflow. Building it now would multiply identity and contract changes across two runtimes before the Product-code distinction and event envelope stabilize.

## 11. Questions Requiring Resolution

Main/human should decide before final D/E/F:

1. Is `userProductCode` mandatory?
2. Must it be unique per account after normalization?
3. May users change it, and must old codes remain aliases or snapshots?
4. Can a retired code be reused?
5. What maximum length and permitted character policy apply?
6. Should internal Product IDs be random UUIDs/opaque IDs in Sprint 04, leaving deterministic semantic UUIDs solely to the future central catalogue?
7. Which JSON Schema draft and validator will D/E/F authorize?
8. Does Android “attempt” mean install tooling when permission is granted, or build only if tooling already exists?
9. Which exact Visual Studio workload/components may be installed for Windows?

Design recommends: mandatory account-unique code, explicit user-authorized change, no silent reuse during the beta, internal opaque random UUID, and no central semantic UUID field until the central catalogue is actually designed.

## 12. Explicit Non-Goals

- changing or migrating the ordinary Cycle 06 database;
- retiring PySide6;
- TypeScript API, Postgres, Neon, authentication, or authorization;
- actual upload/download synchronization;
- household/global catalogue;
- Product merge/alias or central UUID assignment;
- purchase editing/deletion;
- background/realtime sync;
- Android execution as mandatory acceptance;
- iOS validation;
- broad analytics expansion;
- permanent documentation promotion.

## 13. Evidence Matrix

| Claim | Classification | Source |
| --- | --- | --- |
| PySide6 beta remains protected | accepted/validated | 00, 05, Python boundaries |
| Flutter foundation coexists additively | implemented | J20, I, repository |
| Dart domain is infrastructure-independent | implemented/validated | imports, analyze/tests |
| Drift local schema and atomic aggregate exist | implemented/validated | schema, repository tests |
| Close/reopen local persistence passes | validated | repository test, G/I |
| Windows/Android/iOS targets exist | implemented, host-unvalidated | generated topology, G/I |
| Purchase UI exists | blocked/not implemented | `markei_app.dart` placeholder |
| Device sequence is monotonic | defective, not accepted | repository upsert/allocation |
| Unicode-safe normalization exists | defective/provisional | Product normalizer |
| Deterministic Product ID is final | provisional/superseded | code plus human decision |
| User Product code is required direction | accepted | 06 human decisions |
| JSON Schema is Sprint 04 validator | accepted | 06 human decisions |
| TypeScript API/Neon synchronization exists | deferred/not implemented | J20, repository |
| Windows execution is Sprint 04 gate | accepted/required | 06 human decision |
| Android full execution is required | deferred/not required | 06 human decision |

## 14. Proposed F_DSN Gates and Handoff

Design-relevant future F stage should require:

1. exact Product identifier responsibilities and invariants;
2. a migration from current Drift v1 without touching Cycle 06 data;
3. sequence preservation plus uniqueness;
4. Unicode/display separation;
5. JSON Schema and readable examples;
6. composition-root database ownership;
7. multi-item atomic workflow and visible history;
8. Windows lifecycle evidence;
9. conditional Android build classification;
10. explicit preservation of deferred cloud/sync work.

Main should reconcile this C report with refreshed A and B. D/E/F should not be written from older Sprint 02 staging. The smallest coherent Sprint 04 outcome is a Windows-executed, local-only Flutter Purchase workflow with corrected identities, schema-validated contracts, persistent history, and preserved PySide6 rollback.
