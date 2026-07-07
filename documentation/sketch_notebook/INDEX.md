# INDEX.md

> Version: 0.1
> Status: Draft
> Persistence Class: Derived / Navigational
> Authority: Main Chat
> Scope: Sketch Notebook navigation and bootstrap routing

---

# 1. Purpose

`INDEX.md` is the navigation entrypoint for the Sketch Notebook.

Every chat should read this file before exploring the rest of the notebook.

Its purpose is to expose the notebook structure, redirect all agents to the methodology directory, and prevent path drift.

This file is a map, not a source of canonical truth.

---

# 2. Mandatory Bootstrap Route

Before starting any work cycle, every chat should read the methodology directory.

Required methodology files:

```text
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
documentation/sketch_notebook/methodology/FLUX.md
```

Recommended boot order:

```text
METHOD_FOUNDATIONS
↓
PROMOTION_RULES
↓
CHAT_BEHAVIOUR
↓
CHAT_PROTOCOL
↓
FLUX
```

No chat should begin functional work before loading the methodology context.

---

# 3. Canonical Notebook Root

The canonical notebook root is:

```text
documentation/sketch_notebook/
```

Invalid notebook root:

```text
app/documentation/sketch_notebook/
```

Any notebook material created under `app/documentation/` should be considered misplaced.

---

# 4. Top-Level Structure

```text
documentation/sketch_notebook/
│
├── INDEX.md
│
├── methodology/
│   ├── METHOD_FOUNDATIONS.md
│   ├── PROMOTION_RULES.md
│   ├── CHAT_BEHAVIOUR.md
│   ├── CHAT_PROTOCOL.md
│   └── FLUX.md
│
├── DEV_STAGE/
│   ├── A_OPERATIONAL.md
│   ├── B_DIDACTIC.md
│   ├── C_DESIGN.md
│   ├── D_OPS_STAGE.md
│   ├── E_DDC_STAGE.md
│   └── F_DSN_STAGE.md
│
├── operational/
│
├── didactics/
│
└── design/
```

---

# 5. Directory Roles

## methodology/

Contains the specifications that define the method itself.

This directory is protected.

Only Main Chat may modify methodology files.

Codex must not modify methodology files.

Functional chats must not modify methodology files.

## DEV_STAGE/

Contains temporary staging files.

Functional chats write A/B/C.

Main Chat writes D/E/F.

Codex reads D/E/F when materializing changes.

## operational/

Contains permanent operational knowledge.

Operational Chat may reason about this domain, but permanent updates are materialized only after Main synthesis.

## didactics/

Contains permanent didactic and learning knowledge.

Didactic Chat may reason about this domain, but permanent updates are materialized only after Main synthesis.

## design/

Contains permanent architecture, domain, and decision knowledge.

Design Chat may reason about this domain, but permanent updates are materialized only after Main synthesis.

---

# 6. Functional Chat Domain Routing

When a functional role is declared, the chat should remain mostly within its domain after methodology boot.

| Role | Primary domain | Stage file | Permanent domain |
|---|---|---|---|
| Operational Chat | execution, debugging, commands | `DEV_STAGE/A_OPERATIONAL.md` | `operational/` |
| Didactic Chat | learning, KANBANs, glossary, concepts | `DEV_STAGE/B_DIDACTIC.md` | `didactics/` |
| Design Chat | architecture, decisions, domain model | `DEV_STAGE/C_DESIGN.md` | `design/` |

Functional chats may inspect application source files when needed for their task.

They should not edit application source files.

They should not edit permanent notebook files.

They should stage only into their assigned DEV_STAGE file.

---

# 7. Main Chat Routing

Main Chat reads all functional stage files:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

Main Chat then prepares materialization stage files:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

These files are the bridge between chat synthesis and Codex materialization.

---

# 8. Codex Routing

Codex should read:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
documentation/sketch_notebook/methodology/FLUX.md
```

Codex should materialize only Main-approved instructions from:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Codex must not modify `documentation/sketch_notebook/methodology/`.

---

# 9. Navigation Summary

Start here:

```text
documentation/sketch_notebook/INDEX.md
```

Then read:

```text
documentation/sketch_notebook/methodology/
```

Then proceed according to role:

```text
Operational → DEV_STAGE/A_OPERATIONAL.md → operational/
Didactic    → DEV_STAGE/B_DIDACTIC.md   → didactics/
Design      → DEV_STAGE/C_DESIGN.md     → design/
Main        → A/B/C synthesis           → D/E/F materialization stage
Codex       → AGENTS.md + D/E/F         → materialization
```
