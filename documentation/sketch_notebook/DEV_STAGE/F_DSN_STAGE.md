# F_DSN_STAGE — Cycle 07 Sprint 04 Design and File Authority
> Authority: Main Chat [M]
> Sources: `C_DESIGN.md`, J §21, `06_SESSION_SCHEME.md`
> Status: Main-approved Codex materialization stage
> Repository: `gus-i-gu/markei`
> Branch: `cycle-07-mobile-preparation`
> Companions: `D_OPS_STAGE.md`, `E_DDC_STAGE.md`
> Outcome: corrected local domain plus first Windows-executed Flutter Purchase workflow

---

# 1. Dependency boundary

Preserve:

```text
Flutter presentation/composition
→ application use cases and query ports
→ domain models and invariants
← infrastructure Drift adapters
```

Rules:
- presentation does not import Drift;
- domain imports neither Flutter nor Drift;
- application owns coordination;
- infrastructure owns persistence and transactions;
- no network exists in Sprint 04;
- Python does not participate in Flutter runtime;
- Cycle 06 storage remains separate.

# 2. Repository boundary

Keep:

```text
app/                         protected Python/PySide6 beta
clients/markei_flutter/      shared Flutter client
contracts/                   versioned language-neutral contracts
documentation/               Sketch Notebook
```

Do not move or rename these roots.
Do not create another client or a TypeScript service.

# 3. Authorized Flutter responsibilities

Expected responsibility map:

```text
clients/markei_flutter/lib/
├── main.dart
├── app/
│   ├── markei_app.dart
│   ├── markei_composition.dart
│   ├── pages/
│   │   ├── purchase_page.dart
│   │   └── purchase_history_page.dart
│   └── widgets/
├── application/
│   ├── register_purchase.dart
│   ├── catalogue_queries.dart
│   └── purchase_history.dart
├── domain/
│   ├── analytics/
│   ├── catalogue/
│   │   ├── product.dart
│   │   └── product_code.dart
│   ├── purchase/
│   ├── shared/
│   ├── store/
│   └── sync/
└── infrastructure/local/
    ├── local_database.dart
    ├── local_database.g.dart
    ├── local_purchase_repository.dart
    └── local_query_repository.dart
```

Equivalent smaller organization is allowed.
Do not create empty files merely to match this map.

# 4. Four Product identities

## 4.1 Internal Product ID

```text
ProductId
```

Rules:
- immutable;
- UUID v4 for new Products;
- application-generated through an injectable factory;
- database primary key and Purchase Item reference;
- event identity reference;
- not user-entered;
- not derived from Product meaning;
- existing v1 IDs preserved.

## 4.2 User Product code

```text
ProductCode
    displayValue
    normalizedKey
```

Rules:
- required for new Products;
- chosen by the user;
- display value preserved;
- 1–64 characters after trim;
- unique by account + normalizedKey;
- normalized by NFKC, trim, whitespace collapse, lowercase;
- punctuation preserved;
- never a primary key;
- never global identity;
- editing and reuse deferred.

## 4.3 Product Identification Set

Exact semantic identity remains:

```text
account
normalization version
normalized name
normalized brand
mode
measurement kind/package quantity for PACKAGED
```

Rules:
- exact identity can resolve an existing Product;
- exact key unique per account;
- exact key no longer generates Product ID;
- fuzzy similarity only warns;
- conflicting exact identity must not create a duplicate.

## 4.4 Future central identity

Do not add a central/global Product ID field.
Central catalogue identity is deferred.

# 5. Product model

Product contains:

```text
id
accountId
userProductCode
normalizationVersion
displayName
displayBrand
normalizedName
normalizedBrand
mode
measurementKind
packageQuantity when PACKAGED
creation/lifecycle facts already owned
```

New ProductDraft contains:
- user code;
- display name;
- display brand;
- mode;
- measurement kind;
- package amount/unit when PACKAGED.

Creation:
1. validate display input;
2. derive ProductCode;
3. derive normalization v2;
4. derive exact identity key;
5. receive/generated UUID v4;
6. return immutable Product.

Remove sentinel IDs such as `pending`.

# 6. Normalization v2

Add dedicated functions:

```dart
NormalizedProductFacts normalizeProductFacts(ProductDraft draft)
ProductCode normalizeProductCode(String displayCode)
```

Name/brand:
1. NFKC;
2. trim;
3. lowercase;
4. fixed punctuation-to-space;
5. collapse whitespace;
6. preserve Unicode accents.

Product code:
1. NFKC;
2. trim;
3. collapse whitespace;
4. lowercase;
5. preserve punctuation.

Do not use ASCII `\w` as an allowlist.
Set `productNormalizationVersion = 2`.
Never reinterpret stored v1 keys.

Document the semantic punctuation set.
At minimum include common separators:
`- _ , . ; : ! ? / \ ( ) [ ] { } ' "`.

# 7. Product reference in Purchase

Support:

```text
ExistingProductReference(ProductId)
or
NewProductReference(ProductDraft)
```

Every PurchaseItemDraft contains exactly one reference.

Rules:
- existing Product belongs to Purchase account;
- new code is unique;
- exact identity conflict directs user to existing Product;
- similarity returns candidates;
- user confirms select-existing or continue-create;
- no automatic merge.

A strictly validated mutually exclusive representation is acceptable if sealed types are disproportionate.

# 8. Store boundary

UI may:
- list Stores;
- reuse exact display-name match;
- create Store from non-empty name.

Store retains immutable internal ID.
Name is not a foreign key.
Branch/address/deduplication remain deferred.

# 9. Purchase aggregate

Purchase:
- immutable after registration;
- one or more Items;
- explicit account, Store, occurrence time, currency;
- total derived from lines.

PurchaseItem:
- immutable ID;
- Purchase ID;
- Product internal ID;
- package count > 0;
- dimensionally valid quantity;
- Money matching Purchase currency.

Invalid aggregate persists nothing.
Editing/deletion is deferred.

# 10. Device sequence

Correct ensure behavior:

```text
insert Device(nextSequence = 1) only when absent
never update existing nextSequence during ensure
```

Correct allocation:

```text
inside Purchase transaction
read nextSequence
assign to event
persist nextSequence + 1
```

Required invariant:

```text
unique(accountId, deviceId, deviceSequence)
```

Do not:
- allocate before domain validation;
- consume sequence on rollback;
- derive from event count;
- reset on registration.

# 11. Drift schema v2

Set schema version 2.

Products add:
- displayName;
- displayBrand;
- userProductCode;
- normalizedUserProductCode.

Required unique indexes:
- Products(accountId, normalizedUserProductCode);
- Products(accountId, exactIdentityKey);
- SyncEvents(accountId, deviceId, deviceSequence).

Replace global exact-key uniqueness with explicit account-scoped ownership where needed.

Storage columns may remain nullable only when SQLite migration mechanics require it; domain/repository invariants must require values for all v2 writes, and migration must backfill every v1 row before indexes are added.

# 12. v1→v2 migration

Applies only to Flutter `markei_shared_beta.sqlite`.

Steps:
1. detect v1;
2. add display/code columns safely;
3. backfill displayName from normalizedName where original is unavailable;
4. backfill displayBrand likewise;
5. assign account-unique temporary code `legacy-<stable-id-prefix>`;
6. normalize code;
7. preserve Product IDs;
8. preserve Purchase Item references;
9. preserve Purchases/events/pending/Device/cursor;
10. add indexes after backfill;
11. record runtime UTC migration;
12. fail without reset.

Temporary legacy codes are not user-confirmed.
Expose a bounded marker/prefix so later UI can request review.
Product-code editing is not added now.

# 13. Migration test

Create a reviewed v1 test database in a temporary path.

Insert deterministic:
- account;
- Device with sequence state;
- Product;
- Store;
- Purchase and Item;
- event;
- pending row.

Open through v2 and assert:
- all IDs unchanged;
- references intact;
- display/code backfilled;
- indexes active;
- sequence continues;
- pending row preserved;
- ledger updated.

Never copy or open a real database.

# 14. Migration ledger

Record:
- schema name;
- from version;
- to version;
- migration identifier;
- appliedAt runtime UTC.

If existing table shape limits this, add compatible columns or a clear v2 record.
Document compromise in I.
Do not falsify v1 execution time.

# 15. Contract v2 topology

Create:

```text
contracts/shared_beta/v2/
├── README.md
├── schemas/
│   ├── catalogue_product.schema.json
│   ├── purchase_aggregate.schema.json
│   └── purchase_registered_event.schema.json
├── examples/
│   ├── valid/
│   │   ├── packaged_product.json
│   │   ├── bulk_product.json
│   │   ├── one_item_purchase.json
│   │   ├── multi_item_purchase.json
│   │   └── purchase_registered_event.json
│   └── invalid/
│       ├── product_missing_code.json
│       ├── packaged_product_missing_quantity.json
│       ├── bulk_product_with_package_quantity.json
│       ├── purchase_without_items.json
│       ├── purchase_currency_mismatch.json
│       └── event_invalid_sequence.json
└── invalid_manifest.json
```

Additional bounded examples are allowed.
Do not modify v1.

# 16. JSON Schema rules

Use Draft 7.
Declare `$schema`.
Use local/self-contained references.
No network fetch.
Use `additionalProperties: false` for closed shapes.

Represent:
- IDs as strings;
- Product code length 1–64;
- dimensions/units/modes as enums;
- quantities as fixed decimal strings;
- money as integer minor units + currency;
- timestamps as UTC ISO-8601;
- versions as positive integers;
- Items as non-empty arrays.

Cross-field invariants remain Dart tests.

# 17. Contract tests

Add under `test/contracts/`.

Tests:
- load local schemas;
- validate all valid examples;
- reject all invalid examples from manifest;
- explain expected failure;
- run offline;
- separately test domain invariants.

Do not bundle contracts as runtime assets unless the app consumes them.
This Sprint treats them as development contracts.

# 18. Application ports

Preserve `PurchaseRegistrationRepository`.

Add query ports:

```text
CatalogueQueryRepository
    listProducts(accountId)
    listStores(accountId)
    similarityCandidates(accountId, draft)

PurchaseHistoryRepository
    listRecentPurchases(accountId)
```

Return domain/application read models.
Never return Drift generated rows to widgets.
One adapter may implement several ports.

# 19. History read model

```text
PurchaseHistoryEntry
    purchaseId
    occurrenceTime
    storeDisplayName
    currencyCode
    totalMinorUnits
    itemCount
```

Order newest occurrence first, then stable ID.
Initial limit may be 100.
No pagination.
No duplicate history table.
Query authoritative facts.

# 20. Composition root

Composition owns:
1. `WidgetsFlutterBinding.ensureInitialized()`;
2. one app-private LocalDatabase;
3. UUID provider;
4. repository adapters;
5. use cases/query services;
6. dependency injection into MarkeiApp;
7. database disposal where safely supported.

Do not create database per widget build.
Do not use global mutable service locator.
Tests inject memory/temp storage.

# 21. App shell

Replace static label.

Minimum navigation:
- Purchase;
- History.

Responsive:
- wide Windows: rail or two-pane permitted;
- narrow: bottom navigation/stacked form;
- readable validation;
- keyboard-friendly;
- no pixel-perfect requirement.

Do not mechanically copy PySide6 layout.

# 22. Purchase page

Required input:
- Store;
- occurrence date/time;
- currency;
- existing/new Product choice;
- Product code;
- display name/brand;
- PACKAGED/BULK;
- measurement kind;
- package amount/unit;
- package count;
- purchased quantity;
- line total.

Required actions:
- Add Item;
- view/remove staged Item before commit;
- view calculated total;
- Register Purchase.

Stage Items only in UI memory.
Commit only on Register.
Clear after success.
Retain safe input after error.

# 23. Similarity UX

For similar Product:
- display candidates and identity facts;
- allow select existing;
- allow confirmed create;
- never merge;
- never rewrite existing Product.

For exact conflict:
- select existing or show clear conflict;
- never create duplicate.

# 24. History page

Show:
- occurrence time;
- Store;
- formatted total;
- item count;
- Purchase reference where useful.

Refresh after registration.
Query on reopen.
Show empty and error states.
No edit/delete.

# 25. Money and quantity UI

Persist integer minor units.
A BRL-oriented two-decimal entry parser is allowed as presentation policy.
Domain Money remains currency + minor units.
Do not globalize two-decimal assumption.

Quantity supports:
- MASS: g/kg → KG;
- VOLUME: ml/l → L;
- COUNT: integral UNIT.

Never infer density.
Reject invalid pairs.

# 26. Transaction

One application call reaches one local transaction:

```text
ensure account
+ ensure Device without reset
+ resolve/create Store
+ resolve/select Product
+ validate Items
+ insert Purchase/Items
+ allocate sequence
+ insert purchase.registered
+ enqueue pending
= commit
```

No network.
No history-table write.
Failure rolls back everything.

# 27. Event v2

Continue local `purchase.registered`.

Payload v2 includes:
- internal IDs;
- Product code/display/normalized facts required by contract;
- complete Purchase;
- device sequence;
- normalization/payload versions.

Do not upload.
Do not mark sent.
Do not call synchronization complete.

# 28. Analytics

Keep existing registry.
Do not add broad analytics.
History total comes from Purchase facts.
Inflation/deflation and Storage/Shortage/Market remain deferred.

# 29. Error boundary

Classify:
- validation;
- duplicate code;
- exact identity conflict;
- similarity confirmation;
- persistence;
- migration;
- unexpected.

UI shows actionable messages.
Do not expose SQL/stack traces to ordinary users.

# 30. Test topology

Add equivalent responsibility-focused tests:

```text
test/domain/product_code_test.dart
test/domain/unicode_normalization_test.dart
test/contracts/json_schema_test.dart
test/infrastructure/device_sequence_test.dart
test/infrastructure/schema_v2_migration_test.dart
test/infrastructure/catalogue_query_test.dart
test/infrastructure/purchase_history_test.dart
test/application/register_purchase_test.dart
test/app/purchase_page_test.dart
test/app/history_page_test.dart
```

Retain existing tests.
Avoid one monolithic test.

# 31. Integration boundary

Authorize `integration_test/` when Windows supports it.

Flow:
1. launch;
2. create Store;
3. create Product/code;
4. stage two Items;
5. register;
6. open history;
7. verify row;
8. close/relaunch;
9. verify row.

If automation cannot close/relaunch, combine:
- repository persistence test;
- widget workflow test;
- human Windows checklist.

Never fabricate success.

# 32. Python boundary

No Flutter import/IPC with Python.
No Python schema edits.
No Python database access.
Python remains beta/reference/rollback/import source.
Run regressions only.

# 33. Generated source

Regenerate Drift through build_runner.
Do not hand-edit generated code.
Accept platform generated changes only when required by Flutter build.
Do not add build artifacts.

# 34. Authorized implementation paths

Only paths authorized by D:
- Flutter pubspec/lock;
- Flutter lib/test/integration_test;
- necessary conventional Windows/conditional Android generated files;
- contracts v2;
- G/H/I.

No permanent docs, A/B/C, J, 00/05/06, methodology, Python, installer, build, dist, or contracts v1 edits.

# 35. Explicit non-goals

No:
- Product-code editing/aliases/reuse;
- central/global catalogue identity;
- Store branch/address/deduplication;
- Purchase editing/deletion;
- auth/secure storage;
- TypeScript/API/Postgres/Neon;
- real sync/cursor/convergence;
- legacy Cycle 06 import;
- PySide6 retirement;
- iOS;
- Android runtime acceptance;
- production packaging;
- broad analytics;
- permanent-document promotion.

# 36. Acceptance gates

Pass when:
- four identity responsibilities remain distinct;
- v2 preserves v1 facts;
- sequence is monotonic/unique;
- Unicode accents survive;
- schemas/examples validate;
- UI calls application ports;
- multiple Items stage and commit atomically;
- history derives from facts;
- close/reopen evidence exists;
- Windows builds/launches;
- Android is correctly classified;
- Python remains unchanged;
- G/H/I are exact.

# 37. Stop gates

Stop if:
- Cycle 06 data is needed;
- Product code becomes primary key;
- Product IDs are rewritten;
- central identity is invented;
- similarity auto-merges;
- widgets import Drift or SQL;
- history duplicates truth;
- network/sync enters scope;
- schema validation needs network;
- Windows tooling cannot be installed safely;
- source expands beyond D.

# 38. I report

I must record:
1. final topology;
2. locked dependencies;
3. Product identities;
4. normalization v2;
5. code uniqueness;
6. schema v2/migration;
7. sequence invariant;
8. contract v2;
9. JSON Schema boundary;
10. ports/composition;
11. transaction/history;
12. Windows evidence;
13. Android classification;
14. deviations;
15. deferred work;
16. Cycle 06 isolation.

# 39. Completion

This is a local shared-client vertical slice.

Completion means:

```text
correct local identities
+ correct local ordering
+ validated structural contracts
+ working multi-item Purchase UI
+ persistent local history
+ Windows execution
```

Synchronized shared state remains a later materialization.
