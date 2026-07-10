# 06_SESSION_SCHEME.md

> Version: Cycle 06 forward checkpoint 0.1
> Status: Active Forward Checkpoint
> Persistence Class: Forward Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Preparation branch: `sketch-notebook-recovery`
> Current-state source: `00_PROJECT_STATE.md`
> Historical source: `05_SESSION_LOG.md`
> Domain checkpoints: `operational/10_OPERATIONAL_STATE.md`, `didactics/08_CONCEPT_MAP.md`, `design/09_DESIGN_STATE.md`
> Cycle target: fully executable and installable Windows primary beta of Markei

---

# 1. Purpose and Reading Rule

This file prepares Cycle 06.

It defines:

- the single active cycle outcome;
- the bounded inspection route;
- role and staging responsibilities;
- implementation and validation gates;
- evidence required for executable and installer acceptance;
- recovery warnings inherited from Cycle 05;
- exit criteria for a primary beta release candidate.

It does not itself authorize implementation changes.

It is not:

- application canon;
- a replacement for Operational, Didactic, or Design checkpoints;
- a Codex implementation report;
- proof that a build, executable, or installer works;
- permission to bypass A/B/C, D/E/F, G/H/I, Main reconciliation, or human validation.

Authority route:

```text
Current project state
    00_PROJECT_STATE.md

Current execution and validation state
    operational/10_OPERATIONAL_STATE.md
    operational/04_TODO.md

Current learning state
    didactics/08_CONCEPT_MAP.md

Current architecture and open decisions
    design/09_DESIGN_STATE.md

Prior recovery and failed-cycle history
    05_SESSION_LOG.md

Cycle 06 preparation
    06_SESSION_SCHEME.md
```

---

# 2. Cycle 06 Single Active Milestone

Cycle 06 has one active milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

The expected user-facing delivery is:

```text
Windows installer
→ installs Markei into an ordinary user environment
→ provides a launchable application executable
→ starts without a development Python command
→ creates or reuses writable user data outside installed program files
→ supports the principal desktop workflows
→ closes and reopens without retained database failure
→ preserves intended user data through the tested lifecycle
→ can be uninstalled according to an explicitly accepted data-retention policy
```

A successful source run is not the Cycle 06 milestone.

A successful PyInstaller command is not the Cycle 06 milestone.

A generated `.exe` that starts only from the build directory is not the Cycle 06 milestone.

An installer that compiles but has not been installed and exercised is not the Cycle 06 milestone.

Cycle 06 closes only when the accepted beta package has been built, installed, launched, exercised, closed, reopened, and reconciled through the Sketch Notebook evidence flow.

---

# 3. Product Outcome Definition

## 3.1 Primary beta

For Cycle 06, “primary beta” means the first internally distributable Windows desktop package whose core Markei behavior is sufficiently complete and validated for controlled beta use.

The beta is not a declaration of production maturity.

It must support the contemporary public surfaces:

```text
Register
Lists
History
Settings
```

Storage, Shortage, and Market remain Lists modes unless an explicit Design decision changes that structure before implementation staging.

## 3.2 Executable outcome

The packaged runtime must:

- launch from the installed application entrypoint;
- not require the user to invoke `python`, activate a virtual environment, or locate source files;
- resolve required bundled resources independently of the working directory;
- initialize or open the user database from the approved writable location;
- display the expected MainWindow and public pages;
- report startup failure in an inspectable form rather than silently disappearing;
- exclude development-only and transient files from the release package.

## 3.3 Installer outcome

The installer must:

- compile successfully with the selected Windows installer toolchain;
- install the executable and required read-only resources;
- create an ordinary launch path such as a Start Menu entry and, if approved, a desktop shortcut;
- avoid installing a live user database as replaceable program content;
- implement the accepted seed policy;
- implement the accepted uninstall data policy;
- provide version and publisher metadata appropriate to a primary beta;
- support an install → launch → use → close → reopen → uninstall sequence;
- support upgrade and reinstall testing when required by the accepted beta lifecycle.

---

# 4. Scope Boundaries

## 4.1 In scope

Cycle 06 includes only work required to produce and validate the Windows primary beta:

- inspect current packaging and installer configuration;
- reconcile current source behavior with package behavior;
- resolve production seed inclusion;
- ensure required database resources are bundled and discoverable;
- ensure live database and WAL/SHM files are excluded;
- establish startup-error observability;
- establish executable metadata and version information;
- build the packaged runtime;
- compile the installer;
- install and run the application in a user-like environment;
- validate principal workflows;
- validate shutdown and immediate reopen behavior;
- validate intended user-data preservation;
- record evidence and update notebook memory through the prescribed stages.

## 4.2 Explicitly out of scope

Unless a blocking beta defect makes a narrowly bounded change unavoidable, Cycle 06 does not reopen:

- mobile architecture;
- backend or API design;
- synchronization;
- authentication or remote identity;
- cloud persistence;
- major ProductService or Repository decomposition;
- broad view-model redesign;
- new feature development unrelated to installable-beta acceptance;
- visual redesign unrelated to usability or launch blockers;
- general schema redesign;
- replacement of the current migration mechanism with a complete migration framework;
- unrelated cleanup or refactoring merely because files are large.

Any proposed scope expansion must be classified before implementation as:

```text
required beta blocker
or
future-cycle proposal
```

A future-cycle proposal remains outside Cycle 06.

---

# 5. Cycle 05 Prevention Rules

Cycle 06 must not repeat the Cycle 05 failure pattern.

The following controls are mandatory.

## 5.1 One milestone

```text
fully installable and executable Windows primary beta
```

No parallel mobile, backend, synchronization, or unrelated architecture milestone may be introduced into this cycle.

## 5.2 Fractioned inspection

Inspection must be divided into bounded passes. A chat should not ingest all packaging history, source code, stages, reports, and generated artifacts in one uncontrolled context.

Preferred order:

```text
current checkpoints
→ current packaging and installer files
→ exact application/runtime boundaries affected
→ existing tests and build commands
→ only then bounded historical commits when intent remains unclear
```

## 5.3 Complete functional staging before implementation staging

A/B/C must be complete and mutually reconcilable before D/E/F are finalized.

```text
A_OPERATIONAL
    executable, installer, resource, lifecycle, and validation plan

B_DIDACTIC
    concepts and explanations required to understand the packaging lifecycle

C_DESIGN
    accepted package/runtime boundaries and any beta-blocking design decisions
```

## 5.4 Main reconciliation before Codex execution

Main must reconcile A/B/C in the authorized J surface before preparing D/E/F.

No functional stage may independently become implementation authority.

## 5.5 No stale Codex reports

G/H/I must correspond to the same Cycle 06 materialization represented by D/E/F.

A Cycle 06 checkpoint must not be promoted while G/H/I still describe Cycle 04, Cycle 05, or an earlier Cycle 06 sprint.

## 5.6 Evidence level must match status language

Use:

```text
configured
built
launched
installed
validated
accepted
blocked
```

Do not report “release complete” from source inspection, configuration, or build success alone.

## 5.7 Preserve inherited validation debt

Cycle 06 must carry forward rather than erase:

- deterministic closure of all page-owned repositories;
- exact multi-commit failure behavior;
- seed classification;
- migration and reset behavior under isolation;
- generated-resource inclusion;
- installed data preservation;
- retained human desktop interaction checks.

---

# 6. Required Role Route

## 6.1 Main Chat [M]

Main owns:

- cycle coherence;
- milestone and scope control;
- prompt preparation for domain chats;
- A/B/C reconciliation;
- D/E/F preparation;
- conflict classification;
- human-decision surfacing;
- post-materialization reconciliation;
- `00_PROJECT_STATE.md` refresh;
- `05_SESSION_LOG.md` append;
- next `06_SESSION_SCHEME.md` preparation.

Main must not silently decide functional-domain truth that requires domain ownership or human acceptance.

## 6.2 Operational Chat [O]

Operational owns execution analysis for:

- development and frozen runtime commands;
- PyInstaller configuration and resource collection;
- installer toolchain and compile commands;
- seed/resource inclusion and exclusion;
- user-data path behavior;
- startup logging;
- build artifact inspection;
- executable launch validation;
- shutdown and database-lock behavior;
- installation, upgrade, uninstall, and reinstall evidence;
- exact acceptance commands and expected results.

Primary output:

```text
DEV_STAGE/A_OPERATIONAL.md
```

## 6.3 Didactic Chat [A]

Didactic owns the Cycle 06 learning model for:

- source execution versus frozen execution;
- build-time versus runtime dependency;
- package resource versus writable data;
- executable bundling;
- installer compilation;
- successful build versus validated release;
- installation lifecycle;
- version metadata;
- startup diagnostics;
- upgrade and uninstall data behavior.

Primary output:

```text
DEV_STAGE/B_DIDACTIC.md
```

Didactic work must support understanding and durable recovery without inflating Cycle 06 implementation scope.

## 6.4 Design Chat [D]

Design owns architectural analysis for:

- packaged runtime boundary;
- executable composition and entrypoint;
- read-only resources versus writable user data;
- startup and shutdown ownership when required for beta correctness;
- production seed policy as a system-boundary decision;
- installer data-retention policy;
- version and application identity placement;
- beta-blocking lifecycle decisions;
- rejection of unrelated architectural expansion.

Primary output:

```text
DEV_STAGE/C_DESIGN.md
```

## 6.5 Codex

Codex materializes only approved D/E/F instructions.

Codex does not decide:

- methodology;
- semantic promotion;
- unresolved architecture;
- seed policy;
- user-data retention policy;
- whether evidence is sufficient for beta acceptance.

Codex reports through:

```text
DEV_STAGE/G_OPS_CODEX.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/I_DSN_CODEX.md
```

---

# 7. Fractioned Inspection Plan

## Pass 1 — Current recovery and release state

Read:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
operational/10_OPERATIONAL_STATE.md
operational/04_TODO.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

Outcome:

- inherited facts;
- inherited validation debt;
- current decisions and non-decisions;
- no repository-wide inspection yet.

## Pass 2 — Packaging topology

Identify and inspect the exact current files responsible for:

- PyInstaller specification or build configuration;
- installer definition;
- application version metadata;
- icons and executable resources;
- dependency pins;
- build scripts or commands;
- startup logging;
- release output directories and exclusion rules.

Outcome:

- current packaging file map;
- source/frozen/installed dependency map;
- known toolchain prerequisites;
- drift between files and current application structure.

## Pass 3 — Runtime resource boundary

Inspect only relevant application files:

```text
main.py
app/main.py
app/core/config.py
app/core/database.py
app/database/schema.sql
app/database/seed.sql
```

Add other files only where a packaging or startup dependency requires them.

Outcome:

- resource resolution map;
- user-data path map;
- seed behavior;
- startup and error path;
- frozen runtime assumptions.

## Pass 4 — Desktop beta workflow

Inspect the current desktop composition and the minimum end-to-end workflows required for beta acceptance.

Outcome:

- exact human smoke-test path;
- writable and read-only surfaces;
- required refresh behavior;
- shutdown and reopen checks;
- no feature redesign.

## Pass 5 — Tests and historical evidence

Inspect:

- current automated packaging/runtime tests;
- current release scripts;
- relevant prior Cycle 05 build evidence;
- only the bounded commits necessary to distinguish still-valid configuration from stale material.

Historical evidence explains intent. It does not substitute for current Cycle 06 execution.

---

# 8. Required Functional Stage Content

## 8.1 A_OPERATIONAL completion criteria

A must contain:

1. current packaging and installer topology;
2. exact toolchain prerequisites;
3. current and target build commands;
4. source, frozen, and installed path behavior;
5. resource inclusion/exclusion matrix;
6. seed policy dependency and operational consequences;
7. database and WAL/SHM exclusion rules;
8. startup diagnostics plan;
9. executable validation plan;
10. installer compile and install plan;
11. shutdown, reopen, and lock validation;
12. upgrade/uninstall/reinstall data matrix;
13. failure recovery and cleanup commands;
14. risks classified as confirmed, suspected, blocked, or deferred;
15. exact proposed implementation work for D_OPS_STAGE.

## 8.2 B_DIDACTIC completion criteria

B must contain:

1. Cycle 06 concept spine;
2. prerequisite relations;
3. project examples tied to exact packaging files;
4. source versus frozen versus installed execution distinctions;
5. build artifact versus installer package distinctions;
6. configured versus validated release distinctions;
7. resource and user-data explanation;
8. startup/logging and lifecycle explanation;
9. learning material eligible for later KANBAN/glossary/checkpoint updates;
10. exact proposed documentation work for E_DDC_STAGE.

## 8.3 C_DESIGN completion criteria

C must contain:

1. current packaged-runtime architecture;
2. installer/runtime/user-data boundary;
3. application identity and version ownership;
4. startup and shutdown boundary analysis;
5. seed and uninstall policy decisions requiring human acceptance;
6. accepted stable architecture that implementation must preserve;
7. beta-blocking design decisions only;
8. explicit non-goals;
9. no redesign justified solely by file size or theoretical preference;
10. exact proposed implementation/documentation work for F_DSN_STAGE.

---

# 9. Main Reconciliation Gate

After A/B/C are complete, Main must reconcile them in:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

The Cycle 06 J stage must classify every material statement as:

```text
confirmed current implementation
validated current behavior
required beta change
human decision required
Design decision required
Operational validation required
historical evidence only
future-cycle proposal
```

Main must resolve:

- conflicting file maps;
- conflicting build or installer commands;
- differing seed assumptions;
- differing data-retention assumptions;
- source claims presented as runtime proof;
- desired architecture presented as current fact;
- documentation proposals presented as implementation requirements.

D/E/F may be finalized only after this gate.

---

# 10. Human Decisions Required Before Materialization

At minimum, Cycle 06 requires explicit human acceptance of:

## 10.1 Production seed policy

Classify every seed row as one of:

```text
required production baseline
optional first-launch default
example/demo data
local development fixture
excluded from beta package
```

The example Rice product must not enter the beta merely because `seed.sql` exists.

## 10.2 Uninstall data policy

Choose and document whether uninstall:

- preserves `%LOCALAPPDATA%/Markei/market.sqlite` by default;
- offers an explicit optional data-removal choice;
- removes data automatically.

Automatic removal must not be assumed.

## 10.3 Shortcut policy

Choose whether the installer creates:

- Start Menu entry;
- optional desktop shortcut;
- both.

## 10.4 Beta version identity

Approve:

- application display name;
- beta version string;
- executable name;
- installer name;
- publisher value;
- installation directory convention.

## 10.5 Transaction and shutdown blockers

Determine whether current non-atomic workflows or implicit shutdown ownership block beta release after direct validation.

Do not redesign them in advance merely because they are open questions. Do not ignore them if validation demonstrates release-impacting failure.

---

# 11. D/E/F Implementation Staging

After Main reconciliation and required decisions:

```text
D_OPS_STAGE.md
    exact application, build, packaging, installer, test, and validation changes

E_DDC_STAGE.md
    exact didactic/documentation changes required by the accepted Cycle 06 implementation

F_DSN_STAGE.md
    exact architecture and design-memory changes required by accepted decisions
```

Each implementation instruction must specify:

- exact target file;
- exact responsibility of the change;
- inputs and expected outputs;
- constraints and non-goals;
- validation command or human check;
- rollback or failure handling where relevant;
- which stage/report will carry evidence.

D/E/F must not contain broad exploratory reasoning that belongs in A/B/C or J.

---

# 12. Materialization Sequence

Preferred sequence:

```text
1. Packaging/runtime corrections
2. Seed and resource policy implementation
3. Startup diagnostics and version metadata
4. Automated source/runtime tests
5. PyInstaller executable build
6. Frozen executable validation
7. Installer compilation
8. Clean installation validation
9. Installed workflow validation
10. Reopen and persistence validation
11. Upgrade/uninstall/reinstall validation as accepted
12. G/H/I reports
13. Main and human reconciliation
```

A later step must not be reported complete when an earlier required gate is blocked.

Installer compilation may not be skipped merely because the executable works.

Installed validation may not be skipped merely because the installer compiles.

---

# 13. Validation Matrix

## Gate 1 — Source integrity

Required evidence:

- syntax/import validation passes;
- tests required by the changed surfaces pass;
- source desktop launches;
- isolated database initialization succeeds;
- current migration checks converge;
- no ordinary user data is touched by destructive tests.

## Gate 2 — Frozen executable

Required evidence:

- executable is generated from the approved configuration;
- executable launches outside the source working directory;
- MainWindow and all four public surfaces appear;
- `schema.sql` is discoverable;
- seed behavior matches accepted policy;
- live database is created or opened under the approved user-data path;
- live database, `-wal`, and `-shm` files are not bundled;
- startup failure produces inspectable diagnostics;
- executable closes and immediately reopens.

## Gate 3 — Installer compilation

Required evidence:

- installer toolchain is available;
- installer compiles without unresolved errors;
- installer metadata matches approved beta identity;
- required executable and resources are included;
- development-only content is excluded;
- uninstall data behavior matches the accepted policy.

## Gate 4 — Clean installation

Required evidence:

- install from the generated installer on a clean or controlled user-like environment;
- launch from installed shortcut or Start Menu entry;
- no source checkout or active Python environment is required;
- first launch creates or reuses the expected user-data directory;
- MainWindow is visible and usable;
- no working-directory dependency is observed.

## Gate 5 — Installed beta workflow

Human validation must exercise at least:

```text
launch
→ inspect Register / Lists / History / Settings
→ register a receipt or approved beta test record
→ verify Lists refresh and status modes
→ verify History refresh and persisted purchase
→ change an approved setting or store record
→ close normally
→ reopen
→ confirm persisted data and usable database
```

Any destructive or synthetic data test must use an approved isolated profile.

## Gate 6 — Lifecycle validation

Required evidence as accepted for the beta:

- deterministic or practically successful closure of every active repository connection;
- immediate database reopen;
- no retained lock preventing ordinary use;
- upgrade behavior tested if an upgrade package is in scope;
- uninstall behavior matches the accepted data policy;
- reinstall behavior is recorded;
- preserved data remains readable where preservation is expected.

## Gate 7 — Release acceptance

Required evidence:

- A/B/C and D/E/F correspond to the implemented scope;
- G/H/I correspond to the actual materialization;
- human validation results are recorded;
- blocked checks are absent or explicitly accepted as non-blocking by the human;
- Operational, Didactic, and Design checkpoints are reconciled;
- `00_PROJECT_STATE.md` is refreshed;
- `05_SESSION_LOG.md` records Cycle 06 outcome;
- the next `06_SESSION_SCHEME.md` no longer presents Cycle 06 as pending.

---

# 14. Primary Beta Acceptance Criteria

Cycle 06 may be classified as successful only when all required criteria below are met.

## Deliverable

- a named beta installer artifact exists;
- the installer contains a launchable Markei executable and required resources;
- artifact version and identity are recorded.

## Installation

- installer runs successfully in the target Windows environment;
- application can be launched through the installed entrypoint;
- installation does not depend on the source repository.

## Runtime

- MainWindow opens;
- Register, Lists, History, and Settings are usable;
- core write/read/refresh behavior works;
- user database is stored outside replaceable program files;
- approved seed policy is observed;
- startup errors are inspectable.

## Persistence

- a beta test record survives close and reopen;
- expected data survives the accepted install lifecycle;
- no live database or transient SQLite files are bundled as release resources.

## Shutdown

- normal application closure does not leave a release-blocking lock or unusable database;
- immediate reopen succeeds;
- any remaining lifecycle limitation is explicitly classified and accepted.

## Methodology

- functional stages are complete;
- Main reconciliation precedes implementation staging;
- D/E/F match implemented scope;
- G/H/I match actual materialization;
- human validation is recorded;
- domain checkpoints and Main-root continuity are refreshed in order.

A partial result must be classified accurately:

```text
executable built but installer blocked
installer compiled but install unvalidated
installed launch works but workflow incomplete
workflow works but lifecycle unresolved
beta accepted
```

Only the final classification closes the stated Cycle 06 milestone.

---

# 15. Blocker Policy

A blocker must include:

- exact failed gate;
- exact command or human action;
- exact observed result;
- expected result;
- relevant logs or artifact evidence;
- owner of the next action;
- whether the blocker prevents executable, installer, installed workflow, or release acceptance.

Examples:

```text
installer compiler unavailable
    blocks installer compilation
    does not prove installer configuration incorrect

frozen executable cannot find schema.sql
    blocks frozen runtime acceptance
    requires resource-path or bundling correction

installed application cannot reopen database after close
    blocks lifecycle and beta acceptance

example seed data appears on production first launch
    blocks accepted seed policy
```

Blocked work must not be silently reclassified as deferred if it is required by the primary beta definition.

---

# 16. Recovery Warnings

## 16.1 Exact branch and path

All reads and writes must remain pinned to the active Cycle 06 branch selected by the human.

Do not infer branch absence from connector branch-search failure when exact-ref reads work.

## 16.2 Authorized staging files only

Use only:

```text
DEV_STAGE/A_OPERATIONAL.md
DEV_STAGE/B_DIDACTIC.md
DEV_STAGE/C_DESIGN.md
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
DEV_STAGE/G_OPS_CODEX.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/I_DSN_CODEX.md
[M]_STAGE/J_[M]_STAGE.md
```

Do not create alternate retrospective, track-record, sprint, or duplicate stage filenames without methodology revision and human authorization.

## 16.3 Generated files

Generated build and installer outputs are evidence and deliverables, not notebook canon.

Do not commit transient caches, live databases, WAL/SHM files, temporary isolated profiles, or unreviewed build output merely to prove that a build ran.

## 16.4 Historical evidence

Cycle 05 packaging evidence may reduce exploratory cost, but every release claim required by Cycle 06 must be revalidated against the contemporary branch and artifact.

## 16.5 No status inflation

```text
source inspected
≠ configured
≠ built
≠ launched
≠ installed
≠ validated
≠ accepted beta
```

---

# 17. Initial Cycle 06 Session Sequence

```text
1. Main confirms the Cycle 06 working branch and exact repository state.

2. Main prepares bounded prompts for [O], [A], and [D].

3. Domain chats read checkpoints first and inspect packaging/runtime files fractionally.

4. A/B/C are completely refreshed for Cycle 06.

5. Main compares A/B/C and refreshes J as the Cycle 06 reconciliation reference.

6. Human resolves seed, uninstall-data, identity, shortcut, and any beta-blocking lifecycle decisions.

7. Main prepares complete D/E/F implementation stages.

8. Codex materializes approved changes.

9. Codex records G/H/I against the same materialization.

10. Operational and human validation proceed through source, frozen, installer, installed workflow, and lifecycle gates.

11. Main reconciles evidence and requests domain checkpoint updates.

12. Main refreshes 00, appends 05, and prepares the next 06.
```

---

# 18. Session Exit Condition

This forward checkpoint has fulfilled its purpose when Cycle 06 has either:

## Successful closure

```text
fully executable Windows beta
+
compiled installer
+
clean installation
+
installed workflow validation
+
accepted persistence and uninstall lifecycle
+
complete A–J evidence chain
+
reconciled permanent memory
```

or:

## Explicit blocked closure

```text
precise blocking gate
+
reproducible evidence
+
accurate partial-outcome classification
+
no false beta-complete claim
+
continuity scheme for the next bounded session
```

The preferred and active target remains successful closure.

---

# 19. Immediate Next Action

The next action is not implementation.

It is:

```text
confirm the Cycle 06 working branch
→ inspect current packaging topology in bounded passes
→ issue role-specific Cycle 06 prompts
→ refresh A/B/C completely
```

Only after A/B/C reconciliation and required human decisions may D/E/F authorize materialization.
