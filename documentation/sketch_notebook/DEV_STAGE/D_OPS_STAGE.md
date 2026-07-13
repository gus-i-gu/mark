# D_OPS_STAGE — Cycle 08 Product-Beta Operational Directive

> Cycle: 08 — Shared-Client Product Beta
> Directive: C08-PB-01
> Status: ACTIVE — CODEX PRODUCT IMPLEMENTATION AUTHORIZED
> Authority: explicit human instruction reconciled by Main [M]
> Branch: `cycle-08-shared-client-product-beta`
> Inputs: cumulative C08-R01/R02 A/B/C, J C08-R02, and repository investigation
> Paired directives: `E_DDC_STAGE.md` and `F_DSN_STAGE.md`
> Evidence outputs: `G_OPS_CODEX.md`, `H_DDC_CODEX.md`, `I_DSN_CODEX.md`
> Control: this directive fully supersedes C08-IMP-01 and every earlier D authorization

## 1. Required outcome

Codex shall implement a demonstrable Cycle 08 shared-client product beta, not a documentation or refactoring-only exercise.

The finished beta must expose these connected user journeys:

1. responsive navigation among **Purchase**, **Products**, and **History**;
2. private reusable Product catalogue browsing and search;
3. existing Product selection, new Product creation, and advisory similar-Product choice;
4. existing Store selection or Store creation during Purchase;
5. multi-Item Purchase staging;
6. staged Item editing and removal;
7. explicit Purchase review before registration;
8. atomic local Purchase registration with in-flight duplicate-tap prevention;
9. detailed Purchase History;
10. first personal price comparison from compatible observations;
11. distinct loading, empty, validation, success, and failure states;
12. honest local-data, recovery, and backup boundaries;
13. Windows/Android-oriented responsive and lifecycle validation within available hosts.

Source implementation and focused tests are the primary deliverable. D/E/F or G/H/I editing alone is not completion.

## 2. Main product decisions for this implementation

To unblock materialization, Main selects the lowest-risk choices supported by repository truth:

| Decision | Controlling choice |
| --- | --- |
| destinations | Purchase, Products, History |
| Catalogue UI term | Products; “Catalogue” remains architectural documentation language |
| Store placement | picker within Purchase; no top-level Store destination |
| Product code | remains mandatory in Cycle 08 |
| quantity/currency | retain explicit MASS and BRL beta boundary; do not imply general support |
| draft lifetime | current app-session/mounted lifetime; no process-death persistence |
| review | explicit inline phase in the Purchase flow |
| registration safety | existing atomic transaction plus disabled/in-flight submit guard |
| durable idempotency | deferred; no false identical-retry guarantee |
| first comparison | latest versus previous compatible observation for the same Product |
| comparison basis | normalized purchased-unit price, same currency/dimension/canonical unit |
| analytics wording | “Price change in your purchases” |
| Store identity | existing Store UUID/display name; selection is explicit, creation warns on exact-name reuse |
| export/restore | no false backup claim; expose a clear local-only data boundary |
| Device correction | no Cycle 08 schema change; remains a hard Cycle 09 entry gate |

These choices avoid new packages and schema migrations while delivering the core product journey.

## 3. Existing implementation to reuse

Codex must extend, not replace, the evidenced foundation:

- `MarkeiComposition.appPrivate()`;
- `MarkeiApp`, its selected destination state and mounted-page preservation;
- `CatalogueQueryRepository.listProducts()`, `listStores()`, and `similarityWarnings()`;
- `ExistingProductReference` and `NewProductReference`;
- `PurchaseItemDraft`;
- `RegisterPurchaseCommand`;
- atomic `LocalPurchaseRepository.registerPurchase()`;
- `PurchaseHistoryRepository` and `LocalQueryRepository`;
- existing Money, Quantity, Product identity and similarity rules;
- Drift v2/app-private storage;
- existing Flutter and Python regressions.

If an earlier Codex run already changed responsive/state code, inspect its diff and retain compatible work. Do not redo it for cosmetic restructuring.

## 4. Bounded implementation sequence

### Unit 1 — Responsive product shell and state foundation

Implement:

- shared semantic destinations for Purchase, Products and History;
- constraint-driven compact/wide navigation;
- selected destination and mounted Purchase draft preservation;
- explicit dependency-free presentation-state types;
- safe loading/empty/error/success rendering.

Acceptance:

- all three destinations reachable in compact and wide layouts;
- selection survives resize;
- existing Purchase draft survives destination changes and resize;
- errors are not rendered as empty or raw exception text.

### Unit 2 — Products and complete Purchase staging

Implement:

- Products list with local search/filter;
- Product empty/loading/error/data states;
- Product selection from Purchase;
- new Product entry using the current mandatory code and current identity facts;
- advisory similar-Product candidates before creation;
- explicit “use existing” or “create anyway” choice;
- Store list/select/create within Purchase;
- multiple stable draft lines;
- edit and remove;
- running total;
- inline review phase;
- cancel/back-to-edit behavior;
- in-flight registration guard;
- successful local registration refresh/reset behavior.

Acceptance:

- selecting an existing Product sends `ExistingProductReference`;
- creating sends `NewProductReference`;
- similarity never silently merges;
- exact existing Store selection retains Store identity through the application boundary where current contracts permit;
- Store creation remains explicit;
- draft edit/remove targets stable lines;
- review reflects final staged facts;
- one user submit action reaches one registration call while in flight;
- atomic repository behavior remains unchanged.

If preserving selected Store identity requires replacing free-text `storeName` with a dependency-free existing/new Store reference, that application-contract change is authorized. Persistence schema changes are not.

### Unit 3 — Detailed History and first comparison

Implement:

- History list with occurrence time, Store, total and Item count;
- Purchase detail view with registered Items and relevant Product/quantity/price facts;
- application query records/ports and local adapter queries needed for detail;
- removal or bounded batching of the current N+1 Item-count behavior;
- Product observation query using current persisted facts;
- pure/versioned compatible-observation comparison;
- “Price change in your purchases” presentation;
- explicit incompatible/insufficient-data states.

Acceptance:

- loading, empty, failure and data are distinct;
- detail facts match the registered Purchase;
- widgets do not traverse Drift rows;
- comparison uses the same Product, currency, quantity kind and canonical unit;
- latest and previous compatible observations are ordered by occurrence time;
- result identifies both observations and percentage change;
- one observation or incompatible facts return explanation, not a fabricated value;
- no analytics cache or schema change.

### Unit 4 — Beta acceptance and boundary completion

Implement or document in-product where appropriate:

- local-only data notice;
- no synchronization/backup promise;
- safe startup/query/registration failure language;
- responsive overflow and larger-text corrections;
- keyboard/focus/Back behavior on touched flows;
- Android portrait/landscape and Windows narrow/wide checks where hosts exist;
- background/resume and restart checks;
- protected Python boundary regression.

This unit is not production release work.

## 5. Mandatory preflight

Before edits:

```text
git status --short --branch
git branch --show-current
git pull --ff-only
git rev-parse HEAD
```

Then load `AGENTS.md`, `INDEX.md`, `PROMPT_COLLECTION.md`, run `PRI-CODEX` and `PMC-01`, and read all three controlling D/E/F directives.

Codex must report:

- existing source changes, especially any prior C08-IMP-01 work;
- exact starting HEAD;
- proposed files for the next unit;
- tests to be added before beginning that unit.

Preserve unrelated human changes. Never reset, clean, stash, discard or overwrite them.

## 6. Validation

Run focused tests after each unit. At the end run available baseline checks:

```text
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
flutter build apk --debug
python -m unittest discover -s tests
```

Use existing repository commands and dependencies only. Unsupported host commands are **host-unvalidated**, not passed.

Minimum test coverage:

- compact/wide navigation and resize preservation;
- Products list/search/empty/error;
- existing/new/similar/create-anyway Product paths;
- Store select/create;
- stable multi-line add/edit/remove;
- review and back-to-edit;
- double-tap/in-flight guard;
- atomic failure retaining a recoverable draft;
- History list/detail and query failure;
- comparison compatible/incompatible/insufficient data;
- safe copy without exception or Device leakage;
- current Flutter suite and Python regressions.

## 7. Prohibitions and stop conditions

Not authorized:

- new dependencies, dependency upgrades or tool installation;
- Drift schema/version/migration changes;
- optional Product code;
- normalized Store/branch uniqueness;
- durable SubmissionId/idempotency;
- persisted drafts;
- Device schema/invariant changes;
- authentication, API, Neon or synchronization;
- export/restore implementation;
- Python/PySide6 source/database changes;
- registered Purchase editing/deletion;
- forecasting or general inflation claims;
- iOS, signing or distribution;
- unrelated architecture refactoring.

Stop only when the next required behavior cannot be implemented without one of these prohibited changes. Report the exact blocker and continue with independent authorized units when safe.

## 8. Evidence and completion

G/H/I are written after material implementation, not instead of it.

Each report must name:

- implemented files and behavior;
- tests and exact command results;
- host-validated versus host-unvalidated claims;
- deviations and blockers;
- remaining Cycle 08 work.

C08-PB-01 is complete only when the connected product journey can be previewed through the implemented Flutter UI and the available automated evidence passes.
