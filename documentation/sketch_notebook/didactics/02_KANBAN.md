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

## Runtime data contracts and KeyError in StoragePage

Markers:

- &&& Mapping / associative array
- &&& Data contract
- &&& Interface expectation
- &&& Boundary
- &&& Separation of concerns
- &&& Presentation data vs business data
- &&& Defensive programming
- &&% Python dictionary
- &&% Dictionary key
- &&% KeyError
- &&% Direct dictionary lookup
- &&% Safe dictionary access
- &&% Stack trace
- &%% StoragePage initialization
- &%% Service-to-UI contract
- &%% Price variation semantics
- &%% Presentation metadata
- %%% PySide6 / Qt / Shiboken

Core explanation:

`KeyError: "color"` means Python tried to retrieve the key `"color"` from a
dictionary-like object, but that key was absent at runtime.

In Markei, `StoragePage` expected presentation metadata that `ProductService`
did not provide. This reveals an implicit service-to-UI contract mismatch.

Project connection:

`ProductService` currently returns price variation data as semantic/business
information: `delta`, `percentage`, and `text`.

`StoragePage` attempted to consume that result as if it also contained
presentation metadata: `color`.

The error teaches the difference between domain/business data and UI
presentation data.

## From developer-run script to user-run desktop application

Markers:

- &&& Script vs Application
- &&& Executable
- &&& Installer
- &&& User-Facing Interface
- &&& Developer Interface
- &&& Release Artifact
- &&& User Data Ownership
- %%% Dependency
- %%% Packaging
- %%% Frozen Python Application
- &%% Local Database
- &%% App Data Folder
- &%% Packaged Runtime
- &%% Runtime Path Contract

Core explanation:

A developer-run Markei assumes a Python environment, a repository folder,
installed packages, and terminal knowledge.

A user-run Markei should launch like a normal desktop app, hide Python startup
details, and store user data in a stable user-owned location.

Project connection:

Markei already has a PySide6 interface, but it still needs packaging-safe
runtime paths and user-data handling before it can be trusted as an installable
desktop application.
