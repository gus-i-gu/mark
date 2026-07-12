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
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker preserves the prior milestone. This checkpoint below is the current compact recovery surface.

# Cycle 07 Sprint 04 Didactic Checkpoint

## Current Learning State

Cycle 07 Sprint 04 has a tested local Flutter Purchase vertical slice and Windows host evidence. It separates the account-private Product code, immutable local Product record UUID, and future central semantic UUID responsibility; uses normalization v2; validates readable v2 JSON examples against JSON Schema; migrates local schema v1 to v2; preserves atomic Purchase/event/queue writes; and proves local device sequences 1, 2, 3 across rollback boundaries.

This is project evidence, not learner mastery. Authentication, authorization, API synchronization, server cursors, cross-device convergence, and a central catalogue remain absent. Android is tooling-blocked, iOS host-unvalidated, and manual UI acceptance remains open.

## Maturity Guard

All Cycle 07 Sprint 02 concepts retain their existing `Red` status. Earlier Green, Yellow, and Red entries are unchanged. No maturity transition is inferred from implementation, tests, schemas, generated code, build success, or Main preference.

## Current Evidence Map

### Strong local implementation/test evidence

- `&&&06` Stable Identity — Product code and immutable local Product UUID have separate ownership.
- `&&&10` Historical Integrity — append-only facts and tested v1-to-v2 migration preserve history boundaries.
- `&&%05` Immutable Dart Model — value objects and domain facts remain immutable.
- `&%%07`–`&%%10` — catalogue, identification, Purchase aggregate, and Items drive the local workflow.
- `&%%11`–`&%%13` — local event, queue preparation, rollback, and monotonic device ordering are evidenced locally.
- `&%%15`–`&%%17` — dimensional quantities, minor-unit money, and versioned analytics remain executable concepts.
- `%%%07` — responsive widget composition and Windows execution have evidence.

### Stronger specification, still bounded

- `&%%08` — normalization v2 has Unicode fixtures, but TypeScript parity and central identity assignment are unproved.
- `&%%14` — JSON Schema plus readable examples provide structural contracts, not an implemented synchronization protocol.

### Still absent as distributed behavior

- `&&&07` Authentication.
- `&&&08` Authorization; row ownership remains an example only.
- `&&&09` Eventual Consistency.
- server idempotency, server cursor application, remote replay, and convergence portions of `&%%12`–`&%%14`.

## Dependency Spine

```text
immutable values and stable local identities
→ account-private Product code + local Product UUID
→ versioned semantic normalization
→ dimensional quantity + minor-unit money
→ Purchase aggregate and Items
→ one local transaction
→ append-only local event
→ pending offline queue
→ monotonic per-device sequence
→ schema migration and historical preservation
→ JSON Schema structural contract
→ Flutter composition and local history projection
→ Windows host validation
→ authentication/authorization — pending
→ API idempotency/server cursor — pending
→ cross-device eventual consistency — pending
```

## Distinctions to Preserve

- Visible Product code is not the immutable local Product UUID.
- A future central Product UUID is neither of those identities.
- Normalized semantic facts aid comparison; they do not authorize automatic merge.
- JSON Schema validates structure; domain tests own cross-field meaning.
- Local device sequence is not server cursor order.
- Atomic queue creation is not synchronization.
- Windows validation does not prove Android or iOS behavior.
- A history projection is derived from authoritative Purchase facts.
- Project implementation evidence is not learner maturity.

## Next Learner Questions

1. Why must user Product code, local record UUID, and future central UUID remain separate?
2. Which normalization facts are versioned, and what must migration preserve?
3. Which rules can JSON Schema express, and which remain domain invariants?
4. Why does rollback preserve both Purchase atomicity and device ordering?
5. What does a local pending event prove, and what distributed evidence is still missing?
6. How do device sequence and future server cursor solve different ordering problems?
7. Why is Windows build/launch evidence platform-specific?
8. What explicit learner evidence would justify changing one Red concept?

## Permanent-Memory Pointers

- Observation and chronology: `13_LECTURE_REGISTER.md`, Observation 007.
- Canonical concepts and evidence limits: `02_KANBAN.md`, Cycle 07 Sprint 04 evidence reconciliation.
- Derived retrieval terminology: `07_GLOSSARY.md`, Sprint 04 current-evidence retrieval.
- Staged synthesis: `DEV_STAGE/B_DIDACTIC.md`.
- Materialization evidence: `DEV_STAGE/H_DDC_CODEX.md`.
- Main authority and limits: `[M]_STAGE/J_[M]_STAGE.md`, §21.

## Next Learning Boundary

The next Didactic step is explanation and evidence classification, not automatic promotion. Distributed concepts should be revisited only when authentication, authorization, API idempotency, server cursors, replay, and convergence exist as bounded evidence. Platform claims must remain separated by Windows, Android, and iOS validation boundaries.
