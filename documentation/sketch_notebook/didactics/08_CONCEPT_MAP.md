# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Cycle 07 Sprint 02 Flutter canonical checkpoint
> Authority: Didactic Chat [A]
> Canon source: `02_KANBAN.md`
> Derivative source: `07_GLOSSARY.md`
> Evidence sources: `[M]_STAGE/J_[M]_STAGE.md` sections 17–18, `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`, and `13_LECTURE_REGISTER.md`
> Current milestone: Flutter/Dart shared-client model and synchronized-beta concept preparation

---

## Current Learning State

Flutter/Dart is the accepted planning basis for one maintained Windows, Android, and iOS client. TypeScript remains favored for the custom synchronization API, Neon for managed shared persistence, and Python/PySide6 as the protected beta reference and rollback.

The reusable catalogue, Purchase aggregate, dimensional quantity/money, append-only synchronization, and versioned analytics models are defined for planning. No Flutter code, API, schema, provider, infrastructure, or D/E/F materialization has been authorized or validated.

Concept introduction during model design is authorized because the concepts have reusable meaning and concrete Markei manifestations. Introduction is not learner mastery.

## Maturity

### Green

None.

### Yellow

`&&&01`, `&&&02`, `&&&03`, `&&%01`, `&&%02`, `&%%01`, `&%%02`, `&%%03`, `&%%04`, `%%%01`, `%%%03`, `%%%04`, `%%%05`.

### Red — existing

`&&&04`, `&&&05`, `&&%03`, `&&%04`, `&%%05`, `&%%06`, `%%%02`, `%%%06`.

### Red — introduced in Cycle 07 Sprint 02

```text
&&&06 Stable Identity
&&&07 Authentication
&&&08 Authorization
&&&09 Eventual Consistency
&&&10 Historical Integrity
&&%05 Immutable Dart Model
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
%%%07 Flutter Framework and Responsive Widget Composition
```

No pre-existing maturity changed. All introduced concepts begin Red because no explicit learner validation exists.

## Dependency Spine

Identity and access:

```text
&&&01 Responsibility Boundary
→ &&&06 Stable Identity
→ &&&07 Authentication
→ &&&08 Authorization
```

Catalogue and purchase:

```text
&&%05 Immutable Dart Model
→ &%%07 Reusable Catalogue
→ &%%08 Product Identification Set and Deterministic Normalization
→ &%%09 Purchase Aggregate
→ &%%10 Purchase Item
→ &%%05 Statement Atomicity Versus Workflow Atomicity
→ &&&10 Historical Integrity
```

Synchronization:

```text
&%%09 Purchase Aggregate
→ &%%11 Append-Only Synchronization Event
→ &%%12 Offline Queue and Idempotent Delivery
→ &%%13 Device Ordering and Synchronization Cursor
→ &%%14 Sync Protocol
→ &&&09 Eventual Consistency
```

Types and analytics:

```text
&&&03 Naming as Data Contract
→ &%%15 Dimensional Quantity
→ &%%16 Monetary Minor Unit
→ &&&02 Raw Data Versus Derived Data
→ &%%17 Versioned Analytic
```

Presentation support:

```text
&&%05 Immutable Dart Model
→ %%%07 Flutter Framework and Responsive Widget Composition
→ &%%03 Presentation Adapter
→ &&&04 Resource Ownership and Lifetime
```

## Reconciled Ownership

- Authoritative facts and derived projections extend `&&&02`.
- Purchase atomicity extends `&%%05`.
- Row ownership is an `&&&08 Authorization` example.
- Composition root and lifecycle remain related to `&&&01`, `&&&04`, and `&&%03`.
- Protocol versioning belongs to `&%%14`.
- Storage-schema versioning remains related to `%%%01`.
- `&%%11` append-only event semantics are distinct from `&&%05` Dart immutability.
- Dart is the language; Flutter is the framework.

## Current Project Learning Spine

```text
protected PySide6 beta
→ language-neutral contracts and fixtures
→ immutable Dart models
→ Flutter shared-client composition
→ account-private reusable catalogue
→ atomic Purchase with Purchase Items
→ application-private local persistence
→ append-only pending event
→ authenticated/authorized custom API
→ idempotent event acceptance
→ account cursor download
→ local deterministic projection rebuild
→ versioned analytics
→ parity and migration evidence
```

## Next Learner Questions

1. How do Dart language responsibilities differ from Flutter framework responsibilities?
2. Which state belongs in immutable models, local persistence, use cases, and widgets?
3. Why is email not a stable ownership identity?
4. How does authorization differ from successful authentication?
5. Which exact facts identify PACKAGED and BULK Products?
6. Why can normalization merge 350 g with 0.350 kg while fuzzy similarity cannot?
7. Which invariants belong to the Purchase aggregate?
8. Why must Purchase, Items, and pending event commit atomically?
9. How do event UUID, device sequence, occurrence time, and cursor differ?
10. How does idempotent delivery protect a retry?
11. Why can clients differ temporarily under eventual consistency?
12. How do dimensional quantity and minor-unit money prevent ambiguous facts?
13. Which facts are authoritative and which projections are rebuildable?
14. Why does analytic version 2 not rewrite version 1 or raw purchases?
15. How can Dart and TypeScript share behavior without sharing source?
16. What evidence would justify maturity movement for any new concept?

## Immediate Learning Boundary

The next Didactic evaluation requires explicit learner explanations or implementation-linked evidence. Architecture discussion and canonical introduction do not change maturity. D/E/F remain postponed.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above preserves the earlier milestone. The compact segment below is the current Didactic recovery checkpoint.

# Cycle 07 Sprint 05 Didactic Checkpoint

> Branch: `cycle-07-mobile-preparation`  
> Inspected implementation head: `ca53097b346ae42b216188dabc56a6eef45b051c`  
> Evidence: `DEV_STAGE/H_DDC_CODEX.md`  
> Main reconciliation: J §24

## Current Truth

Sprint 05 established an Android debug-development vertical slice. The Android toolchain is installed and recognized; an API 36 emulator booted; the debug APK was built, installed, and launched; the package is `com.gusigu.markei` with label `Markei`; a human confirmed Purchase registration; app-private Drift data showed a Purchase and an installation-local UUID v4 Device with sequence advanced to 2. Flutter tests total 27, Windows build passed, and five Python regressions passed.

The production composition now loads or creates a database-owned Device UUID instead of injecting `windows-device`. Tests cover fresh UUID creation, same-database reuse, different fresh-database identities, sequence continuation after reopen, historical non-UUID preservation, and a phone-width Purchase/History workflow.

## Maturity

No KANBAN maturity changed. All Cycle 07 Sprint 02 concepts remain `Red`; earlier statuses remain unchanged. The human observed application execution, but supplied no explicit concept explanation, comparison, or transfer evidence. Codex implementation, tests, and host success are not learner mastery.

## Evidence Classification

### Implemented and validated within the current boundary

- Android application ID/label coherence and debug APK identity.
- persistent local Device UUID creation/reuse and per-Device sequence continuation.
- shared Flutter Purchase registration and History projection.
- app-private local database use on the emulator.
- phone-width widget workflow, Flutter analysis/tests, Windows build, and Python regression path.

### Human-observed

- emulator application launch and Purchase registration.
- runtime database facts consistent with one persisted Purchase and advanced Device sequence.

### Provisional or partially validated

- full Android lifecycle: keyboard, Back, rotation, background/resume, text scale, staged-state behavior, and complete process-recreation checklist.
- responsive behavior beyond the controlled phone-width widget case.
- UI/UX and accessibility quality; current UI is a functional scaffold.
- Device selection algorithm: prototype lookup scans the first 20 created rows and lacks an explicit current-installation relation.
- Account identity remains the `local-account` prototype placeholder.

### Host-unvalidated, blocked, or deferred

- physical Android-device compatibility and wider device matrix: host-unvalidated/deferred.
- production signing/release, Play Store lifecycle, and Android upgrade distribution: deferred.
- authentication, authorization, API/server synchronization, cursor replay, and eventual consistency: deferred/unimplemented.
- central catalogue, iOS runtime, and PySide6 retirement: deferred.

## Distinctions to Preserve

- Flutter SDK ≠ Android SDK ≠ Android Studio ≠ emulator.
- APK built ≠ installed ≠ launched ≠ interacted ≠ lifecycle-validated ≠ persistence-validated.
- application ID ≠ display label ≠ Account ID ≠ Device UUID.
- Device UUID ≠ Product IDs ≠ Purchase UUID ≠ Event UUID; Device sequence is ordering, not identity.
- phone-width widget evidence ≠ real Android responsive/lifecycle evidence.
- Purchase registration creates a new immutable Purchase; unsupported upsert semantics must not be inferred.
- local event queue ≠ synchronization.
- functional UI scaffold ≠ accepted visual design.
- emulator evidence ≠ physical-device compatibility.
- project evidence ≠ learner maturity.

## Dependency and Learning Spine

```text
platform/toolchain vocabulary
→ evidence ladder
→ application/package identity
→ installation-local Device identity
→ per-Device ordering
→ immutable Purchase registration
→ local event/queue preparation
→ app-private persistence
→ responsive and lifecycle distinctions
→ cross-platform regression classification
→ explicit learner explanation before maturity change
```

## Next Learner Questions

1. What does each evidence-ladder step prove, and what does it not prove?
2. Why must application ID, Account ID, Device UUID, Event UUID, and Device sequence remain distinct?
3. Why is registration not Purchase upsert?
4. Which state should survive rebuild, rotation, backgrounding, process restart, data clear, and uninstall?
5. Why can a phone-width widget pass while real keyboard or Back behavior remains unvalidated?
6. What evidence would justify calling the UI responsive rather than a functional scaffold?
7. Why does one emulator not prove physical-device compatibility?
8. What learner explanation would justify moving one Red concept?

## Recovery Pointers

- Canonical concepts/evidence limits: `02_KANBAN.md`, Sprint 05 Android evidence reconciliation.
- Derived terminology: `07_GLOSSARY.md`, Sprint 05 current-evidence retrieval.
- Observational chronology: `13_LECTURE_REGISTER.md`, Observation 008.
- Codex evidence: `DEV_STAGE/H_DDC_CODEX.md`.
- Pre-materialization learning gates: `DEV_STAGE/B_DIDACTIC.md` and `DEV_STAGE/E_DDC_STAGE.md`.
- Main classification and unresolved debt: `[M]_STAGE/J_[M]_STAGE.md`, §24.

## Next Valid Route and Authority

PDR2-A may publish these four permanent Didactic files. Main must then reconcile domain results and decide whether Sprint 05 closes or needs a bounded lifecycle supplement. Additional source work, 00/05/06 updates, and future D/E/F remain inactive until Main/human authorization. A later UI/UX sprint is only a candidate.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


# Intermid Cycle Recovery Didactic Checkpoint

> Branch: `intermid-cycle-recovery`  
> Inspected implementation head: `84fc6e4e49dedc7ce629a97a78dd86486dbf0cf8`  
> Materialization commit: `409e5f1e013a282165efd5f31bed17a396ad6543`  
> Evidence: `DEV_STAGE/H_DDC_CODEX.md`  
> Main reconciliation: `[M]_STAGE/J_MAIN_STAGE.md` §§20–25

## Current Truth

The Flutter client implements Products, a session Purchase draft, registered Purchase Items, and History. The Intermid Recovery correction now preserves the staged line's original `ProductReference` and Product label while allowing package count, purchased quantity, unit, and line total to change.

The focused existing-Product regression registers the edited Item, retains the original Product ID, confirms changed Item values, and confirms that no duplicate Product row is created. At materialization time the focused app suite passed 7 tests, the full Flutter suite passed 32 tests, and Flutter analysis reported no issues.

## Canonical Ownership

The distinction reinforces existing concepts and creates no duplicate concept:

- `&&&06 Stable Identity`: Product reference identity survives mutable presentation activity.
- `&%%07 Reusable Catalogue`: a staged Item refers to an existing reusable Product.
- `&%%10 Purchase Item`: quantity and monetary facts belong to the transaction Item.
- `&&&05 Evidence State and Validation Boundary`: direct regression evidence and source-structure inference remain distinct.

## Maturity

No KANBAN maturity changed. Project implementation, passing tests, and the corrected regression do not demonstrate that the learner can explain, compare, predict, debug, or transfer the concepts.

## Evidence Classification

### Implemented and validated within the named local boundary

- edit state retains `_editingReference` and `_editingProductLabel`;
- saving rebuilds editable Item values using the retained Product reference;
- “Create anyway” is unavailable while editing;
- the existing-Product widget regression preserves Product ID and Product row count;
- focused/full Flutter tests and analysis passed as recorded in H.

### Implemented by shared source structure, not separately regression-tested

- `NewProductReference` passes through the same retained base-`ProductReference` edit path.

### Host-unvalidated or outside scope

- file-backed restart and migration behavior;
- Windows manual runtime acceptance;
- Android/iOS build, runtime, lifecycle, and physical-device evidence;
- accessibility and release acceptance.

### Deferred

- Store normalization and branch identity;
- durable SubmissionId/idempotency;
- persisted drafts;
- schema v3 and migration strategy;
- authentication, API, Neon, upload/download, and synchronization.

## Distinctions to Preserve

- Product reference identity ≠ Product label ≠ draft-line key.
- Product identity ≠ editable Purchase Item quantity or price.
- editing a staged Item ≠ creating or replacing a Product.
- direct existing-Product regression ≠ separately tested new-Product edit behavior.
- local queue preparation ≠ synchronization.
- passing project regression ≠ learner maturity.

## Next Learner Evidence Needed

1. Explain in the learner's own words why Product identity remains stable while Item values change.
2. Identify which fields belong to ProductReference, staged-line presentation state, and PurchaseItemDraft.
3. Predict how relying on the current dropdown selection could create or reference the wrong Product.
4. Apply the distinction to both existing- and new-Product reference variants.
5. Distinguish a passing widget regression from platform, persistence, and lifecycle acceptance.

## Recovery Pointers

- Canonical concepts and maturity: `02_KANBAN.md`, Intermid Recovery ProductReference evidence reconciliation.
- Derived terminology: `07_GLOSSARY.md`, Intermid Recovery current-evidence retrieval.
- Observational history: `13_LECTURE_REGISTER.md`, Observation 009.
- Codex evidence: `DEV_STAGE/H_DDC_CODEX.md`.
- Controlling semantics: `DEV_STAGE/E_DDC_STAGE.md`.
- Functional assessment: `DEV_STAGE/B_DIDACTIC.md`.
- Main classification: `[M]_STAGE/J_MAIN_STAGE.md` §§20–25.

## Next Valid Route and Authority

Didactic permanent reconciliation is complete for this bounded claim. Main may reconcile the refreshed domain checkpoints into Main-root continuity. Further source work, maturity promotion, and next-cycle D/E/F require separate authority.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
