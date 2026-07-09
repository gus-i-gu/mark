# Materialization Stage — Didactic

## 1. Scope

This stage gives Codex didactic reporting instructions for the Product View refactor. The permanent didactic domain files are left for [A] after Codex reports are available.

## 2. Source Inputs

- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- Main synthesis: purchase rhythm and shelf-life rhythm remain separate.
- Human correction: use uniform `expiration_date`; include PRAGMA as a future didactic concept.

## 3. Didactic Invariants

- Same technical type does not imply same domain meaning.
- `average_duration_days` is purchase-to-purchase rhythm.
- `average_shelf_life_days` is purchase-to-expiration rhythm.
- `expected_next_purchase` belongs to purchase rhythm.
- `expected_expiration_date` is a product-level cached summary field for future market/product analysis.
- Current end-user display primarily depends on purchase-level `expiration_date`.
- `expiration_date` on Purchase is raw historical/batch data.
- `average_shelf_life_days` is calculated data.
- Average price is derived from collected purchase prices for this milestone.
- Product View is a display contract and should not own business calculation.

## 4. Concepts to Report for [A]

Report these in `H_DDC_CODEX.md` as didactic evidence/candidates:

- `&&&` Semantic field distinction
- `&&&` Raw data versus derived data
- `&&&` Naming as data contract
- `&&&` Cached summary field
- `&%%` Product summary state in Markei
- `&%%` Purchase rhythm versus shelf-life rhythm
- `&%%` Product View read model
- `&%%` Service-owned calculation responsibility
- `&%%` Repository result shape
- `&&%` Dataclass field evolution
- `&&%` Optional values / nullable fields in Python models
- `%%%` SQLite schema evolution
- `%%%` SQLite PRAGMA
- `%%%` PySide6 widget composition, if UI widget work is performed

## 5. PRAGMA Note for H_DDC_CODEX.md

If migration uses `PRAGMA table_info`, include a brief learner-facing note:

- PRAGMA is a SQLite command family for database metadata and settings.
- `PRAGMA table_info(table_name)` returns information about a table's columns.
- Here it checks whether migration columns already exist before `ALTER TABLE` runs.

[A] will later decide whether this becomes a `%%%` KANBAN concept.

## 6. H_DDC_CODEX.md Report Shape

After materialization, write `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md` with:

- Source stage files
- Coding concepts exposed
- Concept candidates by marker
- Naming / semantic distinctions preserved
- Raw data vs derived data evidence
- Service vs repository vs UI responsibility evidence
- PRAGMA note
- Didactic risks or confusions remaining
- Suggested [A] follow-up

Keep the report compact. Do not reproduce long code.

## 7. Didactic Domain Absorption Later

Later [A] may absorb this report into:

- `documentation/sketch_notebook/didactics/02_KANBAN.md`
- `documentation/sketch_notebook/didactics/07_GLOSSARY.md`
- `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`
- `documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md`
