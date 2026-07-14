<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

<!-- ROUND_MARKER:IRC-R01-D-2026-07-14 -->
# Intermid Cycle Recovery Round 01 — Design Investigation

> Role: Design Chat [D]  
> Sequence selected by invoking prompt: FLX-ORD-01 — bounded Ordinary Design pass  
> Repository: `gus-i-gu/markei`  
> Branch: `intermid-cycle-recovery`  
> Main orientation: `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`, IRC-R00  
> Application implementation boundary inspected: `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc`  
> Status: FUNCTIONAL DESIGN STAGE — PROVISIONAL, NOT CANONICAL, NOT CODEX AUTHORITY  
> Writable surface: this file only

## 1. Authority and evidence boundary

This report appends one bounded Design assessment. It interprets repository structure but does not claim Operational reproducibility or host acceptance, change Didactic maturity, promote permanent Design knowledge, activate D/E/F, authorize Codex, or modify source.

`J_MAIN_STAGE.md` is provisional orientation. Its claims were confronted with current branch-pinned source and the Cycle 08 implementation commit. Recorded test/build results in the commit and Main stage remain historical observational evidence; they were not rerun in this Design pass.

The Main stage describes IRC-R01 under FLX-INV-02, while the human invoking prompt explicitly selects the Ordinary Sequence. This report follows the human-selected bounded pass and preserves the investigative classifications required by IRC-R00. Main must choose the subsequent sequence before synthesis, materialization, or promotion.

## 2. Evidence inspected

### Main and staging

- `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- branch comparison from `d5b2ad7881563fb00405bbbb52ae020cabe35add` to `intermid-cycle-recovery`
- Cycle 08 implementation commit `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc`, including its changed-path and Codex-report evidence

### Current application source

- `clients/markei_flutter/lib/main.dart`
- `clients/markei_flutter/lib/app/markei_composition.dart` as resolved by the entrypoint and Main topology
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/lib/application/register_purchase.dart`
- `clients/markei_flutter/lib/application/catalogue_queries.dart`
- `clients/markei_flutter/lib/application/purchase_history.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_database.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart`
- Cycle 08 diff evidence for `markei_app.dart`, `products_page.dart`, `history_page.dart`, and `test/app/markei_app_test.dart`

One initially guessed root-level composition path did not exist; the entrypoint establishes the canonical composition path under `lib/app/`. No obsolete Main-stage path was queried.

## 3. Implemented topology and dependency direction

**Implemented repository fact**

```text
main.dart
→ MarkeiComposition.appPrivate()
→ presentation widgets/pages
→ application commands and query-port interfaces
→ independent domain structures
← infrastructure adapters implementing application ports
→ Drift LocalDatabase / app-private SQLite
```

The entrypoint performs asynchronous composition before `runApp`. Presentation depends on application contracts and domain values. Infrastructure depends inward on those contracts and domain structures while owning Drift translation. Application records such as `PurchaseHistoryEntry`, `PurchaseDetail`, and `ProductPriceObservation` prevent presentation from depending on generated Drift rows.

`MarkeiComposition` is the composition root and lifetime owner for the database, local adapters, local Account identity, and persistent Device identity. `MarkeiApp` owns destination selection and a refresh signal. The shell’s `IndexedStack` preserves mounted page state across Purchase, Products, and History navigation.

**Design inference**

The current structure is a local shared-client architecture with explicit inward contracts, not a synchronized distributed architecture. The event and pending tables preserve an intended future seam but do not alter present authority: SQLite is the active local system of record.

## 4. Presentation state ownership and lifecycle

**Implemented repository fact**

`_PurchasePageState` owns:

- catalogue snapshots for Products and Stores;
- selected Store and Product;
- session draft lines;
- review/edit state;
- next transient line key;
- in-flight submission guard;
- input controllers and user feedback.

Draft lines use stable presentation keys and immutable `PurchaseItemDraft` values. The draft is copied into an unmodifiable command item list at registration. On repository failure the lines remain available; after success they are cleared.

The draft lifetime is the mounted `PurchasePage` state. `IndexedStack` preserves it while switching destinations, but process death, widget disposal outside the preserved shell, database replacement, or application restart does not.

**Confirmed structural defect**

`_editLine(_DraftLine line)` restores quantity, package count, unit, and price controls but does not restore or retain the line’s original `ProductReference`. A subsequent “Save staged Item” action is routed through the current new-Product or separately selected existing-Product action. The stable line key preserves list identity, not Product identity. Existing-Product editing can therefore be semantically rewritten or fail to preserve the intended `ExistingProductReference(ProductId)`.

**Prospective correction**

The smallest reversible correction is to make edit state own the complete staged line/reference, not reconstruct identity from visible controllers. This can remain presentation-only and requires no schema change. Main should treat it as an independent defect unit with focused widget and command-capture evidence.

## 5. Identity model

### Product

**Implemented**

`ProductId` is durable record identity. Within an Account, persistence separately constrains normalized user code and `exactIdentityKey`. Similarity is advisory through `ProductSimilarityWarning`; it does not merge identity. Existing purchase lines carry `ExistingProductReference(ProductId)`; new lines carry `NewProductReference(ProductDraft)` and resolve during registration.

Legacy nullable Product columns coexist with current UI-required code. This is a migration-compatibility boundary, not proof that code is optional for newly created Products.

**Unresolved**

The lifecycle for changing Product code, correcting Product facts, merging duplicates, or preserving aliases is not established. These should not be inferred from current create/reuse behavior.

### Store

**Implemented**

`StoreId` is durable record identity. `ExistingStoreReference(StoreId)` preserves a selected record; `NewStoreReference(displayName)` creates a new record inside registration. Purchases reference Store by foreign key.

**Unresolved**

Store has no accepted normalized identity, branch identity, uniqueness key, alias, merge, or correction policy. Exact display-name matching in presentation is convenience logic, not a domain invariant.

### Purchase and Purchase Item

**Implemented**

`PurchaseId` and `PurchaseItemId` are generated UUID record identities. Purchase owns occurrence time, Store reference, currency, total, and Items. Registered facts are append-oriented in the current UI: no mutation boundary is exposed.

**Unresolved**

There is no durable registration-attempt identity such as `SubmissionId`. The UI `_submitting` flag prevents concurrent taps only within one mounted state. It cannot establish retry idempotency after timeout, restart, duplicated command delivery, or later upload.

### Account and Device

**Implemented**

The application uses a provisional local Account identity. Device is persisted and its sequence participates in the unique event key `(accountId, deviceId, deviceSequence)`.

**Unresolved**

The current-installation-to-Device relation remains prototype-oriented. The schema does not express exactly one current Device for an installation, installation replacement, restore behavior, or concurrent bootstrap ownership. Device must not be redefined from hardware, platform, email, or application ID by inference.

### Event

**Implemented**

`EventId` is durable; event uniqueness is account/device/sequence. Registration writes `SyncEvent` plus one pending record in the same transaction as local facts.

**Boundary**

This establishes locally queued event identity only. It does not establish remote acceptance, cursor semantics, convergence, replay safety across servers, distributed idempotency, or synchronization correctness.

## 6. Transaction and invariant boundary

**Implemented repository fact**

`LocalPurchaseRepository.registerPurchase()` owns one Drift transaction spanning:

1. local Account and SyncState establishment;
2. Device presence;
3. Store resolution;
4. existing/new Product resolution;
5. Purchase and validated PurchaseItem construction;
6. Purchase and Item persistence;
7. Device sequence allocation/update;
8. SyncEvent construction;
9. PendingEvent enqueue;
10. `PurchaseRegistrationResult`.

Important represented invariants include:

- a Purchase requires at least one Item;
- Purchase and Item identities are generated before persistence;
- PurchaseItems reference one Purchase and Product;
- Purchase references one Store;
- Product exact identity and normalized code are Account-scoped unique keys;
- event sequence is unique per Account and Device;
- foreign keys are enabled before use;
- pending state references an existing event;
- monetary facts use integer minor units;
- normalized quantities use canonical kind/unit structures.

**Design inference**

Atomic reuse is the strongest current boundary: future local changes should preserve one application-level registration unit rather than split Store/Product resolution, facts, sequence, and event enqueue across presentation calls.

**Unresolved**

The inspected evidence does not establish concurrent registration behavior, duplicate command retry behavior, or recovery after interruption at every write boundary. Those are validation questions for Operational and design inputs before durable idempotency is selected.

## 7. Schema v2 boundary and evolution debt

**Implemented**

Schema version 2 contains LocalAccounts, Devices, Products, Stores, Purchases, PurchaseItems, SyncEvents, PendingEvents, SyncState, and MigrationLedger. Fresh creation and a handwritten v1→v2 Product display/code migration are defined. Unsupported upgrade origins throw rather than silently reset. Foreign-key delete actions largely preserve registered facts through restriction and cascade Item/Event dependents only from their owning aggregate/event.

**Structural debt**

- v1→v2 backfill manufactures legacy Product codes from record IDs; the semantics are compatibility-only.
- Store identity has no normalized or uniqueness-bearing fields.
- Purchase has no SubmissionId/attempt key.
- installation ownership of Device is not modeled.
- later schema upgrades have no selected compatibility policy.
- backup/export/restore identity behavior is undefined.
- query volume and index requirements are not justified by measured budgets.
- migration ledger records application intent but is not itself a recovery strategy.

**Independent prospective units**

1. Existing-Product edit correction — presentation-only, immediately reversible, no schema.
2. Query-volume measurement and query-shape review — evidence-only before indexes.
3. Store identity decision — semantic decision before schema; may conclude no change.
4. Submission/idempotency decision — application/domain decision before adding a column or unique key.
5. Installation–Device invariant — identity/lifecycle decision before schema.
6. Schema-v3 migration/recovery contract — follows accepted identity decisions; must include representative upgrade and reopen evidence.
7. Draft persistence — separate product/lifecycle choice; not required by the current session-draft promise.

Combining these into one migration would couple unrelated reversibility and make failure attribution expensive.

## 8. Query and projection boundaries

**Implemented**

`CatalogueQueryRepository` owns Product/Store listing, Product creation, and advisory similarity lookup. `PurchaseHistoryRepository` owns recent Purchase summaries, detail projections, and Product price change. `LocalQueryRepository` maps local rows to application/domain records.

Price change is a rebuildable derived result. `compareLatestCompatibleObservations` sorts observations, anchors on the latest Product/currency/measurement-kind/canonical-unit boundary, chooses the previous compatible observation, derives per-unit integer values, and reports basis-point change or explicit unavailability.

**Design limits**

- It is personal purchase comparison, not market inflation or forecasting.
- It is recomputable and therefore does not currently justify a cache/table.
- Same occurrence timestamps use Store name as a deterministic tie-breaker, but Store name is not a globally durable ordering identity.
- Integer division creates a bounded truncation policy that should remain explicit if analytics expand.
- History detail currently presents the first Item’s comparison, a presentation choice rather than a query limitation.
- Product filtering and History reads are local and bounded by present data volume; pagination/indexes require evidence.

## 9. Alternatives, reversibility, and development cost

### Store identity

- **Retain record UUID + display name:** lowest cost and fully reversible; duplicates remain explicit.
- **Add normalized name uniqueness:** modest schema cost but risks merging distinct branches and converts spelling policy into identity.
- **Introduce explicit chain/branch/location values:** stronger model with higher UI, migration, and correction cost; requires human product decisions first.

Recommendation: retain current identity during recovery and stage a semantic decision before schema work.

### Durable submission identity

- **Keep UI in-flight guard:** sufficient only for the declared mounted-session duplicate-tap boundary.
- **Add client-generated SubmissionId with a local unique constraint:** supports local retry identity and later transport correlation; requires command, schema, migration, and retry-result semantics.
- **Derive idempotency from Purchase/Event fields:** lower apparent schema cost but fragile because identical facts need not mean identical user intent.

Recommendation: do not derive identity from content. Decide whether retry durability belongs in Cycle 09 before selecting physical storage.

### Draft lifetime

- **Session-only draft:** implemented, cheap, and coherent with current copy.
- **Local persisted draft:** improves restart recovery but introduces draft identity, serialization/migration, cleanup, and conflict rules.
- **Evented/durable distributed draft:** premature before synchronization authority.

Recommendation: preserve session-only ownership unless a human requirement explicitly demands restart recovery.

### Analytics

- **Rebuild projections from facts:** current, reversible, and appropriate for small local volume.
- **Add indexes:** only after measured query evidence.
- **Persist comparison cache:** creates invalidation/versioning cost without current need.

Recommendation: retain rebuildable calculations for this boundary.

## 10. Corrections and confrontation with Main orientation

**Confirmed from Main**

- three-destination presentation topology;
- application ports between presentation and local adapters;
- explicit existing/new Store references;
- session-owned multi-line Purchase draft;
- atomic registration reuse;
- detailed History projections;
- rebuildable compatible price comparison;
- schema v2 and synchronization-preparation tables;
- protected Python/PySide6 boundary;
- existing-Product edit defect;
- deferred authentication/API/Neon/real synchronization.

**Clarified**

- Stable draft line keys do not preserve Product identity during edit.
- Store exact-name matching in presentation is not Store normalization.
- PendingEvent plus SyncState is local preparation, not synchronization.
- Product code required by current creation workflows does not erase legacy nullable storage.
- Recorded Cycle 08 tests/builds are not newly reproduced Design evidence.
- The current branch is ahead of the IRC-R00 inspected methodology head through documentation-stage work; the application boundary remains the Cycle 08 implementation commit in the inspected evidence.

**Not established**

- final schema-v3 contents;
- Store normalization or branch model;
- durable SubmissionId;
- persisted draft;
- exactly-one current-installation Device relation;
- backup/restore identity semantics;
- performance index requirements;
- distributed event replay, convergence, or cursor contracts.

## 11. Cross-domain consequences

### Operational

Operational evidence is needed for concurrent transaction behavior, migration/reopen/failure recovery, database location and lifecycle, query-volume budgets, platform behavior, and any future idempotency claim. Design does not classify those as validated here.

### Didactic

Didactic may distinguish record identity from similarity, presentation draft from registered facts, atomicity from idempotency, rebuildable projection from stored fact, and local pending queue from synchronization. This report does not change learner maturity.

### Main

Main should keep the edit defect separate from identity/schema planning. Before any controlling D/E/F, Main must decide whether the next bounded unit is defect correction, identity decision, schema planning, or further evidence gathering.

## 12. Risks and non-goals

Active Design risks:

- edit flow can lose existing Product identity;
- weak Store semantics may be prematurely frozen into schema;
- UI duplicate protection may be mislabeled durable idempotency;
- prototype Device ownership may leak into synchronization design;
- unmeasured query concerns may provoke premature indexes/caches;
- schema-v3 work may combine independent decisions and reduce reversibility.

Non-goals for this stage:

- source correction;
- schema or dependency change;
- Operational acceptance;
- Didactic promotion;
- permanent Design promotion;
- authentication, API, Neon, upload/download, convergence, or production release design;
- Python/PySide6 mutation or retirement.

## 13. Human/Main decisions required

1. Does the existing-Product edit defect close as the next isolated bounded unit?
2. Is mounted-session draft lifetime still accepted for Cycle 09?
3. Must local registration survive ambiguous retry through a durable SubmissionId?
4. Does Cycle 09 require Store normalization, or only preservation of UUID record identity?
5. Must the installation–Device invariant be resolved before schema v3, or remain deferred with synchronization?
6. Which measured data-volume/query threshold would justify pagination or indexes?
7. Should schema-v3 planning wait until these identity decisions are classified?

## 14. Recommendation and next route

Recommended order:

```text
Main reconciles IRC-R01 A/B/C
→ isolate existing-Product edit correction if accepted
→ classify Store / Submission / installation–Device decisions
→ gather Operational migration and query-cost evidence
→ define smallest schema-v3 boundary, if any
→ freeze controlling D/E/F only for one bounded unit
→ Codex materialization and G/H/I evidence
→ FLX-PRM-04 permanent reconciliation
```

If Main cannot classify the identity decisions without more repository or product evidence, it should explicitly transition to or continue FLX-INV-02 rather than treating this Ordinary Design pass as implementation authority.

## 15. Authority state

```text
Design assessment: appended
implemented design: distinguished from inference
unresolved decisions: preserved
prospective proposals: non-authoritative
source/schema/dependency changes: prohibited and untouched
J_MAIN_STAGE: orientation only and untouched
permanent memory: untouched
other domain stages: untouched
Codex: inactive
next authority: Main/human reconciliation
```
