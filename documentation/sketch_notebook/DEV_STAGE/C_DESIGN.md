# Main Synthesis Summary

Cycle 07 Sprint 01 finds a reusable behavioral nucleus, but not yet a portable application. `models.py` is genuinely platform-neutral. Much of `ProductService` is UI-framework-neutral, yet it constructs the concrete SQLite `Repository`, and that repository immediately opens the desktop database through a database manager whose storage path is `%LOCALAPPDATA%/Markei`. Consequently, the current runtime boundary survives conceptually—Presentation → Service → Repository → Local Store—but fails physically on mobile at construction, storage-location, lifecycle, and presentation boundaries.

The primary prototype candidate is **C: a native or cross-platform mobile client governed by explicit shared contracts and fixtures**, initially offline-first with its own sandboxed local database. This recommendation favors mobile UX and Android/iOS feasibility while preserving Markei semantics as portable specifications rather than assuming Python runtime reuse. The strongest alternative is A, but Python-native mobile viability, packaging, and lifecycle remain unevidenced and should be tested only as a bounded feasibility experiment. B is plausible but would require re-expressing local workflows and persistence behind a web/native bridge. D is unjustified because no demonstrated synchronization, account, or shared-household requirement exists.

The smallest meaningful slice is: launch; open a mobile-owned local store; register one product/purchase through a mobile use-case boundary; persist it; close/relaunch; display the saved item and derived status. It must not access, copy, or synchronize the ordinary desktop database.

## Inspected Evidence

Branch inspection explicitly targeted `cycle-07-mobile-preparation`. The supplied baseline `f6414fbe7394453387067a5a34ca6cc7621bbed3` is an ancestor of inspected HEAD `889c9ac365e0d717ac33431bd82af286b0f343f1`; the intervening commit updates only Main staging. Methodology boot followed `AGENTS.md`, `INDEX.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, and `CHAT_PROTOCOL.md`.

Cycle context came from `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, `design/09_DESIGN_STATE.md`, and `[M]_STAGE/J_[M]_STAGE.md`. The Design checkpoint still says Cycle 06 awaits acceptance. Main-root evidence supersedes that wording: Cycle 06 is accepted and closed; this report does not reopen it.

Implementation evidence inspected: `app/core/models.py`, `contracts.py`, `services.py`, `repository.py`, `database.py`, `config.py`; all files under `app/desktop/` and `app/mobile/`; `app/main.py`, root `main.py`, and `app/database/schema.sql`. `app/mobile/main.py` is empty. No runtime experiment was performed during this investigation-only sprint.

## Portability and Coupling Map

| Surface | Classification | Evidence and consequence |
| --- | --- | --- |
| `app/core/models.py` | Platform-neutral and likely reusable | Dataclasses and typing only; entities contain no Qt, SQL, filesystem, or lifecycle operations. Direct reuse is possible only where Python runs. |
| Domain constants in `config.py` | Platform-neutral and likely reusable | Names, defaults, and date format are runtime-independent; database resource names are deployment-oriented. |
| `app/core/contracts.py` | Platform-neutral but language-bound | ABCs and field lists express useful responsibilities, but are Python interfaces, not cross-language wire/data contracts or executable conformance fixtures. |
| Calculations and validations in `services.py` | Platform-neutral but coupled by construction/imports | No Qt or SQL imports, but `ProductService.__init__()` constructs `Repository`; UI-facing dictionaries/labels and persisted page-order settings mix behavior with desktop presentation conveniences. |
| `app/core/repository.py` | Persistence-specific | Concrete SQLite adapter, row mapping, connection/cursor ownership, and per-method commits. Its abstract responsibility survives; implementation portability is unknown until the mobile SQLite driver/runtime is tested. |
| `app/core/database.py` | Persistence-specific and desktop-coupled | SQLite/schema logic is broadly portable, but resource discovery includes PyInstaller and user storage defaults to Windows `%LOCALAPPDATA%`; module-level paths are fixed at import time. |
| `app/database/schema.sql` | Persistence-specific, semantically reusable | Product/purchase/category/store/settings relationships are useful. Text dates, additive migration helpers, cached derived fields, and schema ordering require mobile migration/conformance experiments. |
| `app/desktop/**` | Desktop- and presentation-specific | PySide6 widgets own navigation, rendering, dialogs, event binding, refresh, and form state. Pages construct their own services and participate in close coordination. |
| `app/main.py`, root `main.py` | Desktop-specific composition | QApplication, Qt event loop, MainWindow, PyInstaller/source path handling, and desktop startup diagnostics. |
| `app/mobile/main.py` | Unknown until built/tested | Empty placeholder supplies no architecture, runtime, or feasibility evidence. |

## Boundaries Under Mobile Execution

The entity distinction among Product, Purchase, Category, and Store survives. The purchase-ledger/inventory-summary distinction, validation and calculation rules, repository abstraction, structural defaults, and dependency direction also survive as design concepts. SQLite remains a credible local-store technology because the schema already represents offline facts without network identity.

Several current boundaries fail as executable mobile seams. Service construction hard-codes the concrete repository, so a mobile composition root cannot select storage without changing construction. Repository creation opens a connection immediately. The database manager selects a Windows data directory and bundled filesystem schema at import time. Desktop pages each create service/connection ownership, while MainWindow later coordinates closure; mobile suspend/resume and process termination require an application-scoped lifecycle owner rather than widget-close assumptions. Per-method repository commits also prevent a receipt workflow from being guaranteed atomic across multiple writes. This inherited transaction debt matters more under interrupted mobile lifecycles.

Current service return dictionaries containing labels, display strings, and page-order settings should not become cross-platform contracts. Stable contracts should carry typed facts and status codes; each presentation should own localization, formatting, navigation, and visual labels.

## Four Approach Families

| Shared criterion | A. Shared Python core / Python-native UI | B. Web/hybrid presentation | C. Native/cross-platform client + contracts | D. Service-backed client |
| --- | --- | --- | --- | --- |
| Domain behavior reuse | Highest potential direct reuse after construction seam extraction | Low-to-medium; Python needs embedding/service or behavior port | Medium semantic reuse through fixtures; runtime behavior is ported | Server may reuse Python, but client still needs contracts/local logic |
| Mobile UX / platform fit | Unknown; toolkit maturity, accessibility, and native integration must be evidenced | Good for form/list UI; native feel and bridge quality vary | Strongest expected platform UX and lifecycle fit | Determined by client framework; backend adds no UX benefit itself |
| Offline capability | Strong in principle with sandbox SQLite | Strong with local SQLite/web storage, but bridge/migration design needed | Strong with platform database and local use cases | Weak unless local-first duplication and sync are also built |
| Persistence safety | Current database manager cannot be reused unchanged | New client persistence boundary required | Explicit mobile-owned database and migration owner | Adds local cache, server store, sync, and conflict responsibilities |
| Android / iOS feasibility | Android/iOS packaging and distribution are unknown; iOS likely the stricter gate | Generally feasible through established hybrid toolchains | Generally strongest established feasibility | Feasible but operationally broadest |
| Contract stability | Python ABCs help only inside Python | Requires language-neutral DTO/use-case definitions | Makes language-neutral contracts and fixtures first-class | Requires API plus local-sync contracts prematurely |
| Lifecycle ownership | Must replace widget-owned service lifetime | App shell/bridge owns store and suspend/resume | App composition root owns use cases/store lifecycle | Client and server lifecycles plus sync scheduler |
| Schema/migrations | Could adapt current SQLite/schema resources | Likely client-specific migration system | Client-specific migrations validated against semantic fixtures | Client and server schemas plus versioned synchronization |
| Testing | Reuse Python unit tests; add device/package tests | Contract, bridge, web UI, and device persistence tests | Shared golden fixtures plus client unit/integration/device tests | API, auth, conflict, network, client, and server tests |
| Repository topology | Same repo best for shared Python package | Same repo/monorepo while boundaries settle | Same repo initially: desktop, mobile, and shared specifications | Multiple deployables may later justify monorepo or split repos |
| Maintenance cost | Lowest if toolchain works; high risk from niche deployment constraints | Medium; bridge and duplicated logic cost | Medium-high from second implementation, offset by mature tooling | Highest: hosting, security, operations, compatibility, sync |
| Future synchronization | Can add sync above local repository | Can add sync adapter above local store | Clear local repository/use-case seam supports later sync | Immediate capability, but pays complexity before demand |

## Facts, Assumptions, Experiments, and Deferrals

### Accepted facts

- Desktop remains an accepted PySide6/SQLite controlled beta and must remain protected.
- Core models contain no platform imports; services contain no Qt/SQL calls but construct the concrete repository.
- The database manager owns Windows/PyInstaller path behavior; repository owns connection/cursor and commits.
- Desktop presentation constructs services and participates in shutdown; the mobile placeholder is empty.
- The schema is local and has no account, device, synchronization, or conflict identifiers.

### Working assumptions

- The prototype is single-device, offline-first, and owns a fresh mobile sandbox database.
- Mobile will reproduce business semantics, not binary-copy desktop state.
- Same-repository investigation provides the lowest drift cost until a toolchain is selected.
- Cross-platform/native framework choice remains outside this report; C names an architectural family, not a technology winner.

### Required experiments

1. Turn representative service scenarios into language-neutral input/output fixtures: first purchase, repeat purchase, status transition, persistence/relaunch, and invalid receipt.
2. Prove one C-family client can create, reopen, and migrate a sandboxed local database on at least Android; record the exact iOS feasibility gate separately.
3. Verify the minimal workflow is atomic under interruption or redesign the use-case transaction boundary before expansion.
4. Run a time-boxed A-family spike only if direct Python reuse could materially reduce cost; require real device packaging, lifecycle, and accessibility evidence rather than desktop execution.
5. Decide whether the schema itself is shared or only its semantics are shared by comparing fixture outcomes across desktop and prototype stores.

### Explicit deferrals

Authentication, backend hosting, multi-device synchronization, household sharing, conflict resolution, desktop/mobile database exchange, app-store release, notification scheduling, barcode scanning, broad schema redesign, full feature parity, permanent repository split, and desktop refactoring are deferred. Export/import may later be investigated, but is not part of the prototype.

## Recommended Minimal Vertical-Slice Architecture

Use a same-repository investigative topology with isolated roots: existing `app/core` and `app/desktop` remain untouched; a mobile client owns presentation, composition, lifecycle, and its local-store adapter; a shared specification area later approved by Main would own language-neutral use-case contracts and golden fixtures. No new topology is materialized in Sprint 01.

The prototype dependency direction should be:

```text
Mobile presentation
→ RegisterPurchase use case
→ mobile repository interface
→ mobile local database adapter
→ sandboxed local database
```

The application composition root creates one store/repository scope, runs initialization/migrations, injects it into the use case, and handles suspend/resume/relaunch. The registration command carries raw typed values; the result exposes domain facts/status codes, not desktop labels. A single transaction creates or finds the product, inserts the purchase, recalculates summary state, and commits. Relaunch reads the persisted result and renders one list/detail view.

Explicitly outside the slice: editing/deleting, stores/settings UI, analytics/history periods, promotions engine, complete Storage/Shortage/Market screens, desktop database access, transfer/sync, accounts, cloud services, background tasks, release packaging, and pixel-complete UI.

## Handoff to Main

Main should treat C as the primary prototype architecture, A as the bounded reuse challenger, B as viable but secondary, and D as deferred pending demonstrated synchronization requirements. Approve contracts/fixture design and one mobile-local persistence slice before choosing a framework or permanent topology. Acceptance evidence should require persistence across relaunch, semantic agreement with shared fixtures, explicit lifecycle ownership, and no contact with ordinary desktop user data.
