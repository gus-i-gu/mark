<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# Intermid Cycle Recovery — Didactic Ordinary Assessment

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Didactic Chat [A]
> Branch: `intermid-cycle-recovery`
> Main orientation: `[M]_STAGE/J_MAIN_STAGE.md` (IRC-R00, provisional)
> Authority: append Didactic findings to this file only
> Evidence boundary: repository inspection and previously recorded validation; no tests rerun, no learner interview, no maturity promotion

## 1. Bounded objective

Recover the learner-facing knowledge expressed by the current Flutter product implementation, distinguish implemented project knowledge from demonstrated learner maturity, identify permanent Didactic drift, and prepare the next Didactic reconciliation boundary.

## 2. Evidence inspected

- `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`
- `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`
- `documentation/sketch_notebook/didactics/02_KANBAN.md`
- Cycle 08 implementation commit `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc`
- `clients/markei_flutter/lib/app/pages/products_page.dart`
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/lib/app/pages/history_page.dart`
- `clients/markei_flutter/lib/application/register_purchase.dart`
- `clients/markei_flutter/lib/application/purchase_history.dart`
- `clients/markei_flutter/lib/domain/catalogue/product.dart`
- `clients/markei_flutter/lib/domain/purchase/purchase.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`
- `clients/markei_flutter/test/app/markei_app_test.dart`

The Cycle 08 commit records six focused widget tests, 31 Flutter tests, clean Flutter analysis, a Windows release build, and five Python regressions. Those commands were not rerun during this assessment.

## 3. Implemented project vocabulary

Current presentation and tests express:

- `Purchase`, `Products`, and `History` as distinct destinations.
- `Product`, mandatory `Product code`, `similar Product`, use-existing, and create-anyway.
- `Choose Store` and `Create Store` as different user actions.
- session `Purchase draft`, staged `Item`, edit/remove, running total, `Review purchase`, and `Register purchase`.
- `Purchase registered locally.`, `Purchase History`, and `Purchase Item`.
- `Price change in your purchases` and explicit unavailable-comparison language.
- local-device storage boundaries without claims of upload, synchronization, backup, authentication, or production readiness.
- separate loading, empty, no-match, failure, retry, in-progress, and success states.

This vocabulary is implemented project knowledge. It does not by itself establish that the learner can define, compare, or transfer the underlying concepts.

## 4. Conceptual distinctions evidenced by implementation

### Product identity, code, and similarity

`ProductId` supplies record identity; Product code participates in account-local identification; normalized fields and exact identity keys support deterministic matching; similarity warnings remain advisory. “Similar” therefore does not mean “identical,” and create-anyway does not authorize automatic merging.

### Store record and Store identity

`ExistingStoreReference(StoreId)` preserves a selected Store record. `NewStoreReference(displayName)` creates a new record. The implementation does not establish normalized branch identity, uniqueness, or merge semantics.

### Draft Item and registered Purchase Item

A staged line is mutable, keyed, session-only presentation state. Registration converts the reviewed draft into persisted Purchase and Purchase Item facts. Editing a draft is not mutation of an already registered Purchase.

### Atomicity and idempotency

`LocalPurchaseRepository.registerPurchase()` uses one local transaction for Store/Product resolution, Purchase, Items, Device sequence, SyncEvent, and PendingEvent. This supports statement/workflow atomicity within the local boundary. The UI in-flight guard does not provide durable registration idempotency, and no durable SubmissionId exists.

### Raw fact and derived price change

Purchase Items and compatible price observations are historical facts. “Price change in your purchases” is a rebuildable comparison derived from the latest two compatible observations. It is not official inflation, forecasting, or a universal market-price claim.

### Local queue and synchronization

SyncEvent/PendingEvent persistence prepares local event delivery. It does not demonstrate upload, download, convergence, authentication, cursor replay, or synchronization.

### State lifetime and evidence boundary

Mounted draft state, persisted local facts, responsive widget state, Windows build evidence, and Android host evidence have different lifetimes and validation boundaries. A passing widget case does not prove process-death recovery, physical-device behavior, accessibility, or full lifecycle acceptance.

## 5. Learner-maturity classification

No explicit learner explanation, comparison, debugging narration, prediction, or transfer exercise was found in the inspected evidence.

Therefore:

- no KANBAN maturity change is supported;
- existing Green/Yellow/Red states must be preserved;
- repository implementation and passing tests count as project evidence only;
- human use of the application, where previously recorded, does not alone demonstrate conceptual mastery;
- Cycle 08 vocabulary may become permanent Didactic material only through later FLX-PRM-04 classification and reconciliation.

## 6. Didactic drift and knowledge gaps

The current `08_CONCEPT_MAP.md` checkpoint retains Cycle 07 foundations and an empty Intermid Recovery segment. It does not yet expose the final Cycle 08 Products/Purchase/History vocabulary or the implemented distinctions above.

Permanent reconciliation should later determine whether existing concepts already own these meanings or require carefully bounded additions. Immediate candidates for reinforcement are:

- `&&&02 Raw Data Versus Derived Data`;
- `&&&03 Naming as Data Contract`;
- `&&&04 Resource Ownership and Lifetime`;
- `&&&05 Evidence State and Validation Boundary`;
- `&%%05 Statement Atomicity Versus Workflow Atomicity`;
- `&&&06 Stable Identity`;
- `&%%07 Reusable Catalogue`;
- `&%%09 Purchase Aggregate`;
- `&%%10 Purchase Item`;
- `&%%11 Append-Only Synchronization Event`;
- `&%%12 Offline Queue and Idempotent Delivery`;
- `&%%17 Versioned Analytic`.

No new canonical concept is selected here. The permanent Didactic owner must check concept identity and duplication before any addition.

## 7. Concepts needed for the next cycle

The next database/UI cycle should require learner-facing treatment of:

1. record identity versus business identity versus similarity;
2. reference objects versus creation drafts;
3. aggregate boundary and transaction atomicity;
4. retry guard versus durable idempotency;
5. mutable draft lifetime versus immutable registered history;
6. schema version, migration, compatibility, and recovery evidence;
7. raw persisted facts versus rebuildable projections;
8. local event queue versus actual synchronization;
9. UI state labels as evidence-bearing contracts;
10. test/build/manual/lifecycle evidence ladders.

A maturity transition should require the learner to explain at least one distinction in their own words and apply it correctly to a concrete Markei path or failure case.

## 8. Classification for Main

- Retained: implementation evidence is not learner maturity.
- Newly confirmed: Cycle 08 product vocabulary and state language exist in current source and focused widget tests.
- Corrected: the Didactic checkpoint statement that no Flutter implementation exists is historical within its earlier segment, not current branch truth.
- Contradicted: no current evidence contradicts the preserved rule against automatic maturity promotion.
- Unresolved: whether existing KANBAN concepts fully own Store identity, durable submission idempotency, and schema-migration teaching needs.
- Prospective: a bounded next-cycle lesson/evidence exercise covering identity, transaction/idempotency, migration, and derived projections.
- Deferred: authentication, real synchronization, backup/restore, production release, and broader analytics teaching until corresponding project boundaries activate.

## 9. Recommendation and stop condition

Main should use this assessment as Didactic input for later reconciliation. A subsequent FLX-PRM-04/PDR-A pass may update permanent Didactic memory, but this Ordinary assessment authorizes no such promotion.

Stop reached: the bounded Didactic investigation and single authorized stage append are complete. No architecture selection, Operational acceptance, source change, methodology change, permanent-memory change, J change, or other domain-stage change is included.

---

# C09-R01 — Didactic Investigation: Product and Database Expansion Vocabulary

> Sequence: FLX-INV-02 — Investigative Sequence
> Role: Didactic Chat [A]
> Round or unit: C09-R01
> Cycle: 09 — Local Product and Database Expansion
> Branch: `intermid-cycle-recovery`
> Baseline / inspected HEAD: `f81fa8bd0ba8542804c9779f6ad3e234651b5cc3`
> Required ancestry: `801e3940c972bac88b039e18357dbe006e94760a` — verified
> Authority: investigate learner-facing vocabulary and append this marked round only
> Writable surface: `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
> Evidence boundary: source, tests, contracts, current notebook memory, and explicit human/Main product direction; no test rerun, learner interview, maturity promotion, source validation, permanent-memory update, or implementation authority

## 1. Round delta

### Newly inspected

- the current responsive navigation and the implemented `Purchase`, `Products`, and `History` pages;
- application contracts for catalogue queries, Purchase registration, and History;
- Product, Product code, quantity, Purchase, Store, and ID domain vocabulary;
- Drift schema vocabulary and v1-to-v2 migration language;
- identity, normalization, local repository, migration, and widget tests;
- current Main recovery reconciliation and paired B/H evidence;
- targeted KANBAN, glossary, concept-map, and lecture-register ownership.

### Retained by reference

- implementation evidence is not learner-maturity evidence;
- a local pending event is not synchronization;
- a staged Item is not a registered Purchase Item;
- Product record identity, visible Product code, semantic identification facts, and advisory similarity are different concepts;
- registered Purchases remain immutable/read-only at the current product boundary.

### Corrected

- Cycle 09 navigation is broader than the implemented three-destination scaffold; `Products` is current source vocabulary, while `Catalogue` is the accepted destination term for the planned product surface.
- Decimal acceptance is uneven: money parsing in Purchase already converts comma to point, but dimensional quantity parsing accepts only a decimal point. The product direction therefore describes required convergence, not current uniform behavior.
- Unit support exists in the domain for `kg`, `g`, `L/l`, `ml`, and `un/unit`, but current Product and Purchase forms hard-code `MeasurementKind.mass`; visible support for volume and count is not established.
- The current `Product code` is user-visible and account-local. It must not be described as the internal Product ID.

### Contradicted or overloaded

- Current `Products` naming conflicts with accepted navigation vocabulary `Catalogue`, though `Product` remains the correct entity term inside the Catalogue.
- Current generic `Create anyway` can sound like bypassing an exact collision. It is defensible only for advisory similarity; it must never bypass an exact Product-code or exact-identification collision.
- Current error handlers frequently catch any failure and return `Check the details and try again`; this hides whether the problem is input, collision, missing Store, persistence, or an unknown registration outcome.
- Schema `userProductCode` columns are nullable after migration, while the domain normalizer and current creation UI require a non-empty code. This is an implementation/schema evidence conflict, not authorization for [A] to choose the resolution.
- `package(s)` is displayed for every History Item even though BULK vocabulary should emphasize amount bought and price per unit rather than packaged-unit counting.

### Unresolved

- whether `Person` should label the optional value on a Purchase while `People` labels its Settings collection;
- whether `nickname` is sufficiently clear or should be presented as `Nickname` with helper text such as “the label you recognize”;
- exact visible wording for archived People and Payment Methods in historical filters;
- whether a Product code is always user-supplied, may be generated, or may be absent for migrated rows;
- how ambiguous search is produced, because current search is an in-memory substring filter and does not expose an ambiguity state;
- which failures can guarantee that no Purchase was registered and which require an “outcome unknown” recovery path.

### Prospective

- Home, Lists, Catalogue details, Settings management, optional People/Payment Methods, exact Product lookup, selected-History actions, and specific recovery messages;
- Analytics and Household as visible future/PIN destinations only;
- CSV export and PDF-first “Share as list” as planned History actions.

### Deferred

- authentication, API, Neon, synchronization, production distribution, registered Purchase edit/delete, manual list creation, and final Home copy;
- automatic Product merge and any claim that advisory similarity establishes identity.

## 2. Implementation vocabulary actually observed

Current user-facing source exposes:

```text
Purchase
Products
History
Purchase draft
Choose Store / Create Store
Find or create Product
Product code / Product name / Brand
Packaged / Bulk
Package size / Package unit
Total amount bought / Unit / Packages bought / Line total
Add staged Item / Save staged Item / Remove staged Item
Similar Product found / Use this Product / Create anyway
Review purchase / Register purchase
Purchase registered locally.
Purchase History / Purchase Item(s)
Price change in your purchases
Retry
```

The implementation also communicates that data is stored on the device, synchronization is inactive, and export/restore are not yet provided. It does not currently present Home, Lists, Catalogue, Analytics, Household, Guide, Documentation, Settings, People, Payment Methods, Product details, CSV export, or PDF sharing.

Domain/schema/test vocabulary includes `ProductId`, `ProductCode`, `identityKey`, `normalizedUserProductCode`, `exactIdentityKey`, `ProductDraft`, `ProductReference`, `PurchaseItemDraft`, `NormalizedQuantity`, `MeasurementKind`, `CanonicalUnit`, `SyncEvent`, `PendingEvent`, and migration terminology. These are not all suitable visible labels.

## 3. Accepted user-facing vocabulary and status

The accepted navigation labels are:

```text
Home · Lists · Purchase · History · Catalogue · Analytics
Household · Guide · Documentation · Settings
```

Status must remain explicit:

- `Home`, `Lists`, remodelled `Purchase`, remodelled `History`, remodelled `Catalogue`, Product details, and Settings management are accepted Cycle 09 direction but not observed implementation.
- `Analytics` and `Household` are visible future/PIN destinations, not implemented features.
- `Guide` and `Documentation` are accepted destinations; their content and implementation evidence remain prospective.
- current `Products` should be treated as implemented legacy/scaffold navigation vocabulary, not silently equated with completed `Catalogue` behavior.

## 4. Conceptual distinctions that must survive implementation

| Distinction | Required learner-facing meaning |
| --- | --- |
| Product ID vs Product code | Product ID is an internal stable record identity; Product code is a visible lookup/reference value. |
| Product code lookup vs exact identification lookup | Code alone may locate a Product; otherwise the exact normalized identifying fields locate it. These are two exact routes, not fuzzy search. |
| Exact identification vs normalized spelling | Normalization makes equivalent spelling/unit representations comparable; the identification set decides which normalized facts constitute one Product. |
| Exact match/collision vs similar Product | Exact equivalence refers to the existing Product; similarity is advice and requires a human choice. Similarity never merges automatically. |
| Product identification vs idempotency | Product identification answers “which Product?”; idempotency answers whether retrying one operation produces the same effect rather than a duplicate effect. |
| Product vs Purchase Item | Product owns reusable identity facts; Purchase Item owns transaction facts such as amount, package count, unit, and price. |
| Draft Item vs registered Purchase Item | A draft line may be edited or removed before registration; registered history remains read-only in Cycle 09. |
| Package quantity vs packages bought | Package quantity describes one packaged Product; packages bought counts packages in this Purchase. |
| Amount bought vs price per unit | Amount bought is the BULK quantity purchased; price per unit is its comparable commercial rate, not the total paid. |
| Raw history vs Lists estimate | Purchases are recorded facts; Lists statuses are derived personal estimates based on available history. |
| Local label vs payment credential | Payment Method is an optional nickname/reference only; it stores no card, bank, or payment credential. |
| Archived vs deleted | Archived labels stop ordinary new selection but remain intelligible wherever older Purchases reference them. |

## 5. Candidate Home-card wording and evidence limits

These are Didactic candidates for Main/product review, not final copy:

### Recent updates

> Markei is becoming one Flutter application for desktop and mobile. The current beta records Products and Purchases in a local database and shows Purchase History.

Evidence limit: “one Flutter application” describes the maintained codebase direction; it does not prove equal platform acceptance, distribution readiness, or feature parity on every host.

### Scheduled updates

> Next, Markei will expand Home, Lists, Purchase, History, Catalogue, Product details, and local Settings. Analytics, Household features, synchronization, and distribution remain future work.

Evidence limit: planned work must use future language and must not imply a delivery date.

### What Markei is for

> Markei helps you record everyday purchases and use your own history to organize Products, compare observations, and estimate when something may be needed again.

Evidence limit: “estimate” and “may” prevent derived personal cycles from sounding like objective stock knowledge.

### Mid-term perspectives

> Optional synchronization may later let a user carry their data across devices. Normal use today is local and does not require a network.

Evidence limit: optional synchronization is future; a local pending-event row is not synchronization.

### How Markei works

> Purchases are saved in an offline-first database on your device. Markei derives views and comparisons from the history you register; these results are estimates, not direct measurements of your cupboard.

Evidence limit: “offline-first” should not be expanded into backup, restore, or multi-device claims.

### For developers

> Markei is an evolving cross-platform Flutter project. Technical documentation and a provisional GitHub project link will be added here later.

Evidence limit: no link exists in the inspected UI. The statement about no developer retention or development-side analytics should be phrased narrowly: “At this stage, normal local use sends no user data or usage analytics to the developer.” It must be revisited if crash reporting, telemetry, external links, API, or synchronization are introduced.

## 6. Lists: status and estimate wording

`Lists` is a derived-view destination, not a manual-list editor. The clearest status language is:

| View | Recommended explanation |
| --- | --- |
| Storage | Products estimated to remain available, based on your Purchase history. |
| Shortage | Products approaching their estimated next-Purchase time. |
| Market | Products whose estimated personal Purchase cycle has ended. |
| All | All Products in the current derived view, including those without enough history. |
| Not enough history | Markei does not yet have enough comparable Purchases to estimate this Product’s cycle. |

Use `estimated to remain`, `approaching`, and `estimated cycle has ended`. Avoid bare `remaining`, `ending soon`, or `ended`, which can sound like observed inventory facts. `Expected next Purchase` is acceptable when paired with “based on your history”; it describes a personal estimate, not a scheduled event or objective forecast.

## 7. Product identification, lookup, and collision wording

Recommended visible structure:

- `Product code` — “Enter the visible Product code to find an exact match.”
- `Product details` — “Or identify the Product by its exact details.”
- PACKAGED helper — `Name + Brand + package quantity and unit`.
- BULK helper — `Name + Brand`.
- exact existing Product — “This Product already exists. Use the existing Product.”
- code collision — “This Product code is already used by another Product. Open that Product or enter a different code.”
- advisory similarity — “A similar Product was found. Compare the details before choosing an existing Product or creating a different one.”
- ambiguous search — “More than one Product matches this search. Choose a Product or add more exact details.”

Avoid `duplicate` without qualification: it may mean the same internal ID, the same code, the same exact identification set, a similar spelling, or a repeated operation. Avoid `upsert` in user copy. `Registration` should describe completing a Purchase, while Product creation should use `Create Product` or `Use existing Product`.

## 8. People and Payment Methods

Recommended collection/field distinction:

- Settings collection: `People`;
- Purchase field: `Person`;
- record label: `Nickname`;
- empty choice: `Not assigned`;
- lifecycle state: `Active` / `Archived`;
- second collection and field: `Payment Methods` / `Payment Method`.

Helper wording:

> People and Payment Methods are optional labels stored locally on this device. They help organize Purchases and are not required.

> A Payment Method stores only the nickname you choose. It does not store card numbers, bank details, or payment credentials.

For History, archived references should remain shown with a qualifier such as `Nickname (archived)`. Filters should include archived labels when historical Purchases reference them; archiving must not make older History appear unassigned.

## 9. Units, decimals, PACKAGED, and BULK

Visible unit vocabulary should be `kg`, `g`, `L`, `ml`, and `un`. Internally canonical `l` and `unit` need not leak into user copy.

Recommended explanations:

- decimal: “Use a comma or point for decimals, for example 1,5 or 1.5.”
- package quantity: “Amount contained in one package, for example 500 g or 1 L.”
- packages bought: “Number of packages bought in this Purchase.”
- amount bought: “Total quantity bought, for example 1,5 kg or 750 ml.”
- BULK price: “Price per kg, L, or unit,” with the applicable unit shown explicitly.

PACKAGED and BULK should not be taught merely as visual form modes:

- PACKAGED Product identity includes name, Brand, package quantity, and unit; its Purchase Item may also record packages bought and total amount.
- BULK Product identity includes name and Brand; the Purchase Item records amount bought and price per unit.

The present source only partially supports this language: quantity normalization understands the required unit families, but the UI currently constructs mass-mode Products and Items, and quantity parsing does not yet accept decimal commas.

## 10. Error and recovery-message structure

Every failure message should answer:

```text
What happened?
Why, when it is safe and known?
What can the user do next?
Was any data kept or possibly registered?
```

Candidate patterns:

| Failure | Explanation and next action |
| --- | --- |
| Invalid unit | “This unit does not match the selected quantity type. Choose kg/g for mass, L/ml for volume, or un for count.” |
| Invalid decimal | “Enter a number using a comma or point, such as 1,5 or 1.5.” |
| Missing identity field | “Add the fields required to identify this Product: …” with PACKAGED/BULK-specific fields. |
| Code collision | “This Product code is already used. Open the existing Product or enter another code.” |
| Exact Product exists | “This exact Product already exists. Use the existing Product; Markei will not create another.” |
| Ambiguous search | “More than one Product matches. Choose one or add more exact details.” |
| Missing Store | “Choose an existing Store or add a Store nickname before registering the Purchase.” |
| Invalid quantity | “Enter an amount greater than zero and use a unit accepted for this Product.” |
| Database failure before commit is known | “The Purchase was not registered. Your draft is still available. Try again.” |
| Unknown registration outcome | “Markei could not confirm whether the Purchase was registered. Keep this draft and check History before trying again.” |

The last two states must not be collapsed. A generic database exception does not by itself prove whether a transaction committed, rolled back, or became uncertain from the caller’s perspective.

## 11. Existing KANBAN ownership

No new canonical concept is required merely to express most Cycle 09 vocabulary. Existing owners include:

- `&&&02 Raw Data Versus Derived Data` — Purchase facts versus Lists/status estimates;
- `&&&03 Naming as Data Contract` — stable navigation, field, status, and error vocabulary;
- `&&&04 Resource Ownership and Lifetime` — draft, persisted history, active/archived labels, and local-state lifetimes;
- `&&&05 Evidence State and Validation Boundary` — implemented/planned/validated/future distinctions and truthful Home claims;
- `&&&06 Stable Identity` — internal Product ID and referenced archived records;
- `&%%03 Presentation Adapter` — turning domain failures and states into useful user language;
- `&%%04 Database Row, Domain Model, and View Model` — internal IDs/schema names versus visible labels and projections;
- `&%%07 Reusable Catalogue` — Catalogue Product reuse;
- `&%%08 Product Identification Set and Deterministic Normalization` — exact PACKAGED/BULK identification and normalized spelling;
- `&%%09 Purchase Aggregate` and `&%%10 Purchase Item` — Purchase/Item ownership and read-only registered history;
- `&%%12 Offline Queue and Idempotent Delivery` — operation idempotency, explicitly distinct from Product identification;
- `&%%15 Dimensional Quantity` — mass, volume, count, unit conversion, and decimal representation;
- `&%%16 Monetary Minor Unit` — stored money versus visible decimal price;
- `&%%17 Versioned Analytic` — derived estimates and future Analytics boundaries;
- `%%%01 SQLite Initialization Versus Migration` and `%%%04 Relational Schema and Referential Integrity` — local database expansion and archived-reference preservation.

No maturity change is supported by this investigation.

## 12. Genuinely new concept candidates

These remain candidates pending later evidence and duplicate-ownership review:

1. **Error Taxonomy and Recovery Contract** — distinguishing validation, conflict, ambiguity, persistence failure, and unknown outcome while preserving a useful next action. Existing `&&&03`, `&&&05`, and `&%%03` may already own much of it; a new concept is justified only if implementation creates a reusable error model.
2. **Lifecycle Archiving and Historical Reference** — active/archived organizational labels that remain resolvable in immutable history. This may be an extension/example of `&&&04`, `&&&06`, `&&&10 Historical Integrity`, and referential integrity rather than a new concept.
3. **Personal Estimate Versus Observed Inventory** — communicating derived cycle status without asserting physical stock. This likely extends `&&&02` and `&%%17`; it should not be created separately unless the estimate model gains independent reusable structure.

No candidate is automatically created or promoted in C09-R01.

## 13. Learner questions requiring later evidence

1. Can the learner explain why a Product code is not the Product ID?
2. Can the learner identify the exact PACKAGED and BULK identification sets without adding Purchase Item facts?
3. Can the learner explain why normalized equivalence may establish an exact match while similar spelling cannot?
4. Can the learner distinguish Product identification from operation idempotency using a retry example?
5. Can the learner explain why `Storage` is an estimate rather than an inventory observation?
6. Can the learner map package quantity, packages bought, amount bought, line total, and BULK price per unit to their correct owners?
7. Can the learner explain why an archived Person remains visible in older History?
8. Can the learner classify an error as validation, collision, ambiguity, database failure, or unknown outcome and choose a safe recovery action?
9. Can the learner state which Home claims are implemented facts, recorded evidence, accepted direction, or future work?
10. Can the learner explain why decimal-comma support in money does not prove decimal-comma support in quantity?

## 14. Round classification and handoff

- **Retained:** established identity, draft/history, raw/derived, local/sync, and evidence-boundary distinctions.
- **Corrected:** current versus accepted navigation; Product code versus internal ID; uneven decimal support; domain unit capability versus visible UI capability.
- **Superseded:** none of the prior B round is erased; current Cycle 09 findings append a narrower product-language investigation.
- **Contradicted:** treating current generic errors as adequate; treating `Create anyway` as valid for exact collisions; treating all unit families and decimal commas as already supported by the UI.
- **Unresolved:** code optionality/migration semantics, archived-filter presentation, search ambiguity, unknown-outcome detection, and final Home copy.
- **Prospective:** Cycle 09 Home, Lists, Catalogue, Product details, Settings labels, selected-History actions, units, exact lookup, and recovery contracts.
- **Deferred:** authentication, API, Neon, synchronization, production distribution, registered Purchase mutation, manual lists, and implemented Analytics/Household claims.

### Performance improvement achieved

The round converts a broad Cycle 09 vocabulary brief into a source-grounded map of implemented, accepted, conflicting, prospective, and deferred language. It identifies exact conceptual owners and isolates five implementation-facing language conflicts: navigation naming, code/schema optionality, decimal inconsistency, unit/UI inconsistency, and generic error collapse.

### Narrower next question

Main should reconcile whether Cycle 09 first freezes the user-visible vocabulary contract and error taxonomy before schema-bearing People/Payment Method and Product-identity changes, while preserving these findings as Didactic requirements rather than architecture selection.

### Evidence still missing

- final product copy approval;
- implemented Home/Lists/Settings/History-selection surfaces;
- specific error types and commit-outcome evidence;
- exact search behavior and collision recovery;
- learner explanation/application evidence.

### Human decisions

- confirm `People` for the collection and `Person` for the Purchase field;
- confirm whether migrated/created Products may omit a visible Product code;
- confirm the intended wording for archived labels and unknown registration outcomes.

### Exit readiness

C09-R01 Didactic investigation is complete and ready for Main reconciliation under FLX-INV-02. It does not activate Codex, promote permanent memory, change KANBAN maturity, select architecture, or claim Operational validation.
