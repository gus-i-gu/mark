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
