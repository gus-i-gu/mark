# [D] Session 001 | 09:45_07_07_2026 | Markei

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Design Chat

Responsibility: architecture, domain boundaries, responsibility allocation, abstractions, and long-term maintainability.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BOOTSTRAP STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Read successfully:

- AGENTS.md
- documentation/sketch_notebook/INDEX.md
- documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
- documentation/sketch_notebook/methodology/PROMOTION_RULES.md
- documentation/sketch_notebook/methodology/FLUX.md

Bootstrap inconsistency observed:

- documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md returned 404.
- documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md returned 404.

Design implication:

The methodology boot sequence is partially unavailable in the repository. This does not change the application architecture diagnosis below, but Main Chat should verify whether these methodology files are intentionally absent, renamed, or not yet materialized.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROBLEM ANALYSED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ImportError:

    cannot import name 'Repository' from 'app.core.repository'

Relevant dependency:

    app/core/services.py
        imports Repository from app.core.repository
        instantiates Repository inside ProductService.__init__

Observed repository state:

    app/core/repository.py
        does not expose a visible top-level Repository class at the beginning of the file.
        begins with database connection functions.
        contains repository-like methods later in the file, but they appear structurally displaced / indented under an execution block rather than owned by a class declaration.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ARCHITECTURAL DIAGNOSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

The immediate import error is not merely an import typo. It indicates a broken architectural boundary between the business layer and the persistence layer.

The intended architecture, as described by services.py, is:

    UI
    ↓
    ProductService
    ↓
    Repository
    ↓
    SQLite

In that structure:

- ProductService owns workflows and business rules.
- Repository owns persistence operations and SQL access.
- database.py owns SQLite connection creation, schema initialization, and low-level database configuration.
- models.py owns domain data structures.
- contracts.py owns abstract responsibility declarations.

The current implementation violates that intended structure because repository.py appears to contain database-manager responsibilities and repository method fragments without exporting the concrete Repository abstraction expected by ProductService.

Therefore, the import failure is a symptom of a deeper design inconsistency:

    The concrete persistence adapter expected by the service layer is missing or malformed.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INTENDED STRUCTURE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

The intended structure should be:

    app/core/database.py
        SQLite lifecycle only:
        - configure connection
        - initialize database
        - connect
        - close
        - reset
        - database_exists

    app/core/repository.py
        Concrete Repository implementation only:
        - class Repository(RepositoryContract)
        - __init__ opens connection through database.connect()
        - cursor belongs to Repository instance
        - commit / close / context-manager support
        - CRUD and query methods for products, purchases, categories, stores, promotions
        - row_to_product / row_to_purchase / row_to_category / row_to_store / row_to_promotion mapping helpers
        - no database initialization logic duplicated from database.py

    app/core/services.py
        Business orchestration only:
        - class ProductService(ServiceContract)
        - register_receipt workflow
        - recalculate_product
        - status classification
        - price / duration calculations
        - no SQL
        - no sqlite3 cursor access

    app/core/models.py
        Domain entities only:
        - Product
        - Purchase
        - Category
        - Store
        - Promotion, if supported by repository/schema

    app/core/contracts.py
        Abstract responsibility declarations only:
        - ProductContract
        - PurchaseContract
        - RepositoryContract
        - ServiceContract

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RESPONSIBILITY ALLOCATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Correct responsibility allocation:

1. database.py

Should be the infrastructure gateway for SQLite connection lifecycle.

It should not know Product, Purchase, Repository, or business workflows.

2. repository.py

Should be the concrete persistence adapter.

It should know:

- SQL
- sqlite3 rows
- database schema
- model reconstruction from rows

It should not know:

- reorder business meaning
- shortage / market status classification
- purchase prediction rules
- UI presentation

3. services.py

Should be the business application layer.

It may coordinate repository operations and calculate domain summaries.

It should not know:

- SQL
- sqlite3
- cursors
- row factories

4. models.py

Should remain passive domain structures.

It should not execute queries or perform persistence.

5. contracts.py

Should describe layer expectations, but should not replace concrete implementation.

The contract currently establishes the idea of RepositoryContract, but repository.py must provide the concrete Repository class that satisfies it.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ARCHITECTURAL CONSISTENCY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Consistent elements already present:

- services.py explicitly documents that ProductService should coordinate Repository and never execute SQL.
- contracts.py defines RepositoryContract as the lowest persistence layer and says it contains SQL only.
- database.py documents itself as a Database Manager and correctly excludes business logic, Product knowledge, and Repository knowledge.
- models.py documents itself as domain models without SQL or database manipulation.

Inconsistent elements:

- repository.py appears to duplicate database.py connection responsibilities.
- repository.py does not currently expose the concrete Repository class required by services.py.
- repository-like methods appear after an `if __name__ == "__main__"` block, which makes them local functions rather than class methods if the indentation is exactly as fetched.
- repository.py contains a recursive `cursor_execute` implementation at the end, calling itself instead of delegating to `self.cursor.execute(...)`.
- ProductService depends on Repository as a stable abstraction, but the concrete adapter is structurally absent.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DESIGN DECISIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Decision candidate 1 — Keep Repository as a concrete adapter.

The application should keep `ProductService -> Repository -> database.py -> SQLite` as the main dependency chain.

Do not move SQL into services.py.

Do not make database.py perform domain queries.

Decision candidate 2 — Remove duplicated database lifecycle code from repository.py.

Repository should import connection lifecycle functions from database.py instead of redefining them.

Recommended dependency:

    from .database import connect, close

Decision candidate 3 — Restore Repository as a class, not as free functions.

Repository should be a top-level class:

    class Repository(RepositoryContract):
        ...

All persistence methods currently intended to use `self` should live inside that class.

Decision candidate 4 — Keep row mapping inside Repository for now.

Mapping sqlite3.Row to dataclasses is a persistence concern. Until the project grows, separate mapper files are unnecessary.

Decision candidate 5 — Preserve ProductService as the business boundary.

The current ProductService responsibilities are architecturally appropriate. The repair should avoid changing service workflows unless method names or repository signatures require alignment.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DESIGN PROPOSALS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Proposal A — Minimal structural repair

1. Rebuild app/core/repository.py around a top-level Repository class.
2. Import RepositoryContract from contracts.py.
3. Import domain models from models.py.
4. Import connect from database.py.
5. Implement __init__ with:

       self.connection = connect()
       self.cursor = self.connection.cursor()

6. Ensure all existing repository methods are class methods.
7. Add commit and close methods if absent.
8. Fix cursor_execute to call:

       return self.cursor.execute(sql, parameters)

9. Keep services.py unchanged unless signatures fail.

Proposal B — Boundary cleanup after minimal repair

After the import error is fixed and runtime is validated:

1. Audit repository.py for database-manager duplication.
2. Remove duplicate connect/reset/initialize functions from repository.py.
3. Keep database.py as the only database lifecycle module.
4. Add a small import smoke test for ProductService.
5. Add a small repository construction test.

Proposal C — Contract alignment

RepositoryContract currently declares only part of the behavior used by ProductService.

After the immediate bug is fixed, Main Chat may decide whether to:

- keep RepositoryContract minimal;
- expand it to include all methods ProductService relies on;
- or postpone contract strictness until the MVP stabilizes.

Design recommendation: postpone broad contract expansion until the concrete Repository is stable.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STRUCTURAL RISKS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Risk 1 — Broken class boundary

If repository methods remain outside a concrete Repository class, every service workflow depending on `Repository()` will fail.

Risk 2 — Layer collapse

If the fix copies SQL into services.py, the architecture will lose its intended separation between business orchestration and persistence.

Risk 3 — Database lifecycle duplication

Duplicating connect/reset/initialize logic in both database.py and repository.py creates drift and makes later database changes harder.

Risk 4 — Recursive cursor helper

The current cursor_execute shape appears recursive. If it becomes reachable, repository calls may fail with recursion rather than executing SQL.

Risk 5 — Contract theatre

Contracts are useful only if the concrete implementation exists and matches the service dependency. RepositoryContract without Repository gives the appearance of architecture while leaving the executable boundary broken.

Risk 6 — Methodology path drift

The task references some older/missing paths and required methodology files are absent. This indicates notebook synchronization risk separate from the application bug.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FILES INSPECTED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

- AGENTS.md
- documentation/sketch_notebook/INDEX.md
- documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
- documentation/sketch_notebook/methodology/PROMOTION_RULES.md
- documentation/sketch_notebook/methodology/FLUX.md
- documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
- documentation/sketch_notebook/04_TODO.md
- documentation/sketch_notebook/10_ACTIONS.md
- app/core/repository.py
- app/core/services.py
- app/core/database.py
- app/core/contracts.py
- app/core/models.py

Missing / unavailable during inspection:

- documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
- documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
- documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md before this write
- documentation/sketch_notebook/04_TODO.md
- documentation/sketch_notebook/10_ACTIONS.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MAIN CHAT SYNTHESIS REQUEST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Main Chat should synthesize this with the Operational Chat report before materialization.

Recommended Main synthesis direction:

1. Treat the ImportError as a malformed Repository implementation, not as a service-layer problem.
2. Approve a minimal Codex materialization stage for repository.py only if Operational evidence agrees.
3. Preserve the intended architecture:

       ProductService -> Repository -> database.py -> SQLite

4. Avoid service-layer workaround patches.
5. Decide separately whether missing methodology files require a methodology materialization task.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STAGING RESULT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

File updated:

- documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md

Commit scope:

- This file only.
