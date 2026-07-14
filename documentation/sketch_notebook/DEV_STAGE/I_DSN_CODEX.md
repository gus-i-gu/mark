# I_DSN_CODEX — Cycle 09 Design Evidence

> Sequence: FLX-ORD-01
> Unit: C09-U02
> Status: Architecture evidence only; not permanent Design memory

## Topology

- Preserved dependency direction: Flutter presentation uses application ports/read models; repositories adapt Drift rows; domain owns Product/Purchase/quantity semantics.
- Composition remains explicit in `MarkeiComposition`.
- Widgets do not receive Drift rows or raw SQLite exceptions.
- Generated Drift code remains derived from `local_database.dart`.
- Protected Python/PySide6/database topology was not changed.

## Application And Domain Ownership

- Application contracts added for typed failures, local references/preferences, Home descriptors, Lists projections, exact Product lookup, and Purchase export DTOs.
- Domain owns Product normalization v3, local reference value semantics, nullable BULK package count, and display quantity normalization.
- Presentation owns selected destination, staged draft lines, History selected-ID set, and temporary UI feedback.
- Local repository owns Drift transactions, v3 migration, read models, reference lifecycle, preference persistence, Lists projection query, and export bundle retrieval.

## Schema v3 And Migration

- New tables: People, PaymentMethods, AccountPreferences.
- Purchases gain nullable `person_id` and `payment_method_id`.
- PurchaseItems `package_count` is nullable for BULK.
- Product normalization version moves to 3; v2 rows are rewritten to v3 exact keys without rewriting Purchase history.
- Legacy null codes are deterministically backfilled from Product IDs.
- Migration preflights v3 exact identity collisions and stops on collision.
- v2 migration rebuilds `purchase_items` to relax package count nullability.
- Fresh-create, v1 migration, file-backed v2-to-v3 migration, close/reopen, and generated-code evidence are present.

## Projection, Export, And Share Architecture

- Lists are transient projections from Product/Purchase observations; no List aggregate or cache table was added.
- `personal-cycle-v1` is pure Dart and versioned in the application layer.
- CSV/PDF export uses selected Purchase DTOs independent of Drift/widgets.
- CSV is deterministic UTF-8 text.
- PDF is generated as simple PDF bytes with Dart standard libraries.
- Save/share behavior writes explicit local files and tells the user to share manually; no upload or synchronization path was activated.

## Dependency Choices

- No new Flutter dependency was added.
- Reason: current requirements could be satisfied with Dart standard libraries for deterministic CSV/PDF file evidence, avoiding unsupported or unverified share dependencies on this host.
- `pubspec.yaml` and `pubspec.lock` were not changed.

## Invariants

- Account-scoped Product code and exact identity remain enforced.
- Exact Product collision is not similarity.
- BULK has no package count and does not persist a competing price truth.
- Optional references are nullable and history-preserving.
- Registered Purchase edit/delete remains disabled.
- Analytics and Household remain disabled/PIN-labelled.
- Store identity, sync/API/auth, SubmissionId, persisted drafts, and Product auto-merge remain outside implementation.

## Deviations And Risks

- OS-native share plugin was not introduced; share is explicit local PDF save plus manual share boundary.
- Android build/runtime is host-blocked by missing Java.
- Windows smoke was bounded process launch only, not full manual acceptance.
- Future review should inspect UI density for small screens and decide whether native share dependencies are worth adding.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
