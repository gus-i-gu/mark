# 07_GLOSSARY.md

> Domain: Didactic
> Status: Persistent derivative — Cycle 09 Sprint 02
> Authority source: `didactics/02_KANBAN.md`
> Purpose: Compact terminology retrieval; no independent truth or maturity change

## Evidence and execution

### Evidence state and validation boundary

**KANBAN ID:** `&&&05`
The strongest claim supported within a named environment and scope. Source presence, unit/widget tests, platform builds, manual workflows, accessibility checks and learner evidence are different levels.

### Project evidence is not learner maturity

**KANBAN ID:** `&&&05`
Implementation and tests may stabilize project vocabulary and relationships. Green/Yellow/Red maturity requires direct learner explanation, application or transfer evidence.

### Local queue is not synchronization

**KANBAN IDs:** `&%%11`–`&%%14`, `&&&09`
A local event and pending row prepare later delivery; they do not prove API exchange, acknowledgement, cursor replay or convergence.

## Identity and catalogue

### Stable identity

**KANBAN ID:** `&&&06`
A durable identifier for one logical subject independent of mutable labels. Markei UUIDs are opaque relational identities.

### Product code

**KANBAN IDs:** `&&&03`, `&&&06`, `&%%08`
A mandatory, user-established, immutable visible code for a new Product. It is not the Product UUID, local organizational reference code, nickname or exact identifying-field set.

### Local organizational reference code

**KANBAN IDs:** `&&&03`, `&&&06`
A generated visible Account-local sequence such as `@001` for Person or `#001` for Payment Method. It aids recognition and is not the database primary/foreign-key identity.

### Nickname

**KANBAN IDs:** `&&&03`, `&&&06`
The human-readable label paired with a Person or Payment Method reference. It may be shown as `@001 · Nickname`; `Archived` preserves historical meaning.

### Reusable Catalogue

**KANBAN ID:** `&%%07`
The Account-private set of recurring Products referenced by Purchases. Catalogue Products are reusable subjects, not Purchase Items.

### Product identification set and normalization

**KANBAN ID:** `&%%08`
Exact normalized identity facts resolve one Product: PACKAGED uses name, Brand, package quantity and unit; BULK uses name and Brand. Similarity is advisory and never auto-merges.

### Exact Product-code lookup

**KANBAN IDs:** `&%%07`, `&%%08`
An exact code match selects one existing Product and autofills immutable Product facts. It does not automatically add a staged Purchase Item.

### Product selection, details and Item addition

**KANBAN IDs:** `&&&03`, `&%%07`, `&%%10`
Selection identifies the current Product; Product details presents its facts; adding a staged Item records transaction values. These are separate actions.

## Purchase and history

### Purchase aggregate

**KANBAN ID:** `&%%09`
The consistency boundary that owns one Purchase, its Items and required persistence effects.

### Purchase occurrence time

**KANBAN IDs:** `&&&03`, `&&&10`, `&%%09`
The local civil date/time when buying happened, displayed as `dd/mm/yyyy · HH:mm`. It is distinct from database insertion/creation time and does not by itself decide storage-timezone architecture.

### Purchase Item

**KANBAN ID:** `&%%10`
A Product-specific commercial observation inside one Purchase. It owns transaction quantities, rates and totals while retaining the Product reference.

### PACKAGED Product and Item facts

**KANBAN IDs:** `&%%08`, `&%%10`, `&%%15`
Package quantity/unit belongs to Product identity; packages bought and amount bought belong to the Purchase Item.

### BULK rate and calculated line total

**KANBAN IDs:** `&%%10`, `&%%15`, `&%%16`
The Item records amount bought and a rate in the same selected unit; fixed-point calculation derives a read-only line total rounded half-up to currency minor units.

### Historical integrity

**KANBAN ID:** `&&&10`
Registered Purchase facts keep their original Product and optional reference identities. Archiving or relabelling does not make older History unassigned or editable.

### History selection and details

**KANBAN IDs:** `&&&03`, `%%%07`
Checkbox/multi-selection chooses Purchases for actions. Opening/focusing details is separate; current History double-click opens/focuses detail rather than toggling selection.

### Deterministic export and native share

**KANBAN IDs:** `&&&05`, `&%%09`
Selected Purchase DTOs can produce deterministic CSV/PDF bytes or a saved file. Native OS share completion is a separate, currently unimplemented boundary.

## Lists and presentation

### Lists projection

**KANBAN IDs:** `&&&02`, `&%%17`
A rebuildable view derived from registered Catalogue/Purchase history. Storage, Shortage/Ending soon and Market/Expected ended are personal estimates, not manually maintained or measured inventory.

### No Purchase history

**KANBAN IDs:** `&&&02`, `&%%17`
No compatible registered observation exists for the Product, so no cycle can begin.

### Not enough history

**KANBAN IDs:** `&&&02`, `&%%17`
Exactly one compatible observation exists; the Product has history but not enough intervals to estimate a personal cycle.

### Functional UI scaffold

**KANBAN ID:** `%%%07`
Current navigation and page controls support bounded workflows. Theme/component presence does not prove that pages use the system or match target images.

### Responsive and accessible equivalence

**KANBAN IDs:** `%%%07`, `&&&05`
Desktop and compact layouts should preserve meaning and reachable actions. Current keyboard, screen-reader and full accessibility equivalence remain unvalidated.

### Error and recovery contract

**KANBAN IDs:** `&&&03`, `&&&05`, `&%%03`
A user-facing failure identifies the operation/field, explains the known reason, preserves safe input, and offers a next action without raw database exceptions. Unknown outcomes require History verification before retry.

## Current evidence boundary

- Implemented/tested within reported scope: schema-v4 visible references, mandatory Product code, occurrence parsing, exact code autofill, same-unit BULK calculation, Lists unavailable-state distinction, selected CSV/PDF generation.
- Partial/open: target visual composition, page consumption of shared components, History double-click semantics, native share and full relational Lists presentation.
- Unvalidated: keyboard, screen-reader and complete manual accessibility equivalence.
- Maturity: unchanged; consult `02_KANBAN.md` for canonical status and `08_CONCEPT_MAP.md` for current recovery.
