# B_DIDACTIC — Cycle 08 Round C08-R01

> Role: Didactic Chat [A]
> Cycle: 08
> Round: C08-R01
> Branch: `cycle-08-shared-client-product-beta`
> Inspected HEAD: `60105fab8eac4ac858d8a36674e358737e1c9f98`
> Date: 2026-07-12
> Status: Functional investigation for Main reconciliation; not canonical promotion or Codex authority

## 1. Methodology-loaded report

The complete required sequence was loaded: root `AGENTS.md`; `INDEX.md`; `PROMPT_COLLECTION.md`; `METHOD_FOUNDATIONS.md`; `FLUX.md`; `PROMOTION_RULES.md`; `CHAT_PROTOCOL.md`; `CHAT_BEHAVIOUR.md`; and `METHOD_GLOSSARY.md`. PROMPT_COLLECTION was consolidated through PRI-A, PMC-01, PMC-02, and MSU-02 with Didactic scope.

Confirmed authority: [A] observes learner-facing concepts, vocabulary, dependencies, misconceptions, and evidence-based maturity; [A] may replace only this temporary stage in this round. Main owns synthesis. Design owns architecture. Operational owns execution acceptance. Codex materializes only later authorized D/E/F. Implementation evidence is not learner evidence, and staging is not promotion.

PMC-01 result: retained role and Cycle 08 direction agree with the canonical recovery surfaces. PMC-02 result: routing and promotion boundaries are explicit; no KANBAN maturity change is justified. MSU-02 result: application inspection is required because Cycle 08 product language is the direct subject and the Didactic checkpoint predates Cycle 08.

Contradictions/drift:

- `didactics/08_CONCEPT_MAP.md` is still labelled as a Cycle 07 checkpoint; Main continuity opens Cycle 08 Sprint 01. This is checkpoint staleness, not authority to refresh it now.
- `INDEX.md` names `J_MAIN_STAGE.md`, while the repository uses `[M]_STAGE/J_[M]_STAGE.md`. The latter is the actual current route named by PROMPT_COLLECTION and the mission.
- MSU-02 normally directs a commit/push for a shared branch, but the human instruction expressly says not to commit or push unless separately authorized. No commit or push is authorized.
- Current J is intentionally cleared and contains no active synthesis. `LEGACY_RECONCILIATION.md` remains archived provisional material and was not treated as authority.

## 2. Branch and HEAD

Local verification completed in the required order. Working tree began clean; branch was `cycle-08-shared-client-product-beta`; `git pull --ff-only origin cycle-08-shared-client-product-beta` reported already up to date; HEAD exactly matched `60105fab8eac4ac858d8a36674e358737e1c9f98`. The GitHub connector independently confirmed that commit and branch file access.

## 3. Recovery and repository topology

Recovered from `00_PROJECT_STATE.md`, the Cycle 08 entry in `06_SESSION_SCHEME.md`, the latest Cycle 08 segment in `05_SESSION_LOG.md`, cleared J, the stale Didactic checkpoint, the KANBAN and Glossary where concept ownership/vocabulary required them, and Operational/Design checkpoints for cross-domain limits. `13_LECTURE_REGISTER.md` was not required because no maturity transition or learner chronology was claimed.

The complete repository topology was scanned. Relevant classes of material are: preserved Python/PySide6 beta (`main.py`, `app/`, Python tests and packaging); handwritten Flutter client (`clients/markei_flutter/lib/`); Flutter tests; platform hosts (`android/`, `windows/`, `ios/`); Drift persistence and generated database source; shared v1/v2 contract fixtures and JSON Schemas; manifests and lockfiles; generated/build/distribution output; and notebook/documentation. Generated and binary output was classified but not read line by line.

### Didactic component inventory

| Exact path | Responsibility and concepts | User vocabulary / evidence | Likely misconception | KANBAN ownership | Cycle relevance |
| --- | --- | --- | --- | --- | --- |
| `clients/markei_flutter/lib/domain/catalogue/product.dart` | Product draft, packaged/bulk mode, normalized identity, visible display fields | Product code, name, brand, packaged, bulk; implemented | visible fields or fuzzy likeness equal internal identity | `&%%07`, `&%%08`, `&&&06` | C08 core; correction/merge deferred |
| `clients/markei_flutter/lib/application/catalogue_queries.dart` | Catalogue lookup and advisory similarity | “Similar” warning; implemented query boundary | warning means duplicate or automatic merge | `&%%07`, `&%%08` | C08 core |
| `clients/markei_flutter/lib/domain/store/store.dart` | account-private Store record | Store/name; implemented minimal model | chain name uniquely identifies a branch | `&&&06` and project identity family; exact Store concept coverage incomplete | C08 gap; richer branch rules deferred |
| `clients/markei_flutter/lib/domain/purchase/purchase.dart` | Purchase aggregate and draft Item lines | Purchase, Item, package count, quantity, line total; implemented | staged Item already is historical Purchase Item | `&%%09`, `&%%10`, `&&&07` | C08 core |
| `clients/markei_flutter/lib/domain/shared/quantity.dart` | dimensional normalization | amount, unit, normalized quantity; implemented | package amount, package count, and purchased amount are interchangeable | `&%%12` | C08 core |
| `clients/markei_flutter/lib/domain/shared/money.dart` | currency plus integer minor units | currency, total; implemented | every currency has two decimal places or formatted value is raw fact | `&%%13` | C08 presentation boundary |
| `clients/markei_flutter/lib/application/register_purchase.dart` | registration command and repository contract | register Purchase; implemented | “save”, “upsert”, and immutable registration mean the same action | `&%%09`, `&%%11`, `&&&07` | atomic review/register core |
| `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart` | local atomic write of Product/Store/Purchase/Items/event | no necessary user-facing technical vocabulary; implemented/tested | local event queue means cloud synchronization exists | `&%%11`, `&&&07`, sync concepts | preserve; C09 activation deferred |
| `clients/markei_flutter/lib/infrastructure/local/local_database.dart` | Drift tables, keys, constraints, migrations | none should expose UUID/event/cursor language | account row means authenticated account; pending event means upload | persistence/sync entries | protected technical behavior; C09 sync deferred |
| `clients/markei_flutter/lib/app/pages/purchase_page.dart` | current multi-item staging scaffold | Store, Product code/name/brand, package amount/unit, Quantity, Packages, Line total, Add item, Register; implemented/widget-tested | “Quantity” is sufficiently precise; warning resolves duplicates; staging includes edit/remove/review | existing Product/Purchase/quantity concepts | baseline to enrich in C08 |
| `clients/markei_flutter/lib/app/pages/history_page.dart` | summary projection and empty state | History, no purchases registered, store, item count, total; implemented/widget-tested | summary is detailed History or analytics | raw/derived and Purchase concepts | detail/comparison gap for C08 |
| `clients/markei_flutter/lib/app/markei_app.dart` | navigation/composition presentation | Purchase, History; implemented | same widget tree proves responsive/platform acceptance | Flutter/composition and evidence-state concepts | responsive foundation C08 |
| `clients/markei_flutter/test/` | executable examples for identity, migration, transaction, UI and lifecycle-adjacent behavior | test evidence, not learner evidence | passing tests establish understanding or full product acceptance | `&&&05` | evidence source only |
| `contracts/shared_beta/v2/` | language-neutral identity, Purchase, and event examples/schemas | technical contract vocabulary | fixture is final wire protocol or active synchronization | data contract, catalogue, sync concepts | protect during C08; C09 transport deferred |
| `app/`, `main.py`, `tests/test_release_configuration.py` | accepted Python/PySide6 behavior and regression baseline | legacy Register/Storage/History vocabulary | Python projections define new Flutter product language | existing Python/project concepts | protected behavior, not C08 primary UI |
| `clients/markei_flutter/android/`, `windows/`, `ios/` | platform hosts | Android/Windows interaction | host files prove full lifecycle or iOS scope | Flutter/evidence boundary | Windows/Android C08; iOS deferred |

## 4. Accepted concepts and vocabulary

Accepted conceptual ground, without new maturity claims:

- Catalogue: the household’s private reusable collection of Product references, distinct from one Purchase entry.
- Product: a reusable identity-bearing catalogue fact; visible code/name/brand/package facts help recognition but are not the internal UUID.
- Exact duplicate: exact normalized identity equivalence eligible for reuse under the current rules.
- Similar Product: advisory likeness requiring human choice; it never authorizes automatic merge.
- Packaged amount: the amount contained by one package (for example 500 g).
- Package count: how many packages were bought.
- Purchased amount: the observed total quantity on the Purchase line; it must retain a dimension and unit.
- Normalized quantity: a comparable representation derived from entered amount/unit; it is not a replacement for understandable display evidence.
- Staged Item: editable, removable pre-registration input.
- Purchase Item: the registered historical line within an atomic Purchase.
- Review: inspection/correction before registration. Registration: one atomic historical commit, not an upsert.
- History: raw Purchase observations and their details. Price comparison: a derived interpretation rebuilt from those observations.
- Personal price change: change between the user’s own comparable observations. It must not be called general, official, or population inflation.
- Responsive composition: interface adaptation to available space and interaction conditions; not proof of identical layout or complete platform behavior.

## 5. Cycle 08 conceptual gaps

1. A learner-facing visible Product identity sentence is not yet settled: which fields users recognize, and which internal distinctions remain hidden.
2. Store versus Store branch/location lacks a stable ordinary-language rule.
3. The UI label `Quantity` collapses purchased amount and normalized/comparable quantity.
4. The relationship among package amount, package count, purchased amount, unit price, and line total needs one coherent example and validation vocabulary.
5. Current staging has add/register but no implemented edit/remove/cancel/review model.
6. Failure/retry language does not yet distinguish validation failure, transaction failure, unknown outcome, safe retry, and duplicate prevention.
7. History is only a summary list; detail, Product observation history, comparison inputs, and selected interval are unimplemented.
8. The first personal price-change formula and comparability rule remain provisional; shrinkflation and mixed package sizes must not be silently collapsed.
9. Empty, loading, validation, success, failure, recovery, and retry states are incomplete or undifferentiated.
10. Responsive behavior has phone-width widget evidence but no accepted conceptual model for keyboard, Back, focus, larger text, rotation, and wide composition.

## 6. Existing KANBAN ownership

Cycle 08 should extend or exemplify existing entries before inventing duplicates: `&&&01` responsibility boundaries; `&&&02` raw versus derived data; `&&&03` naming as contract; `&&&05` evidence state; `&&&06` stable identity; `&&&07` atomicity; `&&&08` historical integrity; `&&&09` authentication versus authorization; `&&&10` eventual consistency; `&%%07` reusable Catalogue; `&%%08` Product identification and normalization; `&%%09` Purchase aggregate; `&%%10` Purchase Item; `&%%11` append-only event; `&%%12` dimensional quantity; `&%%13` minor-unit money; `&%%14` analytics registry/versioning; and Flutter/Drift framework entries.

Possible uncovered teaching objects—visible identity, exact-versus-advisory match, draft-versus-registered state, review-versus-commit, and responsive composition—must first be tested as examples/extensions of these owners. No new IDs or status changes are proposed in this round.

## 7. Provisional vocabulary candidates

- `Catalogue Product` for the reusable reference, with plain `Product` preferred in UI where context is clear.
- `Package size` instead of `Package amount` when speaking to users.
- `Packages bought` for package count.
- `Total amount bought` for purchased amount when ambiguity exists.
- `Comparable amount` only when normalization is actually displayed/explained.
- `Purchase draft` or `Items to register` for pre-registration state.
- `Review purchase` for the explicit pre-commit step.
- `Price change in your purchases` as the safest first analytics title.
- `Compared purchases` and explicit date interval for the two observations.

These are candidates for usability/learner evaluation, not canonical Glossary entries.

## 8. Misleading language and confusion risks

- Avoid `inflation rate` without the qualifier personal/observed; two private prices do not measure general inflation.
- Avoid `upsert Purchase`; registration creates a new immutable historical Purchase.
- Avoid `duplicate` for fuzzy similarity; say `similar Product` until exact equivalence is established.
- Avoid `syncing`, `uploaded`, `account`, `signed in`, or `cloud backup` in user-facing status. Current behavior is local; the account identifier and event queue are preparatory technical structures.
- Avoid exposing UUID, device sequence, event, cursor, hash, Drift, or normalization version as ordinary product vocabulary.
- Avoid `saved` after an uncertain failure; distinguish validation rejection, registration success, and unknown/retry states.
- Avoid implying that Android/Windows share identical interactions merely because they share Flutter source.
- Avoid treating normalized quantity or derived unit price as raw receipt evidence.

## 9. Learner-evidence boundaries

Repository files and passing tests demonstrate implemented examples. Human runtime reports demonstrate bounded workflow evidence. Neither demonstrates that the learner can define, distinguish, predict, explain, or apply a concept independently. Therefore every existing KANBAN maturity remains unchanged.

Future promotion would require explicit learner evidence such as: explaining Product visible/internal identity; classifying exact versus advisory matches; calculating package count versus purchased amount; predicting atomic rollback; distinguishing draft Item from Purchase Item; identifying raw and derived price facts; or explaining why personal price change is not general inflation. Usability observation may improve interface language but is not automatically conceptual mastery.

## 10. Cycle 09/10 deferrals

Cycle 09: authentication/authorization activation, remote API/Neon, actual upload/download synchronization, server cursors, conflict handling, multi-device convergence, central/shared catalogue, household sharing, and production identity semantics.

Cycle 10 or later: broad analytics, forecasting, official-index comparison, shrinkflation suite, cross-store recommendations, global catalogue/product-family relations, mature Product/Store correction/merge/delete workflows, legacy import, and broader distribution. iOS is outside the current Cycle 08 scope.

## 11. Human questions

1. Should the UI use `Catalogue`, `Products`, or a paired title such as `My products` while documentation retains Catalogue?
2. Is user Product code mandatory in Cycle 08, optional, or an advanced/internal-facing field?
3. For packaged goods, should the user enter package count plus package size and let total purchased amount derive, or retain all three with consistency validation?
4. What minimum facts distinguish Store branches in Cycle 08: name only, optional location label, or another visible identifier?
5. Must Review be a separate screen/dialog, or may an editable staged list plus explicit Register action satisfy the concept?
6. Should the first analytics view say percentage `price change`, reserving `personal inflation/deflation` for an explanatory secondary label?
7. Which failures may be retried automatically, and which must ask the user to confirm whether registration occurred?

## 12. Recommendations to Main

- Make the first product-language spine: choose/reuse Product → stage Items → review → atomically register → inspect History → compare like observations.
- Require every D/E/F UI instruction to name validation, empty, success, failure, retry, and recovery language, not only happy-path widgets.
- Keep internal identity/sync vocabulary behind the interface while preserving contract invariants.
- Define comparability before naming analytics; begin with explicit Product, amount basis, two Purchase observations, dates, stores, currency, and percentage change.
- Treat Store branch identity and package/purchased quantity entry as human decisions before implementation staging.
- Carry current KANBAN maturity unchanged and schedule small learner checks after the product vocabulary is selected.

## 13. Exact next staging route

```text
C08-R01 B_DIDACTIC
↔ Main J reconciliation with A_OPERATIONAL and C_DESIGN
↔ provisional D/E/F, each labelled exactly:
  Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
↔ renewed A/B/C review of the proposed product language and gates
↔ enriched J and D/E/F
→ explicit human/Main authorization
→ Codex materialization
→ G/H/I evidence
→ functional reconciliation; only then consider permanent Didactic updates or maturity review
```

This report recommends no source change, permanent Didactic promotion, architecture choice, or Operational acceptance.

<!-- ROUND_MARKER:C08-C08-R02-[A]-2026-07-13 -->
# Cycle 08 Round C08-R02 — [A] Investigation

## 1. Role, authority, branch, and HEAD

Didactic Chat [A] observes learner-facing concepts, vocabulary, conceptual dependencies, misconceptions, and evidence-based maturity. This round may append only to `DEV_STAGE/B_DIDACTIC.md`; it does not authorize source, tests, dependencies, schema, generated code, permanent promotion, J, D/E/F, or Codex.

- Repository: `gus-i-gu/markei`
- Branch: `cycle-08-shared-client-product-beta`
- Expected starting HEAD: `44b50788952947cfb3d23290192ebb3521d3a816`
- Inspected reconciled local HEAD: `0cc1b95feff33f711041e402d44c96c317771ba9`
- Ancestry: expected HEAD is confirmed as an ancestor.
- Authority state: J and D/E/F remain `PROVISIONAL — NOT AUTHORIZED FOR CODEX`.

The checkout initially contained the earlier local Didactic commit while the remote contained its connector-published equivalent plus later staging. A normal non-destructive merge reconciled the histories. No reset, stash, clean, discard, overwrite, or force operation occurred.

## 2. Prompts executed and recovery result

Executed by complete indexed definition: PRI-A, PMC-01, PMC-02, ERI-01, and FCA-02.

PMC-01 confirmed [A], C08-R02 cumulative staging, the checkpoint-first route, and the sole writable surface. PMC-02 confirmed that staged/Main-synthesized language is not canonical, implementation evidence is not learner evidence, and append-only B is the valid next action. The complete methodology was not reopened because PROMPT_COLLECTION, AGENTS, INDEX, current staging, and checkpoints resolved the round without a canonical-rule contradiction.

Inputs inspected: latest Cycle 08 segments of `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, and `05_SESSION_LOG.md`; current `J_[M]_STAGE.md`; paired `E_DDC_STAGE.md`; complete cumulative `B_DIDACTIC.md`; Didactic checkpoint; and Operational/Design checkpoints for evidence and architecture limits. The legacy reconciliation was not used as authority.

## 3. Repository surfaces inspected

The tracked topology was scanned across Python/PySide6, Flutter/Dart, shared contracts, tests, platform hosts, packaging/configuration, generated/build output, and notebook staging. Detailed Didactic inspection focused on:

- domain/value language: `lib/domain/catalogue/product.dart`, `product_code.dart`, `purchase/purchase.dart`, `shared/quantity.dart`, `shared/money.dart`, `store/store.dart`, `sync/sync_event.dart`, and `shared/ids.dart`;
- application ports: `application/catalogue_queries.dart`, `register_purchase.dart`, and `purchase_history.dart`;
- local adapters/schema: `local_purchase_repository.dart`, `local_query_repository.dart`, `local_device_identity_repository.dart`, and generator-owned `local_database.dart`;
- presentation: `markei_app.dart`, `purchase_page.dart`, and `history_page.dart`;
- evidence: catalogue identity, Product code, Unicode normalization, transaction/rollback/reopen, migration, Device sequence/identity, JSON Schema, analytics, and widget tests;
- protected boundary: Python/PySide6 sources, database, release configuration, and regression path were identified but not modified.

## 4. New component, function, and object evidence

| Classification | Exact symbol/path | Repository truth and Didactic consequence |
| --- | --- | --- |
| newly evidenced | `Product.userProductCode: ProductCode`, `createProductFromDraft()` in `domain/catalogue/product.dart` | The domain requires a Product code, while Drift columns `userProductCode` and `normalizedUserProductCode` are nullable. “Optional Product code” is therefore not current domain behavior and requires a deliberate contract/domain change, not merely relabelling the UI. |
| newly evidenced | `normalizeProductFacts()` / `normalizeSemanticIdentityText()` | Display name is required; brand may be empty. NFKC/case/diacritic normalization defines exact identity material. This internal equivalence must not be taught as fuzzy similarity. |
| newly evidenced | `areAdvisorySimilar()` | Similarity uses same mode/kind plus edit-distance/name or brand equality. It is advisory evidence only; it neither proves duplicate identity nor performs reuse. |
| corrected | `CatalogueQueryRepository.listProducts()` and `listStores()` versus `PurchasePage._addItem()` | Query ports can list Catalogue and Stores, but current UI exposes neither selection journey. `_addItem()` always creates `NewProductReference`; therefore J’s Catalogue/Store journey is prospective, not present capacity at the presentation layer. |
| newly evidenced | `PurchaseItemDraft` / `PurchaseItem` | Draft has `ProductReference`, `packageCount`, `purchasedQuantity`, and `lineTotal`; registered Item adds IDs. This gives a precise staged-versus-registered teaching example, but the UI does not expose edit/remove/review. |
| corrected | `PurchasePage._productDraft()` and `_addItem()` | `MeasurementKind.mass` is hard-coded for both Product and purchased quantity. Although the value model supports mass/volume/count, the current UI teaches a misleading universal `Quantity` label and cannot enter volume/count correctly. |
| newly evidenced | `NormalizedQuantity(kind, unit, microunits)` | Normalization stores fixed-point microunits, rejects fractional COUNT, and canonicalizes mass/volume/count. “Normalized quantity” is derived technical representation; the UI should teach package size and total amount bought first. |
| newly evidenced | `_parseMinorUnits()` in `purchase_page.dart` | UI parsing accepts only non-negative values with at most two decimal places and hard-codes BRL. This is a bounded BRL scaffold, not a general currency lesson despite `Money.currencyCode`. |
| corrected | `_resolveStore()` in `local_purchase_repository.dart` | Store reuse is exact account/name equality. There is no normalized identity, similarity warning, branch/location field, or uniqueness constraint; J correctly leaves Store identity unresolved, but “duplicate warning” is not implemented capacity. |
| retained | `LocalPurchaseRepository.registerPurchase()` | One Drift transaction resolves Store/Products, validates Purchase, inserts Purchase/Items, advances Device sequence, writes SyncEvent/PendingEvent, and returns IDs/sequence. Atomicity is implemented and tested. |
| corrected | `RegisterPurchaseCommand` / `registerPurchase()` | Command has no caller-supplied retry key or Purchase ID. Each call generates new UUIDs. Atomic registration exists; identical/conflicting retry semantics do not. J correctly calls idempotency schema/contract work likely, but E must not describe retry states as current behavior. |
| newly evidenced | `_resolveProduct()` | Exact identity reuses a Product; duplicate Product code throws; an `ExistingProductReference` is account-checked. UI currently uses only the new-reference path, so visible/internal identity teaching needs both domain and presentation evidence labels. |
| corrected | `HistoryPage` `FutureBuilder` | `snapshot.data ?? []` makes loading and query failure appear as `No purchases registered.` There is no visible loading/error/retry distinction. E’s state vocabulary is necessary prospective work, not documentation of current behavior. |
| newly evidenced | `LocalQueryRepository.listRecentPurchases()` | History returns only Purchase ID, Store name, occurrence time, currency, total, and Item count; UI omits occurrence time and has no detail or Product observations. “Detailed History” and price comparison remain unimplemented. |
| corrected | `PurchasePage` catch blocks and success text | All exceptions are displayed via raw `error.toString()`; success exposes `Device sequence`. Both leak technical language and collapse validation, persistence, and unknown outcomes. Device sequence should not be ordinary product vocabulary. |
| retained | widget and repository tests | Tests prove two-item registration, rollback, close/reopen, phone-width flow, summary History, identity fixtures, and migration behavior. They do not prove learner mastery, final responsive interaction, error-state language, or usability. |

Important state/lifetime evidence: `PurchasePage` owns ephemeral controllers, `_items`, `_warnings`, and `_message` for the widget lifetime; it clears Items after success but provides no draft persistence. `HistoryPage` owns no durable state and refreshes through `refreshSignal`. `LocalDatabase` owns durable Products, Stores, Purchases, Items, Device sequence, and pending events. Rebuildable projections and analytics are not yet presentation features.

## 5. Retained C08-R01 conclusions

- Catalogue Product versus one Purchase Item remains the central reusable-fact distinction.
- Visible identity must remain distinct from internal UUID and normalization keys.
- Exact normalized equivalence and advisory similarity are not interchangeable.
- Package size, package count, total purchased amount, and normalized quantity need distinct terms.
- Draft Item versus registered Purchase Item and review versus atomic registration remain necessary.
- Raw Purchase facts remain distinct from derived comparisons.
- “Price change in your purchases” remains safer than general/official inflation language.
- Responsive composition is not established by shared Flutter source or one phone-width widget test.
- Local Account/Event/Pending structures do not mean authentication, upload, cloud backup, or synchronization.
- No learner evidence supports any KANBAN maturity transition.

## 6. Corrections and superseded claims

1. C08-R01 described Product code as a possible advanced/internal-facing choice. Repository truth sharpens this: it is mandatory in the current Dart domain and UI, despite nullable database columns. Any optional-code proposal is structural.
2. The C08-R01 inventory said Catalogue lookup was implemented. Correct scope: list/similarity query ports and adapters are implemented; a user-visible browse/search/select Catalogue workflow is not.
3. Store “selection/creation” is not present as a UI journey. Registration silently reuses an exact same-name row or creates another.
4. Dimensional quantity exists in the domain, but current UI is mass-only. Volume/count presentation must not be inferred from the value object.
5. Atomicity must no longer be grouped with retry safety. Transaction rollback is evidenced; submission idempotency is absent.
6. Current History empty language is not a valid empty/error model because loading and failure are not distinguished.
7. The current success message’s Device sequence is implementation evidence and should be removed from eventual learner/user language, though no source edit is authorized here.

## 7. Confrontation with current J

Supported/retained:

- the carried technical baseline, atomic Purchase transaction, reusable Product identity, advisory-only similarity, raw/derived split, protected Python boundary, and provisional authority;
- J’s statement that coherent navigation, first-class Catalogue/Store journeys, edit/remove/review, safe retry, detailed History, analytics, recovery states, and complete responsive behavior remain missing;
- J’s Store identity, quantity ownership, continuity staleness, and atomicity/idempotency conflict classifications;
- J’s cautious analytics rule: two personal observations do not establish general inflation.

Corrections/enrichment required for MJR-03:

- classify Catalogue capability in three layers: domain identity implemented; query list/similarity ports implemented; user browse/search/select journey absent;
- state that Product code is mandatory in current domain/UI and nullable only in persistence, making optionality a cross-layer reconciliation;
- record mass-only UI despite three-dimensional domain capacity;
- record exact, case-sensitive Store name reuse without normalized uniqueness or branch facts;
- state that History loading/error currently masquerades as empty and registration errors expose raw exceptions;
- separate “transaction retry after known failure” from true command idempotency/unknown-outcome recovery;
- record that the current UI exposes Device sequence after success, contradicting the desired ordinary-language boundary.

## 8. Confrontation with paired provisional E_DDC_STAGE

Feasible without new package dependency: revise labels; create explicit presentation states; remove technical identifiers from messages; add Catalogue/Store selection UI using existing query ports; expose staged list/review/edit/remove with ordinary Flutter state; distinguish Product similarity warning from exact reuse; and add History loading/error/empty language.

Requires broader structural work: optional Product code changes domain construction, fixtures, contracts, persistence expectations, and migration policy; volume/count entry changes presentation controls and validation but can reuse the current value object; Store branch/location or normalized duplicate rules require domain/schema decisions; detailed History requires new query records/joins; price comparison requires an application query and algorithm/version boundary; idempotent registration requires command identity, persistence uniqueness, result recovery, contracts, and migration.

E should correct two implications:

- identical/conflicting retry language is a target model, not a state the current application can classify;
- current `FutureBuilder` and catch-all messages do not supply the required loading/failure/retry boundaries merely because those words are staged.

## 9. Structural additions and alternatives

| Provisional addition | Problem / responsibility / owner | Affected surfaces and state | Persistence/schema/dependency | Tests, cost, alternatives, reversibility |
| --- | --- | --- | --- | --- |
| Catalogue selection presentation | Expose existing Products and explicit existing/new choice; presentation + application queries | `PurchasePage`, `CatalogueQueryRepository`, `ExistingProductReference`; draft lifetime | no required schema/package change | widget tests for empty/search/exact/similar/choice; medium; alternative modal versus inline; reversible UI composition |
| Typed presentation state | Stop treating loading/error as empty and raw exceptions as user copy; presentation/application error mapping | Purchase/History pages, command/query outcomes; widget lifetime | no schema; no package required initially | state-transition/widget tests; low–medium; sealed state objects versus local enums; highly reversible |
| Quantity-entry model | Make package size/count/total amount and mass/volume/count coherent; presentation with domain validation | `_productDraft()`, `_addItem()`, `NormalizedQuantity`; draft lifetime | no schema if existing fields suffice; migration unlikely | dimensional and consistency tests; medium; derive total from size×count or retain independent observation; reversible until persisted semantics change |
| Store visible identity | Distinguish reusable Store/branch and warn on likely duplicates; domain + query + persistence | `Store`, Stores table, `_resolveStore()`, listStores, UI | likely new fields/index and migration if branch/location becomes identity | identity/migration/query/UI tests; medium–high; bounded display label only is cheaper but ambiguous; schema addition is reversible only with data migration care |
| Detailed History query | Present Purchase details and Item observations; application query + adapter | new detail record/port, joins over Purchases/Items/Products | no schema necessarily; no package | repository/widget tests; medium; route detail versus expandable list; reversible API shape before release |
| Versioned price comparison | Compare like observations without overstating inflation; analytics/application query | analytics registry, History/Product observations, derived result lifetime | no schema initially if computed; optional cache later | comparable/non-comparable fixture tests; medium–high; start with unit-price delta only; versioned algorithm preserves reversibility |
| Registration idempotency | Resolve duplicate submit and unknown outcomes; application/domain/persistence contract | `RegisterPurchaseCommand`, result lookup, Purchases/event tables/contracts | likely idempotency key/unique constraint, migration, fixture/schema updates; no new package inherently | identical/conflicting retry, crash/reopen, concurrency tests; high; cheaper first alternative disables repeat while outcome is known but cannot solve crash uncertainty; structural change requires migration discipline |

All additions remain prospective. Didactic Chat does not select their architecture.

## 10. Dependency, schema, and migration consequences

- No new third-party dependency is inherently required for the first Catalogue UI, typed UI states, staged review, or clearer messaging.
- Product-code optionality cannot be achieved safely by only changing the label: current `ProductCode` construction, Product type, fixtures, JSON contracts, exact identity behavior, and legacy migration must agree.
- Store branch/location or normalized uniqueness likely changes `Stores`, indexes, queries, contracts, and v2→next migration.
- Detailed History and computed price comparison may begin without schema change, but require richer query ports and stable comparability rules.
- Idempotency is the strongest schema-bearing proposal: a caller-owned key and unique persistence/result-recovery rule are needed; the existing Event UUID is generated too late to protect duplicate command submission.
- Generated `local_database.g.dart` remains generator-owned and would change only through schema regeneration after authorization.

## 11. Validation and learner-evidence requirements

Implementation evidence required later: Catalogue exact/similar/new selection tests; Store identity cases; all quantity dimensions; draft edit/remove/cancel/review; atomic rollback; repeated/unknown submission; loading/empty/error/retry; History detail; comparable/non-comparable price observations; narrow/wide, keyboard, Back, rotation, larger text, reopen; migration/rollback/no-silent-reset; Python regressions.

Learner evidence remains separate. Candidate checks should ask the learner to explain or apply: visible versus internal identity; exact versus advisory match; package size/count/total amount; draft versus registered Item; atomicity versus idempotency; raw fact versus derived comparison; personal price change versus general inflation; and widget evidence versus platform validation. No maturity changes occur in this round.

## 12. Cross-domain consequences

- Design must resolve Product-code optionality, Store branch identity, quantity ownership/derivation, History query shape, comparison versioning, and idempotency boundaries.
- Operational must define migration, crash/unknown-outcome retry, data-volume, lifecycle, and recovery evidence; it must not call staged state wording validated behavior.
- Main must keep product vocabulary decisions distinct from schema and transaction decisions even when one UI label exposes both.
- Python/PySide6 remains a protected regression/reference boundary; Cycle 08 Flutter vocabulary must not silently rewrite its accepted behavior.

## 13. Human decisions

1. Choose user destination language: `Catalogue`, `Products`, or `My products`, and whether it is top-level, Purchase-integrated, or both.
2. Decide whether Product code remains mandatory. If optional, authorize cross-layer contract/schema investigation rather than a UI-only change.
3. Choose quantity input truth: derive total amount from package size × count, store it as an independent receipt observation with validation, or support both explicitly.
4. Define minimum Store branch facts and whether same-name Stores may coexist.
5. Decide whether Review is a distinct route/dialog or an explicit editable staged section.
6. Decide whether C08 first solves only known in-session duplicate taps or full crash/unknown-outcome idempotency.
7. Use `price change in your purchases` initially, or permit `personal inflation/deflation` as secondary explanatory language.
8. Decide whether local draft recovery is required across navigation/rebuild/process restart in this beta.

## 14. Recommendations for J restaging

- Group current capability by domain, application-port, adapter, and presentation evidence to avoid calling a port a completed user journey.
- Add the seven repository corrections above as explicit R02 evidence.
- Separate low-cost presentation clarity from schema-bearing identity/idempotency work.
- Preserve all C08-R01 human questions, but mark Product-code optionality and retry safety as structural decisions.
- Keep price comparison bounded to explicitly comparable personal observations and retain no-forecasting scope.

## 15. Recommendations for next D/E/F enrichment

- E: specify exact user copy/state distinctions and label each as current defect or proposed outcome; remove Device sequence from intended success copy; avoid promising retry classifications before idempotency exists.
- D: gate Catalogue selection, loading/error/empty differentiation, quantity labels, and History detail separately from migrations and idempotency.
- F: name state owners and exact port/schema changes; split reversible presentation work from Store/Product/idempotency migrations.
- Every D/E/F append must retain `Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX` until final human/Main activation.

## 16. Exact next route

```text
C08-R02 B_DIDACTIC publication
→ Main runs MJR-03
→ Main appends the next J reconciliation
→ Main runs MDE-04
→ Main appends the next provisional D/E/F enrichment
→ renewed domain confrontation as required
→ final human/Main activation
→ Codex
```
