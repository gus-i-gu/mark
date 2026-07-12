# Didactic State-of-Union — Cycle 07 Sprint 05 Android Preparation

> Role: Didactic Chat [A]  
> Cycle/Sprint: Cycle 07 Sprint 05 — Android full-implementation preparation  
> Repository: `gus-i-gu/markei`  
> Branch: `cycle-07-mobile-preparation`  
> Inspected head: `f6c499c94aca2b7cc4a25cf28bdbbf7e9b0444f1`  
> Date: 2026-07-12  
> Sources: PRI-A, PMC-01, MSU-02; `AGENTS.md`; `INDEX.md`; `PROMPT_COLLECTION.md`; `00_PROJECT_STATE.md`; latest Sprint 04/Android segment of `05_SESSION_LOG.md`; active Android checkpoint in `06_SESSION_SCHEME.md`; Main J §22; `didactics/08_CONCEPT_MAP.md`; prior `B_DIDACTIC.md`; bounded Python, Flutter, Android, contract, and test inspection; human Windows evidence.

## 1. Recovered Main State

Cycle 07 remains open. Sprint 04 materially completed the local Flutter vertical slice while preserving the accepted Python/PySide6 beta and its ordinary database boundary. Product code and local Product UUID are separated; normalization v2, device-sequence correction, Drift migration v2, JSON Schemas, multi-item Purchase registration, and local History are implemented and tested.

The human has now supplied the missing Windows evidence: Flutter tooling worked; the client built and launched; a Purchase was registered; History displayed the projection; and the data remained after closing and reopening. This upgrades the Windows workflow claim from pending human verification to human-validated within the bounded scenario. The interface remains a functional scaffold. Passing the scenario does not establish visual completeness, accessibility quality, or mobile responsiveness.

Main J §22 and the active forward checkpoint select Android full implementation as Sprint 05. Android planning is accepted, but installation and implementation remain inactive until Main writes fresh D/E/F and the human approves their exact host actions. Synchronization, authentication, API/Neon work, central catalogue work, iOS, publication, and broad UI redesign remain deferred.

## 2. Hierarchical-Recovery Path

Recovery followed:

```text
PRI-A and PMC-01
→ Main J §22
→ 00 current checkpoint
→ latest relevant 05 segment
→ active 06 Android checkpoint
→ Didactic checkpoint
→ prior B stage
→ bounded repository inspection
```

The Didactic checkpoint was required by PRI-A and MSU-02. It was sufficient for concept identity, dependency order, and the no-maturity-change guard. No deeper read of `02_KANBAN.md`, `07_GLOSSARY.md`, or `13_LECTURE_REGISTER.md` was justified. No permanent Didactic file was modified.

## 3. Repository Surfaces Inspected

Preserved beta boundary:

- root `main.py` and `app/main.py`, confirming the separate PySide6 executable;
- baseline ancestry, confirming the active branch descends from `f6414fbe7394453387067a5a34ca6cc7621bbed3`;
- recorded Python regression evidence: five tests passed.

Flutter handwritten boundary:

- `pubspec.yaml` and `lib/main.dart`;
- `markei_composition.dart`, `markei_app.dart`, Purchase and History pages;
- Drift schema and local Purchase repository;
- widget, sequence, migration, normalization, repository, and JSON Schema tests;
- `contracts/shared_beta/v2/`.

Android boundary:

- `android/app/build.gradle.kts`;
- main Android manifest and generated Android project topology.

Generated Drift output and platform boilerplate were not read line by line. Build output and local databases were not inspected or changed.

## 4. Didactic Current State of Union

### Existing concepts with stronger executable evidence

Stable Identity, Immutable Dart Model, Purchase Aggregate, Purchase Item, Atomicity, Append-Only Synchronization Event, Offline Queue preparation, Device Ordering, Historical Integrity, Dimensional Quantity, Monetary Minor Unit, Versioned Analytic, and Flutter composition all have project examples. Windows now adds human-observed launch, interaction, projection, and reopen-persistence evidence.

This evidence does not itself demonstrate that the learner can explain or transfer these concepts. KANBAN maturity therefore remains unchanged.

### Android knowledge newly required

**Android SDK/toolchain boundary.** Flutter source is shared, but Android execution requires a separate host toolchain: SDK platform and build tools, command-line tools, emulator/platform tools, Java/Gradle compatibility, licenses, and possibly NDK/CMake for dependencies. “Flutter is installed” does not imply “Android is ready.”

**Application ID.** `com.example.markei` is generated placeholder identity. An Android application ID names the installable package to Android tooling and the operating system. It is not a user account, Product ID, event ID, or device ID.

**Emulator/device execution.** A generated Android folder proves target scaffolding. An APK proves compilation/package production. A recognized emulator or physical device proves a deployment target. A successful launch proves runtime entry. These are separate evidence levels.

**Application lifecycle.** Background/resume, back navigation, rotation, process termination, and recreation can interrupt or rebuild UI state. Durable facts belong in app-private persistence; temporary form state may require explicit handling. Lifecycle testing asks which state must survive which boundary.

**Platform-neutral device UUID.** The current composition injects `windows-device`. A persistent locally generated UUID should identify one Markei installation for local event sequencing across restarts. It must not depend on Windows, Android hardware identifiers, account credentials, or application ID. It is local identity, not authentication.

**Responsive mobile behavior.** The current `ListView`, text fields, segmented control, and bottom navigation form a functional scaffold. Mobile evidence must check safe areas, narrow width, scrolling, keyboard obstruction, focus, tap targets, portrait/landscape, and back behavior. Responsive means behavior remains usable under changed constraints; it does not mean a broad visual redesign.

**Debugging boundary.** Compile errors, Gradle/toolchain errors, deployment failures, Flutter exceptions, SQLite failures, lifecycle loss, and layout overflow belong to different layers. Good debugging first classifies the failing layer, then preserves logs and reproduction facts.

**Evidence classification.** Installation, doctor validation, APK build, device recognition, launch, workflow completion, lifecycle checks, persistence, and regression results must be reported separately. One success must not be used as shorthand for all later levels.

## 5. Agreement With J, 00, 05, and 06

The sources agree that:

- Sprint 04’s local Windows slice is implemented and tested;
- the human’s new report closes the bounded manual Windows workflow and persistence check;
- the UI remains an intentionally narrow functional scaffold;
- Android project files exist, while Android SDK/build/run/lifecycle evidence does not;
- `com.example.markei` and `windows-device` are entry defects;
- Android is a platform-completion milestone, not synchronization;
- D/E/F must own installation and implementation authority;
- no Didactic maturity transition follows automatically.

The protected Python beta remains the reference/rollback implementation. Android changes must preserve Windows and Python regressions.

## 6. Drift, Defects, Contradictions, and Stale Documentation

1. The active 06 checkpoint and older 00/05 text still say Windows manual workflow is pending. The human’s newer evidence supersedes that narrow claim.
2. Prior `B_DIDACTIC.md` describes Sprint 04 before materialization and is stale: sequence, normalization, JSON Schema, Purchase UI, History, migration, and Windows execution are no longer pending.
3. `MarkeiComposition.appPrivate()` still injects `windows-device`, contradicting platform-neutral identity.
4. Android namespace/application ID remains `com.example.markei`; generated placeholder presence is not accepted product identity.
5. Android manifests and runner topology exist, but no SDK, APK, device, runtime, lifecycle, or persistence evidence exists.
6. The current widget test uses a generous synthetic viewport. It proves the workflow, not narrow Android usability.
7. Windows persistence success does not prove Android app-private path behavior or Android process-recreation behavior.
8. A functional scaffold should not be described as either “no UI” or “finished UI.”

## 7. Human Decisions Already Supplied

- Sprint 05 investigates full Android debug-development implementation.
- Windows tooling, build/launch, Purchase registration, History projection, and persistence succeeded.
- The current UI is a functional scaffold and may receive only bounded usability corrections required by Android acceptance.
- Installation requires future D/E/F with exact components, approval points, validation, and stop conditions.
- No broad redesign, production signing, store publication, synchronization, or backend expansion belongs to this unit.

## 8. Questions Requiring Main or Human Resolution

1. Is `com.gusigu.markei` accepted as the stable Android application ID, or should Main stage another value?
2. Should the primary execution route be an emulator, with a physical device as fallback, or the reverse?
3. Where should the persistent device UUID be owned so it is created once, survives restart, and remains testable on Windows and Android?
4. Should uninstall/data-clear deliberately create a new device UUID, and how should that consequence be explained while synchronization is absent?
5. Which temporary form fields, if any, must survive rotation or process recreation?
6. What minimum narrow-screen defects block Sprint 05 acceptance, given that broad UI redesign is deferred?
7. Which human-observed artifacts are sufficient to distinguish launch, interaction, lifecycle, and persistence evidence without recording personal data?

## 9. Recommended Next Bounded Materialization Scope

The smallest coherent learning/materialization unit is:

```text
validate Android toolchain
→ approve stable application ID
→ replace platform-named fixed Device ID with persistent local UUID
→ build debug APK
→ launch on one recognized emulator/device
→ execute existing two-item Purchase/History scenario
→ check keyboard, narrow layout, back, rotation, background/resume
→ terminate and relaunch
→ verify History and device sequence persist
→ rerun Flutter, Windows, and Python regressions
→ classify every evidence level separately
```

This boundary reuses one known workflow, so new uncertainty comes mainly from platform execution rather than new business behavior.

## 10. Explicit Non-Goals

- no tool installation or source implementation in this stage;
- no KANBAN creation, promotion, or maturity change;
- no broad visual redesign or accessibility certification;
- no Play Store publication, production signing, or release channel;
- no authentication, authorization, TypeScript API, Postgres/Neon, or real synchronization;
- no central Product catalogue, Product editing/deletion, or legacy import;
- no PySide6 retirement or ordinary desktop database access;
- no iOS validation;
- no claim that emulator success equals every physical Android device.

## 11. Evidence Matrix

| Claim | Classification | Source |
| --- | --- | --- |
| Python/PySide6 beta remains preserved | accepted/validated within its boundary | 00, 05, Python entrypoints, regression report |
| Flutter local Purchase/History slice | implemented and validated | source, widget tests, H/J |
| Windows build and launch | validated | automated evidence plus human report |
| Windows Purchase/History interaction | human-validated | new human evidence |
| Windows close/reopen persistence | human-validated | new human evidence |
| UI visual quality | provisional functional scaffold | human observation and current widgets |
| Android target project | implemented as generated scaffold | Android project files |
| Android toolchain | blocked/absent | 00/06/J §22 |
| Stable Android application ID | proposed; unresolved | Gradle placeholder and 06 candidate |
| Persistent platform-neutral device UUID | accepted requirement; not implemented | composition source and 06/J |
| Debug APK | host-unvalidated/not built | 00/06/J |
| Emulator or physical-device launch | host-unvalidated | 06/J |
| Android responsive behavior | host-unvalidated | UI source and absence of device evidence |
| Android lifecycle/persistence | host-unvalidated | 06/J |
| App-private Drift strategy | implemented in shared client; Android behavior unvalidated | database source |
| Synchronization/authentication | deferred | 00/06/J |
| Learner mastery | unvalidated | Didactic checkpoint |

## 12. Proposed Didactic D/E/F Gates

E_DDC_STAGE should require:

1. a short learner-facing distinction among Flutter SDK readiness, Android SDK readiness, APK build, deployment, launch, interaction, lifecycle, and persistence;
2. explicit distinction between application ID, account identity, persistent device UUID, Product identity, and event identity;
3. a test or deterministic seam proving one device UUID is reused across restart and is not named for a platform;
4. controlled test data for the two-item Purchase/History scenario;
5. narrow-screen evidence for scrolling, safe areas, keyboard, validation, tap targets, and navigation;
6. separate background/resume, rotation, back, process termination, and relaunch observations;
7. proof that durable History survives while no external-storage permission or desktop database access is introduced;
8. logs classified by toolchain, build, deployment, Flutter runtime, persistence, or layout layer;
9. Windows and Python regression evidence after Android changes;
10. no maturity transition without explicit learner explanation.

Stop the Didactic acceptance claim if an APK is called Android execution, launch is called lifecycle validation, `windows-device` is merely renamed to `android-device`, application ID is confused with device identity, or emulator success is generalized to all devices.

## 13. Smallest Learning Boundary

Before materialization, the learner needs only this compact dependency order:

```text
shared Flutter behavior
→ platform-specific build/runtime boundary
→ application package identity
→ installation-local persistent identity
→ emulator/device evidence ladder
→ mobile constraints and lifecycle
→ app-private persistence
→ debugging-layer classification
→ cross-platform regression
```

The central lesson is portability through evidence: shared source can preserve behavior, but each platform must still prove its tooling, lifecycle, storage, interaction, and identity boundaries.

## 14. Final Handoff to Main

Sprint 05 can be staged as a single Android parity experiment around the already validated Purchase/History workflow. Main should first resolve the application ID, device-UUID ownership, and primary device route, then write narrowly authorized D/E/F for installation and materialization. Preserve the evidence ladder and the UI-scaffold boundary. Windows success is now accepted for the bounded scenario; Android remains blocked and unvalidated until toolchain, APK, device execution, lifecycle, persistence, and regressions are independently evidenced. No KANBAN maturity change is justified.
