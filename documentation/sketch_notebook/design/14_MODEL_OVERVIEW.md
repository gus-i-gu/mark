# 14_MODEL_OVERVIEW.md

> Version: 0.2-cycle06
> Status: Active Derived Overview
> Persistence Class: Derived
> Knowledge Class: Design
> Authority: Design Chat [D]
> Canonical Source: `design/01_ARCHITECTURE.md`
> Scope: Low-cost recovery map of the accepted Markei application and deployment architecture

---

# 1. System at a Glance

Markei is a local PySide6 and SQLite desktop monolith.

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

Main responsibility rule:

```text
presentation requests behavior
service owns application meaning
repository owns SQL
Database Manager owns database lifecycle
packaging owns frozen composition
installer owns placement and registration
```

---

# 2. Responsibility Map

| Surface | Current responsibility |
| --- | --- |
| `main.py` | Packaged launcher adapter and outer startup-diagnostic boundary |
| `app/main.py` | Creates `QApplication`, constructs `MainWindow`, and enters the event loop |
| `app/desktop/main_window.py` | Composes pages, coordinates navigation/refresh, and closes page-owned services on final window shutdown |
| `app/desktop/ui/pages/*` | Receives input and renders public desktop workflows |
| `app/core/services.py` | Workflows, validation, calculations, settings, stores, and read models |
| `app/core/repository.py` | SQL, row mapping, persistence operations, commits, and connection ownership |
| `app/core/database.py` | Resource/user paths, initialization, configuration, additive migration, reset, and connection primitives |
| `Markei.spec` | Authoritative one-folder PyInstaller composition |
| `scripts/build_windows.ps1` | Invokes the authoritative spec |
| `installer/Markei.iss` | Installer identity, placement, shortcuts, and uninstall registration |
| `scripts/build_installer.ps1` | Locates Inno Setup and invokes installer compilation |

Packaging and installer surfaces do not own business workflows, SQL meaning, or persistence semantics.

---

# 3. Desktop and Lifecycle Model

Public surfaces:

```text
Register
Lists
History
Settings
```

Lists modes:

```text
Storage  → in-house
Shortage → shortage
Market   → to-buy
```

Current ownership:

```text
4 pages
→ 4 ProductService instances
→ 4 Repository instances
→ 4 SQLite connections
```

Each service/repository retains its local close path. `MainWindow.closeEvent()` is the accepted idempotent final coordinator that closes all four page-owned services. This bounded correction followed a focused shutdown failure and is not a composition-root redesign.

---

# 4. Deployment Map

```text
Source
    main.py
    app/
    app/database/schema.sql

Build
    Markei.spec
    scripts/build_windows.ps1
    dist/Markei

Install
    installer/Markei.iss
    scripts/build_installer.ps1
    compiled installer — blocked

Installed application
    replaceable program files
    Start Menu shortcut — configured
    optional desktop shortcut — configured

User state
    %LOCALAPPDATA%/Markei/market.sqlite
    market.sqlite-wal / market.sqlite-shm
    %LOCALAPPDATA%/Markei/logs/startup.log
```

Installed program files and user state are separate sibling concerns.

---

# 5. Resource Classification

| Item | Classification |
| --- | --- |
| `schema.sql` | Bundled read-only production resource |
| `seed.sql` | Development/test fixture, excluded from production package |
| `market.sqlite` | Retained writable user data |
| WAL/SHM | Transient writable companions, never bundled |
| startup logs | Generated writable diagnostics |
| version metadata/static assets | Replaceable release content |

Fresh production initialization is schema-only and contains no sample business rows.

---

# 6. Release Contract

```text
Name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Stable AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Target: Windows x64 controlled beta
```

```text
Start Menu shortcut: required
Desktop shortcut: optional installer task
Uninstall data policy: preserve %LOCALAPPDATA%/Markei by default
```

The installer source records these choices, but installed behavior remains unvalidated.

---

# 7. Evidence Status

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

Validated boundaries include source/static checks, schema-only frozen first launch, resource exclusion, startup-log creation, shutdown closure, and frozen reopen.

Blocked boundaries include installer compilation and all installed lifecycle transitions.

---

# 8. Stable Boundaries

1. Desktop code does not execute SQL.
2. ProductService owns application workflows and meaning.
3. Repository owns SQL and persistence mapping.
4. Database Manager owns database lifecycle and compatibility behavior.
5. Packaging and installer layers remain deployment concerns.
6. `Markei.spec` is the package authority.
7. Bundled resources and writable user state remain separate.
8. MainWindow coordinates final shutdown of page-owned services.
9. A built frozen runtime is not an installed or accepted beta.

---

# 9. Open or Deferred Areas

- installed lifecycle validation;
- workflow transaction atomicity;
- future service/repository decomposition;
- composition-root or dependency-injection redesign;
- numbered migration framework;
- optional uninstall data-deletion UX;
- signing, rollback, auto-update, one-file packaging;
- mobile, backend, synchronization, authentication, and cloud persistence.

For exact accepted wording, consult `01_ARCHITECTURE.md`. For current gates, consult `09_DESIGN_STATE.md`. For chronology, consult `03_DECISION_LOG.md`.