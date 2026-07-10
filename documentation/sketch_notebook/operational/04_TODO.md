# 04_TODO.md

> Version: Recovery derivative 0.1
> Status: Active operational derivative
> Persistence Class: Derived
> Knowledge Class: Operational
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Purpose: Low-cost recovery, human supervision, and immediate execution guidance

---

# 1. Use This File For

Use this file to answer:

```text
What is operationally established?
What requires validation now?
What decisions remain outside Operational authority?
Which commands or inspections should run next?
```

This file reorganizes canonical knowledge. It does not replace or override `12_OPERATIONAL_MODEL.md` and must not introduce independent truth.

---

# 2. Fast Recovery Card

## Runtime spine

```text
main.py
→ app.main.main()
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

## Persistence ownership

```text
ProductService
    workflows, calculations, settings interpretation, UI projections

Repository
    SQL, row/model mapping, mutation commits, one connection + cursor

Database Manager
    paths, connection configuration, initialization, migration, close/reset
```

## Writable state

```text
%LOCALAPPDATA%/Markei/market.sqlite
```

Bundled SQL resources remain under `app/database/`.

## Current lifecycle shape

```text
4 desktop pages
→ 4 ProductService instances
→ 4 Repository instances
→ 4 long-lived SQLite connections
```

Local close capability exists. Application-wide shutdown ownership remains implicit.

## Current transaction shape

```text
Repository mutation
→ commit

multi-step service workflow
→ several committed mutations
→ not transactionally atomic as one business operation
```

---

# 3. Immediate Operational Priorities

## P0 — Protect data during validation

- Use an isolated `LOCALAPPDATA` path for initialization, migration, reset, and failure tests.
- Never run exploratory reset against the ordinary user database.
- Close every Repository created by a test.
- Account for SQLite `-wal` and `-shm` files before deletion or recreation.

## P1 — Verify deterministic desktop shutdown

Establish whether normal Qt shutdown closes all four page-owned services and repositories.

Evidence required:

- each Repository is open after page construction;
- all four are closed after normal window/application shutdown;
- no cleanup exception is emitted;
- the database can be reopened immediately;
- isolated test directories can be removed without retained locks.

Do not classify the current model as leaking until runtime evidence demonstrates it.

## P1 — Validate multi-commit failure behavior

Inject failure after each mutation boundary in:

```text
register_receipt()
create/update Product
→ insert Purchase
→ recalculate Product
→ update Product summary
```

Also inspect purchase deletion followed by summary recalculation.

Record the durable database state after each injected failure. The current workflow is known to be non-atomic; the test should identify exact partial-state outcomes.

## P1 — Resolve production seed policy

Current `seed.sql` contains baseline category, store, and settings rows plus an example Rice product.

Human/Main classification is required for:

- required production defaults;
- optional development fixtures;
- demonstration business records;
- rows that must be excluded from packaged production initialization.

Packaging acceptance must not proceed while this classification is ambiguous.

## P2 — Validate migration behavior

Confirm on an isolated database that:

- repeated connections converge on the same schema;
- required columns are not duplicated;
- default settings are not duplicated;
- user-selected settings are not overwritten;
- migration failure behavior is observable and recoverable;
- current additive compatibility remains distinct from a future versioned migration system.

## P2 — Validate packaged resource discovery

For every generated runtime mode under consideration, verify:

- `schema.sql` is bundled and discoverable;
- seed inclusion matches the approved policy;
- no prebuilt live database is bundled;
- no SQLite WAL/SHM files are bundled;
- the live database is created or reused outside the runtime directory.

## P2 — Validate installed data preservation

Source path separation is implemented, but lifecycle preservation still requires direct evidence for:

```text
install
→ launch
→ write data
→ upgrade
→ relaunch
→ uninstall
→ reinstall
```

Record which operations preserve `%LOCALAPPDATA%/Markei/market.sqlite` and which intentionally remove it.

---

# 4. Validation Ladder

Use the lowest sufficient validation layer first.

```text
1. syntax/import
2. isolated database connection
3. fresh initialization
4. repeated migration
5. Repository lifecycle
6. service workflow failure injection
7. desktop smoke and shutdown
8. generated runtime launch
9. installed lifecycle
10. release acceptance
```

Evidence from one level does not prove a later level.

Status vocabulary:

```text
implemented
validated
configured but unvalidated
blocked
deferred
```

---

# 5. Command-Ready Checks

## Syntax and imports

```powershell
python -m compileall app main.py
```

## Connection configuration

```powershell
python -c "from app.core.database import connect; c=connect(); print(c.execute('PRAGMA foreign_keys').fetchone()[0]); print(c.execute('PRAGMA journal_mode').fetchone()[0]); c.close()"
```

## Repository lifecycle

```powershell
python -c "from app.core.repository import Repository; r=Repository(); print(r.is_open); r.close(); print(r.is_open)"
```

## Isolated fresh initialization

```powershell
$env:LOCALAPPDATA = "$PWD\.tmp-localappdata"
Remove-Item -Recurse -Force $env:LOCALAPPDATA -ErrorAction SilentlyContinue
python -c "from app.core.database import connect, DATABASE_PATH; c=connect(); print(DATABASE_PATH); print([r['name'] for r in c.execute('SELECT name FROM sqlite_master WHERE type=''table'' ORDER BY name')]); c.close()"
```

## Repeated migration

```powershell
$env:LOCALAPPDATA = "$PWD\.tmp-localappdata"
python -c "from app.core.database import connect; [connect().close() for _ in range(3)]; print('repeated connect/migrate complete')"
```

## Developer desktop smoke

```powershell
python main.py
python -m app.main
```

Manual checks:

- visible MainWindow;
- Register, Lists, History, and Settings load;
- Lists modes change;
- a write refreshes dependent views;
- closure releases database access;
- reopening preserves data.

---

# 6. Human and Main Decisions Required

Operational evidence can inform but cannot decide:

1. whether page-local service ownership remains the intended lifecycle model;
2. whether shutdown ownership moves to `app/main.py`, MainWindow, or another composition object;
3. whether workflow-level atomicity is required for the current product stage;
4. whether migrations adopt a numbered/versioned ledger;
5. which seed rows belong in production;
6. whether reset becomes user-facing and under which safeguards;
7. which installer lifecycle should preserve or remove user data.

These are not implementation defects merely because alternatives exist.

---

# 7. Retrieval Map

Consult the canonical model when exact rules or full rationale are needed:

```text
runtime and responsibilities       → 12_OPERATIONAL_MODEL §§2–4
resources and writable data        → §5
connection configuration           → §6
initialization                      → §7
migration                           → §8
connection ownership               → §§9–10
transaction behavior               → §11
reset safety                        → §12
validation language and isolation  → §§13–14
packaging lifecycle                → later canonical sections
```

Consult this derivative first when the goal is rapid orientation, task selection, or validation planning.

---

# 8. Derivative Maintenance Rule

Refresh this file when canonical operational knowledge changes or when active priorities are reordered by Main/human direction.

When a statement here conflicts with `12_OPERATIONAL_MODEL.md`:

```text
canon wins
→ identify derivative drift
→ refresh this file
```

Completed execution events do not become permanent truth here. They should update the checkpoint and, once the repopulation milestone is complete, the observational record.