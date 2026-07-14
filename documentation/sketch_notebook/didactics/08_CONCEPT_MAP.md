# 08_CONCEPT_MAP.md

> Status: Cycle 09 Sprint 02 Didactic checkpoint
> Branch: `intermid-cycle-recovery`
> Inspected implementation: `1d817972aea0229c9f109f236f4d224671927aab`
> Promotion baseline: `4bf2e52d9d3e23437c4da1d8bb05e2402e189dd5`
> Canonical owner: `02_KANBAN.md`
> Derived retrieval: `07_GLOSSARY.md`

## Current milestone

Cycle 09 Sprint 02 stabilized a functional UX vocabulary around local identity, Product resolution, Purchase occurrence, BULK calculation and Lists availability. It did not complete the target visual reconstruction or provide learner-maturity evidence.

## Maturity

No KANBAN status changed.

- Green/Yellow/Red remain exactly as recorded in `02_KANBAN.md`.
- Source, tests, builds and human application observation are project evidence.
- Maturity requires direct learner explanation, comparison, debugging, prediction or transfer.

## Stable project vocabulary

```text
Product UUID
!= mandatory immutable Product code
!= exact Product identifying-field set
!= advisory similarity

Person/Payment Method UUID
!= @001/#001 visible local reference code
!= nickname

select Product
!= open Product details
!= exact-code autofill
!= add staged Purchase Item

Purchase occurrence time
!= record insertion time

Catalogue/Purchase facts
!= Lists projections
!= measured or manually maintained inventory
```

## Canonical concept ownership

- `&&&02 Raw Data Versus Derived Data` — registered facts versus Lists estimates.
- `&&&03 Naming as Data Contract` — distinct identity, action, time and state labels.
- `&&&05 Evidence State and Validation Boundary` — implementation, visual, accessibility and learning evidence.
- `&&&06 Stable Identity` — opaque UUIDs, immutable Product codes and visible organizational references.
- `&&&10 Historical Integrity` — occurrence, Product/reference identity and immutable registered history.
- `&%%03 Presentation Adapter` — clear failures, retained input and recovery action.
- `&%%07 Reusable Catalogue` — existing Product selection and reuse.
- `&%%08 Product Identification Set and Deterministic Normalization` — exact code/details versus similarity.
- `&%%09 Purchase Aggregate` — occurrence and aggregate registration boundary.
- `&%%10 Purchase Item` — staged/registered transaction quantities, rates and totals.
- `&%%15 Dimensional Quantity` — PACKAGED/BULK amount and same-unit rate compatibility.
- `&%%16 Monetary Minor Unit` — half-up derived line total.
- `&%%17 Versioned Analytic` — history-derived Lists and unavailable states.
- `%%%07 Flutter Framework and Responsive Widget Composition` — adaptive navigation and incomplete visual/accessibility equivalence.

No new concept was required.

## Implemented within reported automated evidence

- schema v4 keeps opaque relational IDs separate from visible `@001` / `#001` references and nicknames;
- Product code is mandatory for new Products, user-established and immutable;
- exact Product-code lookup autofills immutable Product facts without staging an Item;
- Product selection, Product details and adding a staged Item remain separate;
- Purchase date/time represents the buying occurrence and is parsed separately from insertion time;
- BULK amount and same-unit rate produce a read-only half-up line total;
- optional Person and Payment Method absence does not block Purchase registration;
- Lists distinguishes `No Purchase history` from `Not enough history`;
- errors preserve the Purchase draft and provide bounded recovery language;
- selected Purchase data produces deterministic CSV/PDF output.

Reported evidence includes Flutter analysis, 43 Flutter tests, schema-v4 migration tests and a Windows build. Consult H/J and implementation tests for exact boundaries.

## Partial, open or unvalidated

- Target images 01–05 remain directional; the complete visual language is not materialized.
- Theme/component files exist, but page consumption and visual convergence are not established.
- Current sparse page composition is a scaffold, not the intended final Markei model.
- History double-click opens/focuses details instead of toggling multi-selection.
- Native OS sharing is unimplemented; deterministic PDF/save-manually behavior remains.
- Complete relational Lists presentation, filters, summary cards/tables and compact parity remain open.
- Keyboard traversal, focus equivalence, screen-reader behavior and full manual accessibility remain unvalidated.
- Windows build/smoke is not visual acceptance; Android remains host-blocked in the reported environment.

## Dependency spine

```text
&&&03 Naming as Data Contract
↓
&&&06 Stable Identity
↓
&%%07 Reusable Catalogue
↓
&%%08 Product Identification and Normalization
↓
&%%09 Purchase Aggregate
↓
&%%10 Purchase Item
├─ &%%15 Dimensional Quantity
└─ &%%16 Monetary Minor Unit

&&&02 Raw versus Derived Data
↓
&%%17 Versioned Analytic

&&&05 Evidence Boundary
↓
%%%07 Responsive Widget Composition
```

## Next learner evidence

1. Explain Product UUID, Product code and exact identity without merging them.
2. Explain why `@001`/`#001` are stable visible references but not foreign keys.
3. Predict what exact-code autofill changes and why it does not add an Item.
4. Allocate PACKAGED and BULK facts to Product versus Purchase Item.
5. Calculate a BULK total and explain same-unit compatibility and currency rounding.
6. Distinguish occurrence time from insertion time and name the historical consequence.
7. Explain `No Purchase history` versus `Not enough history`.
8. Distinguish generated PDF evidence from native OS sharing.
9. Explain why tests/theme presence do not prove visual or accessibility acceptance.

## Recovery pointers

1. `02_KANBAN.md` — canonical concepts and unchanged maturity.
2. `07_GLOSSARY.md` — current terminology and distinctions.
3. `DEV_STAGE/H_DDC_CODEX.md` — materialization evidence.
4. `[M]_STAGE/J_MAIN_STAGE.md` — accepted, partial and open classifications.
5. relevant Flutter source/tests — implementation truth when a claim remains uncertain.
6. `13_LECTURE_REGISTER.md` — historical teaching/learning observations only; no Sprint 02 promotion entry was added.

## Next valid route

Main may reconcile this Didactic promotion with the independent Operational and Design commits. Further source work requires a new authorized implementation unit. Any KANBAN maturity change requires direct learner evidence.
