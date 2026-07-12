# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Cycle 07 Sprint 01 portability checkpoint
> Authority: Didactic Chat [A]
> Canon source: `02_KANBAN.md`
> Derivative source: `07_GLOSSARY.md`
> Evidence sources: `[M]_STAGE/J_[M]_STAGE.md`, `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`, and `13_LECTURE_REGISTER.md`
> Current milestone: Reconcile mobile-portability knowledge before any prototype materialization

---

## Current Learning State

Cycle 06 is accepted and closed. Cycle 07 Sprint 01 investigated mobile portability without implementing or validating a prototype. The learner-facing result is a classified comparison between two cost pathways, not proof of a selected runtime or learner mastery.

Current project direction:

```text
primary preference: contract-first native/cross-platform client
bounded challenger: Python-native mobile runtime
default persistence: mobile-local and offline-first
backend/synchronization: deferred without demonstrated requirement
D/E/F materialization: postponed
```

The preference for the contract-first pathway is reasoned but provisional. It does not establish technical validation, permanent architecture acceptance, or conceptual understanding.

## Maturity

### Green

None. Software evidence and project preference do not establish learner mastery.

### Yellow

`&&&01`, `&&&02`, `&&&03`, `&&%01`, `&&%02`, `&%%01`, `&%%02`, `&%%03`, `&%%04`, `%%%01`, `%%%03`, `%%%04`, `%%%05`.

### Red

`&&&04`, `&&&05`, `&&%03`, `&&%04`, `&%%05`, `&%%06`, `%%%02`, `%%%06`.

No maturity changed during Cycle 07 Sprint 01 because no explicit learner responses or prototype evidence were recorded.

## Active Candidate Concepts

The following are classified candidates, not canonical KANBAN entries:

```text
Platform Boundary
Composition Root
Dependency Injection
Behavioral Contract
Golden Fixture
Semantic Parity
Local Persistence
Offline-First
Transaction Boundary
Application Lifecycle Ownership
Synchronization
```

Existing canon supplies partial prerequisites, but the candidates require prototype-grounded examples and a later promotion decision before receiving KANBAN identifiers.

## Dependency Spine

Existing canonical foundation:

```text
&&&01 Responsibility Boundary
→ &%%01 Application Service
→ &%%02 Repository Pattern and Persistence Adapter
→ &&&04 Resource Ownership and Lifetime
→ %%%02 SQLite Connection and Cursor Ownership
→ &%%05 Statement Atomicity Versus Workflow Atomicity
→ &&&05 Evidence State and Validation Boundary
```

Candidate progression:

```text
Platform Boundary
→ Composition Root
→ Dependency Injection
→ Application Lifecycle Ownership
→ Local Persistence
→ Transaction Boundary
→ Offline-First
```

Behavior-preservation progression:

```text
Behavioral Contract
→ Golden Fixture
→ Semantic Parity
```

Deferred network progression:

```text
Local Persistence
→ Offline-First
→ Synchronization
```

Synchronization remains last because it adds identities, transport, conflicts, failure recovery, security, and remote operations that the current single-device prototype does not require.

## Two Development-Cost Pathways

### Python-native pathway

```text
more direct Python source reuse
→ potentially less initial rewriting
→ unknown mobile runtime/toolkit feasibility
→ possible later cost in packaging, lifecycle, native integration,
  accessibility, platform support, distribution, and debugging
```

### Contract-first cross-platform pathway

```text
less direct runtime reuse
→ more initial implementation and learning
→ explicit contracts and fixtures
→ conventional mobile tooling and lifecycle ownership
→ intended reduction in semantic drift and long-term platform uncertainty
```

Development cost means all effort needed to create, understand, prove, ship, debug, and maintain the software. It includes learning, setup, cognitive complexity, duplicate implementation, tests, fragile tools, multi-platform maintenance, semantic-drift prevention, distribution, and future change—not merely money or lines of code.

Neither pathway is proven cheaper overall. Sprint 01 identifies where each may place cost. A later bounded experiment is required to compare actual setup, implementation, testing, lifecycle, and debugging effort.

## Active Distinctions

```text
shared language ≠ shared runtime
platform-neutral component ≠ portable application
business behavior ≠ UI implementation
source-code reuse ≠ contract reuse
Python abstract class ≠ language-neutral behavioral contract
local persistence ≠ synchronization
offline-first ≠ cloud-backed
service layer ≠ network server
project preference ≠ permanent architecture acceptance
technical investigation ≠ prototype validation
project decision ≠ learner maturity
less code today ≠ lower total development cost
duplicate implementation ≠ semantic drift when fixtures enforce parity
```

## Current Project Examples

- Python dataclasses are platform-neutral candidates, but direct reuse still requires a mobile Python runtime.
- `ProductService` contains reusable-looking rules but constructs the concrete repository.
- The database manager contains Windows/PyInstaller path assumptions.
- The desktop PySide6 presentation is platform-specific.
- The mobile entrypoint is empty and supplies no runtime evidence.
- The contract-first proposal uses explicit behavior examples and a mobile-owned sandboxed database.
- The Python-native proposal remains a bounded challenger whose packaging and lifecycle costs require device evidence.
- No ordinary desktop database may be accessed by a future mobile prototype.

## Next Learner Questions

1. What is the difference between sharing Python syntax, sharing Python source, and sharing a Python runtime?
2. Which Markei components are platform-neutral, and which make the whole application platform-bound?
3. What creates and connects repositories, use cases, and lifecycle owners in a composition root?
4. How does dependency injection allow a mobile-local repository to replace the desktop repository?
5. What must a behavioral contract state beyond a Python method signature?
6. How does a golden fixture detect semantic drift between two implementations?
7. What evidence demonstrates semantic parity without claiming identical source?
8. Who owns the local database, transaction, initialization, suspension, and relaunch lifecycle?
9. Why can an application be offline-first without supporting synchronization?
10. Which requirement would justify introducing synchronization or a backend?
11. How should setup, learning, testing, debugging, maintenance, and future change be included in a cost comparison?
12. What bounded prototype result would support or challenge the current contract-first preference?

## Immediate Learning Boundary

Before prototype materialization, the learner should be able to explain:

```text
where each pathway executes
what is reused as source versus preserved as behavior
who owns mobile-local state
why one use case needs a transaction boundary
why offline-first does not imply synchronization
which evidence would validate only the prototype claim
how initial cost differs from recurring maintenance cost
```

Canonical KANBAN creation remains deferred until prototype preparation supplies independent concept need and concrete project examples. The glossary remains unchanged because no canonical concepts were added. D/E/F and application implementation remain postponed.
