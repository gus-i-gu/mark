# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Checkpoint
> Current Milestone: Cycle 05 Sprint 01 — Windows Desktop Installation

---

## Current Milestone

Cycle 05 Sprint 01 absorbs verified Windows desktop packaging evidence through this learning transformation:

```text
source application
→ PyInstaller one-folder frozen runtime
→ bundled schema resource
→ per-user writable SQLite state
→ first-launch initialization and migration
→ Inno Setup per-user installer configuration
→ installed-lifecycle validation still pending
```

The accepted application boundary remains:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

Packaging and installation infrastructure did not move installer concerns into ProductService, Repository, or business behavior.

## Stable Concepts

- None fully Green yet.

Automated packaging evidence is substantial, but no concept advances to Green without explicit learning validation and the installed lifecycle remains incomplete.

## Active / Stronger Yellow Concepts

Existing concepts reinforced by Sprint 01:

- &&&03 — Naming as Data Contract
- &&&08 — Configuration State
- &&&15 — Default Value as Fallback Contract
- &&&16 — Validation Boundary
- &&&18 — Adapter Boundary
- &&&19 — Capability Versus Placeholder
- &&%04 — Platform-Neutral Read-Model Shape
- &%%12 — Service Contract Stability
- %%%01 — SQLite Schema Evolution

Cycle 05 Sprint 01 candidates supported by observed evidence:

- &&&20 — Packaged Application Lifecycle
- &&&21 — Packaging Versus Installation
- &&&22 — Resource State Versus User State
- &&&23 — Build-Time Versus Runtime Dependency
- &&&24 — Reproducible Build Process
- &&&25 — Successful Build Versus Validated Release
- &&&26 — Release Version and Compatibility Contract
- &&%09 — Frozen Python Execution Context
- &%%15 — Markei Installed Data Lifecycle

These candidates are checkpointed as Yellow or Red learning objects pending canonical-register materialization and later explicit teaching. They are not Green.

## Early / Unstable Concepts

- &&&14 — Mobile Readiness Without Rewrite
- &&&18 — Adapter Boundary
- &&&19 — Capability Versus Placeholder
- &&&21 — Packaging Versus Installation, because installation is configured but not compiled or exercised
- &&&24 — Reproducible Build Process, because one successful controlled build does not establish broad reproducibility
- &&&25 — Successful Build Versus Validated Release, because the installed release remains unvalidated
- &&&26 — Release Version and Compatibility Contract, because installed upgrade, uninstall, and reinstall behavior remain unverified

## Verified Sprint 01 Distinctions

```text
source execution
is not
frozen executable execution
```

The frozen executable launched successfully without requiring the ordinary repository launch command.

```text
packaging
is not
installation
```

PyInstaller produced and validated a one-folder runtime. Inno Setup defines installation behavior, but the installer artifact was not compiled because `ISCC.exe` was unavailable.

```text
successful PyInstaller build
is not
fully validated installed release
```

Build, frozen launch, schema discovery, and first-launch database behavior passed. Start Menu launch, installed upgrade, uninstall, reinstall, SmartScreen, and antivirus behavior remain unverified.

```text
bundled application resource
is not
writable user data
```

The production runtime contains `schema.sql`. The user database lives under `%LOCALAPPDATA%\Markei` and is not bundled into the runtime.

```text
schema initialization
is not
sample-data seeding
```

Production first launch creates an empty business database from `schema.sql` without `seed.sql` or sample business records.

```text
build-time dependency
is not
runtime dependency
```

PyInstaller participates in artifact production. PySide6 and collected Qt components support the running frozen application.

```text
application code
is not
packaging configuration
```

Packaging configuration collects the runtime, resources, and metadata without taking ownership of Markei business rules.

```text
installed application files
are not
persistent user data
```

Replaceable application files remain separate from `%LOCALAPPDATA%\Markei\market.sqlite`.

## Explicit Sprint 01 Evidence

Implemented and validated:

- PyInstaller one-folder runtime.
- Frozen executable launch.
- Working-directory-independent `schema.sql` discovery.
- Schema-only production initialization.
- Seed-free empty business database.
- User database under `%LOCALAPPDATA%\Markei`.
- First receipt workflow without a seeded store.
- Startup failure logging.
- Pinned PySide6 and PyInstaller dependencies.
- Public pages constructed: Register, Lists, History, Settings.

Verified empty first-launch state:

```text
products: 0
purchases: 0
stores: 0
categories: 0
settings: 6
```

Verified production-runtime exclusions:

```text
seed.sql
market.sqlite
SQLite WAL/SHM files
sample business records
```

Configured but not validated:

- Inno Setup per-user installer configuration.
- Application placement and shortcut configuration.
- Uninstall registration.
- Upgrade identity and preservation intent.

Primary blocker:

```text
Inno Setup ISCC.exe unavailable
```

## Numbering Reconciliation

The Cycle 04 checkpoint referenced identifiers that were not present in the visible canonical `02_KANBAN.md` materialization:

```text
&&&15 through &&&19
&&%07 through &&%08
&%%13 through &%%14
%%%09
```

These identifiers remain occupied and must not be reused.

Cycle 05 Sprint 01 candidate numbering therefore continues with:

```text
&&&20 through &&&26
&&%09
&%%15
```

The canonical register, glossary, and checkpoint must eventually be materialized into the same numbering state. Until then, this discrepancy remains explicit didactic-memory drift rather than permission to renumber concepts.

## Dependency Spine

```text
&&&03 Naming as Data Contract
↓
entrypoint and source-execution reinforcement
↓
&&&20 Packaged Application Lifecycle
├──→ &&&23 Build-Time Versus Runtime Dependency
│    ↓
│    &&&24 Reproducible Build Process
│
├──→ &&&21 Packaging Versus Installation
│
└──→ &&%09 Frozen Python Execution Context
     ↓
     &&&22 Resource State Versus User State
     ↓
     %%%01 SQLite Schema Evolution
     ↓
     &%%15 Markei Installed Data Lifecycle
     ↓
     &&&26 Release Version and Compatibility Contract
     ↓
     &&&25 Successful Build Versus Validated Release
```

## Project Learning Spine

```text
main.py / application entrypoint
↓
PyInstaller collection
↓
one-folder frozen runtime
↓
PySide6 and Qt runtime components
↓
working-directory-independent resource lookup
↓
bundled schema.sql
↓
%LOCALAPPDATA%\Markei\market.sqlite
↓
schema-only first launch
↓
idempotent migration and settings defaults
↓
Inno Setup per-user installer configuration
↓
compiled installer and installed-lifecycle validation still pending
```

## Deferred Learning

Sprint 02 or later:

- mobile framework selection;
- mobile UI implementation;
- synchronization and shared backend;
- authentication and accounts;
- cross-device persistence;
- external supermarket/reward integration;
- receipt or NFC-e recognition.

Release hardening deferred until installer validation:

- production signing;
- SmartScreen reputation behavior;
- antivirus false-positive handling beyond observation;
- automated update channel;
- formal rollback mechanism;
- byte-identical deterministic builds.

## Next Concepts

1. Compile the Inno Setup installer when `ISCC.exe` is available.
2. Validate Start Menu launch from a clean user profile.
3. Verify that installed upgrades preserve `%LOCALAPPDATA%\Markei\market.sqlite`.
4. Verify uninstall preservation and reinstall recovery.
5. Perform a manual interactive walkthrough of Register, Lists, History, and Settings.
6. Observe SmartScreen and antivirus behavior without treating reputation as application correctness.
7. Reconcile `02_KANBAN.md`, `07_GLOSSARY.md`, and `13_LECTURE_REGISTER.md` with this checkpoint while preserving occupied identifiers.
8. Keep PyInstaller and Inno Setup as tooling evidence rather than automatic standalone canonical concepts.

## Session Delta

Cycle 05 Sprint 01 moved Markei from developer-run source execution to a validated PyInstaller one-folder frozen runtime with schema-only initialization and external per-user data. Inno Setup installation behavior is configured but remains uncompiled and unvalidated because `ISCC.exe` was unavailable. The learning state now explicitly distinguishes successful packaging from a validated installed release, preserves the application/service/repository/SQLite boundary, and records unresolved numbering drift without reusing identifiers.
