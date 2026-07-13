# C_DESIGN — Cycle 08 Round C08-R01

> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
> Role: Design Chat [D]
> Repository: `gus-i-gu/markei`
> Required branch: `cycle-08-shared-client-product-beta`
> Remote baseline inspected: `60105fab8eac4ac858d8a36674e358737e1c9f98`
> Scope: architecture investigation and recommendations to Main; no implementation authority

---

## 1. Methodology-loaded report

The complete required sequence was read from the named remote branch: root `AGENTS.md`; `INDEX.md`; `PROMPT_COLLECTION.md`; `METHOD_FOUNDATIONS.md`; `FLUX.md`; `PROMOTION_RULES.md`; `CHAT_PROTOCOL.md`; `CHAT_BEHAVIOUR.md`; and `METHOD_GLOSSARY.md`.

`PROMPT_COLLECTION` was consolidated through PRI-D, PMC-01, PMC-02, and MSU-02 with Design scope. The resulting authority boundary is:

- Design observes responsibilities, dependency direction, invariants, ownership, alternatives, reversibility, and cost;
- this file is a functional C-stage report for Main reconciliation;
- it does not validate execution, change Didactic maturity, promote permanent Design canon, authorize schema/source/dependency work, or activate D/E/F;
- promotion is semantic; materialization is physical; neither follows automatically from repository evidence;
- `LEGACY_RECONCILIATION.md` is archived provisional evidence, not current authority;
- only this paired `C_DESIGN.md` is writable in this round.

No methodology contradiction was found in those authority rules. Path/state contradictions are recorded in section 11.

## 2. Branch and HEAD evidence

The prescribed local commands could not complete because the supplied workspace root is not a usable Git checkout (`fatal: not a git repository`). No substitute branch, reset, stash, clean, overwrite, commit, or push was attempted.

GitHub connector evidence independently established:

- repository `gus-i-gu/markei` exists;
- branch `cycle-08-shared-client-product-beta` exists;
- commit `60105fab8eac4ac858d8a36674e358737e1c9f98` exists on the inspected repository and is titled `Reset Main staging after archival`;
- all repository reads explicitly used the required branch.

Therefore the remote investigation baseline is confirmed, while local branch cleanliness and fast-forward status remain unverified.

## 3. Repository topology and Design component inventory

The complete architectural surface was scanned through GitHub branch reads, dependency/import traversal, permanent checkpoints, and current staging. Generated Drift output and platform boilerplate are implementation products; handwritten ownership remains with the adjacent Dart/host sources.

| Exact path | Responsibility and dependency direction | Identity/state ownership | Ownership/status | Debt and Cycle relevance |
| --- | --- | --- | --- | --- |
| `clients/markei_flutter/lib/main.dart` | Flutter entrypoint; initializes binding, requests composition, runs app | process bootstrap only | handwritten; accepted/materialized | correct thin entrypoint; C08 keeps it thin |
| `clients/markei_flutter/lib/app/markei_composition.dart` | composition root; infrastructure adapters satisfy application ports | database lifetime, local account context, selected installation Device | handwritten; accepted prototype | hard-coded `local-account`; concrete return types leak infrastructure; Device selection invariant is provisional |
| `clients/markei_flutter/lib/app/markei_app.dart` | root Material shell and two-destination composition | selected tab and integer refresh signal for app lifetime | handwritten; prototype | phone-style bottom navigation only; no breakpoint policy, routing/detail navigation, draft-lifetime contract, or recovery state |
| `clients/markei_flutter/lib/app/pages/purchase_page.dart` | Purchase presentation directly builds application command | controllers, draft item list, warnings, transient message, submission trigger | handwritten; prototype | page owns too much workflow state; create-only item staging, no edit/remove/review; fixed MASS/BRL; no busy/idempotency guard; errors expose raw exceptions |
| `clients/markei_flutter/lib/app/pages/history_page.dart` | renders recent-history query projection | async snapshot only | handwritten; prototype | summary only; no date display, detail route, fact reconstruction, explicit loading/error, paging, or analytics |
| `clients/markei_flutter/lib/application/catalogue_queries.dart` | inward-facing Product/Store/similarity query port | no durable state | handwritten; accepted interface, incomplete use-case surface | list-only; search/select/create intent and exact-match result semantics need explicit contracts |
| `clients/markei_flutter/lib/application/register_purchase.dart` | registration command and persistence port | aggregate request/result boundary | handwritten; accepted prototype contract | command accepts store name rather than explicit Store reference/draft; no stable submission key or declared retry outcome |
| `clients/markei_flutter/lib/application/purchase_history.dart` | history list projection port | read model only | handwritten; provisional projection | summary projection lacks Purchase detail, item observation, paging, and analytic query ports |
| `clients/markei_flutter/lib/domain/shared/ids.dart` | typed record identities | Account, Device, Product, Store, Purchase, Item, Event IDs | handwritten; accepted/materialized | wrappers have no value equality; IDs must remain distinct from visible Product code and Store name |
| `clients/markei_flutter/lib/domain/catalogue/product.dart` and `product_code.dart` | Product identity, normalization, exact matching, advisory similarity | immutable Product record identity and visible user code | handwritten; accepted foundation | corrections/alias/merge deferred; normalization migrations remain version-sensitive |
| `clients/markei_flutter/lib/domain/store/store.dart` | account-private Store entity | Store UUID; display name is not identity | handwritten; accepted minimum model | branch/location and duplicate policy unresolved; current persistence exact-matches case-sensitive display name |
| `clients/markei_flutter/lib/domain/purchase/purchase.dart` | Purchase aggregate and Item invariants | registered Purchase/Item facts | handwritten; accepted foundation | draft is only a list of item drafts in widget state; registered fact immutability versus correction needs later explicit policy |
| `clients/markei_flutter/lib/domain/shared/quantity.dart` and `money.dart` | dimensional quantity and minor-unit money | value semantics inside facts | handwritten; accepted foundation | UI currently collapses choice to MASS and assumes BRL/two decimal display |
| `clients/markei_flutter/lib/domain/sync/sync_event.dart` | versioned `purchase.registered` envelope | event UUID, Device sequence, immutable aggregate payload | handwritten; materialized local preparation; Cycle 09 inactive | local event is not synchronization; content/retry semantics must be preserved |
| `clients/markei_flutter/lib/infrastructure/local/local_database.dart` | Drift schema, app-private database opening, v1→v2 migration | physical local facts, queue, cursor, migration ledger | handwritten schema/migration; generated `local_database.g.dart` | accepted local prototype; monolithic schema owner is manageable now but backup/recovery and future migration policy are incomplete |
| `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart` | resolves Store/Product and atomically writes Purchase, Items, Event, pending queue, sequence | transaction ownership and generated UUIDs | handwritten; accepted atomic prototype | one large adapter combines identity resolution, mapping, transaction, event serialization; double submission creates two valid aggregates |
| `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart` | implements Catalogue and History query ports | rebuildable read projections | handwritten; accepted prototype | Product row mapping duplicated; History has N+1 item-count reads; no detail/analytics/paging |
| `clients/markei_flutter/lib/infrastructure/local/local_device_identity_repository.dart` | loads or creates persistent local Device UUID | installation Device candidate | handwritten; provisional prototype | scans up to 20 account devices and picks first UUIDv4; no explicit unique current-installation relation or concurrency rule |
| `clients/markei_flutter/test/**`, `clients/markei_flutter/integration_test/**` | domain, migration, repository, widget, platform-boundary evidence | fixture/test state only | handwritten; materialized evidence, Operational acceptance not claimed here | C08 must extend contract tests for draft/retry/detail/analytics; this report does not claim test execution |
| `clients/markei_flutter/android/**`, `windows/**`, `ios/**` | generated/platform host projects and native lifecycle/package integration | OS process, package identity, app-private paths | mixed generated/handwritten host ownership | Windows/Android are active C08 hosts; iOS remains unvalidated/deferred; host code must not own domain workflow |
| `app/**`, `main.py`, `tests/**`, `database/**` | protected Python/PySide6 beta and legacy data boundary | established desktop runtime/database | handwritten; accepted/protected | behavioral/migration reference only; no Flutter direct opening, IPC dependency, or retirement in C08 |
| `contracts/shared_beta/v2/**` | language-neutral schemas/examples/fixtures | protocol meaning and fixture identities | handwritten canonical contract artifacts; accepted foundation | C08 local changes must not silently redefine Cycle 09 wire meaning |

## 4. Accepted architecture and materialized structures

The accepted inward direction remains:

```text
Flutter presentation
→ application commands/query ports
→ domain entities, values, invariants, analytics contracts
← infrastructure adapters implement application/domain ports
```

Materialized strengths to preserve:

- an isolated Flutter shared client beside the protected Python beta;
- a thin process entrypoint and explicit composition root;
- domain types independent of Flutter and Drift;
- account-private Product and Store records with UUID identity;
- visible Product code separated from internal Product identity;
- exact normalized Product reuse and advisory-only similarity;
- multi-item Purchase aggregate validation;
- one Drift transaction for Product/Store resolution, Purchase, Items, event, pending queue, and Device-sequence advancement;
- raw local facts separated from rebuildable query projections;
- app-private local storage, schema versioning, and migration ledger;
- local event preparation that preserves the future API boundary without claiming synchronization;
- persistent platform-neutral Device UUID as a bounded prototype;
- generated Windows/Android/iOS hosts kept outside domain ownership.

## 5. Provisional choices and prototype debt

Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX

Recommended provisional architecture for confrontation:

1. Introduce a presentation-facing Purchase draft coordinator/view model owned below the page but above domain facts. It owns Store selection/draft, staged Items, editing/removal, validation, review phase, busy/result state, and retry identity. Widgets own controllers/focus only.
2. Keep state management package-neutral in Sprint 02. A small explicit `ChangeNotifier`/`Listenable` or equivalent injected controller is cheaper and reversible; adopt a package only when navigation, restoration, or testing evidence justifies it.
3. Make the responsive shell choose navigation presentation by available width: bottom navigation for narrow space; rail or equivalent for wide space. Screen identity and selection remain shared; platform branding must not fork the product model.
4. Treat Catalogue and History as first-class screens/read models, not side effects of Purchase. Store selection may initially be a reusable picker flow without requiring a permanent Store screen.
5. Separate draft identity from registered fact identity. Draft Items may use ephemeral UI keys; Product/Store/Purchase/Item UUIDs become durable only at accepted resolution/registration boundaries.
6. Preserve exact Product equivalence as deterministic reuse. Similarity produces ranked advisory candidates and requires explicit human selection or `create anyway`; it never changes identity automatically.
7. Add an explicit client-generated `submissionId`/attempt UUID to registration. The repository must return the prior result for an identical retry and reject conflicting content, rather than relying only on disabling a button.
8. Extend History through dedicated list, detail, Product-observation, and comparison projection ports. Do not make widgets traverse Drift rows or event JSON.
9. Define personal price comparison as versioned derived analytics over immutable Item facts. The first useful observation should normalize line total by recorded purchased quantity/package basis only where dimensions and currency are comparable; absence/incomparability is a result, not zero.
10. Keep Drift as the local transaction owner in C08. Split query mappers/use cases only where responsibilities or tests benefit; do not introduce a generic repository abstraction or distributed topology prematurely.

Prototype debt presently includes raw exception display, N+1 History counts, hard-coded BRL and MASS, case-sensitive Store reuse, duplicated Product row mapping, no submit guard/idempotency key, no detail projection, no explicit loading/error model, and form draft loss/lifetime ambiguity.

## 6. Cycle 08 responsibility and state boundaries

| Concern | Proposed owner | Lifetime/invariant |
| --- | --- | --- |
| navigation selection | responsive shell coordinator | app session; same semantic destinations across widths |
| text/focus/keyboard | page/widgets | mounted view lifetime; never durable fact authority |
| Purchase draft and review | application-facing draft coordinator | survives view recomposition/navigation according to explicit policy; disposable after confirmed success/cancel |
| Product/Store search results | query use cases | refreshable read state; account-scoped |
| exact matching | Product domain normalization + repository uniqueness | versioned, deterministic, account-scoped |
| similarity warning | domain advisory rule + query adapter | non-authoritative; requires human choice |
| registered Purchase aggregate | domain invariants + registration transaction | immutable raw fact boundary in C08 |
| duplicate-submit protection | application submission identity + local unique persistence rule | identical retry returns same result; conflict fails atomically |
| History list/detail | application projection ports | rebuildable views over facts; no fact mutation |
| price comparison | versioned domain/application analytic + projection adapter | derived and reproducible from named fact boundary/version |
| database/migrations | Drift infrastructure | one local schema owner; no silent reset; migrations explicit |
| backup/export | application port with local adapter, if approved | consistent read boundary; format/version and recovery intent explicit |
| Device | installation identity repository + composition | exactly one selected current-installation Device before C09 sync |
| platform lifecycle | Flutter shell/host adapters | no domain-rule duplication in Windows/Android hosts |

Atomic registration must remain one local transaction. Network work must never enter that transaction. UI disablement is useful feedback but is not the identity guarantee. Registered aggregate correction/deletion remains deferred unless Main explicitly expands the fact model.

## 7. Alternatives, reversibility, and development cost

| Decision | Lower-cost/recommended route | Alternative | Reversibility and cost |
| --- | --- | --- | --- |
| state | injected draft coordinator using SDK primitives | Riverpod/Bloc/provider package now | low-cost route is highly reversible; package adoption adds dependency, conventions, and migration work |
| navigation | shared destinations with width-driven NavigationBar/Rail | router package and nested routes immediately | shell swap is cheap; deep-link/router adoption becomes justified with detail routes/restoration |
| Catalogue | dedicated query screen + picker reuse | embed all Product management in Purchase | dedicated boundary costs more UI now but avoids Purchase-page growth and is reversible at presentation level |
| Store | picker/create flow with UUID reference | free-text Store on registration | picker costs query/state work; preserves identity and later branch evolution |
| draft | explicit application draft model | keep `List<PurchaseItemDraft>` in widget | moderate refactor now; strongly reduces future edit/review/restoration cost |
| idempotency | client submission UUID persisted uniquely | busy flag only | schema/contract cost is moderate; postponement raises duplicate-fact migration cost |
| analytics | pure versioned calculation + query projection | cached mutable analytics as truth | compute-first is cheaper and reversible; cache later without changing meaning |
| local data | extend Drift schema by migrations | replace persistence or open Python database | Drift continuity is lowest risk; replacement/direct legacy access is high-cost and violates protection boundary |
| backup | decide contract in C08, implement only when authorized | postpone all consideration to C10 | early decision is cheap; late format/recovery retrofit is expensive |

## 8. Schema/dependency consequences — not authorization

Likely schema consequences if Main later accepts the recommendations:

- a unique durable submission/registration-attempt identity associated with Purchase and/or event;
- indexes supporting Product search/exact identity, Store search, History ordering/detail joins, and Product observation history;
- possibly normalized Store matching fields and version if Store duplicate policy is accepted;
- no table is required merely for responsive state or transient draft state unless restoration across process death becomes an explicit requirement;
- analytic results should remain computed/rebuildable initially; any cache requires analytic ID/version/input boundary;
- backup/export needs format version and consistency boundary, not necessarily a new database table;
- Device correction needs an explicit current-installation relation or singleton metadata rule plus uniqueness/concurrency migration before C09.

Likely dependency consequence: none is necessary for the first responsive/draft boundary. Navigation/state packages remain evidence-driven candidates. Drift stays accepted. These observations do not authorize `pubspec.yaml`, generated code, schema, or migration edits.

## 9. Carried installation–Device debt

The current repository finds up to twenty account Devices, selects the first UUIDv4, or creates another. This is accepted only for the one-installation prototype. It does not express `this installation owns exactly one current Device`, does not prevent multiple valid candidates, and has no explicit concurrent creation/repair policy.

Cycle 08 must keep the debt visible and must not let UI work deepen reliance on arbitrary selection. Recommended timing:

- Sprint 02–04: preserve current behavior, test lifecycle without claiming distributed safety;
- Sprint 05 acceptance: decide and, if authorized, migrate to an explicit current-installation invariant;
- hard gate before Cycle 09 upload/download: exactly one installation Device, durable across restart/upgrade, deterministic repair, unique sequence ownership, and concurrency-safe creation must be evidenced.

Uninstall/data clear may destroy the local Device with local-only data; backup/import must not accidentally clone Device identity unless the later protocol explicitly defines that behavior.

## 10. Cycle 09/10 deferrals

Cycle 09 remains the boundary for verified Account identity, authentication/authorization, TypeScript API, Neon/Postgres, idempotent upload, cursor download, bootstrap, convergence, and multi-device conflict behavior. C08 may preserve/clarify contracts but must not activate them.

Cycle 10 remains the boundary for production secrets, privacy/deletion, production-grade export/import and recovery, observability/support, signing, distribution, packaging, upgrade matrices, and controlled public beta. A bounded local backup/export decision may occur in C08, but production recovery guarantees remain deferred.

Also deferred unless separately activated: central/shared catalogue, automatic Product merge, Product alias/family/supersession, Store deletion/correction policy, registered Purchase editing/deletion, forecasting, iOS acceptance, legacy import, and PySide6 retirement.

## 11. Contradictions and human decisions

Contradictions/drift:

1. The workspace has a `.git` path but is not a usable checkout; therefore local status, current branch, pull, HEAD, and local-change safety could not be proven. Remote evidence does not cure this operational gap.
2. The supplied documentation archive is dated and contains many zero-length notebook working files; it was not treated as authority. The remote required branch supplied current truth.
3. `00_PROJECT_STATE.md` and `06_SESSION_SCHEME.md` headers still advertise Cycle 07 branch/baseline while their latest temporal sections correctly activate Cycle 08. Latest marked sections supersede the stale headers, but checkpoint refresh debt remains.
4. Historical text says D/E/F become implementation authority after Main approval; the active C08 loop explicitly requires every intermediate D/E/F to remain provisional until final human/Main activation. The stricter active-cycle rule governs.
5. The accepted Product identity model is stronger than current Store identity behavior; Store duplicate/branch semantics remain unresolved.
6. Atomic registration exists, but safe duplicate submission does not. Atomicity and idempotency must not be conflated.

Human/Main decisions required:

- Is Catalogue a top-level beta destination, or a reusable selection surface reached primarily from Purchase?
- Is Store a top-level destination or picker-only boundary in C08?
- Must Purchase drafts survive tab switches only, app backgrounding, or full process death?
- Is a persisted submission UUID accepted for C08, and what identical/conflicting retry result should the application expose?
- What is the minimum Store identity: normalized name only, or name plus optional branch/location?
- Which price basis is the first beta comparison: purchased-unit price, package-unit price, or a deliberately bounded subset by Product mode?
- Does C08 implement local export/backup, or only settle its contract and defer production implementation?
- Must installation–Device correction occur in Sprint 05, or may it remain a named hard gate at Cycle 09 entry?

## 12. Recommendations to Main

Main should preserve the materialized inward dependency direction and stage C08 as bounded increments:

1. responsive shell and explicit presentation-state ownership;
2. Catalogue/Store query and selection contracts;
3. Purchase draft coordinator with edit/remove/review;
4. idempotent atomic registration boundary;
5. History list/detail projections;
6. versioned personal price comparison;
7. migration, recovery, backup/export decision, Device invariant, and host acceptance.

Main should require each future provisional D/E/F to name exact files, state lifetimes, transaction owner, migration consequences, generated-code handling, tests/evidence, rollback/stop gates, and non-goals. No sprint should combine responsive restructuring, schema idempotency, analytics, and Device migration without separate acceptance gates.

## 13. Exact next staging route

```text
C08-R01 A/B/C complete
→ Main reads A_OPERATIONAL + B_DIDACTIC + this C_DESIGN
→ J_MAIN_STAGE reconciliation
→ provisional D/E/F
   Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
→ renewed O/A/D confrontation of J and provisional D/E/F
→ enriched J and replacement provisional D/E/F as required
→ repeat until contradictions and human decisions are resolved
→ explicit final human/Main activation
→ only then Codex materialization
→ G/H/I evidence
→ domain reconciliation and checkpoint refresh
```

Immediate next writer: Main Chat [M] in `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`, after all three current A/B/C reports are available. This C-stage does not write or activate D/E/F.

---

Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX

<!-- ROUND_MARKER:C08-C08-R02-[D]-2026-07-13 -->
# Cycle 08 Round C08-R02 — [D] Investigation

> Role: Design Chat [D]
> Authority: exploratory functional staging only
> Branch: `cycle-08-shared-client-product-beta`
> Inspected HEAD: `44b50788952947cfb3d23290192ebb3521d3a816`
> Ancestry: HEAD equals and therefore descends from the expected starting HEAD
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
> Write boundary: append to `C_DESIGN.md` only

## 1. Prompts executed and authority recovered

The complete definitions of `PRI-D`, `PMC-01`, `PMC-02`, `ERI-01`, and `FCA-02` were read and executed from `PROMPT_COLLECTION.md`; prompt names were not used as shorthand substitutes. Root `AGENTS.md` and `INDEX.md` were also recovered. The complete canonical methodology was not reopened because the prompt collection resolved the active routing and authority economically.

Confirmed boundary: Design may inspect architecture and append cumulative evidence to C. J and F remain provisional. No source, test, dependency, schema, generated code, host, permanent memory, methodology, J, D/E/F, G/H/I, or continuity file is writable or executable in this round. Publication of this single append is separately authorized.

Methodology/path drift remains: `INDEX.md` names `J_MAIN_STAGE.md`, while repository authority is `documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`. `F_DSN_STAGE.md` section 12 says “Replace C”; this is superseded for exploratory rounds by the newer explicit `FCA-02` append-only rule and the current human direction.

## 2. Repository surfaces inspected

Pinned branch reads covered:

- `AGENTS.md`, `INDEX.md`, and `methodology/PROMPT_COLLECTION.md`;
- latest Cycle 08 portions of `00_PROJECT_STATE.md`, `05_SESSION_LOG.md`, and `06_SESSION_SCHEME.md`;
- `[M]_STAGE/J_[M]_STAGE.md`, `DEV_STAGE/F_DSN_STAGE.md`, complete prior `DEV_STAGE/C_DESIGN.md`, and `design/09_DESIGN_STATE.md`;
- `clients/markei_flutter/lib/main.dart` and `lib/app/markei_composition.dart`;
- `lib/app/markei_app.dart`, `pages/purchase_page.dart`, and `pages/history_page.dart`;
- application ports in `application/catalogue_queries.dart`, `register_purchase.dart`, and `purchase_history.dart`;
- domain structures in `domain/catalogue/product.dart`, `product_code.dart`, `domain/store/store.dart`, `domain/purchase/purchase.dart`, `domain/shared/ids.dart`, `quantity.dart`, `money.dart`, and `domain/sync/sync_event.dart`;
- local adapters and schema in `infrastructure/local/local_database.dart`, `local_device_identity_repository.dart`, `local_purchase_repository.dart`, and `local_query_repository.dart`;
- `pubspec.yaml`, language-neutral `contracts/shared_beta/v2/**`, Flutter test surfaces, Windows/Android hosts, and the protected Python/PySide6 boundary.

GitHub’s repository search returned no symbol index, so symbol evidence below comes from exact pinned file reads and import traversal, not an assertion that GitHub code search enumerated every generated/test file. Generated Drift ownership remains with `local_database.dart` and build generation; generated output was not treated as a design owner.

## 3. Newly evidenced component, function, and object index

| Classification | Exact structure | New Design evidence and consequence |
| --- | --- | --- |
| newly evidenced | `_MarkeiAppState._selectedIndex` and `_refreshSignal` in `app/markei_app.dart` | Shell owns tab selection and an integer invalidation signal for app-state lifetime. `IndexedStack` keeps both page subtrees mounted, so Purchase widget state already survives Purchase↔History tab changes; J/F should not describe tab survival as wholly undefined. It does not prove process restoration. |
| newly evidenced | `PurchasePage` constructor | Presentation receives `AccountId`, `DeviceId`, registration/query ports, and callback directly. The page is coupled to identity/context and application ports but not Drift. A coordinator can be injected without changing inward dependency direction. |
| newly evidenced | `_PurchasePageState` controllers, `_items`, `_warnings`, `_bulk`, `_message` | Ten text controllers plus mutable draft/warning/message fields share mounted-page lifetime. `_items` is `List<PurchaseItemDraft>` with no draft-line identity, making stable edit targeting and keyed UI difficult. `_message` conflates validation, failure, warning, and success. |
| corrected | `_addItem()` in `purchase_page.dart` | Always constructs `NewProductReference`; it never consumes `CatalogueQueryRepository.listProducts` to select `ExistingProductReference`. The repository can reuse an exact new draft, but the UI does not yet offer explicit catalogue reuse. Similarity is calculated before staging but does not block staging or require explicit “existing/create anyway” choice. |
| newly evidenced | `_productDraft()` and quantity construction | UI hard-codes `MeasurementKind.mass`; `ProductMode.bulk` changes package fields only. Purchased quantity also hard-codes mass. Domain supports MASS/VOLUME/COUNT, but current UI cannot express two of them. |
| newly evidenced | `_registerPurchase()` | Creates `occurrenceTime` at button invocation and uses fixed BRL. It does not set busy state, disable during the Future, retain a submission identity, or distinguish unknown outcome. Double invocation can reach the repository as two logical registrations. |
| newly evidenced | `_parseMinorUnits()` | Presentation owns BRL-like two-decimal parsing, whereas `Money` only asserts a three-character currency code. A currency/input policy is missing; general currency support must not be inferred from the value object alone. |
| corrected | `normalizeProductCode()` in `domain/catalogue/product_code.dart` | Empty Product code throws; the current model makes code mandatory and limits its collapsed form to 1–64 characters. J’s “mandatory, optional, or advanced” is a future policy decision requiring domain/schema/migration work, not merely a UI choice. |
| newly evidenced | `Product.identityKey` | Exact identity includes account, normalization version, normalized name/brand, mode, and for packaged goods kind/amount/unit. User Product code is independently unique in persistence but is not part of `identityKey`. This dual uniqueness can reject a code collision even when semantic identity differs. |
| corrected | `isSimilarButNotExact(Product a, Product b)` | After excluding exact, cross-account, and cross-mode pairs, similarity uses only normalized-name edit distance/containment. Brand, measurement kind, and package quantity do not rank or suppress warnings. J/F’s “similar candidates” needs this narrower current-fact wording and a future similarity-policy decision. |
| newly evidenced | `CatalogueQueryRepository` | `listProducts(AccountId)`, `listStores(AccountId)`, and `similarityWarnings(AccountId, ProductDraft)` are whole-list/query methods. There is no search text, page/cursor, exact-resolution result, or Store-warning contract. A “search surface” is prospective, not materialized. |
| newly evidenced | `Store` and `Stores` table | Domain Store owns only UUID, AccountId, and displayName. Persistence has primary key `id` but no normalized name or account/name unique key. `_resolveStore()` performs account + case-sensitive `displayName.equals(name)`. Store reuse is therefore exact-string adapter behavior, not stable normalized identity. |
| newly evidenced | `PurchaseItemDraft` | Immutable value contains `ProductReference`, package count, normalized purchased quantity, and Money; it has no draft ID, validation method, copy/update operation, or product display snapshot. A presentation/application draft line is structurally distinct from this registration input. |
| retained/evidenced | `Purchase.validate()` and `PurchaseItem.validate()` | Registered aggregate requires at least one Item, positive package count/quantity, nonnegative line total, and matching currency. `totalMinorUnits` derives from Items. These invariants belong to domain facts and should not migrate into widgets. |
| corrected | `RegisterPurchaseCommand` | It carries free-text `storeName`, not StoreId or a sealed existing/new Store reference. F’s reusable Store picker is feasible, but command and adapter contracts must change to preserve explicit Store identity instead of collapsing selection back to text. |
| newly evidenced | `LocalPurchaseRepository.registerPurchase()` | One Drift transaction creates/updates account context, resolves Store/Product, inserts Purchase/Items, allocates Device sequence, inserts `purchase.registered`, and enqueues PendingEvent. It returns PurchaseId/EventId/sequence. Atomicity is evidenced structurally; there is no submission lookup/unique key. |
| newly evidenced | `_resolveProduct()` | `ExistingProductReference` verifies account ownership. `NewProductReference` first reuses exact identity, then rejects normalized code collision, then inserts. This is the correct adapter seam for a future explicit resolution result, but similarity has no authority here. |
| newly evidenced | `HistoryPage.build()` | `FutureBuilder` maps `snapshot.data == null` to an empty list, so loading and error both render “No purchases registered.” It has no selection/detail action and does not display `occurrenceTime` despite the projection carrying it. |
| newly evidenced | `LocalQueryRepository.listRecentPurchases()` | Returns at most 50 Purchases ordered by occurrence time and performs one item-count query per Purchase. The fixed limit is not paging; N+1 counts become a volume concern. Detail/observation/comparison ports remain absent. |
| retained/evidenced | `LocalDatabase` schema v2 | Products uniquely constrain account+normalized code and account+exact identity. SyncEvents uniquely constrain account+Device+sequence. Purchases have no submission identity. Stores lack normalized uniqueness. Migration supports only v1→v2 and throws otherwise. |
| newly evidenced | `LocalDeviceIdentityRepository.loadOrCreateDeviceId()` | Transaction ensures local account, reads up to 20 Devices ordered by creation, selects first UUIDv4, otherwise creates one. It does not model installation identity, enforce one current Device, or repair multiple valid candidates. |

## 4. Retained C08-R01 conclusions

- The thin entrypoint/composition root and inward presentation→application/domain←infrastructure direction remain sound.
- Widgets should retain controllers/focus/rendering; workflow state requiring broader lifetime belongs in an application-facing coordinator.
- Exact Product reuse and advisory similarity are separate; similarity never gains merge authority.
- Registered Purchase facts remain immutable in the current boundary; draft editing is pre-commit behavior.
- Drift remains transaction/migration owner; no new state/navigation dependency is required for a first bounded unit.
- History list/detail/observation/comparison are distinct read responsibilities.
- Analytics must be versioned and rebuildable from raw facts; incompatibility is a result.
- Protected Python data remains isolated; Device correction remains mandatory before real synchronization.
- Cycle 09 authentication/API/Neon/synchronization and Cycle 10 production distribution remain inactive.

## 5. Corrections and superseded claims

1. **Corrected:** draft survival across top-level tabs is not unknown: current `IndexedStack` retains the mounted Purchase page. Background/rotation/process-death semantics remain unevidenced.
2. **Corrected:** Catalogue is not yet a search surface; it is a whole-list port unused by Purchase UI for existing selection.
3. **Corrected:** current similarity is name-only advisory logic, not a general Product similarity model.
4. **Corrected:** Product code is materially mandatory. Making it optional affects normalization, Product construction, nullable/unique columns, migration, contracts, and tests.
5. **Corrected:** Store currently has record identity but no normalized identity invariant or duplicate-warning mechanism.
6. **Corrected:** History has an occurrence field in its read model but does not render it; loading/error are incorrectly presented as empty.
7. **Superseded:** F section 12’s replacement instruction is superseded by FCA-02 append-only staging.
8. **Retained but narrowed:** “atomic registration” is structurally supported; duplicate-submit idempotency is absent.

## 6. Confrontation with current J

Supported by repository truth:

- J’s carried architecture, Product identity separation, exact/advisory distinction, atomic transaction, raw/derived boundary, Device debt, and Cycle 09/10 deferrals;
- the need for a coordinator when state lifetime exceeds mounted widget state;
- the separation of History list/detail/observations/comparison;
- the atomicity/idempotency distinction and the need for persistence-backed retry identity;
- no immediate state-management/router package.

J corrections for MJR-03:

- record existing tab-switch survival through `IndexedStack` while leaving broader lifecycle policy open;
- classify Catalogue search and explicit reuse choice as prospective because only whole-list ports exist and Purchase always creates a NewProductReference;
- state that Product code is currently mandatory and optionality is schema-bearing;
- state the exact current similarity predicate (name edit distance/containment only);
- distinguish Store UUID record identity from absent normalized Store uniqueness;
- add History’s loading/error-as-empty defect and fixed-50/N+1 projection debt;
- distinguish a Store picker UI from the required command change away from free-text `storeName`.

No J conclusion is contradicted at the product-direction level, but several provisional statements require these implementation-specific qualifications.

## 7. Confrontation with paired provisional F_DSN_STAGE

Feasible/retained:

- constraints-driven NavigationBar/Rail shell;
- injected SDK-level coordinator;
- explicit existing/create-anyway Product choice;
- Store search/select/create boundary;
- durable submission UUID and unique local persistence;
- separate History/analytics ports;
- schema change isolation and delayed Device hardening.

Required F corrections/enrichment:

- preserve the append-only C rule;
- recognize current IndexedStack session/tab lifetime;
- require a draft-line key and explicit coordinator state/result algebra, not merely a moved `List<PurchaseItemDraft>`;
- add an explicit existing/new Store reference to the future registration boundary;
- separate Product-code optionality as its own schema-bearing decision;
- define similarity v1 as current name-only evidence or explicitly authorize a richer pure policy later;
- require History loading/empty/error states and remove N+1 before volume acceptance;
- avoid locating submission identity only on Event: Purchase registration idempotency should survive any later event-envelope evolution.

Smallest coherent first implementation boundary remains responsive shell plus explicit presentation state/error model, without schema change. Draft coordinator can follow as a second bounded unit unless Main deliberately combines them.

## 8. Structural additions and alternatives

### 8.1 Responsive shell state

- Problem: navigation control, selected index, and refresh invalidation are embedded in `_MarkeiAppState`.
- Responsibility: expose semantic destination selection and layout choice independently of NavigationBar/Rail.
- Owner/layer: presentation shell; affects `markei_app.dart` and page composition.
- Lifetime: app session; existing IndexedStack page state may be retained deliberately.
- Direction/persistence: presentation depends inward on existing ports; no persistence/schema impact.
- Validation: narrow/wide widget tests, destination preservation across resize, focus/Back checks.
- Cost/alternative: low; keep local StatefulWidget versus introduce router/package. Local SDK state is cheaper and reversible.
- Status: prospective, suitable first bounded unit.

### 8.2 Purchase draft coordinator and keyed draft lines

- Problem: `_PurchasePageState` conflates input mechanics, staged collection, warnings, result, and submission lifecycle; `PurchaseItemDraft` lacks edit identity.
- Responsibility: own `DraftLineKey`, staged lines, selected/draft Store, add/replace/remove, totals, review phase, busy/failed/succeeded/unknown result, and submission ID rotation.
- Owner/layer: application-facing presentation model injected by composition; widgets keep text controllers.
- Existing structures: `PurchasePage`, `PurchaseItemDraft`, `RegisterPurchaseCommand`, `MarkeiComposition`.
- Lifetime: app session initially; process restoration explicitly deferred unless human-selected.
- Direction/persistence: coordinator depends on application ports/domain values; no Drift dependency. No schema for transient draft.
- Validation: pure coordinator tests plus widget edit/remove/review and tab/resize/background policy evidence.
- Cost/alternatives: medium; alternative is widget-local list (cheaper now, expensive for edit/review). Highly reversible while package-neutral.
- Status: prospective; second bounded unit.

### 8.3 Explicit Product resolution workflow

- Problem: UI always creates `NewProductReference`; warnings do not require a decision.
- Responsibility: list/filter Products, evaluate exact/similar candidates, return explicit existing/create-anyway choice.
- Owner/layer: application query/use-case boundary plus presentation picker; domain retains normalization/similarity purity.
- Existing structures: `CatalogueQueryRepository`, `ProductSimilarityWarning`, `ExistingProductReference`, `_addItem()`, `LocalQueryRepository`.
- Lifetime: picker/search session; no durable state until registration.
- Direction/persistence: query port inward; existing Product schema can support exact reuse. Search indexes/paging are optional until measured.
- Validation: exact reuse, similar warning, create-anyway, account isolation, larger lists.
- Cost/alternatives: medium; client filtering is cheapest for bounded catalogue, repository search is scalable. Reversible port extension.
- Status: prospective; do not call current list port “search.”

### 8.4 Store reference and identity policy

- Problem: reusable Store selection collapses into free-text `storeName`; duplicate behavior is case-sensitive.
- Responsibility: sealed existing/new Store reference in registration and an explicit normalization/branch policy.
- Owner/layer: application command + Store domain policy + local adapter.
- Existing structures: `RegisterPurchaseCommand.storeName`, `Store`, `Stores`, `_resolveStore()`, `listStores()`.
- Lifetime: selected Store in draft; Store fact durable after registration.
- Direction/persistence: inward reference type; likely normalized Store fields and account-scoped unique/index constraint.
- Migration: schema v3 candidate must derive normalized values, detect collisions, and require a human ambiguity policy; never silently merge.
- Validation: case/Unicode normalization, duplicate advice, existing/new selection, migration collision fixtures.
- Cost/alternatives: medium-high. Keeping exact displayName is cheapest but perpetuates duplicate identity. Optional branch label adds future flexibility at higher UI/schema cost.
- Reversibility: picker is reversible; destructive identity merging is not. Preserve UUIDs.
- Status: unresolved/prospective; human decision required before schema instructions.

### 8.5 Local registration idempotency

- Problem: `_registerPurchase()` and repository can create two Purchases for one repeated intent.
- Responsibility: client-generated SubmissionId created when a draft becomes submit-ready; canonical content fingerprint; identical retry returns stored result, conflicting reuse fails.
- Owner/layer: coordinator creates/retains ID; application command carries it; infrastructure enforces uniqueness inside the registration transaction.
- Existing structures: `RegisterPurchaseCommand`, `PurchaseRegistrationResult`, `Purchases`, `SyncEvents`, `registerPurchase()`.
- Lifetime: submission intent through confirmed result/retry across restart; durable on registration.
- Direction/persistence: no outward dependency; requires submission column/attempt responsibility and unique constraint.
- Migration: schema v3 candidate; existing Purchases need nullable legacy submission identity or deterministic backfill that cannot imply retry equivalence. Prefer nullable legacy plus unique non-null behavior.
- Validation: concurrent/double call, restart retry, identical content, conflicting content, transaction rollback, sequence/event count.
- Cost/alternatives: medium-high. Busy flag is low-cost UX only; using EventId alone couples business idempotency to sync envelope. Separate SubmissionId is clearer and reversible.
- Status: prospective; schema-bearing unit separate from shell.

### 8.6 History detail, observation, and comparison

- Problem: fixed-50 summary, N+1 counts, no details, and loading/error collapse.
- Responsibility: typed list state; joined/paged summary; Purchase detail; Product observation stream; pure versioned comparison result.
- Owner/layer: application projection ports and local query adapter; pure analytic domain/application service.
- Existing structures: `PurchaseHistoryRepository`, `PurchaseHistoryEntry`, `HistoryPage`, `listRecentPurchases()`, Purchase/Item/Product tables.
- Lifetime: refreshable view state; analytics derived, not durable initially.
- Direction/persistence: widgets consume projections. Indexes may be needed on Purchase account/time and Item product/purchase after query measurement; no analytic cache initially.
- Migration: index-only/schema migration possible; no raw-fact rewrite.
- Validation: loading/empty/error, list/detail consistency, paging, query count/performance, currency/dimension incompatibility, algorithm-version fixtures.
- Cost/alternatives: medium. One joined detail projection is cheaper than generic analytics infrastructure. Reversible ports.
- Status: prospective for later Cycle 08 unit.

### 8.7 Product-code policy

- Problem: human decision asks whether code is optional, but domain/persistence currently require it for new Products.
- Responsibility: decide whether code is household-visible mandatory identity aid or optional lookup metadata.
- Owner/layer: human product decision, then Product domain/application/schema.
- Existing structures: `ProductDraft.userCode`, `normalizeProductCode()`, Product fields, Products nullable code columns with application-level requirement, unique account+normalized code.
- Lifetime/persistence: durable Product fact if present.
- Migration: optionality needs nullable domain type/serialization/fixtures; existing values remain. No destructive backfill.
- Validation: empty/duplicate/Unicode/legacy code behavior and recognition usability.
- Cost/alternatives: retaining mandatory is lowest development cost; optional is moderate and improves entry simplicity; auto-generated visible code risks confusing internal and human identity.
- Reversibility: mandatory→optional is easier than optional→mandatory for accumulated records.
- Status: human decision required; separate from responsive unit.

## 9. Likely dependency, schema, and migration consequences

- Responsive shell, explicit async states, and an app-session draft coordinator require no new dependency or schema.
- Store normalization/branch identity, durable SubmissionId, Product-code optionality, and performance indexes are distinct schema decisions and should not be bundled automatically.
- Any next schema version must extend the explicit v1→v2 migration strategy rather than rely on silent recreation; generated Drift output follows handwritten schema authority.
- History ports require query changes before schema changes; measure joined/paged queries first.
- No router/state package is justified by current evidence. No analytics cache is justified. No Python database access is permitted.

## 10. Validation and evidence requirements

Design requests, without claiming Operational execution:

- widget evidence for constraints-driven shell, destination/state preservation, explicit loading/empty/error, edit/remove/review;
- pure tests for coordinator transitions, draft-line identity, exact/similar/create-anyway choices, comparison compatibility and version;
- repository transaction tests for identical/conflicting/concurrent SubmissionId, one Purchase/Event/sequence effect, and restart retry;
- migration fixtures for every accepted schema choice, including Store collisions and nullable legacy submissions;
- query-plan/count and bounded-volume evidence before adding indexes or caching;
- Windows/Android evidence for resize/rotation, keyboard, Back, background/resume, cold relaunch, and chosen draft lifetime;
- regressions proving Python/PySide6 source/data isolation and unchanged shared-beta contract meaning.

## 11. Cross-domain consequences

- Operational: distinguish current tab retention from unevidenced lifecycle restoration; test unknown registration outcome and query counts; separate schema-bearing units.
- Didactic: Product code is currently mandatory; “similar” currently means name proximity only; “No purchases” must not cover loading/error; Store name is not stable identity; atomic and idempotent remain distinct.
- Main: group prospective structures by shell, draft, Product resolution, Store identity, idempotency, History/analytics, and Product-code policy rather than one UI block.
- Future sync: SubmissionId may remain client/business identity, while EventId remains envelope identity; do not collapse them without an explicit protocol decision.

## 12. Human decisions still required

1. Destination topology: Purchase/Catalogue/History with Store picker is the Design-preferred minimum; confirm Catalogue top-level and Store picker-only.
2. Draft lifetime: Design recommends app-session survival across tabs/resize/background, but not process-death restoration in the first unit. Confirm.
3. Product code: retain mandatory for Cycle 08 or accept separate optionality migration?
4. Store identity: normalized name plus optional branch/location label, or normalized name only?
5. Review: explicit phase in the same editable staged flow is cheaper than a separate route; confirm.
6. SubmissionId: accept a durable UUID distinct from EventId and PurchaseId?
7. Identical-content fingerprint: which occurrence-time value is frozen when the submit intent is created?
8. First comparison: Design recommends normalized purchased-unit price for same Product, currency, kind, and canonical unit; confirm package-size-change presentation.
9. Backup/restore and installation–Device timing remain unresolved as in R01/J/F.

## 13. Recommendations for J restaging

MJR-03 should retain R01’s product spine but append the exact corrections in sections 5–6. It should classify current tab survival, mandatory Product code, name-only similarity, absent Store normalization, free-text Store command, History state collapse, and fixed-50/N+1 behavior as repository facts. It should group schema-bearing choices separately and preserve explicit human ownership.

Recommended provisional priority:

```text
shell/state semantics without schema
→ draft coordinator and explicit review without persistence
→ Product/Store resolution contracts
→ isolated SubmissionId migration
→ History detail/observation/comparison
→ recovery/backup/Device hardening
```

## 14. Recommendations for next F enrichment

MDE-04 should append, not replace, a Design enrichment that:

- corrects the C append instruction;
- maps exact current symbols and newly evidenced limitations;
- accepts SDK-only shell/coordinator as the smallest reversible candidates;
- treats Store identity, Product-code optionality, SubmissionId, and performance indexes as separate decisions/migrations;
- introduces `DraftLineKey` and explicit async/result states conceptually without inventing final filenames;
- requires an existing/new Store reference before a Store picker can preserve identity;
- keeps SubmissionId distinct from EventId provisionally;
- requests the exact human decisions above;
- remains `PROVISIONAL — NOT AUTHORIZED FOR CODEX`.

## 15. Exact next route

```text
C08-R02 C append published
→ complete C08-R02 A/B/C publication
→ Main runs MJR-03
→ Main appends grouped J reconciliation
→ Main runs MDE-04
→ Main appends provisional D/E/F enrichment
→ renewed O/A/D confrontation as required
→ explicit final human/Main activation
→ Codex only after controlling D/E/F are activated
```

No implementation, promotion, dependency, schema, host, or Codex authority is created by this append.

