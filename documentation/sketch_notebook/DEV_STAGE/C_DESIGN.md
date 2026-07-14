<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Sprint 02 Design stage. Replaces prior active C cache; earlier Design history remains in permanent observational files. This report is investigative, not Codex authority.

# C_DESIGN — Cycle 09 Sprint 02 Design Investigation

Sequence: FLX-INV-02
Role: Design lead [D]
Branch/baseline: `intermid-cycle-recovery`, after `c67d573f1335ffd55c659a9ee795982ca72c2c32`
Evidence: screenshots 6–10=current; mockups 1–5=target proposal; handwritten Flutter/source/tests; current I/J/checkpoints
Writable surface: this file only
Prohibited: source, schema, dependencies, permanent memory, D/E/F/J
Evidence boundary: repository/static design investigation; no tests or runtime rerun

## 1. Current topology and target

Current: seed-color Material theme, standard AppBar, rail ≥720 px, bottom bar below, `IndexedStack`, long ListView/Column forms, standard fields/ListTiles/Cards, sparse hierarchy and rigid Rows. Screenshots add pale surfaces, unused desktop space, overflow and weak selection/action feedback.

Target proposal: cream/white surfaces, dark-green primary, lavender secondary, stronger hierarchy/spacing, tables/cards, chips, explicit states, accessible selection, desktop panes and mobile cards/sheets. It is not accepted architecture.

Preserve dependency direction:

```text
presentation tokens/components/adaptive pages
→ application ports/read models/typed results
→ domain semantics
← adapters
→ handwritten Drift
```

Widgets never consume Drift rows.

## 2. Visual-system alternatives

| Alternative | Fidelity | Maintenance/test/responsive/accessibility | Migration/risk | Decision |
| --- | --- | --- | --- | --- |
| Expanded ThemeData + page-local widgets | medium | duplicated page rules; inconsistent states | cheap start; drift/oversized pages | reject as final |
| Markei tokens + reusable components | high | central semantics, widget/golden testing, no dependency | moderate incremental extraction | recommend |
| Tokens + components + adaptive compositions + packages | highest potential | good only if packages stay behind adapters | dependency/license/platform risk | conditional |

Use Flutter SDK first. Do not add a UI framework. Consider `intl` only if locale/date formatting cannot remain small and deterministic; consider native share separately. Reject table/layout packages until SDK widgets fail a named requirement.

## 3. Proposed token model

```text
colors: canvas cream; surface white; secondary lavender; primary dark green;
        semantic storage/success, shortage/warning, market/due, error,
        unavailable/disabled; all contrast-tested
type: display 32/40; title 24/32; section 18/24; body 14/20; label 12/16
space: 4, 8, 12, 16, 24, 32, 48
radius: 8 controls/chips; 12 cards; 16 panels
surface: border-first; subtle shadow only for elevated/selectable content
icons: Material icons, 20 inline / 24 navigation; icon+label for critical actions
heights: 40 compact, 48 standard controls, 56 touch/navigation minimum
breakpoints: compact <600; medium 600–1023; expanded ≥1024
adaptation: expanded table/pane → medium wrapped table/card → compact cards/sheet
states: explicit selected, hover, focus-visible, pressed, disabled, error
```

Main must freeze exact colors, contrast, density and dark-mode scope.

## 4. Reusable component architecture

Presentation-only `lib/app/design/`: `MarkeiTokens`, Theme extension, spacing/type helpers.
Presentation-only `lib/app/widgets/`:

- `MarkeiAdaptiveShell`, desktop sidebar/rail, compact navigation;
- `MarkeiPageHeader`, toolbar, section/surface card;
- summary/stat card, filter bar/filter sheet;
- responsive data view: desktop table + mobile card list;
- status chip; loading/empty/error/unavailable panels;
- selection toolbar; Product row/card; Purchase review table;
- reference selector showing visible ID + nickname;
- typed failure banner;
- local date/time fields;
- currency/amount/unit-price fields.

Components accept immutable application read models/callbacks. Pages own transient selection/controllers; application owns query/command contracts; domain owns validation/calculation; adapters own persistence/platform IO.

Likely paths: new `lib/app/design/*`, `lib/app/widgets/*`; refactor `markei_app.dart` and pages incrementally. Tests: `test/app/design_system_test.dart`, component widget tests, existing `markei_app_test.dart`.

## 5. Interaction contracts

| Context | Tap/click | Double-click desktop | Explicit/keyboard | Details |
| --- | --- | --- | --- | --- |
| Catalogue browse | select row only | primary selection confirmation only when picker context exists | Select button, Enter/Space | separate Details button |
| Purchase picker | select Product | confirm selection; never add Item | Select/Enter | separate Details |
| History | toggle selection + reveal detail | toggle/confirm selection only | checkbox, Space, toolbar | expand/detail action |

Deterministic rule: double-click repeats the context’s primary selection action; it never opens details and never adds an Item. Details always uses its own action. Adding Item requires explicit Add/Save.

Selected Product/Purchase IDs are transient page state. `IndexedStack`/shell preserves Purchase draft. Review is a state over the same draft; Back to edit retains values. Desktop may show list+detail pane; compact opens route/sheet and returns without changing selection.

Tests: tap/double-click/keyboard equivalence, details isolation, selection persistence, review/back, navigation draft preservation, narrow/wide transitions.

## 6. Purchase date/time

| Alternative | Correctness/cost | Decision |
| --- | --- | --- |
| one UTC occurrence instant from editable local date/time | smallest; current schema compatible | recommend |
| persist local date/time + offset/zone metadata | strongest historical civil-time evidence; schema/migration cost | defer |
| current `now()` with cosmetic editors | misleading; ignores edits | reject |

Keep `Purchases.occurrenceTime` UTC. Page initializes local date/time to now; date/time pickers edit one local `DateTime`; command receives `.toUtc()`. Review shows `dd/MM/yyyy` and `HH:mm`; History converts stored UTC to current local display.

DST: reject nonexistent local times where detectable; document ambiguous repeated-hour limitation because no zone ID is stored. Tests freeze timezone/clock where feasible, verify local→UTC→display, date rollover, review/back, reopen. No schema migration.

Paths: `purchase_page.dart`, optional application clock abstraction, register command/widget tests.

## 7. Lists projection repair

Current `LocalQueryRepository.productListProjection()` already begins with Products and left-joins Items/Purchases in one query. `personalCycleV1` requires two distinct local purchase dates; one valid Purchase therefore displays `Not enough history`. The read model currently omits latest occurrence, amount/unit, derived unit price, Store and Person, so fetched relations appear absent.

Recommended state algebra:

```text
NoPurchaseHistory
LearningHistory(observationCount, latest facts)
IncompatibleHistory(reason, latest facts)
AvailableCycle(...)
ProjectionQueryFailure(AppFailure)
```

Bounded query:

1. fetch all Account Products;
2. one joined/batched observation query by Product with Purchase, Item, optional Store/Person;
3. group in adapter; retain zero-history Products;
4. choose latest deterministically by occurrenceTime then Purchase/Item ID;
5. expose latest Purchase, amount/unit, line total and derived unit price;
6. feed compatible distinct-day dates into pure cycle function;
7. apply Storage/Shortage/Market filters only to available cycles; All shows every state.

Avoid N+1. Optional Store/Person filters must be application parameters and account-scoped; Main must decide whether active in Sprint 02. No List/cache table.

Paths: `application/product_lists.dart`, `local_query_repository.dart`, `lists_page.dart`.
Tests: zero/one/two purchases; same-day observations; incompatible units/currencies; Product without Item; deterministic latest; filters; query failure; query-count/bounded SQL; responsive row contents.

## 8. Person and Payment Method visible IDs

| Option | Schema/migration | Readability/privacy/archive | Decision |
| --- | --- | --- | --- |
| shortened UUID | none | opaque, collision/display/privacy risk | reject as durable UI ID |
| immutable generated visible code | columns + account uniqueness + backfill | readable, stable in History/export; archive-safe | recommend |
| user-defined code | columns + collision/correction UX | meaningful but higher support cost | reject for Sprint 02 |
| nickname only | none | ambiguous; fails ID+nickname requirement | reject |

Recommend typed codes (`P-0001`, `PM-0001` or Main-approved format), immutable and Account-scoped unique; opaque UUID remains FK. Optional/local-only behavior unchanged. Archive never reuses a code. Exports/History use `code — nickname`; Settings may copy but not edit code.

Schema unit: add nullable-then-backfilled visible code columns, unique indexes, deterministic v3 fixture backfill, then require in new writes. This is separate from UI restyle and active-only nickname correction. Main may defer the schema unit; do not expose UUID as a substitute.

## 9. BULK pricing

Contract:

```text
normalized amount microunits
× price minor units per canonical KG/L/UNIT
÷ 1,000,000
→ line total minor units, half-up
```

Positive amount; unit compatible with measurement kind; comma/dot input normalized; price has currency minor-unit precision; COUNT remains integral under current domain.

Half-up integer formula for nonnegative inputs:
`(amountMicros * pricePerUnitMinor + 500000) ~/ 1000000`.

Presentation labels price as `BRL per kg/L/un`, previews derived total, and review shows amount, unit price reference and authoritative line total. Persist existing amount/unit + line total only; do not add competing unit-price truth. History derives unit price. Existing rows remain compatible; no migration.

Paths: domain/application pure calculator (not widget), `purchase_page.dart`, review/read models. Tests: kg/g/L/ml/un conversions, comma/dot, half boundary, zero/negative/overflow, review/back/edit, persisted total.

## 10. Incremental materialization

Recommend horizontal foundation followed by vertical page slices:

1. tokens/theme + adaptive shell; app remains runnable;
2. shared states/components; old pages may consume them gradually;
3. Purchase date/time, selection, BULK pricing and review;
4. Catalogue selection/details;
5. Lists read model/query/UI;
6. History + Settings visible-reference presentation;
7. responsive/accessibility/Windows/Android validation.

Compatibility seams: keep existing application ports until each page contract is ready; wrappers render old read models; no schema dependency for 1–5 except optional visible-reference codes; every checkpoint passes analysis/tests and preserves draft/navigation.

Reject one broad UI rewrite: failure attribution, screenshot comparison and rollback become unsafe. Pure page-by-page without shared foundation is also rejected because styles/states drift.

## 11. Decision matrix / authority envelope

| Unit | Source/tests | Schema/deps | Invariant | Stop condition |
| --- | --- | --- | --- | --- |
| tokens/shell | app/design, widgets, `markei_app.dart`; widget/golden/a11y | none | destination/draft preserved | overflow, contrast, route regression |
| Purchase | page + domain calc/tests | none | UTC fact; one price truth | rounding/time ambiguity unresolved |
| Catalogue | page/query ports/tests | none | select ≠ details ≠ add | shortcut conflates actions |
| Lists | product_lists/query/page/tests | none | all Products; no N+1/cache | zero-history lost/query failure hidden |
| visible refs | domain/app/repo/settings/history/export + migration tests | schema-bearing | UUID FK ≠ visible code; archive-safe | collision/backfill/reopen unproved |
| validation | app tests/platform checks | package only if approved | accessible equivalents | Android/Windows blocker unclassified |

## 12. Main decisions unresolved

1. exact token colors, contrast, dark mode and density;
2. navigation grouping and breakpoint values;
3. SDK-only versus `intl`; native-share remains separate;
4. double-click primary action in browse-only Catalogue;
5. adaptive details route/sheet/pane breakpoints;
6. DST repeated-hour limitation acceptance;
7. Lists Store/Person filters and compatible-observation rules;
8. visible reference code format and whether schema unit enters Sprint 02;
9. BULK price input precision/range and half-up contract;
10. golden-test policy and screenshot acceptance sizes;
11. horizontal-foundation + vertical-slices sequence approval;
12. exact D/E/F unit boundaries, writable paths, rollback and platform gates.

State: investigation complete; C replaced; Codex inactive; no source/schema/dependency/permanent-memory change.
