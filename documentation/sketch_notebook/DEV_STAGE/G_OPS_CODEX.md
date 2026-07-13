# G_OPS_CODEX

> Cycle: 08
> Directive: C08-PB-01
> Status: Codex implementation evidence
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> Directive HEAD: `4f5ef21cb0d31f5efbf386b3e51cff15c543a802`

---

# 1. Source stage files

Codex materialized the active C08-PB-01 directive from:

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

These stages are marked `ACTIVE -- CODEX PRODUCT IMPLEMENTATION AUTHORIZED` and supersede C08-IMP-01 plus earlier D/E/F authorizations.

# 2. Implemented behavior

- Added responsive top-level navigation for Purchase, Products and History.
- Added a Products page with local loading/empty/error/data states, search, no-match state and Product creation using mandatory Product code.
- Added advisory similar-Product flow with explicit use-existing/create-anyway choices.
- Reworked Purchase into a session-only multi-Item draft with stable line keys, edit, remove, totals, inline review, back-to-edit and in-flight duplicate-submit guard.
- Added existing/new Store references so explicit Store selection preserves Store UUID and explicit creation remains separate.
- Preserved MASS + BRL beta boundary in active Purchase inputs.
- Added detailed History with Purchase Items and safe loading/empty/failure/detail states.
- Added first “Price change in your purchases” query using latest two compatible same-Product observations.
- Kept registration on the existing atomic local Drift transaction.

# 3. Files changed

- `clients/markei_flutter/lib/app/markei_app.dart`
- `clients/markei_flutter/lib/app/pages/history_page.dart`
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/lib/application/catalogue_queries.dart`
- `clients/markei_flutter/lib/application/purchase_history.dart`
- `clients/markei_flutter/lib/application/register_purchase.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart`
- `clients/markei_flutter/test/app/markei_app_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

# 4. Files created

- `clients/markei_flutter/lib/app/pages/products_page.dart`

# 5. Generated validation artifacts

The required Python regression command generated `__pycache__` changes under `app/`, `app/core/`, and `tests/`. They are validation artifacts, not source implementation. They were not removed because the invocation prohibited discard/reset/clean.

# 6. Commands run

Preflight:

```text
git status --short --branch
git branch --show-current
git pull --ff-only
git rev-parse HEAD
```

Validation:

```text
dart format clients/markei_flutter/lib/... clients/markei_flutter/test/app/markei_app_test.dart
flutter test test/app/markei_app_test.dart -r expanded
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
flutter build apk --debug
python -m unittest discover -s tests
```

# 7. Validation results

Passed:

- `flutter test test/app/markei_app_test.dart -r expanded`: 6 tests passed.
- `dart format --output=none --set-exit-if-changed .`: 34 files checked, 0 changed.
- `flutter analyze`: no issues found.
- `flutter test`: 31 tests passed.
- `flutter build windows`: built `build\windows\x64\runner\Release\markei.exe`.
- `python -m unittest discover -s tests`: 5 tests passed.

Host-unvalidated:

- `flutter build apk --debug`: failed because `JAVA_HOME` is not set and no `java` command exists in `PATH`.

# 8. Deviations and blockers

- Android debug APK remains host-unvalidated due missing Java host configuration.
- Product creation success is verified by repository state and rendered Product list in tests; transient success copy is not asserted.
- Phone-width automated coverage verifies responsive shell/local/empty states; long scroll-form registration is covered by the wide app flow.
- No manual Windows or Android runtime smoke was performed.

# 9. Remaining risks

- Store creation intentionally does not normalize branch identity or prevent same-name duplicates.
- Duplicate-submit protection is in-flight UI mitigation only, not durable idempotency.
- Drafts remain mounted app-session state only and are not process-death recoverable.
- Price comparison is limited to compatible same-Product, same-currency, same-kind, same-unit local observations.
