# I_DSN_CODEX

> Cycle: 08
> Directive: C08-PB-01
> Status: Codex implementation evidence
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> Directive HEAD: `4f5ef21cb0d31f5efbf386b3e51cff15c543a802`

---

# 1. Source stage files

Design implementation authority came from:

- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`
- paired operational/language controls in `D_OPS_STAGE.md` and `E_DDC_STAGE.md`

C08-PB-01 is active and supersedes C08-IMP-01 plus earlier F authorization.

# 2. Architecture materialized

Preserved dependency direction:

```text
Flutter presentation -> application commands/query ports -> domain
infrastructure adapters -> Drift app-private SQLite
```

Added or extended:

- semantic shell destinations for Purchase, Products and History;
- Products presentation surface backed by `CatalogueQueryRepository`;
- catalogue Product creation through the local adapter without schema change;
- explicit `StoreReference` command boundary with existing/new variants;
- Purchase presentation session draft with stable line keys, review phase and in-flight guard;
- History detail application records that do not expose Drift rows;
- Product price observation records and a pure compatible-observation comparison function;
- local query adapter methods for Product creation, bounded summary counts, detail and comparison.

# 3. Important implementation choices

- Store selection uses `ExistingStoreReference(StoreId)` to preserve the selected UUID.
- Store creation uses `NewStoreReference(displayName)` and does not normalize branch identity or merge.
- Registration still uses the existing `LocalPurchaseRepository.registerPurchase()` transaction.
- Product similarity remains advisory; no automatic merge is introduced.
- Price comparison uses same Product, currency, measurement kind and canonical unit, then compares latest and previous compatible observations by occurrence time.
- Draft state remains mounted/session-only presentation state.

# 4. Files changed

- `clients/markei_flutter/lib/app/markei_app.dart`
- `clients/markei_flutter/lib/app/pages/history_page.dart`
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/lib/application/catalogue_queries.dart`
- `clients/markei_flutter/lib/application/purchase_history.dart`
- `clients/markei_flutter/lib/application/register_purchase.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart`
- `clients/markei_flutter/test/app/markei_app_test.dart`

# 5. Files created

- `clients/markei_flutter/lib/app/pages/products_page.dart`

# 6. Explicit exclusions preserved

Not added:

- new packages or frameworks;
- schema versions, migrations, tables, columns or indexes;
- generated Drift output changes;
- optional Product code;
- Store normalization, branch identity or uniqueness;
- durable SubmissionId/idempotency;
- persisted drafts;
- Device relation changes;
- authentication, API, Neon or synchronization;
- export/restore;
- analytics cache, forecasting or official inflation;
- registered Purchase mutation;
- Python/PySide6 source changes.

# 7. Validation evidence

Passed:

```text
flutter test test/app/markei_app_test.dart -r expanded
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
python -m unittest discover -s tests
```

Results:

- focused app tests: 6 passed;
- full Flutter tests: 31 passed;
- analyzer: no issues found;
- Windows build: passed;
- Python regression: 5 passed.

Host-unvalidated:

```text
flutter build apk --debug
```

Reason:

```text
JAVA_HOME is not set and no 'java' command could be found in your PATH.
```

# 8. Residual design risks

- The UI-level duplicate-submit guard is not durable idempotency.
- The Products page uses bounded local filtering, not pagination or indexed search.
- Price comparison is intentionally narrow and has no cache.
- App-session drafts are not restored after process death.
- Android runtime composition remains unvalidated on this host because the Java/Gradle prerequisite is absent.
