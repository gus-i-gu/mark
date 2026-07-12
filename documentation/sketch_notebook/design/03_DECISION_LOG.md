# 03_DECISION_LOG.md

> Version: 0.3-cycle06-sprint02
> Status: Active Observational Record
> Persistence Class: Observational History
> Knowledge Class: Design History
> Authority: Design Chat [D]
> Scope: Chronological Design-domain decisions, reconciliation events, materializations, corrections, and deferred boundaries
> Current Coverage: Recovery repopulation through Cycle 06 Sprint 02 installed-lifecycle evidence

---

# 1. Purpose and Reading Rule

This file records what happened in the Design domain and why. It is append-oriented observational history; it does not independently define current architecture.

For current truth, read:

```text
Canonical architecture
    design/01_ARCHITECTURE.md

Derived architecture map
    design/14_MODEL_OVERVIEW.md

Current checkpoint
    design/09_DESIGN_STATE.md
```

Earlier events remain historical even when later events revise current architecture.

---

# 2. Recovery Repopulation Record

## Event 01 — Methodology boot and empty-domain detection

The recovery began after permanent Design files had been intentionally pruned. Domain Symmetry assigned:

```text
C_DESIGN.md          functional reasoning
01_ARCHITECTURE.md   canonical knowledge
14_MODEL_OVERVIEW.md derived knowledge
09_DESIGN_STATE.md   checkpoint
03_DECISION_LOG.md   observational history
```

Application source was evidence, not automatic canon.

## Event 02 — Initial structural review

Repository inspection recovered the application direction:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

MainWindow was identified as desktop composer and coordinator; ProductService as application facade; Repository as persistence facade; and Database Manager as lifecycle owner.

Functional staging commits:

```text
0c7143e13cd27e1b6a20506cadf045631e2eeeae
    Stage initial design recovery review

3f40e25109ede1501541fa8eefce84465dcb47bd
    Consolidate design structural recovery
```

## Event 03 — Lifecycle and transaction constraints clarified

All four public pages were confirmed to create separate ProductService → Repository → SQLite connection chains. Cleanup capability existed locally, while application-wide shutdown ownership was distributed and implicit.

Receipt registration and purchase deletion/recalculation were confirmed as multi-commit workflows. This was recorded as current implementation property, not accepted future target architecture.

## Event 04 — Main-stage routing correction

The initial lookup used obsolete path:

```text
[M]_STAGE/J_MAIN_STAGE.md
```

The human-corrected authoritative path was:

```text
[M]_STAGE/J_[M]_STAGE.md
```

A concurrent content-SHA conflict was also handled by re-reading before writing. These events established that exact stage paths and current blob SHAs are part of reconciliation safety.

Corrective staging commit:

```text
65199e4e3d02541fc4f25f9f677e307c40447973
    Stage initial design canon candidate
```

## Event 05 — Canonical, derived, and checkpoint repopulation

Main reconciliation authorized stable current architecture while excluding unresolved future targets.

Permanent Design materialization:

| Commit | Result |
| --- | --- |
| `4431a25c8365e0c847c4c97b2775a90eda21ea0b` | Canonical architecture repopulated |
| `b019063163e45dc72ffb04a9010483a035e858e2` | Derived model overview repopulated |
| `32a6834ef845280ed372c518ddcf1edb1e4e2112` | Design checkpoint rebuilt |

Temporary retrospective staging:

```text
ec9a1b6dc5d5252e1031e0890a468ecc38321b55
    Stage design checkpoint retrospective
```

The failed Cycle 05 precedent was classified as cycle-control and knowledge-routing overload, not proof that the layered application architecture had failed.

## Event 06 — Recovery decisions and deliberate non-decisions

Recovery established:

1. functional stages remain temporary reasoning surfaces;
2. Main reconciliation filters what may enter permanent memory;
3. canon stores accepted stable architecture;
4. the overview reorganizes canon without independent truth;
5. the checkpoint stores current state and active tensions;
6. this log stores chronology and rationale.

The recovery deliberately left open shared versus page-local services, shutdown ownership, workflow atomicity, ProductService/Repository decomposition, complete contracts, typed projections, migration versioning, Promotion status, `pages.order`, and Product's long-term hybrid role.

---

# 3. Event 07 — Cycle 06 Primary-Beta Design Reconciliation

## Context

Cycle 06 established one milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Functional A/B/C reports were reconciled in `J_[M]_STAGE.md`. Main authorized one bounded release-enablement unit without broad application redesign.

## Policy decisions accepted before materialization

### Schema-only production initialization

Decision:

```text
production package includes schema.sql
production package excludes sample-bearing seed.sql
fresh production data contains structural/default settings only
no sample store, category, product, purchase, or business fixture ships
```

Rationale: bundled sample data would blur application resources, development fixtures, and user-owned state.

### Preserve-user-data uninstall policy

Decision:

```text
uninstall removes replaceable program files and shortcuts
uninstall preserves %LOCALAPPDATA%/Markei by default
```

Rationale: the database and settings are user-owned writable state, not installer-owned replaceable content. Optional data-deletion UX was deferred.

### Coordinated release identity

Decision:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Stable AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Target: Windows x64 controlled beta
```

Rationale: executable, package, installer, shortcuts, and compatible upgrades require one stable identity contract.

### Authoritative PyInstaller specification

Decision:

```text
Markei.spec
    authoritative package composition

scripts/build_windows.ps1
    invocation wrapper only
```

Rationale: duplicated command flags and spec contents had created two drifting package definitions.

### Shortcut policy

Decision:

```text
Start Menu shortcut required
desktop shortcut optional installer task
```

Rationale: Start Menu launch is part of ordinary installed use; desktop placement remains user choice.

### Validation-first shutdown policy

Decision:

```text
validate distributed cleanup first
add only a bounded close coordinator if direct evidence fails
```

Rationale: distributed lifecycle ownership was a structural concern, not yet proof of a leak or retained lock.

---

# 4. Event 08 — Cycle 06 Sprint 01 Materialization Evidence

## Source boundaries materialized

Codex materialized:

- root `main.py` as launcher and outer startup-diagnostic boundary;
- `app.main.main()` unchanged as Qt application construction;
- `Markei.spec` as authoritative one-folder package definition;
- `scripts/build_windows.ps1` as the invocation wrapper;
- `installer/Markei.iss` as placement, identity, shortcuts, and uninstall-registration source;
- `scripts/build_installer.ps1` as compiler-discovery and compile wrapper;
- external startup logs under `%LOCALAPPDATA%/Markei/logs`;
- schema-only production packaging and exclusion of writable/transient state.

## Frozen evidence

Operational evidence recorded:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
validated: partial
```

Source/static checks, five standard-library release tests, frozen build, resource inspection, schema-only first launch, startup-log creation, and frozen reopen passed.

## Observed shutdown failure and bounded correction

The validate-first probe showed the isolated SQLite file remained open after `MainWindow.close()`. Codex added `MainWindow.closeEvent()` and `close_page_services()` to idempotently close Register, Lists, History, and Settings services.

Rerun evidence showed all four repositories closed and the isolated database directory became removable.

Design classification:

```text
MainWindow coordinates final closure
local service/repository close ownership remains intact
not a composition-root redesign
not dependency injection
```

## Installer blocker

`installer/Markei.iss` and `scripts/build_installer.ps1` were configured, but `ISCC.exe` was unavailable.

```text
installer source: configured
compiled installer: blocked
installed execution: blocked
installed lifecycle: unvalidated
beta acceptance: no
```

---

# 5. Event 09 — Sprint 01 Main Post-Codex Reconciliation

Main reviewed G/H/I and critical implementation files in commit:

```text
f402c9394d3401ef8c2df5696d052b18358758dc
    Reconcile Cycle 06 Codex materialization evidence
```

Main accepted the bounded unit as technically successful but insufficient to close Cycle 06.

Accepted Design absorption:

- deployment states remain distinct;
- launcher-owned startup diagnostics are stable;
- `schema.sql` is production resource and `seed.sql` is fixture-only;
- retained user data remains external;
- release identity and stable AppId form one contract;
- MainWindow final service-close coordination is accepted;
- packaging and installer layers do not own workflows or persistence semantics.

Preserved evidence boundary:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

---

# 6. Event 10 — Sprint 02 Installer Toolchain and Structural Defaults

## Installer compiler discovery

Inno Setup 6.7.3 was installed in a per-user location. The original wrapper did not discover that path.

Bounded correction:

```text
scripts/build_installer.ps1
→ add %LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe candidate
```

Design classification: tooling correction only. Packaging authority and installer authority remained unchanged.

## Structural production defaults

The fresh installed Register-equivalent workflow failed with a foreign-key error because the seed-free database lacked current Register defaults.

Bounded correction:

```text
category F / General
store 1 / Default Store
```

These rows were classified as idempotent structural application defaults, not sample business data. Production continued to exclude `seed.sql` and to create zero sample products and purchases.

This refined the earlier schema-only policy without reversing it:

```text
schema.sql
+ structural defaults required by current application invariants
+ zero sample business records
```

---

# 7. Event 11 — Sprint 02 Compiled Installer and Installed Lifecycle

## Artifact and build evidence

The installer compiled successfully:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

The Inno `x64` deprecation warning was recorded as non-blocking tooling debt.

## Installed boundary evidence

The following transitions passed technically:

```text
per-user install
→ installed executable under %LOCALAPPDATA%/Programs/Markei
→ Start Menu shortcut launch
→ external database creation
→ service-backed Register / Lists / History / Settings evidence
→ close and immediate reopen
→ same-version reinstall with preserved data
→ uninstall with retained database
→ reinstall with retained-data recovery
```

Observed installed behavior matched the accepted separation between replaceable program files and `%LOCALAPPDATA%/Markei` user state.

The installed shutdown path used the existing MainWindow close coordination successfully. No broad architecture correction was required.

## Validation environment

The lifecycle used the current ordinary Windows user. Existing Markei data was backed up before testing and restored afterward. Dedicated-account isolation was not evidenced.

## SmartScreen and signing

Defender was enabled and the executable/installer were unsigned. No SmartScreen prompt appeared during silent/programmatic execution.

Design classification:

```text
human-visible SmartScreen behavior: unknown
not an application correctness failure
```

---

# 8. Event 12 — Sprint 02 Main Post-Codex Reconciliation

Main reconciled Sprint 02 G/H/I and implementation evidence in the active `J_[M]_STAGE.md`.

Accepted evidence state:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Main preserved the distinction:

```text
installed technical workflow path: validated
human-visible UI workflow acceptance: pending
```

Still pending:

- human-visible installer wizard observation;
- human-visible Register / Lists / History / Settings walkthrough;
- human-visible close/reopen confirmation;
- human-visible SmartScreen/security observation;
- final Main/human acceptance;
- artifact-versioning policy resolution.

Main also identified a report/repository contradiction: G described the installer artifact as generated but uncommitted, while branch evidence showed it added. Design records the contradiction but does not decide artifact retention policy.

---

# 9. Explicit Deferrals Preserved

Cycle 06 did not introduce or authorize:

- composition-root or dependency-injection redesign;
- ProductService/Repository decomposition;
- transaction redesign;
- schema redesign or migration ledger;
- mobile, backend/API, synchronization, authentication, or cloud persistence;
- automatic update, signing, rollback framework, or one-file packaging;
- optional uninstall data-deletion UX;
- broad UI/navigation redesign.

Workflow atomicity and broader migration strategy remain inherited Design debt.

---

# 10. Current Observational Result

```text
compiled installer evidenced
installed per-user lifecycle technically validated
structural defaults classified
program/user-state separation observed
same-version reinstall passed
uninstall retention passed
reinstall recovery passed
MainWindow shutdown coordination sufficient in tested installed lifecycle
human-visible acceptance still pending
beta not accepted
Cycle 06 not closed
```

The next append should record human-visible acceptance results, SmartScreen/security observations, artifact-policy resolution, or a bounded failure discovered during those final gates.

---

# 11. Event 13 — Cycle 07 Sprint 01 Mobile Portability Reconciliation

## Knowledge classification

Cycle 07 Sprint 01 completed investigation only. Cycle 06 remains accepted and closed. No application change, framework selection, repository-topology decision, or D/E/F implementation authorization occurred.

The portability inventory established observationally:

- domain dataclasses are platform-neutral and likely reusable where Python runs;
- substantial validation, calculation, and workflow meaning is UI-framework-neutral;
- `ProductService` remains coupled because it constructs the concrete `Repository`;
- Repository construction opens SQLite through desktop-shaped path, resource, connection, commit, and shutdown behavior;
- Python abstract contracts express responsibilities but are not language-neutral contracts;
- PySide6 presentation, page-owned service construction, MainWindow shutdown coordination, and Windows packaging are desktop-specific;
- mobile runtime, sandbox persistence, suspend/resume, Android/iOS packaging, accessibility, and semantic parity remain untested.

## Competing pathways and development-cost models

### Operational challenger — time-boxed Python-native Android experiment

Approach A remains the cheapest bounded way to test direct source reuse. Its initial implementation can be smaller because models, calculations, validations, and perhaps service workflows stay in Python. If it works cleanly, it avoids immediate behavior reimplementation and yields fast Android evidence.

That saving is conditional. Toolchain setup may require Linux or WSL, SDK/NDK/JDK layers, framework packaging recipes, emulator/device work, and mobile-safe resource and database paths. Cost can move into runtime compatibility, lifecycle handling, native integration, accessibility, packaging diagnosis, and framework-specific debugging. Android success would not establish iOS parity: iOS adds macOS/Xcode and a distinct Python packaging path. If the experiment fails late, its construction seams and packaging work may have little lasting product value, although recorded fixtures and failure evidence remain reusable.

Classification:

```text
bounded falsification challenger
not accepted long-term architecture
```

A future spike should stop when mobile SQLite/core behavior, lifecycle safety, packaging, accessibility, or required construction changes cease to be bounded.

### Design strategic candidate — native/cross-platform client with contracts and fixtures

Approach C costs more initially. Stable behavior must be described in language-neutral commands, results, invariants, error cases, and deterministic fixtures; mobile behavior must then be partly reimplemented. Direct Python source reuse is lower, and maintaining semantic parity requires deliberate tests.

That early cost may reduce long-term cost through conventional Android/iOS tooling, explicit application lifecycle and persistence ownership, platform-appropriate presentation, mature accessibility and native integration, clearer debugging boundaries, and framework-independent semantic fixtures. Fixtures make drift observable instead of relying on two implementations merely looking similar. A mobile-local repository boundary also leaves a clearer future synchronization seam without requiring a backend now. Abandoning one unsuccessful C-family framework still loses UI/toolchain work, but language-neutral contracts and fixtures remain usable by another client.

Classification:

```text
favored strategic architecture candidate
framework not selected
implementation not authorized
```

## Human/Main preference

Human/Main currently favors Approach C as the strategic direction. This is stronger than a neutral list of alternatives: planning and documentation should treat contract/fixture specification and explicit mobile ownership as the leading direction. It is weaker than final acceptance: no framework, repository topology, persistence library, schema-sharing policy, or implementation structure is selected. The preference does not authorize implementation, does not erase Approach A as a bounded challenger, and remains revisable when empirical evidence arrives.

## Evidence required before acceptance

Acceptance still requires:

1. deterministic scenarios for first purchase, repeat purchase, status transition, invalid input, structural defaults, atomic registration, and close/reopen persistence;
2. a language-neutral contract boundary excluding presentation labels and formatting;
3. evidence of sandboxed local persistence and lifecycle ownership on Android;
4. an explicit iOS feasibility and parity gate using macOS/Xcode;
5. accessibility, navigation, native integration, packaging, debugging, and migration evidence for a selected framework;
6. a measured comparison of fixture-driven reimplementation cost against a strictly time-boxed direct-reuse spike;
7. confirmation that ordinary desktop data is never accessed;
8. Main/human acceptance after evidence reconciliation.

## Deferrals

Deferred: application implementation, D/E/F, framework and repository-topology selection, permanent source reorganization, backend, authentication, synchronization, household sharing, desktop/mobile database exchange, production migration design, store release, and full feature parity.


---

# 12. Event 14 — Cycle 07 Sprint 02 Flutter Shared-Beta Reconciliation

## Client-language supersession

Human/Main accepted Flutter/Dart as the planning basis for the future shared Windows, Android, and iOS client. This superseded the earlier TypeScript-client exploration direction while retaining TypeScript as the favored custom synchronization-API language.

Rationale: one Dart/Flutter client can own presentation, use cases, local persistence, event queue, synchronization coordination, authenticated session, platform lifecycle, and analytics without embedding Python or coordinating multiple installed client runtimes. Python/PySide6 remains the accepted Cycle 06 implementation, behavioral reference, migration source, and rollback.

Retained alternatives are evidence controls rather than active client directions. TypeScript remains valuable at the API boundary; Python remains a possible API fallback. Exact Flutter persistence, secure storage, state-management, navigation, and packaging dependencies remain unvalidated.

## Catalogue and purchase direction

The first shared beta adopts an account-private reusable catalogue. Product identity distinguishes PACKAGED and BULK modes and uses normalized name, brand, and—when packaged—explicit dimensional package amount/unit. Exact normalized equivalence may reuse; fuzzy similarity warns but never merges automatically. Deterministic account-scoped Product UUID derivation and normalization-v1 mechanics remain provisional pending cross-language fixtures.

Purchase is an atomic aggregate containing one or more Purchase Items. The first UI may guide one item, but the domain contract remains multi-item capable. One append-only `purchase.registered` event containing immutable item lines is the favored first synchronized event.

Dimensional quantity separates MASS/KG, VOLUME/L, and COUNT/UNIT without mass/volume inference. Money carries explicit currency and integer minor units. Line totals and purchase observations are authoritative; normalized prices, price changes, personal inflation/deflation, forecasts, and other analytics are derived.

## Analytics, synchronization, and cloud direction

The Flutter client owns a versioned Dart analytics registry. Stable algorithm identifiers and versions preserve reproducibility; raw facts are never rewritten by analytical evolution.

Synchronization planning accepts event UUID idempotency, device UUID plus monotonic sequence, occurrence time as business time, opaque account-scoped cursor as download order, sequence-gap rejection, per-event upload transactions/results, cursor-zero bootstrap, and transactional local event application plus cursor advancement.

The mandatory boundary is:

```text
Flutter client
→ authenticated custom synchronization API
→ Neon Postgres
```

The TypeScript API owns token verification, account/device authorization, runtime validation, idempotent event append, sequence enforcement, cursor allocation/download, protocol versions, transactions, stable errors, and diagnostics. Neon owns managed persistence and constraints, not synchronization meaning. RLS remains an open defense-in-depth candidate.

## Migration and rollback policy

Transition is additive. The accepted PySide6 beta and original database remain protected until Flutter desktop/mobile parity and human/Main acceptance. Migration operates from a protected copy, uses deterministic legacy-to-UUID mapping and idempotent import evidence, reports ambiguous units/money/package facts instead of guessing, validates counts/totals/dates/projections, and retains rollback. Direct destructive conversion or shared access to the ordinary Cycle 06 database is not authorized.

## Explicit deferrals and empirical questions

Deferred: purchase editing/deletion, aliases/merges, global catalogue, household sharing, product-family/successor UI, complex conflicts, realtime/background sync, broad settings synchronization, app-store/public release, permanent repository split, and PySide6 retirement.

Still empirical or open: Flutter persistence and secure-storage plugins; state management/navigation; auth provider; API framework/runtime/host; Postgres migration tool; canonical JSON toolchain; exact decimal scale/range; fractional COUNT; currency metadata; normalization migration; legacy ambiguity policy; RLS; paging limits; queue-corruption recovery; iOS/macOS evidence; and parity threshold.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
