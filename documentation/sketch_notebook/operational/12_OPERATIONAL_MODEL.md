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
