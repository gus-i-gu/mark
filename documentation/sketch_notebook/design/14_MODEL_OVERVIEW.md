# 14_MODEL_OVERVIEW.md

> Version: 0.1-recovery
> Status: Recovered Derivative
> Persistence Class: Derived
> Knowledge Class: Design
> Authority: Design Chat [D]
> Canonical Source: `design/01_ARCHITECTURE.md`
> Scope: Low-cost recovery map of the accepted current Markei architecture

---

# 1. Purpose

This file is the preferred quick-entry view of the Markei architecture.

It reorganizes canonical Design knowledge for human supervision and economical agent recovery. It does not introduce architectural truth. When precision, rationale, or boundary wording matters, consult `01_ARCHITECTURE.md`.

---

# 2. System at a Glance

Markei is a local Python desktop monolith using PySide6 and SQLite.

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

Main rule:

```text
presentation requests behavior
service owns application meaning
repository owns SQL
Database Manager owns database lifecycle
```

---

# 3. Responsibility Map

| Surface | Current responsibility |
| --- | --- |
| `app/main.py` | Starts Qt and creates `MainWindow` |
| `app/desktop/main_window.py` | Composes pages, navigation, edit routing, and refresh coordination |
| `app/desktop/ui/pages/*` | Receives input and renders public desktop workflows |
| `app/desktop/ui/widgets/*` | Renders reusable Qt-specific views |
| `app/core/services.py` | Application facade: workflows, calculations, settings, stores, and read models |
| `app/core/repository.py` | Persistence facade: SQL, queries, row mapping, commits, and connection ownership |
| `app/core/database.py` | Paths, initialization, SQLite configuration, additive migration, reset, and closure primitives |
| `app/core/models.py` | Domain data representations |
| `app/core/contracts.py` | Invariants and partial service/repository interfaces |
| `app/database/*.sql` | Bundled persistence definition and initialization data |
| `%LOCALAPPDATA%/Markei/market.sqlite` | Writable user state |

---

# 4. Desktop Model

Public surfaces:

```text
Register
Lists
History
Settings
```

Lists contains the former inventory surfaces:

```text
Storage  → in-house
Shortage → shortage
Market   → to-buy
```

Page roles:

| Page or widget | Role |
| --- | --- |
| Register | Writes receipt and product workflows |
| Lists | Reads inventory and status projections |
| History | Reads grouped purchase history and analytics |
| Settings | Edits history settings and stores |
| ProductDetailPanel | Renders service-prepared product detail data |

`MainWindow` is the present desktop shell and informal coordinator. Pages use service operations rather than SQL or repository calls.

---

# 5. Domain Spine

Active domain representations:

```text
Category
Store
Product
Purchase
```

Relationships:

```text
Category 1 ─── * Product
Product  1 ─── * Purchase
Store    1 ─── * Purchase, optional
```

Meaning:

```text
Purchase
    historical receipt record

Product
    editable product identity and metadata
    + current inventory state
    + cached summaries derived from purchases
```

`ProductService.recalculate_product()` is the centralized producer of calculated Product state.

Promotion exists in the schema but is not part of the recovered active application model.

---

# 6. Data Representation Flow

```text
SQLite row
    ↓
Domain model
    ↓
Service projection / view model
    ↓
Qt widget
```

Current service projections are dictionaries used by Lists, History, analytics, and Product detail.

The service may prepare application-oriented labels. Qt code retains controls, layout, signals, colors, dialogs, and selection behavior.

---

# 7. Persistence Model

Repository:

- owns SQL and row mapping;
- spans products, purchases, categories, stores, settings, and related queries;
- owns one SQLite connection and cursor per instance;
- commits mutation methods individually;
- exposes explicit closure.

Database Manager:

- resolves bundled and writable paths;
- initializes the database;
- configures every managed connection;
- applies the current additive compatibility migration;
- exposes reset and closure primitives.

Connection configuration:

```text
foreign_keys = ON
journal_mode = WAL
synchronous = NORMAL
row_factory = sqlite3.Row
```

Resource boundary:

```text
bundled schema and seed
    separate from
writable user database
```

---

# 8. Current Structural Constraints

## Distributed lifecycle ownership

Each principal page currently creates its own chain:

```text
Page → ProductService → Repository → SQLite connection
```

Normal composition therefore creates four service/repository/connection chains.

Local close capability exists, but one authoritative application-wide shutdown owner is not established.

## Multi-commit workflows

Receipt registration currently commits in stages:

```text
create or update Product
→ insert Purchase
→ recalculate Product summary
```

The workflow is sequentially consistent but not transactionally atomic across the complete user action.

These are accepted descriptions of the current implementation, not preferred permanent targets.

---

# 9. Stable Boundaries

Use these as the fast architectural invariants:

1. Desktop code does not execute SQL.
2. Service code owns workflows, calculations, settings interpretation, and application projections.
3. Repository owns SQL and persistence mapping.
4. Database Manager owns database lifecycle and compatibility behavior.
5. Domain models do not perform persistence or orchestrate workflows.
6. Purchase is historical source data.
7. Product calculated state is centralized through service recalculation.
8. Bundled resources and writable user data remain separate.
9. MainWindow composes and coordinates the current desktop.

---

# 10. Open Design Areas

The canon records these as unresolved rather than accepted targets:

- shared versus page-local service ownership;
- application shutdown ownership;
- workflow-level transaction semantics;
- ProductService or Repository decomposition;
- completion or simplification of contracts;
- typed view models and formatting ownership;
- versioned migration design;
- Promotion feature status;
- `pages.order` status;
- long-term Product aggregate/cache design.

Consult `01_ARCHITECTURE.md` before making decisions in these areas.

---

# 11. Recovery Routing

```text
Need rapid structural orientation
    → read this file

Need exact accepted responsibility or invariant
    → read 01_ARCHITECTURE.md

Need current milestone, tensions, and next inspection
    → read 09_DESIGN_STATE.md

Need accepted design evolution history
    → read 03_DECISION_LOG.md
```

At this recovery stage, `09_DESIGN_STATE.md` remains the next Design symmetry target and `03_DECISION_LOG.md` remains intentionally empty.
