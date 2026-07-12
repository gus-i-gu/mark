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

