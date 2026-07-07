# [M] Session 001 | 10:05_07_07_2026 | Markei

# E_DDC_STAGE — Main Didactic Materialization Stage

> Source stages:
> - `DEV_STAGE/B_DIDACTIC.md`
>
> Purpose: Codex-ready didactic notebook update brief.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Didactic Synthesis

The Repository ImportError is a strong learning sample because it connects a Python language mechanism with project architecture.

The error:

```text
ImportError: cannot import name 'Repository' from app.core.repository
```

teaches that Python can successfully locate a module while still failing to retrieve a requested top-level symbol from that module.

In this case:

```text
app.core.repository
```

is found, but:

```text
Repository
```

is not available in that module namespace.

The project-level lesson is that import surfaces must remain aligned with architectural expectations.

`ProductService` expects a repository object. `RepositoryContract` describes the repository responsibility. `repository.py` must expose a concrete implementation that matches both.

---

# 2. Didactic Promotions Approved

Create or update permanent didactic material under:

```text
documentation/sketch_notebook/didactics/
```

Do not modify methodology files.

Approved didactic content:

1. A KANBAN/note explaining Python import resolution:
   - module discovery;
   - module namespace;
   - symbol lookup;
   - top-level exported names.

2. A KANBAN/note explaining the Repository Pattern in Markei:
   - `ProductService -> Repository -> SQLite`;
   - service layer should not know SQL;
   - repository owns persistence operations.

3. A glossary cluster containing:
   - module;
   - namespace;
   - symbol;
   - exported symbol;
   - top-level name;
   - class declaration;
   - relative import;
   - ImportError;
   - ModuleNotFoundError;
   - Repository;
   - RepositoryContract;
   - contract/interface;
   - concrete implementation;
   - service layer;
   - persistence layer;
   - refactor drift;
   - dependency direction.

---

# 3. Codex Prompt — Didactic Materialization

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

Create or update didactic files under:

```text
documentation/sketch_notebook/didactics/
```

Use the staged material in:

```text
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
```

Recommended files if they do not yet exist:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

If these files already exist, append/update conservatively.

Do not invent a large didactic system.

Keep the first materialization focused on this learning sample.

---

# 4. Suggested KANBAN Entry

Add a KANBAN-style entry titled:

```text
Python import surfaces and Repository boundary
```

Markers:

```text
&&% Python import system
&&% module namespace
&&% exported symbol
&&% class declaration
&&& Repository Pattern
&&& Interface / Contract
&%% RepositoryContract
&%% ProductService-to-Repository dependency
```

Core explanation:

```text
`from .repository import Repository` requires `repository.py` to expose a top-level symbol named `Repository`.

If `repository.py` exists but does not define that symbol, Python raises `ImportError: cannot import name`.

This differs from `ModuleNotFoundError`, where Python cannot find the module path itself.
```

Engineering implication:

```text
The import surface of a module must match the architecture expected by dependent layers.

In Markei, ProductService expects a concrete repository object. The repository module must therefore export a concrete implementation compatible with RepositoryContract.
```

---

# 5. Suggested Glossary Entries

Add concise glossary entries for:

```text
module
module namespace
symbol
exported symbol
top-level name
class declaration
relative import
ImportError
ModuleNotFoundError
Repository Pattern
RepositoryContract
contract/interface
concrete implementation
service layer
persistence layer
refactor drift
dependency direction
```

Each entry should be short, project-contextual, and readable for future learning sessions.

---

# 6. Suggested Concept Map Update

Add relationships similar to:

```text
Python import system
    -> module namespace
    -> exported symbol
    -> class declaration

Repository Pattern
    -> service layer
    -> persistence layer
    -> RepositoryContract
    -> concrete implementation

ImportError
    -> module found but symbol missing

ModuleNotFoundError
    -> module path not found
```

---

# 7. Expected Codex Report

Codex must report:

1. didactic files created/updated;
2. whether content was appended or newly created;
3. glossary entries added;
4. KANBAN entries added;
5. concept map updates;
6. unresolved didactic risks.
