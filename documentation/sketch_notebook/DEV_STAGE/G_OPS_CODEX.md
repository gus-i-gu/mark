# G_OPS_CODEX — MCG-02 Native Closure Operational Evidence

- Authority marker: C10-MCG02-NATIVE-CLOSURE_20260718T140335Z
- Required provider-foundation ancestor: ade6e2c1f19ae3ebf318457d7ef76ac8dbe3bcae
- Resolved staging authority: 6fffad609bb83523d467a849e2d91f3c668af721 (`STAGING_COMMIT_SHA` in prompt was a placeholder; J/D/E/F identify this active native-closure staging).
- Baseline remote/local SHA: 6fffad609bb83523d467a849e2d91f3c668af721
- Actual implementation start: after branch/methodology/provider-boundary boot on 2026-07-18 local session; exact pre-command timestamp was not independently persisted before first shell command.
- Evidence timestamp: 2026-07-18T11:44:14.5496765-03:00
- Implementation tree before reports: d1f48239d213af5449736612544fc23afe99d7fb
- Final commit status: pending before commit.
- Evidence environment: Windows host, Flutter 3.44.6, Dart 3.12.2, Android SDK available, Windows symlink support disabled.
- Result classification: native Auth0 composition ready locally; decisive provider proof pending.

## Changed Paths

- `clients/markei_flutter/pubspec.yaml`
- `clients/markei_flutter/pubspec.lock`
- `clients/markei_flutter/android/app/build.gradle.kts`
- `clients/markei_flutter/android/gradle.properties`
- `clients/markei_flutter/lib/application/hosted_auth_ports.dart`
- `clients/markei_flutter/lib/app/markei_composition.dart`
- `clients/markei_flutter/lib/app/native_auth_closure_runner.dart`
- `clients/markei_flutter/lib/infrastructure/auth/auth0_native_authentication.dart`
- `clients/markei_flutter/lib/infrastructure/auth/native_auth_config.dart`
- `clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart`
- `clients/markei_flutter/windows/flutter/generated_plugin_registrant.cc`
- `clients/markei_flutter/windows/flutter/generated_plugins.cmake`
- `clients/markei_flutter/windows/runner/main.cpp`
- G/H/I reports.

Preserved without reading: `.vscode/`, `documentation/NEON_*`, `.env*`, and the pre-existing untracked provider-looking file `Enter only the POOLED Neon hostname`.

## Dependency And Platform Evidence

- Pinned `auth0_flutter: 2.4.0`.
- Official SDK evidence: Flutter 3.24.0+, Android API 21+, Windows 10+; repository has Flutter 3.44.6 and Dart 3.12.2.
- Android application ID verified and preserved as `com.gusigu.markei`.
- Android manifest placeholders derive callback/logout from Gradle property `MARKEI_AUTH0_DOMAIN` with inert placeholder fallback; no tenant value committed.
- Windows uses SDK-required `auth0flutter://callback` and runner plumbing for startup URI capture, current-user named pipe forwarding, single-instance routing and callback prefix validation.
- Android debug build required `kotlin.incremental=false` because Kotlin incremental cache failed across `H:` repo and `C:` pub cache roots.

## Tests And Validation

- `flutter pub get`: passed; lock updated for exact Auth0 SDK.
- `flutter pub get --enforce-lockfile`: passed.
- `dart format --set-exit-if-changed lib test`: passed.
- `flutter analyze`: passed, no issues.
- `flutter test test/infrastructure/native_auth_composition_test.dart`: 10 passed.
- `flutter test`: 72 passed, 2 skipped; existing Drift debug warnings only.
- `flutter build apk --debug`: passed, built `build\app\outputs\flutter-apk\app-debug.apk`; SDK emitted a future KGP migration warning.
- `flutter build windows --release`: host-excluded; Flutter reported Windows plugin builds require symlink support and Developer Mode is disabled. Host configuration was not changed.
- `git diff --check`: passed.
- Protected-path check for A/B/C, J, D/E/F, methodology and permanent domain folders: no changes.
- Tracked/untracked changed-path secret scan: no private-key, API-key, bearer literal, client-secret, password or database URL hits.
- Final `docker ps -a --filter name=markei-c10 --format "{{.Names}}"`: empty.

Server validation and protected Python regressions were excluded because no server, migration, shared API contract or Python path changed.

## Completed / Deferred

Completed: native typed configuration, Auth0 SDK adapter, ephemeral token lifecycle, Android callback composition, Windows callback routing, local closure runner and deterministic tests.

Deferred: human Auth0 login, Neon/Render hosted convergence, provider acceptance, permanent promotion, Cycle 10 closure, MCG-03 and MCG-04.
