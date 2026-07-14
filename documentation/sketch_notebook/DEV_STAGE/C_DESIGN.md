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

---

# C09-R01 — Cycle 09 Local Product and Database Expansion: Design Investigation

Sequence: FLX-INV-02 — Investigative Sequence
Role: Design Chat [D]
Round or unit: C09-R01
Branch: intermid-cycle-recovery
Baseline / inspected remote branch: required ancestor `801e3940c972bac88b039e18357dbe006e94760a`; GitHub comparison reported the branch 23 commits ahead, 0 behind, with that commit as merge base
Authority: human Cycle 09 investigative prompt; staging only
Writable surfaces: `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
Evidence boundary: GitHub inspection of current notebook, Flutter/Dart application/domain, Drift schema/migration, repositories, queries and pages. No local checkout was available; no tests, commands, platform, file-backed or manual validation are claimed.
Next handoff: Main reconciliation and provisional D/E/F cache; Codex inactive

## 1. Round delta

### Newly inspected

- responsive shell, navigation selection and `IndexedStack`;
- composition-root and adapter lifetime;
- Products, Purchase and History state boundaries;
- catalogue, registration, History/detail and price-comparison ports/results;
- Product normalization/identity and fixed-scale quantity types;
- Drift v2 schema, v1→v2 migration, foreign keys, unique keys and generated-code boundary;
- local query translation and bounded History reads;
- current global/forward/Design checkpoints, latest active J, C and I evidence.

### Retained

```text
Flutter presentation
→ application commands/query ports
→ independent Dart domain
← local repository adapters
→ Drift v2 / app-private SQLite
```

Python/PySide6 and its database remain isolated. Draft/edit state is presentation-owned; registered facts and local event preparation are transaction-owned. SyncEvent/PendingEvent is not synchronization.

### Corrected/clarified

- Cycle 09 is the second local product-beta expansion, not an account/API/Neon cycle.
- A normalization-versioned exact Product key already exists and is Account-scoped unique.
- visible Product code is already separate from internal UUID and normalized unique, though legacy columns remain nullable.
- quantity domain supports kg/g/L/ml/un through KG/L/UNIT normalization, but parses dot decimals only and rejects fractional COUNT.
- Products UI currently fixes new Products to MASS despite broader domain capacity.
- History owns one selected Purchase detail, not multi-row selection/export.
- History summaries are capped at 50; no measured evidence justifies cache or broad index work.
- current user messages are catch-all presentation strings, not typed application failures.

### Contradicted

- no manually authored List aggregate or “new immediate list”;
- Product identification is not operation idempotency;
- Settings UI does not own Person/PaymentMethod identity;
- generic key/value settings cannot safely own historical foreign references;
- clearer messages alone do not justify a database error table;
- double-click alone cannot own selection or detail access.

### Unresolved/prospective/deferred

Unresolved: cycle formula/threshold; Product correction policy; normalization collisions; legacy null handling; export contract; PDF/share behavior; reference lifecycle; measured query/index need.

Prospective: Home/navigation, Lists read models, export ports/DTOs, adaptive Product details, typed Person/PaymentMethod records, typed failures and presentation decimal parsing.

Deferred: auth/API/Neon/sync, registered Purchase mutation, manual Lists, split payments, multiple people, production release, active Analytics/Household, persisted drafts and SubmissionId unless separately selected.

## 2. Current topology and schema truth

`MarkeiComposition` owns database/adapters, provisional local Account and persistent Device. `MarkeiApp` owns selected destination and coarse refresh; rail/bar switches at 720 px and `IndexedStack` preserves mounted state. Application read models prevent generated Drift rows leaking into widgets. Infrastructure translates rows. Extend these seams; do not bypass them.

Generated Drift code is derived infrastructure. Table declarations and handwritten migrations in `local_database.dart` are authoritative; `.g.dart` must be regenerated, never hand-edited.

Schema v2 contains LocalAccounts, Devices, Products, Stores, Purchases, PurchaseItems, SyncEvents, PendingEvents, SyncState and MigrationLedger. Product has UUID PK, nullable legacy-compatible visible/normalized code, normalization version, normalized fields and Account-scoped unique exact key. Purchases require Store and have no Person/PaymentMethod. Items store integer package count, canonical quantity text and integer minor-unit totals. FKs are enabled. Unsupported origins throw without silent reset. No v3, reference tables, projection cache, export table or error catalogue exists.

## 3. Cycle 09 UI responsibility map

| Surface | Presentation | Application/domain | Persistence |
| --- | --- | --- | --- |
| Home | cards, links, responsive layout | typed static descriptors | none |
| Lists | view/filter/unavailable state | pure versioned projection query/calculation | Purchase/Product facts |
| Purchase | draft and optional selectors | validation/atomic command | transaction + optional refs |
| History | selected ID set/action mode | export/share use cases and DTOs | read-only facts |
| Catalogue | search/create/detail action | exact lookup and advisory similarity | Product constraints |
| Product details | adaptive rendering | immutable detail read model | query adapter |
| Settings | reference management UI | identity/archive rules | dedicated tables |
| Analytics/Household | disabled destinations | none active | none |
| Guide/Docs | content navigation | typed content/link config | none |

## 4. Home and navigation

Home becomes index 0 and startup landing. Shell owns destination selection, responsive layout and state preservation. Use a typed destination enum/registry rather than raw index meaning.

Bundled cards are compiled/static configuration, not database facts. Offline copy must conservatively describe capabilities of the installed release. GitHub is an external-launch action with unavailable/failure feedback, not persisted data. `IndexedStack` remains acceptable, but static/disabled pages need not all create database-backed live state.

## 5. Lists projections

Authoritative facts: Product identity/display plus ordered registered Purchase/Item occurrence, package/amount/unit, price and currency. Latest Purchase/amount/unit price are read facts. Personal cycle, expected date, remaining time and status are estimates.

```text
compatible Product observations
→ versioned PersonalCycleResult
→ ProductListProjection
→ Storage / Shortage / Market / All filters
```

Provide `AvailableCycleEstimate` and explicit `CycleEstimateUnavailable(reason)`. Insufficient history stays visible in All and never becomes invented inventory. Labels must distinguish personal estimate from factual stock.

Threshold belongs to user preference/application configuration, not Product/Purchase. A compiled default passed to the pure calculation is smaller than a generic DB settings table until editability is accepted.

Recommended persistence: targeted observation query plus pure Dart calculation on demand. Do not persist/cache without measurement. Algorithm ID/version is required. New registration invalidates read state; current refresh signal may trigger rebuild. Candidate indexes require realistic volume and query-plan evidence.

## 6. History selection/export/share

History owns transient `Set<PurchaseId>`. Checkbox/tap/keyboard and clear/select-all are primary; double-click is convenience. Operations never mutate Purchases.

```text
selected IDs
→ export use case
→ ordered ExportPurchase DTO graph
→ CSV encoder or PDF renderer
→ filesystem/share adapter
```

DTOs are independent of Drift and tiles, containing Purchase ID/time/Store, optional Person/Payment labels, currency/total and ordered Items with Product code/name/brand, quantities and totals.

CSV: UTF-8, quoted/doubled fields, stable columns, declared ISO/local date policy, dot-decimal normalized numerics, integer-derived money, deterministic ordering. Multiple Purchases use one row per Item with repeated Purchase columns; single Purchase uses the same schema.

PDF groups by Purchase but consumes the semantic DTO, not CSV. Renderer, file creation and platform sharing are separate ports/adapters. Windows may save/open/share; Android may use app-private temporary file plus OS share sheet. Destination, cancellation, cleanup and failure are visible. No silent upload/analytics. Move to Analytics stays disabled.

## 7. Product details

Use one semantic route keyed by `ProductId` with adaptive rendering: full route on compact/mobile, sheet/route on medium, persistent detail pane on wide desktop. Dialog-only is too restrictive. Explicit action, tap and keyboard are mandatory; double-click optional.

Query returns immutable `ProductDetailView`; no Drift row or registered-Purchase mutation callback. Catalogue and Purchase share the same action/route.

## 8. Person and Payment Method

```text
Person(PersonId, nickname, active|archived)
PaymentMethod(PaymentMethodId, nickname, active|archived)
Purchase.personId? → Person
Purchase.paymentMethodId? → PaymentMethod
```

IDs are immutable opaque identities. Nickname may be corrected. Archived rows resolve in History/export but disappear from ordinary new-Purchase selectors. Nullable restrictive/no-action FKs preserve history. Referenced rows cannot be physically deleted; archive is the primary lifecycle. Backfill is null. Omission never blocks registration. No credentials, multiple people or split payment.

Settings owns create/rename/archive/reactivate UI. Domain/application owns identity and lifecycle. Dedicated tables are required; generic settings is rejected. Indexes on optional refs require evidence.

## 9. Product identity/code/normalization/collisions

| Concern | Owner |
| --- | --- |
| record identity | `ProductId` UUID |
| visible code | normalized Account-scoped unique `ProductCode` |
| exact identity | normalization-v2 Account-scoped unique key |
| similarity | advisory pure heuristic, no merge |
| retry idempotency | separate future SubmissionId |

Add lookup ports for code alone and normalized draft facts; database uniqueness remains collision guard. PACKAGED already includes name/brand/mode/dimension/canonical package quantity. BULK excludes package quantity, but current model retains measurement kind. Main must resolve whether stated name+brand-only identity forbids same-name bulk products of different dimensions or whether dimension participates.

Normalization v2 performs NFKC, lowercase, punctuation-to-space and whitespace collapse; accents remain significant. Canonical units equate 1000 g/1 kg and 1000 ml/1 L. Never mutate released v2. A changed rule needs new version, preflight/backfill, collision detection and explicit resolution. Migration must stop/report collisions, never auto-merge Purchases.

Identity edits remain unmodeled. Recommend immutability this cycle; correction/reclassification is separate. Display-only correction is safe only if it cannot contradict identity. Technical UUID is never user code. Legacy null codes are readable compatibility rows and non-matches for code lookup; new commands remain non-null.

## 10. Quantity, decimal and money

Domain canonical boundary: MASS→KG, VOLUME→L, COUNT→UNIT, scale 1e6. Presentation accepts comma or dot, rejects mixed ambiguity, normalizes to dot before domain/application. Serialization stays locale-neutral.

g/ml conversion currently truncates below canonical microunit through integer division; Main must accept truncation or require divisibility/rounding. Require positive bounded values. Fractional COUNT remains rejected unless separately changed.

PACKAGED identity owns package quantity; Purchase records packages, amount and total. BULK has no package identity and packages must not be required. Current `packageCount` is non-null integer: decide nullable/not-applicable versus a documented placeholder. Design recommends nullable/not-applicable if schema work is accepted; fake `1` is misleading.

Money remains currency + integer minor units. Presentation parses price without floating point and rejects unsupported fraction digits. For BULK, distinguish input price-per-unit from stored line total. Derive one from amount with explicit rounding; avoid two competing authoritative price facts.

## 11. Error/result ownership

Alternatives:

1. typed domain/application failure algebra plus presentation mapping — recommended smallest owner;
2. DB-backed descriptions — rejected now due migration/localization/staleness cost;
3. typed failures plus compiled/localized catalogue — recommended evolution.

Failure descriptor: stable code, title key, explanation key, field/operation, recovery action, retryable, and outcome (`known-not-applied`, `known-applied`, `unknown`). Adapters translate Drift/SQLite exceptions; widgets never receive raw DB errors. Do not persist/transmit error occurrences as analytics.

## 12. Independent schema units

Keep independently selectable:

1. Person table;
2. PaymentMethod table;
3. nullable Purchase FKs;
4. Product-code tightening/backfill;
5. exact identity/normalization change;
6. BULK package-count representation;
7. evidence-justified indexes;
8. measured projection cache;
9. independently justified error catalogue;
10. future SubmissionId.

Each accepted unit defines next version, representative v2 fixture, backfill, collisions, FK/archive/delete behavior, transactional failure classification, reopen/no-reset evidence, Drift regeneration and Python/PySide6 database protection. Person/PaymentMethod/refs may share one coherent optional-metadata migration while remaining separately testable. Never bundle Product identity into it.

## 13. Schema-free units

- typed destination registry, Home and static destinations;
- disabled Analytics/Household plus Guide/Docs;
- History selection, export DTO and pure CSV;
- Product-detail contract/route;
- Lists algebra/algorithm fixtures/unavailable state;
- comma/dot presentation parser and required unit controls;
- typed failures plus compiled messages;
- query-volume/plan measurement.

PDF/share is schema-free but may be dependency/platform-bearing and needs separate license/platform authorization.

## 14. Reversibility, cost and validation

Preferred order:

```text
shell/Home
→ typed failures and decimal boundary
→ Product details
→ History selection + DTO + CSV
→ pure Lists fixtures/query
→ optional-reference migration
→ PDF/share adapters
```

Required evidence later: navigation/keyboard/tap widgets; projection fixtures/version; CSV escaping/order/date/decimal; exact lookup/collision/similarity separation; quantity and money rounding; representative v2 migration/archive/history/reopen/no-reset; generated schema reconciliation; share cancellation/privacy on Windows/Android; measured query plans; Python regression and protected DB evidence. Design does not claim these validations here.

## 15. Main/human decisions

1. Does BULK name+brand identity prohibit differing dimensions, or does dimension participate?
2. Is BULK package count nullable/not-applicable?
3. Define minimum observations, interval aggregation, ties and outliers for personal cycle.
4. Define default threshold and whether user editing is active.
5. Approve “personal estimate, not inventory” and explicit unavailable result.
6. Keep Product identity fields immutable or authorize explicit correction.
7. Retain accent-sensitive normalization v2 or stage a new version.
8. Approve rename/archive/reactivate and whether never-used deletion is worthwhile.
9. Approve Item-row CSV/grouped PDF, columns, timezone and order.
10. Approve Windows save-first and Android share-sheet cleanup behavior.
11. Approve adaptive semantic Product route.
12. Approve typed failures + compiled/localized messages; reject DB catalogue now.
13. Is optional Person/PaymentMethod metadata the first migration unit?
14. Require measured evidence before index/cache.
15. Keep Analytics/Household visibly disabled rather than empty active pages.

## 16. Classification and next route

Retained: inward topology, app-private Drift, atomic registration, UUID/code/exact identity separation, advisory similarity, fixed-scale quantity, minor-unit money and rebuildable analytics.

Corrected: Cycle 09 local boundary; normalized key already exists; UI/domain capacity and current selection/error limits are now explicit.

Contradicted: manual List aggregate, generic reference settings, identity-as-idempotency, DB error table by default and shortcut-only access.

Unresolved: formula, BULK semantics, threshold, correction/version policy, export/share contract, lifecycle and performance evidence.

Prospective: schema-free contracts and one optional-reference migration.

Deferred: distributed/cloud/release scope and unrelated identity units.

```text
Main reconciles C09-R01 A/B/C
→ resolves formula, BULK and reference lifecycle
→ keeps D/E/F PROVISIONAL — NOT AUTHORIZED FOR CODEX
→ stages schema-free contracts first
→ requests Operational v2/query/share evidence
→ freezes at most one schema migration unit
→ explicitly transitions to FLX-ORD-01 only with writable paths,
   validation, rollback and stop gates
```

Authority state:

```text
Design investigation appended
source/schema/dependencies/permanent memory/J/D/E/F/G/H/I untouched
Operational validation and Didactic maturity not claimed
Codex inactive
ready for Main reconciliation; not ready for materialization
```
