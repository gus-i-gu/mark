# Main Synthesis Summary

Cycle 07 Sprint 01 should teach portability as a set of boundaries, not as a technology-name choice. Markei already separates much business vocabulary from PySide6, but that does not prove that the application can move unchanged to mobile. The smallest useful learning target is an offline-first, single-device prototype that uses mobile-local data, exercises one business workflow, and treats desktop behavior as evidence rather than the desktop database as a shared resource. A backend is not conceptually required unless later requirements introduce cross-device or multi-user coordination.

Cycle 06 is accepted and closed. The Didactic checkpoint still says acceptance is pending; this is inherited checkpoint drift, not evidence for reopening the cycle. No existing concept maturity is changed by this report.

## Inspected Evidence

Inspection explicitly used branch `cycle-07-mobile-preparation`. Current HEAD `889c9ac365e0d717ac33431bd82af286b0f343f1` descends from the verified baseline `f6414fbe7394453387067a5a34ca6cc7621bbed3`.

Methodology and Cycle context were recovered from `AGENTS.md`, `INDEX.md`, the four required methodology files, `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, `didactics/08_CONCEPT_MAP.md`, and `[M]_STAGE/J_[M]_STAGE.md`.

Implementation evidence included `app/core/models.py`, `contracts.py`, `services.py`, `repository.py`, `database.py`, `config.py`, all tracked source under `app/desktop/` and `app/mobile/`, both entry points, and `app/database/schema.sql`. The models are Python dataclasses without UI imports. `ProductService` contains validation, calculations, settings, and UI-facing projections, but imports and constructs the concrete `Repository`. The repository owns SQLite operations. The database manager assumes bundled resources plus a Windows-oriented `%LOCALAPPDATA%`/home fallback. The desktop tree is a substantial PySide6 UI; `app/mobile/main.py` is empty. The schema expresses durable product, purchase, category, store, setting, and promotion facts.

## Concepts Required for the Decision

**Shared language versus shared runtime.** Two platforms may both use Python source syntax while needing different interpreters, packaging systems, native bridges, libraries, and lifecycle support. Shared Python therefore reduces translation only if a supported Python runtime and every required dependency can execute inside the mobile platform boundary.

**Platform-neutral code versus portable application.** Code is platform-neutral when its meaning does not depend on a particular UI toolkit, operating-system path, packaging context, or device lifecycle. An application is portable only when its entire executable chain—runtime, dependencies, storage paths, resources, lifecycle, UI, and deployment—works on the target. Markei’s dataclasses and many calculations look platform-neutral; the concrete repository construction and Windows-shaped database location remain portability questions.

**Business behavior versus UI implementation.** Business behavior defines what registering a receipt, recalculating a product, or classifying a list means. UI implementation defines how a user enters, navigates, and sees that behavior. PySide6 pages are desktop presentation, while service rules are candidate business behavior. UI-facing dictionaries may preserve useful meanings, but their shape could also reflect current widgets and must be tested as contracts rather than assumed universal.

**Contract reuse versus source-code reuse.** Source reuse means executing the same implementation. Contract reuse means preserving inputs, outputs, invariants, error cases, and fixtures even when another language reimplements the behavior. `contracts.py` names responsibilities, but its Python abstract classes alone are not a language-neutral mobile contract. Cross-language clients would learn more from explicit schemas and shared behavioral examples than from copying Python interfaces.

**Client, service, and contract.** A client is the user-facing application and its local orchestration. A service owns business workflows; it need not mean a network server. A contract describes the stable boundary by which callers use behavior. This vocabulary prevents “service layer” from being mistaken for “backend.”

**Local persistence versus synchronization.** Local persistence keeps state across launches on one installation. Synchronization reconciles state between independent stores and therefore requires identity, transport, conflict, failure, and security semantics. SQLite proves local persistence, not synchronization. The mobile prototype should create its own sandboxed database and must not access the ordinary desktop database.

**Offline-first versus cloud-backed operation.** Offline-first means core work remains available against authoritative local state without a network; optional synchronization can happen later. Cloud-backed operation makes remote infrastructure part of the operating boundary, even if caches exist. Markei’s current single-device workflow supports investigating offline-first without accounts or a backend.

**Prototype evidence versus production architecture.** A prototype answers a bounded uncertainty: can one vertical slice run and preserve its meanings? It does not prove maintainability, complete migration, store distribution, accessibility, synchronization, security, or production fitness. Evidence should be recorded at exactly the level demonstrated.

## Candidate Concept Dependency Order

1. Platform boundary and execution context.
2. Business behavior versus presentation.
3. Shared language versus shared runtime.
4. Platform-neutral component versus portable application.
5. Client, service, repository, and contract boundaries.
6. Source reuse versus contract/fixture reuse.
7. Mobile-local persistence and sandbox ownership.
8. Offline-first operation.
9. Synchronization and conflict semantics, only if required.
10. Prototype evidence versus production acceptance.

## Approach Families from the Learner’s Perspective

| Family | Main learning gain | Principal misconception to avoid | Prototype question |
| --- | --- | --- | --- |
| A. Shared Python core + Python-native UI | Tests whether source and business behavior can share one runtime | “Written in Python” means mobile-ready | Can a supported mobile Python runtime execute one service workflow with sandboxed SQLite and a native-feeling screen? |
| B. Web/hybrid presentation | Separates portable UI skills from local storage and native bridges | Web UI automatically implies a server | Can a packaged client perform the slice offline with local persistence and no Python process? |
| C. Native/cross-platform client + explicit contracts | Makes behavior preservation independent of implementation language | Reimplementation must drift | Can contract examples and fixtures reproduce one Python-defined workflow locally? |
| D. Service-backed client | Teaches remote authority, accounts, sync, and failure boundaries | Mobile automatically requires cloud infrastructure | Which demonstrated requirement cannot be satisfied by a local client? |

A offers maximal possible source reuse but depends most strongly on mobile Python runtime evidence. B may match existing web-language familiarity and remain offline, but likely replaces or relocates Python behavior. C makes the reuse distinction clearest and may offer stronger platform integration at the cost of duplicated implementation. D should remain deferred under current requirements because it adds concepts and operations not needed to test local portability.

## Possible KANBAN Candidates — Not Promoted

- `&&&` Platform Boundary and Execution Context.
- `&&&` Source Reuse versus Contract Reuse.
- `&&&` Local Persistence versus Synchronization.
- `&&&` Offline-First State Authority.
- `&&&` Prototype Evidence versus Production Architecture.
- `&&%` Python Language Availability versus Python Runtime Availability.
- `&%%` UI Projection as Contract Candidate.
- `&%%` Mobile Sandbox and Database Ownership.
- `%%%` Mobile Runtime, Packaging, and Native Bridge Dependency.

These are candidates only. IDs, canonical definitions, relationships, and maturity require later Didactic promotion authority and learner evidence.

## Minimum Concepts Before Prototype Materialization

Before Main authorizes a prototype, the learner needs only to explain: where code executes; which behavior is being preserved; whether preservation uses the same source or an explicit contract; who owns the mobile-local database; why offline-first does not mean synchronized; and what single claim the prototype can validate. Synchronization algorithms, authentication, cloud hosting, production migrations, and final repository topology are unnecessary unless the selected slice or demonstrated requirements make them unavoidable.

## Handoff to Main

Select a vertical slice that registers or reads one meaningful local fact through a mobile presentation, preserves an explicit business invariant, uses a fresh sandboxed store, and produces evidence for one approach family. Keep backend, desktop-database access, full UI parity, maturity changes, and production-architecture claims outside the Sprint 01 conclusion.
