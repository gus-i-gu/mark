# 05_SESSION_LOG.md

> Version: Global history 0.5
> Status: Active Global Observational History
> Persistence Class: Observational
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `cycle-07-mobile-preparation`
> Current-state source: `00_PROJECT_STATE.md`
> Domain-history sources: `operational/11_OPERATIONAL_RECORD.md`, `didactics/13_LECTURE_REGISTER.md`, and `design/03_DECISION_LOG.md`
> Scope: Main-level chronology, reconciliation events, corrections, and cycle continuity

---

# 1. Reading Rule

This file records what happened. It does not independently define present truth or future implementation authority.

```text
current global state       00_PROJECT_STATE.md
current domain state       domain checkpoints
future cycle boundary      06_SESSION_SCHEME.md
session chronology         05_SESSION_LOG.md
```

When history conflicts with current authority, preserve the historical observation and follow current authority.

---

# 2. Session 001 — Recovery Reconstruction

```text
Date: 2026-07-10
Repository: gus-i-gu/markei
Branch: sketch-notebook-recovery
Class: global recovery and permanent-memory reconstruction
```

The Sketch Notebook methodology was loaded from `documentation/sketch_notebook/INDEX.md`. Main recovered the current application from branch-qualified repository evidence and rebuilt domain symmetry across Operational, Didactic, and Design memory.

Recovered application spine:

```text
main.py
→ app.main.main()
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

Important recovery outcomes:

- exact branch/ref discipline was established;
- the human-designated `J_[M]_STAGE.md` route was retained;
- repository evidence remained distinct from canon;
- semantic promotion remained distinct from physical materialization;
- the previous Cycle 05 was classified as a useful partial artifact outcome but an incoherent methodology closure;
- fractioned inspection and compact staging became mandatory protections against token burst.

---

# 3. Session 002 — Cycle 06 Sprint 01 Release Enablement

```text
Date: 2026-07-11 to 2026-07-12
Class: Windows primary-beta release enablement
Outcome: frozen runtime built and partially validated; installer lifecycle blocked
```

Cycle 06 activated one milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Main reconciled A/B/C and accepted:

```text
schema.sql included
seed.sql excluded from production
external %LOCALAPPDATA% user data preserved
Markei / Markei.exe / 0.1.0 identity
Markei.spec as packaging authority
one-folder windowed package
Start Menu required; desktop shortcut optional
validate shutdown before changing it
```

Codex materialized packaging, installer source, build wrappers, startup diagnostics, tests, and version metadata.

Focused shutdown validation initially failed because SQLite remained open after `MainWindow.close()`. A bounded `MainWindow.closeEvent()` coordinator closed all four page-owned services. Rerun evidence passed.

Sprint 01 ended at:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

The blocker was unavailable `ISCC.exe`.

---

# 4. Session 003 — Cycle 06 Sprint 02 Installed Lifecycle

```text
Date: 2026-07-12
Class: installer compilation and installed-lifecycle completion
Outcome: controlled Windows beta technically validated and accepted
```

## 4.1 Functional and materialization route

Operational, Didactic, and Design produced compact Sprint 02 A/B/C deltas. They agreed that no new architecture or policy decision was required. D/E/F authorized one validation-centered Codex unit:

```text
provide Inno Setup
→ compile installer
→ install per user
→ launch from Start Menu
→ exercise technical workflows
→ close/reopen
→ reinstall
→ uninstall with retained data
→ reinstall and recover
→ correct only directly failed gates
```

Codex loaded `AGENTS.md`, `INDEX.md`, the full methodology route, current state, J, and D/E/F before execution.

## 4.2 Installer compiler correction

Initial installer compilation again failed because `ISCC.exe` was not found. Inno Setup 6.7.3 was installed per user through `winget` at:

```text
%LOCALAPPDATA%/Programs/Inno Setup 6/ISCC.exe
```

`scripts/build_installer.ps1` was extended to discover that supported per-user path. Compilation then passed.

## 4.3 Structural-default correction

Fresh production Register execution failed with a foreign-key error because schema-only initialization lacked the category and store expected by current Register defaults.

Codex added only idempotent structural defaults:

```text
category F / General
store 1 / Default Store
```

`seed.sql` remained excluded, and fresh production data still contained zero sample products and purchases.

## 4.4 Artifact and lifecycle evidence

Installer artifact:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

Frozen executable hash:

```text
E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
```

Validated technical lifecycle:

```text
per-user install
→ Start Menu launch
→ external database initialization
→ Register-equivalent persistence
→ Lists / History / Settings projections
→ installed close and immediate reopen
→ same-version reinstall with retained data
→ uninstall with retained data
→ reinstall and retained-data recovery
```

Validation used the current ordinary Windows user with existing Markei data backed up and restored. It did not establish dedicated-account isolation.

## 4.5 Evidence limits

Automated/service-backed workflow evidence was not a complete human visual walkthrough. Defender was enabled and the binaries were unsigned. No SmartScreen prompt was observed during silent/programmatic execution, so human-visible SmartScreen behavior remained unknown.

The installer binary appeared in the repository despite G describing it as generated but uncommitted. Operational classified generated release binaries as better suited to an approved release/artifact channel; cleanup remains separate release-hygiene work.

## 4.6 Domain absorption

Operational, Didactic, and Design updated permanent memory.

They converged on:

```text
configured: validated
built: validated
launched: validated — frozen and installed
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: pending Main/human direction
```

Didactic maturity did not change automatically. No concept became Green.

## 4.7 Main acceptance and closure

The human instructed Main to generate the final Cycle 06 commits and prepare Cycle 07. Main interpreted that direction as acceptance of the controlled beta, not as production/public maturity.

Final Cycle 06 classification:

```text
successful bounded desktop release cycle
+
compiled wizard installer
+
validated per-user installed lifecycle
+
accepted controlled Windows primary beta
```

Residual SmartScreen, signing, artifact-channel, cross-version upgrade, atomicity, and migration concerns remain recorded as non-blocking debt.

---

# 5. Cycle 07 Handoff

Cycle 07 begins as a mobile-development preparation and architecture-discovery cycle in an isolated cloned repository/worktree context.

It must preserve the accepted desktop baseline and avoid immediate platform rewrites.

Primary handoff:

```text
clone and isolate
→ load methodology
→ inventory reusable core
→ identify desktop-only coupling
→ compare mobile approaches
→ define local/offline and synchronization assumptions
→ prototype one minimal vertical slice
→ reconcile before choosing the mobile architecture
```

The authoritative Cycle 07 preparation boundary is `06_SESSION_SCHEME.md`.


---

# 6. Session 004 — Cycle 07 Sprint 01 Portability Investigation

```text
Date: 2026-07-12
Repository: gus-i-gu/markei
Branch: cycle-07-mobile-preparation
Baseline: f6414fbe7394453387067a5a34ca6cc7621bbed3
Class: mobile portability investigation and permanent-memory reconciliation
Outcome: strategic direction staged; implementation postponed
```

## 6.1 Isolation and initialization

The human developer created an isolated sibling clone named `markei-mobile`, connected it to the existing `gus-i-gu/markei` repository, and created `cycle-07-mobile-preparation` from the exact accepted Cycle 06 closure commit.

GitHub remained the canonical Sketch Notebook host. Notion was considered as a future projection or recovery layer but was not assigned authority.

## 6.2 Functional investigation

Operational, Didactic, and Design inspected the platform boundary without modifying application code.

The reports agreed that Markei contains reusable domain behavior but is not mobile-portable as currently composed. Reuse candidates include domain models, validation/calculation rules, workflow meanings, schema semantics, and structural defaults. Coupling remains in concrete repository construction, SQLite lifecycle, Windows-shaped paths/resources, presentation-shaped projections, transaction boundaries, and desktop lifecycle ownership.

The reports compared:

```text
A. shared Python core + Python-native mobile UI
B. web/hybrid mobile client
C. native/cross-platform client + explicit contracts/fixtures
D. service-backed client
```

## 6.3 Preserved pathway tension

Operational recommended Approach A as the cheapest bounded experiment for directly falsifying Python-core reuse on Android.

Design recommended Approach C as the stronger strategic architecture for a maintained mobile product.

Main reconciled the difference as perspectival:

```text
Operational:
    cheapest direct-reuse experiment

Design:
    strongest maintained-product direction
```

The human/Main direction favors Approach C while preserving Approach A as a bounded challenger.

Development cost was recorded as more than initial code volume. It includes learning, setup, behavior reimplementation, toolchains, debugging, Android/iOS differences, testing, semantic parity, lifecycle, accessibility, distribution, dependency upgrades, and long-term maintenance.

## 6.4 Permanent-domain absorption

Functional chats updated their own permanent memory:

```text
Operational
    04_TODO.md
    10_OPERATIONAL_STATE.md
    11_OPERATIONAL_RECORD.md

Didactic
    08_CONCEPT_MAP.md
    13_LECTURE_REGISTER.md

Design
    03_DECISION_LOG.md
    09_DESIGN_STATE.md
```

No canonical architecture or framework was promoted. No Didactic maturity changed. No application, methodology, D/E/F, or G/H/I files were modified.

## 6.5 Main reconciliation

Main recorded:

```text
primary strategic direction:
    contract-first native/cross-platform client

bounded challenger:
    time-boxed Python-native Android experiment

backend:
    deferred

framework:
    not selected

implementation:
    not authorized

D/E/F:
    postponed
```

The next knowledge target is a technology-neutral behavior and fixture specification. An empirical prototype remains required before Cycle 07 can close, but its materialization awaits later human/Main direction.


---

# 7. Session 005 — Cycle 07 Sprint 02 Shared-Beta Architecture

```text
Date: 2026-07-12
Repository: gus-i-gu/markei
Branch: cycle-07-mobile-preparation
Class: shared-client, synchronization, catalogue, analytics, and learning-model design
Outcome: Flutter/Dart planning architecture and permanent domain memory accepted
```

## 7.1 Product-direction expansion

The human expanded Cycle 07 from mobile-only preparation toward one synchronized shared application for Windows, Android, and iOS.

The favored product boundary became:

```text
one maintained shared client
+ local-first persistence
+ verified-email identity
+ custom synchronization API
+ Neon Postgres
+ append-only first synchronized slice
```

The earlier near-term no-backend assumption was superseded because synchronized state became an explicit requirement.

## 7.2 Infrastructure and synchronization planning

Neon was classified as a way to reduce Postgres infrastructure operations, not as a replacement for synchronization semantics. Email was classified as a login/verification attribute, while immutable account UUID owns data.

The favored responsibility chain became:

```text
Flutter local client
→ authenticated TypeScript API
→ Neon Postgres
```

The API owns authorization, runtime validation, idempotency, device sequencing, account cursors, protocol versions, server transactions, and diagnostics. Clients never receive privileged Postgres credentials.

The first protocol uses event UUID, device sequence, business occurrence time, and account-scoped cursor for distinct responsibilities.

## 7.3 Reusable catalogue and purchase model

The human proposed the Reusable Catalogue Perspective: stable account-private Product identities should be separated from variable purchase observations.

Main and the domains reconciled:

```text
Account
├── Products
├── Stores
└── Purchases
    └── Purchase Items
```

Packaged identity uses normalized name, brand, packaged mode, package amount, and explicit unit/dimension. Bulk identity omits packaged amount. Exact normalization may reuse; fuzzy similarity only warns.

Purchase became an atomic aggregate containing one or more Items and a pending `purchase.registered` event. The first interface may guide one Item without constraining the model to one-item Purchases.

## 7.4 Quantity, money, and analytics

The broad `M/m` abstraction was narrowed for persistence.

```text
quantity:
    MASS/KG
    VOLUME/L
    COUNT/UNIT

money:
    explicit currency
    integer minor units
```

Package amount, package count, and purchased amount became distinct.

Analytics moved toward a versioned Dart registry. Raw catalogue/purchase/item facts remain authoritative; Storage/Shortage/Market, interval, price, personalized inflation/deflation, shrinkflation, store comparison, and forecasts remain derived.

## 7.5 Language and framework decision

TypeScript was initially explored as the shared-client basis. Human/Main then selected Flutter/Dart as the stronger planning basis for one Windows/Android/iOS client.

Final language boundary:

```text
Flutter/Dart
    shared client

TypeScript
    custom synchronization API

Python/PySide6
    protected beta, fixtures, migration source, rollback

Python ↔ Dart
    contracts, fixtures, and parity evidence
    no embedded runtime bridge
```

Tauri and React Native Windows remain comparison controls, not current leaders.

## 7.6 Functional restaging and Main reconciliation

A/B/C restaged the Flutter direction.

Operational recommended a Windows+Android-first, Drift-first local experiment followed by a TypeScript/disposable-Postgres protocol harness. iOS remained separately gated by macOS/Xcode.

Design defined the Flutter dependency direction, catalogue/purchase aggregate, local event queue, TypeScript API, Neon responsibilities, progressive migration, and accepted/provisional/open decision matrix.

Didactic proposed and later promoted eighteen new Red concepts spanning identity, access, consistency, Dart models, Flutter, catalogue, purchase, synchronization, quantity, money, and analytics.

Main reconciled these reports in J sections 17–18.

## 7.7 Permanent-domain absorption

Operational updated:

```text
04_TODO.md
10_OPERATIONAL_STATE.md
11_OPERATIONAL_RECORD.md
12_OPERATIONAL_MODEL.md
```

Didactic updated:

```text
02_KANBAN.md
07_GLOSSARY.md
08_CONCEPT_MAP.md
13_LECTURE_REGISTER.md
```

Design updated:

```text
01_ARCHITECTURE.md
03_DECISION_LOG.md
09_DESIGN_STATE.md
14_MODEL_OVERVIEW.md
```

New concepts were introduced as Red. No existing maturity changed.

No Flutter project, Dart source, TypeScript API, physical schema, authentication provider, Neon environment, or D/E/F/G/H/I materialization was produced.

## 7.8 Sprint 02 closure

```text
Flutter/Dart planning basis: accepted
TypeScript API: favored
Neon Postgres: favored
shared catalogue/purchase architecture: accepted for planning
synchronization semantics: accepted for planning
permanent-domain reconciliation: complete
implementation: not started
D/E/F: pending Sprint 03 authorization
```

Sprint 03 should begin the additive transition into a fresh Flutter structure and new local schema while preserving the accepted Python/PySide6 application and database.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.

# Cycle 07 Sprint 03 Closure — Flutter Foundation and Domain Reconciliation

> Date: 2026-07-12
> Implementation commit: `5ef64a1d5b6af6d397d4f3a7aea6d635911be12d`
> Domain-reconciled head: `36996361ce06e8833b91e04800ccbe0944d778e1`
> Main reconciliation: J sections 19–20

Sprint 03 Unit 01 materialized an additive Flutter/Dart client foundation, fresh Drift schema, account-private catalogue structures, Purchase aggregate transaction, local append-only event preparation, pending queue, semantic JSON fixtures, and a minimal analytics registry.

Evidence recorded:

```text
Flutter/Dart setup and generation: passed
flutter analyze: passed
Flutter tests: 9 passed
Python regression tests: 5 passed
rollback and close/reopen: passed
Windows build/run: blocked by missing Visual Studio C++ workload
Android build/run: blocked by missing SDK/device
iOS: unavailable without macOS/Xcode
```

Main then identified likely device-sequence reset, Unicode normalization risk, provisional deterministic-ID semantics, incomplete wire fixtures, unrehearsed schema upgrades, and incomplete Store identity.

Operational, Didactic, and Design chats reconciled A/G, B/H, and C/I with J section 19 into all twelve permanent-domain files. The domains agreed that no KANBAN maturity change was justified and unanimously recommended completing the local Flutter purchase workflow before the TypeScript/Postgres synchronization harness.

Main accepted that recommendation in J section 20 and advanced global continuity to Sprint 04 entry. No Sprint 04 source implementation was authorized during this closure.

# Cycle 07 Sprint 04 — Windows Local Vertical Slice Materialized

> Date: 2026-07-12
> Materialization commit: `bcc9452805ea5eee19f37653dc017fb5f3c78a0c`
> Permanent-domain reconciled head: `c195ed9b4197927db9c015076159534aa47c88e3`
> Main reconciliation: J §22

Codex implemented Product-code/internal-ID separation, Unicode normalization v2, sequence correction, Drift schema v2 migration, v2 JSON Schemas, multi-item Purchase UI, and local History.

Evidence:

```text
flutter analyze: passed
flutter test: 21 passed
flutter build windows: passed
Windows startup smoke: passed
Python tests: 5 passed
Android: blocked by absent SDK
Windows manual UI acceptance: pending
```

PDR2 reconciled the permanent domains. Main found the Operational checkpoint remained stale at pre-materialization state; J §22 and implementation truth supersede it until PDR2-O is rerun.

## VS Code terminal — Windows manual UI verification

From the repository root:

```powershell
git switch cycle-07-mobile-preparation
git pull --ff-only
cd .\clients\markei_flutter
flutter pub get
flutter doctor -v
flutter devices
flutter run -d windows
```

Manual check:

```text
create/select Store
→ stage two Products/Items
→ register Purchase
→ open History
→ verify Store, total, and item count
→ close window
→ run flutter run -d windows again
→ verify History persists
```

If debug launch fails but the release build exists:

```powershell
flutter build windows
.\build\windows\x64\runner\Release\markei.exe
```

Record visible pass/fail separately from automated smoke evidence.

The human selected full Android implementation as the next milestone. Android installation and execution require new D/E/F.


# Cycle 07 Sprint 05 and Cycle Closure — Android Debug Foundation

> Date: 2026-07-12  
> Main reconciliation: J §§24–25  
> Sprint 05 staging head: `c2d74e445a6c7819b9c36573f6d63836d990c471`

Codex installed and configured the Android toolchain, converged the active Flutter SDK on the deliberate H: installation, established `com.gusigu.markei`, replaced the production `windows-device` placeholder with a Drift-backed UUID v4 Device, built and launched a debug APK on an API 36 emulator, and preserved Windows/Python regression evidence.

Evidence:

```text
Flutter SDK: H:\Users\Gus\develop\flutter
Android SDK: C:\Users\gusrm\AppData\Local\Android\Sdk
Android Studio: 2026.1.1.10
API/target: 36
AVD: Markei_Sprint05_API36
flutter analyze: passed
Flutter tests: 27 passed
debug APK: built
APK install/launch: passed
Android app-private database: observed
human Android Purchase registration: confirmed
Device UUID/sequence: persisted and evidenced
Windows Flutter build: passed
Python regressions: 5 passed
```

PDR2 reconciled all twelve permanent domain files. No Didactic maturity changed.

Permanent reconciliation retained:

- incomplete keyboard, Back, rotation, background/resume, text-scale, staged-state, and complete cold-relaunch evidence;
- no physical-device validation;
- current UI as a functional scaffold;
- prototype-only first-20 Device lookup and missing explicit installation relation;
- committed `devtools_options.yaml` despite G’s contrary report;
- Purchase registration as the accepted term, not unsupported upsert;
- local queue as synchronization preparation only.

Main closed Cycle 07 at the shared-client technical-foundation boundary. The incomplete lifecycle matrix is carried into Cycle 08 product-beta acceptance rather than promoted as complete.

# Cycle 08 Entry — Shared-Client Product Beta

The human accepted the forward schedule:

```text
Cycle 08 — local shared-client product beta and UI/UX formalization
Cycle 09 — synchronized household beta with account/API/Neon
Cycle 10 — release preparation and controlled public beta
```

Cycle 08 Sprint 01 begins as definition/investigation. Its task is to define the responsive navigation and user journeys for Catalogue, Store, staged Purchase review, detailed History, and first personal price-comparison analytics while preserving the local-first and future synchronization boundaries.

No Cycle 08 source implementation was authorized in this session.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.
