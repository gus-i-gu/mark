# Didactic Checkpoint Recovery Retrospective

> Status: Ephemeral functional staging
> Role: Didactic Chat [A]
> Branch: `sketch-notebook-recovery`
> Scope: Main-branch commit retrospective through the Cycle 05 naming transition, reconciled against current didactic canon
> Knowledge state: Historical evidence and checkpoint preparation; not canonical knowledge
> Permanent target: `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`

---

## 1. Purpose

This stage temporarily preserves the commit retrospective required to rebuild the Didactic checkpoint after canonical and derivative repopulation.

The retrospective is bounded around the transition from closed Cycle 04 into the competing Cycle 05 directions. It does not reproduce every historical commit or restore the former checkpoint verbatim.

```text
current 02_KANBAN canon
+ current repository recovery baseline
+ main-branch commit sequence through Cycle 05
= compact current checkpoint
```

Commit history explains how the current learning state emerged. It does not override current canon.

---

## 2. Retrospective Boundary

```text
Cycle 04 domain reconciliation and global closure
↓
post-Cycle 04 recovery scheme
↓
Cycle 05 mobile-preparation synthesis
↓
Cycle 05 mobile-development planning session
↓
cycle 5.0 outburst mode
↓
Cycle 05 Sprint 01 packaging reconciliation
↓
desktop packaging operational model
```

Relevant commits:

```text
1e07b48  Reconcile Cycle 04 didactic checkpoint
c84e850  Close Cycle 04 global project state
bd4b4cd  Prepare post-Cycle 04 recovery scheme
e9cf0f0  Stage Cycle 05 mobile preparation synthesis
a4f7732  Prepare Cycle 05 mobile development planning session
c51938b  cycle 5.0 outburst mode
11a931f  Reconcile Cycle 05 Sprint 01 operational checkpoint
bc4d3a5  Reconcile Cycle 05 Sprint 01 operational TODO
b29aec0  Reconcile Cycle 05 Sprint 01 didactic checkpoint
d4a1448  Append Cycle 05 Sprint 01 operational evidence
fbeef65  Add desktop packaging operational model
```

This range exposes the last closed baseline, the failed intended cycle, the pivot, the packaging evidence, and the unresolved completion boundary.

---

## 3. Closed Baseline Before the Failed Cycle

Cycle 04 closed with:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

The project had service-owned business interpretation, generic repository persistence, platform-neutral semantic values, consolidated Lists views, History analytics, Settings validation, and separation between UI labels and persisted meanings.

The forward state still carried human verification gaps around Settings interaction, store editing and refresh, first-weekday period-end correctness, and broad desktop regression evidence.

---

## 4. Failed Preceding Cycle: Mobile Preparation

The first Cycle 05 direction was preparation for full mobile implementation. Its declared exit conditions required decisions about mobile product scope, reusable core boundaries, typed contracts, dependency construction, persistence and synchronization, backend/API responsibility, identity and security, mobile framework, migration, automated validation, and phased implementation.

The planning documents prohibited broad mobile coding before those dependencies were reconciled.

That cycle did not reach its declared exit conditions. Before product scope, data ownership, synchronization, backend, identity, framework, and migration decisions were resolved, the lineage pivoted into `cycle 5.0 outburst mode` and then a Windows desktop packaging sprint.

The first Cycle 05 direction is checkpointed as:

```text
historically significant
+ useful for exposing missing decisions
+ incomplete
+ superseded as active implementation direction
```

It must not be represented as completed mobile preparation, implemented mobile architecture, or accepted target design.

Its principal lesson is capability versus readiness: a planning document and reusable service boundary do not prove that a second platform is ready to build.

---

## 5. Cycle 05 Pivot: Desktop Packaging

The pivot changed the active learning topic from mobile architecture preparation to Windows packaging and installation.

```text
source application
→ PyInstaller one-folder frozen runtime
→ bundled schema resource
→ per-user writable SQLite state
→ first-launch initialization and migration
→ Inno Setup installer configuration
→ installed-lifecycle validation pending
```

Verified evidence included a generated and launched frozen runtime, working-directory-independent schema discovery, schema-only first launch, seed-free production business state, `%LOCALAPPDATA%/Markei` writable data, resource/data separation, pinned dependencies, and construction of the four public pages.

Configured but incomplete were Inno Setup compilation, installed Start Menu launch, upgrade preservation, uninstall/reinstall lifecycle, SmartScreen and antivirus observation, signing, and rollback. The immediate blocker was unavailable `ISCC.exe`.

The sprint produced a validated frozen runtime, not a fully validated installed release.

---

## 6. Conflict Against Current Canon

The current `02_KANBAN.md` is a fresh recovery canon. Historical identifiers from the former checkpoint are not imported unless represented in current canon.

### Canon reinforced by the retrospective

```text
&&&01 Responsibility Boundary
&&&02 Raw Data Versus Derived Data
&&&03 Naming as Data Contract
&&&04 Resource Ownership and Lifetime
&&%01 Package and Module Boundary
&&%03 Context Manager and Deterministic Cleanup
&%%01 Application Service
&%%02 Repository Pattern and Persistence Adapter
&%%03 Presentation Adapter
&%%04 Database Row, Domain Model, and View Model
&%%05 Statement Atomicity Versus Workflow Atomicity
%%%01 SQLite Initialization Versus Migration
%%%02 SQLite Connection and Cursor Ownership
%%%03 SQLite PRAGMA and Connection Configuration
%%%05 Bundled Resource Versus Writable User Data
```

Packaging-specific historical lessons—frozen execution, packaging versus installation, build-time versus runtime dependencies, reproducible builds, version compatibility, and successful build versus validated release—remain historical or next-concept material pending explicit promotion under the refreshed numbering system.

### Unresolved questions

- application-level shutdown ownership;
- deterministic closure of four page-owned chains;
- workflow transaction boundaries;
- breadth of ProductService and Repository;
- completeness of abstract contracts;
- dictionary versus typed view models;
- migration versioning;
- promotions-table status;
- `pages.order` drift;
- production seed policy;
- installer lifecycle validation;
- mobile product and architecture direction.

---

## 7. Checkpoint Reconstruction Decision

```text
The notebook recovered the contemporary layered desktop system,
repopulated Didactic canon and glossary,
and reconstructed learning state after a failed mobile-preparation cycle
followed by a partially completed desktop-packaging pivot.
```

No concept becomes Green solely from code or packaging evidence. Yellow marks strongly evidenced concepts still requiring reinforcement. Red marks ownership, cleanup, and transaction concepts tied to unresolved behavior or decisions.

### Proposed checkpoint state

Stable concepts: none confirmed Green through explicit human learning validation.

Active concepts:

```text
&&&01 &&&02 &&&03
&&%01 &&%02
&%%01 &%%02 &%%03 &%%04
%%%01 %%%03 %%%04 %%%05
```

Unstable concepts:

```text
&&&04
&&%03
&%%05
%%%02
```

Next concepts:

- packaged execution versus source execution;
- packaging versus installation;
- build dependency versus runtime dependency;
- successful build versus validated release;
- application composition root and shutdown ownership;
- workflow transaction boundary;
- explicit migration/version compatibility;
- second-platform readiness versus implementation.

These are checkpoint recommendations, not canonical concepts.

---

## 8. Stage Exit

This retrospective is ready to compress into `08_CONCEPT_MAP.md`.

After checkpoint materialization, this DEV_STAGE content remains ephemeral evidence. `13_LECTURE_REGISTER.md` remains empty until explicit observational registration. The failed Cycle 05 mobile-preparation attempt may later become the first observational metadata entry once checkpoint completion is accepted.