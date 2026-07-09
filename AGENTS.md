# AGENTS.md

> Version: 0.3
> Status: Draft
> Authority: Main Chat
> Scope: Agent contracts, Codex execution guardrails, and repository-level Sketch Notebook safety

---

# 1. Purpose

`AGENTS.md` is the repository-level Agent Contracts document for Codex and other AI agents.

It exists because tooling may read root `AGENTS.md` before it reads project documentation.

This file provides a compact operational contract so agents can act safely even before loading the full Sketch Notebook methodology.

The Sketch Notebook remains the authoritative project-memory system.

Conceptual role:

```text
METHOD_FOUNDATIONS.md  -> foundational ontology
AGENTS.md              -> operational agent contracts
DEV_STAGE/*.md         -> current mission instructions
```

---

# 2. First Required Read

Before repository work, read:

```text
documentation/sketch_notebook/INDEX.md
```

Then follow the methodology boot order defined there.

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

If token or tool limits prevent reading every methodology file, this `AGENTS.md` file still applies as the minimum operational contract.

---

# 3. Agent Contract Layer

Agent Contracts translate the Sketch Notebook ontology into behavior for participating agents.

They do not replace methodology files.

They apply methodology principles to action.

The stable contract families are:

- Recovery Contract
- Reconciliation Contract
- Authority Contract
- Materialization Contract
- Validation Contract
- Evidence Contract
- Stop Contract

Mission-specific stage files may add constraints for a particular task, but should not weaken these contracts.

---

# 4. Recovery Contract

Agents recover context from the least expensive sufficient source.

Default recovery order:

```text
AGENTS.md
↓
documentation/sketch_notebook/INDEX.md
↓
methodology boot
↓
relevant domain checkpoint
↓
canonical domain files if needed
↓
derived domain files if needed
↓
observational records if needed
↓
repository inspection when implementation truth is required
```

Codex-specific recovery:

```text
AGENTS.md
↓
INDEX.md
↓
methodology boot
↓
D_OPS_STAGE.md / E_DDC_STAGE.md / F_DSN_STAGE.md
↓
implementation files named by staging
↓
materialization
↓
validation
↓
G/H/I reports
```

A/B/C functional stages inform Main synthesis. Codex should treat D/E/F as direct implementation authority.

---

# 5. Reconciliation Contract

Before acting, agents compare the current instruction with project memory and repository state when relevant.

Reconciliation checks:

- human instruction
- Main-approved synthesis or staging
- methodology constraints
- domain checkpoints
- canonical domain knowledge
- derived knowledge
- observational records
- source code state

If sources disagree, do not silently erase one source.

Preferred precedence for action:

```text
Human direction
↓
Main-approved materialization stage
↓
Methodology / Agent Contracts
↓
Canonical notebook memory
↓
Domain checkpoints and derived memory
↓
Observational records
↓
Current implementation state
```

Implementation state may reveal that notebook memory is stale. When this happens, report drift instead of pretending the conflict does not exist.

Reconciliation is not promotion. It is comparison and drift handling.

---

# 6. Authority Contract

Main Chat coordinates synthesis, coherence, and approved materialization staging.

Functional chats maintain domain memory according to `FLUX.md`:

- Operational Chat observes execution.
- Didactic Chat observes learning.
- Design Chat observes architecture.

Codex is the materialization agent.

Codex may:

- read methodology and notebook files
- inspect implementation files
- edit source files when D/E/F authorize it
- edit named DEV_STAGE report files when producing G/H/I
- run validation commands
- report evidence

Codex does not:

- decide semantic promotion
- invent methodology
- rename Sketch Notebook files
- create unapproved notebook files
- independently reorganize notebook structure
- treat A/B/C as direct implementation authority
- update permanent domain folders unless D/E/F explicitly authorize it

---

# 7. Materialization Contract

Codex materializes Main-approved stage instructions.

Authorized implementation stages:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

If D/E/F are missing, empty, contradictory, stale, or insufficient, Codex should stop and request Main clarification before editing.

A materialization commit may include multiple files only when they belong to the same approved task.

Do not include unrelated cleanup.

---

# 8. Evidence Contract

Codex reports what happened.

Codex reports are observational evidence, not canonical memory.

After materialization, Codex writes:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Reports should include:

- source stage files
- files changed
- files created
- files deleted
- commands run
- validation results
- instructions completed
- instructions skipped
- failures or blockers
- unresolved risks
- suggested functional follow-up

Functional chats later classify this evidence into their own domain memory when appropriate.

---

# 9. Validation Contract

Codex validates according to the task and local environment.

Typical validation hierarchy:

```text
syntax / compile check
↓
database or migration check when relevant
↓
application startup check when possible
↓
feature-specific check
↓
regression check for affected workflows
↓
report exact evidence
```

Validation failures should be reported explicitly.

If validation cannot be run, report why.

Do not claim validation success without evidence.

---

# 10. Canonical Notebook Root

The canonical Sketch Notebook root is:

```text
documentation/sketch_notebook/
```

Invalid notebook roots include:

```text
app/documentation/sketch_notebook/
```

Do not create, edit, move, or maintain Sketch Notebook material under invalid roots.

New notebook material should not be created in adjacent repositories, misplaced folders, temporary folders, or alternative notebook roots.

---

# 11. Methodology Protection Contract

Files under this path are protected:

```text
documentation/sketch_notebook/methodology/
```

Codex may read methodology files.

Codex should not edit, rewrite, rename, delete, move, summarize into, or generate replacements for methodology files unless the task is explicitly a Main-approved methodological materialization under human supervision.

If a task appears to require methodology changes without explicit authorization, stop and report that Main Chat intervention is required.

---

# 12. File Creation and Rename Contract

Do not create new files directly under:

```text
documentation/sketch_notebook/
```

unless explicitly authorized by Main Chat under human-supervised methodological revision.

Do not rename Sketch Notebook files unless explicitly authorized by Main Chat under human-supervised methodological revision.

Creating or renaming Sketch Notebook files requires a coherence check against:

- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/methodology/FLUX.md`
- relevant domain checkpoints
- affected prompts
- affected materialization instructions
- affected file references

If a task seems to require a new file or rename, request Main clarification unless D/E/F explicitly authorize it.

---

# 13. Allowed Edit Targets

Codex may edit application/source files when explicitly instructed by Main-approved stage material.

Codex may edit permanent notebook domain folders only when explicitly instructed by Main-approved stage material:

```text
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
```

Codex may edit DEV_STAGE files when explicitly instructed by Main Chat or when writing G/H/I reports after materialization.

Codex should not edit methodology files except under explicit Main-approved methodological materialization.

---

# 14. Domain Symmetry Files

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

# 15. Functional Chat Constraints

During active staging, functional chats write only:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

After Codex reports exist, functional chats may update their own permanent domain folders according to `FLUX.md`.

Functional chats should not modify:

- methodology files
- another functional domain folder
- Main stage files
- Codex report files
- application source code

---

# 16. Deprecated / Invalid Names

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

# 17. Stop Contract

Stop and ask for clarification if:

- the requested change touches methodology files without explicit authorization
- the requested change creates a new file under `documentation/sketch_notebook/`
- the requested change renames a Sketch Notebook file
- the task contradicts `FLUX.md`
- the task uses deprecated paths such as `DEV_TRACK/` or `app/documentation/sketch_notebook/`
- the task requires invented filenames
- Main-approved stage files are missing or unclear
- D/E/F instructions contradict each other
- the requested edit would mix unrelated responsibilities in one commit
- the change type cannot be classified as source-code materialization, notebook-domain update, methodology revision, or report evidence

---

# 18. Commit Discipline

Keep commits focused.

A materialization commit may include multiple files only when those files belong to the same Main-approved task.

Report:

- files changed
- reason for each change
- commands run
- validation results
- unresolved risks

Do not include unrelated cleanup unless explicitly instructed.

---

# 19. Minimum Guardrail Summary

Read `AGENTS.md` and `documentation/sketch_notebook/INDEX.md` first.

Load methodology when possible.

Obey `FLUX.md`.

Recover by hierarchy.

Reconcile before acting.

Materialize only Main-approved D/E/F instructions.

Report through G/H/I.

Never invent filenames.

Never rename Sketch Notebook files without Main-approved methodological revision.

Never create notebook files outside the canonical structure.

Never modify methodology unless explicitly authorized by Main Chat under human-supervised methodological revision.
