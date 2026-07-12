# 1. Main Synthesis Summary

Cycle 07 Sprint 02 should restage Markei around a Flutter/Dart shared client for Windows, Android, and iOS; a favored TypeScript synchronization API; and favored Neon Postgres event persistence. Python/PySide6 remains the accepted Cycle 06 application, behavioral reference, migration source, and rollback until the Flutter client proves parity.

The shared client owns presentation, use cases, domain rules, application-private persistence, a pending-event queue, synchronization coordination, authenticated session state, versioned analytics, and platform composition. Python and Dart share behavior through language-neutral contracts, deterministic fixtures, and migration evidence—not an embedded Python runtime or IPC bridge.

The first synchronized fact is one atomic `purchase.registered` event containing a Purchase aggregate and one or more Purchase Items. The first UI may guide a single item, but the contract must never encode one purchase equals one product. Products are account-private catalogue identities. Packaged identity includes normalized name, brand, mode, package amount, and explicit unit/dimension; bulk identity includes normalized name, brand, and BULK mode.

All conclusions remain planning architecture. No Flutter code, schema, API, infrastructure, or D/E/F authorization follows from this report.

# 2. Accepted and Superseded Decisions

## Accepted planning direction

- Flutter/Dart owns the future shared Windows/Android/iOS client.
- TypeScript is favored for the custom synchronization API.
- Neon Postgres is favored for shared append-only event persistence.
- PySide6 and its database remain protected until parity acceptance.
- Client behavior crosses Python/Dart through contracts and fixtures.
- Products are account-private.
- Purchases are atomic aggregates containing Purchase Items.
- Currency is explicit and money uses integer minor units.
- Quantity is dimensionally explicit: MASS/KG, VOLUME/L, COUNT/UNIT.
- Analytics use stable algorithm identifiers and versions.
- First-beta synchronization is append-only.

## Superseded direction

TypeScript no longer leads shared-client exploration. It remains favored at the API boundary. A permanent dual-client strategy is also superseded: Flutter should progressively become the common desktop/mobile client, but only after evidence. Earlier “no backend” planning is superseded by the explicit synchronized-beta requirement.

Not superseded: the accepted desktop architecture, ordinary user-data protection, offline-first operation, fixture-first semantic continuity, and implementation postponement.

# 3. Flutter Client Architecture

The Flutter client should have explicit inward dependency direction:

```text
Flutter presentation
→ application/use cases
→ domain contracts and algorithms
→ repository interfaces
→ local persistence / event queue / sync adapters
```

**Presentation** owns responsive Windows/mobile widgets, navigation, input, accessibility, formatting, and platform interaction. It receives view data and stable error/status codes, not SQL rows or raw API responses.

**Application/use cases** coordinate Register Purchase, catalogue lookup/create, local projection reads, authentication, and synchronization requests. Register Purchase owns the aggregate transaction boundary.

**Domain** owns Product identity normalization, Purchase/Purchase Item invariants, dimensional quantity, money, event construction, and analytics selection. Domain objects should be typed and immutable where representing accepted facts.

**Local persistence** maps domain facts, events, projections, and synchronization metadata to an application-private database. **Event queue** tracks pending, in-flight, accepted, and rejected upload outcomes without treating timeout as rejection.

**Synchronization coordinator** uploads pending events, downloads after the account cursor, applies accepted events transactionally, and exposes status. It does not calculate business meaning independently.

**Authentication session** owns access-token use, refresh/re-authentication boundaries, account UUID, device registration, logout, and platform-secure credential storage adapters.

**Analytics registry** maps stable algorithm ID/version pairs to pure Dart calculations and fixtures.

**Composition root** creates platform-specific database paths, secure storage, HTTP transport, repositories, coordinator, registry, and use cases. It owns startup and lifecycle wiring while preventing Flutter widgets from constructing persistence directly.

# 4. Reusable Catalogue

A Product is a relatively stable account-private identity, not a current purchase record.

Candidate normalization must be deterministic and versioned. Recommended identity string:

```text
v1|account=<account_uuid>
|name=<normalized_name>
|brand=<normalized_brand_or_empty>
|mode=PACKAGED
|kind=<MASS|VOLUME|COUNT>
|amount=<canonical_fixed_precision>
|unit=<KG|L|UNIT>
```

For bulk:

```text
v1|account=<account_uuid>
|name=<normalized_name>
|brand=<normalized_brand_or_empty>
|mode=BULK
```

Normalization v1 should Unicode-normalize, trim outer whitespace, collapse internal whitespace, apply a locale-independent case rule, and preserve semantic characters rather than deleting punctuation broadly. Package input converts only within its dimension to KG, L, or UNIT and serializes a canonical fixed-precision decimal. It never converts mass to volume.

A deterministic account-scoped Product UUID is feasible using a namespaced UUID derived from the versioned normalized identity string. It allows offline devices to derive equal IDs for mechanically equivalent identities such as 350 g and 0.350 kg. It remains provisional because correction of normalization defects or identity fields creates a new identity. The normalization version must therefore be explicit, collision fixtures must exist, and migration must preserve old mappings.

Exact normalized match may reuse a Product automatically. Fuzzy matching is advisory only: it warns and asks the user. It never changes identity or merges products.

Identity fields are immutable in the first beta. Changed name, brand, packaged amount, mode, dimension, or unit creates a new Product. A future successor or product-family relationship may connect variants for shrinkflation and longitudinal analytics without rewriting history; aliases, merges, spelling correction, and global catalogue deduplication are deferred.

# 5. Purchase Aggregate

The aggregate is:

```text
Purchase
    purchase_uuid
    account_uuid
    store reference
    occurrence timestamp
    currency code
    one or more Purchase Items

Purchase Item
    item_uuid
    product_uuid
    package count
    purchased amount/dimension/unit
    line total minor units
    promotion observation
    optional expiration/notes
```

Store is an account-private reusable reference with stable UUID and minimum name; address/location remain optional and outside identity unless later accepted.

The first UI may collect one item, but the command/result and event payload contain an item list. Registering commits Product/Store bootstrap facts when absent, Purchase, all Items, projection changes, and the pending event atomically. An invalid item rejects the entire aggregate locally.

The recommended `purchase.registered` payload includes protocol and payload versions; event/account/device/purchase UUIDs; device sequence; occurrence timestamp; currency; Store identity plus minimum bootstrap name; Product identity records required by the Items; and immutable item lines. This purchase-level event preserves receipt atomicity and lets a new device apply it independently.

Minimum historical snapshot facts are the immutable referenced Product identity, Store identity/name needed for display, occurrence time, dimensional purchased amount, package count, line total/currency, and promotion observation. Broad duplicated Product snapshots are unnecessary while identity records are immutable. Future catalogue corrections must not rewrite prior Items.

# 6. Quantity and Money

Quantity must carry dimension, canonical unit, and fixed-precision amount:

- MASS uses KG;
- VOLUME uses L;
- COUNT uses UNIT.

Package amount describes one packaged unit. Package count describes how many packages were bought. Purchased amount is their measured total. For a 0.350 KG package bought twice, package amount is 0.350 KG, package count is 2, and purchased amount is 0.700 KG. Bulk mode has no packaged amount; the Item records purchased amount directly.

No mass/volume inference is permitted. COUNT values may be displayed without fractional noise, but storage rules must define whether fractional UNIT is rejected. Exact decimal scale/range is an open technical choice; floating-point storage is inappropriate for authoritative equality or identity.

The account supplies a default currency for input convenience. Every Purchase persists an ISO-style currency code. Every Item persists authoritative line total in integer minor units. Receipt-level total may be stored if independently observed, but it does not silently overwrite line totals.

Package price, normalized KG/L/UNIT price, unit price, price deltas, and inflation/deflation indicators are derived. Currency minor-unit metadata must be respected; not every currency has two decimal places. Cross-currency analytics and conversion are deferred.

# 7. Versioned Analytics

Flutter owns a Dart analytics registry. Each algorithm has a stable identifier, semantic version, declared inputs, output contract, and deterministic fixtures. Candidate identifiers include `purchase_interval`, `package_price`, `normalized_measure_price`, and `price_change`.

Raw Product/Purchase/Item facts remain authoritative. Cached projections record algorithm ID/version when reproducibility matters and are rebuildable. A released algorithm version never changes meaning; improved formulas receive a new version.

Python fixtures should capture accepted Cycle 06 behavior where it remains intended. Dart must reproduce those expected results, while new dimensional-money fixtures define behavior Python never modeled precisely. Future personalized inflation, deflation, shrinkflation, store comparison, and product-family analytics remain derived; the first beta proves registry/version mechanics with only the calculations required by its projection.

# 8. Local Persistence

Logical local responsibilities are separate even if one physical SQLite database later implements them:

- account/device/session metadata excluding raw privileged secrets;
- Catalogue Products and Stores;
- Purchases and Purchase Items;
- immutable local/applied synchronization events;
- pending upload queue and stable rejection state;
- last transactionally applied account cursor;
- rebuildable projections and algorithm versions;
- migration/import ledger.

One local Register transaction commits aggregate facts, event, queue state, and affected projection together. Network work occurs after commit and never inside the database transaction.

Downloaded events are inserted if unseen, references and aggregate facts are applied, projections rebuild, and cursor advances in one local transaction. Failure leaves the old cursor so replay is safe. Bootstrap initializes an empty store and downloads from cursor zero in bounded pages.

Physical table names, SQLite package/plugin, migration framework, indexes, encryption choice, and schema layout remain open until tooling evidence and logical-contract fixtures exist.

# 9. Synchronization Event Contract

Identifiers include account, device, Product, Store, Purchase, Item, and event UUIDs. The envelope carries protocol version, event type, payload version, event UUID, device UUID, monotonic device sequence, occurrence time, and immutable payload.

The server cursor should be account-scoped and opaque. This bounds downloads and ownership checks to one account and avoids leaking global activity. The API may implement it as an account-local monotonic value, but clients depend only on ordering and continuation semantics.

Sequence gaps should be rejected with a stable “missing prior sequence” result. This prevents silent loss and asks the device to retry earlier pending events. Identical event UUID and content returns the prior acceptance; the same UUID with different canonical content returns an immutable-content conflict.

Upload batches return per-event results. Each event receives its own server transaction: validate/authenticate/authorize, check idempotency and sequence, ensure account-owned references, append the immutable event and aggregate facts, allocate cursor, and commit. One rejected event need not roll back unrelated valid events, but later same-device sequences cannot leap over its gap.

Stable errors should distinguish authentication required, forbidden account/device, device revoked, unsupported protocol/payload, invalid payload, sequence gap, identity conflict, event-content conflict, retryable server failure, and page/cursor invalidity.

# 10. TypeScript API

The TypeScript API is favored because it offers mature runtime schema validation, Postgres/Neon tooling, authentication middleware, JSON protocol support, migration ecosystems, and test harnesses. Dart and TypeScript remain separated by serialized language-neutral contracts and shared fixtures.

The API owns token verification, immutable account UUID resolution, device authorization, runtime payload validation, event canonicalization/hash comparison, idempotent append, sequence enforcement, account cursor allocation, cursor-based download, protocol negotiation, transactions, stable errors, rate/size limits, and privacy-safe observability.

Clients never carry privileged Neon credentials. Exact runtime, framework, host, validation library, migration tool, and auth provider remain open. Familiarity is insufficient; selection requires deployment, migration, transaction, Neon, token-validation, logging, and contract-test evidence.

# 11. Neon Responsibilities

Neon logically stores account identity references, device registrations/revocation, account-private Products and Stores, Purchases and Items or their accepted-event materialization, immutable events, account cursors, idempotency/content hashes, and protocol/schema metadata.

Every user-data row is owned by immutable `account_uuid`; email is replaceable login metadata, never the ownership key. Constraints enforce account-scoped references, event uniqueness, device-sequence uniqueness, and immutable accepted content.

API transactions own synchronization semantics. Neon supplies Postgres persistence, constraints, migrations, roles, backups/recovery, and observability support. Row-level security is a provisional defense-in-depth candidate, not a replacement for API authorization.

Logical cloud schema may separate immutable event log from query/materialized aggregate tables, but physical tables are not justified until the event payload, invariants, cursor allocation, migration tool, and transaction tests are accepted.

# 12. Migration From PySide6

Migration is additive and reversible:

1. preserve the accepted PySide6 program and untouched original database;
2. work from a protected copy;
3. define deterministic UUID mapping for legacy Product, Store, Purchase, and generated Item identities;
4. normalize legacy units/money only through explicit migration rules and exception reporting;
5. import through append-only events or a separately authorized controlled-fact import;
6. record source identity, mapping version, and import idempotency keys;
7. compare entity counts, totals, dates, history, and projection fixtures;
8. test retry and rollback;
9. run Flutter Windows/Android parity, then iOS separately;
10. retire or demote PySide6 only after human/Main acceptance.

Legacy rows with ambiguous package amount, currency, quantity dimension, or promotion meaning must be reported rather than guessed. The migration may preserve a legacy/unknown representation pending user correction, but the exact policy is open. Direct destructive conversion and shared opening of the ordinary Cycle 06 database are prohibited.

# 13. Decision-State Matrix

| Item | State |
| --- | --- |
| Flutter/Dart shared client | Accepted planning direction |
| TypeScript synchronization API | Favored planning direction |
| Neon Postgres | Favored planning direction |
| PySide6 protection until parity | Accepted planning direction |
| Account-private catalogue | Accepted planning direction |
| Product normalized identity fields | Provisional structural definition |
| Deterministic Product UUID | Provisional; fixture evidence required |
| Purchase + Item atomic aggregate | Provisional structural definition |
| One-item UI / multi-item contract | Accepted planning direction |
| Dimensional quantity and minor-unit money | Provisional structural definition |
| Versioned Dart analytics registry | Accepted planning direction |
| Account-scoped cursor | Recommended provisional definition |
| Sequence-gap rejection | Recommended provisional definition |
| Per-event upload transaction/results | Recommended provisional definition |
| Exact local/cloud physical schema | Open technical choice |
| Flutter database, storage and auth plugins | Open technical choice |
| TypeScript runtime/host/auth/migration tools | Open technical choice |
| Editing, deletion, families, sharing, real-time/background sync | Deferred features |
| Cross-platform lifecycle/plugin viability | Empirical question |
| Migration treatment of ambiguous legacy facts | Empirical/policy question |

# 14. Unresolved Empirical Questions

Evidence must determine: deterministic normalization equivalence across Dart/TypeScript/Python; Unicode/case behavior; UUID derivation collision and version migration; decimal scale/range; fractional COUNT policy; currency minor-unit metadata; event canonicalization/hash parity; Flutter SQLite migrations and transaction behavior; secure token storage; Windows/Android/iOS lifecycle and packaging; cursor throughput/bootstrap paging; sequence recovery after local queue corruption; Neon transaction/cursor contention; RLS compatibility; API deployment and cold-start behavior; and legacy import ambiguity rates.

Parity evidence must cover deterministic Register fixtures, projections, close/reopen, offline queue recovery, unknown-result retry, two-device bootstrap, cross-account denial, migration counts/totals, rollback, and unchanged Cycle 06 data.

# 15. Permanent-Documentation Update Plan

After Main reconciles A/B/C, Design may propose:

- `design/03_DECISION_LOG.md`: observational Flutter supersession, alternatives, rationale, and deferrals;
- `design/09_DESIGN_STATE.md`: checkpoint for Flutter/Dart basis, TypeScript API, Neon, and unresolved evidence;
- `design/14_MODEL_OVERVIEW.md`: derived compact client/API/event ownership map;
- `design/01_ARCHITECTURE.md`: only accepted stable planning boundaries that Main/human explicitly promotes.

No permanent file should copy this stage wholesale. Physical schema, framework plugins, repository layout, and implementation structures remain outside canon until accepted.

# 16. Handoff to Main

Main should reconcile the Operational feasibility gates and Didactic promotion recommendations against this architecture. The next decisions should accept or revise normalization v1, deterministic UUID namespace/versioning, Purchase payload, snapshot minimum, account cursor, sequence policy, per-event transaction, TypeScript API boundary, and logical schema responsibilities.

Before any physical schema or D/E/F materialization, require cross-language canonicalization fixtures, aggregate/event invariants, money/quantity fixtures, migration exception rules, local/cloud transaction tests, account-isolation tests, and explicit PySide6 parity/rollback criteria.