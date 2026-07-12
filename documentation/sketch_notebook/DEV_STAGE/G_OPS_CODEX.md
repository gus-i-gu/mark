# G_OPS_CODEX - Cycle 07 Sprint 04 Operational Codex Report

> Status: Implemented and validated with Android host blocker
> Branch: `cycle-07-mobile-preparation`
> HEAD: `0b6abb8796e095928d31d4e6f1cb67660f3223d4`
> Baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Date: 2026-07-12

## Source Stage Files

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Preflight

- Branch verified: `cycle-07-mobile-preparation`.
- Remote branch head verified: `origin/cycle-07-mobile-preparation` at `0b6abb8796e095928d31d4e6f1cb67660f3223d4`.
- Baseline ancestry verified: `git merge-base --is-ancestor f6414fbe7394453387067a5a34ca6cc7621bbed3 HEAD` passed.
- Existing unrelated user change preserved: `documentation/PT_INTRO.md`.
- Initial Visual Studio state: Community 2022 existed but was incomplete/canceled.
- Visual Studio Build Tools 2022 was installed/modified with `Microsoft.VisualStudio.Workload.VCTools`, MSVC x64/x86 tools, CMake tools, and Windows 10 SDK.

## Files Created Or Changed

- Flutter source under `clients/markei_flutter/lib/`.
- Flutter tests under `clients/markei_flutter/test/`.
- Drift generated source: `clients/markei_flutter/lib/infrastructure/local/local_database.g.dart`.
- Flutter dependencies: `clients/markei_flutter/pubspec.yaml`, `clients/markei_flutter/pubspec.lock`.
- Versioned contracts: `contracts/shared_beta/v2/`.
- Codex reports: G/H/I.

## Implemented And Tested

- Product-code normalization separated from semantic Product identity.
- Unicode NFKC normalization and semantic punctuation handling.
- Product IDs changed to local UUID values, not identity-derived values.
- Similarity remains warning-only and performs no automatic merge.
- Device sequence no longer resets on repeated registration.
- Drift schema version 2 and v1 to v2 migration path.
- Shared `shared_beta/v2` JSON Schemas and examples.
- Contract validation tests with `json_schema`.
- Query/application ports for catalogue and purchase history.
- Composition root for the local Flutter client.
- Multi-item Purchase entry UI.
- Local Purchase history UI.
- Widget test for multi-item registration and history display.
- Windows release build and startup smoke launch.

## Commands Run

```text
git status --short --branch
git branch --show-current
git rev-parse HEAD
git rev-parse origin/cycle-07-mobile-preparation
git merge-base --is-ancestor f6414fbe7394453387067a5a34ca6cc7621bbed3 HEAD
flutter --version
dart --version
flutter doctor -v
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run build_runner build
dart format .
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
python -m unittest discover -s tests
```

Visual Studio remediation commands were also run through `winget install --id Microsoft.VisualStudio.2022.BuildTools -e --force ...` with the Flutter-required VCTools workload/components.

## Validation Results

- `flutter pub get`: passed.
- `dart format --output=none --set-exit-if-changed .`: passed.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed, 21 tests.
- `flutter doctor -v`: Flutter, Windows, Visual Studio, connected devices, and network resources passed; Android SDK and Chrome remain unavailable.
- `flutter build windows`: passed, built `build\windows\x64\runner\Release\markei.exe`.
- Windows launch smoke: built executable stayed running after 5 seconds and was stopped.
- `python -m unittest discover -s tests`: passed, 5 tests.

## Blocked Or Deferred

- Android build skipped: Android SDK is absent and Android tooling installation was prohibited.
- Chrome/web validation skipped: Chrome executable absent and web was outside scope.
- iOS runtime/build remains host-unvalidated on Windows.
- Human manual acceptance of the Windows UI remains required.

## Scope Evidence

- No Python source changes.
- `git diff -- app tests main.py` was empty after Python regressions.
- `git diff -- app/database/market.sqlite` was empty.
- No TypeScript, API, Neon, auth, networking, real sync, central catalogue identity, Product-code editing, legacy import, or PySide6 retirement was implemented.
