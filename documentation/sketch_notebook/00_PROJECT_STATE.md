# 00_PROJECT_STATE.md

> Version: Cycle 07 Sprint 02 closure / Sprint 03 entry 0.5
> Status: Active Global State Canon-Checkpoint
> Persistence Class: Canon-Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `cycle-07-mobile-preparation`
> Baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Reconciliation source: `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Accepted current global state and low-cost recovery entrypoint

---

# 1. Global State

Cycle 06 is accepted and closed at the controlled Windows primary-beta boundary.

Cycle 07 Sprint 02 planning and permanent-domain reconciliation are complete. Cycle 07 now has an accepted planning basis for a Flutter/Dart shared client, TypeScript synchronization API, Neon Postgres shared persistence, reusable catalogue, append-only synchronization, and progressive migration from the protected PySide6 beta.

```text
Cycle 06 desktop beta: accepted and protected
Cycle 07 Sprint 01 portability investigation: complete
Cycle 07 Sprint 02 shared-beta architecture planning: complete
permanent Operational reconciliation: complete
permanent Didactic promotion: complete
permanent Design reconciliation: complete
Flutter/Dart planning basis: accepted
physical implementation: not started
D/E/F: not yet activated for Sprint 03
```

---

# 2. Protected Desktop Baseline

The accepted implementation remains:

```text
PySide6 Desktop
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

It includes the validated one-folder Windows runtime, per-user installer, Start Menu launch, external writable user data, structural defaults, technical workflows, close/reopen, reinstall retention, uninstall retention, and recovery evidence.

The existing Python application and ordinary Cycle 06 database remain:

- runnable and recoverable;
- behavioral reference and fixture source;
- legacy migration source;
- rollback boundary;
- excluded from direct Flutter opening or destructive conversion.

PySide6 is not retired until Flutter desktop/mobile parity and migration safety are evidenced and accepted.

---

# 3. Accepted Shared-Beta Planning Architecture

```text
Flutter presentation
→ application/use cases
→ domain contracts + versioned Dart analytics
→ repository interfaces
→ local persistence / event queue / synchronization adapters
→ authenticated TypeScript synchronization API
→ Neon Postgres
```

Stable boundaries:

- Flutter/Dart owns the future Windows/Android/iOS client.
- TypeScript is favored for the custom synchronization API.
- Neon is favored as managed shared persistence behind the API.
- Every installation remains offline-first with application-private storage.
- The API is the mandatory client/cloud boundary.
- Clients never contain privileged Postgres credentials.
- Verified email maps to an immutable internal account UUID.
- Python and Dart share behavior through contracts, fixtures, and migration evidence—not an embedded Python runtime.

---

# 4. Reusable Catalogue and Purchase Model

The first shared beta uses account-private reusable Products and Stores.

Packaged Product identity is based on:

```text
normalized name
+ normalized brand
+ PACKAGED
+ normalized package amount
+ explicit dimension/unit
```

Bulk identity uses:

```text
normalized name
+ normalized brand
+ BULK
```

Exact normalized equivalence may reuse an identity. Fuzzy similarity only warns and asks the user; it never merges automatically.

Domain relationship:

```text
Account
├── Catalogue Products
├── Stores
└── Purchases
    └── Purchase Items
        └── reference Catalogue Product
```

Purchase is an atomic aggregate containing one or more Items and one pending append-only synchronization event. The first UI may guide one Item while preserving a multi-item contract.

Product identity fields remain immutable in the reduced beta. Editing, deletion, merge/alias workflows, global catalogue, product-family relations, and household sharing remain deferred.

---

# 5. Quantity, Money, and Analytics

Quantity is dimensionally explicit:

```text
MASS   → KG
VOLUME → L
COUNT  → UNIT
```

Package amount, package count, and purchased amount are distinct. Markei never infers mass from volume.

Money uses explicit currency and integer minor units. Account currency may default the interface, while every Purchase retains historical currency evidence.

Raw Product, Store, Purchase, and Purchase Item facts remain authoritative. Storage, Shortage, Market, expected dates, price comparisons, personalized inflation/deflation, shrinkflation, store comparisons, and forecasts remain rebuildable analytics.

Dart analytics use stable algorithm identifiers and versions. A released version does not change meaning; improved formulas create a new version.

---

# 6. Synchronization Planning State

The first synchronized fact is an atomic `purchase.registered` event containing immutable Item lines and required account-private reference/bootstrap facts.

```text
event UUID
    retry identity and duplicate protection

device UUID + monotonic sequence
    one-installation creation order

occurrence timestamp
    business/purchase time

opaque account-scoped cursor
    accepted download order
```

Policies:

- identical retry returns prior acceptance;
- same UUID with different content is rejected;
- sequence gaps are rejected/requested;
- second device bootstraps from cursor zero in pages;
- upload requests return per-event transactional results;
- downloaded events and cursor advancement commit together locally;
- API authentication and authorization are mandatory;
- RLS remains an optional defense-in-depth question.

---

# 7. Didactic State

Cycle 07 Sprint 02 introduced the following concepts as Red:

```text
&&&06–&&&10
&&%05
&%%07–&%%17
%%%07
```

They cover stable identity, authentication, authorization, eventual consistency, historical integrity, immutable Dart models, reusable catalogue, normalization, purchase aggregation, synchronization, dimensional quantity, minor-unit money, versioned analytics, and Flutter.

No existing maturity changed.

---

# 8. Provisional and Open Choices

Experiment candidates—not validated dependencies:

- Drift;
- `sqflite_common_ffi`;
- `flutter_secure_storage`;
- local TypeScript API and disposable Postgres;
- fake/test identity issuer;
- later non-production Neon.

Still open:

- Flutter project/repository layout;
- state management and navigation;
- auth provider;
- TypeScript API framework/runtime/host;
- Postgres migration tooling;
- canonical schema/fixture toolchain;
- physical local/cloud schemas;
- decimal scale/ranges and fractional COUNT;
- currency metadata source;
- normalization-version migration;
- legacy ambiguity policy;
- RLS;
- paging limits and queue-corruption recovery;
- parity threshold for PySide6 retirement.

---

# 9. Next Milestone

Cycle 07 Sprint 03 should begin the first bounded transition from the current repository into Flutter/Dart and the new logical data model.

It must proceed additively:

```text
preserve Python/PySide6
→ approve Sprint 03 D/E/F
→ establish isolated Flutter/Dart structure
→ define canonical fixtures
→ materialize fresh Flutter-local schema
→ prove catalogue + Purchase aggregate locally
→ preserve Cycle 06 database
→ only then introduce local API/Postgres sync harness
```

The authoritative forward boundary is `06_SESSION_SCHEME.md`.

---

# 10. Recovery Route

```text
1. Read this file.
2. Read 06_SESSION_SCHEME.md for Sprint 03.
3. Read the relevant domain checkpoint.
4. Read J sections 17–18 for reconciliation rationale.
5. Read permanent canon for exact definitions.
6. Read A/B/C only for detailed planning evidence.
7. Inspect source when implementation truth is directly required.
```

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
