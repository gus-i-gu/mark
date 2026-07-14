# F_DSN_STAGE — Cycle 09 Architecture and Materialization Contract

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Unit: C09-U02
> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITH D/E
> Report: replace `DEV_STAGE/I_DSN_CODEX.md` with a ≤250-line C09 report

## 1. Dependency direction

Preserve:

```text
Flutter presentation
→ application commands/query/export ports
→ independent Dart domain
← local repository/export/share adapters
→ Drift v3 / app-private SQLite
```

Widgets must not receive Drift rows or raw SQLite exceptions. Generated Drift code is
derived; change handwritten schema/migration authority and regenerate. Keep composition
explicit and Python/PySide6/database isolated.

## 2. Authorized surfaces

Codex may modify the smallest coherent subset under:

```text
clients/markei_flutter/lib/app/
clients/markei_flutter/lib/application/
clients/markei_flutter/lib/domain/
clients/markei_flutter/lib/infrastructure/local/
clients/markei_flutter/test/
clients/markei_flutter/pubspec.yaml
clients/markei_flutter/pubspec.lock
clients/markei_flutter/android/
clients/markei_flutter/windows/
```

It may regenerate existing Drift artifacts and add tests/fixtures within established test
structure. Android/Windows edits are limited to dependency-required save/share integration.
New Flutter dependencies are limited to PDF generation, explicit file save and OS share
capabilities; inspect maintenance, license and SDK/platform support first.

## 3. Application contracts

Add typed contracts/read models for:

- destination registry and static Home descriptors;
- exact Product lookup by code and identifying draft;
- immutable Product detail by ProductId;
- typed application failures/results;
- Person/Payment Method list/create/rename/archive/reactivate;
- optional reference fields in registration command/result/history;
- versioned PersonalCycleResult and ProductListProjection;
- selected-Purchase Export DTO graph;
- CSV encoding, PDF rendering, save/share outcomes.

Presentation owns draft state, selected destination, History selected-ID set and temporary
filters. Domain/application owns identity, validation, lifecycle, projections and results.

## 4. Schema v3

Add dedicated Account-owned People and PaymentMethods with UUID, nickname,
normalizedNickname, active/archive state and timestamps. Add nullable Person/PaymentMethod
FKs to Purchases, nullable packageCount for BULK Items, and typed Account preference with
shortageThresholdDays default 5.

References use restrictive/no-action history-preserving behavior. Archive hides ordinary
selection but retains History/export resolution. Backfill optional refs null. Do not store
payment credentials. Do not physically delete referenced rows.

Introduce Product normalization version 3:

- PACKAGED key: normalized name/brand/mode + canonical package quantity/unit;
- BULK key: normalized name/brand/mode, excluding package facts/dimension;
- visible Product code remains separately Account-scoped unique;
- deterministically backfill legacy null codes from immutable Product IDs, collision-safe;
- preflight v2 rows and stop/report exact-key collisions; never auto-merge or rewrite Items.

Build a sequential v2→v3 migration with ledger update, transactional failure, fresh-create,
representative fixture, reopen and no-silent-reset tests.

## 5. Quantity and money

One presentation parser accepts comma/point and yields locale-neutral fixed decimals.
Domain remains MASS→KG, VOLUME→L, COUNT→UNIT at scale 1e6. Reject fractional COUNT and
ambiguous mixed separators.

PACKAGED requires positive package count. BULK package count is null/not applicable.
BULK accepts amount and price per canonical unit; calculate line total in integer minor
units with documented half-up rounding. Do not persist a second competing price truth.

## 6. Pages and adaptive behavior

- Home is startup index 0; card content is static configuration.
- Use typed destinations; preserve `IndexedStack` state where useful.
- Catalogue owns Product list/search/create; shared Product detail route adapts to compact
  full route and wide pane/sheet.
- Purchase uses optional reference selectors and mode-specific quantity controls.
- Settings manages People, Payment Methods and shortage threshold.
- Analytics/Household are disabled; Guide/Docs bounded static pages.
- Explicit action/tap/keyboard opens details; desktop double-click is convenience only.

## 7. Lists v1

Create a targeted observation query returning Product display/code and ordered Purchase
Item dates/amount/price without per-row N+1 queries. Pure Dart implements J's
`personal-cycle-v1`, explicit unavailable reasons, four views and approximate total.
Do not store cycle/status/cache. Registration and threshold changes invalidate projections.
Measure realistic fixtures before adding indexes; report any justified index separately.

## 8. History and export/share

History owns transient `Set<PurchaseId>`. Checkboxes/tap/keyboard and clear/select-all are
primary. Use explicit double-click only on pointer platforms.

Export DTO: Purchase ID/time, Store, optional reference labels, currency/total and ordered
Items with Product code/name/brand, quantities and totals. CSV is UTF-8, deterministic,
properly quoted and one row per Item with repeated Purchase columns. PDF groups selected
Purchases. Renderer, file creation and share adapters are separate. Handle cancellation,
cleanup and failure; never upload. Move to Analytics/edit/delete remain disabled.

## 9. Architectural stop conditions

Stop before broadening if implementation requires Store redesign, Product merge/correction,
SubmissionId, persisted drafts, projection cache, error DB, sync/API, registered-Purchase
mutation, generic settings ownership, or changes outside the authorized tree except reports.

Stop on unresolved migration collisions, loss of atomic registration, loss of historical
references, unsupported share dependencies, or unbounded query design.

## 10. I report

Replace I with a concise architecture report: chosen structures, schema/migration design,
dependency choices, changed paths, invariants/tests, deviations, remaining risks and exact
stop conditions encountered. Evidence is not permanent promotion. Maximum 250 lines.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
