4. DEV_TRACK/03_DESIGN.md update

I could not update DEV_TRACK/03_DESIGN.md directly because the requested notebook paths returned 404 in GitHub. I checked these likely paths and they were not found:

documentation/sketch_notebook/01_ARCHITECTURE.md
documentation/sketch_notebook/03_DECISIONS.md
documentation/sketch_notebook/DEV_TRACK/03_DESIGN.md
DEV_TRACK/03_DESIGN.md
documentation/DEV_TRACK/03_DESIGN.md

Use this staged update:

## Design Note — Repository Boundary and ProductService Dependency

### Context

`app/core/services.py` imports `Repository` from `app.core.repository` and instantiates it inside `ProductService`.

Current runtime failure:

```text
ImportError: cannot import name 'Repository' from 'app.core.repository'
Architectural evaluation

The intended architecture remains layered:

UI
→ ProductService
→ Repository
→ SQLite

ProductService should coordinate workflows and business rules. It must not execute SQL, know SQLite details, or manipulate cursors.

The repository layer should own persistence operations and SQL mapping.

Decision

A concrete Repository class should exist.

services.py should not be converted to direct function imports from repository.py.

The correct design is:

keep database helper functions module-level if useful;
define class Repository(RepositoryContract) in app/core/repository.py;
move persistence operations into that class;
let ProductService depend on the repository object;
optionally later inject RepositoryContract into ProductService.__init__.
Reason

The current services.py already follows the intended object-based repository architecture.

The defect is structural drift in repository.py: repository methods exist in form, but no exported Repository class currently owns them.

Minimal design patch
Inspect app/core/repository.py.
Restore or create class Repository(RepositoryContract).
Move product and purchase persistence methods into the class.
Keep connect, close, and reset as module-level helpers.
Ensure from .repository import Repository succeeds.
Do not move SQL into services.py.
Status

Design decision staged.

Implementation belongs to Operational Chat / Codex.