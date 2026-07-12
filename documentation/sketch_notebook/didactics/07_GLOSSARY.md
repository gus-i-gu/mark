# 07_GLOSSARY.md

> Domain: Didactic
> Status: Persistent derivative — Cycle 06 Sprint 02
> Authority source: `didactics/02_KANBAN.md`
> Purpose: Compact retrieval without independent truth

---

# Release-Evidence Spine

```text
installer configuration
→ compiled installer
→ per-user installation
→ Start Menu launch
→ technical workflow evidence
→ close/reopen
→ same-version reinstall
→ uninstall retention
→ reinstall recovery
→ human-visible acceptance — pending
```

Current evidence:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
SmartScreen visible behavior: unknown
```

## Evidence State
**KANBAN ID:** `&&&05`  
The strongest truthful claim supported by observed evidence. Sprint 02 reached compiled installer, installed execution, technical workflows, retention, and recovery.

## Validation Boundary
**KANBAN ID:** `&&&05`  
The environment, lifecycle stage, conditions, and behavior covered by evidence. Automated service-backed workflow evidence is not a complete human UI walkthrough.

## Source Execution
**KANBAN ID:** `&&%04`  
Repository modules run through a development Python interpreter.

## Frozen Application
**KANBAN ID:** `&&%04`  
A generated executable distribution containing collected code, resources, and runtime dependencies.

## Installed Application
**KANBAN ID:** `&&%04`  
A frozen runtime placed and registered through an installer. Markei was launched through its Start Menu shortcut under the current ordinary Windows user.

## Packaging Artifact
**KANBAN ID:** `&%%06`  
The generated one-folder distribution produced from `Markei.spec`.

## Installer Configuration
**KANBAN ID:** `&%%06`  
Source instructions for producing setup media. `installer/Markei.iss` is configuration, not the installer executable.

## Installer Artifact
**KANBAN ID:** `&%%06`  
Compiled setup media. Sprint 02 produced `dist/installer/Markei-Setup-0.1.0-x64.exe`.

## Installed Program Files
**KANBAN ID:** `&%%06`, `%%%05`  
Replaceable application files placed under `%LOCALAPPDATA%\Programs\Markei`.

## Retained User Data
**KANBAN ID:** `%%%05`  
Mutable state under `%LOCALAPPDATA%\Markei`. The database survived uninstall and reopened after reinstall.

## Structural Default
**KANBAN ID:** `%%%01`  
A required baseline row or setting needed for valid application operation. Category `F` / `General` and store `1` / `Default Store` are structural defaults, not sample business data.

## Seed Data
**KANBAN ID:** `%%%01`  
Optional predefined rows used for development, testing, or demonstrations. Production excludes `seed.sql`.

## Build-Time Dependency
**KANBAN ID:** `%%%06`  
A dependency required to produce the frozen artifact. PyInstaller is the Markei example.

## Runtime Dependency
**KANBAN ID:** `%%%06`  
A dependency required by the executing application. Collected PySide6/Qt components are Markei examples.

## Installer-Time Dependency
**KANBAN ID:** `%%%06`  
A dependency required to compile installation tooling. Inno Setup's `ISCC.exe` is installed on the builder and is not required by installed Markei.

## Same-Version Reinstall
**KANBAN ID:** `&%%06`  
Reapplying the same installer identity/version. Sprint 02 observed retained compatible data.

## Uninstall Retention
**KANBAN ID:** `&%%06`, `%%%05`  
Removal of installed program files while preserving accepted external user state. Markei's database remained after uninstall.

## Reinstall Recovery
**KANBAN ID:** `&%%06`, `%%%05`  
Reinstalling program files and reopening previously retained compatible user data.

## Windows Reputation Observation
**KANBAN ID:** `&&&05`  
A platform-security or reputation observation distinct from application correctness. Defender was enabled and binaries were unsigned; human-visible SmartScreen behavior remains unknown.

---

# Existing Retrieval Terms

- **Responsibility boundary** — allocation of knowledge and behavior. `&&&01`
- **Naming as data contract** — precise labels preserve meaning. `&&&03`
- **Resource ownership and lifetime** — creation, use, and release responsibility. `&&&04`
- **Deterministic cleanup** — release tied to a visible scope or lifecycle event. `&&%03`
- **Statement versus workflow atomicity** — one statement can be atomic while a multi-step use case is not. `&%%05`
- **SQLite initialization versus migration** — fresh structure versus compatible adaptation; seeding is distinct. `%%%01`
- **SQLite connection ownership** — session and cursor lifetime. `%%%02`
- **Bundled resource versus writable user data** — replaceable application content versus retained mutable state. `%%%05`

---

# Supervision Notes

- `02_KANBAN.md` remains authoritative.
- No concept became Green.
- Installed technical validation does not prove learner mastery.
- Human-visible Register, Lists, History, Settings, close/reopen, and SmartScreen observations remain learner-facing evidence gaps.
- Tool names remain project examples rather than standalone concepts.

---

# Flutter Shared-Beta Canonical Derivations

## Stable Identity
**KANBAN ID:** `&&&06`  
**Type:** Foundational Computer Science  
**Definition:** A durable identifier for one logical subject independent of mutable labels.  
**Project Usage:** Account, device, Product, Purchase, Item, and event UUIDs.  
**Related Concepts:** See `&&&06` in `02_KANBAN.md`.

## Authentication
**KANBAN ID:** `&&&07`  
**Type:** Foundational Computer Science  
**Definition:** Verification that establishes an authenticated principal.  
**Project Usage:** Verified sign-in resolves the internal account UUID.  
**Related Concepts:** See `&&&07` in `02_KANBAN.md`.

## Authorization
**KANBAN ID:** `&&&08`  
**Type:** Foundational Computer Science  
**Definition:** Policy deciding which operations a principal may perform on resources.  
**Project Usage:** The API restricts events to the authenticated account; row ownership is an example.  
**Related Concepts:** See `&&&08` in `02_KANBAN.md`.

## Eventual Consistency
**KANBAN ID:** `&&&09`  
**Type:** Foundational Computer Science  
**Definition:** Replicas converge after receiving and deterministically applying the same accepted facts.  
**Project Usage:** Offline Markei clients catch up through cursor synchronization.  
**Related Concepts:** See `&&&09` in `02_KANBAN.md`.

## Historical Integrity
**KANBAN ID:** `&&&10`  
**Type:** Foundational Computer Science  
**Definition:** Preservation of the identity and facts required to interpret accepted history.  
**Project Usage:** Package or brand change creates a new Product ID without rewriting old Purchase Items.  
**Related Concepts:** See `&&&10` in `02_KANBAN.md`.

## Immutable Dart Model
**KANBAN ID:** `&&%05`  
**Type:** Dart Language  
**Definition:** Typed Dart data whose identity-bearing fields do not mutate after construction.  
**Project Usage:** Events, catalogue identities, Money, and Quantity use immutable values.  
**Related Concepts:** See `&&%05` in `02_KANBAN.md`.

## Reusable Catalogue
**KANBAN ID:** `&%%07`  
**Type:** Project / Model  
**Definition:** An account-scoped set of recurring identities referenced by historical transactions.  
**Project Usage:** Products and Stores are reused across Purchases.  
**Related Concepts:** See `&%%07` in `02_KANBAN.md`.

## Product Identification Set and Deterministic Normalization
**KANBAN ID:** `&%%08`  
**Type:** Project / Model  
**Definition:** Canonical identity attributes mapped deterministically to one account-scoped Product ID.  
**Project Usage:** Packaged and BULK identities normalize units; fuzzy matches never auto-merge.  
**Related Concepts:** See `&%%08` in `02_KANBAN.md`.

## Purchase Aggregate
**KANBAN ID:** `&%%09`  
**Type:** Project / Model  
**Definition:** Consistency boundary owning Purchase header, Items, and required persistence effects.  
**Project Usage:** Purchase, Items, and pending event commit atomically.  
**Related Concepts:** See `&%%09` in `02_KANBAN.md`.

## Purchase Item
**KANBAN ID:** `&%%10`  
**Type:** Project / Model  
**Definition:** Product-specific commercial observation belonging to a Purchase.  
**Project Usage:** Stores Product reference, quantity, line total, package count, and promotion.  
**Related Concepts:** See `&%%10` in `02_KANBAN.md`.

## Append-Only Synchronization Event
**KANBAN ID:** `&%%11`  
**Type:** Project / Synchronization  
**Definition:** Immutable identified protocol fact appended to shared history.  
**Project Usage:** `purchase.registered` carries one atomic Purchase and its Item lines.  
**Related Concepts:** See `&%%11` in `02_KANBAN.md`.

## Offline Queue and Idempotent Delivery
**KANBAN ID:** `&%%12`  
**Type:** Project / Synchronization  
**Definition:** Durable pending events plus retry rules that prevent duplicate effect.  
**Project Usage:** The same event UUID/content returns prior acceptance.  
**Related Concepts:** See `&%%12` in `02_KANBAN.md`.

## Device Ordering and Synchronization Cursor
**KANBAN ID:** `&%%13`  
**Type:** Project / Synchronization  
**Definition:** Device sequence records local creation order; server cursor records accepted download order.  
**Project Usage:** Clients detect sequence gaps and page unseen account events.  
**Related Concepts:** See `&%%13` in `02_KANBAN.md`.

## Sync Protocol
**KANBAN ID:** `&%%14`  
**Type:** Project / Synchronization  
**Definition:** Versioned cross-runtime rules for validated, authorized, ordered event exchange.  
**Project Usage:** Dart client and TypeScript API share language-neutral payload and error semantics.  
**Related Concepts:** See `&%%14` in `02_KANBAN.md`.

## Dimensional Quantity
**KANBAN ID:** `&%%15`  
**Type:** Project / Value Model  
**Definition:** Fixed-precision magnitude qualified by physical dimension and unit.  
**Project Usage:** MASS/KG, VOLUME/L, and COUNT/UNIT remain distinct.  
**Related Concepts:** See `&%%15` in `02_KANBAN.md`.

## Monetary Minor Unit
**KANBAN ID:** `&%%16`  
**Type:** Project / Value Model  
**Definition:** Currency code paired with integer count of the currency's minor unit.  
**Project Usage:** BRL 8.79 is BRL plus 879.  
**Related Concepts:** See `&%%16` in `02_KANBAN.md`.

## Versioned Analytic
**KANBAN ID:** `&%%17`  
**Type:** Project / Analytics  
**Definition:** Derived algorithm with stable identity and immutable semantic version.  
**Project Usage:** Improved price-change rules create a new version without rewriting purchases.  
**Related Concepts:** See `&%%17` in `02_KANBAN.md`.

## Flutter Framework and Responsive Widget Composition
**KANBAN ID:** `%%%07`  
**Type:** Framework / Dependency  
**Definition:** Flutter-managed responsive widget tree rendered from application state across platforms.  
**Project Usage:** Markei adapts one client presentation to Windows, Android, and iOS.  
**Related Concepts:** See `%%%07` in `02_KANBAN.md`.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.

# Sprint 03 Local-Evidence Retrieval

These notes derive from the canonical evidence boundary recorded in `02_KANBAN.md`.

## Local Implementation Evidence
**KANBAN IDs:** `&&&06`, `&&&10`, `&&%05`, `&%%07`–`&%%12`, `&%%15`–`&%%17`, `%%%07`  
Dart/Drift tests now exercise the local catalogue, Purchase aggregate, immutable local event, pending queue, dimensional quantity, minor-unit money, persistence, rollback, and minimal analytics registry. This is local unit-test evidence, not platform or learner validation.

## Versioned Semantic Fixture
**KANBAN IDs:** `&%%08`, `&%%09`, `&%%11`, `&%%14`  
A human-readable cross-language example containing inputs, expectations, or required fields. Current JSON fixtures coordinate meaning but do not yet specify a complete wire protocol, schema validation, or Dart/TypeScript parity.

## Offline Queue Preparation
**KANBAN ID:** `&%%12`  
Atomic creation of a durable pending-event row beside local facts. It does not prove upload, server acceptance, retry deduplication, cursor download, or synchronization.

## Generated Code
**KANBAN IDs:** `%%%07`, `&%%02`  
Source produced from reviewed schema/configuration and tooling. Drift database code and Flutter platform runners are regeneration outputs; their existence does not equal handwritten domain design or platform validation.

## Host-Unvalidated Platform Target
**KANBAN ID:** `%%%07`  
A generated platform project not yet built or run on the required host. Android, Windows, and iOS remain host-unvalidated in Sprint 03 Unit 01.

## Provisional Device Ordering
**KANBAN ID:** `&%%13`  
The intended monotonic device sequence and cursor responsibility is not implemented reliably: repeated registration may reset sequence allocation, and no server cursor exists.

## Local Event Versus Synchronization
**KANBAN IDs:** `&%%11`, `&%%12`, `&%%14`, `&&&09`  
A persisted local append-only event and queue are prerequisites for synchronization. They are not evidence of an API, server idempotency, cursor application, cross-device convergence, authentication, or authorization.

