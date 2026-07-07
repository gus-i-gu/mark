# Design Decisions

## Preserve the Repository Object Boundary

Status: Accepted for current MVP repair.

Context:

`services.py` imports and instantiates `Repository`, but `repository.py` did not
expose a top-level `Repository` class.

Decision:

Restore a concrete `Repository` class in `app/core/repository.py`, compatible
with `RepositoryContract`.

Consequences:

- The service layer remains free of SQL.
- The repository layer remains the persistence adapter.
- `database.py` remains responsible for SQLite lifecycle.
- Later dependency injection may allow `ProductService(repository:
  RepositoryContract | None = None)`.
