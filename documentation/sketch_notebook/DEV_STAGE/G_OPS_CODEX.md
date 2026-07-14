# G_OPS_CODEX — Cycle 09 Sprint 02 Codex Evidence

> Sequence: FLX-ORD-01
> Unit: C09-S02
> Branch: `intermid-cycle-recovery`
> Starting commit: `5ddff3c5eae582f0e25c1ecd0cfb3fe962026cf3`
> Status: Codex execution evidence only; not canonical memory

## Boot And Safety

- Read in required order: `AGENTS.md`, `INDEX.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`.
- Also inspected A/B/C, smallest relevant operational/didactic/design checkpoints, target mockups `01` through `05`, Flutter source, schema, migrations, tests, and pubspec.
- Verified branch `intermid-cycle-recovery`; HEAD and `origin/intermid-cycle-recovery` were `5ddff3c5eae582f0e25c1ecd0cfb3fe962026cf3`.
- Required staging ancestor `5ddff3c5eae582f0e25c1ecd0cfb3fe962026cf3` was present.
- Worktree was clean before mutation.
- J reconciled Main decisions; D/E/F jointly supplied implementation authority.
- A/B/C remained investigation only.

## Implementation Summary

- Added SDK-first Markei theme and reusable card/state/chip components.
- Changed compact navigation to Home / Lists / Purchase / History / More while preserving the IndexedStack state model.
- Added schema v4 with non-null Product code columns, visible People codes `@001...`, visible Payment Method codes `#001...`, and account preference counters.
- Added deterministic v4 Product code backfill for legacy null/blank codes using reserved `legacy:` namespace.
- Added v1/v2 chained migration coverage through v4 and file-backed reopen evidence.
- Added transactional visible-code allocation for new People and Payment Methods.
- Added required blank Purchase date and Time fields; parsing accepts exact `dd/mm/yyyy` and `HH:mm` and stores the buying moment as UTC.
- Added exact Product-code lookup in Purchase; lookup fills immutable Product facts without staging an Item.
- Added BULK fixed-point line-total calculation from amount, selected unit, and price per same selected unit; final total is read-only.
- Adjusted Catalogue selection so ordinary tap selects; explicit View details and double-click open details.
- Adjusted Lists zero-history language to distinguish `No Purchase history` from `Not enough history`.
- Adjusted Settings/History labels to resolve current and archived `code · nickname`.
- Added History select-all and desktop double-click detail access.
- Added regression proving existing Product ID retention and no duplicate Product creation when Item values change.

## Changed Paths

- App UI: `clients/markei_flutter/lib/app/markei_app.dart`
- App pages: `history_page.dart`, `products_page.dart`, `purchase_page.dart`
- New app components: `clients/markei_flutter/lib/app/design/markei_theme.dart`, `clients/markei_flutter/lib/app/widgets/markei_components.dart`
- Application: `bulk_pricing.dart`, `purchase_occurrence.dart`, `product_lists.dart`
- Domain: `product_code.dart`, `local_reference.dart`
- Infrastructure: `local_database.dart`, `local_database.g.dart`, `local_purchase_repository.dart`, `local_query_repository.dart`
- Tests: `markei_app_test.dart`, `local_database_migration_test.dart`, `local_purchase_repository_test.dart`, `purchase_contracts_test.dart`
- Reports: G/H/I Codex files only.

## Validation

- `git fetch origin intermid-cycle-recovery`: passed.
- `git merge-base --is-ancestor 5ddff3c5eae582f0e25c1ecd0cfb3fe962026cf3 HEAD`: passed.
- `dart run build_runner build --delete-conflicting-outputs`: passed; Drift generated output updated; flag reported ignored by current build_runner.
- `dart format lib test`: passed.
- `flutter test test/infrastructure/local_database_migration_test.dart`: passed, 3 tests.
- `flutter test test/local_purchase_repository_test.dart`: passed, 6 tests.
- `flutter test test/application/purchase_contracts_test.dart test/application/lists_and_export_test.dart`: passed, 5 tests.
- `flutter test test/app/markei_app_test.dart`: passed, 7 tests.
- `flutter test`: passed, 43 tests.
- `flutter analyze`: passed, no issues.
- `flutter pub get`: passed.
- `flutter pub outdated`: passed; no new dependencies added; existing packages have available updates.
- `dart format --output=none --set-exit-if-changed lib test`: passed.
- `python -m pytest`: blocked, `pytest` not installed.
- `python -m unittest`: discovered 0 tests.
- `python -m unittest discover tests`: passed, 5 tests; generated Python pycache changes were restored.
- `flutter build windows`: passed; built `build\windows\x64\runner\Release\markei.exe`.
- Bounded Windows smoke: started release executable hidden for 5 seconds and stopped it; result `started-and-stopped`.
- `flutter build apk`: blocked by host, `JAVA_HOME` unset and no `java` in PATH.
- `git diff --check`: passed; only CRLF warnings.

## Evidence Boundaries

- Native OS PDF sharing dependency was not adopted; deterministic PDF save/export remains. Native share is host-unvalidated/deferred rather than accepted.
- Android runtime/install/lifecycle/share workflow was blocked by missing Java/Android runtime path.
- Windows evidence is build plus bounded launch smoke, not manual workflow acceptance.
- Responsive evidence is widget-level for compact/expanded navigation and selected destination survival.
- Accessibility evidence is limited to explicit tap/button alternatives in widgets; no separate screen-reader manual pass was run.

## Residual Risks

- Markei UI foundation is present but not a full target-mockup pixel/composition implementation.
- Lists projection keeps the existing joined-query approach and language repair; deeper table/card target polish remains.
- Native share adapter remains a D/E/F deviation and should be staged separately after dependency approval.
