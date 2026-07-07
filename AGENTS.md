# AGENTS.md

> Version: 0.1
> Status: Draft
> Authority: Main Chat
> Scope: AI agent and Codex execution guardrails

---

# 1. Required Bootstrap

Before performing any task, every AI agent must read:

```text
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
documentation/sketch_notebook/methodology/FLUX.md
```

No agent should edit files before completing this bootstrap sequence.

---

# 2. Absolute Methodology Protection Rule

Codex must not modify files under:

```text
documentation/sketch_notebook/methodology/
```

This directory is controlled by Main Chat only.

Methodology files define the operating system of the Sketch Notebook Method.

Codex may read methodology files, but must not edit, rewrite, rename, delete, move, summarize into, or generate replacements for them.

If a task appears to require methodology changes, Codex must stop and report that Main Chat intervention is required.

---

# 3. Canonical Notebook Root

The canonical Sketch Notebook root is:

```text
documentation/sketch_notebook/
```

The following path is invalid for notebook material:

```text
app/documentation/sketch_notebook/
```

Codex must not create or update Sketch Notebook files under `app/documentation/`.

---

# 4. Codex Role

Codex is the materialization agent.

Codex applies Main-approved instructions to repository files.

Codex should not invent methodology, alter routing rules, redefine chat authority, or promote unstaged content.

Codex materializes.

Main Chat synthesizes.

Functional chats stage.

---

# 5. Authorized Codex Inputs

Codex should materialize changes only from Main-approved stage files:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

If these files are missing, empty, contradictory, or insufficient, Codex must ask for Main Chat clarification before editing.

---

# 6. Allowed Codex Edit Targets

Codex may edit application/source files when explicitly instructed by Main-approved stage material.

Codex may edit permanent notebook domain folders when explicitly instructed by Main-approved stage material:

```text
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
```

Codex may edit DEV_STAGE files only when explicitly instructed by Main Chat.

Codex must not edit:

```text
documentation/sketch_notebook/methodology/
```

---

# 7. Functional Chat Restrictions

Functional chats are:

- Operational Chat
- Didactic Chat
- Design Chat

They may stage and commit only their assigned files:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

Functional chats must not modify permanent notebook folders, methodology files, Main stage files, or application source files.

---

# 8. Stop Conditions

Codex must stop and ask for clarification if:

- the requested change touches `documentation/sketch_notebook/methodology/`;
- the task contradicts `FLUX.md`;
- the task uses deprecated paths such as `DEV_TRACK/` or `app/documentation/sketch_notebook/`;
- the task requires invented filenames;
- Main-approved stage files are missing or unclear;
- the requested edit would mix unrelated responsibilities in one commit.

---

# 9. Commit Discipline

Codex should keep commits focused.

A materialization commit may include multiple files only when those files belong to the same Main-approved task.

Codex should report:

- files changed;
- reason for each change;
- commands run;
- test results;
- unresolved risks.

---

# 10. Summary

Read `INDEX.md` first.

Load methodology.

Obey `FLUX.md`.

Never modify `documentation/sketch_notebook/methodology/`.

Materialize only Main-approved stage instructions.
