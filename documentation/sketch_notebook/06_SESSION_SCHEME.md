# 06_SESSION_SCHEME.md

> Version: Cycle 07 forward checkpoint 0.1
> Status: Active Forward Checkpoint
> Persistence Class: Forward Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Baseline branch: `sketch-notebook-recovery`
> Current-state source: `00_PROJECT_STATE.md`
> Historical source: `05_SESSION_LOG.md`
> Domain checkpoints: `operational/10_OPERATIONAL_STATE.md`, `didactics/08_CONCEPT_MAP.md`, `design/09_DESIGN_STATE.md`
> Cycle target: prepare and evidence the primary mobile-development approach without destabilizing the accepted Windows desktop beta

---

# 1. Purpose

Cycle 07 is a preparation and architecture-discovery cycle for mobile development.

It does not begin with a full mobile rewrite.

It must answer:

```text
what can be reused
what is desktop-only
what mobile delivery models are viable
what persistence model is required
what synchronization assumptions are acceptable
what the smallest meaningful mobile vertical slice is
```

The cycle should be performed in an isolated cloned repository or equivalent worktree so that the accepted Windows desktop beta remains recoverable and runnable throughout the investigation.

---

# 2. Single Active Milestone

Cycle 07 has one active milestone:

> Select and evidence a primary mobile-development approach for Markei through an isolated clone, bounded architecture comparison, and one minimal vertical-slice prototype.

Cycle 07 is complete only when:

```text
desktop baseline remains protected
→ reusable core and desktop coupling are mapped
→ mobile approach candidates are compared
→ persistence/synchronization assumptions are explicit
→ one candidate produces a minimal runnable vertical slice
→ Operational, Didactic, and Design evidence is reconciled
→ Main accepts a primary approach or records a precise blocker
```

A technology preference, mockup, dependency installation, or empty mobile project is not sufficient.

---

# 3. Isolation and Clone Policy

## 3.1 Preserve the accepted desktop baseline

Before mobile work:

```text
1. ensure sketch-notebook-recovery is clean and recoverable;
2. retain the accepted Windows installer/build sources;
3. do not delete or relocate the desktop application;
4. do not mix generated mobile tooling into the desktop release boundary;
5. record the exact baseline commit used for the mobile clone.
```

## 3.2 Create an isolated working copy

Preferred local route:

```text
git clone <repository-url> markei-mobile-preparation
cd markei-mobile-preparation
git checkout sketch-notebook-recovery
git switch -c cycle-07-mobile-preparation
```

An isolated `git worktree` is also acceptable when it provides equivalent separation.

The mobile-preparation branch should begin from the accepted Cycle 06 closure commit. Do not recover from the default branch unless Main explicitly reclassifies it as authoritative.

## 3.3 Repository strategy is not pre-decided

Cycle 07 must determine whether long-term mobile work belongs in:

```text
A. the same repository with platform directories;
B. a dedicated mobile repository sharing contracts manually;
C. a monorepo with shared core packages;
D. a mobile client repository plus a future service boundary.
```

The initial clone is an investigation environment, not automatic acceptance of a permanent repository topology.

---

# 4. Mandatory Methodology Recovery

Every Cycle 07 chat and Codex session must begin with:

```text
AGENTS.md, when present
→ documentation/sketch_notebook/INDEX.md
→ METHOD_FOUNDATIONS.md
→ FLUX.md
→ PROMOTION_RULES.md
→ CHAT_PROTOCOL.md
```

Then recover:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
relevant domain checkpoint
```

Use the Hierarchical Recovery Principle and inspect implementation only when notebook memory is insufficient.

---

# 5. Inherited Desktop Baseline

Cycle 07 inherits an accepted controlled Windows beta with:

```text
PySide6 desktop UI
SQLite local persistence
ProductService workflow facade
Repository persistence facade
Database Manager lifecycle boundary
one-folder PyInstaller package
Inno Setup per-user installer
external %LOCALAPPDATA% user state
```

Accepted dependency direction:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

Cycle 07 must not assume that PySide6 widgets, Windows paths, Inno Setup, or desktop page composition are reusable on mobile.

It should test which lower layers are genuinely platform-neutral rather than merely written in Python.

---

# 6. Primary Investigation Approaches

Cycle 07 should compare approaches rather than selecting one from memory.

## Approach A — Shared Python core with a Python-native mobile UI

Investigate whether Markei can retain substantial Python application logic while replacing the PySide6 presentation layer with a mobile-capable Python UI/runtime.

Questions:

- Can domain models and ProductService operate without Qt imports?
- Can Repository and database path handling work in mobile sandbox storage?
- What packaging/runtime constraints appear on Android and iOS?
- How mature is the required widget, navigation, accessibility, and deployment tooling?
- Does this route preserve too much desktop-shaped application behavior?

## Approach B — Mobile client with a web/hybrid presentation layer

Investigate a mobile UI built with web technologies, packaged as a mobile application or delivered as an installable web experience.

Questions:

- Can business workflows be expressed behind stable contracts?
- Would the current Python core run locally, remotely, or be replaced?
- How would offline storage work?
- What capabilities require native bridges?
- Does this approach simplify UI development while introducing a service boundary too early?

## Approach C — Native or cross-platform mobile client with explicit shared contracts

Investigate a mobile client built in a native or cross-platform mobile framework while treating the current Python application as a source of behavior and contracts rather than directly reusable runtime code.

Questions:

- Which domain rules should be ported versus shared?
- Can contracts and fixtures prevent semantic drift?
- What local database technology and migration path would be used?
- What cost does a second implementation introduce?
- Does this provide the strongest long-term mobile UX and platform integration?

## Approach D — Service-backed mobile client

Investigate whether mobile requirements genuinely demand a backend for synchronization, multi-device state, authentication, or shared household data.

This approach must not be selected merely because mobile exists.

Questions:

- Is single-device offline-first usage sufficient for the next product milestone?
- Which facts must synchronize?
- What conflict model would be required?
- What privacy, account, hosting, and operational responsibilities appear?
- Can backend work be deferred while preserving a future boundary?

---

# 7. Required Architecture Inventory

Before prototyping, produce a compact portability map.

Classify current code as:

```text
platform-neutral and likely reusable
platform-neutral but coupled by construction/imports
Windows/desktop-specific
persistence-specific
presentation-specific
unknown until tested
```

At minimum inspect:

```text
app/models.py or current domain representations
app/core/services.py
app/core/repository.py
app/core/database.py
app/core/config.py
app/desktop/
main.py
app/main.py
app/database/schema.sql
```

The inventory must answer:

- whether ProductService can run headlessly;
- whether Repository contracts are portable;
- whether SQLite schema semantics remain suitable;
- whether path and lifecycle logic is Windows-specific;
- whether UI-facing dictionary projections are reusable contracts or desktop conveniences;
- whether structural defaults and settings semantics remain appropriate on mobile.

Do not perform broad refactoring during inventory.

---

# 8. Persistence and Synchronization Decision Boundary

Cycle 07 must explicitly separate:

```text
mobile local persistence
multi-device synchronization
authentication
cloud hosting
shared-household collaboration
```

The default investigation assumption should be:

```text
offline-first local mobile prototype
+
no backend unless a demonstrated requirement demands it
```

Compare at least:

- local SQLite or platform database reuse;
- mobile sandbox path and backup behavior;
- schema compatibility with desktop data;
- export/import as an interim transfer mechanism;
- future synchronization boundaries;
- migration ownership;
- whether desktop and mobile may safely open the same logical data model.

Do not implement production authentication, cloud synchronization, or hosting in Cycle 07 unless Main creates a separate accepted milestone.

---

# 9. Minimal Vertical Slice

The prototype must be intentionally small but meaningful.

Preferred slice:

```text
launch mobile prototype
→ initialize isolated local data
→ show one current list projection
→ register one product/purchase or equivalent minimal workflow
→ close and reopen
→ confirm persistence
```

The slice should exercise:

- one UI flow;
- one ProductService-equivalent workflow;
- one persistence boundary;
- one read projection;
- one lifecycle reopen.

A static mockup or navigation-only shell is insufficient.

The prototype must not mutate the ordinary desktop database.

---

# 10. Domain Responsibilities

## Operational [O]

Own:

- clone/worktree reproducibility;
- mobile toolchain and emulator/device prerequisites;
- build/run commands;
- local storage behavior;
- packaging and deployment evidence;
- prototype validation;
- operational cost and failure states for each approach.

## Didactic [A]

Own:

- concepts introduced by platform portability;
- shared logic versus shared runtime;
- client, service, local persistence, synchronization, and offline-first distinctions;
- technology-specific versus reusable concepts;
- learner dependency order;
- maturity discipline.

## Design [D]

Own:

- platform boundary;
- reusable core boundary;
- mobile presentation ownership;
- repository topology alternatives;
- persistence and synchronization responsibility;
- contract strategy;
- primary approach recommendation and explicit deferrals.

Main [M] reconciles the approaches and selects the prototype boundary. Codex materializes only after D/E/F authorization.

---

# 11. Fractioned Staging Route

Cycle 07 uses:

```text
A_OPERATIONAL.md
B_DIDACTIC.md
C_DESIGN.md
→ Main reconciliation in J
→ D_OPS_STAGE.md
E_DDC_STAGE.md
F_DSN_STAGE.md
→ Codex materialization
→ G/H/I evidence
→ permanent-domain reconciliation
→ Main-root update
```

A/B/C must be compact comparison stages, not exhaustive technology surveys.

Recommended limits:

```text
A  1,500–2,200 words
B  1,000–1,500 words
C  1,500–2,200 words
```

Each must begin with `Main Synthesis Summary` and include an evidence index, approach comparison, blockers, recommendation, and handoff.

---

# 12. Evaluation Criteria

Each approach should be assessed against the same criteria:

```text
reuse of current domain behavior
mobile UX suitability
offline capability
persistence safety
Android feasibility
iOS feasibility
tooling reproducibility
build/distribution complexity
testing strategy
maintenance cost
future synchronization compatibility
developer learning cost
```

Use observed evidence where possible. Mark assumptions explicitly.

Do not select an approach only because it minimizes initial code changes.

---

# 13. Scope Guard

Cycle 07 does not authorize:

- rewriting the complete desktop UI;
- deleting PySide6 desktop support;
- production backend deployment;
- authentication implementation;
- cloud synchronization implementation;
- app-store publication;
- payment systems;
- broad schema redesign;
- speculative microservices;
- automatic desktop/mobile data sharing;
- migration of ordinary user data without an accepted plan;
- merging prototype code into the accepted desktop release path before reconciliation.

---

# 14. Exit Criteria

Cycle 07 closes only when:

```text
baseline commit and isolated clone recorded
reusable/coupled/desktop-specific inventory complete
at least three mobile approaches compared
persistence and synchronization assumptions explicit
primary candidate selected for prototyping
minimal vertical slice runs in a mobile-relevant environment
local persistence survives close/reopen
prototype evidence reported through G/H/I
permanent domains reconciled
Main accepts the primary approach for the next implementation cycle
```

If no candidate succeeds, Cycle 07 may close with a precise blocker report and a justified next experiment. It must not claim mobile architecture acceptance from a paper comparison alone.

---

# 15. Recovery Warning

Preserve these distinctions:

```text
shared language ≠ shared runtime
platform-neutral code ≠ portable application
mobile mockup ≠ mobile workflow prototype
local mobile storage ≠ synchronization
prototype success ≠ production architecture
cloned investigation repo ≠ accepted permanent repository topology
```
