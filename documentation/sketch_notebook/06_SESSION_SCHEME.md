# 06_SESSION_SCHEME.md

> Version: Cycle 07 Sprint 02 forward checkpoint 0.2
> Status: Active Forward Checkpoint
> Persistence Class: Forward Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Working branch: `cycle-07-mobile-preparation`
> Baseline commit: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Current-state source: `00_PROJECT_STATE.md`
> Historical source: `05_SESSION_LOG.md`
> Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md`
> Cycle target: evidence a primary mobile-development approach without destabilizing the accepted Windows desktop beta

---

# 1. Current Entry State

Cycle 07 Sprint 01 is complete.

Completed:

```text
isolated clone and branch verified
→ portable/coupled/desktop-specific inventory completed
→ four approach families compared
→ persistence and synchronization assumptions separated
→ A/B/C reconciled in J
→ permanent domain memory refreshed
→ Main-root current state and history refreshed
```

Not completed:

```text
language-neutral behavior specification
deterministic fixture set
framework selection
mobile toolchain validation
minimal vertical-slice prototype
G/H/I evidence
Cycle 07 acceptance
```

No implementation is authorized. D/E/F remain postponed.

---

# 2. Current Strategic Direction

```text
Primary strategic direction:
    Approach C — native/cross-platform mobile client
    with explicit language-neutral contracts and deterministic fixtures

Bounded challenger:
    Approach A — time-boxed Python-native Android experiment
    testing direct reuse

Secondary:
    Approach B — web/hybrid mobile client

Deferred:
    Approach D — service-backed client
```

The human/Main direction favors Approach C. This is provisional planning direction, not framework acceptance or empirical validation.

The Operational and Design pathways remain preserved because they answer different cost questions:

```text
Approach A:
    potentially cheaper first experiment
    uncertain packaging, lifecycle, native integration, accessibility,
    iOS support, and long-term maintenance

Approach C:
    higher initial specification and reimplementation cost
    intended to reduce semantic drift and improve conventional
    mobile lifecycle, tooling, testing, UX, and maintenance ownership
```

---

# 3. Sprint 02 Knowledge Milestone

The next bounded milestone is:

> Specify the technology-neutral behavior, fixtures, invariants, and validation gates required to compare or prototype a mobile client without selecting a framework prematurely.

Sprint 02 knowledge work should answer:

1. Which Markei behaviors must remain identical across desktop and mobile?
2. Which inputs and outputs are stable facts rather than presentation formatting?
3. Which deterministic scenarios provide semantic-parity evidence?
4. What persistence effects and transaction boundary does registration require?
5. What mobile-local path invariant prevents desktop-data contact?
6. What lifecycle events must preserve state?
7. What evidence would justify Approach C framework selection?
8. What exact question, time box, pass gates, and stop conditions would bound Approach A?
9. Which questions require execution rather than more documentation?

---

# 4. Proposed Behavior Scenarios

At minimum specify:

```text
first purchase for a new product
repeat purchase and duration recalculation
Storage / Shortage / Market transition
invalid receipt rejection
structural category/store defaults
one atomic registration workflow
close/reopen persistence
mobile-local path isolation
```

Each scenario should define:

- typed input facts;
- deterministic expected facts/status codes;
- validation failure;
- date and quantity semantics;
- persistence effects;
- transaction expectation;
- lifecycle expectation;
- platform-independent invariant;
- presentation-owned labels or formatting excluded from the contract.

Current Python abstract classes and UI dictionaries are sources of evidence, not automatic language-neutral contracts.

---

# 5. Domain Responsibilities

## Operational [O]

Prepare evidence and execution boundaries:

- candidate toolchain inventory questions;
- Android versus macOS/iOS gates;
- validation matrix;
- path/data-isolation checks;
- lifecycle failure taxonomy;
- stop conditions for Approach A;
- unknowns requiring empirical execution.

## Didactic [A]

Prepare learner-facing knowledge:

- platform boundary;
- composition root and dependency injection;
- behavioral contract and golden fixture;
- semantic parity;
- local persistence and offline-first;
- transaction boundary;
- lifecycle ownership;
- synchronization as a deferred dependent concept.

No maturity changes without explicit learner evidence.

## Design [D]

Prepare technology-neutral structure:

- command/result boundary;
- fixture ownership;
- mobile composition and lifecycle owner;
- local transaction boundary;
- schema reuse versus semantic equivalence;
- framework comparison criteria;
- repository topology kept provisional;
- conditions for accepting/rejecting the Approach A challenger.

## Main [M]

Reconcile the domain work, preserve evidence-state distinctions, and decide whether:

```text
documentation is sufficient
or
one empirical experiment must be authorized
```

---

# 6. Staging Route

Until implementation is authorized:

```text
A/B/C documentation deltas
→ J reconciliation
→ permanent-domain classification when needed
→ 00/05/06 refresh when global state changes
```

D/E/F must remain inactive.

If a prototype is later authorized:

```text
human/Main selects one bounded uncertainty
→ Main prepares D/E/F
→ Codex materializes
→ G/H/I report evidence
→ functional domains reconcile
→ Main updates global state
```

Existing earlier-cycle D/E/F content is not Cycle 07 authority.

---

# 7. Default Persistence Boundary

```text
offline-first
single-device
fresh mobile-local sandbox database
no ordinary desktop database access
no backend
no authentication
no synchronization
```

A backend may be reconsidered only if accounts, multi-device state, household collaboration, or synchronization become demonstrated requirements.

---

# 8. Scope Guard

Sprint 02 documentation work does not authorize:

- application or source-code modification;
- framework initialization;
- tool installation;
- Android/iOS build execution;
- database migration or desktop-data access;
- backend, authentication, hosting, or synchronization;
- permanent repository split;
- app-store publication;
- broad schema redesign;
- new Sketch Notebook files;
- methodology modification;
- D/E/F or G/H/I activity.

---

# 9. Cycle 07 Exit Criteria

Cycle 07 remains open until:

```text
baseline and isolation remain protected
portable/coupled inventory remains reconciled
approach comparison remains explicit
behavior contracts and fixtures are defined
primary candidate is selected for empirical prototyping
minimal vertical slice runs in a mobile-relevant environment
mobile-local persistence survives termination/relaunch
ordinary desktop data remains untouched
G/H/I evidence is reconciled
Main accepts the primary approach or records a precise blocker
```

A preference, paper architecture, static mockup, empty mobile project, or dependency installation is insufficient.

---

# 10. Recovery Route

```text
1. AGENTS.md
2. INDEX.md and methodology boot
3. 00_PROJECT_STATE.md
4. this forward checkpoint
5. relevant domain checkpoint
6. J_[M]_STAGE.md when cross-domain rationale is needed
7. A/B/C or observational history only when exact evidence is required
8. source inspection only when notebook memory is insufficient
```

Recovery warnings:

```text
strategic preference ≠ framework acceptance
shared language ≠ shared runtime
platform-neutral code ≠ portable application
contract reuse ≠ source reuse
local persistence ≠ synchronization
prototype success ≠ production architecture
low initial code cost ≠ low total development cost
```
