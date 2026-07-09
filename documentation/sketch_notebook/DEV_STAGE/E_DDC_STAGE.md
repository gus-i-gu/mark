# Materialization Stage — Didactic

## 1. Scope

This stage gives Codex didactic reporting instructions for Cycle 02: History UI page and Settings page. Codex must preserve learning evidence for [A] but must not promote permanent didactic memory in this pass.

## 2. Source Inputs

- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- Main Chat synthesis for Cycle 02.

## 3. Didactic Invariants

Codex should preserve these learning distinctions in its H report:

- Grouping is not sorting.
- Time bucketing assigns records to periods according to boundary rules.
- Total rows are derived aggregate data, not raw purchase facts.
- Settings configuration is durable application state that changes later interpretation.
- A simple key/value settings table is a persistence pattern, not a business domain table.
- Repository result shape should expose clear purchase/time/store facts.
- Service owns grouping, bucketing, aggregate meaning, and History read-model assembly.
- UI renders grouped data and editable settings forms.
- Store editing in Settings continues Cycle 01 deferred store-address editing.
- Product View and History are both read-model examples, but with different display responsibilities.

## 4. Concepts Codex Should Report for [A]

Report these in `H_DDC_CODEX.md` as didactic evidence/candidates:

- `&&&` Time Bucketing
- `&&&` Aggregation and Totals
- `&&&` Grouping Versus Sorting
- `&&&` Configuration State
- `&&&` Simple Key/Value Table
- `&&%` Date/Datetime Boundary Handling
- `&%%` History Read Model
- `&%%` Settings-Owned Preferences
- `&%%` Store Editing Workflow
- `&%%` History Grouping Service Responsibility
- `%%%` SQLite Settings Persistence
- `%%%` PySide6 Editable Form Composition

Also report how these reuse Cycle 01 concepts:

- Raw Data Versus Derived Data
- Naming as Data Contract
- Repository Result Shape
- Service-Owned Calculation Responsibility
- SQLite Schema Evolution
- SQLite PRAGMA
- PySide6 Widget Composition

## 5. Simple Key/Value Table Didactic Requirement

Because the developer requested clarification, `H_DDC_CODEX.md` must include a brief learner-facing note on a simple key/value settings table.

Explain:

- It stores each setting as a named key plus a text value.
- It is useful when settings are small, independent, and may grow over time.
- Example: `history.week_boundary = wednesday`.
- It avoids creating many columns before the settings model is stable.
- Its tradeoff is that values need parsing/validation in service code.

[A] will later decide whether this becomes a canonical KANBAN concept or a glossary derivative.

## 6. Aggregation Didactic Requirement

Codex should report clearly which aggregate meanings were implemented.

The H report should distinguish:

- sum/total for monetary purchase totals
- mean/average for average price or unit values
- quantity aggregation only when units are compatible

This matters because not every History value should be reduced with a single `SUM` rule.

## 7. H_DDC_CODEX.md Report Shape

After materialization, write `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md` with:

- Source stage files
- Coding concepts exposed
- Concept candidates by marker
- Existing Cycle 01 concepts reused
- Grouping versus sorting evidence
- Time bucketing evidence
- Aggregation and total-row evidence
- Simple key/value table note
- Settings/configuration state evidence
- Service vs repository vs UI responsibility evidence
- Didactic risks or confusions remaining
- Suggested [A] follow-up

Keep the report compact. Do not reproduce long code.

## 8. Didactic Domain Absorption Later

Later [A] may absorb this report into:

- `documentation/sketch_notebook/didactics/02_KANBAN.md`
- `documentation/sketch_notebook/didactics/07_GLOSSARY.md`
- `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`
- `documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md`

Codex should not edit those permanent didactic files in this pass.
