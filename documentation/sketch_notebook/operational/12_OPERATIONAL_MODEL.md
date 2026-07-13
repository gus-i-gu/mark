# 12_OPERATIONAL_MODEL.md

> Version: Cycle 07 synchronization safety reconciliation 0.5
> Status: Canonical operational knowledge
> Persistence Class: Canonical
> Knowledge Class: Operational
> Branch: `cycle-07-mobile-preparation`
> Authority: Operational Chat under Main reconciliation
> Reconciliation sources: `DEV_STAGE/D_OPS_STAGE.md`, `DEV_STAGE/G_OPS_CODEX.md`, `[M]_STAGE/J_[M]_STAGE.md`

---

# 1. Purpose

This file defines stable Operational knowledge for Markei execution, packaging, persistence, diagnostics, installer production, and release validation. Current work belongs in `04_TODO.md`; current evidence state belongs in `10_OPERATIONAL_STATE.md`; chronology and artifact hashes belong in `11_OPERATIONAL_RECORD.md`.

# 2. Runtime and Persistence Boundary

Markei remains a local PySide6 desktop application backed by SQLite:

```text
main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

Writable user state and diagnostics remain external to replaceable application files:

```text
%LOCALAPPDATA%/Markei/market.sqlite
%LOCALAPPDATA%/Markei/logs/startup.log
```

A live database, WAL/SHM companions, logs, caches, tests, and sample fixtures are not valid production package or installer content.

# 3. Production Initialization Policy

The production package includes `app/database/schema.sql` and excludes `app/database/seed.sql`.

Fresh or compatible databases receive idempotent structural application defaults through database compatibility handling:

```text
category F / General
store 1 / Default Store
required settings defaults
```

These rows are required application structure, not demonstration business data. Production initialization must retain zero sample products and zero sample purchases. Structural defaults must be inserted without overwriting compatible user choices.

# 4. Packaging and Installer Authority

`Markei.spec` is the authoritative one-folder PyInstaller definition. `scripts/build_windows.ps1` is its invocation and clean-build wrapper; it must not redefine package composition independently.

`installer/Markei.iss` is the installer authority. `scripts/build_installer.ps1` locates and invokes Inno Setup; supported compiler discovery includes:

```text
explicit -ISCCPath
→ ISCC_PATH environment variable
→ per-user %LOCALAPPDATA%/Programs/Inno Setup 6/ISCC.exe
→ standard Program Files locations
```

Operational dependencies are phase-specific:

```text
build time      Python + PyInstaller + PySide6
runtime         frozen Markei distribution
installer time  Inno Setup / ISCC.exe
```

An installer-time dependency is not required by the installed application.

# 5. Evidence Ladder

Use these statuses precisely:

```text
configured
built
launched
installed
validated
accepted
blocked
unknown
```

The release ladder is:

```text
configuration materialized
→ frozen artifact built and inspected
→ frozen artifact launched
→ installer compiled and inspected
→ application installed
→ installed shortcut launch
→ technical workflow path validated
→ close/reopen and persistence validated
→ reinstall/uninstall/recovery validated
→ human-visible workflow and security observations
→ Main/human acceptance
```

Evidence from one gate does not prove a later gate. Automated ProductService/database evidence validates the technical workflow path but does not replace a human-visible UI walkthrough. Silent or programmatic execution does not establish human-visible SmartScreen behavior.

# 6. Installed Lifecycle Rules

The primary beta installer consumes the built one-folder distribution and installs per user under `%LOCALAPPDATA%\Programs\Markei`, with a Start Menu shortcut and optional desktop shortcut. Writable state remains under `%LOCALAPPDATA%\Markei`.

The accepted technical lifecycle route is:

```text
install
→ Start Menu launch
→ create and read application data
→ close and immediate reopen
→ same-version reinstall
→ uninstall while retaining user data
→ reinstall and recover retained compatible data
```

Validation may use the current ordinary Windows user only when existing data is backed up, test state is isolated sufficiently to avoid ambiguity, and the original state is restored. This proves ordinary per-user semantics; it does not prove dedicated-account isolation.

# 7. Startup and Shutdown Boundaries

The root executable entrypoint owns startup exception diagnostics. Unhandled startup exceptions must produce a failing process result, write an inspectable UTF-8 per-user log, and show a concise visible error when Qt permits.

Normal MainWindow composition owns final coordination of the four page-owned service/repository chains:

```text
MainWindow.closeEvent()
→ close Register, Lists, History, and Settings services idempotently
→ close repositories and SQLite connections
```

Stable correction rule:

```text
validate the lifecycle gate
→ classify the demonstrated failure
→ make the smallest bounded correction
→ rerun the failed and dependent gates
```

# 8. Database and Transaction Safety

Every Repository must have an identifiable owner and deterministic close path. Validation that initializes, migrates, resets, corrupts, or injects failure must protect ordinary user data and close all connections before cleanup.

Repository mutations commit individual persistence operations. Receipt registration and purchase deletion/recalculation remain non-atomic as complete workflows. Workflow atomicity is inherited Operational debt and is not resolved by successful packaging or installed-lifecycle validation.

# 9. Release Artifact Policy

Generated frozen distributions and installer executables are reproducible release outputs, not source truth. Operational policy is:

```text
source repository
    version packaging definitions, scripts, tests, and metadata

release evidence
    record artifact path, size, cryptographic hash, toolchain, and commands

release delivery
    publish binaries through an approved release/artifact channel
    do not retain generated binaries as ordinary source-controlled files
```

The current branch contains `dist/installer/Markei-Setup-0.1.0-x64.exe`, despite the Sprint 02 G report describing it as uncommitted. This is repository drift. Removing the binary and adding an ignore rule require a separately authorized repository-cleanup change; documentation reconciliation must not alter the artifact.

# 10. Non-Blocking Toolchain Debt

Inno Setup currently accepts `x64` while warning that it is deprecated in favor of `x64compatible`. The warning is non-blocking for the evidenced build but remains bounded installer-maintenance debt.

# 11. Acceptance Boundary

Technical installed-lifecycle validation does not grant beta acceptance. Final acceptance still requires human-visible installer and principal UI walkthrough evidence, normal close/reopen confirmation, human-visible SmartScreen or antivirus observations, and Main/human approval.

# 12. Shared-Client Synchronization Safety Rules

These rules are technology-independent and apply to any later shared-client implementation.

## 12.1 Privileged database credentials

Distributed clients must never contain privileged shared-database credentials. All shared reads and writes pass through an authenticated and authorized service boundary that validates account ownership, protocol version, payload, and operation.

## 12.2 Atomic local fact creation

When a user action creates local authoritative facts and an outbound synchronization event, the facts, event identity, queue state, and local ordering metadata must commit in one transaction:

```text
all durable together
or
none durable
```

A successful UI response must not leave authoritative facts without their required outbound event, or a queued event without its corresponding local facts.

## 12.3 Atomic downloaded-event application

Downloaded accepted events, applied-event identity records, affected authoritative facts, and the local server-cursor advancement must commit in one local transaction. The cursor must never advance beyond facts that were durably applied.

## 12.4 Unknown network outcomes

A lost response creates an unknown outcome, not a known failure. Clients retain pending work and retry with the same immutable event identity. The service must make identical retry safe and reject conflicting content under an already accepted identity.

## 12.5 Local proof before production infrastructure

Synchronization semantics, authorization isolation, transactions, retries, ordering/cursors, migrations, restart recovery, and diagnostics must first pass against disposable local infrastructure. Production or managed infrastructure is introduced only after the local protocol boundary is evidenced.

## 12.6 Migration rehearsal and recovery

Every supported migration path must be rehearsed against fresh state and representative prior state. A failed migration must preserve the prior valid state or a recoverable copy. Deployment and rollback procedures must define compatibility order, backups/recovery, diagnostics, and forward correction; destructive reversal is never assumed safe.

## 12.7 Accepted desktop-data isolation

New clients and experiments use distinct application-private storage and must not open, copy, mutate, or destructively convert accepted desktop user data without a separately authorized migration procedure. The accepted application and data remain recoverable until explicit parity and migration acceptance.

# 13. Canonical Maintenance Rule

Update this model only when stable Operational behavior or reusable validation rules change. Current hashes, command transcripts, temporary blockers, and chronological corrections belong in the record, checkpoint, or TODO.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
# Generated-Source and Cross-Platform Evidence Rules

## Generated-source ownership

Generated source is not reviewed as if every generated line were handwritten. Operational ownership is:

```text
review generator inputs, schema and configuration
→ pin generator/runtime dependencies
→ regenerate cleanly
→ verify no unexplained diff
→ run static analysis, tests and target builds
```

Committed lockfiles record resolved dependency state. Build outputs and local runtime databases remain excluded unless a separate artifact policy explicitly owns them.

## Target generation is not platform validation

Creating platform project directories proves only that scaffolding was generated. A platform claim requires its target host/toolchain, successful build, launch, lifecycle behavior, persistence behavior, and relevant packaged-plugin validation. Evidence from one platform does not validate another.

## Durable monotonic sequence rule

A per-device sequence used for synchronization must be allocated durably, must not reset during ordinary registration, and must be uniquely constrained within its account/device responsibility. Repeated-operation and recovery tests are required before ordering depends on it.

## Versioned canonical identity rule

When normalized identity affects stable identifiers across runtimes:

- display text remains separately preserved;
- normalization is explicitly versioned;
- Unicode, locale, whitespace, punctuation, dimension/unit, and canonical numeric rules are specified;
- fixed fixtures prove equivalent output across participating runtimes;
- rule changes require a migration policy rather than silent reinterpretation.

## Contract-example boundary

Human-readable JSON examples coordinate semantics but do not become a complete wire contract until required types, ranges, nullability, enums, unknown-field behavior, timestamp/decimal form, version compatibility, valid/invalid examples, and runtime validation are defined and tested.

# Sprint-Gated Host and Migration Rules

## Explicit host-mutation authority

Installing or modifying platform toolchains is a host mutation and requires an implementation stage that names the exact product, workload or component, permitted version boundary, invocation method, expected validation, failure handling, and stop condition. Planning acceptance alone is insufficient authority. Post-install evidence must distinguish tool presence, target detection, build success, launch success, and lifecycle validation.

## Identity-bearing migration safety

When a local schema introduces a user-facing code, normalized key, or new internal identity role, migration must preserve every existing primary/foreign-key relationship. Missing human-authored values may receive an explicitly temporary, account-unique bootstrap value, but migration must not invent product meaning. Temporary values remain identifiable for later review.

## Structural schema validation boundary

Executable schema validation proves payload structure only. Domain invariants, normalization equivalence, transaction behavior, cross-runtime semantic parity, and lifecycle persistence require separate tests. Readable valid and invalid examples remain part of the operational evidence set alongside the machine validator.

# Android Runtime Evidence and Host-Recovery Rules

## Gate-specific platform classification

Android evidence must be classified independently as:

```text
tool installed
doctor validated
runtime recognized
artifact built
artifact installed
process launched
workflow human-observed
app-private persistence observed
lifecycle matrix completed
physical-device validated
release/distribution validated
```

A later gate is never implied by an earlier one. Emulator execution does not prove physical-device compatibility; debug execution does not prove release signing, upgrade, backup, accessibility, or store distribution.

## Lifecycle checklist closure

When a stage's acceptance criteria name keyboard, Back, rotation, background/resume, text scale, process restart, or staged-state behavior, closure requires an explicit result for each named gate. Build, widget tests, database inspection, and a single manual workflow may establish partial lifecycle evidence but cannot silently stand in for the missing checklist. A supplemental checklist should remain evidence-only unless it exposes a bounded defect requiring separately authorized correction.

## SDK and AVD recovery

Installed SDK packages and virtual devices are reproducible host dependencies, not repository source. Operational evidence must record the selected Flutter SDK, Android SDK root, installed package identifiers/versions, system image, AVD definition, license state, and doctor result.

Recovery uses the recorded manifest and supported SDK/AVD tools. Cleanup requires separate authority, an inventory first, and named-component removal. Never delete an entire SDK root, unrelated AVDs, IDE configuration, or alternate Flutter SDK merely because one sprint no longer needs them. Host storage cost is reported from measured evidence; component type alone does not justify a numeric claim.

## Repository/report scope reconciliation

A materialization report's changed-file claim must be checked against the committed comparison. If repository truth contains an extra configuration file, preserve the contradiction observationally and classify ownership before cleanup. A harmless or generated-looking file is not automatically intentional, and a report statement does not override the commit.

## Workflow terminology

Operational reports name the executed domain operation. Current Markei behavior registers a new immutable Purchase aggregate. “Purchase upsert” is unsupported unless implementation explicitly provides update-or-insert semantics for Purchase identity.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

# Cycle 08 Product-Beta Operational Rules

## Evidence separation for shared-client targets

For each target, classify independently:

```text
source implemented
→ automated tests validated
→ artifact built
→ process manually launched
→ principal workflow manually accepted
→ lifecycle matrix accepted
→ release/distribution accepted
```

A Windows release build does not establish manual Windows runtime acceptance. A failed Android build caused by a missing host Java configuration leaves Android host-unvalidated; it is not an application failure and does not validate the target.

## Presentation-path coverage rule

Responsive widget evidence must state which width and workflow were exercised. Shell/empty-state coverage at phone width does not validate a long scroll-form registration path unless that path is executed at the same constraints. Manual host smoke remains separately required.

## Session mitigation versus durable idempotency

Disabling submission while one mounted request is in flight prevents ordinary repeated taps only. It does not establish safe retry after restart, an unknown outcome, or two equivalent command instances. Durable idempotency requires an accepted identity, uniqueness, identical/conflicting retry rules, persistence, and restart/concurrency tests.

## Generated validation-artifact rule

Python `__pycache__` and `.pyc` files are generated runtime artifacts, not source. Validation must not intentionally publish them as implementation. If already tracked, repository truth and the materialization report must record them; cleanup and ignore-policy changes require a bounded authorized hygiene change rather than silent deletion during reconciliation.

## Existing-reference edit regression rule

When a draft line references an existing durable Product, editing presentation fields must preserve that reference unless the user explicitly chooses replacement. Tests must cover existing Product selection, edit, save, review, and registration without accidental conversion to an empty/new Product draft.

