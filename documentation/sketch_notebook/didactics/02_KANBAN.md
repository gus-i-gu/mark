# Didactic KANBAN

## Python import surfaces and Repository boundary

Markers:

- &&% Python import system
- &&% module namespace
- &&% exported symbol
- &&% class declaration
- &&& Repository Pattern
- &&& Interface / Contract
- &%% RepositoryContract
- &%% ProductService-to-Repository dependency

Core explanation:

`from .repository import Repository` requires `repository.py` to expose a
top-level symbol named `Repository`.

If `repository.py` exists but does not define that symbol, Python raises
`ImportError: cannot import name`.

This differs from `ModuleNotFoundError`, where Python cannot find the module
path itself.

Engineering implication:

The import surface of a module must match the architecture expected by dependent
layers.

In Markei, `ProductService` expects a concrete repository object. The repository
module must therefore export a concrete implementation compatible with
`RepositoryContract`.
