# 01_ARCHITECTURE.md

> Version: 0.2-cycle06
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

The present concrete construction remains page-local: each principal page constructs a ProductService, which constructs a Repository. This describes current implementation and is not a mandate for dependency injection or a future composition-root redesign.

---

# 2. Desktop Composition and Shutdown

`app.main.main()` owns Qt application construction: it creates `QApplication`, constructs `MainWindow`, shows it, and enters the event loop.

`MainWindow` owns the current desktop shell:

- construction of Register, Lists, History, and Settings;
- tab composition, navigation, edit routing, and refresh coordination;
- final coordination of page-owned service closure during normal window shutdown.

The four page-local chains remain:

```text
RegisterPage → ProductService → Repository → SQLite connection
ListsPage    → ProductService → Repository → SQLite connection
HistoryPage  → ProductService → Repository → SQLite connection
SettingsPage → ProductService → Repository → SQLite connection
```

Each service and repository retains its local close responsibility. `MainWindow.closeEvent()` provides the accepted idempotent final coordinator that invokes those local close paths for all four pages. This bounded coordination was introduced after focused validation demonstrated that distributed cleanup alone left the isolated SQLite file open.

This decision does not establish a new composition root, shared-service model, or dependency-injection architecture.

---

# 3. Application and Persistence Boundaries

`ProductService` remains the broad application facade for receipt registration, product lifecycle, calculated state, inventory projections, history projections, settings, stores, and UI-consumable read models.

`Repository` remains the broad SQLite persistence facade for products, purchases, categories, stores, settings, SQL execution, row mapping, commits, and closure.

Repository mutation methods commit individually. Receipt registration and purchase deletion/recalculation remain multi-commit workflows rather than one atomic business transaction. Workflow atomicity remains inherited Design debt and was not changed by Cycle 06 packaging work.

The current additive migration behavior is not a numbered or general migration framework.

---

# 4. Deployment Boundaries

Cycle 06 establishes five distinct execution and deployment states:

```text
Source tree
    main.py + app/ + schema resource

Frozen runtime
    one-folder PyInstaller distribution

Installer source
    Inno Setup definition consuming the frozen distribution

Installed program files
    replaceable executable and runtime content

Writable user state
    retained per-user database, transient SQLite companions, and diagnostics
```

A configured installer is not an installed application. A built and launched frozen runtime does not prove installer or installed-lifecycle behavior.

## 4.1 Launcher and application construction

```text
root main.py
    launcher adapter
    owns the outer startup-diagnostic boundary

app.main.main()
    owns Qt application construction and execution
```

An unhandled launcher-level startup exception is written to a per-user diagnostic log and produces a concise visible error where Qt permits. Startup diagnostics remain outside business and persistence layers.

## 4.2 Packaging authority

```text
Markei.spec
    authoritative one-folder PyInstaller composition

scripts/build_windows.ps1
    operational invocation wrapper
    not an independent package definition
```

The packaging layer owns collection of executable code, Python/Qt runtime components, approved read-only resources, and executable metadata. It does not own business workflows, SQL semantics, database migration meaning, or user-created data.

## 4.3 Installer authority

```text
installer/Markei.iss
    placement, installer identity, shortcuts, and uninstall registration

scripts/build_installer.ps1
    compiler discovery and installer-build invocation
```

The installer consumes the frozen distribution. It does not redefine package composition or persistence semantics.

---

# 5. Resource and Writable-State Classification

| Item | Accepted classification |
| --- | --- |
| `app/database/schema.sql` | Bundled read-only, replaceable application resource |
| `app/database/seed.sql` | Development/test fixture; excluded from the production beta package |
| `%LOCALAPPDATA%/Markei/market.sqlite` | Retained writable user data |
| `market.sqlite-wal`, `market.sqlite-shm` | Transient writable companions; never bundled |
| `%LOCALAPPDATA%/Markei/logs/startup.log` | Generated writable startup diagnostics |
| settings stored in SQLite | Retained user data |
| executable metadata and static assets | Replaceable application content |

Fresh production initialization is schema-only: it creates structural/default settings through current initialization and compatibility behavior, without sample category, store, product, purchase, or other demonstration business rows.

Installed application files and retained user state are separate sibling concerns. External placement supports preservation but does not itself prove uninstall, reinstall, or upgrade behavior.

---

# 6. Primary-Beta Retention and Upgrade Boundary

Accepted primary-beta policy:

```text
uninstall
    removes replaceable application files and shortcuts
    preserves %LOCALAPPDATA%/Markei by default

same-version reinstall or compatible beta upgrade
    retains stable installer identity
    replaces program files
    may reopen compatible retained user data
    applies current additive compatibility behavior
```

Optional uninstall-time data-deletion UX is deferred. Incompatible database formats, downgrade behavior, rollback, and a numbered migration framework are outside Cycle 06.

Installer-source configuration records this policy, but the installed lifecycle remains unvalidated until a compiled installer is exercised.

---

# 7. Release Identity Contract

The first controlled Windows x64 beta uses one coordinated release identity:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Installer AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
```

The AppId remains stable across compatible upgrades. Application version, executable metadata, installer metadata, shortcut names, and artifact names are one release contract; silent divergence is Design drift.

Shortcut policy:

```text
Start Menu shortcut: required
Desktop shortcut: optional installer task
```

These are installation-UX decisions and do not alter application-layer architecture.

---

# 8. Evidence Boundary

Current accepted evidence classification:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
installed: blocked
validated: partial — source/static/frozen/resource/startup/shutdown gates
accepted: no
```

Installer source, Start Menu behavior, optional desktop shortcut behavior, uninstall preservation, compatible reinstall, and upgrade are configured but not lifecycle-validated. No compiled installer artifact exists because `ISCC.exe` was unavailable during the bounded materialization.

---

# 9. Accepted Current Boundaries

1. Markei remains a layered local desktop monolith.
2. Packaging and installation are deployment concerns around, not inside, the business architecture.
3. Root `main.py` is the launcher adapter and outer startup-diagnostic boundary.
4. `app.main.main()` remains the Qt construction function.
5. `Markei.spec` is the authoritative package definition; the Windows build script invokes it.
6. Installer source owns placement, shortcuts, identity, and uninstall registration.
7. Production packaging includes `schema.sql` and excludes `seed.sql` and all writable state.
8. User data and diagnostics remain external to replaceable program files.
9. Uninstall preserves `%LOCALAPPDATA%/Markei` by default for the primary beta.
10. Release identity is coordinated across executable and installer surfaces.
11. MainWindow coordinates idempotent final closure of four page-owned services while local close responsibilities remain intact.
12. Installed-lifecycle behavior and final beta acceptance remain unproven.

---

# 10. Explicitly Unresolved or Deferred

The following are not authorized by this Design absorption:

- composition-root or dependency-injection redesign;
- shared-service or repository-lifetime redesign;
- ProductService or Repository decomposition;
- workflow transaction redesign;
- schema redesign or migration ledger;
- typed view-model conversion or broad UI redesign;
- mobile, backend/API, synchronization, authentication, or cloud persistence;
- automatic update, signing, or rollback framework;
- one-file packaging;
- optional uninstall data-deletion UX;
- incompatible-version, downgrade, or rollback strategy;
- unrelated Promotion or `pages.order` decisions.

Derived and checkpoint files must not introduce architectural claims absent from this canon.