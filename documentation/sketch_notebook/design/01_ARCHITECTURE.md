# 01_ARCHITECTURE.md

> Version: 0.4-cycle07-sprint02
> Status: Reconciled Canon
> Persistence Class: Canonical
> Knowledge Class: Design
> Authority: Design Chat [D], reconciled through Main Chat [M]
> Scope: Stable application, deployment, resource, identity, diagnostics, and lifecycle responsibility boundaries
> Reconciliation Sources: `DEV_STAGE/F_DSN_STAGE.md`, `DEV_STAGE/I_DSN_CODEX.md`, `DEV_STAGE/G_OPS_CODEX.md`, `[M]_STAGE/J_[M]_STAGE.md`

---

# 1. System Form

Markei is a local Python, PySide6, and SQLite desktop monolith. Packaging and installation surround the application as deployment concerns; they do not become business or persistence layers.

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
Database Manager
    ↓
SQLite
```

Canonical dependency rules remain:

1. Desktop presentation requests behavior from ProductService and does not execute SQL.
2. ProductService owns workflows, validation, calculations, settings interpretation, and application-facing projections.
3. Repository owns SQL, row mapping, persistence operations, and one SQLite connection/cursor per instance.
4. Database Manager owns resource and user-data paths, initialization, SQLite configuration, additive compatibility migration, reset, and connection primitives.
5. Domain models carry application data and do not execute persistence or orchestrate workflows.

The current concrete construction remains page-local. This is accepted implementation structure, not a mandate for dependency injection, a new composition root, or shared service/repository lifetime.

---

# 2. Desktop Composition and Shutdown

`app.main.main()` owns Qt application construction. `MainWindow` owns the current desktop shell, including page construction, tab composition, navigation, edit routing, refresh coordination, and final coordination of page-owned service closure.

```text
RegisterPage → ProductService → Repository → SQLite connection
ListsPage    → ProductService → Repository → SQLite connection
HistoryPage  → ProductService → Repository → SQLite connection
SettingsPage → ProductService → Repository → SQLite connection
```

Each service and repository retains its local close responsibility. `MainWindow.closeEvent()` remains the accepted idempotent final coordinator for all four page-owned services.

Sprint 02 installed close and immediate reopen evidence reached this same shutdown path successfully. No installed lifecycle gate required a broader lifetime or composition redesign.

---

# 3. Application and Persistence Boundaries

`ProductService` remains the broad application facade for receipt registration, product lifecycle, calculated state, inventory projections, history projections, settings, stores, and UI-consumable read models.

`Repository` remains the broad SQLite persistence facade for products, purchases, categories, stores, settings, SQL execution, row mapping, commits, and closure.

Repository mutation methods still commit individually. Receipt registration and purchase deletion/recalculation remain multi-commit workflows rather than one atomic business transaction. Workflow atomicity remains inherited Design debt.

The current additive compatibility behavior is not a numbered or general migration framework.

---

# 4. Deployment Boundaries

Cycle 06 now has technical evidence across these distinct states:

```text
Source tree
    main.py + app/ + schema resource

Frozen runtime
    one-folder PyInstaller distribution

Installer source
    Inno Setup definition consuming the frozen distribution

Compiled installer
    Markei-Setup-0.1.0-x64.exe

Installed program files
    per-user executable and runtime content

Writable user state
    retained database, transient SQLite companions, and diagnostics
```

A configured installer, compiled installer, installed application, validated installed lifecycle, and accepted beta remain different evidence states.

## 4.1 Launcher and application construction

```text
root main.py
    launcher adapter
    owns the outer startup-diagnostic boundary

app.main.main()
    owns Qt application construction and execution
```

Unhandled launcher-level startup exceptions are written to a per-user diagnostic log and surfaced visibly where Qt permits.

## 4.2 Packaging authority

```text
Markei.spec
    authoritative one-folder PyInstaller composition

scripts/build_windows.ps1
    operational invocation wrapper
```

The packaging layer owns collection of executable code, Python/Qt runtime components, approved read-only resources, and executable metadata. It does not own workflows, SQL semantics, migration meaning, or user-created data.

## 4.3 Installer authority

```text
installer/Markei.iss
    placement, identity, shortcuts, and uninstall registration

scripts/build_installer.ps1
    compiler discovery and installer-build invocation
```

Sprint 02 added per-user Inno Setup discovery to the wrapper. That correction is tooling behavior, not a new architectural boundary.

The installer consumes the frozen distribution. It does not redefine package composition or persistence semantics.

---

# 5. Resource, Defaults, and Writable-State Classification

| Item | Accepted classification |
| --- | --- |
| `app/database/schema.sql` | Bundled read-only, replaceable application resource |
| `app/database/seed.sql` | Development/test fixture; excluded from production |
| category `F` / `General` | Structural application default required by current Register behavior |
| store `1` / `Default Store` | Structural application default required by current Register behavior |
| `%LOCALAPPDATA%/Markei/market.sqlite` | Retained writable user data |
| `market.sqlite-wal`, `market.sqlite-shm` | Transient writable companions; never bundled |
| `%LOCALAPPDATA%/Markei/logs/startup.log` | Generated writable startup diagnostics |
| settings stored in SQLite | Retained user data |
| executable metadata and static assets | Replaceable application content |

Fresh production initialization remains schema-only with idempotent structural defaults. It contains no sample products or purchases.

The structural category and store are not demonstration data. They are required referential defaults for current Register behavior when the sample-bearing seed is absent.

---

# 6. Installed Program and User-State Boundary

Installed program files are replaceable deployment content under the per-user program directory. Writable user state remains under `%LOCALAPPDATA%/Markei`.

Sprint 02 technically validated:

```text
per-user installation
→ installed executable present
→ Start Menu shortcut launch
→ external database creation
→ installed workflow persistence
→ close and immediate reopen
→ same-version reinstall with retained data
→ uninstall with retained database
→ reinstall with retained-data recovery
```

The observed installation, shortcut, uninstall registration, user-state separation, and retained-data behavior match the accepted boundary.

The validation used the current ordinary Windows user with existing Markei data backed up and restored. It did not use a dedicated clean account.

---

# 7. Retention and Upgrade Boundary

Accepted primary-beta behavior:

```text
uninstall
    removes replaceable application files and shortcuts
    preserves %LOCALAPPDATA%/Markei by default

same-version reinstall
    retains stable installer identity
    replaces program files
    preserves compatible user data
    reopens the existing database

compatible beta upgrade
    retains stable installer identity
    replaces program files
    preserves user state
    applies current additive compatibility behavior
```

Same-version reinstall, uninstall preservation, and reinstall recovery are now technically validated in the reported environment.

A later compatible-version upgrade remains a separate transition unless directly exercised. Downgrade handling, rollback, incompatible-schema recovery, and a migration ledger remain outside Cycle 06.

---

# 8. Release Identity and Shortcut Contract

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Installer AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Target: Windows x64 controlled beta
```

The AppId remains stable across compatible upgrades. Executable metadata, installer metadata, shortcut names, and artifact names form one coordinated release contract.

```text
Start Menu shortcut: required and technically validated
Desktop shortcut: optional installer task; not required for beta acceptance
```

The current Inno `x64` deprecation warning is non-blocking tooling debt, not an architecture failure.

---

# 9. Evidence Boundary

Current accepted technical classification:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Technically validated boundaries include installer compilation, per-user placement, Start Menu launch, installed data path, service-backed principal workflow persistence, installed close/reopen, same-version reinstall, uninstall retention, and reinstall recovery.

Still outside technical acceptance:

- complete human-visible installer wizard observation;
- complete human-visible Register / Lists / History / Settings walkthrough;
- human-visible close/reopen confirmation;
- human-visible SmartScreen behavior;
- final Main/human beta acceptance.

Defender enabled and unsigned binaries were observed. Human-visible SmartScreen behavior remains unknown.

---

# 10. Accepted Current Boundaries

1. Markei remains a layered local desktop monolith.
2. Packaging and installation remain deployment concerns around the business architecture.
3. Root `main.py` owns launcher-level startup diagnostics.
4. `Markei.spec` remains the authoritative package definition.
5. Installer source owns placement, identity, shortcuts, and uninstall registration.
6. Production includes `schema.sql`, excludes `seed.sql`, and creates only structural defaults.
7. Installed program files and retained user state remain separate.
8. Per-user installation, Start Menu launch, installed close/reopen, same-version reinstall, uninstall preservation, and reinstall recovery are technically validated.
9. MainWindow final service-close coordination remains sufficient for the tested installed lifecycle.
10. Technical installed workflow evidence does not equal human visual UI acceptance.
11. Final beta acceptance and Cycle closure remain Main/human decisions.

---

# 11. Explicitly Unresolved or Deferred

The following remain outside this Design absorption:

- composition-root or dependency-injection redesign;
- shared-service or repository-lifetime redesign;
- ProductService or Repository decomposition;
- workflow transaction redesign;
- schema redesign or migration ledger;
- compatible-version upgrade evidence not yet directly exercised;
- typed view-model conversion or broad UI redesign;
- mobile, backend/API, synchronization, authentication, or cloud persistence;
- automatic update, signing, rollback, or one-file packaging;
- optional uninstall data-deletion UX;
- incompatible-version and downgrade strategy;
- unrelated Promotion or `pages.order` decisions.

Derived and checkpoint files must not introduce claims absent from this canon.

---

# 16. Accepted Cycle 07 Shared-Beta Planning Architecture

This section defines accepted stable planning boundaries for the future shared client. It does not replace the accepted Cycle 06 desktop architecture until parity and human/Main acceptance.

## 16.1 Client and dependency direction

Flutter/Dart is the accepted planning basis for one future Windows, Android, and iOS client.

```text
Flutter presentation
→ application/use cases
→ domain/contracts/versioned analytics
→ repository interfaces
→ local persistence/event queue/synchronization adapters
```

Dependencies point inward toward application and domain meaning. Presentation owns responsive rendering, navigation, input, accessibility, and formatting. Use cases coordinate workflows. Domain owns identity, aggregate, quantity, money, event, and analytical contracts. Infrastructure implements repository and synchronization boundaries.

Python is not embedded in the Flutter client. Python-to-Dart continuity uses language-neutral contracts, deterministic fixtures, expected behavior, and migration evidence.

## 16.2 Local-first persistence

Every client installation owns application-private local persistence and remains usable for the reduced workflow while offline.

A local Purchase registration atomically commits the Purchase aggregate, its Purchase Items, required local catalogue references, one pending synchronization event, and affected projections. Network operations occur after local commit.

Downloaded events and local cursor advancement commit together. Projections remain rebuildable from authoritative facts and versioned rules.

## 16.3 Catalogue and purchase model

The first shared beta owns an account-private reusable catalogue.

```text
Account
├── Products
├── Stores
└── Purchases
    └── one or more Purchase Items
        └── reference Product
```

Product identity distinguishes PACKAGED and BULK modes. Packaged identity uses normalized name, brand, package amount, and explicit dimension/unit. Bulk identity uses normalized name, brand, and BULK mode. Exact normalized equivalence may reuse; fuzzy similarity is advisory and never merges automatically.

Product identity fields remain immutable in the first beta. A changed identifying name, brand, mode, or package specification creates a distinct Product identity. Future successor/product-family relationships may connect identities without rewriting history.

Purchase is an atomic aggregate containing one or more Purchase Items. The first UI may guide one item, but the contract remains multi-item capable. Purchase Items preserve immutable commercial observations.

Quantity is dimensionally explicit across MASS/KG, VOLUME/L, and COUNT/UNIT. Mass and volume are never inferred from one another. Currency is explicit and monetary facts use integer minor units. Raw catalogue, purchase, and item observations are authoritative; prices, status, intervals, inflation/deflation, shrinkflation, forecasts, and presentation models are derived.

## 16.4 Versioned analytics

The Flutter client owns versioned Dart analytical behavior. Each reproducible algorithm has a stable identifier and version. Once used, a version does not change meaning; improved behavior receives a new version. Raw purchase facts are not rewritten when analytics evolve, and cached projections remain rebuildable.

## 16.5 Synchronization and cloud boundary

```text
Flutter client
→ authenticated custom synchronization API
→ Neon Postgres
```

Clients do not hold privileged Neon credentials and do not bypass the API.

The custom API owns authentication-token verification, immutable account resolution, account/device authorization, runtime event validation, idempotent append, device-sequence policy, account-scoped cursor allocation and download, protocol versions, server transactions, stable errors, and diagnostics.

TypeScript is favored for the API boundary. Neon is favored as managed Postgres persistence behind that API. These preferences do not accept an exact framework, host, migration tool, or physical schema.

The first synchronization slice is append-only. Event UUID identifies retries; device UUID plus monotonic sequence describes one installation's creation order; occurrence timestamp records business time; opaque account-scoped cursor describes accepted download order. Purchase events are atomic, batch uploads return per-event transactional results, and new devices bootstrap from cursor zero.

Verified email is a login requirement. Immutable internal account UUID—not email—owns data.

## 16.6 Protected transition

The accepted Python/PySide6 beta and original Cycle 06 database remain recoverable throughout the transition.

```text
preserve accepted desktop beta
→ define cross-language contracts and fixtures
→ build against fresh isolated Flutter data
→ evidence reduced workflow and projection parity
→ evidence synchronization and platform lifecycle
→ migrate only from a protected copy with deterministic mapping
→ retain rollback
→ retire/demote PySide6 only after human/Main acceptance
```

Direct destructive conversion or shared opening of the ordinary Cycle 06 database is outside the accepted transition boundary.

## 16.7 Explicit exclusions from canon

The following remain provisional, open, or empirical and are not canonical implementation choices:

- deterministic Product UUID derivation;
- exact normalization-v1 rules;
- exact cursor implementation;
- decimal scale, range, and serialization;
- fractional COUNT policy;
- RLS adoption;
- legacy ambiguity handling;
- Flutter persistence and secure-storage plugins;
- state management and navigation;
- authentication provider;
- TypeScript framework/runtime/host;
- physical SQLite/Postgres tables and migrations;
- repository directory topology;
- paging limits and parity threshold.

Editing/deletion, catalogue merges/aliases, global catalogue, household sharing, complex conflicts, realtime/background synchronization, public/app-store release, and PySide6 retirement remain deferred.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
