# E_DDC_STAGE.md — Cycle 07 Sprint 05 Evidence and Learning Directive

> Status: Main-approved temporary implementation directive  
> Authority: Main Chat [M]  
> Branch: `cycle-07-mobile-preparation`  
> Reconciliation: J §23  
> Paired implementation authority: D and F

---

# 1. Purpose

Make Sprint 05 evidence understandable, reproducible, and correctly classified while Codex materializes Android parity. E does not authorize extra features. It defines what implementation and validation must teach and what G/H/I must preserve.

# 2. Required evidence ladder

Never collapse these states:

```text
SDK files present
→ Flutter recognizes Android toolchain
→ licences accepted
→ emulator/device online
→ APK built
→ APK deployed
→ Flutter runtime launched
→ Purchase/History interacted
→ lifecycle exercised
→ persistence recovered
→ human observed
```

Each report must state the highest evidenced level and source. A debug APK alone is not Android execution. Launch alone is not lifecycle or persistence acceptance. Emulator evidence is not proof for every physical device.

# 3. Identity distinctions

Implementation, tests, and H must distinguish:

| Identity | Meaning | Sprint 05 rule |
| --- | --- | --- |
| Android application ID | installed app/sandbox identity | `com.gusigu.markei` |
| Display label | user-visible app name | `Markei` |
| Account ID | data-owner placeholder | retain `local-account` |
| Device UUID | installation-local event/sequence owner | persisted UUID v4 |
| Product internal ID | local stable Product identity | unchanged |
| Product user code | user-controlled opaque catalogue reference | unchanged |
| Event UUID | retry/idempotency identity | unchanged |
| Sequence | order within one Device | monotonic and reused Device owner |

Reject any patch that renames `windows-device` to `android-device`, derives Device identity from hardware/email/platform, or treats application ID as Account/Device identity.

# 4. Toolchain concepts to evidence

H must explain briefly:

- Flutter SDK versus Android SDK;
- Android Studio versus VS Code;
- SDK Platform, Build-Tools, Platform-Tools, Command-line Tools, Emulator, CMake, and NDK;
- Gradle build host versus shared Dart runtime;
- application ID/namespace versus Kotlin package and display label;
- emulator versus physical device;
- debug signing versus production signing;
- app-private storage versus broad/shared storage.

Do not copy manuals. Tie each concept to actual repository or command evidence.

# 5. Persistent Device learning boundary

Source and tests must demonstrate:

```text
first app-private database
→ no Device row
→ create UUID v4
→ persist Device
→ allocate sequence under Device
→ close process
→ reopen same database
→ reuse UUID
→ continue sequence
```

Also demonstrate that a distinct fresh database creates a distinct UUID. Explain why Device identity and sequence state share one persistence boundary. Do not add secure storage merely because “identity” sounds sensitive; this UUID is not a secret.

# 6. Lifecycle distinctions

Report these separately:

- widget rebuild;
- rotation/configuration recreation;
- background/resume;
- Android Back;
- process termination;
- cold relaunch;
- app-data clear;
- uninstall.

Committed Purchase/History and Device UUID must survive ordinary process restart. Data-clear/uninstall may remove local-only state. Unsaved staged Items may visibly reset during rotation in this prototype, but partial or silent commit is forbidden.

# 7. Mobile functional evidence

Using D’s controlled data, evidence:

- long form scrolls on phone width;
- keyboard does not make required actions unreachable;
- validation remains visible;
- Back behavior is predictable;
- bottom navigation remains usable;
- portrait workflow completes;
- landscape/rotation does not corrupt committed state;
- larger text does not create a blocking overflow at the selected evidence scale;
- History displays Store, total, and item count;
- process restart restores History.

This is functional adaptability, not final UI design or accessibility certification. Record visual debt for a later sprint without widening implementation.

# 8. Debugging classification

Every failure must be assigned to one layer:

1. PATH/Flutter SDK selection;
2. Android SDK/licences;
3. emulator/device/ADB;
4. Gradle/Java/NDK;
5. Flutter build/deployment;
6. Dart runtime/composition;
7. Drift migration/persistence;
8. widget layout/input/navigation;
9. test/fixture;
10. host permission or human gate.

Do not “fix” a toolchain failure by redesigning domain code.

# 9. Required automated examples

Tests should be readable and demonstrate:

- valid UUID v4 creation;
- stable UUID after reopen;
- different UUID for separate fresh databases;
- monotonic sequence after reopen;
- migration/facts preserved if schema changes;
- atomic two-item Purchase;
- History projection;
- bounded phone-width widget behavior.

Tests must use fresh temporary databases and controlled values. They must not access Cycle 06 data.

# 10. Cross-platform evidence

H must preserve the distinction:

- Windows Flutter workflow: human-validated baseline;
- Android: new empirical target;
- Python/PySide6: protected regression/rollback baseline;
- iOS: generated or deferred, not validated;
- local queue: synchronization preparation only.

After Android changes, record Flutter analysis/tests, Windows build, and Python tests. A Windows build regression blocks acceptance even if Android works.

# 11. KANBAN and promotion

Do not edit permanent Didactic files or KANBAN during Codex materialization. No maturity change follows automatically from installation, generated code, passing tests, or a Codex explanation.

H may recommend later PDR2-A review and must list:

- concepts represented in source;
- concepts executed by tools;
- concepts observed by the human;
- concepts still unvalidated;
- misconceptions prevented;
- learner evidence still needed.

# 12. Required H structure

Replace `H_DDC_CODEX.md` with:

1. authority and inspected commit;
2. evidence ladder achieved;
3. identity distinctions;
4. toolchain concepts exercised;
5. Device bootstrap example;
6. lifecycle observations;
7. responsive/mobile observations;
8. test examples and results;
9. Windows/Python regression distinctions;
10. generated versus handwritten ownership;
11. failures classified by layer;
12. concepts still provisional;
13. no-maturity-change statement;
14. recommended permanent Didactic follow-up.

# 13. Stop conditions

Stop the Didactic acceptance claim if:

- build is called execution;
- launch is called persistence proof;
- emulator result is universalized;
- application ID and Device ID are conflated;
- Device UUID is platform-named or regenerated;
- data clear/uninstall is confused with ordinary restart;
- visual scaffold is called final UI;
- local queue is called synchronization;
- generated Android source is called product architecture;
- learner mastery is inferred from Codex work;
- permanent Didactic files are edited.

# 14. Completion

E is satisfied only when the resulting evidence can answer, in plain language:

```text
Which SDK did we use?
What was installed?
What was built?
Where did it run?
Which identity owns the installation?
What survived restart?
Which mobile behaviors were exercised?
What still belongs to later UI, cloud, and release work?
```
