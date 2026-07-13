# F_DSN_STAGE

> Cycle: 08 — Shared-Client Product Beta
> Round: C08-R01
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
> Purpose: Domain confrontation; no implementation authority
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> Main source: `[M]_STAGE/J_[M]_STAGE.md` at reconciliation commit `fc22f0484b2896f3ee579cd76f489fab1487b56d`

This file is an iterative staging draft. It does not authorize source, dependency, schema, tool, host, infrastructure, permanent-memory, or Codex changes.


# 1. Conciliated Design outcome

Prepare Design Chat [D] to confront a reversible Cycle 08 product architecture derived from J and current repository structure.

This file proposes responsibility boundaries and alternatives. It does not select final widgets, dependencies, schema, migrations or source files for implementation.

# 2. Preserved architecture

Keep:

```text
Flutter presentation
→ application commands/query ports
→ independent Dart domain
← infrastructure adapters
→ Drift application-private SQLite
```

Preserve:

- protected Python/PySide6 beta and isolated database;
- Product internal ID, visible code and identification facts;
- advisory similarity without automatic merge;
- Purchase aggregate and local transaction ownership;
- raw facts versus rebuildable projections;
- local queue as synchronization preparation only;
- platform hosts outside domain behavior;
- current Device debt visibility.

# 3. Provisional responsive shell

Candidate responsibility:

- one shared set of semantic destinations;
- narrow presentation through bottom navigation or equivalent;
- wide presentation through rail or equivalent;
- selection/state independent of the visual navigation control;
- width/constraints rather than platform name choose layout;
- keyboard, focus, Back, safe areas and text scale remain presentation/host concerns.

Candidate destinations requiring human choice:

A. Purchase, Catalogue, History; Store as picker;  
B. Purchase, Catalogue, Stores, History;  
C. Purchase and History top-level; Catalogue/Store as nested selection flows.

No router/state package is justified yet. Prefer injected SDK-level state until requirements prove otherwise.

# 4. Purchase draft coordinator

Provisional boundary below pages and above registered domain facts.

Owns:

- selected or draft Store;
- staged Items;
- add/edit/remove;
- validation;
- running total;
- review phase;
- busy/result state;
- submission identity;
- cancel/reset;
- policy-driven survival across navigation/lifecycle.

Widgets own text controllers, focus and rendering. Drift does not own transient drafts unless process-death restoration is explicitly accepted.

R02 must compare draft lifetimes:

1. mounted page only;
2. app-session/navigation survival;
3. background/rotation survival;
4. process-death restoration.

# 5. Catalogue and Store boundaries

Catalogue:

- first-class query/search surface;
- exact reuse;
- advisory similar candidates;
- explicit existing/create-anyway choice;
- no merge/correction expansion in the first unit.

Store:

- reusable UUID identity;
- search/select/create picker;
- no silent merge;
- minimum visible identity still undecided.

R02 must recommend Store identity among:

- normalized name;
- normalized name + optional branch/location label;
- another explicit visible identifier.

# 6. Registration atomicity and idempotency

Existing atomic transaction remains infrastructure-owned.

Provisional new responsibility:

```text
client submission UUID
+ canonical registration content
→ unique local registration attempt
→ identical retry returns prior Purchase result
→ conflicting content under same ID fails
```

UI busy state complements this rule but cannot replace it.

Potential consequences, not authorization:

- submission ID on Purchase/attempt/event responsibility;
- unique index/constraint;
- migration from schema v2;
- command/result contract change;
- identical/conflicting retry tests;
- recovery after restart.

R02 must determine the smallest coherent model and whether idempotency is mandatory in Sprint 03 or split into a separate schema-bearing unit.

# 7. History and analytics ports

Provisionally separate:

- Purchase History list query;
- Purchase detail query;
- Product observation query;
- comparison query/use case.

Widgets do not traverse Drift tables or event JSON.

First analytic remains pure/versioned and returns:

- comparable result with basis and percentage;
- or explicit incompatibility.

No mutable analytic result becomes authoritative fact. Cache is deferred until measurement justifies it.

# 8. Migration, backup and recovery responsibilities

Drift remains the local transaction/migration owner.

Any schema change requires:

- forward migration from representative v2;
- no silent reset;
- retained raw facts;
- restart/reopen tests;
- generated-source reconciliation.

Backup/export, if accepted, requires an application port and local adapter with:

- versioned format;
- consistent read boundary;
- integrity metadata;
- defined restore promise;
- Device identity handling.

Export UI alone is not backup architecture.

# 9. Device timing

Provisional recommendation:

- avoid changing Device schema during responsive/Catalogue work;
- decide the invariant during Cycle 08;
- materialize no later than Sprint 05 if backup/restore or realistic multi-installation testing needs it;
- otherwise make it a hard, documented Cycle 09 entry unit before upload/download.

Required invariant:

- exactly one current installation record;
- exactly one referenced current Device;
- concurrency-safe bootstrap;
- independent historical Devices;
- restore does not clone Device identity accidentally.

# 10. Bounded implementation candidates

For later activation only:

1. responsive shell and explicit state/error model;
2. Catalogue/Store query and picker flows;
3. Purchase draft coordinator and review;
4. local submission idempotency;
5. History detail and observation ports;
6. first versioned comparison;
7. migration/recovery/backup and Device hardening.

Do not combine all candidates in one Codex unit.

# 11. Design questions for C08-R02

Design Chat must answer:

1. Which destination topology best fits the product?
2. What draft lifetime is required?
3. What is the minimum Store identity?
4. What Product fields form user-visible recognition?
5. Where does submission identity live?
6. What constitutes identical versus conflicting retry content?
7. Which History/analytics ports are minimal?
8. What first comparison basis is semantically valid?
9. Does backup/restore enter Cycle 08?
10. When does Device correction become mandatory?
11. Which choices require dependencies or schema changes?
12. What is the smallest reversible first implementation boundary?

# 12. Required R02 report

Replace C with C08-R02 and report:

- agreement/conflict with J and this F;
- preferred alternatives with rationale and reversibility;
- exact responsibility map;
- lifecycle/state implications;
- likely dependency/schema effects without edits;
- migration and rollback requirements;
- unresolved human decisions;
- recommended revisions to J and F;
- proposed first bounded implementation unit.

No architecture is accepted merely because it appears here. No source or schema mutation is authorized.

---

<!-- ENRICHMENT_MARKER:C08-C08-R02-Design-2026-07-13 -->
# Cycle 08 Round C08-R02 — Provisional Design Enrichment

> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX  
> Purpose: Domain confrontation; no implementation authority  
> Main source: J C08-R02 reconciliation at `b244f41c9f76baec3123e7584364969bcc7bc588`  
> Inputs: latest cumulative A/B/C C08-R02 rounds and preceding D/E/F content

## 1. Successive-round classification

Retained:

- inward dependency direction;
- package-neutral responsive shell;
- coordinator below widgets and above facts;
- exact Product reuse/advisory similarity;
- existing/new Store selection;
- SubmissionId distinct from UI busy state;
- separate History list/detail/observation/comparison;
- Drift migration ownership;
- Device debt before synchronization.

Corrected:

- IndexedStack already provides current tab-session retention;
- Product code is mandatory across current domain/UI;
- similarity is bounded by current Product policy;
- Store command remains free-text;
- History state/query defects are concrete;
- F’s earlier instruction to replace C is superseded by append-only FCA-02;
- submission identity should remain distinct from EventId provisionally.

Newly added:

- DraftLineKey;
- explicit presentation/result algebra;
- existing/new Store reference;
- Product-code policy as an isolated structural decision;
- schema-free and schema-bearing unit split.

## 2. Schema-free structural candidates

### F2.1 Responsive shell

Owner: presentation shell.

Responsibilities:

- semantic destinations;
- constraint-driven navigation presentation;
- destination preservation;
- typed async states;
- focus/Back/safe-area/text-scale behavior.

No schema or package required by current evidence.

### F2.2 Draft coordinator

Owner: application-facing presentation model.

Responsibilities:

- DraftLineKey;
- Store selection/draft;
- staged lines;
- add/replace/remove;
- totals;
- validation;
- review phase;
- busy/failed/succeeded/unknown result;
- SubmissionId creation/retention boundary.

Initial lifetime: app session, preserving tab/resize/background behavior selected by the human. Process persistence remains separate.

### F2.3 Product resolution

Owner split:

- domain: exact identity and advisory similarity;
- application: list/filter/resolution result;
- presentation: explicit existing/create-anyway choice;
- adapter: account ownership and exact reuse.

Current list ports may support bounded client filtering; scalable repository search remains evidence-driven.

### F2.4 History structure

Introduce conceptual ports for:

- summary page/list;
- Purchase detail;
- Product observations;
- versioned comparison.

Fix state/query behavior before adding analytics cache or broad infrastructure.

## 3. Schema-bearing structural candidates

### F2.5 Store reference and identity

Command should move from free-text `storeName` toward sealed existing/new Store reference.

Durable normalization/branch identity remains blocked on human policy and collision migration.

### F2.6 SubmissionId

Provisionally:

- created when one submit intent becomes ready;
- carried by command;
- enforced durably;
- identical canonical content returns prior result;
- conflicting content fails;
- remains distinct from PurchaseId and EventId.

Migration should prefer nullable legacy submission identity rather than inventing retry equivalence for old Purchases.

### F2.7 Product-code policy

Retaining mandatory code is lowest cost.

Optional code requires coordinated changes to:

- ProductCode/domain construction;
- ProductDraft;
- identity/normalization rules;
- application command/reference behavior;
- persistence nullability/uniqueness;
- fixtures/contracts;
- migrations and tests.

### F2.8 Installation relation

Must eventually own exactly one current Device, concurrency-safe bootstrap, historical Device separation and restore semantics.

## 4. Prospective structure record

| Structure | Existing owner affected | Lifetime | Persistence impact | Status |
| --- | --- | --- | --- | --- |
| shell state | MarkeiApp | app session | none | highest-priority reversible |
| result algebra | Purchase/History presentation + application results | operation/view | none | high-priority |
| DraftLineKey/coordinator | PurchasePage/PurchaseItemDraft/composition | session initially | none | second bounded unit |
| Product resolution | Catalogue ports/ProductReference/Purchase UI | picker/draft | none initially | Cycle 08 core |
| Store reference | RegisterPurchaseCommand/Store adapter | draft→durable Store | possible schema | blocked on identity |
| SubmissionId | command/repository/Purchase result | submit intent→durable | schema/migration | isolated unit |
| History ports | purchase_history/query adapter | view/query | indexes only if measured | Cycle 08 core |
| comparison | analytics + observation query | rebuildable | none initially | later unit |
| installation relation | Device repository/composition | installation | schema/migration | hardening gate |

## 5. Bounded candidate order

```text
1. shell + typed states
2. draft coordinator + explicit review
3. Product resolution + Store picker contract
4. isolated SubmissionId migration
5. History detail/observations
6. first versioned comparison
7. recovery/backup/Device hardening
```

Do not combine schema-free shell work with Store, SubmissionId, Product-code or Device migrations.

## 6. Design questions for C08-R03

1. Confirm destination topology.
2. Confirm Product-code policy.
3. Confirm quantity truth.
4. Confirm Store identity.
5. Confirm draft lifetime.
6. Confirm Review presentation.
7. Confirm durable idempotency scope.
8. Define canonical content for identical retry, including occurrence time.
9. Confirm comparison basis.
10. Confirm backup and Device timing.
11. Identify exact existing tests/symbols for the first unit.
12. Challenge whether shell + typed states is sufficient as Unit 1.

## 7. Evidence requested next

Design C08-R03 should provide:

- precise responsibility map;
- preferred alternatives and rejected alternatives;
- lifecycle implications;
- exact likely surfaces without editing;
- separate schema/migration consequences;
- rollback/reversibility;
- corrections required in J/F;
- smallest implementation-ready candidate.

## 8. Activation boundary

No candidate is accepted merely because it appears here.

Codex remains inactive.


---

<!-- CODEX_ACTIVATION_MARKER:C08-ACT-01-Design-2026-07-13 -->
# Cycle 08 — Codex Activation C08-ACT-01

> Status: ACTIVE — AUTHORIZED FOR CODEX IMPLEMENTATION
> Authority: explicit Main/human authorization on 2026-07-13
> Scope: bounded Unit 1 only — responsive shell and typed presentation states
> Supersedes: earlier “Codex remains inactive” and “not authorized” statements only for the scope defined below

## Authorized design boundary

Codex may implement:

1. one shared semantic destination model for the destinations already present in the application;
2. constraint-driven narrow/wide navigation presentation using existing Flutter SDK facilities;
3. preservation of selected destination across layout changes;
4. typed presentation-state handling for loading, empty, error and success on touched current surfaces;
5. focused unit/widget tests and the minimum composition changes required by this unit.

The existing destination set is preserved in this unit. Adding Catalogue or Stores as new top-level destinations requires a later Main decision and activation.

## Architecture constraints

Preserve the current inward dependency direction:

`presentation → application/domain ← infrastructure`

Do not introduce a router/state-management/UI package. Do not move database behavior into widgets. Do not combine this unit with draft coordination, Product resolution, Store reference, SubmissionId, History detail/analytics, backup/recovery or Device hardening.

## Exit and handoff

Codex must keep the change reversible and bounded, report exact files and tests, and write the corresponding G/H/I implementation evidence. Any need for schema, dependency or excluded architectural work returns to Main for a new D/E/F activation.

This latest activation marker controls Codex authority for F.
