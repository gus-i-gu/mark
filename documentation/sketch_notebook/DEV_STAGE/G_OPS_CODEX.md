# G_OPS_CODEX - Windows Runtime Packaging Evidence

- Authority marker: C10-MCG02-WINDOWS-RUNTIME-PACKAGING_20260719T155742Z
- Baseline SHA after fast-forward: a892c2628df7425124be0e64db66697b7b572b4d
- Required ancestor retained: a892c2628df7425124be0e64db66697b7b572b4d
- Final commit SHA: resolved by Git after this report is committed and pushed; Codex terminal response reports it.
- Evidence environment: Windows host, Flutter/Dart local toolchain, CMake with validation-time `CMAKE_TOOLCHAIN_FILE`, `auth0_flutter` 2.4.0 pinned.
- Result classification: Windows runtime packaging corrected locally; clean provider retest required.

## Changed Paths

- `clients/markei_flutter/windows/runner/CMakeLists.txt`
- `clients/markei_flutter/test/infrastructure/windows_runtime_packaging_contract_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Preserved without reading or staging:

- `Enter only the POOLED Neon hostname`
- `clients/markei_flutter/Exact Auth0 API audience`
- `clients/markei_flutter/Windows Native Application Client ID`

## Commands and Results

- `git fetch origin intermid-cycle-recovery`: passed.
- `git pull --ff-only origin intermid-cycle-recovery`: already up to date.
- `git merge-base --is-ancestor a892c2628df7425124be0e64db66697b7b572b4d HEAD`: passed.
- `flutter clean`: exit 0, but reported `build` could not be fully removed because a file handle was open; later inspection found a stale Release `markei.exe` process.
- `flutter pub get --enforce-lockfile`: passed; `auth0_flutter` remained pinned at 2.4.0.
- `dart format --set-exit-if-changed lib test`: passed, 82 files checked, 0 changed after initial formatting of the new test.
- `flutter analyze`: passed, no issues.
- `flutter test test/infrastructure/windows_runtime_packaging_contract_test.dart test/infrastructure/windows_runner_callback_contract_test.dart test/infrastructure/native_auth_composition_test.dart test/app/native_closure_surface_test.dart`: passed, 28 tests.
- `flutter test`: passed, 91 tests and 2 existing skips.
- `flutter build windows --debug` with non-secret closure/Auth0/hosted defines and PATH stripped of vcpkg runtime `bin` entries: passed, built `build\windows\x64\runner\Debug\markei.exe`.
- `flutter build windows --release` with the same defines and PATH/toolchain environment: first attempt failed with `LNK1104` because stale PID 20280 locked `build\windows\x64\runner\Release\markei.exe`; after stopping that build-output process, the retry passed and built `build\windows\x64\runner\Release\markei.exe`.
- Direct launch validation under PATH stripped of vcpkg runtime `bin` entries: Debug responding `True`, Release responding `True`.
- Sanitized secondary callback launch under PATH stripped of vcpkg runtime `bin` entries: Debug secondary exited cleanly, Release secondary exited cleanly; no missing-DLL dialog was observed.
- `git diff --check`: passed.

Builds retained the existing vcpkg Boost CMP0167 developer warning from the pinned dependency path.

## Runtime Inventories

Debug runner DLLs:

- `auth0_flutter_plugin.dll`
- `boost_container-vc143-mt-gd-x64-1_91.dll`
- `boost_date_time-vc143-mt-gd-x64-1_91.dll`
- `cpprest_2_10d.dll`
- `dartjni.dll`
- `flutter_windows.dll`
- `sqlite3_flutter_libs_plugin.dll`
- `sqlite3.dll`

Release runner DLLs:

- `auth0_flutter_plugin.dll`
- `boost_container-vc143-mt-x64-1_91.dll`
- `boost_date_time-vc143-mt-x64-1_91.dll`
- `brotlicommon.dll`
- `brotlidec.dll`
- `brotlienc.dll`
- `cpprest_2_10.dll`
- `dartjni.dll`
- `flutter_windows.dll`
- `legacy.dll`
- `libcrypto-3-x64.dll`
- `libssl-3-x64.dll`
- `sqlite3_flutter_libs_plugin.dll`
- `sqlite3.dll`
- `z.dll`

Release debug-suffix scan returned empty.

## Scans and Exclusions

- Clean PATH evidence: filtering command returned no vcpkg `bin` or `debug\bin` entries.
- Tracked secret/private-name scan found only pre-existing tracked references: `clients/markei_flutter/lib/infrastructure/auth/auth0_native_authentication.dart`, `documentation/NEON_DOC.md`, `documentation/NEON_SESSION.ps1`.
- Tracked binary/generated-artifact scan found pre-existing Python desktop/package binaries only; no `clients/markei_flutter/build`, Flutter Windows runner DLL, vcpkg checkout or native package cache was tracked by this correction.
- No Auth0, Neon, Render, provider credential, registry export, Device enrollment, hosted synchronization, migration, Drift schema, server authorization, dependency upgrade, installer, permanent memory, methodology, MCG-03 or MCG-04 operation was performed.

Human evidence retained: Windows release build, Auth0 signup/login, callback consumption, authorization-code exchange, authenticated state, status preservation, logout and re-sign-in passed after manually copying release runtime DLLs. This unit replaces that manual copy with reproducible build-output runtime packaging and requires a clean provider retest.
