# J_[M]_STAGE — Cycle 07 Sprint 01 Knowledge Reconciliation and Next-Step Staging

> Status: Active Main reconciliation / documentation-first continuation
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Branch: `cycle-07-mobile-preparation`
> Baseline branch: `sketch-notebook-recovery`
> Baseline commit: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Knowledge state: Reconciled Main staging; implementation authorization postponed
> Source reports: `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`
> Active cycle: Cycle 07 mobile-development preparation and architecture discovery

---

# 1. Main Synthesis Summary

Cycle 07 Sprint 01 completed the bounded portability investigation without modifying application code, initializing a mobile framework, installing toolchains, opening databases, or touching ordinary desktop user data.

The three functional reports agree that:

```text
Markei contains reusable behavior
≠
Markei is a portable mobile application as currently constructed
```

The likely reusable portion is concentrated in Python domain models, validation, date/status calculations, workflow meanings, schema semantics, and structural defaults. The current executable composition is not mobile-portable because service construction, repository creation, database-path resolution, resource loading, SQLite lifecycle, presentation projections, and shutdown ownership remain shaped by the desktop implementation.

The accepted investigation boundary remains:

```text
offline-first
single-device
fresh mobile-local data
no backend
no authentication
no synchronization
no ordinary desktop database access
```

Approach D, a service-backed client, has no demonstrated product requirement and remains deferred.

The evidence does not yet justify a final framework selection or D/E/F materialization. Main therefore postpones D/E/F. The next phase is documentation and specification refinement through A/B/C and J, followed by a later human/Main decision on whether a prototype is necessary and which uncertainty it should test.

---

# 2. Cycle and Baseline Integrity

Cycle 06 remains accepted and closed at the controlled Windows primary-beta boundary.

Cycle 07 began from:

```text
repository: gus-i-gu/markei
branch: cycle-07-mobile-preparation
baseline: f6414fbe7394453387067a5a34ca6cc7621bbed3
```

The isolated `markei-mobile` working copy and Cycle 07 branch preserve the accepted desktop baseline.

The three inherited domain checkpoints still contain pre-acceptance Cycle 06 language. This remains classified as checkpoint drift:

```text
Main-root continuity
    owns accepted Cycle 06 closure and Cycle 07 direction

domain checkpoints
    remain useful for domain detail
    but require later refresh
```

Nothing in Sprint 01 reopens Cycle 06.

GitHub remains the canonical Sketch Notebook host. Notion remains only a possible future projection or recovery layer; no authority or migration is active.

---

# 3. Reconciled Portability Map

## 3.1 Platform-neutral and likely reusable

Current evidence supports likely reuse of:

- Python domain dataclasses and core vocabulary;
- validation and calculation rules;
- purchase-duration and expected-date behavior;
- status classification meanings;
- structural-default semantics;
- schema facts and relationships as a semantic reference;
- repository and service responsibilities as design concepts;
- existing deterministic desktop behavior as a source for fixtures.

Likely reusable does not mean proven inside a mobile runtime.

## 3.2 Platform-neutral but coupled by construction

Current evidence identifies these coupled surfaces:

- `ProductService` constructs a concrete `Repository`;
- repository construction opens concrete SQLite lifecycle behavior;
- abstract contracts do not cover every method actually used;
- database and resource paths are resolved through desktop/Windows-shaped assumptions;
- service projections contain labels, formatting, grouping, and page-order choices;
- transaction boundaries remain split across independently committed repository methods.

These surfaces are candidates for later seams or specifications. Sprint 01 does not authorize refactoring them.

## 3.3 Desktop-specific

Desktop-specific ownership remains in:

- PySide6 application creation and event-loop ownership;
- `app/desktop/` pages, widgets, dialogs, and navigation;
- page-owned service construction;
- MainWindow shutdown coordination;
- Windows/PyInstaller packaging and diagnostic surfaces;
- installed Windows path and lifecycle behavior.

These surfaces should be preserved as the accepted desktop implementation rather than treated as mobile assets.

## 3.4 Persistence-specific

SQLite schema semantics remain credible for an offline mobile prototype, but the following are not yet portable evidence:

- mobile sandbox path resolution;
- packaged schema-resource access;
- connection behavior within a chosen mobile runtime;
- WAL/file-lock behavior;
- suspend/resume and process-termination behavior;
- migrations and transaction ownership;
- uninstall, backup, and restore behavior;
- parity between desktop and mobile stores.

A mobile prototype must own a fresh sandboxed database. It must not open, copy, or mutate the ordinary desktop database.

## 3.5 Unknown until tested

No report establishes:

- a functioning mobile runtime;
- a selected UI framework;
- Android build or device launch;
- iOS build or device launch;
- packaged SQLite compatibility;
- lifecycle persistence across mobile termination/relaunch;
- mobile accessibility or performance;
- store distribution;
- semantic parity across two runtime implementations;
- safe cross-device synchronization.

These remain experiment candidates, not accepted facts.

---

# 4. Approach Reconciliation

## 4.1 Approach A — Shared Python core with Python-native mobile UI

Operational identifies Approach A as the lowest-cost Android falsification experiment because it maximizes direct Python reuse and can quickly test whether the existing core survives mobile packaging.

Its primary uncertainties are:

- Android packaging through an additional Linux/WSL, SDK/NDK, JDK, emulator/device, and framework toolchain;
- iOS dependence on macOS/Xcode and a separate packaging path;
- mobile lifecycle and SQLite compatibility;
- accessibility, navigation, and platform integration;
- whether required construction/path seams stay genuinely bounded.

Main classification:

```text
best short falsification challenger
not accepted long-term architecture
```

## 4.2 Approach B — Web/hybrid mobile presentation

Approach B may fit existing web familiarity and rapid UI work, but it cannot directly execute the current Python core in an ordinary hybrid client. It therefore requires:

- ported business behavior;
- a local bridge/runtime;
- or a service boundary.

It also needs a durable local relational-store strategy rather than treating browser preference storage as Markei’s ledger.

Main classification:

```text
viable secondary candidate
not currently the smallest evidence path
```

## 4.3 Approach C — Native/cross-platform client with explicit contracts and fixtures

Design recommends Approach C as the primary architectural candidate because it gives mobile presentation, lifecycle, local persistence, navigation, and platform integration explicit ownership.

This route reuses semantics rather than necessarily reusing Python runtime code. It requires language-neutral contracts and deterministic fixtures to control drift between desktop and mobile implementations.

Its cost is a second implementation and stronger fixture/contract discipline.

Main classification:

```text
primary strategic architecture candidate
framework not selected
implementation not authorized
```

## 4.4 Approach D — Service-backed client

No accepted requirement currently demands accounts, multi-device state, household collaboration, or cloud synchronization. A backend would add hosting, authentication, privacy, network failure, API compatibility, offline queues, conflict resolution, and operational support without removing the need for mobile-local persistence.

Main classification:

```text
deferred unless a demonstrated requirement activates it
```

---

# 5. Main Decision Boundary

Main does not treat the difference between Operational and Design as a contradiction.

They answer different questions:

```text
Operational:
What is the cheapest experiment that can falsify direct Python reuse?

Design:
What architecture is strongest if mobile becomes a maintained product?
```

The current reconciled position is:

```text
Approach C
    primary strategic candidate

Approach A
    bounded challenger / falsification spike

Approach B
    viable secondary route

Approach D
    deferred
```

Before any prototype authorization, the project should specify the behavior to preserve independently of framework choice.

---

# 6. Contract and Fixture Direction

The next useful artifact is conceptual specification, not application code.

Candidate behavior scenarios include:

1. first purchase for a new product;
2. repeat purchase and duration recalculation;
3. Storage/Shortage/Market status transition;
4. invalid receipt rejection;
5. structural category/store defaults;
6. close/reopen persistence;
7. one atomic registration workflow;
8. mobile-local path isolation.

A later contract/fixture design should describe:

- typed input facts;
- stable output facts and status codes;
- validation failures;
- date and quantity semantics;
- expected persistence effects;
- deterministic example values;
- invariants across desktop and mobile;
- presentation-owned labels and formatting excluded from the contract.

Current Python abstract classes and UI-facing dictionaries are evidence sources, not automatically the final cross-platform contract.

No new shared-specification directory or file is authorized by this J revision. Any new notebook or implementation file still requires explicit Main/human authorization and routing review.

---

# 7. D/E/F Postponement

The following files are intentionally not prepared:

```text
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
```

Reason:

```text
no implementation is currently requested
+
framework selection remains open
+
contract/fixture boundary remains underspecified
+
documentation reconciliation can reduce uncertainty first
```

Existing D/E/F content, if present from an earlier cycle, must not be interpreted as Cycle 07 authorization.

D/E/F may be activated later only after Main/human direction selects a bounded materialization unit.

---

# 8. Documentation-First Next Phase

The next phase should use A/B/C as renewable staging surfaces and J as the cross-domain gathering and reconciliation surface.

## 8.1 Operational continuation through A

Operational may refine `A_OPERATIONAL.md` with a compact documentation delta covering:

- host and toolchain inventory questions;
- evidence needed to compare one A-family and one C-family toolchain;
- Android-accessible versus macOS/iOS-only gates;
- reproducible prototype validation matrix;
- mobile-local path and ordinary-desktop-data isolation checks;
- lifecycle and persistence failure taxonomy;
- criteria for stopping a failed spike;
- exact unknowns that require execution rather than further reading.

Operational should not install tools or execute the prototype during this documentation phase.

## 8.2 Didactic continuation through B

Didactic may refine `B_DIDACTIC.md` with:

- explicit KANBAN candidates;
- dependency order for platform boundary, composition root, dependency injection, DTO/contract, golden fixture, local persistence, transaction boundary, offline-first, synchronization, and lifecycle ownership;
- learner-facing distinctions between reuse of code, behavior, schema, and vocabulary;
- maturity-preserving questions for the human learner;
- glossary candidates derived only from accepted or staged concepts;
- a compact learning checkpoint for the later prototype.

No maturity promotion or permanent KANBAN update should occur without the Didactic protocol and explicit learner evidence.

## 8.3 Design continuation through C

Design may refine `C_DESIGN.md` with:

- a technology-neutral use-case boundary;
- candidate command/result contract shapes;
- fixture ownership and semantic-parity rules;
- mobile composition-root and lifecycle ownership;
- local transaction boundary;
- schema reuse versus semantic-schema equivalence;
- repository topology options without selecting a permanent split;
- comparison criteria for candidate C-family frameworks;
- explicit conditions under which the A-family challenger should be attempted or rejected.

Design should not create implementation contracts or reorganize source code during this phase.

## 8.4 Main continuation through J

Main should gather subsequent A/B/C deltas into this J file by:

1. identifying agreements;
2. preserving genuine domain tensions;
3. classifying facts, assumptions, unknowns, and deferrals;
4. pruning duplicate cross-domain wording;
5. deciding whether additional documentation can answer the next question;
6. identifying when an empirical experiment becomes necessary;
7. selecting at most one bounded D/E/F materialization unit when authorized.

J remains staging. It does not replace permanent domain memory or Main-root continuity.

---

# 9. Permanent Documentation Reconciliation Candidates

After one documentation refinement round, functional chats may propose—not automatically perform—updates to permanent domain memory.

## Operational candidates

```text
operational/10_OPERATIONAL_STATE.md
    refresh Cycle 06 closure and Cycle 07 investigation state

operational/04_TODO.md
    express evidence gaps and future experiment gates

operational/12_OPERATIONAL_MODEL.md
    add stable mobile-investigation validation rules only if sufficiently general

operational/11_OPERATIONAL_RECORD.md
    append Sprint 01 investigation chronology
```

## Didactic candidates

```text
didactics/08_CONCEPT_MAP.md
    refresh current Cycle 07 learning boundary

didactics/02_KANBAN.md
    add concepts only after classification and learner protocol

didactics/07_GLOSSARY.md
    derive terms from accepted KANBAN concepts

didactics/13_LECTURE_REGISTER.md
    record the portability investigation and learner evidence
```

## Design candidates

```text
design/09_DESIGN_STATE.md
    refresh current portable-core and mobile-boundary state

design/14_MODEL_OVERVIEW.md
    derive a compact platform-boundary overview

design/01_ARCHITECTURE.md
    update only after an architecture decision becomes accepted

design/03_DECISION_LOG.md
    record alternatives, deferrals, and later accepted decisions
```

Permanent updates must follow `FLUX.md` and `PROMOTION_RULES.md`. A/B/C content must be classified rather than copied wholesale.

---

# 10. Proposed Next Steps

Recommended immediate sequence:

```text
1. Human/Main reviews this reconciliation.
2. A/B/C perform one documentation-refinement round if desired.
3. Main gathers the deltas in J.
4. Functional chats classify permanent-domain update candidates.
5. Domain checkpoints are refreshed to remove Cycle 06 closure drift.
6. Main decides whether documentation is sufficient.
7. If empirical evidence is required, select one bounded experiment.
8. Only then prepare D/E/F.
```

The most useful next decision question is:

> Should the project first formalize language-neutral behavior contracts and fixtures, or first run a time-boxed Python-native Android falsification spike to test whether direct core reuse is viable?

Main currently recommends contract/fixture specification first because it benefits every approach and reduces the risk that a framework spike tests only packaging while leaving semantic portability undefined.

---

# 11. Scope Guard

This J revision does not authorize:

- application or source-code modification;
- framework initialization;
- tool installation;
- Android or iOS build execution;
- database migration or ordinary-user-data access;
- backend, authentication, synchronization, or hosting;
- permanent repository split;
- new Sketch Notebook files;
- methodology modification;
- D/E/F materialization;
- automatic permanent-domain promotion.

---

# 12. Recovery Route

```text
Accepted global state
    00_PROJECT_STATE.md

Cycle 07 boundary
    06_SESSION_SCHEME.md

Current Main reconciliation
    this file

Operational evidence
    DEV_STAGE/A_OPERATIONAL.md

Didactic evidence
    DEV_STAGE/B_DIDACTIC.md

Design evidence
    DEV_STAGE/C_DESIGN.md

Permanent domain state
    domain checkpoints, after authorized reconciliation
```

Current status:

```text
Sprint 01 investigation: complete
A/B/C reports: received and reconciled
primary strategic candidate: Approach C
bounded challenger: Approach A
backend: deferred
implementation authorization: none
D/E/F: postponed
next mode: documentation-first refinement and domain-memory reconciliation
```


---

# 13. Permanent-Domain Absorption Result

Operational, Didactic, and Design completed the authorized permanent-memory reconciliation pass.

Materialized domain updates:

```text
Operational
    operational/10_OPERATIONAL_STATE.md
    operational/04_TODO.md
    operational/11_OPERATIONAL_RECORD.md

Didactic
    didactics/08_CONCEPT_MAP.md
    didactics/13_LECTURE_REGISTER.md

Design
    design/09_DESIGN_STATE.md
    design/03_DECISION_LOG.md
```

Main classification:

- checkpoints now reflect Cycle 06 closure and active Cycle 07 investigation;
- observational files preserve both the Python-native challenger and contract-first strategic pathway;
- the human/Main preference for the Design pathway is recorded as provisional planning direction;
- development cost is described across learning, setup, rewriting, toolchains, testing, lifecycle, semantic parity, distribution, and maintenance;
- no Didactic maturity changed;
- no framework, permanent repository topology, backend, or implementation architecture was accepted;
- no application, methodology, D/E/F, or Codex-report files were modified;
- no further J synthesis is required before the Main-root continuity refresh.

Current reconciled position:

```text
primary strategic direction
    contract-first native/cross-platform client

bounded challenger
    time-boxed Python-native Android falsification experiment

next required knowledge
    language-neutral behavior scenarios
    deterministic fixtures
    explicit validation and stop criteria

implementation authorization
    none

D/E/F
    postponed
```

The next cycle step remains documentation/specification work. Main should activate D/E/F only when the human requests an empirical prototype and one bounded uncertainty has been selected.


---

# 14. Shared Beta Planning Activation

## 14.1 Human/Main direction

The human developer has activated planning for an actual shared Markei beta spanning desktop and mobile.

Favored product direction:

```text
one shared cross-platform application
+
local-first persistence on every installation
+
verified-email user account
+
small custom synchronization API
+
Neon Postgres shared synchronization store
+
append-only first synchronization slice
```

This direction supersedes the earlier assumption that backend and synchronization remain wholly outside near-term planning. It does not authorize implementation yet.

Approach C remains the favored client direction. The cloud boundary is now activated as a planning concern because synchronized desktop/mobile state is an explicit human requirement.

## 14.2 Responsibility boundary

```text
Email authentication
    proves account access and resolves an immutable account ID

Local database
    supports offline use and durable device-local state

Synchronization API
    owns upload/download protocol, validation, idempotency,
    authorization, cursors, and protocol versions

Neon Postgres
    stores shared account-scoped synchronization facts

Shared client
    owns responsive desktop/mobile presentation, local use cases,
    local projections, pending-event queue, and sync application
```

Clients must not embed a privileged Neon connection string or connect directly with shared database credentials.

## 14.3 Reduced first synchronized slice

The first synchronized beta should support only:

```text
verified email registration/sign-in
→ immutable account UUID
→ per-installation device UUID
→ local database initialization
→ offline purchase registration
→ append-only local purchase event
→ authenticated event upload
→ idempotent server acceptance
→ server cursor assignment
→ second device downloads unseen events
→ deterministic local projection rebuild
→ close/reopen persistence
```

Explicitly excluded from the first slice:

- purchase editing;
- purchase deletion;
- concurrent product renaming;
- household sharing;
- multi-account roles;
- real-time push;
- background synchronization;
- conflict-resolution UI;
- desktop database-file transfer;
- complete settings synchronization;
- broad schema redesign;
- app-store publication;
- production scaling claims.

## 14.4 Initial synchronization event requirements

A planning candidate event should contain at least:

```text
event_id
account_id
device_id
device_sequence
entity_type
entity_id
operation_type
payload
client_created_at
server_received_at or server sequence
schema_version
```

Timestamps alone are not accepted as ordering or duplicate protection.

Required properties:

- globally unique event identity;
- per-device ordering;
- safe retry through idempotency;
- server-owned incremental cursor;
- authenticated account ownership;
- deterministic application into local state;
- schema/protocol versioning;
- transactional local application.

The authoritative first synchronized facts should be purchase events and necessary identity/reference facts. Calculated projections such as average duration, expected purchase date, and Storage/Shortage/Market classification should be rebuilt deterministically where possible rather than synchronized as competing mutable values.

## 14.5 Custom API preference

The custom synchronization API is favored over direct client table access because it provides one owner for:

- authentication-token validation;
- account authorization;
- event validation;
- idempotent append;
- batch upload;
- cursor-based download;
- transaction semantics;
- protocol versions;
- observability;
- future conflict policy.

Neon is favored as managed Postgres infrastructure. It reduces database operations but does not define synchronization semantics.

Authentication provider selection remains open. Verified email is a product requirement; Neon Auth may be evaluated, but its current Beta status prevents automatic acceptance.

## 14.6 Planning phases

```text
Phase 1 — Shared local application specification
    responsive desktop/mobile client boundary
    local schema and lifecycle
    shared contracts and deterministic fixtures
    no cloud dependency required for core workflow

Phase 2 — Synchronization protocol specification
    identities
    append-only events
    idempotency
    per-device order
    server cursor
    upload/download batches
    failure and retry behavior

Phase 3 — Small API + Neon prototype
    verified account
    authenticated append
    cursor download
    two-device semantic parity
    offline/reconnect lifecycle

Phase 4 — Shared beta validation
    desktop and mobile builds
    local persistence
    cross-device propagation
    retry/duplicate safety
    ordinary Cycle 06 desktop data protected
    bounded security and operational evidence
```

## 14.7 Required domain planning before D/E/F

Operational should plan:

- local development and hosted environments;
- Neon, API runtime, auth, secrets, migrations, logs, and test prerequisites;
- two-device sync validation;
- offline/reconnect, retry, duplicate, and cursor gates;
- minimum deployment and rollback evidence.

Didactic should plan:

- authentication versus authorization;
- local persistence versus synchronization;
- event identity, idempotency, ordering, cursors, eventual consistency;
- authoritative facts versus derived projections;
- API and managed-database responsibilities;
- learner dependency order.

Design should plan:

- shared client boundary;
- local store and pending-event queue;
- immutable account/device/entity/event identities;
- append-only event contract;
- custom API endpoints and ownership;
- Neon schema responsibilities and row ownership;
- projection rebuild and transaction boundaries;
- explicit deferrals and migration path from the accepted PySide6 beta.

Main should reconcile A/B/C into one shared-beta architecture plan before authorizing D/E/F.

## 14.8 Current authorization state

```text
shared synchronized beta planning: active
human product preference: recorded
architecture: not yet accepted
framework: not selected
auth provider: not selected
API runtime/host: not selected
Neon project/schema: not created
implementation: not authorized
D/E/F: postponed pending domain planning
```


---

# 15. Sprint 02 Shared-Beta Reconciliation and Reusable Catalogue Orientation

## 15.1 Main synthesis

The Sprint 02 Operational, Didactic, and Design reports converge on a coherent planning architecture:

```text
shared cross-platform client
→ application-private local database
→ local transaction and pending-event queue
→ authenticated custom synchronization API
→ account-scoped append-only event history
→ Neon Postgres
```

Each client remains usable offline. The API is not a transparent database tunnel: it owns authentication-token validation, authorization, event validation, idempotency, ordering/cursors, protocol compatibility, transactions, and diagnostics. Neon owns managed shared persistence, not synchronization meaning.

The smallest credible evidence target is a two-device protocol slice before a broad UI rewrite. It must prove local-first registration, safe retry, account isolation, cursor download, transactional local application, deterministic projection rebuild, restart recovery, and protection of the accepted Cycle 06 database.

The human-proposed Reusable Catalogue Perspective is accepted into Main staging as the preferred structural direction for further definition:

> Markei should separate relatively stable household catalogue identities from purchase-specific commercial observations. Purchases reference reusable product identities while retaining the variable facts observed at each acquisition. Historical price and consumption analysis should derive from the sequence of purchase observations rather than duplicated current product state.

This is structural orientation, not a finalized schema or implementation authorization.

## 15.2 Reconciled structural model

The previous Design event draft treats `purchase.registered` as the first synchronized fact and includes product/store bootstrap information in its payload. The reusable-catalogue perspective refines this into three distinct domain roles:

```text
Catalogue Product
    relatively stable household identity

Purchase Event
    one timestamped acquisition/receipt context at one store

Purchase Item
    one product observation within that purchase
    with quantity, package, price, promotion, and other commercial facts
```

Candidate relationship:

```text
Account
├── Catalogue Products
├── Stores
└── Purchase Events
    └── Purchase Items
        └── reference Catalogue Product
```

This prevents the purchase event from becoming both receipt header and product line. It also preserves a natural path toward one receipt containing several products without requiring that broader UI in the first synchronized slice.

The reduced first slice may still register one purchase with one item. The model should avoid making “one purchase always equals one product” a permanent invariant.

## 15.3 Stable catalogue identity versus historical observation

Candidate stable catalogue facts:

- account-scoped product UUID;
- preferred product name;
- brand;
- package or variant specification;
- category identity;
- lifecycle metadata required for synchronization.

Candidate purchase-event facts:

- purchase UUID;
- account UUID;
- store UUID;
- occurrence date/time;
- optional receipt-level totals or reference;
- creation/source metadata.

Candidate purchase-item facts:

- purchase-item UUID;
- purchase UUID;
- catalogue-product UUID;
- quantity purchased;
- measurement/unit;
- unit price;
- line total;
- promotion observation;
- optional expiration/depletion observation;
- product/package/store snapshot fields required for historical interpretation.

The exact allocation remains open. “Stable” means relatively reusable, not timeless. Product names, brands, package sizes, categories, and store names can change. Historical meaning must not be silently rewritten when the current catalogue entry changes.

## 15.4 Authoritative facts and projections

The following should remain authoritative candidates:

```text
catalogue identity facts
purchase event facts
purchase-item commercial observations
accepted synchronization event identities/order
explicit correction or lifecycle facts when later introduced
```

The following should normally remain derived:

```text
average duration
expected next purchase
current stock estimate
Storage / Shortage / Market classification
price-change percentages
personalized inflation/deflation indicators
store comparisons
expenditure forecasts
formatted labels and groupings
```

Derived analytics must be reproducible from accepted facts and versioned calculation rules. They should not be synchronized as competing mutable truth unless later evidence identifies a specific need.

## 15.5 Newly raised architectural questions

The reports introduce the following questions for Main/human definition.

### A. Shared client and migration

1. Which cross-platform client family will eventually own Windows, Android, and iOS?
2. Will the new client progressively replace PySide6 after parity, as Design recommends?
3. What evidence constitutes sufficient desktop workflow parity?
4. How long must the PySide6 beta and original database remain recoverable?
5. Will the shared client remain in the same repository during transition?
6. How will current integer/text identities map deterministically to UUIDs?
7. Will legacy import emit append-only events, or import catalogue/purchase facts through a separate controlled migration route?

### B. Account and catalogue ownership

8. Is the catalogue owned by one account, one future household, or another workspace boundary?
9. Is a product identity private to an account, or can identities later reference a wider canonical product catalogue?
10. Does the first beta deliberately avoid global product deduplication?
11. Can two catalogue products share the same name/brand/package while remaining distinct?
12. What rules identify “the same product” after spelling, brand, package, or unit changes?
13. Are category and store reusable account-scoped catalogue entities?
14. Which email/auth provider subject maps to the immutable internal account UUID?

### C. Product variants and historical snapshots

15. Is package specification part of product identity?
16. Does changing package size create a new catalogue product/variant?
17. Which product/store/category values are copied as immutable snapshots into purchase items?
18. If a catalogue name or brand changes, what should old History rows display?
19. Are current catalogue corrections allowed before purchase editing exists?
20. How will aliasing or merging duplicate catalogue entries work later without rewriting history?
21. Does a purchase event need sufficient bootstrap facts for a second device to create missing catalogue references?

### D. Purchase and purchase-item granularity

22. Is the synchronized domain event `purchase.registered`, `purchase_item.recorded`, or a receipt-level event containing item lines?
23. Is one receipt/purchase uploaded atomically as one event?
24. Can one invalid item reject an entire purchase, or may items be accepted independently?
25. Does the first slice model one purchase with one item while preserving a multi-item contract?
26. Where do receipt-level store, date, total, discount, and payment facts belong?
27. How are promotions represented without expanding into a broad pricing engine?

### E. Quantity, price, currency, and analytics

28. What are the canonical representations for quantity and unit?
29. How are package count, weight/volume, and purchased quantity distinguished?
30. Are money values stored as integer minor units, fixed-precision decimal, or another representation?
31. Is currency explicit on every purchase or inherited from account settings?
32. Is unit price stored, derived from line total/quantity, or both with validation?
33. Which price basis powers comparison: package price, normalized unit price, line total, or several views?
34. How are promotion quantities and multi-unit offers preserved historically?
35. Which time and normalization rules define personalized inflation/deflation calculations?
36. How are calculation-rule versions recorded when analytics evolve?

### F. Synchronization semantics

37. Is the server cursor global, account-scoped, or partitioned another way?
38. Are upload batches whole-batch atomic or per-event atomic?
39. What happens when a device sequence has a gap?
40. Can a client retry a logically identical event with different content under the same event UUID?
41. Which stable error codes are required?
42. How is a second device bootstrapped from cursor zero when event history grows?
43. Are reference/catalogue events separate from purchase events, or embedded as bootstrap snapshots?
44. Which corrections will later require compensating events rather than mutation?
45. Is row-level security required as defense in depth behind mandatory API authorization?

### G. API, authentication, and operations

46. Will the first protocol API use TypeScript or Python?
47. Which runtime/host provides the smallest reproducible environment?
48. Which verified-email/OIDC provider supports Windows, Android, and iOS securely?
49. How are refresh credentials stored on every platform?
50. What logs are sufficient without exposing tokens or purchase notes?
51. How are migrations rehearsed and rolled back?
52. When should local Postgres testing advance to a non-production Neon environment?
53. What low-cost quotas or cold-start behavior could invalidate the prototype assumptions?

## 15.6 Questions ready for provisional Main definition

The following can be staged now without framework execution:

```text
catalogue ownership
    account-scoped for the first beta

global product catalogue
    deferred

domain shape
    Catalogue Product → Purchase Event → Purchase Item

first workflow
    one purchase with one item,
    contract remains capable of multiple items

historical integrity
    purchase observations are not rewritten by catalogue edits

client database
    local-first and application-private

shared database access
    only through authenticated custom API

account ownership key
    immutable account UUID, never email string

sync style
    append-only first slice

duplicate protection
    event UUID + account-scoped uniqueness

device ordering
    device UUID + monotonic device sequence

download ordering
    opaque server-owned cursor

business time
    client occurrence time retained but not global ordering authority

projections
    rebuilt deterministically from authoritative facts

backend
    small custom synchronization API + Neon favored

desktop migration
    progressive replacement only after parity;
    PySide6 and original data remain recoverable

editing/deletion
    deferred

D/E/F
    postponed
```

These are planning definitions. Permanent architecture promotion still requires domain-memory classification and human/Main acceptance.

## 15.7 Questions requiring the next definition round

The next Design/Operational/Didactic documentation pass should prioritize:

1. catalogue identity and variant rules;
2. purchase-event versus purchase-item event granularity;
3. historical snapshot policy;
4. quantity/unit/money/currency representation;
5. minimum multi-item-capable purchase contract;
6. whole-batch versus per-event atomicity;
7. device-sequence-gap policy;
8. server cursor scope;
9. TypeScript versus Python protocol harness;
10. authentication provider criteria;
11. deterministic migration identity mapping;
12. fixture scenarios for price analytics and projection parity.

No framework, provider, schema, API, or infrastructure should be materialized until Main reconciles this definition round.

## 15.8 Didactic promotion direction

The human has clarified that KANBAN promotion may occur during model-design cycles when relevant concepts are genuinely approached and can be defined with reusable meaning. Implementation evidence is not a prerequisite for concept introduction, although maturity still requires explicit learner evidence.

Didactic may therefore evaluate canonical promotion for:

- Stable Identity;
- Authentication;
- Authorization;
- Append-Only Event;
- Idempotency;
- Event Ordering;
- Synchronization Cursor;
- Eventual Consistency;
- Authoritative Fact and Derived Projection, reconciled with existing `&&&02`;
- Sync Protocol;
- Offline Queue;
- Schema and Protocol Versioning;
- Reusable Catalogue;
- Purchase Event and Purchase Item;
- Historical Snapshot.

Promotion must preserve unique concept ownership, marker sequences, prerequisite relationships, and glossary derivation. No maturity color should change automatically.

## 15.9 Current status

```text
Sprint 02 A/B/C planning reports: received
Main shared-beta reconciliation: staged
reusable catalogue perspective: accepted as structural orientation
shared client + custom API + Neon: favored planning architecture
first slice: append-only, one purchase / one item, multi-item-capable
new architectural questions: classified
KANBAN promotion: permitted through Didactic protocol
implementation authorization: none
D/E/F: postponed
next step: domain documentation and definition round
```


---

# 16. Human/Main Structural Definitions and TypeScript Exploration Direction

## 16.1 Catalogue identity

The first shared beta defines an account-private catalogue product through this normalized identification set:

```text
normalized product name
+
normalized product brand
+
measurement mode
+
normalized package amount and unit, when packaged
```

Rules:

- a brand change creates a different Product ID;
- a packaged amount/size change creates a different Product ID;
- packaged products include normalized package amount/unit in identity;
- bulk/weighted products use `BULK` mode and omit package amount from identity;
- products remain private to one account;
- global catalogue deduplication is deferred;
- exact normalized equivalence may reuse an existing product automatically;
- fuzzy textual similarity only warns and requests user clarification;
- Markei must not merge products automatically from similarity alone;
- spelling correction and manual deduplication are deferred.

A deterministic account-scoped Product UUID derived from the normalized identification set is favored for evaluation because two offline devices can then resolve mechanically equivalent identities such as `350 g` and `0.350 kg` to the same Product ID. Its correction/migration implications still require fixture evidence.

## 16.2 Purchase registration structure

The accepted planning flow is:

```text
stage purchase
→ create purchase UUID and occurrence timestamp
→ select/create account-private store
→ add one or more purchase items
→ resolve Product ID directly or through identification set
→ exact match reuses catalogue product
→ similar match asks user
→ no match creates catalogue product
→ commit purchase aggregate atomically
→ append pending synchronization event
```

The first UI may stage one item at a time. The domain contract must support one purchase containing several purchase items.

## 16.3 Historical integrity and package change

Product identification properties are treated as immutable in the first beta. A changed name, brand, or package identity produces a new Product ID rather than rewriting an existing identity.

Therefore, broad duplicated product snapshots on every purchase item are not required initially. Purchase items preserve historical meaning by retaining their original Product ID and commercial observations.

A future relation may express:

```text
new product supersedes prior product
or
both variants belong to one analytical product family
```

This is useful for package shrinkage and long-range analytics but is deferred from the reduced synchronized slice.

## 16.4 Currency representation

Household purchases normally use the territorial currency associated with the account/store context. The interface may infer and default that currency so ordinary entry does not ask the user repeatedly.

Persisted commercial facts must nevertheless retain an explicit standard currency code. Store location alone must not be the only historical currency evidence.

Planning representation:

```text
account default currency
+ purchase currency code
+ money stored as integer minor units
```

Example:

```text
BRL 8.79
→ currency_code = BRL
→ amount_minor = 879
```

The guide may explain money abstractly, but `M` is not the sole stored database unit.

## 16.5 Quantity and dimensional representation

The earlier broad `m` symbol is rejected as the sole stored measure because equal numeric magnitudes across mass, volume, and count do not mean the same physical quantity. Markei must never infer mass from volume or assume `1 L = 1 kg`.

Planning representation:

```text
measurement_kind
    MASS | VOLUME | COUNT

measurement_unit
    KG | L | UNIT

normalized_amount
    fixed precision with three displayed decimals
```

Examples:

```text
350 g
→ 0.350 KG
→ MASS

1 litre
→ 1.000 L
→ VOLUME

5 units
→ 5.000 UNIT
→ COUNT
```

The abstract `m` notation may appear in an explanatory guide only when paired with the explicit dimension/unit. The database and contracts store explicit dimensions.

Package amount and purchased amount remain distinct:

```text
Product:
    package_amount = 0.350 KG

Purchase Item:
    package_count = 2
    purchased_amount = 0.700 KG
```

## 16.6 Price facts and analytics basis

Candidate authoritative purchase-item price facts:

```text
currency code
line total in minor units
package count
normalized purchased amount and unit
promotion observation
```

Candidate derived analytics:

```text
package price
normalized measure price
price change
normalized price change
personal inflation/deflation indicators
store comparisons
forecasts
```

Raw purchase facts remain authoritative.

## 16.7 Versioned analytics boundary

A dedicated TypeScript analytics boundary is accepted as planning direction.

Initial form may be:

```text
analytics.ts
    registry of pure, versioned analytical algorithms
```

Rules:

- each analytic has a stable identifier and version;
- once used for reproducible results, a version's meaning is not changed;
- improved formulas receive a new version;
- services/use cases select the relevant analytic by identifier;
- persisted or cached analytical results record the version used when necessary;
- raw purchase facts are never rewritten by analytical evolution;
- Git history preserves source chronology;
- semantic growth may later split `analytics.ts` into an `analytics/` directory.

This is not authorization to create the file yet.

## 16.8 Synchronization semantics accepted for planning

The first protocol should use:

```text
event UUID
    duplicate protection and retry identity

device UUID + monotonic device sequence
    creation order for one installation

client occurrence timestamp
    business time, not global synchronization order

opaque account-scoped server cursor
    ordered incremental download position
```

Planning policies:

- a sequence gap is rejected and the missing earlier event is requested;
- identical retry under the same event UUID returns the prior acceptance;
- different content under an accepted event UUID is rejected;
- a second device bootstraps from cursor zero in bounded pages;
- one purchase event is atomic and includes its purchase-item lines;
- an upload request may contain several purchase events and return per-event transactional results;
- API authorization is mandatory;
- database row-level security remains a defense-in-depth evaluation;
- general edit/delete conflict resolution remains deferred.

## 16.9 TypeScript exploration direction

TypeScript is accepted as the primary language for the next shared-client/API exploration.

This does not authorize a hybrid Python/TypeScript runtime inside the new client.

Planning boundary:

```text
accepted PySide6 beta
    preserved as reference, fixture source, and rollback

new shared client
    TypeScript-oriented candidate

custom synchronization API
    TypeScript favored for first comparison/protocol harness

Python ↔ TypeScript continuity
    specifications
    deterministic fixtures
    expected behavior
    migration evidence

not
    embedded Python runtime or client IPC bridge
```

Reasons:

- a Python/TypeScript installed-client bridge would add two runtimes, serialization, lifecycle coordination, cross-language debugging, and multi-platform packaging;
- language-neutral contracts and fixtures allow gradual semantic replacement without embedding the desktop runtime;
- TypeScript can serve client, protocol types, runtime validation, API, tests, and analytics while preserving clear boundaries.

Primary client-family comparison:

```text
Tauri 2 + TypeScript frontend
versus
React Native + React Native Windows
```

Flutter remains the non-TypeScript control candidate. Capacitor remains secondary because Windows desktop is not its primary official target.

No framework is accepted yet. The next empirical comparison must measure local SQLite support, secure token storage, Windows/Android/iOS lifecycle, packaging, accessibility, testing, native integration, and maintenance cost.

## 16.10 Current decision state

```text
catalogue identity: provisionally defined
purchase aggregate: provisionally defined
historical identity policy: provisionally defined
currency storage: provisionally defined
quantity dimensions: provisionally defined
analytics versioning: provisionally defined
sync ordering/idempotency: provisionally defined
TypeScript exploration: accepted
embedded Python bridge: rejected as primary architecture
Tauri vs React Native Windows: open
auth provider: open
exact API runtime/host: open
physical schema: not materialized
implementation: not authorized
D/E/F: postponed
```

The next action is domain-memory reconciliation and Didactic KANBAN promotion, followed by Main-root continuity refresh. Framework or schema implementation requires a later explicit authorization.


---

# 17. Sprint 02 Consolidated Resolution — Flutter/Dart Shared-Client Basis

## 17.1 Supersession statement

Human/Main now establishes Flutter/Dart as the primary development basis for the new shared Markei client.

This supersedes section 16.9 only where it named TypeScript as the primary shared-client exploration language.

The reconciled language boundary is:

```text
Shared Windows / Android / iOS client
    Flutter + Dart

Custom synchronization API
    TypeScript favored

Shared cloud persistence
    Neon Postgres favored

Accepted Cycle 06 desktop beta
    Python + PySide6 preserved as reference and rollback

Python → Dart continuity
    language-neutral contracts
    deterministic fixtures
    migration evidence
    behavioral parity

Not accepted
    embedded Python runtime
    Python/Dart or Python/TypeScript client IPC bridge
```

Flutter/Dart is a planning architecture decision. Framework scaffolding, application implementation, infrastructure creation, and D/E/F remain unauthorized.

## 17.2 Why Dart/Flutter is favored

The product objective is one maintained application behavior across Windows, Android, and iOS. Flutter provides one client framework and language for:

- responsive desktop/mobile presentation;
- local composition and use cases;
- application-private persistence;
- pending synchronization queue;
- authenticated HTTP client;
- local projections;
- versioned analytics;
- platform lifecycle coordination;
- shared tests and fixtures.

Dart introduces a new learning surface but removes the architectural cost of coordinating TypeScript, Python, IPC, and multiple client shells. Platform-specific integrations may still require native code and separate platform tooling; Flutter does not eliminate Android SDK, Windows build, macOS/Xcode, secure-storage, packaging, or plugin-validation work.

## 17.3 Client transition strategy

The transition remains additive:

```text
1. Preserve Cycle 06 PySide6 beta and original user data.
2. Define language-neutral contracts and deterministic fixtures.
3. Build Flutter against a fresh isolated local database.
4. Reproduce the reduced Register + projection workflow.
5. Add local event queue and synchronization protocol.
6. Validate Windows and Android parity.
7. Validate iOS separately through macOS/Xcode.
8. Design deterministic legacy import.
9. Keep PySide6 rollback until human/Main parity acceptance.
10. Replace/demote PySide6 only after evidence.
```

No direct opening, copying, or destructive conversion of the ordinary Cycle 06 database is authorized.

## 17.4 Reusable catalogue resolution

The first shared beta uses an account-private reusable catalogue.

Packaged product identity set:

```text
normalized product name
+
normalized brand
+
PACKAGED mode
+
normalized package amount
+
explicit package unit/dimension
```

Bulk product identity set:

```text
normalized product name
+
normalized brand
+
BULK mode
```

Rules:

- brand or packaged-size changes create a distinct Product ID;
- exact normalized equivalence may reuse automatically;
- unit normalization may make `350 g` and `0.350 kg` equivalent;
- fuzzy textual similarity produces an advisory warning and user choice;
- similarity never causes automatic merge;
- products remain account-private;
- global catalogue deduplication, manual merge, aliases, and spelling correction are deferred;
- deterministic account-scoped Product UUID derivation remains favored for fixture evaluation.

## 17.5 Purchase aggregate resolution

Domain shape:

```text
Account
├── Catalogue Product
├── Store
└── Purchase
    └── one or more Purchase Items
        └── reference Catalogue Product
```

Planning workflow:

```text
stage Purchase
→ create purchase UUID and occurrence timestamp
→ select/create Store
→ add Purchase Items
→ resolve Product ID or identification set
→ exact match / similarity warning / create
→ record commercial observations
→ atomically commit Purchase + Items + pending sync event
```

The first UI may guide one item at a time, but the contract supports multiple items.

One `purchase.registered` event containing immutable item lines is favored. The purchase aggregate is atomic. A network upload request may contain multiple purchase events and return per-event transactional results.

## 17.6 Historical-integrity resolution

Product identity fields are immutable in the first beta. A changed name, brand, or packaged-size identity creates a new Product ID. Purchase Items retain their original Product ID and commercial observations.

Broad duplicated catalogue snapshots are not required initially because accepted identity records are not rewritten.

Future optional relations may express:

```text
product B supersedes product A
product A and B belong to one analytical family
```

These relations support shrinkflation and longitudinal analytics but remain deferred.

## 17.7 Quantity and money resolution

Stored quantity is dimensionally explicit:

```text
measurement_kind
    MASS | VOLUME | COUNT

measurement_unit
    KG | L | UNIT

normalized_amount
    fixed precision
    displayed with three decimals
```

Markei never assumes `1 L = 1 kg`. Package amount and purchased amount are separate.

Stored money is explicit:

```text
account default currency
purchase currency code
integer minor-unit amounts
```

The interface may infer territorial/default currency and avoid repeated input. Persisted facts retain currency code; store location is not the sole historical currency authority.

Candidate authoritative price facts:

- currency;
- line total in minor units;
- package count;
- normalized purchased amount/unit;
- promotion observation.

Package price, normalized measure price, price-change rates, personalized inflation/deflation indicators, store comparisons, and forecasts remain derived analytics.

## 17.8 Versioned Dart analytics resolution

The shared client owns a versioned Dart analytics registry.

Initial planning form:

```text
lib/analytics/
    analytics_registry.dart
    price_change.dart
    normalized_price.dart
    purchase_interval.dart
    fixtures/
```

A smaller first implementation may begin in one Dart file, but semantic ownership is the analytics module.

Rules:

- every analytic has a stable identifier and version;
- a released/used version does not change meaning;
- improved formulas create a new version;
- services/use cases select analytics by identifier;
- reproducible cached/persisted results record algorithm version when needed;
- raw purchase facts remain authoritative;
- Git preserves source chronology;
- analytical projections are rebuildable.

## 17.9 Synchronization resolution

Planning semantics:

```text
event UUID
    identity and idempotent retry

device UUID + monotonic sequence
    per-installation creation order

client occurrence timestamp
    purchase/business time

opaque account-scoped server cursor
    incremental accepted-event download order
```

Policies:

- sequence gaps are rejected/requested;
- identical event UUID/content returns prior acceptance;
- same event UUID with different content is rejected;
- second device bootstraps from cursor zero in bounded pages;
- Purchase event is atomic;
- upload batch uses per-event results;
- downloaded events and cursor advance commit together locally;
- API authorization is mandatory;
- RLS remains defense-in-depth evaluation;
- editing/deletion conflict resolution remains deferred.

## 17.10 Cloud and API resolution

Favored boundary:

```text
Flutter client
→ authenticated custom synchronization API
→ Neon Postgres
```

The API owns:

- access-token validation;
- account/device authorization;
- runtime payload validation;
- idempotent event append;
- device-sequence policy;
- cursor allocation/download;
- protocol versions;
- server transactions;
- stable errors;
- diagnostics.

Neon owns managed Postgres persistence, roles, constraints, migrations, and recovery facilities. It does not define synchronization semantics.

TypeScript is favored for the API/protocol harness because of its JSON validation, Postgres/Neon ecosystem, hosting options, and separation from the Dart client through language-neutral protocol contracts. Python remains a possible API fallback but is not the primary shared-client runtime.

Verified email remains required. Provider selection remains open. Immutable internal account UUID—not email—owns data.

## 17.11 Reduced first synchronized slice

```text
verified sign-in on device A
→ account UUID and device UUID
→ fresh Flutter-local database
→ account-private catalogue lookup/create
→ one Purchase containing one Purchase Item
→ local atomic commit and pending event
→ authenticated API upload
→ idempotent Neon append and account cursor
→ device B sign-in/bootstrap from cursor zero
→ transactional event application
→ same catalogue/purchase projection
→ retry proves no duplicate
→ cross-account request proves isolation
→ close/reopen proves local persistence
→ Cycle 06 data remains untouched
```

Explicitly deferred:

- purchase editing/deletion;
- product merge/alias workflow;
- household sharing;
- complex conflict resolution;
- realtime/background sync;
- global catalogue;
- full settings sync;
- broad schema redesign;
- product-family/supersession UI;
- production analytics suite;
- app-store/public release;
- PySide6 retirement.

## 17.12 Restaging questions

A/B/C must now refine:

### Operational

- Flutter/Dart tooling for Windows, Android, and iOS;
- local SQLite and secure-storage candidates;
- TypeScript API harness and Neon environment route;
- Dart/TypeScript fixture exchange;
- build, lifecycle, sync, migration, and rollback validation;
- development cost for Flutter versus retained alternatives.

### Didactic

- Dart language and Flutter framework distinctions;
- widget/composition/lifecycle concepts;
- typed immutable models;
- identity, catalogue, purchase aggregate, event, idempotency, cursor, and eventual consistency;
- money/quantity dimensional modeling;
- versioned analytics;
- KANBAN promotion under the human-authorized design-stage rule.

### Design

- Flutter client layers and composition root;
- local persistence schema responsibilities;
- catalogue/product/purchase/purchase-item contracts;
- deterministic identity normalization;
- purchase event envelope;
- Dart analytics registry;
- TypeScript sync API contract;
- Neon logical schema;
- legacy import/migration mapping;
- explicit parity acceptance for PySide6 transition.

## 17.13 Current authorization state

```text
Flutter/Dart shared-client basis: accepted for planning
TypeScript custom API: favored
Neon Postgres: favored
reusable catalogue model: provisionally accepted
purchase aggregate: provisionally accepted
quantity/money representation: provisionally accepted
versioned analytics: provisionally accepted
sync semantics: provisionally accepted
KANBAN promotion: allowed through Didactic protocol
client/API/schema implementation: not authorized
external infrastructure: not authorized
D/E/F: postponed
next step: A/B/C restaging
```


---

# 18. Flutter Restaging Reconciliation and Permanent-Domain Direction

## 18.1 Main reconciliation result

Operational, Didactic, and Design converge on one planning architecture:

```text
Flutter/Dart shared client
→ application-private local persistence
→ account-private reusable catalogue
→ atomic Purchase aggregate and pending event
→ authenticated TypeScript synchronization API
→ Neon Postgres account-scoped accepted history
```

Python/PySide6 remains the accepted Cycle 06 client, behavioral reference, migration source, and rollback. Python is not embedded in Flutter. Cross-runtime continuity uses language-neutral JSON contracts, deterministic fixtures, and migration evidence.

No report authorizes application code, physical schemas, external infrastructure, authentication setup, Flutter initialization, or D/E/F.

## 18.2 Accepted planning decisions

Main accepts for permanent-domain classification:

- Flutter/Dart as the shared Windows/Android/iOS client basis;
- TypeScript as the favored synchronization-API language;
- Neon Postgres as favored managed shared persistence;
- progressive Flutter replacement only after evidenced parity;
- protected PySide6 application and original database until acceptance;
- account-private reusable Product and Store catalogue;
- immutable packaged/bulk Product identity rules;
- exact deterministic normalization and advisory-only fuzzy similarity;
- Purchase as an atomic aggregate containing one or more Purchase Items;
- one `purchase.registered` event containing item lines;
- dimensional MASS/KG, VOLUME/L, COUNT/UNIT representation;
- explicit currency and integer minor-unit money;
- authoritative catalogue/purchase/item facts and rebuildable projections;
- versioned Dart analytics registry;
- event UUID idempotency;
- per-device monotonic sequence;
- account-scoped opaque server cursor;
- purchase-business occurrence timestamp separate from sync order;
- per-event upload transactions/results;
- transactional local event application and cursor advancement;
- verified email mapped to immutable internal account UUID;
- custom API as mandatory client/cloud boundary;
- general editing, deletion, sharing, global catalogue, realtime/background sync, and public release deferred.

## 18.3 Provisional definitions requiring fixture evidence

Main retains as provisional:

### Normalization v1

```text
Unicode normalization
trim and collapse whitespace
locale-independent case rule
explicit PACKAGED/BULK mode
within-dimension unit conversion only
canonical fixed-precision representation
normalization version embedded in identity derivation
```

### Deterministic Product UUID

A namespaced, account-scoped UUID derived from the versioned canonical identity string is favored. Acceptance requires fixtures proving Dart/TypeScript/Python equivalence, unit equivalence, Unicode behavior, version migration, and collision handling.

### Purchase payload and snapshots

A Purchase event should carry receipt-level facts, Store bootstrap identity/name, Product identity records required by its Items, and immutable commercial item lines. Broad duplicated Product snapshots remain unnecessary while identity records are immutable. Exact optional fields remain provisional.

### Quantity and currency details

The dimension/unit model is accepted. Exact decimal scale/range, fractional COUNT policy, currency minor-unit metadata, and serialized canonical decimal form remain technical choices.

### RLS

Database row-level security remains defense in depth for evaluation. API authorization is mandatory regardless.

## 18.4 Experiment candidates, not dependencies

Operational evidence identifies:

```text
Flutter persistence candidate:
    Drift first

Retained persistence comparison:
    sqflite_common_ffi

Secure credential candidate:
    flutter_secure_storage

Local protocol environment:
    TypeScript API
    disposable Postgres
    fake/test identity issuer

Later shared environment:
    non-production Neon
```

These are preferred Sprint 03 experiment candidates only. Permanent domain memory must not describe their compatibility as validated or their selection as final.

## 18.5 Validation direction

A future bounded Sprint 03 unit should prove, in order:

1. pinned Flutter/Dart and TypeScript/Node environments;
2. canonical shared JSON fixtures;
3. normalization and deterministic identity parity;
4. fresh Drift-local databases for simulated devices A/B;
5. packaged/bulk and exact/similarity catalogue behavior;
6. atomic Purchase + Items + pending event;
7. close/reopen and projection/analytics rebuild;
8. local TypeScript API + disposable Postgres;
9. idempotent retry, sequence gap, cursor paging, bootstrap, restart, and cross-account denial;
10. Windows and Android build/run;
11. Cycle 06 database isolation;
12. iOS explicitly deferred until macOS/Xcode evidence;
13. non-production Neon only after the local protocol passes.

This remains forward planning. D/E/F are still postponed.

## 18.6 Didactic promotion acceptance

Main accepts the proposed canonical promotion set, subject to final ID recheck immediately before materialization. All new concepts begin Red.

### Foundational

```text
&&&06 Stable Identity
&&&07 Authentication
&&&08 Authorization
&&&09 Eventual Consistency
&&&10 Historical Integrity
```

### Dart-language

```text
&&%05 Immutable Dart Model
```

### Project/model

```text
&%%07 Reusable Catalogue
&%%08 Product Identification Set and Deterministic Normalization
&%%09 Purchase Aggregate
&%%10 Purchase Item
&%%11 Append-Only Synchronization Event
&%%12 Offline Queue and Idempotent Delivery
&%%13 Device Ordering and Synchronization Cursor
&%%14 Sync Protocol
&%%15 Dimensional Quantity
&%%16 Monetary Minor Unit
&%%17 Versioned Analytic
```

### Framework/dependency

```text
%%%07 Flutter Framework and Responsive Widget Composition
```

Reconciliation constraints:

- Authoritative Fact / Derived Projection remains within `&&&02`;
- Purchase atomicity extends `&%%05`;
- Row Ownership is an Authorization example;
- Composition Root/Lifecycle remain related to existing responsibility/resource concepts until later evidence justifies independent promotion;
- protocol versioning belongs to Sync Protocol;
- storage-schema versioning remains related to `%%%01`;
- no maturity state changes automatically.

## 18.7 Permanent-domain materialization route

### Operational

Update:

- `operational/11_OPERATIONAL_RECORD.md` observationally;
- `operational/10_OPERATIONAL_STATE.md` as checkpoint;
- `operational/04_TODO.md` as active derived gates;
- `operational/12_OPERATIONAL_MODEL.md` only for stable technology-independent validation rules.

Preserve candidate-versus-validated distinctions.

### Didactic

Update:

- `didactics/02_KANBAN.md` with accepted concepts;
- `didactics/07_GLOSSARY.md` only as derivative;
- `didactics/08_CONCEPT_MAP.md` with the dependency spine;
- `didactics/13_LECTURE_REGISTER.md` observationally.

All new concepts begin Red.

### Design

Update:

- `design/03_DECISION_LOG.md` observationally;
- `design/09_DESIGN_STATE.md` as checkpoint;
- `design/14_MODEL_OVERVIEW.md` as derived map;
- `design/01_ARCHITECTURE.md` only with stable accepted planning boundaries, excluding physical schemas and unvalidated plugins.

## 18.8 Remaining open decisions

These remain for Sprint 03 preparation or evidence:

- exact Flutter project/repository layout;
- Drift versus retained SQLite alternative after experiment;
- exact secure-storage plugin after packaged validation;
- Flutter state-management/navigation choices;
- auth provider;
- TypeScript API framework/runtime/host;
- Postgres migration tool;
- canonical JSON/schema toolchain;
- exact decimal implementation and ranges;
- fractional COUNT policy;
- currency minor-unit metadata source;
- normalization-version migration;
- legacy ambiguous-data policy;
- RLS adoption;
- event/bootstrap paging limits;
- device-sequence recovery after local queue corruption;
- exact parity threshold for PySide6 retirement.

## 18.9 Current state

```text
Sprint 02 Flutter A/B/C restaging: complete
Main reconciliation: complete
permanent-domain updates: authorized next
KANBAN promotions: accepted, all Red
Flutter/Dart planning basis: accepted
TypeScript API and Neon: favored
experiment dependencies: provisional
physical schemas and implementation: unauthorized
D/E/F: postponed
00/05/06 refresh: after permanent-domain reconciliation
```

---

# 19. Cycle 07 Sprint 03 Primary Materialization Reconciliation

> Date: 2026-07-12
> Branch: `cycle-07-mobile-preparation`
> Materialization commit: `5ef64a1d5b6af6d397d4f3a7aea6d635911be12d`
> D/E/F authority: Cycle 07 Sprint 03 Flutter Foundation
> Evidence: `G_OPS_CODEX.md`, `H_DDC_CODEX.md`, `I_DSN_CODEX.md`
> Status: Primary Main staging for functional-domain review; not yet permanent-domain promotion

## 19.1 Reconciled outcome

Sprint 03 Unit 01 materially implemented the additive Flutter/Dart foundation. This is no longer a paper architecture or empty framework experiment.

Verified repository state:

```text
existing Python/PySide6 beta preserved
+ Flutter application under clients/markei_flutter
+ Android/iOS/Windows generated targets
+ Dart domain/application/infrastructure boundaries
+ Drift local schema and generated database source
+ shared_beta/v1 JSON fixtures
+ atomic local Purchase registration repository
+ pending purchase.registered event creation
+ catalogue, rollback, persistence, and analytics tests
+ G/H/I evidence
```

The materialization is one commit ahead of the prior D/E/F head and contains only the authorized Flutter client, shared fixtures, and G/H/I surfaces.

Validation reported by Codex:

```text
flutter pub get: passed
Dart generation and formatting: passed
flutter analyze: passed, no issues
flutter test: 9 passed
Python unittest suite: 5 passed
Android runtime/build: host-blocked
Windows runtime/build: host-blocked
iOS runtime/build: host-unavailable
```

Therefore Main classifies the result as:

- **implemented and unit-tested:** Dart domain rules, local Drift persistence, aggregate transaction, pending-event preparation, close/reopen behavior, minimal analytics registry;
- **generated but host-unvalidated:** Android, Windows, and iOS platform targets;
- **not implemented:** user purchase workflow, authentication, TypeScript API, Postgres/Neon, actual upload/download synchronization, cross-device convergence, legacy import, parity, and Python retirement.

Sprint 03 Unit 01 is materially successful but does not complete the Sprint 03 vertical slice or Cycle 07.

## 19.2 Repository-size interpretation

The large file increase is primarily conventional generated material:

- `local_database.g.dart` is Drift-generated database code and should not be manually maintained;
- `pubspec.lock` records the resolved dependency graph;
- Android, iOS, and Windows directories contain Flutter platform runners, build descriptions, icons, and metadata;
- iOS project metadata is especially verbose;
- the handwritten Markei domain/application/infrastructure source is comparatively bounded.

Large generated files must remain distinguishable from architectural complexity. Their presence is not evidence of equivalent business complexity, but their generator versions and regeneration commands become operational responsibilities.

Domain documentation should record ownership rules:

```text
handwritten Dart: reviewed directly
generated Dart/platform files: reviewed through source schema/config + regeneration evidence
lockfile: committed dependency resolution evidence
build output and local databases: excluded
```

## 19.3 Meaning of the JSON contract files

The files under `contracts/shared_beta/v1/` are not database tables and are not user data. Their intended role is to give Dart, future TypeScript, and any migration tooling the same examples and expected semantic outcomes.

The direction is valid, but the current fixtures are only first evidence:

- `catalogue_identity.json` is the strongest fixture and contains inputs plus expected normalized identity;
- `purchase_aggregate.json` mainly contains scenario counts/totals and does not yet encode complete purchase inputs and expected canonical outputs;
- `sync_event.json` mainly declares envelope examples and required field names, rather than a complete canonical payload with schema validation;
- no JSON Schema or equivalent validator currently fixes required types, nullability, ranges, enum values, additional-field behavior, canonical ordering, or version migration;
- cross-language Dart/TypeScript equivalence has not been executed.

Permanent documentation may call these **versioned semantic fixtures** or **contract examples**, but must not call them a complete protocol specification.

## 19.4 Accepted implementation evidence

The following planning decisions now have local executable evidence:

1. Flutter/Dart can coexist additively with the Python/PySide6 beta.
2. The new client can own a fresh app-private database rather than reuse the Cycle 06 database.
3. The domain can remain independent from Flutter widgets and Drift.
4. Products can be represented as account-private reusable catalogue identities.
5. PACKAGED and BULK modes can have distinct identity rules.
6. MASS, VOLUME, and COUNT can remain dimensionally explicit.
7. KG, L, and UNIT can remain canonical without assuming mass/volume equivalence.
8. Money can use an explicit ISO currency code and integer minor units.
9. Purchase can be represented as an aggregate with one or more Items.
10. Purchase facts, Items, a local immutable event, and a pending queue entry can be committed atomically.
11. Invalid Item validation can roll back the aggregate.
12. Local facts and pending events can survive close/reopen.
13. Analytics can be selected through an identifier/version registry without rewriting raw facts.
14. Drift is now an implemented local persistence choice for the foundation, not merely a candidate.

These claims remain local and unit-test bounded. Platform lifecycle and distributed behavior are not implied.

## 19.5 Newly exposed design and correctness questions

Functional domains must review these before permanent documentation treats implementation details as settled.

### A. Device-sequence continuity

`registerPurchase` currently upserts the Device with `nextSequence: 1` before allocating a sequence. A repeated registration may reset the counter and reuse sequence 1. The schema also lacks an explicit uniqueness constraint over the account/device/sequence responsibility.

Required disposition:

- classify this as a likely implementation defect;
- do not promote monotonic device ordering as implemented;
- require a repeated-purchase test proving sequences 1, 2, 3 without reset;
- require uniqueness and recovery semantics before the sync protocol relies on the field.

### B. Unicode and locale-safe normalization

The current text normalization uses a regular expression based on `\w`. Its behavior may remove or damage accented letters important to Portuguese product names. No Unicode normalization form, diacritic policy, locale policy, punctuation policy, or cross-language canonical-byte test is yet evidenced.

Required disposition:

- exact normalization v1 remains provisional;
- preserve display text separately from normalized identity;
- add Portuguese/Unicode fixtures such as accented names before identity stability is claimed;
- do not retroactively change identity rules without an explicit normalization-version migration.

### C. Deterministic Product identifier format

The implementation derives a UUID-shaped string from SHA-256 bytes. It is deterministic, but it does not presently demonstrate an RFC UUID version/variant contract or cross-language equivalence.

Required disposition:

- describe it as a deterministic Product identifier candidate;
- decide whether Markei requires RFC UUID semantics or only a stable opaque identifier;
- add fixed expected Product-ID values and TypeScript parity before protocol promotion.

### D. Contract completeness

Current purchase and event fixtures are too shallow to serve as complete wire contracts. They prove direction and test coordination, not schema completeness.

Required disposition:

- decide whether Sprint 04 adopts JSON Schema, hand-validated canonical JSON, or another language-neutral schema mechanism;
- require full valid/invalid payload examples;
- define types, ranges, nullability, enums, unknown-field behavior, timestamp form, decimal serialization, and version compatibility;
- retain human-readable fixtures rather than replacing them with generated-only artifacts.

### E. Platform evidence

Platform directories exist, but none has been built or run on the current host. Windows requires the Visual Studio C++ desktop workload; Android requires the SDK/emulator or device; iOS requires macOS/Xcode.

Required disposition:

- no responsive shared-application or lifecycle validation claim yet;
- Sprint 04 should prioritize at least Windows and Android execution before cloud sync expansion, unless Main explicitly selects the local protocol harness first.

### F. Schema and migration ownership

The Drift schema is version 1 and creates a migration-ledger entry, but no schema upgrade has been rehearsed. The ledger timestamp is source-fixed rather than execution-derived.

Required disposition:

- treat fresh creation as validated;
- treat schema evolution and migration recovery as unvalidated;
- review whether the ledger records authored migration identity, execution time, or both;
- keep legacy Cycle 06 import entirely separate.

### G. Catalogue and Store semantics

Store reuse currently depends on an exact display-name match. Similar Store names, locations, branches, and stable Store identity remain undefined. Product similarity considers mainly Product name and does not constitute a deduplication workflow.

Required disposition:

- preserve warning-only Product similarity;
- do not claim Store deduplication;
- carry Store identity/location and Product merge/alias into later bounded design.

## 19.6 Didactic evidence boundary

Executable evidence justifies review of the local concepts, but not automatic KANBAN promotion.

Candidate evidence-bearing concepts:

```text
&&&06 Stable Identity
&&&10 Historical Integrity
&&%05 Immutable Dart Model
&%%07 Reusable Catalogue
&%%08 Product Identification Set and Deterministic Normalization
&%%09 Purchase Aggregate
&%%10 Purchase Item
&%%11 Append-Only Synchronization Event
&%%12 Offline Queue and Idempotent Delivery
&%%15 Dimensional Quantity
&%%16 Monetary Minor Unit
&%%17 Versioned Analytic
%%%07 Flutter Framework and Responsive Widget Composition
```

Limits:

- `&%%13 Device Ordering and Synchronization Cursor` has only partial structure and a likely sequence defect;
- `&%%14 Sync Protocol` has envelope preparation but no server protocol;
- `&&&07 Authentication`, `&&&08 Authorization`, and `&&&09 Eventual Consistency` remain unimplemented;
- Flutter framework setup is evidenced, but responsive composition and platform runtime are not;
- no maturity change occurs until Didactic Chat applies the KANBAN evidence rules.

## 19.7 Sprint 04 candidate routes

Functional chats must assess two bounded next routes without silently combining them.

### Route 1 — Local shared-client vertical slice

```text
correct identity/sequence defects
→ strengthen fixtures
→ minimal Flutter purchase UI
→ app-private database initialization
→ catalogue Product selection/creation
→ Store selection/creation
→ multi-item Purchase staging
→ atomic registration
→ visible local projection/history
→ close/reopen
→ Windows and Android build/run
```

This route provides the clearest user-visible shared-beta progress and platform evidence.

### Route 2 — Local synchronization protocol harness

```text
correct identity/sequence defects
→ complete canonical wire fixtures/schema
→ TypeScript API boundary
→ disposable local Postgres
→ fake/test account identity
→ upload/idempotent retry
→ sequence-gap rejection
→ cursor paging/bootstrap
→ second-device application
→ cross-account denial
```

This route advances the selected custom API + Neon architecture but risks building distributed infrastructure before the Flutter client has a validated user workflow.

Primary Main orientation for domain review favors **Route 1 first**, with contract-hardening and sequence correction included at its start. Route 2 remains the likely following unit. This is an orientational preference, not Sprint 04 authorization.

## 19.8 Permanent-domain review route

No permanent document is updated by this J stage. Functional chats should now reconcile the evidence into their existing permanent surfaces.

### Operational review targets

- `operational/04_TODO.md`
- `operational/10_OPERATIONAL_STATE.md`
- `operational/11_OPERATIONAL_RECORD.md`
- `operational/12_OPERATIONAL_MODEL.md`

Emphasize toolchain/runtime blockers, generated-file ownership, validation evidence, sequence defect, Unicode fixture need, platform prerequisites, and Sprint 04 gates.

### Didactic review targets

- `didactics/02_KANBAN.md`
- `didactics/07_GLOSSARY.md`
- `didactics/08_CONCEPT_MAP.md`
- `didactics/13_LECTURE_REGISTER.md`

Apply evidence-based maturity carefully. Explain JSON fixtures as language-neutral contract examples. Preserve the difference between local offline queue preparation and actual synchronization.

### Design review targets

- `design/01_ARCHITECTURE.md`
- `design/03_DECISION_LOG.md`
- `design/09_DESIGN_STATE.md`
- `design/14_MODEL_OVERVIEW.md`

Promote stable local boundaries; preserve physical implementation facts observationally; document the newly exposed correctness questions; compare Sprint 04 routes and provide a recommendation.

## 19.9 Main continuation boundary

After the three domain chats update and push their permanent surfaces:

1. Main reads all changed permanent files.
2. Main appends a second Sprint 03 reconciliation to J.
3. Main resolves conflicts and identifies any question needing human definition.
4. Main refreshes `00_PROJECT_STATE.md`, `05_SESSION_LOG.md`, and `06_SESSION_SCHEME.md`.
5. Main defines the Cycle 07 Sprint 04 milestone.
6. D/E/F remain inactive until the human approves the Sprint 04 materialization target.

Current concise state:

```text
Sprint 03 Unit 01 implementation: materialized
local Dart/Drift tests: passed
Python regression tests: passed
Flutter platform projects: generated
platform execution: unvalidated
JSON contracts: useful first fixtures, incomplete protocol specification
device ordering: likely defect, not accepted
Unicode normalization: unresolved
full Flutter user workflow: absent
sync API/cloud: absent
domain permanent review: authorized next
00/05/06 refresh: after domain reconciliation
Sprint 04: not yet authorized
```

---

# 20. Cycle 07 Sprint 03 Permanent-Domain Reconciliation and Sprint 04 Orientation

> Date: 2026-07-12
> Branch: `cycle-07-mobile-preparation`
> Domain-reconciled head inspected: `36996361ce06e8833b91e04800ccbe0944d778e1`
> Sources: all twelve Operational, Didactic, and Design permanent files after their latest temporal boundary
> Status: Main provisional synthesis accepted for 00/05/06 continuity; implementation still requires new D/E/F

## 20.1 Cross-domain agreement

Operational, Didactic, and Design permanent reconciliation is complete and mutually coherent.

All domains agree that Sprint 03 Unit 01 established:

- an additive Flutter/Dart client beside the protected Python/PySide6 beta;
- an independent Dart domain and application boundary;
- fresh Drift-local persistence;
- reusable account-private catalogue structures;
- Purchase and Purchase Item aggregation;
- atomic local facts, event, and pending-queue persistence;
- rollback and close/reopen evidence;
- dimensional quantity, minor-unit money, and versioned analytics foundations;
- useful but incomplete language-neutral semantic fixtures;
- nine passing Flutter tests, clean analysis, and five passing Python regressions.

All domains preserve the same evidence limits:

- no Windows, Android, or iOS runtime evidence;
- no responsive purchase workflow;
- no authentication, API, Postgres/Neon, or distributed synchronization;
- no schema-upgrade rehearsal or legacy import;
- no PySide6 retirement or parity claim;
- no Didactic maturity transition.

No permanent-domain conflict requires human arbitration before forward planning.

## 20.2 Defects and provisional boundaries carried forward

The following are mandatory Sprint 04 entry corrections, not optional polish:

1. Device registration must not reset `nextSequence`; repeated purchases must allocate 1, 2, 3.
2. Account/device/sequence ownership requires an explicit uniqueness invariant and recovery test.
3. Product display text must be preserved separately from normalized identity.
4. Unicode and Portuguese accented text require canonical fixtures and an explicit normalization policy.
5. Deterministic Product identity must be specified as either a stable opaque identifier or an RFC-defined UUID form.
6. Purchase and sync fixtures must become complete enough to validate types, ranges, nullability, enums, timestamps, decimal form, unknown fields, and version compatibility.
7. Drift schema evolution must be rehearsed separately from legacy Cycle 06 import.
8. Store reuse remains exact-name behavior, not Store deduplication.
9. Product similarity remains advisory and never automatically merges.

## 20.3 Sprint 04 route selection

Main accepts the unanimous domain recommendation:

> Sprint 04 should complete the local shared-client vertical slice before beginning the TypeScript/Postgres synchronization harness.

Authorized planning sequence:

```text
correct device sequencing
→ harden Unicode identity and deterministic-ID fixtures
→ strengthen human-readable contract fixtures
→ minimal Flutter purchase workflow
→ Product and Store select/create
→ multi-item Purchase staging
→ atomic registration
→ visible local history/projection
→ close/reopen
→ Windows build/run
→ Android build/run when the SDK/emulator or device is available
```

The synchronization harness remains the candidate following unit and must not be silently combined with this route.

## 20.4 Implementation directives for future D/E/F

A future Sprint 04 D/E/F package should divide work into independently testable units:

### Unit A — Correctness foundation

- preserve an existing Device row during purchase registration;
- allocate and persist monotonic sequence atomically;
- add repeated-registration, uniqueness, rollback, and reopen tests;
- preserve original Product display name/brand alongside normalized identity;
- specify and test Unicode normalization with Portuguese examples;
- record normalization version in identity and fixtures;
- choose and document deterministic identifier semantics.

### Unit B — Contract hardening

- keep JSON examples human-readable;
- add full valid/invalid Product, Purchase, and event examples;
- evaluate JSON Schema as the preferred first validator;
- do not claim Dart/TypeScript parity until both runtimes execute the same fixtures;
- avoid implementing the TypeScript service in this unit.

### Unit C — Local Flutter workflow

- replace the placeholder foundation screen with a minimal Purchase flow;
- initialize the app-private Drift database through the composition root;
- stage one or more Items;
- select or create Product and Store;
- call the existing application/repository boundary;
- show a successful local Purchase and a visible local history/projection;
- preserve warning-only similarity;
- survive close/reopen.

### Unit D — Platform evidence

- run analysis and tests;
- build and launch Windows;
- validate database path and lifecycle persistence;
- build and launch Android when tooling exists;
- keep iOS explicitly unvalidated outside macOS/Xcode;
- preserve the Python beta and rerun its regression suite.

Each unit needs its own pass/fail boundary in D/E/F and exact G/H/I reporting.

## 20.5 Human decisions and actions

Human action is required before materialization for:

1. approving the Sprint 04 local-client route;
2. approving installation of missing Windows/Android host prerequisites;
3. choosing whether Product IDs are stable opaque deterministic IDs or standards-defined UUIDs;
4. accepting JSON Schema as the first contract validator, or selecting an alternative;
5. deciding whether Android execution belongs to the same materialization unit or may be a recorded host-blocked follow-up.

Main recommendation:

- use a standards-defined deterministic UUID form if cross-language libraries produce identical fixed fixtures; otherwise expose the identifier as an opaque stable Product ID and do not call it a UUID;
- use JSON Schema for structural wire validation while retaining readable example JSON;
- require Windows execution in Sprint 04; allow Android to remain a precise blocker only if SDK/emulator setup cannot be completed safely in the available host.

## 20.6 Current executable entrypoint

The Flutter equivalent of the former Python entry command is run from the Flutter client directory:

```powershell
cd clients/markei_flutter
flutter pub get
flutter run -d windows
```

At the inspected state this launches only the foundation screen:

```text
Markei shared client foundation
```

It does not yet expose the Purchase workflow or open the Drift database through the UI.

Until the Visual Studio C++ desktop workload is installed, the reliable executable verification is:

```powershell
cd clients/markei_flutter
flutter analyze
flutter test
```

Android later uses `flutter devices` followed by `flutter run -d <device-id>`.

## 20.7 Continuation state

```text
Sprint 03 Unit 01: closed as local foundation
domain permanent reconciliation: complete
J second reconciliation: complete
00/05/06 refresh: authorized now
Sprint 04 route: local shared-client vertical slice
Sprint 04 implementation: not yet authorized
D/E/F: must be freshly written after human choices
TypeScript/Postgres harness: deferred following route
Cycle 07: open
```

---

# 21. Cycle 07 Sprint 04 A/B/C Reconciliation and D/E/F Authority Basis

> Date: 2026-07-12
> Branch: `cycle-07-mobile-preparation`
> A/B/C inspected head: `495dea0c3bc82f04037bcf55d4f11505e3b482b5`
> Sources: Sprint 04 `A_OPERATIONAL.md`, `B_DIDACTIC.md`, `C_DESIGN.md`, J §§19–20, Main-root continuity, and bounded Flutter/Python repository inspection
> Status: Provisional Main staging accepted as the basis for new D/E/F

## 21.1 Agreement

A/B/C agree with repository truth:

- Flutter/Dart and Drift are implemented local foundations, not merely candidates.
- The UI remains a static foundation label.
- Device creation currently risks resetting sequence allocation.
- display Product facts, user Product code, and internal identity are not separated.
- normalization v1 is unsafe for Portuguese/Unicode identity.
- current JSON files are examples, not complete contracts.
- the next coherent materialization is Windows-first local Purchase workflow.
- Android is conditional; cloud synchronization remains deferred.
- Python/PySide6 and its ordinary database remain protected.

No domain proposes a conflicting implementation route.

## 21.2 Identity resolution

Main resolves the open Product responsibilities for Sprint 04:

```text
internalProductId
    immutable random UUID v4
    generated by the application
    database primary/foreign-key identity
    never editable by the user

userProductCode
    required
    chosen by the user
    displayed as the private catalogue handle
    unique inside one account after code normalization
    never used as a primary key
    editing and retired-code reuse deferred

Product Identification Set
    normalized name + normalized brand + mode + package quantity identity facts
    exact catalogue matching responsibility
    versioned independently from userProductCode

futureCentralProductId
    absent in Sprint 04
    future system-controlled mapping for a central catalogue
    not inferred or populated locally now
```

For Sprint 04, `userProductCode` is 1–64 visible characters after trimming. The stored display value is preserved. Its uniqueness key uses Unicode NFKC, lowercase conversion, and collapsed whitespace. Codes are account-scoped and case-insensitively unique. Code editing, alias history, retirement, and reuse are explicit non-goals.

Existing deterministic Product-ID derivation is retired from new Product creation. Migration preserves existing Product rows by retaining their current IDs as opaque immutable internal IDs; it does not rewrite them merely because new rows use UUID v4.

## 21.3 Normalization v2

Main accepts a bounded normalization-v2 rule:

- preserve display name and display brand;
- apply Unicode NFKC;
- trim and collapse whitespace;
- lowercase after normalization;
- replace a fixed documented punctuation set with spaces for semantic name/brand matching;
- preserve accented Portuguese letters;
- retain PACKAGED/BULK and within-dimension canonical quantity rules;
- embed normalization version in exact identity;
- never silently reinterpret v1 identities.

The first implementation may use `unorm_dart` for Unicode normalization. Fixed fixtures must cover `Café`, decomposed/composed accents, mixed case, whitespace, punctuation, kilogram/gram equivalence, and similarity-only misspellings.

## 21.4 Contract resolution

Sprint 04 creates `contracts/shared_beta/v2/` rather than rewriting v1.

Main selects:

- JSON Schema Draft 7;
- readable valid and invalid examples;
- Dart `json_schema` validation in tests;
- no remote schema references or runtime network requirement;
- structural validation separated from domain invariant tests.

V2 must describe catalogue/Product, Purchase aggregate, and `purchase.registered` envelope structures, including identifier distinctions, types, enums, ranges, nullability, additional-property policy, timestamps, quantity strings, minor-unit money, and versions.

## 21.5 Migration and sequence resolution

Drift schema version advances from 1 to 2.

Required migration:

- add display name and display brand;
- add nullable-then-backfilled user Product code or another deterministic migration-safe bootstrap;
- add normalized user-code key;
- preserve every existing Product ID and Purchase reference;
- add account-scoped user-code uniqueness;
- add account/device/sequence uniqueness for events;
- preserve existing data and pending events;
- record migration execution with runtime time rather than a source-fixed date.

Because old rows have no human-selected code, migration may assign a clearly marked temporary account-unique code such as `legacy-<stable-id-prefix>`. The UI must distinguish it as requiring later user review; automatic Product meaning must not be invented.

Device registration must insert only when absent and never reset an existing sequence. Allocation remains inside the Purchase transaction and must prove 1, 2, 3 across repeated registration and reopen.

## 21.6 UI and platform resolution

Sprint 04 UI is deliberately minimal:

- responsive Windows-capable Material interface;
- Purchase form with Store, Product code/name/brand/mode/package data, quantity, and line total;
- multi-item staging;
- review total;
- atomic submit through the application port;
- success/error state;
- local Purchase history sufficient to show Purchase ID, occurrence time, Store, currency, total, and item count;
- close/reopen persistence.

No new state-management dependency is required; conventional Flutter state is preferred for this bounded slice.

Windows build/run is required. D/E/F may authorize Visual Studio 2022 Desktop development with C++ setup, using workload ID `Microsoft.VisualStudio.Workload.NativeDesktop`, subject to Codex approval prompts and post-install `flutter doctor -v`.

Android tooling installation is not authorized in this unit. If an Android SDK/device already exists, attempt a debug build. Otherwise record the precise blocker. iOS remains deferred.

## 21.7 D/E/F boundary

D/E/F may now authorize:

```text
correct sequence
+ separate Product identities
+ schema v2 migration
+ normalization v2
+ shared_beta/v2 JSON Schema/examples
+ local Flutter Purchase UI/history
+ Windows toolchain/build/run
+ conditional Android build
+ Python regression and Cycle 06 isolation
```

They must not authorize TypeScript, Postgres/Neon, authentication, real sync, legacy import, Product code editing, central catalogue UUID assignment, or PySide6 retirement.

---

# 22. Cycle 07 Sprint 04 Post-Codex Permanent Reconciliation

> Date: 2026-07-12
> Branch: `cycle-07-mobile-preparation`
> Reconciled remote head: `c195ed9b4197927db9c015076159534aa47c88e3`
> Materialization commit: `bcc9452805ea5eee19f37653dc017fb5f3c78a0c`
> Sources: G/H/I, PDR2 permanent updates, current checkpoints, and bounded application/Android repository inspection
> Status: Provisional Main reconciliation accepted for 00/05/06 refresh

## 22.1 Materialized result

Sprint 04 produced a real Windows-local Flutter vertical slice:

- Product user code separated from immutable internal Product identity;
- normalization v2 with Unicode NFKC and preserved display facts;
- Product IDs no longer derived from semantic identity;
- Device sequence reset corrected and uniqueness constrained;
- Drift schema v2 and a tested v1→v2 migration;
- versioned v2 JSON Schemas and examples;
- local catalogue/history query ports;
- application composition root;
- multi-item Purchase UI;
- local Purchase history UI;
- 21 passing Flutter tests;
- five passing Python regression tests;
- successful Windows release build;
- successful five-second Windows startup smoke.

The Python/PySide6 source and ordinary database remained unchanged.

## 22.2 Evidence boundary

Validated:

```text
format/analyze
21 Flutter tests
5 Python tests
local Product-code/identity behavior
Unicode normalization fixtures
device-sequence behavior
schema v1→v2 migration test
JSON Schema structural validation
widget Purchase/History flow
Windows release build
Windows startup smoke
```

Still required from the human:

- interact with the Windows Purchase form;
- register a two-item Purchase;
- inspect History;
- close and relaunch;
- confirm persistence and visible behavior.

Windows startup smoke is not complete manual UI acceptance.

Android remains unbuilt and unexecuted because the SDK was absent and Sprint 04 prohibited Android installation.

iOS remains host-unvalidated.

## 22.3 Permanent-domain consistency

Design and Didactic PDR2 checkpoints reflect the Sprint 04 implementation and its evidence limits.

Operational canonical, derived, and observational files contain useful Sprint 04 evidence, but `operational/10_OPERATIONAL_STATE.md` remains stale:

- it cites inspected head `32898f56f76895dc0f23d72cd132bcc24830e740`;
- it says Sprint 04 implementation has not started;
- it describes schema v1, 9 Flutter tests, and Windows as blocked.

G, repository truth, Design checkpoint, and Didactic checkpoint supersede those claims.

Resolution:

- Main global continuity uses implementation truth;
- the stale Operational checkpoint remains a documented recovery defect;
- Operational Chat must rerun PDR2-O after this J reconciliation and compactly rewrite its current checkpoint;
- Main does not directly rewrite the domain checkpoint.

## 22.4 Repository findings carried forward

Current implementation still contains bounded provisional areas:

- composition uses fixed `local-account` and `windows-device` identifiers;
- Android still uses generated `com.example.markei` application ID;
- Android toolchain, emulator/device, build, runtime, lifecycle, and persistence are unevidenced;
- Product-code editing/alias/reuse remains absent;
- Store branch/location identity remains absent;
- fresh-create ledger time remains source-fixed while upgrade time is runtime UTC;
- UI responsiveness/accessibility and real Windows interaction remain human-unverified;
- local event/queue remains preparation, not synchronization.

## 22.5 Next milestone selection

The human selects Android full implementation as the next forward milestone.

The next bounded route is:

```text
close Windows manual verification
→ authorize Android tooling installation
→ install/validate Android Studio + SDK/tooling
→ establish stable Android application ID
→ replace Windows-specific Device ID with persistent platform-neutral local Device identity
→ build debug APK
→ run on emulator or physical device
→ execute Purchase/History workflow
→ verify Android app-private Drift persistence across process restart
→ validate rotation/back/keyboard/narrow layout
→ rerun Flutter/Windows/Python regressions
```

This is a platform-completion milestone, not a synchronization milestone.

## 22.6 Android acceptance boundary

Android full implementation requires:

- latest supported Android Studio;
- Android SDK platform matching current Flutter guidance;
- Build-Tools;
- command-line tools;
- Emulator;
- Platform-Tools;
- CMake and NDK where Flutter tooling requires them;
- accepted Android SDK licenses;
- one recognized emulator or physical test device;
- successful `flutter build apk --debug`;
- successful `flutter run -d <android-device>`;
- executed UI workflow;
- close/reopen persistence;
- no Cycle 06 access;
- precise G/H/I evidence.

Installation and license acceptance require explicit future D/E/F scope and user approval at the tool prompts.

## 22.7 Deferred boundary

Still deferred:

- TypeScript API;
- Postgres/Neon;
- authentication/authorization;
- actual upload/download;
- server cursor and second-device convergence;
- central Product catalogue;
- legacy import;
- editing/deletion;
- PySide6 retirement;
- iOS validation;
- production store signing/release.

## 22.8 Continuation

```text
Sprint 04 code materialization: complete
Windows automated evidence: complete
Windows manual UI acceptance: pending human
PDR2 permanent reconciliation: complete with Operational checkpoint drift
Main J reconciliation: complete
00/05/06 refresh: authorized now
next milestone: Android full implementation
new Android D/E/F: not yet written
Cycle 07: open
```
