# DEV_TRACK/A_OPERATIONAL.md

## 2026-07-07 — Operational Diagnosis: Repository ImportError

### Chat Authority

Operational Chat.

Perspective: execution.

### Requested Error

```text
ImportError: cannot import name 'Repository'
from app.core.repository
```

### Orientation Status

The requested methodology and orientation paths were consulted first, but the following files were not available at their requested repository paths during this session:

- `methodology/METHOD_FOUNDATIONS.md`
- `methodology/PROMOTION_RULES.md`
- `methodology/CHAT_BEHAVIOUR.md`
- `methodology/CHAT_PROTOCOL.md`
- `methodology/FLUX.md`
- `documentation/sketch_notebook/04_TODO.md`
- `documentation/sketch_notebook/10_ACTIONS.md`
- `documentation/sketch_notebook/11_OPERATIONAL_TRACKRECORD.md`

Diagnosis therefore proceeded from the implementation files required by the reported import error.

### Findings

`app/core/services.py` imports `Repository` from `app.core.repository` and instantiates it inside `ProductService.__init__`.

`app/core/repository.py` does not currently expose a module-level `Repository` class. The file begins directly with database connection helpers and then places repository-style methods under the `if __name__ == "__main__":` test block.

This means methods such as `create_product`, `update_product`, `get_product`, `get_products`, and purchase methods are not methods of an importable `Repository` class.

The most probable cause is structural drift or partial overwrite of `app/core/repository.py`: repository behavior exists textually, but it is not enclosed in the expected persistence abstraction.

### Files Requiring Inspection

Primary:

1. `app/core/repository.py`
2. `app/core/services.py`
3. `app/core/contracts.py`

Secondary, required before implementation completion:

4. `app/core/models.py`
5. `app/core/database.py`
6. `app/core/config.py`
7. `app/core/__init__.py`
8. UI entrypoints that construct `ProductService`

### Minimal Implementation Strategy

1. Repair `app/core/repository.py` only as the first implementation step.
2. Restore required imports at module top.
3. Define `class Repository` at module scope.
4. Prefer `class Repository(RepositoryContract)` if contract compatibility is currently valid.
5. Move persistence methods currently nested below `if __name__ == "__main__":` into `Repository`.
6. Add or restore repository lifecycle helpers:
   - `__init__`
   - `commit`
   - `close`
   - context manager methods if still intended
7. Add or restore row mapping helpers:
   - `row_to_product`
   - `row_to_purchase`
   - `row_to_category`
   - `row_to_store`
   - `row_to_promotion`
8. Fix `cursor_execute`; it currently appears to call itself recursively. It should delegate to `self.cursor.execute(sql, parameters)`.
9. Leave business logic in `services.py`; do not move SQL upward into the service layer.
10. Validate with:

```bash
python -c "from app.core.repository import Repository; print(Repository)"
```

Then:

```bash
python -c "from app.core.services import ProductService; service = ProductService(); print(service)"
```

Then run the application entrypoint.

### Risks

- `repository.py` may have additional missing imports or missing helper functions beyond the visible import failure.
- After `Repository` becomes importable, runtime may reveal schema/model mismatches.
- The current `cursor_execute` implementation risks infinite recursion if reached after class restoration.
- `RepositoryContract` may not cover all methods currently expected by `ProductService` or UI pages.
- Creating the requested DEV_TRACK file at `documentation/sketch_notebook/DEV_TRACK/A_OPERATIONAL.md` may coexist with an alternate notebook path under `app/documentation/...`; Main Chat should decide canonical location.

### Operational Status

Diagnosis staged.

No source-code implementation applied.

Waiting for Main Chat synthesis.
