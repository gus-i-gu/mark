# Operational State of Union — Cycle 07 Sprint 05 Android Preparation

> Role: Operational Chat [O]
> Status: Temporary functional staging for Main reconciliation
> Repository: `gus-i-gu/markei`
> Branch: `cycle-07-mobile-preparation`
> Accepted baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Inspected remote head: `f6c499c94aca2b7cc4a25cf28bdbbf7e9b0444f1`
> Date: 2026-07-12
> Sources: PRI-O, PMC-01, MSU-02, J §22, 00/05/06, Operational checkpoint, G_OPS_CODEX, human Windows evidence, bounded repository inspection, current official Flutter/Android documentation
> Classification: proposed, provisional, accepted, implemented, validated, host-unvalidated, blocked, deferred

## 1. Recovered Main State

Cycle 06 remains accepted, closed, and protected as the Python/PySide6 Windows beta. Its ordinary database at the established per-user Windows boundary remains a behavioral reference, rollback source, and future migration input. Sprint 05 must not open, migrate, copy, or modify it.

Cycle 07 Sprint 04 is materially complete as a Windows-local Flutter vertical slice. Repository and Codex evidence show implemented Product user-code/internal-ID separation, Unicode normalization v2, corrected device sequencing, Drift schema v2 and v1→v2 migration tests, `shared_beta/v2` JSON Schemas/examples, a multi-item Purchase interface, History projection, 21 passing Flutter tests, five passing Python regressions, a successful Windows release build, and startup smoke.

New human evidence strengthens the Windows classification: Flutter 3.44.6/Dart 3.12.2 are available; `flutter pub get`, Windows build/launch, Purchase registration, History display, close/reopen, and persistence succeeded. These observations make the bounded Windows local workflow **validated by human execution**, subject to preserving the exact SDK path and command transcript in the next evidence report. They do not validate Android.

Main has selected Cycle 07 Sprint 05 as Android full implementation at debug-development scope. Android planning is **accepted**; installation and implementation remain inactive until Main writes fresh D/E/F and the human approves exact host mutations. Play Store release, production signing, authentication, API/Neon, real synchronization, iOS, and broad UI redesign remain deferred.

## 2. Hierarchical Recovery Path

Recovery followed:

`AGENTS → INDEX → PROMPT_COLLECTION/PRI-O/PMC-01/MSU-02 → latest J §22 → 00_PROJECT_STATE → latest relevant 05 segment → active 06 Android checkpoint → operational/10_OPERATIONAL_STATE → G_OPS_CODEX → bounded repository truth`.

The permanent Operational checkpoint was required because MSU-02 names the role checkpoint. It is stale: it predates Sprint 04 materialization. No deeper permanent Operational file was needed because J §22, 00, 06, G, human evidence, and current source resolve the present execution state. The checkpoint’s drift should be corrected later through PDR2-O, not in this staging task.

## 3. Repository Surfaces Inspected

Operational inspection covered:

- Flutter manifest and dependency resolution: `pubspec.yaml`, lockfile, Android Gradle settings, app build configuration, manifest, and generated platform topology;
- handwritten startup/composition, Purchase/History UI, persistence schema/migration, repositories, and tests;
- `contracts/shared_beta/v2` presence and validation evidence;
- Sprint 04 G report and current Main continuity;
- protected Python entrypoint, database boundary, regression evidence, packaging boundary, and Cycle 06 isolation;
- generated Android project files as configuration inputs, without treating generated source as handwritten truth.

Current Android configuration uses Java 17 compatibility, Flutter-selected compile/minimum/target SDK and NDK versions, generated namespace/application ID `com.example.markei`, debug signing for the current release build block, and label `markei`. Current composition still injects `local-account` and `windows-device`. The latter is a cross-platform correctness defect for Android preparation.

## 4. Operational Current State of Union

### Windows evidence

Windows is now **validated** for the bounded local workflow by combined automated and human evidence: dependency resolution, tests, release build, launch, two-item Purchase registration, History projection, close/reopen, and persistence. The next Android materialization must preserve this evidence with a repeatable Windows regression run.

Windows packaging/install lifecycle of the original PySide6 beta remains separately accepted from the Flutter Windows debug/release-local workflow. A successful Flutter Windows build does not retire PySide6 or prove Flutter installer distribution.

### Android implementation state

The Android project is **implemented only as generated configuration** and **host-unvalidated**. There is no accepted SDK installation, license result, emulator/device, APK, launch, lifecycle, or app-private persistence evidence. The repository has no broad-storage permission, which is correct for the local database boundary. Drift resolves `markei_shared_beta.sqlite` through the platform application-support directory, but its concrete Android path and lifecycle behavior remain unvalidated until run on Android.

Two source changes are prerequisites for acceptance, not optional cleanup:

1. replace `com.example.markei` with a stable human-approved application ID and set the visible label to `Markei`;
2. replace fixed `windows-device` with one generated, persisted, platform-neutral Device UUID that survives restart on Windows and Android.

A build performed before these corrections may diagnose the toolchain, but it cannot complete Sprint 05.

## 5. Flutter SDK Path Discrepancy

Human/environment evidence names two Flutter locations:

```text
H:\Users\Gus\develop\flutter
C:\Users\gusrm\flutter
```

This is **unresolved**, not proof that either installation is wrong. Plausible causes are two Flutter clones, an old PATH entry, a shell-specific PATH, VS Code configured to one SDK while PowerShell resolves another, or Android `local.properties` generated from a different executable.

The operational rule is convergence, not deletion. Before installation or build, D_OPS should capture:

```powershell
where.exe flutter
Get-Command flutter -All | Format-List Source,Version
flutter --version
dart --version
flutter doctor -v
$env:Path -split ';' | Where-Object { $_ -match 'flutter|dart' }
Get-Content .\clients\markei_flutter\android\local.properties
git -C "H:\Users\Gus\develop\flutter" rev-parse HEAD
git -C "C:\Users\gusrm\flutter" rev-parse HEAD
```

Do not execute both Git commands blindly if a directory does not exist; first use `Test-Path`. Record each existing clone’s channel/revision and working-tree status. The selected SDK must be Flutter 3.44.6/Dart 3.12.2 unless D/E/F explicitly authorize an upgrade. PATH’s first `flutter.bat`, `flutter doctor -v`, and `android/local.properties` `flutter.sdk` must identify the same approved directory.

If both clones are clean and identical, retain one as the active SDK and leave removal as a separate human decision. If revisions differ, stop before `pub get` or Android generation until Main/human chooses the authoritative clone. Do not move or delete SDKs during Sprint 05 materialization unless explicitly authorized. `local.properties` is host-local generated configuration and must not be treated as portable source truth.

## 6. Exact Android Prerequisites and Installation Gates

Current official Flutter Android setup for Windows calls for the latest stable Android Studio, Android SDK API level 36, Build-Tools, Command-line Tools, Emulator, Platform-Tools, CMake, and NDK side-by-side, followed by SDK license review. The repository defers exact compile SDK and NDK numbers to the pinned Flutter SDK, so D_OPS must re-read the values reported by Flutter/Gradle immediately before installation rather than hard-code an assumed patch version. [Flutter Android setup](https://docs.flutter.dev/platform-integration/android/setup)

Pre-install gates:

- settle the active Flutter SDK path;
- capture free disk space and chosen Android SDK/AVD locations;
- capture Windows architecture and virtualization state;
- confirm whether Android Studio, Java, SDK, `adb`, or an emulator already exists;
- preserve existing Android/Java/IDE configuration;
- choose emulator-primary or physical-device-primary route;
- require explicit human approval for installer/UAC prompts and licenses.

Authorized component candidate for D/E/F:

```text
latest stable Android Studio compatible with pinned Flutter
Android SDK Platform 36
Android SDK Build-Tools
Android SDK Command-line Tools (latest)
Android Emulator
Android SDK Platform-Tools
CMake
NDK (side by side) matching flutter.ndkVersion
one compatible emulator system image
OEM USB driver only for the chosen physical device when Windows requires it
```

Android Studio’s setup wizard/SDK Manager is the recommended installation boundary. The Flutter plugin alone is insufficient; the Flutter SDK and its `bin` must remain on PATH. License acceptance is a separate human-readable gate:

```powershell
flutter doctor --android-licenses
```

Success requires the actual “all required licenses accepted” result; it cannot be inferred. Android Studio installation and emulator acceleration requirements follow the official Android guidance. [Android Studio installation](https://developer.android.com/studio/install), [emulator acceleration](https://developer.android.com/studio/run/emulator-acceleration)

## 7. Device Route

The recommended primary route is one x64 Android emulator because it is reproducible, resettable, and does not depend on personal device state. It requires firmware virtualization, Windows hypervisor acceleration, sufficient RAM/disk, one Phone image, and visibility through both `flutter emulators` and `flutter devices`.

A physical device is the fallback when emulator acceleration is unavailable or unstable. It requires developer options, USB or wireless debugging, explicit device authorization, and possibly an OEM Windows driver. Device identity in evidence must be sanitized. No rooting, bootloader changes, security bypass, or personal-data access belongs in scope. ADB is only the diagnostic/deployment bridge. [Android Debug Bridge](https://developer.android.com/tools/adb)

Device-ready gate:

```powershell
flutter emulators
flutter devices
adb devices -l
```

Exactly one intended target should be selected for the acceptance run. An unauthorized/offline device, ambiguous duplicate device, or emulator crash is a stop, not a reason to broaden troubleshooting indefinitely.

## 8. Reproducible Command Plan

These commands are proposed for later D/E/F execution; none was run in this investigation:

```powershell
# Repository and SDK preflight
git status --short --branch
git branch --show-current
git rev-parse HEAD
git rev-parse origin/cycle-07-mobile-preparation
where.exe flutter
Get-Command flutter -All
flutter --version
dart --version
flutter doctor -v

# After authorized Android installation
flutter doctor --android-licenses
flutter doctor -v
flutter emulators
flutter devices
adb devices -l

# Flutter project validation
cd .\clients\markei_flutter
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
flutter run -d <android-device-id>

# Cross-platform regression
flutter build windows
python -m unittest discover -s ..\..\tests
```

`flutter clean` is limited to generated build outputs. It must not touch application source, contracts, user databases, or the protected Python database. Record Flutter/Dart/Java/Gradle/SDK/NDK versions, target identifier, APK path/size, warnings, duration, logs, and every exit result.

## 9. Data Isolation and Lifecycle Procedure

Use controlled test data only. Before launch, capture the expected Windows Flutter database and Cycle 06 Python database locations without opening or hashing personal contents unless D/E/F explicitly defines a privacy-safe method. Android must use app-private storage; no external-storage permission or shared database-file access is required.

Acceptance sequence:

1. install/run the debug app on the chosen target;
2. record a sanitized app-private database path through application diagnostics or approved `run-as` inspection;
3. create one Store, two Products, and a two-item Purchase using controlled values;
4. verify total and History;
5. background/resume;
6. exercise keyboard, focus, scrolling, back, portrait/landscape, and narrow layout;
7. terminate the process without clearing app data;
8. relaunch and verify History and sequence continuity;
9. perform an ordinary second Purchase and verify the next device sequence;
10. distinguish process stop, force-stop, app-data clear, and uninstall: data clear/uninstall are expected to remove local-only data and must not be used during the persistence pass.

Do not access Windows files from Android. Do not request broad storage permissions. An ordinary crash or reopen must never silently create a fresh database over recoverable state.

## 10. Validation Matrix

| Gate | Pass condition | Classification before Sprint 05 |
| --- | --- | --- |
| SDK convergence | PATH, doctor, local.properties use one pinned SDK | blocked/unresolved |
| Android Studio/SDK | required components installed and recorded | blocked |
| Licenses | command reports all required licenses accepted | blocked |
| Device | one emulator/physical target online | blocked |
| Application ID | approved stable non-example ID | proposed |
| Device UUID | generated once, persisted, reused after restart | proposed |
| Static/unit tests | analysis clean; 21+ Flutter tests pass | previously validated; rerun required |
| Debug APK | `flutter build apk --debug` succeeds | host-unvalidated |
| Android launch | app reaches Purchase/History UI | host-unvalidated |
| Two-item Purchase | atomic success and correct total | host-unvalidated |
| History | Store, total, item count visible | host-unvalidated |
| App-private DB | no external permission; private path evidenced | host-unvalidated |
| Background/resume | no loss or duplicate commit | host-unvalidated |
| Back/keyboard/rotation | bounded workflow remains usable | host-unvalidated |
| Process restart | facts/history/device UUID persist | host-unvalidated |
| Sequence | next Purchase advances monotonically | host-unvalidated |
| Windows regression | build plus human/local workflow remains sound | validated baseline; rerun required |
| Python regression | five tests pass; ordinary DB unchanged | validated baseline; rerun required |
| Synchronization | no claim; queue remains local | deferred |

## 11. Agreement, Drift, and Questions

Agreement: J §22, 00, 06, G, human Windows evidence, and source agree that Sprint 04 delivered the Windows-local workflow and Android is the next platform boundary.

Drift: `operational/10_OPERATIONAL_STATE.md` is stale and must later be reconciled through PDR2-O. Older A staging is Sprint 04-oriented and is replaced by this report. G’s Windows smoke/manual-pending boundary is superseded only by the new human manual evidence, not by new automated logs.

Unresolved Main/human questions:

- Which Flutter clone is authoritative: H: or C:, and why do shell/editor/Gradle disagree?
- Is `com.gusigu.markei` the accepted stable Android application ID?
- Is emulator-primary acceptable, with physical device as fallback?
- What Android SDK and AVD installation directories and disk budget are approved?
- May D/E/F authorize Android Studio GUI installation, command-line installation, or only one?
- What privacy-safe mechanism should evidence the Android database path?
- Should the persistent Device UUID live in Drift device metadata or another app-private store? Design must decide exact ownership.

## 12. Recommended Sprint 05 Materialization Scope

One bounded unit should:

1. converge the Flutter SDK path without removing either clone;
2. install and validate exactly the approved Android components;
3. accept licenses with the human present;
4. create one emulator or connect one physical device;
5. stabilize application ID/label;
6. persist one platform-neutral Device UUID;
7. build the debug APK and run it;
8. execute Purchase/History/lifecycle/persistence validation;
9. correct only Android blockers in the bounded workflow;
10. rerun Flutter, Windows, and Python regressions;
11. produce G/H/I that separate installed, doctor-green, built, launched, interacted, lifecycle-passed, and human-observed evidence.

## 13. Explicit Non-Goals and Stop Conditions

Non-goals: Play Store, production signing/keystore, release publication, authentication, TypeScript API, Postgres/Neon, real synchronization, central catalogue, editing/deletion, legacy import, PySide6 retirement, iOS, broad redesign, or broad analytics.

Stop if the Flutter executable/path is ambiguous; installation scope or licenses are not approved; disk or virtualization prerequisites fail; existing SDK/JDK/IDE state would be destructively replaced; doctor remains red for required Android components; no target becomes online; application ID is unresolved; Device identity resets; APK build requires unrelated architectural change; app requests broad storage; database path reaches shared/Cycle 06 data; process restart loses facts; sequence duplicates; Android correction breaks Windows/Python regressions; or changed files exceed D/E/F scope.

## 14. Handoff to Main

A is ready for Sprint 05 Android D/E/F synthesis. Main should first resolve the authoritative Flutter SDK path, application ID, device route, installation mechanism/directories, and Device UUID ownership. D_OPS must make installation and evidence gates exact; F must constrain identity and Android source changes; E must distinguish generated, built, launched, interacted, and persistent evidence. Windows is now the regression baseline, Android is the active empirical boundary, and synchronization remains deferred.
