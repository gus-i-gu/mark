# B_DIDACTIC — Cycle 06

> Status: Ephemeral functional stage
> Role: Didactic Chat [A]
> Branch: `sketch-notebook-recovery`
> Authority: Learning analysis for Main reconciliation; not canonical Didactic memory
> Milestone: Fully executable and installable Windows primary beta
> Main reconciliation surface: `documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`

## Main Synthesis Summary

Cycle 06 requires the developer to distinguish technical states that the current Didactic canon only partly covers. Existing concepts already explain responsibility boundaries, resource ownership, persistence lifecycle, bundled resources versus user data, deterministic cleanup, and workflow atomicity. They should be reused rather than duplicated.

Four compact candidates remain justified: **Evidence State and Validation Boundary**, **Source/Frozen/Installed Execution Context**, **Packaging and Installation Artifact Lifecycle**, and **Build-Time/Runtime/Installer-Time Dependency**. These are reusable distinctions, not lessons about PyInstaller or Inno Setup as products. All remain Red candidates; none becomes canonical or Green through this stage.

Current branch evidence shows a root entrypoint, a Qt application entrypoint, frozen-resource path handling, `%LOCALAPPDATA%/Markei` user data, a PyInstaller one-folder specification collecting `schema.sql` and `seed.sql`, optional seed execution when the file exists, and additive migration. It does not prove a compiled installer, installed launch, uninstall retention, upgrade compatibility, deterministic shutdown, or current-branch release acceptance.

The primary Didactic risk is status inflation:

```text
configured
≠ built
≠ launched
≠ installed
≠ validated
≠ accepted
```

Main should preserve these four candidates for later E-stage drafting, reinforce existing persistence and lifetime concepts with Cycle 06 examples, and keep seed policy, uninstall retention, lifecycle ownership, and application identity as Design/Main decisions rather than Didactic conclusions. The first materialization boundary should produce only the concepts and terminology needed to understand the first bounded packaging/installation implementation stage.

## Current Learning Baseline

No canonical concept is Green through explicit human validation.

Current relevant Yellow concepts:

```text
&&&01  Responsibility Boundary
&&&02  Raw Data Versus Derived Data
&&&03  Naming as Data Contract
&&%01  Package and Module Boundary
&%%01  Application Service
&%%02  Repository Pattern and Persistence Adapter
&%%03  Presentation Adapter
%%%01  SQLite Initialization Versus Migration
%%%05  Bundled Resource Versus Writable User Data
```

Current relevant Red concepts:

```text
&&&04  Resource Ownership and Lifetime
&&%03  Context Manager and Deterministic Cleanup
&%%05  Statement Atomicity Versus Workflow Atomicity
%%%02  SQLite Connection and Cursor Ownership
```

The Concept Map already names source versus frozen execution, packaging versus installation, dependency phases, and build versus release validation as next concepts. It is stale in milestone wording and in stating that the Lecture Register is empty. This stage records the drift but does not update permanent memory.

## Essential Evidence Index

| ID | File or evidence | Why it matters |
|---|---|---|
| E1 | `documentation/sketch_notebook/06_SESSION_SCHEME.md` | Defines the Cycle 06 milestone, evidence vocabulary, scope, and installed-lifecycle acceptance boundary. |
| E2 | `documentation/sketch_notebook/didactics/02_KANBAN.md` | Establishes current concept ownership, maturity, and occupied identifiers. |
| E3 | `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md` | Identifies the packaging concepts as unallocated next concepts and exposes checkpoint drift. |
| E4 | `main.py` and `app/main.py` | Establish source entrypoint and Qt process startup. |
| E5 | `Markei.spec` | Shows one-folder frozen packaging intent and collection of SQL resources. |
| E6 | `app/core/database.py` | Distinguishes source/frozen resource lookup, writable user state, initialization, seeding, migration, and connection behavior. |
| E7 | `app/core/config.py` | Supplies current application name and version value. |
| E8 | `operational/10_OPERATIONAL_STATE.md` and `operational/04_TODO.md` | Separate current-branch source facts from historical frozen-runtime evidence and unvalidated installed lifecycle. |

Additional inspected context: `00_PROJECT_STATE.md`, `07_GLOSSARY.md`, `13_LECTURE_REGISTER.md`, `requirements.txt`, and historical commit `fbeef65`.

## Existing Concepts to Reuse

### `&&&01` Responsibility Boundary

Finding:
Use it to separate entrypoint responsibility, packaging configuration, installer behavior, persistence ownership, validation evidence, and release acceptance.

Status:
observed

Impact:
materialization input

Evidence:
E1, E2, E4–E6

### `&&&03` Naming as Data Contract

Finding:
Reinforce it with the exact evidence terms `configured`, `built`, `launched`, `installed`, `validated`, `accepted`, and `blocked`. Vague terms such as “working” collapse distinct states.

Status:
observed

Impact:
materialization input

Evidence:
E1, E2, E8

### `&&&04`, `&&%03`, and `%%%02` Resource Lifetime and Cleanup

Finding:
Together they already cover clean shutdown, connection release, and reopen safety. Process termination is not proof of deterministic cleanup, while missing centralized ownership is not proof of a leak.

Status:
unresolved

Impact:
validation input

Evidence:
E2, E6, E8

### `%%%01` Initialization Versus Migration

Finding:
Reinforce with a third project-specific operation: seeding. Initialization creates structure, migration adapts existing state, and seeding inserts initial rows. Seeding does not require a new concept yet.

Status:
observed

Impact:
materialization input

Evidence:
E2, E6

### `%%%05` Bundled Resource Versus Writable User Data

Finding:
This remains the central persistence concept. `schema.sql` and potentially `seed.sql` are bundled resources; `market.sqlite` and its runtime companions are user state. External placement supports preservation but does not validate it.

Status:
observed

Impact:
beta blocker through validation, not concept creation

Evidence:
E5, E6, E8

### `&%%05` Statement Versus Workflow Atomicity

Finding:
Packaging does not change the existing multi-commit workflow model. This distinction should be retained as inherited validation debt, not recast as a packaging concept.

Status:
observed

Impact:
validation input

Evidence:
E2, E8

## New Concept Candidates

### `&&&05` — Evidence State and Validation Boundary

**Why existing canon is insufficient:** Raw/derived data and naming contracts help interpret evidence, but neither defines the ordered maturity boundary between configuration, artifact production, observed behavior, validation, and acceptance.

**Required concepts:** `&&&01`, `&&&02`, `&&&03`

**Proposed status:** Red

**Markei evidence:** E1 and E8 distinguish configured, built, launched, installed, validated, and accepted states.

### `&&%04` — Source, Frozen, and Installed Execution Context

**Why existing canon is insufficient:** `&&%01` explains Python packages and modules, not the runtime differences among interpreter-driven source execution, a frozen distribution, and an installer-created application state.

**Required concepts:** `&&&01`, `&&%01`, `%%%05`

**Proposed status:** Red

**Markei evidence:** E4 provides source entrypoints; E5 defines frozen output; E6 changes resource resolution when `sys.frozen` is set; E1 defines installed execution requirements.

### `&%%06` — Packaging and Installation Artifact Lifecycle

**Why existing canon is insufficient:** No existing concept maps source configuration to generated package, installer configuration, compiled installer, installed state, and uninstall lifecycle.

**Required concepts:** `&&&01`, `&&&04`, `&&%04`, `%%%05`

**Proposed status:** Red

**Markei evidence:** E5 is packaging configuration rather than an installed state; E1 and E8 explicitly leave installer compilation and installed lifecycle unvalidated.

### `%%%06` — Build-Time, Runtime, and Installer-Time Dependency

**Why existing canon is insufficient:** Existing package and resource concepts do not classify dependencies according to the phase in which they are required.

**Required concepts:** `&&%01`, `&&%04`, `&%%06`

**Proposed status:** Red

**Markei evidence:** E4 requires PySide6 behavior at runtime; E5 represents a build-tool transformation; E1 distinguishes installer compilation from installed execution.

PyInstaller and Inno Setup remain tool-specific evidence, not separate KANBAN concepts.

## Numbering and Drift

Occupied canonical ranges:

```text
&&&01–&&&04
&&%01–&&%03
&%%01–&%%05
%%%01–%%%05
```

Provisional next identifiers are therefore `&&&05`, `&&%04`, `&%%06`, and `%%%06`. No missing-looking identifier is reused.

Finding:
`08_CONCEPT_MAP.md` still presents the recovery-cycle milestone and says the Lecture Register is empty, while Cycle 06 is active and observational history exists.

Status:
observed

Impact:
deferrable until post-materialization Didactic reconciliation

Evidence:
E1, E3

Finding:
`00_PROJECT_STATE.md` retains the older recovery milestone while `06_SESSION_SCHEME.md` activates Cycle 06.

Status:
observed

Impact:
Main reconciliation input

Evidence:
E1

## Critical Distinctions

```text
source execution
≠ frozen executable execution
≠ installed application execution
```

```text
packaging configuration
≠ generated distribution
≠ installer configuration
≠ compiled installer
≠ installed application
```

```text
build-time dependency
≠ runtime dependency
≠ installer-time dependency
```

```text
bundled resource
≠ generated artifact
≠ writable user state
```

```text
schema initialization
≠ migration
≠ sample-data seeding
```

```text
application version
≠ installer/upgrade identity
≠ database compatibility
```

```text
application-file removal
≠ user-data deletion
```

```text
successful command
≠ validated behavior
≠ accepted release
```

```text
clean shutdown
≠ process termination
≠ reopen safety
```

The current branch directly supports the first side of several distinctions but lacks installed-lifecycle evidence for their final states. Supported by E1, E4–E8.

## Misconception Risks

1. **Treating a PyInstaller build as a release.** A generated distribution proves neither installation nor lifecycle acceptance.
2. **Confusing `dist/Markei` with an installed application.** Installation adds target paths, shortcuts or registration, identity, upgrade, and uninstall behavior.
3. **Assuming `%LOCALAPPDATA%` proves preservation.** Placement supports separation; install, upgrade, uninstall, and reinstall tests prove retention behavior.
4. **Confusing version metadata with compatibility.** `VERSION = "0.1.0"` does not by itself define installer upgrade identity or database compatibility.
5. **Treating process exit as clean shutdown—or implicit ownership as proof of a leak.** Both claims require direct lifecycle evidence.

## Proposed Post-Materialization Learning Updates

After matching Cycle 06 H-report evidence exists, Didactic should classify only demonstrated outcomes:

- add canonical candidates only if Main approved them and materialization evidence matches;
- derive glossary terms such as frozen runtime, generated artifact, installed state, installer identity, and validation gate from approved canon;
- reinforce `%%%01` with seeding and `%%%05` with installed resource/user-state examples;
- update `&&&04`, `&&%03`, and `%%%02` only from actual shutdown/reopen evidence;
- refresh `08_CONCEPT_MAP.md` to Cycle 06 and append observational learning history without promoting implementation success to Green.

## Main Handoff

Main should reconcile four candidate concepts, retain the five misconception risks, and preserve exact evidence-state vocabulary across A/B/C. No independent Didactic decision blocks the first implementation stage. Seed inclusion, uninstall retention, shutdown ownership, application/installer identity, and compatibility policy remain Design/Main decisions informed by Operational evidence.

Recommended first materialization boundary:

```text
entrypoint and frozen-context observability
+ packaging/resource configuration
+ application identity metadata
+ installer source needed for an ordinary installed launch
+ isolated validation scaffolding
```

Didactic materialization should be limited to the terminology and candidate definitions needed to understand that boundary. Full canonical lessons, glossary promotion, Concept Map refresh, and Lecture Register updates belong after Main reconciliation and matching materialization evidence.

Deferred outside Cycle 06:
mobile, backend/API, synchronization, authentication, cloud architecture, broad service/repository decomposition, unrelated UI redesign, broad schema redesign, automatic updating, and signing unless controlled-beta acceptance later proves them blocking.
