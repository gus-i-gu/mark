# 14_MODEL_OVERVIEW.md

> Version: 0.4-cycle07-sprint02
> Status: Active Derived Overview
> Persistence Class: Derived
> Knowledge Class: Design
> Authority: Design Chat [D]
> Canonical Source: `design/01_ARCHITECTURE.md`
> Scope: Compact map of accepted desktop recovery and Flutter shared-beta planning boundaries

---

# 1. System Map

```text
Flutter presentation
→ application / use cases
→ domain / contracts / versioned analytics
→ repository interfaces
→ local persistence / event queue / synchronization adapters
→ authenticated TypeScript synchronization API
→ Neon Postgres
```

```text
Python/PySide6 Cycle 06 beta
    preserved as behavioral reference, migration source, and rollback
    until Flutter parity receives human/Main acceptance
```

# 2. Responsibility Map

| Boundary | Responsibility |
| --- | --- |
| Flutter presentation | Responsive Windows/mobile UI, navigation, input, accessibility, formatting |
| Application/use cases | Catalogue resolution, Register Purchase, projection reads, auth and sync requests |
| Domain/contracts | Identity, aggregate, quantity, money, event and invariant meaning |
| Dart analytics registry | Stable algorithm identifiers/versions and deterministic calculations |
| Repository interfaces | Application-facing persistence contracts |
| Local persistence | Application-private authoritative facts, applied events, projections and cursor |
| Event queue | Pending/in-flight/accepted/rejected upload state and safe retry |
| Sync coordinator | Upload, cursor download, transactional application and status |
| Auth session | Account/device session and platform-secure credential boundary |
| TypeScript API | Token verification, authorization, validation, idempotency, sequence, cursor and transactions |
| Neon | Managed Postgres persistence, constraints, roles, migrations and recovery facilities |

# 3. Domain Relationship Map

```text
Account
├── Products
├── Stores
├── Devices
└── Purchases
    └── Purchase Items
        └── reference Product
```

**Account** is the immutable ownership boundary. Verified email is replaceable login identity.

**Product** is an account-private reusable catalogue identity. PACKAGED identity includes normalized name, brand, package mode, amount and explicit dimension/unit. BULK identity omits package amount.

**Store** is an account-private reusable purchase reference.

**Purchase** is an atomic occurrence at one Store with timestamp and currency.

**Purchase Item** is an immutable commercial observation referencing one Product. The first UI may capture one Item; the aggregate supports several.

# 4. Event and Ordering Map

```text
purchase.registered envelope
    event UUID
    protocol + payload versions
    account UUID
    device UUID + monotonic device sequence
    occurrence timestamp
    Purchase aggregate + Item lines
```

```text
event UUID
    idempotent retry identity

device sequence
    per-installation creation order and gap detection

occurrence timestamp
    business time, not sync order

account cursor
    opaque server-accepted download position
```

Each event is accepted transactionally. Upload batches return per-event outcomes. Downloaded events and local cursor advancement commit together. A new device bootstraps from cursor zero in bounded pages.

# 5. Authoritative Facts and Projections

Authoritative:

- account/device ownership;
- Product and Store identities;
- Purchase and Purchase Item observations;
- dimensional quantity;
- explicit currency and minor-unit line totals;
- immutable accepted events and server ordering;
- explicit future correction facts when introduced.

Derived and rebuildable:

- package and normalized prices;
- purchase interval and expected next purchase;
- stock estimate;
- Storage/Shortage/Market status;
- price change;
- personal inflation/deflation;
- shrinkflation and product-family analytics;
- store comparison and forecasts;
- presentation labels/grouping.

Derived results use stable Dart algorithm identifiers and versions where reproducibility matters.

# 6. Local-First Transaction Map

```text
Register Purchase locally
→ validate aggregate
→ resolve/create catalogue references
→ commit Purchase + Items
→ append pending event
→ update/rebuild projection
→ commit once
→ synchronize later
```

```text
Apply remote page
→ insert unseen events
→ apply account-owned facts
→ rebuild affected projections
→ advance account cursor
→ commit once
```

Network work never stays inside the local database transaction.

# 7. Cloud Boundary

```text
Flutter client
    access token only
        ↓
TypeScript API
    authentication + authorization + protocol
        ↓
Neon Postgres
    no privileged client access
```

RLS may provide defense in depth; API authorization remains mandatory.

# 8. Transition and Evidence

```text
preserve PySide6 + original data
→ define contracts and fixtures
→ fresh isolated Flutter data
→ prove reduced Register/projection parity
→ prove sync on simulated devices
→ validate Windows + Android
→ validate iOS separately
→ deterministic protected-copy migration
→ human/Main acceptance
→ only then consider PySide6 retirement
```

# 9. Provisional or Open

Provisional: normalization v1, deterministic Product UUID, purchase snapshot minimum, cursor implementation, sequence recovery, decimal representation, fractional COUNT, RLS and legacy ambiguity policy.

Open: Flutter persistence/secure-storage/state/navigation choices, auth provider, TypeScript API framework/host, migration tool, physical local/cloud schemas, repository topology and parity threshold.

No candidate dependency or physical schema is validated or accepted by this derived overview.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
