# J_MAIN_STAGE

> Cycle: Intermid Cycle Recovery
> Sequence: FLX-INV-02 — Investigative Sequence
> Round: IRC-R00 — Main Primary Repository View
> Status: PROVISIONAL MAIN SYNTHESIS — NOT AUTHORIZED FOR CODEX
> Repository: gus-i-gu/markei
> Branch: intermid-cycle-recovery
> Primary inspection head: d5b2ad7881563fb00405bbbb52ae020cabe35add
> Source implementation boundary: fb3b7f21e007e383e5951f4bb67b95d283f7a6fc
> Authority: Human-supervised Main Chat
> Scope: Seed orientation for O/A/D investigation; no implementation or permanent promotion

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). This file is the active Main investigative cache from this boundary forward.

# 1. Purpose and incompleteness

This is a partial Main view produced before the first Intermid Recovery A/B/C round.

It establishes:

- the repository and documentation baseline;
- the primary application topology visible to Main;
- knowledge already supported by source or permanent evidence;
- contradictions and gaps that require designation-specific investigation;
- the first O/A/D seed boundary.

It does not:

- replace Operational, Didactic, or Design investigation;
- promote Cycle 08 evidence into permanent memory;
- authorize source, dependency, schema, host, or infrastructure changes;
- activate D/E/F or Codex;
- establish runtime evidence not rerun during this Main inspection.

# 2. Repository and branch boundary

Repository fact:

~~~text
Cycle 08 implementation head
fb3b7f21e007e383e5951f4bb67b95d283f7a6fc

→ Operational reconciliation
→ Intermid Recovery temporal markers and stage reset
→ four-protocol methodology refactor
→ this IRC-R00 Main seed
~~~

The comparison from the source implementation head through the inspected methodology head contains documentation changes only. No Flutter or Python application path changed after the Cycle 08 product implementation.

The forward application client is:

~~~text
clients/markei_flutter/
~~~

The protected desktop beta remains:

~~~text
app/
tests/
packaging/
~~~

The Python/PySide6 beta is a regression, behavior, packaging, and migration reference. The Intermid Recovery investigation must not silently reopen, mutate, merge, or retire its ordinary database.

# 3. Current notebook state of knowledge

## 3.1 Global continuity

00_PROJECT_STATE.md, 05_SESSION_LOG.md, and 06_SESSION_SCHEME.md preserve Cycle 07 and Cycle 08 history but contain no new reconciled Intermid Recovery state after the current marker.

Therefore they are recovery inputs, not sufficient current truth.

## 3.2 Active staging

A_OPERATIONAL.md, B_DIDACTIC.md, and C_DESIGN.md contain only the Intermid Recovery marker and are ready for IRC-R01.

D_OPS_STAGE.md, E_DDC_STAGE.md, and F_DSN_STAGE.md are empty of active authority.

G_OPS_CODEX.md, H_DDC_CODEX.md, and I_DSN_CODEX.md are empty of active evidence.

No current D/E/F or G/H/I content may be recovered from the cleared files. Older evidence must be recovered from permanent memory, repository truth, Git history, or legacy Main reconciliation only when required.

## 3.3 Permanent-memory asymmetry

Operational permanent memory contains a Cycle 08 post-implementation checkpoint and identifies current defects and host-validation gaps.

Didactic and Design permanent checkpoints retain strong Cycle 07 foundations but do not fully absorb the final Cycle 08 product implementation.

Main continuity stops at Cycle 08 entry or earlier planning language.

This asymmetry is the primary reason for the Intermid Recovery investigative round.

## 3.4 Main staging and history

J_MAIN_STAGE.md is the active Main investigative cache.

LEGACY_RECONCILIATION.md preserves archived Cycle 08 Main staging context.

Git history preserves the retired J_[M]_STAGE.md content. Historical staging is evidence and orientation, not current authority.

# 4. Primary Flutter application view

## 4.1 Entrypoint and composition

Current startup:

~~~text
main.dart
→ WidgetsFlutterBinding
→ MarkeiComposition.appPrivate()
→ LocalDatabase.appPrivate()
→ LocalDeviceIdentityRepository
→ LocalPurchaseRepository
→ LocalQueryRepository
→ MarkeiApp
~~~

MarkeiComposition exposes:

- LocalDatabase;
- PurchaseRegistrationRepository;
- CatalogueQueryRepository;
- PurchaseHistoryRepository;
- local AccountId;
- persistent DeviceId.

The application currently uses the placeholder AccountId value local-account. This is a local beta boundary, not authentication.

## 4.2 Presentation topology

MarkeiApp exposes three semantic destinations:

~~~text
Purchase
Products
History
~~~

The shell preserves mounted destinations through IndexedStack and selects compact or wide navigation from available width.

ProductsPage currently provides:

- local Product loading;
- empty, failure, search, and no-match states;
- mandatory Product code;
- Product creation;
- advisory similar-Product lookup;
- explicit create-anyway behavior.

PurchasePage currently provides:

- local Product and Store catalogue loading;
- existing/new Store reference selection;
- existing/new Product reference staging;
- session-only keyed draft lines;
- edit and remove;
- running total;
- review and back-to-edit;
- one in-flight submission guard;
- atomic repository registration;
- MASS + BRL active input boundary.

HistoryPage currently provides:

- loading, empty, error, and data presentation;
- Purchase summaries;
- Purchase detail with Items;
- first Price change in your purchases presentation;
- explicit unavailable comparison results.

## 4.3 Application and domain boundary

Application contracts include:

- CatalogueQueryRepository;
- PurchaseRegistrationRepository;
- PurchaseHistoryRepository;
- RegisterPurchaseCommand;
- ExistingStoreReference and NewStoreReference;
- Purchase history/detail records;
- Product price observations;
- comparable and unavailable price-change results.

Domain structures include:

- AccountId, DeviceId, ProductId, StoreId, PurchaseId, PurchaseItemId, EventId;
- Product and ProductDraft;
- ProductMode packaged/bulk;
- Purchase, PurchaseItem, PurchaseItemDraft;
- ExistingProductReference and NewProductReference;
- Money in integer minor units;
- MeasurementKind mass/volume/count;
- CanonicalUnit kg/l/unit;
- NormalizedQuantity;
- Store;
- SyncEvent and pending state.

The domain can represent mass, volume, and count. The active Purchase UI currently exposes MASS only. The domain’s wider capacity must not be mistaken for implemented UI support.

## 4.4 Local persistence

LocalDatabase uses Drift and app-private SQLite.

Current schema version:

~~~text
2
~~~

Current tables:

- LocalAccounts;
- Devices;
- Products;
- Stores;
- Purchases;
- PurchaseItems;
- SyncEvents;
- PendingEvents;
- SyncState;
- MigrationLedger.

The handwritten migration strategy supports fresh creation and the accepted v1→v2 path. Later upgrade behavior, representative failure recovery, collision policy, no-silent-reset behavior, and the next schema version require investigation before Cycle 09 database expansion.

LocalPurchaseRepository preserves one transaction around Store/Product resolution, Purchase facts, Items, Device sequence, SyncEvent, and PendingEvent.

The local event/queue structures are synchronization preparation. They are not real synchronization.

# 5. Current evidence classification

## 5.1 Repository facts

Implemented in source:

- three-destination responsive shell;
- private Product workflow;
- existing/new Store references;
- multi-line Purchase draft and review;
- atomic local Purchase registration;
- detailed History;
- compatible same-Product price comparison;
- Drift schema v2;
- persistent local Device identity;
- protected Python/PySide6 boundary.

## 5.2 Recorded validation, not rerun in IRC-R00

Cycle 08 permanent Operational memory records:

- six focused widget tests;
- 31 Flutter tests;
- Flutter analysis without issues;
- Windows release artifact build;
- five Python regression tests.

IRC-R00 inspected repository truth but did not rerun these commands. Domain chats must preserve the distinction between recorded evidence and newly reproduced evidence.

## 5.3 Host-unvalidated or incomplete

Recorded gaps include:

- Android APK build for the last product materialization blocked by missing Java/JAVA_HOME on that host;
- no manual Windows product smoke after the final Cycle 08 materialization;
- incomplete Android lifecycle and physical-device evidence;
- incomplete larger-text, keyboard/focus, Back, rotation, background/resume, and cold-relaunch acceptance;
- no current iOS acceptance.

## 5.4 Confirmed defect

The existing-Product draft edit path does not reliably preserve ExistingProductReference.

PurchasePage._editLine restores quantity and price controls but not the Product reference/selection required to save the same existing Product safely.

This is a recovery finding, not implementation authority.

# 6. Structural debt requiring investigation

## 6.1 Database and identity

- Store has durable UUID record identity but no accepted normalized Store/branch identity policy.
- Product code is mandatory for new Products while persistence retains legacy nullable columns.
- Purchases have no durable SubmissionId or equivalent registration-attempt uniqueness.
- current-installation to Device ownership remains prototype-oriented.
- schema evolution after v2 is undefined.
- backup/export and restore identity semantics are undefined.

## 6.2 UI and state

- draft lifetime is mounted application session only;
- process-death recovery is not promised;
- existing-Product edit is defective;
- phone-width long-form registration evidence is incomplete;
- quantity UI is narrower than the domain model;
- Store selection is stronger than free text but Store identity remains weak;
- presentation success/retry/accessibility evidence is incomplete.

## 6.3 Query and analytics

- Product search is bounded local filtering rather than indexed/paged search;
- History volume and query-cost budgets remain undefined;
- performance indexes require measurement rather than assumption;
- price comparison is intentionally narrow and rebuildable;
- broad inflation, forecasting, and analytic caches remain outside current truth.

## 6.4 Synchronization and release

Not implemented:

- authentication or authorization;
- TypeScript API;
- Neon;
- upload/download;
- cursor bootstrap;
- multi-device convergence;
- durable distributed idempotency;
- production signing/distribution;
- final privacy/support/recovery contract.

These are later-cycle boundaries and must not contaminate IRC-R01 unless needed to protect Cycle 09 database decisions.

# 7. IRC-R01 domain seed

## 7.1 Operational seed

Operational must determine:

- exact reproducible checkout, toolchain, test, build, run, and storage state;
- which Cycle 08 evidence remains reproducible now;
- database location, schema/migration behavior, transaction and rollback evidence;
- query cost, catalogue/history volume, and recovery gates needed before Cycle 09;
- Windows and Android host/manual/lifecycle classification;
- generated artifact and repository-hygiene state;
- smallest safe correction/validation sequence after documentation recovery.

## 7.2 Didactic seed

Didactic must determine:

- vocabulary actually expressed by current UI, application contracts, domain objects, schema, and tests;
- distinctions between Product identity/code/similarity, Store record/identity, draft/registered Item, atomicity/idempotency, raw fact/derived price change, local queue/synchronization;
- implemented project evidence versus learner evidence;
- stale or missing permanent Didactic knowledge;
- concepts needed for Cycle 09 database/UI work;
- whether any KANBAN maturity change is evidenced. No change may be inferred automatically.

## 7.3 Design seed

Design must determine:

- current responsibility and dependency topology;
- UI state ownership and lifecycle;
- Product, Store, Purchase, Device, Event, and future Submission identities;
- schema v2 invariants and migration limitations;
- query/projection boundaries and Cycle 09 database/UI expansion candidates;
- which database changes are independent units;
- alternatives, reversibility, development cost, and validation consequences;
- boundaries that must remain inactive until Cycle 10/11 synchronization.

# 8. Required IRC-R01 output discipline

Each domain runs:

~~~text
SEQ-INV-02
→ PRI-[O/A/D]
→ PMC-01
→ ERI-01
→ FCA-02
~~~

Each role writes only its paired file:

~~~text
Operational → DEV_STAGE/A_OPERATIONAL.md
Didactic    → DEV_STAGE/B_DIDACTIC.md
Design      → DEV_STAGE/C_DESIGN.md
~~~

The first round appends below the Intermid Recovery marker.

Required round marker:

~~~text
<!-- ROUND_MARKER:IRC-R01-[ROLE]-2026-07-14 -->
~~~

Each report must distinguish:

- newly inspected;
- retained;
- corrected;
- superseded;
- contradicted;
- unresolved;
- prospective;
- deferred.

Each report must tie material conclusions to exact repository paths, structures, functions, fields, tests, commands, or permanent-memory evidence.

# 9. Main questions for reconciliation after A/B/C

1. What Cycle 08 knowledge is implemented but still absent from permanent Didactic and Design memory?
2. Which Operational claims reproduce on the current host?
3. What is the smallest coherent Cycle 09 database/UI expansion boundary?
4. Which schema changes are necessary versus merely attractive?
5. Which UI behavior requires new persistence, and which can remain session/derived state?
6. Which identity decisions must precede schema v3?
7. Which defects close in the Intermid cycle rather than Cycle 09?
8. Which recovery and performance gates define Cycle 09 entry?
9. Which former Cycle 09 synchronization assumptions must be protected but deferred to Cycles 10–11?
10. What permanent-memory pruning/promotion route should follow the investigation?

# 10. Next route

~~~text
this IRC-R00 partial Main seed
→ O/A/D execute IRC-R01
→ append A/B/C
→ Main runs MJR-03
→ append J_MAIN_STAGE reconciliation
→ Main runs MDE-04
→ populate provisional D/E/F cache
→ decide next investigative round or FLX-PRM-04 recovery
~~~

# 11. Authority state

~~~text
Sequence: FLX-INV-02
Main synthesis: partial and provisional
A/B/C: authorized for IRC-R01 append only
D/E/F: inactive
Codex: inactive
source changes: unauthorized
schema/dependency/host changes: unauthorized
permanent promotion: inactive
Pruning: not yet active
~~~


---

<!-- ROUND_MARKER:INTERMID-RECOVERY-MAIN-RECONCILIATION-2026-07-14 -->

# Ordinary-Sequence Main Reconciliation and Codex Activation

> Date: 2026-07-14
> Sequence: FLX-ORD-01 — Ordinary Sequence
> Authority: Main synthesis and bounded D/E/F activation
> Inputs: A_OPERATIONAL.md, B_DIDACTIC.md, C_DESIGN.md, IRC-R00 repository view
> Status: RECONCILED FOR ONE BOUNDED MATERIALIZATION UNIT

## 12. Sequence reconciliation

The earlier IRC-R00 sections remain the historical investigative seed. The human
subsequently selected the Ordinary Sequence for the domain passes. The completed
A/B/C reports consistently identify themselves as bounded FLX-ORD-01 inputs.

This section therefore supersedes the earlier inactive-D/E/F state for the
single unit declared below. It does not erase the prior investigation or convert
unselected proposals into implementation authority.

Canonical Main-stage path is:

```text
documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md
```

`J_[M]_STAGE.md` is obsolete and must not be recreated.

## 13. Reconciled domain synthesis

### 13.1 Operational

Accepted:

- Application source remains at the inspected Cycle 08 implementation boundary;
  later branch changes are documentation-only.
- The Flutter/Drift client has historically passing focused/full tests, clean
  analysis, a Windows release build, and protected Python regressions.
- Those results were not rerun during the recovery assessment and are not
  present-host acceptance.
- Local registration is organized as one Drift transaction, but executable
  failure-injection evidence remains absent.
- Android validation remains blocked by host Java/JAVA_HOME evidence; final
  manual Windows and physical-device acceptance remain open.
- Existing-Product staged-line editing is a directly observable source defect.
- Tracked Python bytecode and missing/uncertain ignore policy are real hygiene
  debt, but constitute a separate bounded unit.

### 13.2 Didactic

Accepted:

- Product identity, Product code, similarity, Store reference, staged Item,
  registered Purchase Item, atomicity, idempotency, derived price comparison,
  local queue, and synchronization are distinct concepts in the implementation.
- Repository implementation and passing tests are project evidence, not learner
  maturity evidence.
- No KANBAN maturity transition is authorized.
- Permanent Didactic memory is stale relative to Cycle 08 vocabulary, but its
  reconciliation belongs to a later FLX-PRM-04 pass.
- The active source correction should preserve the distinction between mutable
  Item quantities/prices and stable Product reference identity.

### 13.3 Design

Accepted:

- Stable draft-line keys preserve list identity, not Product identity.
- The current edit flow restores quantity/price controls but does not retain the
  original `ProductReference`.
- The smallest correction is presentation-local: edit state must retain the
  complete original Product reference and label while allowing Item values to
  be changed.
- No schema, migration, repository, domain-identity, or synchronization change
  is required for this correction.
- Store normalization, SubmissionId, installation–Device invariants, persisted
  drafts, schema v3, indexes, and caches remain independent decisions.

## 14. Contradiction resolution

The apparent sequence conflict is resolved as follows:

- IRC-R00 was an investigative seed under FLX-INV-02.
- The human explicitly selected FLX-ORD-01 for the A/B/C passes.
- A/B/C completed bounded Ordinary assessments without activating source work.
- Main now reconciles them and freezes one controlling D/E/F envelope.
- Codex materialization is active only for that envelope.

No domain report contradicts the existence or scope of the edit defect. The
reports differ only in perspective: Operational classifies validation risk,
Didactic classifies conceptual boundaries, and Design identifies the smallest
reversible correction.

## 15. Main decision

### Active bounded unit

Correct staged-line editing so saving an edited line preserves the exact
original `ProductReference` and Product label.

The correction applies to both reference variants:

- `ExistingProductReference(ProductId)`;
- `NewProductReference(ProductDraft)`.

Editing may change the staged Item's quantity, unit, package count, and line
total. It must not silently change the Product reference, create a replacement
Product draft, depend on the current Product dropdown selection, or create a
duplicate Product.

### Required regression evidence

A focused widget/integration regression must demonstrate:

1. an existing Product is available;
2. an Item is staged with that Product;
3. the staged line enters edit mode;
4. quantity or price is changed;
5. “Save staged Item” is used;
6. registration completes;
7. the registered Item still references the original Product ID;
8. no duplicate Product is created.

The implementation may add the smallest test seam needed to inspect the
registered command or persisted result, but it must prefer existing local
repository/UI integration and must not redesign application contracts.

### Acceptance gates

Required when supported by the available host:

- format check for touched Dart files;
- focused `markei_app_test.dart` execution;
- full Flutter test suite;
- Flutter analysis.

If a command cannot run because of the environment, Codex must report the exact
blocker and must not convert inspection into a passing result.

## 16. Explicitly excluded decisions

Not authorized in this unit:

- schema v3 or migration changes;
- Store normalization, aliases, branches, or merging;
- durable SubmissionId or distributed idempotency;
- installation–Device lifecycle changes;
- persistent Purchase drafts;
- transaction failure-injection infrastructure;
- query indexes, pagination, or analytics caches;
- Python bytecode cleanup or ignore-policy changes;
- authentication, API, Neon, upload/download, or synchronization;
- packaging, signing, distribution, backup, or restore;
- permanent Operational, Didactic, Design, or Main-root promotion;
- methodology changes.

## 17. Controlling handoff

The controlling files are:

```text
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
```

They form one envelope:

- D defines validation and Operational evidence;
- E protects Didactic meaning and maturity boundaries;
- F defines the source correction and Design invariants.

Codex must read all three before mutation. One file alone is insufficient
authority. After materialization, Codex reports to G/H/I; those reports remain
evidence and do not promote permanent memory.

## 18. Stop conditions

Stop and return to Main if:

- preserving Product identity requires schema/domain-contract changes;
- the existing/new reference variants cannot be preserved without changing
  Product creation semantics;
- a regression exposes unrelated persistence corruption;
- the branch has conflicting source changes;
- the test cannot distinguish preserved identity from duplicate creation;
- requested work expands into any excluded decision.

## 19. Authority state

```text
A/B/C: reconciled as Ordinary functional evidence
J_MAIN_STAGE: updated Main synthesis
D/E/F: controlling for one bounded edit-identity correction
Codex: authorized only within D/E/F
source mutation: narrowly authorized by F
validation: required by D
didactic maturity promotion: prohibited by E
permanent promotion: inactive
next evidence: G/H/I
next reconciliation: Main/human, then FLX-PRM-04 if selected
```


---

<!-- ROUND_MARKER:INTERMID-RECOVERY-POST-CODEX-RECONCILIATION-2026-07-14 -->

# Post-Codex Reconciliation and Permanent-Memory Handoff

> Date: 2026-07-14
> Completed materialization commit: `409e5f1e013a282165efd5f31bed17a396ad6543`
> Completed sequence unit: FLX-ORD-01 — existing-Product staged-Item edit correction
> Inputs: D/E/F controlling envelope, G/H/I Codex evidence, implementation diff
> Status: MATERIALIZATION RECONCILED; DOMAIN PROMOTION PENDING

## 20. Materialization result

Codex implemented the one bounded unit authorized by D/E/F.

Changed implementation paths:

```text
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/test/app/markei_app_test.dart
```

Changed evidence paths:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

No file was created or deleted. No source path outside the F authorization was
changed.

## 21. Reconciliation against D/E/F

### 21.1 Operational — D against G

Required and satisfied:

- focused widget regression added and passed;
- focused app suite passed with 7 tests;
- full Flutter suite passed with 32 tests;
- Flutter analysis passed with no issues;
- touched Dart files were formatted;
- final source diff was inspected;
- Product ID retention and absence of duplicate Product rows were asserted.

Intermediate focused-test failures occurred while shaping the regression. They
were resolved before final validation and are correctly recorded as development
evidence rather than final blockers.

Still outside the evidence boundary:

- Windows manual runtime acceptance;
- Android build/runtime and lifecycle validation;
- physical-device and iOS evidence;
- file-backed restart/migration evidence;
- transaction failure injection;
- release/distribution acceptance.

### 21.2 Didactic — E against H

Required and satisfied:

- “Save staged Item” remains the visible edit action;
- “Create anyway” is hidden while editing;
- Product identity remains distinct from editable Item values;
- the Product selection is cleared after saving;
- no KANBAN status or learner maturity was promoted;
- no permanent Didactic file or lesson was modified.

The regression is project evidence for the identity/value distinction. It is not
evidence that the learner can explain or transfer that distinction.

### 21.3 Design — F against I

Required and satisfied:

- edit state explicitly owns `_editingKey`, `_editingReference`, and
  `_editingProductLabel`;
- entering edit mode captures the original reference and label;
- saving rebuilds Item values but reuses the retained identity;
- save, removal, and registration clear edit state coherently;
- the save path does not invoke new Product creation or similarity checks;
- no schema, migration, domain-contract, Store, idempotency, draft-persistence,
  or synchronization change occurred.

The additional clearing of the selected Product after line save is accepted as
a presentation-local coherence correction. It prevents a stale dropdown object
from competing with staged-line identity and remains inside the authorized
boundary.

### 21.4 Evidence limitation

The focused regression directly proves the `ExistingProductReference` case.
The implementation is reference-polymorphic and retains the base
`ProductReference`, so the same path structurally preserves
`NewProductReference`. A distinct new-Product edit regression was not required
or produced in this unit. Permanent wording should preserve this distinction
between direct regression evidence and source-structure inference.

## 22. Main classification

### Accepted implementation fact

Staged-line editing now retains its original Product reference and label while
allowing package count, quantity, unit, and line total to change.

### Accepted validation fact

At materialization time:

- focused widget suite: 7 passed;
- full Flutter suite: 32 passed;
- Flutter analysis: no issues;
- no final blocker was reported.

### Corrected prior state

The existing-Product edit defect recorded in IRC-R00 and A/C is no longer an
active source defect at commit
`409e5f1e013a282165efd5f31bed17a396ad6543`.

### Retained boundaries

- project evidence is not learner maturity;
- local event queue is not synchronization;
- widget/in-memory validation is not host or release acceptance;
- materialization evidence is not permanent canon until domain reconciliation;
- schema and identity decisions remain unresolved and separate.

### Deferred

- schema v3;
- Store identity/normalization;
- durable SubmissionId;
- installation–Device lifecycle;
- persisted drafts;
- migration and rollback fixtures;
- measured query/index decisions;
- Python bytecode hygiene;
- platform acceptance;
- authentication, Neon, and synchronization.

## 23. Intermid Cycle Recovery balance

### Expectations met

- recovered the Cycle 08 implementation and notebook state of knowledge;
- established `J_MAIN_STAGE.md` as the canonical Main staging surface;
- completed Operational, Didactic, and Design A/B/C assessments;
- reconciled A/B/C into one bounded D/E/F controlling envelope;
- completed Codex materialization without scope expansion;
- produced G/H/I evidence;
- corrected one confirmed MVP behavior defect;
- increased focused app coverage from 6 to 7 tests and the full Flutter suite
  from 31 to 32 tests;
- preserved schema, migration, synchronization, and permanent-memory boundaries.

### Expectations partially met

- documentation knowledge has been recovered and staged, but permanent domain
  files still require Operational, Didactic, and Design reconciliation;
- local Flutter behavior is test-validated, but final host/device acceptance is
  incomplete;
- Cycle 09 database/UI decision inputs are identified, but no schema-v3 or
  database-expansion decision has been selected.

### Expectations remaining

- domain chats classify and absorb G/H/I into permanent memory under FLX-PRM-04;
- Main subsequently reconciles the refreshed checkpoints into
  `00_PROJECT_STATE.md`, `05_SESSION_LOG.md`, and `06_SESSION_SCHEME.md`;
- manual Windows restart/History smoke and Android toolchain/runtime validation
  remain Operational gates;
- Store identity, durable submission identity, Device lifecycle, migration
  strategy, and query budgets must be decided as separate Cycle 09 units;
- Neon synchronization remains later-cycle work and is not implied by local
  pending-event persistence.

## 24. Handoff to domain reconciliation

The next controlling sequence is:

```text
FLX-PRM-04 — Promotion/Reconciliation Sequence
```

Domain evidence pairs:

```text
Operational: A_OPERATIONAL + D_OPS_STAGE + G_OPS_CODEX
Didactic:    B_DIDACTIC + E_DDC_STAGE + H_DDC_CODEX
Design:      C_DESIGN + F_DSN_STAGE + I_DSN_CODEX
```

Each domain chat must use PRC-01 classification, update only its permanent
domain files, preserve unique semantic ownership, and refresh its checkpoint.
Promotion may validly result in no change for claims that are duplicate,
insufficiently evidenced, or owned elsewhere.

## 25. Authority state

```text
FLX-ORD-01 materialization unit: complete
D/E/F: consumed; no authority for additional source mutation
G/H/I: accepted as Codex evidence
J_MAIN_STAGE: post-Codex reconciliation updated
source defect: corrected within tested local boundary
permanent domain promotion: pending FLX-PRM-04
learner maturity promotion: unsupported
platform/release acceptance: incomplete
next writers: Operational, Didactic, and Design chats in their own domains
next Main duty: reconcile refreshed domain checkpoints and close recovery state
```
