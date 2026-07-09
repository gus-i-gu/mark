# AGENTS.md

> Version: 0.2
> Status: Draft
> Authority: Main Chat
> Scope: AI agent and Codex execution guardrails for this repository

---

# 1. Purpose

`AGENTS.md` is the repository-level bootstrap and guardrail file for Codex and other AI agents.

It exists because tooling may read root `AGENTS.md` before it reads project documentation.

This file must be robust enough to protect the Sketch Notebook structure even when the agent cannot load every methodology file in full.

The Sketch Notebook remains the authoritative project-memory system.

---

# 2. First Required Read

Before performing repository work, read:

```text
documentation/sketch_notebook/INDEX.md
```

Then follow the methodological boot order defined there.

Current required methodology route:

```text
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

Consult when needed:

```text
documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
documentation/sketch_notebook/methodology/METHOD_GLOSSARY.md
```

If token or tool limits prevent reading all methodology files, this `AGENTS.md` file still applies as a strict minimum guardrail.

---

# 3. Canonical Notebook Root

The canonical Sketch Notebook root is:

```text
documentation/sketch_notebook/
```

Invalid notebook roots include:

```text
app/documentation/sketch_notebook/
```

Codex and AI agents must not create, edit, move, or maintain Sketch Notebook material under invalid roots.

New notebook material must not be created in adjacent repositories, misplaced folders, temporary folders, or alternative notebook roots.

---

# 4. Absolute Methodology Protection Rule

Codex must not modify files under:

```text
documentation/sketch_notebook/methodology/
```

unless explicitly instructed by Main Chat under human-supervised methodological revision.

Methodology files define the operating system of the Sketch Notebook Method.

Codex may read methodology files.

Codex must not edit, rewrite, rename, delete, move, summarize into, or generate replacements for methodology files unless the task is explicitly a Main-approved methodological materialization.

If a task appears to require methodology changes without explicit authorization, Codex must stop and report that Main Chat intervention is required.

---

# 5. File Creation and Rename Guardrail

Codex and AI agents must not create new files directly under:

```text
documentation/sketch_notebook/
```

unless explicitly authorized by Main Chat under human-supervised methodological revision.

Codex and AI agents must not rename Sketch Notebook files unless explicitly authorized by Main Chat under human-supervised methodological revision.

Creating or renaming Sketch Notebook files requires a coherence check against:

* `documentation/sketch_notebook/INDEX.md`;
* `documentation/sketch_notebook/methodology/FLUX.md`;
* relevant domain checkpoints;
* affected prompts;
* affected materialization instructions;
* affected file references.

If a task seems to require a new file or rename, stop and ask for Main Chat clarification unless D/E/F explicitly authorize it.

---

# 6. Codex Role

Codex is the materialization agent.

Codex applies Main-approved instructions to repository files.

Codex reports evidence.

Codex does not decide semantic promotion.

Codex does not invent methodology.

Codex does not invent filenames.

Codex does not independently reorganize the Sketch Notebook.

Main Chat synthesizes.

Functional chats stage and maintain domain memory according to `FLUX.md`.

---

# 7. Authorized Codex Inputs

Codex should materialize changes only from Main-approved stage files:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

If these files are missing, empty, contradictory, stale, or insufficient, Codex must ask for Main Chat clarification before editing.

Codex should not treat A/B/C functional stage files as direct implementation authority.

Codex should not treat G/H/I report files as implementation instructions.

---

# 8. Required Codex Reports

After materialization, Codex should report evidence into the Codex report stage files:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Reports should include:

```text
source stage files
files changed
files created
files deleted
commands run
validation results
instructions completed
instructions skipped
failures or blockers
unresolved risks
suggested functional follow-up
```

Codex reports are observational evidence.

They are not canonical knowledge.

---

# 9. Allowed Edit Targets

Codex may edit application/source files when explicitly instructed by Main-approved stage material.

Codex may edit permanent notebook domain folders when explicitly instructed by Main-approved stage material:

```text
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
```

Codex may edit DEV_STAGE files only when explicitly instructed by Main Chat or when writing G/H/I reports after materialization.

Codex must not edit methodology files except under explicit Main-approved methodological materialization.

---

# 10. Domain Symmetry Files

Current domain files are:

```text
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/operational/11_OPERATIONAL_RECORD.md
documentation/sketch_notebook/operational/12_OPERATIONAL_MODEL.md

documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md

documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

Current domain checkpoints are:

```text
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

Do not rename these files.

Do not create replacements without Main-approved methodological revision.

---

# 11. Functional Chat Constraints

Functional chats are:

* Operational Chat;
* Didactic Chat;
* Design Chat.

During active staging, they write only:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

After Codex reports exist, functional chats may update their own permanent domain folders according to `FLUX.md`.

Functional chats must not modify:

* application source files;
* methodology files;
* another functional domain folder;
* Main stage files;
* Codex report files.

---

# 12. Deprecated / Invalid Names

Do not create or use these paths or names as canonical:

```text
DEV_TRACK/
B_DIDACTICS.md
02_DIDACTICS.md
10_ACTIONS.md
11_OPERATIONAL_TRACKRECORD.md
11_OPERATIONAL_TRACK.md
app/documentation/sketch_notebook/*
```

They may appear in historical context only.

---

# 13. Stop Conditions

Codex must stop and ask for clarification if:

* the requested change touches `documentation/sketch_notebook/methodology/` without explicit methodological authorization;
* the requested change creates a new file under `documentation/sketch_notebook/`;
* the requested change renames a Sketch Notebook file;
* the task contradicts `FLUX.md`;
* the task uses deprecated paths such as `DEV_TRACK/` or `app/documentation/sketch_notebook/`;
* the task requires invented filenames;
* Main-approved stage files are missing or unclear;
* D/E/F instructions contradict each other;
* the requested edit would mix unrelated responsibilities in one commit;
* Codex cannot determine whether a change is source-code materialization, notebook-domain update, or methodology revision.

---

# 14. Commit Discipline

Codex should keep commits focused.

A materialization commit may include multiple files only when those files belong to the same Main-approved task.

Codex should report:

* files changed;
* reason for each change;
* commands run;
* validation results;
* unresolved risks.

Do not include unrelated cleanup unless explicitly instructed.

---

# 15. Minimum Guardrail Summary

Read `documentation/sketch_notebook/INDEX.md` first.

Load methodology when possible.

Obey `FLUX.md`.

Materialize only Main-approved D/E/F instructions.

Report through G/H/I.

Never invent filenames.

Never rename Sketch Notebook files without Main-approved methodological revision.

Never create notebook files outside the canonical structure.

Never modify methodology unless explicitly authorized by Main Chat under human-supervised methodological revision.
