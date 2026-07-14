# 14_MODEL_OVERVIEW.md

> Version: 0.5-cycle07-sprint03-unit01
> Status: Active Derived Overview
> Persistence Class: Derived
> Knowledge Class: Design
> Authority: Design Chat [D]
> Canonical Source: `design/01_ARCHITECTURE.md`
> Scope: Compact responsibility and evidence map after the local Flutter foundation

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above preserves earlier planning; this segment is the rebuildable current Design map after Sprint 05.

# 1. Current System Map

```text
Protected Python/PySide6 beta
    separate Cycle 06 SQLite; behavior reference and rollback

Windows / Android Flutter hosts
    → shared Flutter entrypoint and composition
    → presentation
    → application commands/query ports
    → independent Dart domain
    → local repository adapters
    → Drift schema v2
    → application-private SQLite

Deferred distributed path
    Flutter sync coordinator
    → authenticated TypeScript API
    → Neon Postgres
```

Android/Kotlin hosts Flutter only; it owns no business or persistence semantics.

# 2. Identity Ownership

| Identity | Owner and current state |
| --- | --- |
| Android application ID | `com.gusigu.markei`; installation/update/sandbox identity |
| Android label | `Markei`; presentation metadata |
| Account | `local-account`; provisional prototype placeholder |
| Device | database-owned UUID v4; created before composition completes |
| Device sequence | `devices.next_sequence`; allocated inside Purchase transaction |
| Product | immutable internal ID + user Product code + normalized identity facts |
| Purchase / Item | immutable local aggregate identities and facts |
| Event | UUID plus Account/Device/sequence envelope |
| central/cloud identity | deferred |

# 3. Device Bootstrap

```text
main() awaits MarkeiComposition.appPrivate()
→ open LocalDatabase.appPrivate()
→ LocalDeviceIdentityRepository.loadOrCreateDeviceId(local-account)
→ insert Account if absent
→ find reusable UUID v4 Device or create one
→ inject DeviceId into shared composition
→ event-producing commands become available
```

Tests establish creation, close/reopen reuse, distinct fresh-database IDs, sequence 1→2 continuity, and historical non-UUID preservation.

# 4. Prototype Debt

Current selection scans the first 20 Account Devices by creation time and chooses the earliest UUID v4.

```text
acceptable now
    bounded single-installation prototype

not acceptable for synchronization
    no explicit current-installation relation
    first-20 truncation
    ambiguous multiple-UUID selection
    no dedicated concurrent-bootstrap uniqueness
```

Future requirement: one installation metadata record references exactly one Device, bootstrap is idempotent under concurrency, and historical Devices remain separate.

# 5. Persistence and Schema

Schema v2 already owns Account, Device, sequence, Product, Store, Purchase/Items, Event, pending queue, sync metadata, and migration ledger. Sprint 05 changed bootstrap behavior, not persisted shape, so no schema migration was required.

Historical non-UUID Device rows remain untouched. Android runtime observed the SQLite database inside `com.gusigu.markei` application-private storage. Local queue/event preparation remains distinct from synchronization.

# 6. Purchase Transaction

```text
resolve/create Store and Product references
→ validate Purchase and Items
→ persist aggregate
→ allocate sequence for injected Device
→ persist purchase.registered event
→ enqueue pending event
→ commit once
```

# 7. Functional Scaffold

```text
Purchase / History navigation
+ SafeArea
+ scrollable phone-width form
+ staged BRL total
+ atomic registration
+ visible History
```

These are implemented functional-scaffold decisions, not final UI/UX. SafeArea owns inset avoidance; staged total exposes aggregate feedback. Broad visual hierarchy, accessibility, navigation refinement, and design-system work remain later.

# 8. Evidence Boundary

**Validated:** 27 Flutter tests, analysis, debug APK, identity badging, API 36 emulator boot/install/launch, Android sandbox database observation, Device bootstrap/sequence tests, human Purchase registration, Windows build, and five Python tests.

**Partial:** Android lifecycle/ergonomics, keyboard, Back, rotation, background/resume, larger text, and accessibility.

**Deferred:** physical device, release signing/store, backup policy, authentication, API/Neon, synchronization, central catalogue, import, broad UI/UX, iOS, and PySide6 retirement.

# 9. Configuration Boundary

```text
architectural
    stable application/sandbox identity
    shared dependency direction
    database-owned Device and sequence ownership
    app-private persistence

operational configuration
    compile/target SDK 36
    NDK, Java, Gradle
    Android Studio, emulator, SDK tools
```

# 10. Next Design Route

```text
optional bounded Android lifecycle/ergonomics supplement
→ Main closes Sprint 05 evidence
→ choose later UI/UX formalization or another accepted milestone
→ resolve explicit installation-Device invariant before real synchronization
```

# 11. Recovery Pointers

- Canonical: `design/01_ARCHITECTURE.md`, sections 16–19.
- Observational: `design/03_DECISION_LOG.md`, Event 17.
- Checkpoint: `design/09_DESIGN_STATE.md`.
- Evidence: `DEV_STAGE/I_DSN_CODEX.md`.
- Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md`, §24.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above belongs to Cycle 08 or earlier reviewed project history. This regenerated segment is the current Cycle 09 Design map.

# Cycle 09 Current Design Map

## 1. Topology

```text
Flutter shell/pages
→ application ports/read models/failures
→ Dart domain semantics
← local adapters
→ handwritten Drift v3
→ app-private SQLite
```

Generated Drift is derived. Python/PySide6 and its database remain protected.

## 2. Implemented local expansion

- Home-first responsive navigation and static offline descriptors.
- transient `personal-cycle-v1` Lists projections; no List aggregate/cache.
- People, PaymentMethods and AccountPreferences.
- nullable historical Purchase references.
- null BULK package count.
- normalization v3 with collision preflight and legacy-code backfill.
- History selected IDs, export DTOs, deterministic CSV and PDF bytes.
- typed application failures and exact Product lookup ports.
- ProductId-bound detail query and bounded Catalogue detail card.

## 3. Current claim states

| Claim | State |
| --- | --- |
| BULK null package count | implemented |
| BULK price-per-unit input + half-up total | contradicted completion; UI still asks Line total |
| active-only nickname uniqueness | contradicted; physical key also limits archived duplicates |
| required codes for new Product commands | implemented |
| database Product-code NOT NULL | contradicted; columns remain nullable |
| PDF byte generation | implemented |
| native/save-dialog PDF sharing | deferred; temporary-file/manual sharing only |
| exact lookup application/repository ports | implemented |
| exact lookup Catalogue presentation | partial; substring filtering remains |
| Product detail query/card | implemented bounded form |
| shared adaptive Product details | partial/deferred |
| typed user-facing failures | partial across pages |
| History checkbox/tap selection | implemented |
| double-click/select-all conveniences | partial |

## 4. Ownership map

```text
presentation
    destination, draft, selected IDs, detail-card visibility, feedback

application
    Home descriptors, projections, lookups, references/preferences,
    export DTOs/encoders, typed failure vocabulary

domain
    Product normalization/identity, dimensional quantity,
    BULK package-count meaning, local-reference values

repository/handwritten Drift
    schema v3, migration/collision preflight, transactions,
    reference lifecycle, query translation and export retrieval
```

## 5. Stable boundaries

- registered facts remain authoritative; Lists and exports are rebuildable.
- Product UUID, visible code, exact identity, similarity and idempotency remain distinct.
- optional references preserve archived historical labels.
- BULK stores no competing price-per-unit fact.
- exports do not mutate Purchases or upload data.
- local event/pending structures remain synchronization preparation only.

## 6. Required correction units

1. correct nickname uniqueness to active-only semantics without losing archive history;
2. implement BULK price-per-unit input and explicit half-up line-total derivation;
3. expose exact code/identity lookup in Catalogue presentation;
4. introduce shared adaptive Product-details route/pane/sheet;
5. complete typed failure mapping;
6. decide save destination and native share adapter;
7. add remaining History selection conveniences.

## 7. Evidence limits

Repository truth: handwritten source at `e37cb700feeca4001cc7835b584c46bb81926af3`.

Reported evidence: 39 Flutter tests, clean analysis, Windows release build/bounded launch, migration/reopen tests and five Python regressions. Android, native share, complete manual/accessibility behavior, injected migration failure and release acceptance are not established.

## 8. Recovery pointers

- Canonical: `design/01_ARCHITECTURE.md`, section 21.
- History: `design/03_DECISION_LOG.md`, Event 19.
- Checkpoint: `design/09_DESIGN_STATE.md`, Cycle 09 segment.
- Evidence: C/F/I and post-Codex `J_MAIN_STAGE.md`.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
