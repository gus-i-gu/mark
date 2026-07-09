# 07_GLOSSARY.md

> Scope: Project learning glossary
> Status: Working glossary

---

# Python import glossary entries

## Module

Marker: `&&%`

A Python file loaded as a unit of code.

Example:

```text
app/core/repository.py
```

can be imported as:

```text
app.core.repository
```

A module is not the same thing as a class. The file `repository.py` may exist even if no class named `Repository` exists inside it.

---

## Module namespace

Marker: `&&%`

The collection of names created inside a module after Python executes it.

Example:

```python
class Repository:
    pass
```

creates the name `Repository` in the module namespace.

Then this can work:

```python
from .repository import Repository
```

If the name is absent, the import fails even when the file exists.

---

## Exported name

Marker: `&&%`

A practical term for a top-level name that another module can import.

Python usually does not require an explicit export declaration. A name is importable when it exists at module top level after the module loads.

Example:

```python
# repository.py

class Repository:
    pass
```

exports `Repository` in the normal Python sense.

---

## Relative import

Marker: `&&%`

An import that starts from the current package instead of from the global Python path.

Example inside `app/core/services.py`:

```python
from .repository import Repository
```

means:

```text
from app.core.repository import Repository
```

The dot means "look beside me inside the same package".

---

## ImportError

Marker: `&&%`

An error raised when Python can resolve the module path but cannot complete the requested import.

In this sample:

```text
ImportError: cannot import name 'Repository' from 'app.core.repository'
```

means:

```text
The module app.core.repository exists, but the name Repository was not available inside it.
```

---

## ModuleNotFoundError

Marker: `&&%`

An error raised when Python cannot find the requested module itself.

Contrast:

```text
ModuleNotFoundError
    Python cannot find the module/file/package.

ImportError: cannot import name
    Python found the module, but the requested name is missing.
```

---

## Repository

Marker: `&%%`

In Markei, the Repository is intended to be the persistence-facing object used by the service layer.

Expected relationship:

```text
ProductService
    ↓
Repository
    ↓
SQLite
```

Therefore, when `services.py` imports `Repository`, the file `repository.py` must define a top-level class or compatible object called `Repository`.
