# [M] Session 001 | 10:05_07_07_2026 | Markei

# D_OPS_STAGE — Main Operational Materialization Stage

> Source stages:
> - `DEV_STAGE/A_OPERATIONAL.md`
> - `DEV_STAGE/B_DIDACTIC.md`
> - `DEV_STAGE/C_DESIGN.md`
>
> Purpose: Codex-ready operational patch brief.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Synthesis

The three functional perspectives agree on the same operational conclusion.

The runtime error:

```text
ImportError: cannot import name 'Repository' from app.core.repository
```

is caused by `app/core/services.py` expecting `app.core.repository` to expose a module-level symbol named `Repository`, while `app/core/repository.py` does not currently define/export a visible top-level `Repository` class.

Operational and Design reports both indicate that repository-like persistence methods appear structurally displaced, likely under an `if __name__ == "__main__":` block or otherwise outside the expected class boundary.

Didactic analysis confirms the Python-level interpretation: the module is found, but the requested symbol is missing.

This is an implementation-structure failure in `app/core/repository.py`, not a service-layer design problem.

---

# 2. Main Operational Decision

Do not patch `services.py` as the first response.

Do not move SQL into `services.py`.

Restore the persistence adapter expected by the service layer.

Approved minimal operational direction:

```text
Rebuild app/core/repository.py around a top-level Repository class.
```

The repository class should satisfy or align with `RepositoryContract` where possible.

---

# 3. Required Pre-Patch Cleanup

Before any application patch, Codex must check for conflict markers in stage files.

Search for:

```text
<<<<<<<
=======
>>>>>>>
```

especially in:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

If conflict markers remain, Codex should remove only the markers while preserving both useful staged reports sequentially.

This cleanup is notebook hygiene and should happen before implementation.

---

# 4. Codex Prompt — Operational Implementation

Codex, read first:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/FLUX.md
```

Do not modify:

```text
documentation/sketch_notebook/methodology/
```

Task:

1. Inspect:

```text
app/core/repository.py
app/core/services.py
app/core/contracts.py
app/core/models.py
app/core/database.py
database/schema.sql
```

2. Repair `app/core/repository.py` so that this succeeds:

```python
from app.core.repository import Repository
```

3. Prefer this structure unless inspection proves it incompatible:

```python
from .contracts import RepositoryContract
from .database import connect
from .models import Category, Product, Purchase, Store

class Repository(RepositoryContract):
    def __init__(self):
        self.connection = connect()
        self.cursor = self.connection.cursor()
```

4. Move or restore persistence methods into `Repository` as instance methods.

5. Add or repair helpers required by existing methods:

```text
commit
close
cursor_execute
row_to_product
row_to_purchase
row_to_category
row_to_store
```

6. Fix any recursive `cursor_execute` implementation so it delegates to:

```python
self.cursor.execute(sql, parameters)
```

7. Do not expand the feature set.

8. Defer promotion-specific repository behavior unless the required model/schema exists.

9. Keep `services.py` unchanged unless import/signature alignment strictly requires a minimal adjustment.

---

# 5. Required Validation Commands

After patching, run:

```bash
python -m compileall app
```

Then:

```bash
python -c "from app.core.repository import Repository; print(Repository)"
```

Then:

```bash
python -c "from app.core.services import ProductService; service = ProductService(); print(type(service.repository)); service.close()"
```

If available:

```bash
python -m app.main
```

Report all command outputs.

---

# 6. Expected Codex Report

Codex must report:

1. files changed;
2. exact repository structure chosen;
3. whether `RepositoryContract` was used;
4. validation commands run;
5. command outputs;
6. remaining risks.
