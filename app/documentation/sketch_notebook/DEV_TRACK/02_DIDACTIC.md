# 02_DIDACTIC.md

> Authority: Didactic Chat
> Scope: Learning notes extracted from project debugging
> Status: Working didactic notebook

---

# ImportError learning sample: Repository export

## Source error

```text
ImportError: cannot import name 'Repository' from 'app.core.repository'
```

## Context

The service layer currently contains:

```python
from .repository import Repository
```

and later tries to instantiate:

```python
self.repository = Repository()
```

This means `services.py` expects the module `app.core.repository` to expose a top-level name called `Repository`.

The observed failure means Python successfully found the module `app.core.repository`, but after loading it, Python could not find a top-level object named `Repository` inside that module.

---

# 1. Python import resolution

When Python reads:

```python
from .repository import Repository
```

inside `app/core/services.py`, the leading dot means a relative import:

```text
current package: app.core
requested module: app.core.repository
requested exported name: Repository
```

Python performs two different steps:

1. Resolve and load the module `app.core.repository`.
2. Look inside that module namespace for the name `Repository`.

This distinction matters because the module can exist while the requested name does not.

In that case, the error is not:

```text
ModuleNotFoundError
```

but:

```text
ImportError: cannot import name ...
```

So this error teaches that Python imports are not just file lookup. They are also namespace lookup.

Marker: `&&%` Python import system.

---

# 2. Module vs class/function export

A module is a `.py` file loaded by Python.

A class or function is a name defined inside that module.

Example:

```python
# repository.py

class Repository:
    pass
```

This creates a module named `repository` and a module-level name named `Repository`.

Then this works:

```python
from .repository import Repository
```

But if `repository.py` contains only functions, misplaced indented methods, database helper functions, or a differently named class such as `ProductRepository`, then `Repository` is not exported as a top-level module name.

In Python, "export" usually just means:

```text
a name exists at module top level after the module is executed
```

There is no separate explicit export statement required for normal imports.

Marker: `&&%` module namespace.

---

# 3. Why `from .repository import Repository` fails

This import fails when `app/core/repository.py` does not define a top-level name called `Repository`.

The important sequence is:

```text
1. Python finds app/core/repository.py.
2. Python executes repository.py.
3. Python checks whether repository.Repository exists.
4. It does not.
5. ImportError is raised.
```

This also explains why the filename alone is insufficient. A file named `repository.py` does not automatically create a class named `Repository`.

For the current project, the architectural intent appears to be:

```text
ProductService
    ↓
Repository
    ↓
SQLite
```

So the code and the architecture agree that a repository object should exist. The failure indicates that `repository.py` is not currently shaped as the service layer expects.

The likely structural fix belongs to Operational/Design work:

```python
class Repository(RepositoryContract):
    ...
```

with repository methods indented inside that class, and with required imports restored at the top of `repository.py`.

Marker: `&%%` Markei repository structure.

---

# 4. KANBAN / glossary decision

## KANBAN decision

This deserves a Didactic KANBAN entry because it is a reusable debugging pattern:

```text
Symptom:
    ImportError: cannot import name X from module Y

Meaning:
    Python found module Y but did not find name X inside it.

Learning value:
    Distinguishes module resolution from object/name export.

Project relevance:
    Explains why service-layer imports depend on repository module structure.
```

Suggested learning status:

```text
Yellow → Green candidate
```

Reason: the concept is understandable now, but should become Green only after the operational patch is inspected and the student sees the repaired `Repository` class in context.

## Glossary decision

A glossary entry is useful for:

- module
- module namespace
- export / exported name
- relative import
- ImportError vs ModuleNotFoundError

These terms are foundational enough to recur throughout the project.

---

# Minimal didactic conclusion

This error does not mean Python cannot find `repository.py`.

It means Python can find `repository.py`, but `repository.py` does not currently provide the name `Repository` that `services.py` asks for.

The core lesson:

```text
Import path finds a module.
Imported name must exist inside that module.
```
