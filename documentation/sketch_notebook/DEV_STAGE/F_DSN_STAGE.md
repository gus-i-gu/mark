# [M] Session 003 | 11:??_07_07_2026 | Markei

# F_DSN_STAGE — Main Design Materialization Stage

> Source stages:
> - `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> - `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
> - `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
>
> Purpose: Codex-ready design notebook update brief for the StoragePage `KeyError: "color"` boundary decision.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Design Synthesis

The active issue is not a reason to modify the repository boundary.

The repaired architecture remains:

```text
UI
↓
ProductService
↓
Repository
↓
database.py / SQLite
```

The current failure is higher in the dependency chain:

```text
StoragePage expects presentation metadata named `color`.
ProductService returns semantic price variation data, but not presentation color.
```

Design, Operational, and Didactic reports converge on the same interpretation:

```text
`KeyError: "color"` is a UI/service contract mismatch.
```

It is not primarily:

- a repository problem;
- a database problem;
- a domain model problem;
- a reason to make ProductService depend on PySide6.

---

# 2. Design Decision Approved for Materialization

## Decision: Preserve semantic service boundary and keep presentation color in UI

Status:

```text
Accepted for current MVP repair.
```

Context:

`StoragePage.load_products()` expects price variation data to include `"color"`, but `ProductService.get_price_variation()` returns only semantic/business data:

```text
delta
percentage
text
```

Decision:

```text
ProductService may own price variation semantics.
StoragePage or a UI-side presentation mapper owns color mapping.
QColor must remain in the desktop UI layer.
```

Consequences:

- `ProductService` remains independent of PySide6/Qt.
- The service layer remains usable by tests, CLI tools, future APIs, or alternate UIs.
- UI styling can change without touching business logic.
- StoragePage must not assume service dictionaries contain Qt presentation keys.

---

# 3. Boundary Ownership

## Repository

Owns:

```text
SQL operations
persistent product rows
persistent purchase rows
row-to-model mapping
database access through database.py
```

Does not own:

```text
price variation meaning
UI colors
QColor
table styling
```

## ProductService

Owns:

```text
business interpretation
price variation semantics
product status classification
purchase interval calculations
expected next purchase logic
```

May expose semantic fields such as:

```text
price_delta
price_delta_percent
price_status
price_trend
unknown / increased / decreased / same
```

Does not own:

```text
QColor
text brush
background brush
visual palette
widget styling
table rendering
```

## StoragePage

Owns:

```text
rendering storage data
creating table items
mapping semantic values to visible style
choosing QColor / visual emphasis
handling optional UI display fallbacks
```

Does not own:

```text
SQL
repository access
business calculations
purchase duration algorithms
```

## Optional future UI mapper

A future UI-side mapper may own:

```text
semantic status -> color
semantic status -> label
semantic status -> icon
semantic status -> tooltip
```

This mapper must remain in the UI/presentation side of the architecture, not in `app/core/services.py`.

---

# 4. Permanent Design Updates Required

Create or update design files under:

```text
documentation/sketch_notebook/design/
```

Recommended files if not already present:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISIONS.md
documentation/sketch_notebook/design/09_DOMAIN_MODEL.md
```

If these files already exist, append/update conservatively.

Do not edit methodology files.

---

# 5. Architecture Note to Persist

Add/update architecture content stating:

```text
Core dependency direction remains:

UI -> ProductService -> Repository -> database.py -> SQLite
```

Add this refinement:

```text
Presentation styling belongs to the UI side of the architecture.

ProductService may return semantic business/application data, but should not return Qt/PySide objects or display-only metadata such as QColor, QBrush, text color, or background color.
```

---

# 6. Decision Note to Persist

Add/update decision content:

```text
Decision: Keep price variation color mapping in the UI layer.

Status: Accepted for current MVP repair.

Context:
StoragePage failed with `KeyError: "color"` because it expected ProductService price-variation output to contain a presentation key named `color`.

Decision:
ProductService should remain responsible for price variation semantics only. StoragePage, or a future UI-side presentation mapper, should translate semantic price variation into QColor or other visual styling.

Consequences:
- service layer remains free of PySide6/Qt;
- service return values remain semantic rather than presentation-specific;
- UI remains responsible for visual choices;
- future interfaces can reuse ProductService without importing Qt.
```

---

# 7. Domain / Boundary Note to Persist

Add/update domain or boundary content:

```text
Price variation has two layers of meaning.

Business/application meaning:
- price increased;
- price decreased;
- price stayed same;
- price comparison unavailable.

Presentation meaning:
- red text;
- green text;
- neutral gray text;
- icon or badge choice.

The first belongs to ProductService.
The second belongs to StoragePage or another UI-side presentation component.
```

---

# 8. Shiboken Design Note

Add/update a small design caution only if appropriate:

```text
PySide6/Shiboken warnings are UI binding signals unless evidence shows Qt objects leaking into core layers.

They should not be treated as architectural proof by themselves.

However, introducing Qt objects into ProductService would make such warnings more likely to cross architectural boundaries.
```

Keep this short. The Shiboken issue is operationally relevant but not the main design decision.

---

# 9. Codex Prompt — Design Materialization

Codex, read first:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
documentation/sketch_notebook/methodology/FLUX.md
```

Do not modify:

```text
documentation/sketch_notebook/methodology/
```

Task:

Use:

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
```

as sources, and synthesize stable design conclusions into permanent design notes under:

```text
documentation/sketch_notebook/design/
```

Include only stable design conclusions.

Do not preserve raw staged fragments.

Do not duplicate existing canonical knowledge if the same decision already exists; update conservatively.

---

# 10. Expected Codex Report

Codex must report:

1. design files created/updated;
2. architecture note added/updated;
3. decision note added/updated;
4. boundary note added/updated;
5. whether Qt/PySide objects were kept out of core-layer design guidance;
6. unresolved design risks.
