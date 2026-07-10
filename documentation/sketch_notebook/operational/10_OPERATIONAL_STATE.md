# 10_OPERATIONAL_STATE.md

> Version: Recovery checkpoint 0.2
> Status: Active operational checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Operational
> Branch: `sketch-notebook-recovery`
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Derived execution source: `operational/04_TODO.md`
> Historical recovery source: `DEV_STAGE/A_OPERATIONAL.md`

---

# 1. Current Recovery Milestone

```text
Sketch Notebook recovery cycle
→ Operational canon reconstructed
→ Operational derivative reconstructed
→ Operational checkpoint reconstructed
→ Operational observational history opened
```

The Operational domain has been repopulated far enough to support low-cost future recovery.

Current permanent files:

```text
12_OPERATIONAL_MODEL.md
    stable operational truth and validation conventions

04_TODO.md
    active priorities, commands, and supervision-oriented retrieval

10_OPERATIONAL_STATE.md
    current state, continuity, risks, and next recovery route

11_OPERATIONAL_RECORD.md
    chronological record of the Operational repopulation and later definite events
```

Current temporary stage:

```text
DEV_STAGE/A_OPERATIONAL.md
    active ephemeral Operational evidence; currently holds the bounded Cycle 05 retrospective
```

---

# 2. Current Application State

Markei currently operates as a local PySide6 desktop application backed by SQLite.

Runtime spine:

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

Current public desktop surfaces:

- Register;
- Lists;
- History;
- Settings.

Storage, Shortage, and Market are represented as Lists modes rather than independent public tabs.

Current persistence model:

```text
bundled SQL resources
    app/database/schema.sql
    app/database/seed.sql

writable user state
    %LOCALAPPDATA%/Markei/market.sqlite
```

The present seed contains baseline rows and an example Rice product. Production seed policy remains unresolved.

---

# 3. Current Lifecycle and Transaction State

Normal MainWindow construction creates:

```text
4 desktop pages
→ 4 ProductService instances
→ 4 Repository instances
→ 4 SQLite connections
```

`ProductService.close()` and Repository closure operations exist. Cleanup attempts are distributed across page-level ownership; no single composition-level shutdown owner is established.

Current transaction model:

```text
Repository mutation
→ immediate commit

multi-step service workflow
→ multiple committed mutations
→ not atomic as one business transaction
```

Receipt registration and purchase deletion/recalculation can leave partial durable state if a later step fails.

---

# 4. Database State and Migration Model

Every managed SQLite connection is configured with:

```text
foreign_keys = ON
journal_mode = WAL
synchronous = NORMAL
row_factory = sqlite3.Row
```

Fresh initialization creates the writable database, applies `schema.sql`, executes `seed.sql` when present, then runs compatibility migration.

Current migration behavior is:

```text
additive
idempotent for encoded changes
invoked during connection creation
without numbered migration ledger
without schema-version table
```

The present mechanism is suitable for current additive compatibility work. Complex transformations, destructive changes, table rebuilds, and rollback-safe evolution are not established.

---

# 5. Precedent Cycle 05 Retrospective

The main-branch precedent Cycle 05 must be remembered as a mixed outcome.

## Reported implementation outcome

The cycle reported a successfully built and launched PyInstaller one-folder runtime with:

- working-directory-independent schema discovery;
- external `%LOCALAPPDATA%\Markei` database placement;
- schema-only, seed-free production initialization;
- empty first-launch business tables and six default settings;
- first receipt entry without a seeded store;
- startup failure logging;
- pinned runtime/build dependencies;
- production-runtime exclusion of seed, live database, WAL/SHM, and sample records.

The Inno Setup installer was configured but not compiled or lifecycle-validated because `ISCC.exe` was unavailable.

## Cycle/process outcome

```text
artifact outcome
    partial success

methodology-cycle outcome
    failed / incoherent closure
```

The cycle is classified as failed because:

1. Cycle 05 was staged as mobile-preparation planning, then materially redirected toward Windows packaging during execution.
2. The `cycle 5.0 outburst mode` commit expanded oversized cross-domain staging and weakened recovery economy and role separation.
3. G/H/I Codex reports remained stale on Cycle 04 while Cycle 05 Sprint 01 evidence was promoted.
4. Permanent memory was reconciled after the fact from accepted human evidence rather than a synchronized stage → materialization → report chain.
5. The installer and installed lifecycle—the user-facing release target—remained blocked and unvalidated.
6. Earlier Cycle 04 human interaction checks remained incomplete.
7. The original mobile-preparation objective was deferred rather than completed.

Accepted continuity statement:

```text
Cycle 05 produced useful packaging knowledge and a reportedly validated frozen runtime,
but failed as a coherent end-to-end cycle because direction, staging, evidence,
and installed-release closure did not remain synchronized.
```

Main-branch packaging evidence is historical continuity. It must not be treated as current recovery-branch runtime validation without direct confirmation.

---

# 6. Current Validation Classification

## Confirmed from recovery-branch source inspection

- layered Desktop → ProductService → Repository → Database Manager → SQLite structure;
- four public desktop surfaces;
- four page-owned service/repository/connection chains;
- external user-data path logic;
- centralized SQLite connection configuration;
- additive compatibility migration code;
- explicit Repository and ProductService close capability;
- multi-commit non-atomic workflow structure;
- destructive reset behavior;
- source/frozen resource-path handling in code.

## Validation still required on the recovery branch

- deterministic closure of all four repositories during normal Qt shutdown;
- exact partial states under injected workflow failure;
- migration idempotence and failure behavior in isolated databases;
- reset behavior with active connections and WAL/SHM files;
- approved classification of seed rows;
- packaged inclusion and discovery of required SQL resources;
- exclusion of seed/live database/WAL/SHM from production artifacts;
- installed upgrade, uninstall, and reinstall data preservation;
- full human interactive desktop walkthrough.

## Historical main-branch evidence only

- successful PyInstaller one-folder build and frozen launch;
- seed-free production artifact behavior;
- blocked Inno Setup installer lifecycle.

These require current-branch revalidation before being promoted as contemporary execution evidence.

---

# 7. Highest Active Operational Risks

```text
P0  Validation touching ordinary user data
P1  Implicit application-wide shutdown ownership
P1  Confirmed multi-commit workflow non-atomicity
P1  Unresolved production seed policy
P2  Unversioned additive migration system
P2  Packaged SQL-resource inclusion and discovery
P2  Installed lifecycle data preservation
P2  Retained manual UI verification gaps
```

Operational risk does not itself authorize architecture redesign. Ownership changes, transaction policy, migration strategy, and production seed classification require Main/human and, where appropriate, Design reconciliation.

---

# 8. Immediate Next Execution Sequence

```text
1. Protect validation environment
   → isolated LOCALAPPDATA
   → no ordinary-user reset
   → close every Repository

2. Validate shutdown
   → construct all four pages
   → close application normally
   → confirm all repositories closed
   → confirm immediate database reopening and directory cleanup

3. Validate workflow failure states
   → inject failure after each receipt mutation
   → inspect Product, Purchase, and summary durability
   → repeat for purchase deletion/recalculation

4. Resolve seed policy
   → classify baseline defaults versus demonstration records
   → define production packaging inclusion

5. Validate migration and reset
   → repeated isolated connections
   → preserved user settings
   → active-connection and WAL/SHM reset behavior

6. Revalidate packaging when authorized
   → build current branch
   → inspect resources
   → launch from user-like location
   → compile installer when toolchain exists
   → validate installed lifecycle
```

Detailed commands and acceptance checks are maintained in `04_TODO.md`.

---

# 9. Recovery Route for Future Operational Chats

Use hierarchical recovery:

```text
1. Read this checkpoint.
2. Read 04_TODO.md for current execution detail.
3. Read 12_OPERATIONAL_MODEL.md only when exact rule or rationale is required.
4. Read DEV_STAGE/A_OPERATIONAL.md only for active staged evidence or precedent Cycle 05 failure context.
5. Read 11_OPERATIONAL_RECORD.md only when chronology or prior reconciliation history is required.
6. Inspect repository source or main-branch commits only when the above are insufficient or drift is suspected.
```

Do not begin with the full main-branch history unless a historical conflict requires it.

---

# 10. Checkpoint Exit Condition

The next Operational checkpoint refresh should occur when one or more of these materially changes:

- shutdown behavior is directly validated or corrected;
- transaction-boundary policy is accepted or implemented;
- seed policy is decided;
- migration strategy changes;
- current-branch packaging is rebuilt and validated;
- installed lifecycle evidence becomes available;
- Main closes the recovery cycle.

The Operational repopulation milestone is now eligible for observational recording because canon, derivative, and checkpoint recovery surfaces are all materialized and the temporary staging-name mismatch has been corrected.
