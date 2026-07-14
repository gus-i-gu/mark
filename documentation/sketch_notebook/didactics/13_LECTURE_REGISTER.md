# 13_LECTURE_REGISTER.md

> Domain: Didactic
> Status: Observational history
> Authority: Didactic Chat [A]
> Current truth sources: `02_KANBAN.md`, `07_GLOSSARY.md`, and `08_CONCEPT_MAP.md`
> Rule: This file records how learning memory evolved; it does not override canon or checkpoint state.

---

# Observation 001 — Didactic Domain Recovery

```text
Date: 2026-07-10
Branch: sketch-notebook-recovery
Class: domain recovery and repopulation
```

The Didactic domain was reconstructed from current repository evidence, exact Main reconciliation, and bounded historical review. Canon, glossary, checkpoint, and observational roles were restored without treating implementation facts as learner mastery.

Durable lessons:

- exact authority path and branch matter;
- physical package placement does not fully define semantic responsibility;
- staged interpretation is not canon;
- derivative terminology does not create independent truth;
- unresolved architecture remains outside Didactic authority;
- useful implementation output does not prove cycle completion.

# Observation 002 — Cycle 06 Sprint 01 Concept Classification

```text
Date: 2026-07-12
Branch: sketch-notebook-recovery
Class: release-learning classification
Main source: [M]_STAGE/J_[M]_STAGE.md
```

Four concepts were classified as canonical Red:

```text
&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

Sprint 01 evidenced a one-folder frozen build and launch, schema-only production initialization, startup diagnostics, and an evidence-triggered shutdown correction. Installer compilation remained blocked by missing `ISCC.exe`; installed execution and uninstall retention remained unvalidated. No concept became Green.

# Observation 003 — Cycle 06 Sprint 02 Installed-Lifecycle Evidence

```text
Date: 2026-07-12
Branch: sketch-notebook-recovery
Class: post-materialization Didactic reconciliation
Sources:
  DEV_STAGE/E_DDC_STAGE.md
  DEV_STAGE/H_DDC_CODEX.md
  DEV_STAGE/G_OPS_CODEX.md
  [M]_STAGE/J_[M]_STAGE.md
```

Sprint 02 crossed the installer and automated installed-lifecycle boundary.

Observed progression:

```text
installer configured
→ Inno Setup 6.7.3 installed per-user
→ ISCC.exe discovered
→ installer compiled
→ installer artifact inspected and hashed
→ per-user installation
→ Start Menu launch
→ installed technical workflow evidence
→ close and immediate reopen
→ same-version reinstall
→ uninstall with retained user data
→ reinstall recovery
```

Learning evidence reinforced:

- `&&&05`: each state required matching evidence; acceptance remained separate.
- `&&%04`: installed shortcut execution was distinguished from source and frozen-directory execution.
- `&%%06`: compiled installer, installed files, uninstall, retention, and recovery became observed lifecycle stages.
- `%%%06`: Inno Setup was installer-time tooling, not an installed runtime dependency.
- `%%%05`: replaceable installed files and retained `%LOCALAPPDATA%\Markei` state were directly distinguished.
- `%%%01`: category `F` / `General` and store `1` / `Default Store` were classified as required structural defaults, not sample seed data.

A fresh-production Register-equivalent workflow initially failed because required foreign-key defaults were absent. The bounded correction created structural defaults idempotently while preserving zero sample products and purchases. This demonstrated that initialization, migration/defaulting, and seeding are distinct operations.

Automated technical workflow evidence used the same ProductService/database path and validated persisted Register-equivalent data plus Lists, History, and Settings projections. It did not constitute a complete human-visible UI walkthrough.

Security/reputation evidence remained bounded:

```text
Defender enabled: observed
Authenticode: NotSigned
human-visible SmartScreen behavior: unknown
```

Maturity decision:

```text
no new concept
no Green promotion
no Red-to-Yellow promotion
```

The reason is explicit: software validation and release readiness do not demonstrate learner mastery. Future maturity movement requires learner evidence under the Didactic protocol.

Remaining learner checks:

1. explain the difference between installer configuration, compiled artifact, installation, validation, and acceptance;
2. distinguish frozen launch from Start Menu installed launch;
3. explain why retention must be observed across uninstall and reinstall;
4. distinguish structural defaults from sample data;
5. classify SmartScreen/reputation evidence separately from application correctness;
6. explain why `ISCC.exe` is installer-time only;
7. explain why automated service-backed validation is not a full human UI walkthrough.

# Current Observation Boundary

Cycle 06 is technically release-candidate ready under automated installed-lifecycle evidence, but Didactic memory does not claim learner mastery, human-visible UI acceptance, SmartScreen behavior, or final beta acceptance.

# Observation 004 — Cycle 07 Sprint 01 Portability Learning Reconciliation

```text
Date: 2026-07-12
Branch: cycle-07-mobile-preparation
Class: portability investigation and pathway-cost observation
Sources:
  [M]_STAGE/J_[M]_STAGE.md
  DEV_STAGE/A_OPERATIONAL.md
  DEV_STAGE/B_DIDACTIC.md
  DEV_STAGE/C_DESIGN.md
```

Cycle 07 Sprint 01 investigated portability without implementing a mobile prototype. It established a learning boundary: shared source language does not guarantee a shared runtime, and platform-neutral components do not by themselves make an application portable. Markei's models and parts of its business behavior are reuse candidates, while presentation, storage paths, construction, packaging, and lifecycle remain platform-sensitive.

The investigation preserved two serious pathways.

## Python-native pathway

The Python-native pathway tries to lower initial implementation cost by executing more of the existing Python core directly. Its attraction is immediate: fewer rules may need to be rewritten, existing Python tests may remain useful, and the learner can initially work in a familiar language.

That saving is conditional. Cost may move into mobile Python packaging, device lifecycle handling, native integration, accessibility, platform support, distribution, and debugging across less conventional boundaries. Reusing source can reduce rewriting while increasing uncertainty about whether the runtime, dependencies, and UI toolchain behave reliably on Android and iOS.

## Contract-first cross-platform pathway

The contract-first pathway accepts a larger initial cost because some behavior must be implemented again in a conventional native or cross-platform client. It tries to make that cost visible and controlled through behavioral contracts, golden fixtures, semantic-parity checks, explicit lifecycle ownership, a mobile-owned local store, and platform-appropriate presentation.

Its cost includes duplicate implementation, contract and fixture design, parity testing, and learning a mobile toolchain. Its intended benefit is lower long-term uncertainty: each platform can use established tooling while shared examples protect the meaning of receipt registration, calculation, validation, and status behavior.

Human/Main direction currently favors this contract-first Design pathway. This is a reasoned project preference, not evidence that the pathway is understood by the learner, validated by a prototype, or permanently accepted as architecture. The Python-native route remains a bounded challenger whose direct-reuse claim requires device evidence.

## Development cost in learner-facing terms

Development cost is everything the project must spend to create, understand, prove, distribute, and keep a change working. It is not only money or lines of code. It includes:

- learning effort and setup time;
- the number of ideas that must be held together;
- repeated or duplicate implementation;
- designing tests and shared examples;
- finding and explaining failures;
- fragile or unusual toolchains;
- maintenance across Android, iOS, and desktop;
- preventing two implementations from silently changing meaning;
- packaging and distribution requirements;
- the effort required by future changes.

A pathway can look cheaper because it writes less code today while becoming expensive to package and debug later. Another can look expensive because it rewrites behavior today while making later maintenance and platform support more predictable. Sprint 01 compared where cost may occur; it did not measure either pathway through implementation.

## Candidate concepts observed

```text
Platform Boundary
Composition Root
Dependency Injection
Behavioral Contract
Golden Fixture
Semantic Parity
Local Persistence
Offline-First
Transaction Boundary
Application Lifecycle Ownership
Synchronization
```

These remain KANBAN candidates. Existing canon already partially supports them through Responsibility Boundary, Application Service, Repository Pattern, Resource Ownership and Lifetime, Statement Atomicity versus Workflow Atomicity, and SQLite Connection Ownership. Canonical creation should wait until prototype preparation identifies which candidates are necessary as independent concepts and provides concrete project examples.

Unresolved learner questions include:

1. Which parts of Markei can share source, and which can share only behavior?
2. What does a composition root create and connect?
3. Why does dependency injection make a storage implementation selectable?
4. How can a fixture prove equivalent behavior across Python and another runtime?
5. Who owns the mobile database and its transaction lifetime?
6. What must remain available for the application to be offline-first?
7. When does synchronization become a requirement rather than speculative infrastructure?
8. Which costs are paid once, and which recur with every platform or feature change?
9. What evidence would fairly compare the two pathways?
10. Why does a project preference not change learner maturity?

Maturity decision:

```text
new canonical concepts: none
candidate concepts: eleven
maturity changes: none
project preference: contract-first, provisional
prototype validation: not performed
learner mastery: not demonstrated
```

# Current Observation Boundary

Cycle 06 remains accepted and closed. Cycle 07 Sprint 01 provides classified portability knowledge and a preferred investigation direction, but not mobile runtime evidence, prototype validation, permanent architecture acceptance, or learner mastery. D/E/F remain postponed.

# Observation 005 — Cycle 07 Sprint 02 Flutter Canonical Promotion

```text
Date: 2026-07-12
Branch: cycle-07-mobile-preparation
Class: model-design canonical promotion
Sources:
  [M]_STAGE/J_[M]_STAGE.md sections 17–18
  DEV_STAGE/A_OPERATIONAL.md
  DEV_STAGE/B_DIDACTIC.md
  DEV_STAGE/C_DESIGN.md
```

Human/Main established Flutter/Dart as the planning basis for the shared Windows, Android, and iOS client. TypeScript remained favored for the custom synchronization API, Neon for managed shared persistence, and the accepted Python/PySide6 beta as reference and rollback. No application, API, schema, provider, infrastructure, or D/E/F implementation was authorized or evidenced.

The model-design discussion genuinely approached stable identity, authentication and authorization, the account-private reusable catalogue, deterministic Product normalization, Purchase aggregation, dimensional quantity and minor-unit money, append-only offline synchronization, eventual consistency, historical integrity, versioned analytics, immutable Dart models, and responsive Flutter composition.

Human clarification established that implementation is not required for canonical concept introduction when a model-design concept has reusable meaning and concrete project manifestation. The Didactic domain therefore promoted:

```text
&&&06–&&&10
&&%05
&%%07–&%%17
%%%07
```

All eighteen concepts entered as Red.

Reconciliation prevented duplicate semantic ownership:

- Authoritative Fact / Derived Projection remained an extension of `&&&02`.
- Purchase atomicity remained an extension of `&%%05`.
- Row Ownership remained an Authorization example.
- Composition root and application lifecycle remained related to existing responsibility, ownership, and cleanup concepts.
- Protocol versioning became part of Sync Protocol.
- Storage-schema versioning remained related to `%%%01`.
- Append-only event semantics remained distinct from Dart immutability.

Learning-state decision:

```text
new canonical concepts: 18
new concept status: Red
existing maturity changes: none
implementation evidence: none
learner mastery evidence: none
```

Concept introduction records that the project can now name and teach the model. It does not show that the learner can independently explain, apply, compare, or debug it. Later maturity movement requires explicit learner evidence.

# Current Observation Boundary

The permanent Didactic domain now contains canonical Flutter shared-beta model vocabulary, derived retrieval terminology, and a refreshed checkpoint. Architecture and implementation acceptance remain outside Didactic ownership; D/E/F remain postponed.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.

# Observation 006 — Cycle 07 Sprint 03 Local Flutter Evidence

```text
Date: 2026-07-12
Branch: cycle-07-mobile-preparation
Class: post-materialization Didactic reconciliation
Sources:
  [M]_STAGE/J_[M]_STAGE.md §19
  DEV_STAGE/B_DIDACTIC.md
  DEV_STAGE/H_DDC_CODEX.md
Materialization commit:
  5ef64a1d5b6af6d397d4f3a7aea6d635911be12d
```

Sprint 03 Unit 01 changed the evidence state from planning-only to a locally implemented and unit-tested Flutter/Dart foundation.

Observed implementation:

```text
Flutter project under clients/markei_flutter
→ immutable Dart domain/value models
→ account-private reusable catalogue
→ PACKAGED/BULK identity rules
→ dimensional quantities and minor-unit money
→ Purchase aggregate with one or more Items
→ Drift fresh local schema
→ atomic Purchase/Items/local event/pending queue transaction
→ rollback on invalid Item
→ close/reopen persistence
→ minimal versioned analytics registry
→ shared_beta/v1 JSON semantic fixtures
```

Reported validation:

```text
flutter analyze: passed
flutter test: 9 passed
Dart formatting/generation: passed
Python regressions: 5 passed
Windows runtime/build: host-blocked
Android runtime/build: host-blocked
iOS runtime/build: host-unavailable
```

The local tests provide executable examples for Stable Identity, Immutable Dart Model, Reusable Catalogue, Purchase Aggregate, Purchase Item, local Append-Only Event, Dimensional Quantity, Monetary Minor Unit, Historical Integrity, and Versioned Analytic. They also provide bounded evidence for deterministic normalization, offline queue preparation, and Flutter framework setup.

The evidence does not prove:

- responsive Flutter composition;
- Windows, Android, or iOS lifecycle behavior;
- authentication or authorization;
- TypeScript API behavior;
- server idempotency;
- cursor download/application;
- eventual cross-device consistency;
- schema upgrade/recovery;
- complete wire-contract compatibility;
- learner mastery.

The JSON files were classified as versioned semantic fixtures or contract examples. `catalogue_identity.json` contains the strongest input/expected-output evidence. The Purchase and sync fixtures remain incomplete: they do not yet fix every type, range, nullability rule, enum, unknown-field policy, timestamp form, or version transition. Fixture existence is not a complete Sync Protocol.

Two important correctness questions were preserved:

1. Device sequence allocation may reset to 1 on repeated registration, so monotonic device ordering is not accepted.
2. Text normalization may mishandle accented Portuguese names and has no explicit Unicode/locale/canonical-byte policy, so normalization v1 remains provisional.

Generated Drift and platform source was distinguished from handwritten design. Generated code is reviewed through its source schema/configuration and regeneration evidence; it is not independent proof of business architecture or platform execution.

Maturity decision:

```text
new concepts: none
existing maturity changes: none
local executable evidence: recorded
learner evidence: absent
```

The next learner boundary is to explain evidence classifications, local queue versus synchronization, fixture versus protocol, generated versus handwritten ownership, Unicode normalization, monotonic sequencing, and the proof required for a maturity transition.

# Current Observation Boundary

Sprint 03 Unit 01 is a successful local foundation. It does not complete the user-visible Flutter vertical slice, platform validation, synchronization protocol, or Cycle 07. Main orientation favors correcting identity/sequence defects, strengthening fixtures, and completing the local shared-client workflow before the protocol harness. Sprint 04 remains unauthorized.

---

# Observation 007 — Cycle 07 Sprint 04 Local Flutter Workflow Evidence

> Evidence sources: `DEV_STAGE/H_DDC_CODEX.md`, Main J §21, `DEV_STAGE/B_DIDACTIC.md`, current Flutter source/tests, and `contracts/shared_beta/v2/`  
> Evidence class: implemented, tested, and selectively host-validated; learner mastery not evidenced

Sprint 04 materialized the bounded local Flutter workflow anticipated by the prior checkpoint. The protected Python beta remained regression-tested while the Flutter client gained an explicit composition boundary, a multi-item Purchase form, atomic local registration, and a readable local history projection.

The strongest concept evidence is:

- a user-designable, account-private Product code is stored as display value plus normalized key;
- the Product record keeps a separately generated immutable local UUID;
- normalized Name, Brand, mode, and package facts form versioned semantic identification evidence without becoming the record identity;
- Unicode NFKC and whitespace collapse preserve readable display facts while producing deterministic comparison keys;
- PACKAGED and BULK retain different package-quantity rules;
- Purchase, Items, local append-only event, pending queue entry, and device-sequence allocation remain within one local transaction;
- repeated successful registrations produce device sequences 1, 2, 3, while a rolled-back registration consumes no sequence;
- schema v1-to-v2 migration preserves the existing Product row, assigns an explicit temporary legacy code, records the migration, and survives reopen;
- JSON Schema validates the readable v2 catalogue, Purchase, and sync-event examples structurally;
- the Flutter widget test exercises multi-item registration and the resulting history view;
- Windows analysis, tests, build, and launch smoke supplied host evidence.

The evidence boundaries are equally important. JSON Schema does not establish every cross-field business invariant or Dart/TypeScript parity. A local event and pending queue are not an API, server acknowledgement, cursor application, or cross-device convergence. The future central Product UUID remains a design possibility rather than an implemented identity. Authentication, authorization, eventual consistency, and real Sync Protocol behavior remain unimplemented. Android was blocked by absent tooling under the authorized installation boundary; iOS remains host-unvalidated. Manual UI acceptance remains open.

Maturity decision:

```text
new concepts: none
existing maturity changes: none
implementation/test evidence: recorded
learner evidence: absent
```

# Current Observation Boundary

Sprint 04 closes several local correctness and platform-evidence gaps from Sprint 03, but it does not prove distributed synchronization or learner mastery. The next learner work is to explain the three Product identities, structural schema versus semantic invariants, local atomic delivery preparation versus synchronization, and why Windows validation does not generalize automatically to Android or iOS.

---

# Observation 008 — Cycle 07 Sprint 05 Android Execution Evidence

> Date: 2026-07-12  
> Branch: `cycle-07-mobile-preparation`  
> Inspected implementation head: `ca53097b346ae42b216188dabc56a6eef45b051c`  
> Sources: `DEV_STAGE/H_DDC_CODEX.md`, Main J §24, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/E_DDC_STAGE.md`, current source/tests/Android configuration, and human-observed emulator evidence  
> Class: post-materialization Didactic reconciliation

Sprint 05 moved Android from generated target scaffolding to executed debug-development evidence. The Flutter SDK and Android SDK were separately identified; Android Studio supplied the Android tooling environment; an API 36 emulator booted; a debug APK was built, installed, and launched. The APK identifies the application as `com.gusigu.markei` with display label `Markei`.

The implementation replaced the production `windows-device` placeholder with a Drift-owned local UUID v4. Automated tests demonstrate creation in a fresh database, reuse after close/reopen, distinct UUIDs for distinct databases, sequence continuation after reopen, and preservation of historical non-UUID rows. Runtime database inspection observed one UUID Device row, one Purchase, and the sequence advanced to 2.

The human confirmed Purchase registration on the emulator. This is interaction evidence for creating a new immutable Purchase and its related local facts. It is not evidence that an existing Purchase can be replaced or “upserted”; current repository source creates a fresh Purchase UUID and inserts the Purchase. The local append-only event and pending queue remain synchronization preparation, not upload, server acknowledgement, cursor application, or convergence.

Evidence ladder reached:

```text
Flutter SDK selected
→ Android SDK/toolchain recognized
→ licences accepted
→ emulator online
→ debug APK built
→ APK installed
→ Flutter app launched
→ Purchase registration human-observed
→ app-private database inspected
→ persistence/sequence partly observed
```

The evidence does not complete the full lifecycle matrix. Phone-width widget tests exercise layout constraints and the Purchase/History path, but they are not real Android evidence for keyboard behavior, Back, rotation, background/resume, text scaling, process recreation, or visual quality. Force-stop/relaunch and database inspection provide partial persistence evidence. One emulator does not establish physical-device compatibility.

The UI remains a functional scaffold. SafeArea, scrolling, staged total, and navigation are bounded usability work, not accepted visual design or accessibility certification. Authentication, authorization, server synchronization, physical-device validation, production signing/release, and iOS remain deferred or unvalidated.

Maturity decision:

```text
new concepts: none
existing maturity changes: none
source/test/host evidence: strengthened
human-observed project execution: present
explicit learner concept evidence: absent
```

# Current Observation Boundary

Sprint 05 validates an Android debug-development slice and a persistent installation-local Device identity. The next learner boundary is to explain the evidence ladder, identity taxonomy, lifecycle distinctions, registration semantics, and the difference between emulator evidence and broader device compatibility.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.
