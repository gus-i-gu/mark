# DEV_TRACK/01_OPERATIONAL.md

## 2026-07-07 — Operational Diagnosis: Repository ImportError

### Trigger

Runtime error:

```text
ImportError: cannot import name 'Repository' from 'app.core.repository'
```

### Suspected Cause

`app/core/services.py` imports `Repository` from `app.core.repository` and instantiates it inside `ProductService.__init__`, but `app/core/repository.py` does not currently define an importable `Repository` class.

The repository file appears structurally corrupted or partially overwritten:

- It begins directly with database connection functions.
- Required imports are absent from the visible top of the file.
- Repository-style product and purchase methods are nested under `if __name__ == "__main__":` instead of inside `class Repository`.
- Therefore `from .repository import Repository` fails during module import.

### Files To Inspect

1. `app/core/repository.py`
2. `app/core/services.py`
3. `app/core/contracts.py`
4. `app/core/models.py`
5. `app/core/database.py`
6. `app/core/config.py`
7. `app/core/__init__.py`
8. UI/service entrypoints that import `ProductService`

### Minimal Patch Plan

1. Restore `app/core/repository.py` module header imports.
2. Define `class Repository` at module scope.
3. Move repository methods currently nested under `if __name__ == "__main__":` into `class Repository`.
4. Add/restore `__init__`, cursor helpers, `commit`, `close`, `row_to_product`, and `row_to_purchase` methods.
5. Keep database lifecycle helpers (`connect`, `close`, `reset`) as module-level functions only if they are intentionally part of the database access layer.
6. Re-run the import check:

```bash
python -c "from app.core.repository import Repository; print(Repository)"
```

7. Re-run service construction:

```bash
python -c "from app.core.services import ProductService; service = ProductService(); print(service)"
```

8. Then run the app entrypoint.

### Operational Classification

This is not primarily a business-logic bug. It is a module/class boundary failure caused by repository structure drift.

### Status

Staged for Codex implementation.
