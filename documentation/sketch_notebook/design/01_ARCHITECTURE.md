# Architecture Notes

## Core Application Dependency Direction

Current MVP dependency direction:

```text
UI -> ProductService -> Repository -> database.py -> SQLite
```

Responsibilities:

```text
ProductService:
    business workflows, receipt registration, product lifecycle calculations,
    status classification.

Repository:
    SQL operations, persistence methods, row-to-model mapping, database access
    through database.py.

database.py:
    SQLite connection lifecycle, schema initialization, reset, database
    existence checks.

models.py:
    passive domain data structures.

contracts.py:
    abstract responsibility declarations.
```

The Repository import failure does not change this architecture. It indicates
that the concrete persistence adapter was malformed or missing from
`app/core/repository.py`.

## Presentation Styling Boundary

Core dependency direction remains:

```text
UI -> ProductService -> Repository -> database.py -> SQLite
```

Presentation styling belongs to the UI side of the architecture.

`ProductService` may return semantic business/application data, but should not
return Qt/PySide objects or display-only metadata such as `QColor`, `QBrush`,
text color, or background color.

PySide6/Shiboken warnings are UI binding signals unless evidence shows Qt
objects leaking into core layers. They should not be treated as architectural
proof by themselves.

## Packaging Resource Boundary

Core dependency direction remains:

```text
UI -> ProductService -> Repository -> database.py -> SQLite
```

Installed builds must separate bundled application resources from
user-writable runtime data.

`schema.sql` and `seed.sql` are application resources.

`market.sqlite` is user data.

User-facing navigation may simplify internal concepts without renaming internal
modules immediately. Storage, Shortage, and Market are domain/status
interpretations. In the simplified UI they may be presented as Inventory
sections or filters: In stock, Ending soon, and Buy again.
