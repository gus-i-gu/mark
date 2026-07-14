# G_OPS_CODEX — Cycle 09 Codex Evidence

> Sequence: FLX-ORD-01
> Unit: C09-U02
> Branch: `intermid-cycle-recovery`
> Starting commit: `06714d719c22ebd6b64008b7dcec745faee8fcd5`
> Status: Codex materialization evidence, not canonical memory

## Execution

- Full executive boot completed from checkout: AGENTS, INDEX, PROMPT_COLLECTION, METHOD_FOUNDATIONS, FLUX, PROMOTION_RULES, CHAT_PROTOCOL, CHAT_BEHAVIOUR, METHOD_GLOSSARY, J, D, E, F.
- Safety checks passed: branch was `intermid-cycle-recovery`; HEAD descended from `b93c688496d2995c17d5328aadb348ee8c980da5`; remote was `origin https://github.com/gus-i-gu/markei.git`.
- Active J/D/E/F were Cycle 09 C09-U02 and authorized this materialization envelope.
- Protected Python/PySide6 source and database were not modified.

## Implementation

- Implemented schema v3 in the Flutter local Drift database.
- Added People, Payment Methods, Account preference, nullable Purchase references, nullable BULK package count, and Product normalization version 3.
- Added sequential migration coverage for v1/v2 databases, deterministic legacy code retention, v3 identity rewrite, and no silent reset close/reopen evidence.
- Added typed failure contract, comma/point quantity parsing, COUNT fractional rejection, exact Product lookup ports, optional references, local Lists projections, and deterministic selected-Purchase export DTOs.
- Added Home, Lists, Catalogue wording/details, Purchase optional labels and BULK/PACKAGED controls, History multi-selection/export actions, disabled Analytics/Household/edit/delete, Guide, Documentation, and Settings.
- No new package dependency was added; PDF bytes and CSV are generated with Dart standard libraries. Share is explicit file save with manual share boundary.

## Changed Paths

- Flutter app/composition/pages under `clients/markei_flutter/lib/app/`.
- Application contracts under `clients/markei_flutter/lib/application/`.
- Domain Product/Purchase/quantity/reference contracts under `clients/markei_flutter/lib/domain/`.
- Local Drift database/repositories and generated Drift artifact under `clients/markei_flutter/lib/infrastructure/local/`.
- Focused tests under `clients/markei_flutter/test/`.
- This report plus H/I reports.

## Validation

- `flutter pub get`: passed; existing dependencies resolved, no new dependencies added.
- `dart run build_runner build --delete-conflicting-outputs`: passed; Drift generated code updated. The flag was reported ignored by this build_runner version.
- `dart format lib test`: passed; touched Dart files formatted.
- `flutter test`: passed, 39 tests.
- `flutter analyze`: passed, no issues.
- `git diff --check`: passed; only CRLF warning notices.
- `python -m pytest`: blocked, active Python has no `pytest` module.
- `python -m pip install -r requirements-dev.txt`: passed but requirements only contained PyInstaller, not pytest.
- `python -m unittest tests.test_release_configuration`: passed, 5 tests.
- `flutter build windows`: passed; built `build\windows\x64\runner\Release\markei.exe`.
- Windows bounded smoke: launched built exe, process stayed running for 5 seconds, then Codex stopped the launched process.
- `flutter build apk`: blocked by host environment: `JAVA_HOME` unset and no `java` on PATH.
- `where.exe java`: confirmed Java not found.

## Evidence Boundaries

- Flutter widget tests are widget/runtime evidence, not manual platform acceptance.
- Windows build plus bounded launch is build/smoke evidence, not full lifecycle acceptance.
- Android runtime remains host-unvalidated because Java/Gradle toolchain is unavailable.
- PDF/share behavior is local file generation with explicit manual sharing; no OS share plugin or upload was activated.
- Local pending events remain local storage and were not treated as synchronization.

## Blockers And Risks

- Android build/runtime could not be validated on this host without Java.
- `pytest` was unavailable; protected Python validation was executed with the repository's `unittest` regression instead.
- The Cycle 09 UI is functional but compact; further manual UX review is still warranted for dense mobile layouts.
- No Product correction, Store identity redesign, sync, auth, persisted drafts, registered edit/delete, or Product auto-merge was introduced.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
