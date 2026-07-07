# Glossary

## module

A Python file loaded as an importable unit.

## module namespace

The set of top-level names available inside a loaded module.

## symbol

A name that points to a Python object, such as a class, function, or constant.

## exported symbol

A module-level name that another module can import.

## top-level name

A name declared at module indentation level, not inside a function, class, or
execution block.

## class declaration

Python syntax that creates a class object and binds it to a name.

## relative import

An import that resolves from the current package, such as
`from .repository import Repository`.

## ImportError

An import failure that can occur after Python finds a module but cannot retrieve
the requested name.

## ModuleNotFoundError

An import failure where Python cannot find the requested module path.

## Repository Pattern

A persistence boundary that hides SQL and storage details behind methods used by
the service layer.

## RepositoryContract

The Markei contract describing required repository responsibilities.

## contract/interface

An abstract responsibility declaration that dependent code can rely on.

## concrete implementation

Executable code that satisfies a contract, such as `Repository`.

## service layer

The business orchestration layer. In Markei, this is `ProductService`.

## persistence layer

The layer that owns SQL, database access, and row-to-model reconstruction.

## refactor drift

A mismatch introduced when code structure changes but dependent import surfaces
or contracts are not updated consistently.

## dependency direction

The intended direction of calls between layers:
`ProductService -> Repository -> database.py -> SQLite`.
