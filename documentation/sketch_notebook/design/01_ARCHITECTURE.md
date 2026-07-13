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


# 17. Sprint 03 Implemented Local Flutter Foundation

Cycle 07 Sprint 03 Unit 01 materialized the accepted additive transition without replacing the Python/PySide6 beta.

Stable implemented dependency direction:

```text
Flutter composition
→ application use case
→ Dart domain
→ repository boundary
→ Drift local adapter
```

The Dart domain imports no Flutter widget, Drift, HTTP, Python, or platform-plugin API. Widgets own neither SQL nor durable transactions. The new client uses a fresh application-private database and does not access the Cycle 06 database.

The implemented local model includes account-private Product and Store facts, Purchase aggregates with Purchase Items, immutable local synchronization-event preparation, pending-event state, synchronization metadata, and a migration ledger. Drift is the implemented local persistence choice for this foundation.

`LocalPurchaseRepository.registerPurchase` owns one local transaction:

```text
resolve/create Store and exact Products
+ validate all Purchase Items
+ insert Purchase and Items
+ allocate local event metadata
+ insert immutable purchase.registered event
+ enqueue pending event
= one atomic local commit
```

Invalid Item validation rolls back the aggregate, catalogue writes, event, and pending queue entry. Network work remains outside the transaction. Local facts and pending events survive close/reopen.

Implemented representations use explicit MASS/VOLUME/COUNT dimensions, canonical KG/L/UNIT units, fixed six-decimal microunits, rejection of fractional COUNT, ISO currency code, and integer minor units. A minimal identifier/version analytics registry selects calculations without rewriting raw facts.

Versioned JSON files under `contracts/shared_beta/v1/` are accepted as semantic fixtures and contract examples. They are not database tables, user data, or a complete wire-protocol specification.

The following are not stable implemented invariants and remain outside canon:

- monotonic device-sequence continuity, because repeated registration may reset the sequence;
- exact Unicode/locale-safe normalization;
- RFC UUID version/variant semantics or cross-language Product-ID equivalence;
- complete payload typing, nullability, ranges, unknown-field and compatibility rules;
- schema-upgrade and migration-recovery behavior;
- Store deduplication and branch/location identity;
- Windows, Android, or iOS runtime/lifecycle behavior;
- authentication, TypeScript API, Postgres/Neon, upload/download synchronization, cross-device convergence, legacy import, parity, or PySide6 retirement.

Generated platform projects establish topology only. They do not establish platform validation.


# 18. Sprint 04 Accepted Local Shared-Client Boundaries

Sprint 04 confirms and extends the accepted local-first Flutter architecture without replacing the protected Python/PySide6 beta.

## 18.1 Composition and dependency ownership

The shared-client local slice uses this stable direction:

```text
Flutter presentation
→ application commands and query ports
→ Dart domain contracts
→ local repository adapters
→ Drift-managed application-private SQLite
```

The composition root owns database construction and adapter wiring. Presentation owns navigation, input staging, display state, and formatting; it does not own SQL or durable transactions. Application ports express registration and read use cases. Domain code remains independent of Flutter widgets, Drift, Python, HTTP, and platform APIs. Infrastructure implements persistence and query ports.

## 18.2 Catalogue identity

A private Product has three distinct responsibilities:

1. an immutable opaque internal record ID used by relations and events;
2. a required user-designed Product code, preserved for display and normalized for account-scoped uniqueness;
3. versioned normalized identification facts used for exact catalogue matching.

New internal Product IDs are UUID v4 values. Existing migrated Product IDs remain unchanged and are treated as opaque internal IDs. User Product code is never a primary or foreign key. A future central-catalogue UUID remains absent until that catalogue and its versioned identification set are separately accepted.

Product display name and brand remain distinct from normalized identity facts. Normalization is versioned. Exact account-scoped equivalence may reuse a Product; fuzzy similarity is advisory and never merges automatically. PACKAGED/BULK and dimensional package facts remain part of exact identity.

## 18.3 Purchase and event transaction

Purchase remains an atomic aggregate containing one or more Purchase Items. Local registration owns one transaction that:

```text
resolves account-private Store and Product references
+ validates every Item and the Purchase aggregate
+ persists Purchase and Items
+ allocates the next device sequence
+ persists one immutable purchase.registered event
+ enqueues that event as pending
= one local commit
```

Device creation is insert-if-absent and must not reset an existing sequence. Account/device/sequence uniqueness protects local ordering. Network operations remain outside the local transaction. Local event preparation and a pending queue do not constitute synchronization.

## 18.4 Local schema and contract responsibility

Drift schema v2 is the implemented local persistence structure. Its accepted responsibilities include account-private catalogue and purchase facts, local Device state, immutable prepared events, pending-event state, synchronization metadata, and a migration ledger.

The v1→v2 migration preserves internal Product IDs and Purchase references, adds Product code/display responsibilities, backfills reviewable legacy codes, and records the migration. This is evidence for one controlled upgrade, not acceptance of a general migration framework or desktop import path.

JSON Schema Draft 7 under the versioned shared-beta contract surface owns structural validation. Readable JSON examples retain scenario legibility. Cross-field invariants and normalization semantics remain owned by Dart domain and fixture tests. Structural schema success does not prove cross-language semantic parity.

## 18.5 Platform and transition boundary

Windows build and startup smoke are validated for this local slice. Android remains blocked by absent tooling; iOS remains host-unvalidated. Generated platform projects alone do not establish platform acceptance. Manual UI, accessibility, and responsive-lifecycle acceptance remain separate evidence gates.

The Flutter database remains isolated from the ordinary Cycle 06 database. PySide6 remains a recoverable accepted beta, behavior reference, migration source, and rollback until parity and human/Main acceptance authorize retirement.

## 18.6 Boundaries not promoted

The following remain provisional, blocked, or deferred rather than canonical completed architecture:

- fixed local account and device placeholders as production identity;
- authentication and authorization;
- TypeScript API and Neon/Postgres implementation;
- actual upload/download synchronization and cursor convergence;
- central Product catalogue identity;
- general schema migration, downgrade, and corruption recovery;
- Store branch/location identity and deduplication;
- Product-code editing, aliases, retirement, and reuse;
- Purchase editing/deletion;
- Android/iOS validation and public release;
- PySide6 retirement.


# 19. Sprint 05 Accepted Android and Local Device Boundaries

## 19.1 Android host boundary

Android is a platform host for the shared Flutter client:

```text
Android application host
→ Flutter entrypoint and asynchronous composition
→ presentation
→ application commands/query ports
→ platform-independent Dart domain
→ local repository adapters
→ Drift application-private SQLite
```

Kotlin and Android configuration own package hosting, launch metadata, system integration, and build inputs. They do not own Product, Purchase, Event, Device sequence, analytics, repository transactions, or synchronization semantics.

The stable Android application ID is `com.gusigu.markei`; it owns installation/update identity and application-sandbox continuity. The visible label is `Markei`. Neither is an Account, Device, Product, Purchase, Event, or signing identity.

Compile/target SDK, NDK, Java, Gradle, emulator, and Android Studio versions are Operational build configuration. Controlled pinning does not become canonical domain architecture.

## 19.2 App-private Device identity

One app-private local database owns one Device UUID v4 for the current prototype installation and the sequence ledger attached to that Device row.

Stable rules:

- Device identity is created before event-producing commands are composed;
- it is persisted and reused across ordinary close/reopen;
- separate fresh databases receive distinct identities;
- it is not derived from hardware, platform name, application ID, Account, email, or cloud identity;
- it is not presentation-owned or user-editable;
- sequence allocation remains attached to its Device row and inside the Purchase transaction;
- uninstall/data-clear may remove Device identity with the local database;
- historical Device rows and their event ownership are not destructively rewritten.

The Account remains the provisional `local-account` placeholder. Correcting Device identity does not implement authentication or multi-account ownership.

## 19.3 Schema and historical ownership

Sprint 05 required no Drift schema migration. Existing schema v2 already models Device ID, Account ownership, next sequence, creation time, and event uniqueness by Account/Device/sequence. Architecture changes require schema changes only when persisted responsibilities or invariants cannot be represented safely by the existing schema.

Historical non-UUID Device rows remain valid historical persistence facts. They are not silently converted or selected as the prototype’s new Device, because conversion could detach prior sequence/event meaning from its original identifier.

## 19.4 Prototype selection versus future invariant

The implemented repository scans the first 20 Account Devices ordered by creation time and reuses the earliest UUID v4. This is accepted only as a bounded single-installation prototype heuristic; it is not canonical multi-device selection behavior.

Before synchronization or realistic multiple-Device history, the local model must explicitly identify the current installation’s Device:

```text
one local installation identity record
→ references exactly one Device row
→ bootstrap is idempotent under concurrency
→ sequence ledger belongs to that selected Device
→ historical Devices remain independently addressable
```

The physical table/constraint design and migration are not accepted yet. They require evidence about device registration, account transition, restore/reinstall, concurrent bootstrap, and synchronization semantics.

## 19.5 Functional scaffold and evidence boundary

`SafeArea` and the staged Purchase total are bounded functional-scaffold decisions. They improve inset safety and workflow observability without accepting a final design system, navigation model, state-management framework, accessibility treatment, or visual language.

Validated Android evidence is limited to debug APK build, one API 36 emulator launch/install, application-sandbox database observation, Device bootstrap, and human-confirmed Purchase registration. Phone-width widget tests validate the tested layout/workflow only.

Keyboard, Back, rotation, background/resume, larger text, full lifecycle recovery, physical devices, accessibility, production signing/release, and final visual quality remain partial, host-unvalidated, blocked, or deferred. A supplemental Android pass may close a bounded lifecycle/ergonomics checklist. Broad UI/UX formalization remains a separate future sprint.

## 19.6 Preserved transition

Windows Flutter build and Python regression evidence remain intact. The ordinary Cycle 06 database remains isolated and PySide6 remains recoverable. Android enablement does not authorize synchronization, authentication, cloud storage, import, iOS implementation, or PySide6 retirement.
