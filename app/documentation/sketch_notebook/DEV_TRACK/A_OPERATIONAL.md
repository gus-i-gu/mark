4. DEV_TRACK/01_OPERATIONAL.md update

This update already exists in the repository. It records the same diagnosis: services.py imports Repository, but repository.py does not define an importable Repository class; methods are nested under if __name__ == "__main__":; and the recommended fix is to restore the class boundary and move methods into it.

Current staged operational entry:

## 2026-07-07 — Operational Diagnosis: Repository ImportError

### Trigger

Runtime error:

ImportError: cannot import name 'Repository' from 'app.core.repository'

### Suspected Cause

app/core/services.py imports Repository from app.core.repository and instantiates it inside ProductService.__init__, but app/core/repository.py does not currently define an importable Repository class.

The repository file appears structurally corrupted or partially overwritten:
- It begins directly with database connection functions.
- Required imports are absent from the visible top of the file.
- Repository-style product and purchase methods are nested under if __name__ == "__main__" instead of inside class Repository.
- Therefore from .repository import Repository fails during module import.

### Operational Classification

This is not primarily a business-logic bug. It is a module/class boundary failure caused by repository structure drift.

### Status

Staged for Codex implementation.

I would keep that entry, but change the final status after patching to:

### Status

Implementation required in `app/core/repository.py`.

Next operational step:
restore `Repository` as a module-scope class, move persistence methods into it, fix `cursor_execute`, and validate imports before running the UI.

The attached CS & Coding methodology emphasizes that debugging should expose architectural reasoning and that knowledge should precede modification, which fits this diagnosis: first identify the broken layer boundary, then patch.