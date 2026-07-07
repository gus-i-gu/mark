# DEV_TRACK — C_DESIGN

## 2026-07-07 — Design Evaluation: ProductService Repository Boundary

### Scope

Design Chat evaluated whether `app/core/services.py` should depend on:

- a concrete `Repository` class;
- module-level repository functions;
- or another persistence abstraction.

Only this DEV_TRACK staging file was updated. Permanent notebook files were not modified.

### Methodological context read

Available and read:

- `app/documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md`
- `app/documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`
- `app/documentation/sketch_notebook/methodology/PROMOTION_RULES.md`

Observed repository state:

- `PROMOTION_RULES.md` currently exists but is empty.
- `METHOD_FOUNDATIONS.md` was not found at the requested path or under the discovered `app/documentation/sketch_notebook/methodology/` prefix.
- `FLUX.md` was not found at the requested path or under the discovered `app/documentation/sketch_notebook/methodology/` prefix.

### Orientation files

The requested endpoint file was not found at:

- `documentation/sketch_notebook/03_DECISIONS.md`
- `app/documentation/sketch_notebook/03_DECISIONS.md`

The optional design/domain files were also not found at the discovered notebook prefix:

- `app/documentation/sketch_notebook/01_ARCHITECTURE.md`
- `app/documentation/sketch_notebook/05_DOMAIN_MODEL.md`

Therefore this design evaluation is based on the available methodology files and current code contracts.

### Architectural diagnosis

`app/core/services.py` already declares a layered architecture:

```text
UI
→ ProductService
→ Repository
→ SQLite
```

The service layer is explicitly described as the business orchestration layer. It coordinates repository operations, enforces business rules, registers receipts, maintains product lifecycle state, recalculates product summaries, and exposes application services to the UI.

The same file explicitly says that the service layer must not:

- execute SQL;
- know SQLite;
- manipulate database cursors.

This means `services.py` should not import and coordinate low-level persistence functions directly if doing so would expose database mechanics to the service layer.

`app/core/contracts.py` reinforces the same boundary:

- `RepositoryContract` is the lowest persistence layer and contains SQL only.
- `ServiceContract` is the business layer, has no SQL, and coordinates repository operations.

Therefore the intended architecture is object-oriented service orchestration over a persistence abstraction.

### Evaluation of dependency options

#### Option 1 — `services.py` imports a concrete `Repository` class

This matches the current implementation intent.

`ProductService.__init__()` currently does:

```python
self.repository = Repository()
```

and the service methods call repository object methods such as:

- `get_products()`
- `get_product()`
- `get_purchases()`
- `create_product()`
- `update_product()`
- `insert_purchase()`
- `delete_product()`
- `delete_purchase()`

This is coherent with `RepositoryContract`, which defines repository behavior as object methods.

#### Option 2 — `services.py` imports repository functions

This is not the preferred design.

Function imports would flatten the boundary between the service layer and persistence module. It would also move the code away from the existing `RepositoryContract` / `ServiceContract` model.

Repository helper functions may exist internally inside `repository.py`, especially for connection setup, reset, and database initialization. However, application persistence operations should remain behind a repository object.

#### Option 3 — `services.py` imports another abstraction

Long-term, the cleanest abstraction is not necessarily the concrete class itself, but a repository interface/contract.

Recommended future direction:

```python
class ProductService(ServiceContract):
    def __init__(self, repository: RepositoryContract | None = None):
        self.repository = repository or Repository()
```

This would preserve the simple default runtime behavior while allowing tests or future persistence implementations to inject another repository object.

However, this is a refinement, not the minimal fix required for the current ImportError.

### ImportError classification

The ImportError reflects an implementation bug, not an architectural inconsistency.

Current `services.py` imports:

```python
from .repository import Repository
```

and instantiates:

```python
self.repository = Repository()
```

That is architecturally consistent with the service/repository boundary.

The inconsistency is in `app/core/repository.py`:

- the file begins with database helper functions;
- no module-scope `class Repository` is visible;
- repository-style methods such as `create_product` appear nested under `if __name__ == "__main__":`;
- therefore the module does not export the name `Repository` that `services.py` imports.

So the failure is best classified as repository implementation drift or structural corruption of the repository module.

### Design decision proposal

Adopt the following design decision for Main Chat synthesis:

`services.py` should depend on a repository object, preferably through `RepositoryContract`, with `Repository` as the default concrete SQLite implementation.

Do not convert `services.py` to direct module-level persistence-function imports.

The canonical dependency direction should remain:

```text
ProductService
→ RepositoryContract-compatible repository object
→ SQLite repository implementation
→ sqlite3/database helpers
```

### Required repository changes

Implementation should be handled by Operational Chat / Codex, but the required structural changes are:

1. Restore or create a module-scope `class Repository(RepositoryContract)` in `app/core/repository.py`.
2. Add the missing top-level imports required by that module, including `sqlite3`, model types, config/database helpers, and `RepositoryContract` as needed.
3. Keep database lifecycle helpers such as `connect`, `close`, and `reset` as module-level helpers if useful.
4. Move persistence methods out of the `if __name__ == "__main__":` block and into the `Repository` class.
5. Ensure `Repository` owns connection/cursor state or otherwise clearly owns persistence access.
6. Ensure methods expected by `ProductService` and `RepositoryContract` exist on the class.
7. Add/restore lower-level helper methods used by the repository implementation, such as `cursor_execute`, `commit`, `row_to_product`, and `row_to_purchase` if they are required by the existing method bodies.
8. Validate that `from .repository import Repository` succeeds before running the UI.

### Status

Design decision staged for Main Chat synthesis.

Permanent notebook files were not modified.

Implementation is not performed in this Design Chat pass.
