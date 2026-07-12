# Didactic State-of-Union — Cycle 07 Sprint 04

> Role: Didactic Chat [A]  
> Cycle: 07  
> Sprint: 04 exploration before D/E/F  
> Branch: `cycle-07-mobile-preparation`  
> Inspected head: remote branch ref after Sprint 03 reconciled head `36996361ce06e8833b91e04800ccbe0944d778e1`; baseline remains an ancestor and continuity has advanced beyond that head  
> Date: 2026-07-12  
> Sources: Main J §§19–20, `00_PROJECT_STATE.md`, latest `05_SESSION_LOG.md` segment, `06_SESSION_SCHEME.md`, `didactics/08_CONCEPT_MAP.md`, G/H/I, protected Python source/tests, Flutter handwritten source/tests/manifests, and `contracts/shared_beta/v1/`

## 1. Recovered Main State

**Accepted:** Cycle 06 remains a protected Python/PySide6 beta and behavioral reference. Flutter/Dart is the selected shared-client basis. Sprint 03 Unit 01 established an additive local foundation using immutable Dart models, Drift, an account-private catalogue, Purchase/Purchase Item aggregation, a local append-only event, pending queue preparation, dimensional quantity, minor-unit money, and versioned analytics.

**Validated locally:** Flutter analysis, nine Flutter tests, five Python regressions, aggregate rollback, and temporary-file close/reopen.

**Host-unvalidated:** Flutter Windows, Android, and iOS runtime/lifecycle.

**Defective or provisional:** device sequencing, Unicode normalization, deterministic Product identity semantics, complete contracts, schema upgrades, and Store identity.

**Deferred:** authentication, TypeScript API, Postgres/Neon, real synchronization, legacy import, editing/deletion, global catalogue, and PySide6 retirement.

**Authority:** this exploration may replace B only. Sprint 04 implementation remains inactive until Main prepares and the human approves new D/E/F.

## 2. Hierarchical-Recovery Path

Recovery followed:

```text
latest J reconciliation
→ 00 current state
→ latest 05 chronology
→ active 06 Sprint 04 checkpoint
→ Didactic checkpoint
→ H evidence
→ bounded source/tests/contracts
```

The Didactic checkpoint was sufficient for canonical identities, dependencies, and maturity, so `02_KANBAN.md`, `07_GLOSSARY.md`, and `13_LECTURE_REGISTER.md` were not reread. Repository inspection was required because MSU-02 asks which planning concepts are physically represented and which are still only documentation.

No generated file was read line by line. Drift-generated code and platform runners were treated as generated evidence whose meaning comes from handwritten schema/configuration, manifests, locks, generation commands, and validation reports.

## 3. Repository Surfaces Inspected

Protected Python boundary:

- root `main.py` and `app/main.py`;
- PySide6 application entry and desktop composition;
- dataclass models;
- `ProductService`, `Repository`, database manager, SQLite boundary;
- Python dependency and regression evidence.

Flutter boundary:

- `pubspec.yaml`, `main.dart`, and `MarkeiApp`;
- catalogue Product, Purchase/Purchase Item, IDs, Quantity, Money, Store, and SyncEvent models;
- Register Purchase application port;
- handwritten Drift schema and local Purchase repository;
- catalogue and repository tests.

Contract boundary:

- readable catalogue, Purchase, and sync-event JSON examples under `contracts/shared_beta/v1/`.

The Python application is a mature local workflow reference. The Flutter entry currently renders only a foundation label; it does not yet expose the local Purchase use case.

## 4. Didactic Current State of Union

### Concepts with implemented local examples

- `&&&06 Stable Identity`: typed IDs exist for account, device, Product, Store, Purchase, Item, and event.
- `&&&10 Historical Integrity`: persisted facts and pending event survive close/reopen without rewriting purchase meaning.
- `&&%05 Immutable Dart Model`: final Dart value/domain objects are present.
- `&%%07 Reusable Catalogue`: Products and Stores are separate reusable references.
- `&%%09 Purchase Aggregate` and `&%%10 Purchase Item`: multi-item-capable models and validation exist.
- `&%%11 Append-Only Synchronization Event`: a local immutable event is prepared.
- `&%%15 Dimensional Quantity` and `&%%16 Monetary Minor Unit`: explicit models and tests exist.
- `&%%17 Versioned Analytic`: a minimal identifier/version registry exists.
- `%%%07 Flutter Framework`: project, widget shell, dependencies, and tests exist.

### Concepts with bounded examples

- `&%%08 Product Identification Set and Deterministic Normalization`: basic PACKAGED/BULK and gram/kilogram fixtures pass, but Unicode and central/local identity semantics remain provisional.
- `&%%12 Offline Queue and Idempotent Delivery`: a pending local row is atomically prepared; server retry/deduplication is absent.
- `&%%13 Device Ordering and Synchronization Cursor`: types/tables exist, but device sequencing is likely defective and no server cursor is exercised.
- `&%%14 Sync Protocol`: examples and an envelope exist, but no complete schema validator or server exchange exists.

### Planning-only concepts

Authentication, authorization, and eventual consistency remain unimplemented. No KANBAN maturity changes are justified: implementation examples are not explicit learner evidence.

## 5. Agreement With J, 00, 05, and 06

The repository agrees with Main that Sprint 03 produced a local foundation rather than a user-visible vertical slice. It also agrees that:

- Python/PySide6 remains protected and separate;
- Flutter uses fresh local storage;
- local facts and queue preparation are atomic;
- JSON examples are incomplete contracts;
- Windows/Android/iOS target presence is not runtime validation;
- local queue preparation is not synchronization;
- Sprint 04 should complete the local client before the protocol harness.

The current B stage was stale because it described model-design promotion before Sprint 03 implementation. This replacement absorbs the newer evidence and human decisions without changing permanent maturity.

## 6. Drift, Defects, Contradictions, and Stale Documentation

1. **Device sequence defect:** repeated registration may recreate/upsert a Device with sequence 1. A learner must distinguish a field named “sequence” from evidence of monotonic ordering.
2. **Unicode normalization:** current normalization uses behavior that may discard accented Portuguese letters. “Normalized” does not mean locale-safe or cross-language deterministic.
3. **Identity vocabulary drift:** current Dart uses `ProductId` and a deterministic UUID-shaped derivation. Sprint 04 now requires three distinct identities rather than one overloaded “Product ID.”
4. **Contract gap:** JSON examples are fixtures, not JSON Schema, a complete protocol, or Dart/TypeScript parity evidence.
5. **UI gap:** the Flutter widget proves framework composition only at scaffold level; it does not prove a responsive Purchase workflow.
6. **Platform gap:** generated runners do not prove Windows or Android execution.
7. **Migration gap:** fresh schema creation is not schema-upgrade or legacy-import validation.
8. **Store gap:** exact display-name reuse is not Store deduplication.

## 7. Human Decisions Already Supplied

Sprint 04 must teach and implement three non-equivalent Product identities:

```text
user-designable opaque Product code
    visible account-private reference chosen by the user

immutable internal Product record identity
    system-owned identity of the current account-local Product record

future central Product UUID
    future system-controlled identity associated with a versioned
    Name + Brand + Package Quantity identification set
```

The user code must not become the database primary identity merely because it is visible. The future central UUID must not be silently treated as the same object as the current local record identity; it requires explicit mapping/version/migration semantics.

Further accepted decisions:

- Sprint 04 adopts JSON Schema while retaining readable JSON examples.
- Windows build and run are required acceptance evidence.
- Android build must be attempted when tooling is available; full Android execution is not required for Sprint 04 acceptance.
- Tool installation can be permitted only through forthcoming D/E/F with exact tool, scope, commands, risks, and validation.

## 8. Questions Requiring Main or Human Resolution

1. May user Product codes repeat across accounts but remain unique within one account?
2. Are user codes editable, and if so, how does History show prior values without confusing record identity?
3. What term names the immutable local record identity so UI “Product code” never collides with it?
4. Is the future central identification set exactly Name + Brand + Package Quantity, or must it retain dimension/unit and normalization version explicitly?
5. How is a local Product mapped to a later central UUID without rewriting historical Purchase Items?
6. Which JSON Schema draft/version and validator implementation are accepted?
7. Are schemas canonical protocol definitions while examples remain illustrative test vectors?
8. Does Android acceptance require a successful APK build, or may missing tooling be recorded as an exact blocker after the required attempt?
9. Which host installations may D/E/F authorize, and what rollback/verification is required?

## 9. Recommended Next Bounded Materialization Scope

The smallest coherent teaching/materialization unit is:

```text
correct device sequencing
→ introduce explicit Product code versus internal record ID vocabulary
→ preserve display and normalized forms
→ define Unicode-safe normalization v1 fixtures
→ add JSON Schema and validate readable examples
→ implement minimal multi-item Flutter Purchase workflow
→ display local history/projection
→ close/reopen
→ build and run Windows
→ attempt Android build when tooling exists
→ rerun Python regressions
```

Didactically, the unit should produce executable evidence for distinctions already in canon rather than create more concepts. The central teaching theme is **visible reference versus system identity versus future shared identity**.

## 10. Explicit Non-Goals

- no KANBAN maturity changes;
- no new permanent concepts during this stage;
- no authentication or authorization;
- no API, Postgres, Neon, upload, cursor, or convergence;
- no Product merge/alias or global catalogue;
- no purchase editing/deletion;
- no legacy conversion;
- no PySide6 retirement;
- no Android runtime requirement for acceptance;
- no iOS claim;
- no tool installation outside explicit D/E/F.

## 11. Evidence Matrix

| Claim | Classification | Source |
| --- | --- | --- |
| PySide6 beta remains reference/rollback | accepted and validated within Cycle 06 boundary | 00/05/06, Python entry/core |
| Flutter/Dart local foundation exists | implemented | Flutter manifest and handwritten source |
| Local domain tests and Python regressions pass | validated locally | G/H/I |
| Drift fresh local persistence exists | implemented and unit-tested | schema, repository, H |
| Purchase/Items/event/queue transaction | validated locally | repository tests |
| Product normalization v1 | provisional | Product source/tests; Unicode gap |
| Device monotonic sequence | defective/unvalidated | repository source, J §19 |
| JSON examples | implemented fixtures; incomplete contracts | contracts and J |
| JSON Schema | accepted for Sprint 04; not implemented | human decision |
| User Product code | accepted requirement; not implemented | human decision |
| Internal Product record identity | accepted responsibility; implemented incompletely named | IDs/source and human decision |
| Future central Product UUID | proposed future mapping | human decision |
| Flutter Purchase UI | absent | app widget shell |
| Windows runtime | blocked/required | 06 and G |
| Android build | host-unvalidated; required attempt | 06 and human decision |
| Authentication/API/cloud synchronization | deferred | J/06/H |
| Learner mastery | unvalidated | Didactic checkpoint |

## 12. Proposed Didactic D/E/F Gates

E_DDC_STAGE should require:

1. terminology tests/examples distinguishing Product code, internal record identity, and future central UUID;
2. Unicode/Portuguese normalization fixtures with expected canonical results;
3. JSON Schema validation of both valid and invalid readable examples;
4. explicit explanation that schema validation is structural, not semantic parity by itself;
5. repeated Purchase evidence showing device sequences 1, 2, 3;
6. UI evidence that widgets call application boundaries and own no SQL/transaction;
7. visible multi-item Purchase and persisted history/projection;
8. Windows runtime evidence separated from unit-test evidence;
9. Android build attempt classified separately from Android execution;
10. generated-versus-handwritten ownership;
11. no maturity transition unless the learner supplies explicit evidence.

Stop if the three Product identities are conflated, readable examples are replaced by generated-only schema artifacts, a queue is called synchronization, or platform target generation is called runtime validation.

## 13. Final Handoff to Main

The Didactic domain is ready for Sprint 04 D/E/F only after Main reconciles the three identity terms and JSON Schema ownership with Operational and Design staging. The existing canon is sufficient; Sprint 04 should reinforce it through a real local workflow and platform evidence. Preserve every evidence boundary: local implementation is not platform validation, JSON Schema is not complete semantic parity, pending queue is not synchronization, and successful tests are not learner mastery.
