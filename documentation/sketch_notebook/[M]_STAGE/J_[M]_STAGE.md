# J_[M]_STAGE

> Cycle: 08 — Shared-Client Product Beta
> Round: C08-R01 Main reconciliation
> Status: PROVISIONAL MAIN SYNTHESIS — NOT AUTHORIZED FOR CODEX
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> Entry baseline inspected by A/B/C: `60105fab8eac4ac858d8a36674e358737e1c9f98`
> Inputs: `A_OPERATIONAL.md`, `B_DIDACTIC.md`, `C_DESIGN.md`
> Authority: Main Chat [M] under human supervision
> Scope: Cross-domain reconciliation and next-round staging direction; no implementation authority

---

# 1. Reconciliation boundary

This section reconciles Cycle 08 Round C08-R01 functional investigation.

Input blobs:

- Operational A: `11db9c9532377296538f4eac1999961d20c0a99c`;
- Didactic B: `bfa8667f23a55860e2a2959e86730169dd286f5a`;
- Design C: `ea2ea564d098a89f23d3519989144a2602d29aba`.

The required branch contains three narrow A/B/C publication commits after the Cycle 08 entry baseline. Each report inspected repository truth against the named Cycle 08 branch. A and C used remote GitHub evidence because their working spaces were not usable checkouts; B additionally verified a clean local checkout at the entry baseline.

This difference affects local-worktree evidence only. It does not create a substantive conflict in the repository findings.

J does not promote A/B/C into permanent memory. It classifies their agreement, disagreements, proposed product direction, human decisions, and the next staging route.

# 2. Accepted carried baseline

The following is accepted prior evidence and remains protected:

- Cycle 07 closed at the shared-client technical-foundation boundary.
- The Python/PySide6 beta, its database, tests, packaging history, and rollback value remain protected.
- The Flutter client remains isolated in application-private storage and does not open the Python database.
- Flutter/Dart runs on Windows and Android within the evidenced debug/local boundary.
- The repository contains an inward dependency direction:

```text
Flutter presentation
→ application commands and query ports
→ independent Dart domain
← local infrastructure adapters implement ports
→ Drift-managed application-private SQLite
```

- Product has distinct internal identity, visible user code, display facts, and normalized identification facts.
- Exact normalized equivalence may support reuse; similarity remains advisory and never auto-merges.
- Purchase owns one or more immutable registered Items.
- Local registration atomically persists catalogue resolution, Purchase, Items, local event preparation, pending queue state, and Device-sequence advancement.
- Raw Purchase facts remain authoritative; projections and analytics remain rebuildable and versioned.
- A persistent installation-local Device UUID exists, but current-Device selection remains prototype-only.
- Local queue/event preparation is not synchronization.
- The present Flutter UI is a functional scaffold, not accepted product or visual design.
- Cycle 09 retains account/API/Neon/synchronization.
- Cycle 10 retains production hardening, signing, distribution, support, and controlled release.

# 3. Repository capacity for Cycle 08

A/B/C agree that the existing repository can support an additive local-first product-beta cycle without cloud infrastructure or an immediate framework replacement.

Existing capacity includes:

- explicit Flutter composition;
- domain/value models independent of widgets and Drift;
- Product and Store records;
- Catalogue query boundaries;
- multi-item Purchase validation;
- atomic local persistence;
- History summary projection;
- Drift v2 and one evidenced migration;
- versioned semantic fixtures/contracts;
- Flutter unit/widget coverage;
- Windows build/runtime evidence;
- Android debug build/emulator/runtime evidence;
- persistent Device identity and sequence;
- protected Python regressions.

Important gaps include:

- coherent responsive navigation;
- first-class Catalogue and Store journeys;
- staged Item edit/remove/cancel/review;
- explicit draft ownership and lifetime;
- safe duplicate-submit/retry identity;
- detailed Purchase History;
- Product observation history;
- versioned personal price comparison;
- complete empty/loading/validation/success/failure/recovery states;
- data-volume and performance evidence;
- migration failure and corruption recovery;
- backup/export promise;
- complete Windows/Android lifecycle and accessibility acceptance;
- explicit installation-to-Device invariant.

# 4. Cross-domain product spine

Main provisionally accepts the following shared product spine for further confrontation:

```text
responsive application shell
→ private reusable Catalogue
→ choose or create Store
→ choose/reuse/create Product
→ advisory similar-Product warning
→ stage Purchase Items
→ edit/remove/cancel
→ review Purchase
→ atomically register once
→ inspect detailed History
→ compare comparable personal Product observations
```

This is provisional product direction, not source authority.

Each step must expose:

- initial/empty state;
- loading or search state where relevant;
- input validation;
- reversible pre-commit editing;
- explicit commit boundary;
- success acknowledgement;
- failure classification;
- safe retry behavior;
- recovery or retained-input behavior;
- accessibility and responsive behavior.

# 5. Reconciled responsibility boundaries

## 5.1 Responsive shell

Provisionally accepted:

- semantic destinations remain shared across Windows and Android;
- narrow and wide layouts may present navigation differently;
- responsive choice follows available space and interaction conditions, not device branding;
- platform hosts do not own Product/Purchase rules;
- widgets own controllers, focus, and mounted-view mechanics;
- product/workflow state must sit below transient widget state when its required lifetime exceeds one mounted view.

Unresolved: exact destination set, breakpoint evidence, router/state mechanism, and restoration depth.

No new state-management or navigation dependency is justified in R01.

## 5.2 Catalogue and Product

Provisionally accepted:

- Catalogue is a private reusable Product collection;
- Product selection is based on visible identity and exact deterministic matching;
- exact reuse and advisory similarity remain distinct;
- similarity requires explicit human choice or “create anyway”;
- automatic merge is prohibited;
- internal UUID, user Product code, and display/identification facts remain distinct;
- Product correction, aliases, retirement, and merge policy remain deferred unless explicitly activated.

Unresolved: whether Catalogue is a top-level destination, whether Product code remains mandatory, and which visible identity facts lead the UI.

## 5.3 Store

Provisionally accepted:

- Store is an account-private reusable identity, not merely free text attached to every Purchase;
- Store selection/create should reuse one query/picker boundary;
- Store UUID is distinct from visible name;
- duplicate advice must not silently merge Stores.

Unresolved: top-level versus picker-only destination and minimum branch/location identity.

## 5.4 Purchase draft and review

Provisionally accepted:

- staged Item and registered Purchase Item are different states;
- draft state should be owned by an application-facing draft coordinator/view model rather than durable Purchase facts;
- widgets retain only view mechanics;
- the draft must support add, edit, remove, cancel, validation, running total, and review;
- registered Purchase facts remain immutable in the current Cycle 08 boundary;
- Purchase editing/deletion after registration remains deferred;
- navigation/rotation/background/process-death survival must be explicitly decided, not accidental.

Unresolved: exact draft lifetime and whether Review is a separate route/dialog or an explicit phase within an editable staged list.

## 5.5 Atomic registration and retry

Accepted distinction:

```text
atomicity
    all local Purchase facts/effects commit together or none do

idempotency
    repeating one logical submission cannot create a second Purchase effect
```

Current repository evidence establishes local atomicity, not duplicate-submit idempotency.

Provisionally favored for confrontation:

- application-generated submission/attempt UUID;
- durable uniqueness at the local persistence boundary;
- identical retry returns the prior result;
- conflicting content under the same submission identity fails atomically;
- UI busy-state prevents ordinary double taps but is not the identity guarantee.

This likely implies a schema/migration and contract decision. It is not authorized yet.

## 5.6 History and analytics

Provisionally accepted:

- History must separate list, Purchase detail, Product observations, and comparison projections;
- widgets must not traverse Drift rows or event JSON;
- comparisons derive from immutable Purchase Item facts;
- first analytics must be reproducible and versioned;
- incomparability is an explicit result, not zero;
- currency and dimensional basis must match;
- UI should initially prefer “price change in your purchases” or equivalent;
- two personal observations do not establish general or official inflation.

Unresolved: first comparison basis, treatment of package-size changes, interval selection, and whether “personal inflation/deflation” appears at all in the first beta.

# 6. User-facing vocabulary boundary

The following provisional vocabulary is safe for the next round:

| Concept | Preferred working language | Avoid |
| --- | --- | --- |
| reusable collection | Catalogue, My products, or Products pending human choice | database catalogue, central catalogue |
| exact reuse | existing Product / exact Product | fuzzy duplicate |
| advisory match | similar Product | duplicate unless exact |
| one-package content | package size | ambiguous Quantity |
| number purchased | packages bought | amount without unit |
| total acquired | total amount bought | normalized quantity as raw receipt fact |
| pre-registration line | staged Item / Item to register | Purchase Item before commit |
| commit step | register Purchase | upsert Purchase |
| derived comparison | price change in your purchases | official/general inflation |
| local preparation | registered locally | synced/uploaded/backed up |
| failure | validation failure, registration failure, or unknown outcome | saved when outcome is unknown |

No KANBAN maturity change is implied. Repository evidence remains distinct from learner mastery.

# 7. Operational validation direction

The next provisional stages should require evidence in layers:

1. repository safety and exact tracked-file inventory;
2. generated-source consistency;
3. formatting, analysis, Flutter tests, and Python regressions;
4. transaction rollback and duplicate-submit behavior;
5. migration, reopen, failed migration, and no-silent-reset;
6. Catalogue/Store/Purchase/History/analytics workflow tests;
7. responsive and lifecycle matrix;
8. bounded volume/performance tiers;
9. Windows and Android builds/runs;
10. manual product acceptance.

Required carried matrix:

- narrow/wide Windows;
- Android portrait/landscape;
- keyboard visibility and focus;
- Back behavior;
- larger text;
- background/resume;
- process termination and cold relaunch;
- registered History persistence;
- explicit draft behavior;
- no duplicate or partial registration.

Exact volume tiers, performance budgets, device classes, and manual-test cadence remain human decisions.

# 8. Migration, recovery, and backup boundary

Provisionally accepted:

- no direct opening or destructive conversion of the Python database;
- Flutter migrations remain forward, explicit, tested from representative prior state, and never silently reset local facts;
- raw facts remain authoritative and analytics rebuildable;
- recovery must distinguish missing database, migration failure, corruption, insufficient storage, and requested reset;
- diagnostics must avoid exposing Purchase contents;
- backup/export requires a versioned format, consistent read boundary, integrity check, and stated restoration promise;
- a UI export button without restoration evidence is not an accepted backup.

Human decision required: implement supported local export/restore in Cycle 08, or explicitly ship a device-local beta with a clear destructive-loss boundary until later recovery work.

# 9. Installation–Device debt

The current first-20/earliest-UUID selection remains bounded prototype debt.

Cycle 08 must:

- avoid deepening reliance on arbitrary selection;
- preserve Device identity through ordinary reopen/upgrade evidence;
- define how draft/backup/restore interacts with installation identity;
- keep Device distinct from Account authentication.

Hard requirement before Cycle 09:

```text
one local installation relation
→ references exactly one current Device
→ bootstrap is idempotent and concurrency-safe
→ sequence ledger belongs to that Device
→ historical Devices remain addressable
→ restore does not accidentally clone Device identity
```

Unresolved: materialize this during Cycle 08 hardening or carry it as an explicit Cycle 09 entry gate.

# 10. Conflicts and drift requiring handling

## 10.1 J filename drift

`INDEX.md` and some reports name `J_MAIN_STAGE.md`; the actual active file is:

`documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`.

This is methodology/navigation drift. It does not authorize a rename or methodology edit during product staging.

## 10.2 Main continuity staleness

Older headers in 00/06 and the three permanent checkpoints retain Cycle 07 metadata. Their latest temporal sections control current recovery. Refresh is deferred to the appropriate reconciliation transition.

## 10.3 Local-checkout evidence asymmetry

B verified a local clean checkout. A/C lacked usable checkouts and used pinned GitHub evidence. Before Codex, a usable clean checkout plus `git ls-files` inventory is mandatory.

## 10.4 Store identity asymmetry

Product identity rules are materially stronger than Store reuse/branch rules. Store identity must be resolved before schema or UI instructions become executable.

## 10.5 Quantity ownership ambiguity

Current UI terminology collapses package size, package count, purchased amount, and normalized/comparable amount. Product-language and data-entry decisions must precede implementation.

## 10.6 Atomicity versus idempotency

The repository has atomic registration but lacks an accepted safe duplicate-submission invariant. D/E/F must not claim this is already solved.

## 10.7 Provisional D/E/F semantics

Existing methodology normally treats Main-approved D/E/F as implementation authority. Cycle 08 explicitly uses iterative D/E/F drafts.

Every intermediate file must contain:

```text
Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
```

Only explicit final human/Main activation makes D/E/F executable.

# 11. Human decision register

Decisions should be answered before enriched implementation staging.

## Product/navigation

1. Is Catalogue a top-level destination, primarily a Purchase selection surface, or both?
2. Is Store a top-level destination or picker/create flow only?
3. Should the UI title use Catalogue, Products, or My products?
4. Is Product code mandatory, optional, or advanced/internal-facing?

## Quantity and Store identity

5. For packaged goods, should users enter package size plus package count and derive total purchased amount, or enter all three with consistency validation?
6. What minimum facts distinguish Stores: normalized name only, optional branch/location label, or another visible identifier?

## Draft and registration

7. Must drafts survive tab changes, backgrounding, rotation/resize, or full process death?
8. Is Review a separate route/dialog or an explicit phase in the editable staged list?
9. Is a durable submission UUID accepted for Cycle 08?
10. For identical/conflicting retry, what result and user language should be shown?

## Analytics

11. Is the first comparison purchased-unit price, package-unit price, or a narrower Product-mode subset?
12. Should the UI use only “price change” initially, with personal inflation/deflation deferred or secondary?
13. Which two observations or time interval does the user select?

## Recovery and acceptance

14. Must Cycle 08 include supported export and restore, or may it ship with an explicit local-only data-loss warning?
15. What Catalogue/History volumes and response-time budgets define beta acceptance?
16. Which Android devices and Windows resolutions/scaling combinations are required?
17. Is manual platform acceptance required after every product sprint or at integration/final gates?
18. Must the installation–Device invariant be fixed in Cycle 08 hardening or only before Cycle 09 begins?

# 12. Provisional Cycle 08 sequence

Main provisionally recommends:

```text
Sprint 01
    product decisions + repeated A/B/C ↔ J ↔ provisional D/E/F

Sprint 02
    responsive shell + explicit presentation-state/error boundary

Sprint 03
    Catalogue + Store + Purchase draft/edit/remove/review
    + accepted duplicate-submit boundary

Sprint 04
    History detail + Product observations
    + first versioned price comparison

Sprint 05
    migration/reopen/recovery
    + backup/export decision
    + data-volume/performance
    + Windows/Android lifecycle acceptance
    + installation–Device disposition
```

Main may split schema-bearing idempotency from the broader UI workflow if risk or reviewability requires it.

# 13. Provisional D/E/F preparation constraints

The next Main transition may populate D/E/F only as enriched drafts.

Every file must begin with:

```text
Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
Round: C08-R01
Purpose: Domain confrontation; no implementation authority
```

## D_OPS_STAGE should draft

- repository/checkout preflight;
- existing validation baseline;
- responsive/lifecycle matrix;
- migration/recovery/data-volume gates;
- backup/export acceptance alternatives;
- exact cost and stop conditions;
- no host or source mutation.

## E_DDC_STAGE should draft

- selected/provisional product vocabulary;
- validation, success, failure, retry, and recovery language;
- quantity terminology;
- History/analytics claims;
- learner-evidence boundary;
- no KANBAN promotion.

## F_DSN_STAGE should draft

- responsive shell responsibility;
- destination alternatives;
- draft coordinator and lifetime alternatives;
- Product/Store identity;
- atomicity/idempotency distinction;
- History/analytics ports;
- schema/dependency consequences;
- Device invariant timing;
- reversibility and non-goals.

These drafts must expose alternatives and questions rather than prescribe source edits.

# 14. Next round route

```text
C08-R01 A/B/C
→ this J reconciliation
→ human answers the decision register where possible
→ Main writes provisional D/E/F
→ O/A/D confront J + provisional D/E/F
→ replace A/B/C as C08-R02
→ Main enriches J and replaces provisional D/E/F
→ repeat until scope, language, files, schema effects,
   rollback, validation and non-goals are stable
→ explicit final human/Main activation of D/E/F
→ PRI-CODEX
→ Codex materialization
→ G/H/I
→ PDR2 permanent reconciliation
→ Main continuity refresh
```

# 15. Authority state

```text
Cycle 08: active
Round C08-R01 domain investigation: reconciled provisionally in J
A/B/C: evidence and proposals, not canon
J: Main synthesis, not implementation
D/E/F: not yet populated for this round
Codex: inactive
source/dependency/schema/tool changes: unauthorized
permanent-domain promotion: inactive
Cycle 09/10: scheduled and inactive
```

This J section authorizes only the next human-decision and provisional-staging round. It does not authorize implementation, commits outside named staging, or Codex execution.

---

<!-- RECONCILIATION_MARKER:C08-C08-R02-2026-07-13 -->
# Cycle 08 Round C08-R02 — Main Reconciliation

> Status: PROVISIONAL MAIN SYNTHESIS — NOT AUTHORIZED FOR CODEX  
> Protocol: `MJR-03`  
> Repository: `gus-i-gu/markei`  
> Branch: `cycle-08-shared-client-product-beta`  
> Previous controlling reconciliation: C08-R01 in this file  
> Inputs: latest appended C08-R02 sections of A/B/C, preceding J, provisional D/E/F, and bounded source inspection  
> Authority: Main synthesis only; no source, dependency, schema, host, permanent-memory, or Codex authority

## 1. Reconciliation identity and evidence

The required branch advanced by three narrow cumulative-stage commits after methodology commit `44b50788952947cfb3d23290192ebb3521d3a816`.

Latest input blobs:

- A Operational: `2741396bb98f44266d82abad745eea9af642cc98`;
- B Didactic: `12c3847a09ee07c6dec6e9b6406b001aad39a128`;
- C Design: `ea558a817d6bdb422b87b670352e2319859d44e1`;
- preceding J: `cfd6bef06f30f339a767a6518ef9a05884a316ff`;
- D: `7ba7ed1109a524ed9019da99c49c890320b068c3`;
- E: `70caca49b0daf3875ae0789556897f816671b320`;
- F: `ba03f7a585119b72a4bb7155efbdfc1a57b38cf5`.

Main independently inspected the principal repository structures cited by A/B/C:

- `app/markei_app.dart`;
- `app/pages/purchase_page.dart`;
- `app/pages/history_page.dart`;
- `application/catalogue_queries.dart`;
- `application/register_purchase.dart`;
- `application/purchase_history.dart`;
- Product, Purchase, Store and shared value objects;
- Drift schema/migration authority;
- local Purchase, query and Device adapters.

Generated Drift code was not treated as independent handwritten authority.

## 2. Accepted carried baseline

C08-R01 remains accepted as provisional orientation where R02 does not correct it:

- Flutter presentation depends inward on application/domain contracts;
- Drift owns local persistence and the atomic Purchase transaction;
- Python/PySide6 and its database remain isolated and protected;
- Product internal ID, visible code, display facts and normalized identity remain distinct;
- exact equivalence and advisory similarity remain distinct;
- registered Purchase facts remain immutable in the present boundary;
- raw facts remain authoritative and analytics rebuildable;
- local event/queue state is not synchronization;
- Device selection remains prototype debt;
- no new state, navigation or analytics dependency is justified;
- Cycle 09/10 boundaries remain inactive.

## 3. New repository facts

The following are repository facts, not prospective design:

1. `MarkeiApp` exposes exactly two top-level destinations: Purchase and History.
2. `IndexedStack` preserves the mounted Purchase page across current tab changes.
3. Purchase draft state lives in `_PurchasePageState` through controllers, `_items`, `_warnings` and `_message`.
4. The current draft does not expose edit, remove, cancel or explicit review.
5. `PurchasePage._addItem()` always constructs `NewProductReference`; existing Product selection is not exposed.
6. Catalogue ports can list Products/Stores and compute similarity, but they are latent application capacity rather than a completed user journey.
7. Current similarity is advisory and based on the implemented Product policy; it neither proves identity nor gates staging.
8. Product code is mandatory in the Dart domain and current UI, although corresponding database columns permit legacy nulls.
9. Current Product and purchased-quantity entry is hard-coded to MASS.
10. Current Purchase UI assumes BRL and parses non-negative values with at most two decimal places.
11. `RegisterPurchaseCommand` contains free-text `storeName` and has no submission identity.
12. Each registration generates fresh Purchase/Event identities; transaction atomicity exists, command idempotency does not.
13. Store reuse is exact trimmed display-name equality. Stores have UUID record identity but no normalized uniqueness, branch/location model or duplicate-warning policy.
14. `LocalQueryRepository.listRecentPurchases()` returns a fixed maximum of 50 summaries and issues a separate Item-count query per Purchase.
15. History has no detail, Product-observation or comparison query.
16. `HistoryPage` currently maps loading/query error/no data toward the same empty presentation.
17. Purchase failures expose raw exception strings, and success exposes Device sequence as ordinary UI text.
18. Drift v2 supports v1→v2 only; unsupported upgrades throw.
19. Purchases have no durable submission/attempt uniqueness.
20. Device bootstrap scans the earliest twenty Account Devices and selects the first UUID-v4 candidate.

## 4. Grouped structural model

### 4.1 Entrypoint and composition

Current:

```text
main
→ MarkeiComposition.appPrivate()
→ app-private LocalDatabase
→ LocalQueryRepository
→ local-account placeholder
→ Device lookup/create
→ MarkeiApp
```

Responsibility is structurally sound, but startup database/identity failure lacks an inspected user-facing recovery boundary.

Prospective view:

- keep composition explicit;
- inject future shell/draft/result owners here;
- do not move domain rules into platform hosts;
- add startup failure classification only through an application/presentation boundary.

### 4.2 Presentation shell

Current:

- local selected-index state;
- Purchase/History destinations;
- mounted-page retention through IndexedStack;
- refresh invalidation through a signal.

Prospective view:

- preserve semantic destination identity;
- choose NavigationBar/Rail or equivalent from constraints;
- keep SDK-level state until evidence requires a package;
- add typed loading/empty/error/result states;
- test resize, focus, Back and destination preservation.

Correction to R01: tab-switch survival already exists. Background, rotation restoration and process-death survival remain open.

### 4.3 Catalogue and Product resolution

Current layers:

```text
domain
    Product code + internal Product ID + normalized exact identity

application
    listProducts + similarityWarnings

adapter
    exact reuse + duplicate-code rejection + account checks

presentation
    always submits NewProductReference
```

Therefore Catalogue identity and query capacity exist, but browse/search/select/reuse is not a visible product workflow.

Prospective view:

- explicit existing/new Product resolution;
- bounded client filtering or repository search after volume evidence;
- exact candidate, similar candidates, explicit reuse, or create-anyway;
- no automatic merge;
- retain mandatory Product code unless a separately accepted cross-layer change makes it optional.

### 4.4 Store identity and selection

Current:

- durable Store UUID;
- free-text command input;
- exact trimmed same-name reuse;
- no normalized key, branch/location or uniqueness constraint.

Prospective view:

- existing/new Store reference in the registration command;
- Store query/picker;
- explicit minimum identity policy;
- normalized matching only after collision/migration policy is settled;
- never silently merge existing Store UUIDs.

### 4.5 Purchase draft and review

Current:

- mutable widget-local list of `PurchaseItemDraft`;
- no draft-line key;
- no edit/remove/cancel/review;
- survives current top-level tab changes only.

Prospective view:

- application-facing, package-neutral coordinator;
- keyed draft lines;
- selected/draft Store;
- add/replace/remove;
- validation and running total;
- explicit review phase;
- busy/failed/succeeded/unknown result algebra;
- session lifetime by default;
- no durable draft schema unless process-death restoration is explicitly chosen.

### 4.6 Registration and submission identity

Current transaction remains accepted:

```text
resolve Store/Product
+ validate Purchase/Items
+ insert facts
+ advance Device sequence
+ insert Event/PendingEvent
= one Drift transaction
```

Prospective idempotency is separate:

```text
SubmissionId created for one submit intent
+ frozen canonical submit content
→ durable uniqueness
→ identical retry returns prior result
→ conflicting reuse fails atomically
```

Main provisionally favors a SubmissionId distinct from PurchaseId and EventId. This remains a schema/application-contract decision, not accepted implementation.

### 4.7 History and analytics

Current:

- summary-only list;
- fixed 50;
- N+1 Item counts;
- occurrence time available in the model but omitted from UI;
- loading/error collapsed into empty;
- no detail/observation/comparison ports.

Prospective view:

1. typed History state;
2. joined or bounded/paged summary;
3. Purchase detail query;
4. Product observation query;
5. pure versioned comparison;
6. explicit incompatible result;
7. query measurement before indexes or cache.

No analytic cache or forecasting is justified.

### 4.8 Persistence, schema and migration

Current stable owner: handwritten Drift declarations and migration strategy.

Potentially independent schema decisions:

- SubmissionId uniqueness;
- Store normalized identity/branch facts;
- Product-code optionality;
- query-performance indexes;
- explicit current-installation relation;
- durable Purchase draft, only if selected.

These decisions must not be bundled automatically. Each requires representative migration fixtures, collision/backfill policy, generated-code reconciliation and no-silent-reset validation.

### 4.9 Device identity

Current local UUID persistence and sequence transaction remain useful.

Prototype limitation remains unchanged:

- current installation is not modelled explicitly;
- multiple UUID candidates are ambiguous;
- first-20 truncation is arbitrary;
- restore semantics are undefined.

This must become an explicit Cycle 08 hardening decision or a hard Cycle 09 entry unit.

### 4.10 Protected legacy boundary

Python/PySide6 remains:

- protected regression baseline;
- behavior and migration reference;
- isolated database;
- rollback boundary.

Cycle 08 does not open, mutate, import or retire it.

## 5. Cross-domain agreements

A/B/C agree that:

- the smallest reversible first implementation boundary is shell/state clarity without schema change;
- current SDK/Flutter primitives are sufficient initially;
- Catalogue/Store application capacity is not the same as a complete UI journey;
- Product code is currently mandatory;
- Store identity is materially weaker than Product identity;
- current UI supports only MASS/BRL despite broader domain types;
- draft-versus-registered state must be explicit;
- edit/remove/review requires a wider owner than the current page mechanics;
- History state and query structure need correction before analytics;
- atomicity and idempotency remain separate;
- submission identity is likely schema-bearing;
- personal price change must use explicitly comparable observations;
- technical identifiers and raw exceptions should not be normal product language;
- no KANBAN maturity changes;
- no state/navigation package is presently justified.

## 6. Corrections to previous J

C08-R01 remains historical orientation but is corrected by this append:

1. “Catalogue workflow capacity” now means implemented domain/query/adapter capacity; presentation selection is absent.
2. Existing tab-switch draft survival is evidenced through IndexedStack.
3. Product code is mandatory in current domain/UI; optionality is structural.
4. Similarity must be described by the current bounded policy, not as a general fuzzy identity model.
5. Store has record identity but no normalized Store identity invariant.
6. Quantity decisions begin from a MASS-only UI, not a presentation already exposing all domain dimensions.
7. BRL/two-decimal behavior is a bounded UI scaffold.
8. History has a concrete state defect and fixed-50/N+1 debt.
9. Registration error/success text exposes implementation detail.
10. Safe duplicate-submit semantics are wholly prospective.

No R01 product-direction conclusion is rejected; its implementation maturity is narrowed.

## 7. Contradictions and unresolved ownership

### 7.1 Product code

Conflict:

- simplest receipt entry may favor optional code;
- current domain makes code mandatory;
- database permits legacy nulls.

Owner: human product decision followed by Design cross-layer reconciliation.

Main cannot infer optionality from UI preference.

### 7.2 Store identity

Conflict:

- reusable Store requires stable selection;
- present model has UUID plus exact display-name reuse;
- branch/location and normalization remain undefined.

Owner: human product definition plus Design identity policy.

### 7.3 Quantity truth

Conflict:

- domain distinguishes dimensions and normalized amount;
- UI records package and purchased fields but forces MASS;
- derived size×count may differ from a receipt-observed total.

Owner: human product/data-entry decision with Didactic language and Design invariants.

### 7.4 Draft lifetime

Known: tab switching survives.

Unknown: route replacement, rotation restoration, background eviction and process death.

Owner: human product expectation plus Design/Operational evidence.

### 7.5 Retry outcome

Busy state can prevent ordinary taps but cannot establish idempotency or unknown-outcome recovery.

Owner: Design application/persistence contract plus Operational failure evidence, subject to human scope.

### 7.6 Backup and Device identity

Restoring facts and cloning installation identity are different operations. A future restore contract must explicitly exclude or regenerate Device identity unless later synchronization semantics define otherwise.

Owner: human beta promise plus Design/Operational recovery contract.

## 8. Prospective structural additions

| Candidate | Responsibility | Existing structures affected | Consequences | Status |
| --- | --- | --- | --- | --- |
| responsive shell state | semantic destinations and constraint-driven layout | `MarkeiApp`, page composition | no schema/dependency expected | highest-priority reversible candidate |
| typed presentation/result state | loading/empty/error/success/unknown without raw exceptions | Purchase/History pages, command/query results, startup composition | no schema; application result mapping | high-priority candidate |
| draft coordinator + DraftLineKey | staged Items, edit/remove/review, totals and submit lifecycle | PurchasePage, PurchaseItemDraft, composition | no schema for session-only lifetime | second bounded candidate |
| Product resolution flow | browse/filter/select exact or create-anyway | Catalogue ports, Purchase page, ProductReference | no immediate schema; volume may affect search design | Cycle 08 core candidate |
| Store reference flow | existing/new Store selection | RegisterPurchaseCommand, Store port/adapter/UI | command change; identity policy may require schema | blocked on Store facts |
| SubmissionId | identify one logical registration | command, result lookup, Purchase/attempt persistence, tests/contracts | schema/migration/unique constraint | isolated schema-bearing candidate |
| History detail/observation ports | expose facts without Drift leakage | purchase_history, LocalQueryRepository, History UI | query changes; indexes only after measurement | Cycle 08 core candidate |
| versioned comparison | comparable personal observations | analytics registry, History observations, Money/Quantity | compute first; no cache/schema | later Cycle 08 candidate |
| explicit installation relation | select exactly one current Device | composition, Device repository, schema | schema/migration/restore semantics | hardening/C09 gate |
| export/restore boundary | versioned consistent user recovery | application port, local adapter, platform sharing | host validation; Device exclusion policy | human decision |

## 9. Schema, dependency and migration outlook

No new dependency is evidenced for:

- responsive shell;
- typed UI states;
- session-only draft coordinator;
- Product/Store picker presentation;
- History detail ports;
- pure first comparison.

Possible schema-bearing work must be split:

1. SubmissionId;
2. Store normalized/branch identity;
3. Product-code optionality;
4. performance indexes;
5. installation relation;
6. durable drafts.

Any accepted schema unit requires:

- explicit next schema version;
- representative v2 fixture;
- collision/backfill policy;
- rollback/failure evidence;
- reopen/restart;
- generated Drift reconciliation;
- protected Python isolation.

## 10. Product and vocabulary decisions

Provisionally safe working language:

- Product or My products in UI; Catalogue remains documentation vocabulary pending decision;
- similar Product, not duplicate, unless exact equivalence is proven;
- package size;
- packages bought;
- total amount bought;
- staged Item;
- Purchase Item after registration;
- review Purchase;
- register Purchase;
- price change in your purchases;
- registered locally.

Avoid in ordinary UI:

- upsert;
- Device sequence;
- Event/cursor;
- Drift;
- UUID;
- synced/uploaded/backed up when not true;
- official/general inflation;
- raw exception strings.

## 11. Validation and evidence outlook

### First schema-free unit

Require later:

- current baseline rerun;
- shell narrow/wide tests;
- destination preservation;
- loading/empty/error distinction;
- privacy-safe messages;
- draft retention across current tab behavior;
- keyboard/focus/larger-text checks;
- Windows/Android smoke;
- Python regressions.

### Draft/Product unit

Require:

- keyed edit/remove/review transitions;
- exact Product reuse;
- similar advisory choice;
- create-anyway;
- account isolation;
- MASS/volume/count decision tests;
- Store selection behavior after identity decision.

### Submission unit

Require:

- identical retry;
- conflicting content;
- concurrent/double call;
- failure before/inside commit;
- restart after commit;
- exactly one Purchase/Event/sequence effect;
- migration/reopen/no-silent-reset.

### History/analytics unit

Require:

- loading/empty/error;
- list/detail consistency;
- paging/query-count evidence;
- bounded volume;
- comparable/non-comparable fixtures;
- algorithm version;
- no forecasting.

## 12. Human decision register

Main carries these decisions forward:

1. top-level destinations: confirm Purchase + Products/Catalogue + History, with Store as picker, or choose another topology;
2. UI word: Products, My products, or Catalogue;
3. Product code: retain mandatory or authorize optionality investigation;
4. quantity input: derive total from package size×count, record total independently, or support both explicitly;
5. Store identity: normalized name only or name plus optional branch/location;
6. Review: explicit phase in the editable flow or separate route/dialog;
7. draft lifetime: app session only or process-death restoration;
8. retry scope: busy-state mitigation first or full durable SubmissionId in Cycle 08;
9. SubmissionId: confirm it remains distinct from PurchaseId and EventId;
10. first comparison: normalized purchased-unit price for same Product/currency/dimension/unit, or another basis;
11. analytics language: price change only or secondary personal inflation/deflation;
12. export/restore promise;
13. Device invariant timing;
14. volume/performance budgets and platform acceptance matrix.

## 13. Deferred work

Still inactive:

- authentication/authorization;
- TypeScript API and Neon;
- upload/download synchronization;
- multi-device convergence;
- central/shared catalogue;
- automatic Product/Store merge;
- registered Purchase editing/deletion;
- forecasting/general inflation;
- iOS acceptance;
- Python retirement;
- production signing/distribution/support.

## 14. Instructions for MDE-04

The next D/E/F append must:

- preserve preceding provisional content;
- classify retained/corrected/superseded/new material;
- use exact symbols confirmed here;
- split schema-free and schema-bearing candidates;
- request the human decisions above;
- end with paired-domain questions and evidence requests;
- remain `PROVISIONAL — NOT AUTHORIZED FOR CODEX`.

D should enrich:

- checkout preflight and present baseline;
- state/error tests;
- query-count and volume evidence;
- lifecycle boundaries;
- migration gates for isolated schema decisions;
- backup/Device recovery alternatives.

E should enrich:

- current versus proposed language;
- Product code and quantity implications;
- Store identity language;
- loading/empty/error/unknown outcome;
- removal of raw exceptions/Device sequence from product copy;
- bounded analytics claims and learner checks.

F should enrich:

- shell state;
- typed result algebra;
- coordinator/DraftLineKey;
- Product resolution;
- existing/new Store reference;
- isolated SubmissionId;
- History ports and comparison;
- distinct schema decisions and migration consequences.

## 15. Next functional round

After MDE-04:

```text
this C08-R02 J reconciliation
→ append D/E/F enrichment
→ human answers highest-impact product decisions
→ O/A/D run ERI-01 + FCA-02 as C08-R03
→ append cumulative A/B/C evidence
→ Main runs MJR-03 again
```

Highest-impact decisions before R03:

- destination topology;
- Product-code policy;
- quantity truth;
- Store identity;
- draft lifetime;
- durable idempotency scope.

## 16. Authority state

```text
C08-R02 A/B/C: published cumulative evidence
this J append: provisional Main synthesis
D/E/F: prior provisional drafts; next enrichment pending
Codex: inactive
source/dependency/schema/host changes: unauthorized
permanent promotion: inactive
```

This reconciliation does not authorize implementation. Only a later explicit human/Main activation may identify controlling D/E/F sections for Codex.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.
