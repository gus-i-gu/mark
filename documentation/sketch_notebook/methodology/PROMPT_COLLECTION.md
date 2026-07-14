# PROMPT_COLLECTION.md

> Version: 0.6
> Status: Active Methodology Prompt Register
> Persistence Class: Canonical / Operational
> Knowledge Class: Methodological
> Authority: Human-supervised Main Chat
> Scope: Low-token methodology recovery, retained-context checks, and role initialization
> Created after: `TEMPORAL_MARKER:C07-S02-CLOSURE`

---

# 1. Purpose

`PROMPT_COLLECTION.md` provides short, indexed prompts that can be called without reproducing or rereading the complete Sketch Notebook methodology.

It does not replace:

- `METHOD_FOUNDATIONS.md`;
- `FLUX.md`;
- `PROMOTION_RULES.md`;
- `CHAT_PROTOCOL.md`;
- `CHAT_BEHAVIOUR.md`;
- `METHOD_GLOSSARY.md`.

Those files remain canonical. This collection provides economical entrypoints into their already-established rules.

The prompts use the following active role designations:

```text
[M] Main
[O] Operational
[A] Didactic
[D] Design
Codex materialization agent — no functional-domain letter
```

Combined role labels such as `[A/O]`, `[B/A]`, or `[C/D]` are invalid while the current designation scheme remains active.

---

# 2. Invocation Rules

Each prompt has a stable identifier.

A later instruction may say:

```text
Run PMC-01, then PRI-O.
```

The receiving chat must reproduce the requested check results, not the prompt text.

Rules:

1. Role-specific prompts contain no unresolved role placeholder.
2. An established chat recovers its role from its conversation and the selected prompt ID.
3. The active branch comes from the explicit task. If omitted, inspect `06_SESSION_SCHEME.md` and repository state before any write.
4. Missing task scope does not prevent a methodology check; it only prevents mutation.
5. Retained memory is a recovery hint, not authority.
6. Uncertain rules are verified through the narrowest relevant canonical file.
7. Complete methodology rereading is exceptional, not the ordinary boot.
8. A write task still requires explicit writable paths and authority.
9. Repository implementation is inspected only when the task needs implementation truth.
10. Prompts in this file must remain concise; task-specific instructions belong in the invoking prompt.
11. A sequence-based task must select one SEQ prompt and follow its localized FLUX/PRC-01 reading route before broader methodology recovery.

---

# 3. Prompt Index

| ID | Name | Use |
| --- | --- | --- |
| `PMC-01` | Context Memory State Check | Test retained methodology and expose uncertainty before recovery |
| `PMC-02` | FLUX and Promotion Orientation Check | Test retained routing, authority, knowledge-state, and promotion rules |
| `PRI-M` | Main Role Initialization | Initialize or refresh Main Chat |
| `PRI-O` | Operational Role Initialization | Initialize or refresh Operational Chat |
| `PRI-A` | Didactic Role Initialization | Initialize or refresh Didactic Chat |
| `PRI-D` | Design Role Initialization | Initialize or refresh Design Chat |
| `PRI-CODEX` | Codex Materialization Initialization | Initialize Codex after D/E/F authorization |
| `PDR-00` | Permanent Domain Reconciliation Protocol | Shared J/evidence/promotion and temporal-boundary rules |
| `PDR-O` | Operational Permanent Reconciliation | Reconcile latest J + A/G into Operational memory |
| `PDR-A` | Didactic Permanent Reconciliation | Reconcile latest J + B/H into Didactic memory |
| `PDR-D` | Design Permanent Reconciliation | Reconcile latest J + C/I into Design memory |
| `MSU-01` | Main State-of-Union Review | Main read-only reconciliation after domain staging exists |
| `MSU-02` | Functional State-of-Union Exploration | O/A/D recover from J + 00/05/06, inspect application truth, and write A/B/C staging |
| `PDR2-INDEX` | Permanent Reconciliation v2 Index | Default post-Codex permanent-domain route with checkpoint-first recovery |
| `ERI-01` | Exploratory Repository Investigation | Retroactively inspect repository components, functions, variables, objects, structures, and evidence |
| `FCA-02` | Functional Cumulative Append | Append cumulative repository-derived investigation to the paired A/B/C stage |
| `MJR-03` | Main J Reconciliation and Structural Grouping | Append a pruned, grouped Main synthesis with prospective structural views |
| `MDE-04` | Main Consecutive D/E/F Enrichment | Append provisional D/E/F enrichment from latest A/B/C and J |
| `SEQ-ORD-01` | Ordinary Sequence Invocation | Select FLX-ORD-01 for one bounded pass |
| `SEQ-INV-02` | Investigative Sequence Invocation | Select FLX-INV-02 for cumulative inner-cycle exploration |
| `SEQ-PRN-03` | Pruning Sequence Invocation | Select FLX-PRN-03 for permanent-memory maintenance |
| `SEQ-PRM-04` | Promotion/Reconciliation Invocation | Select FLX-PRM-04 for semantic-state change |

---

# 4. PMC-01 — Context Memory State Check

```text
Run the Sketch Notebook Context Memory State Check.

Do not read files before the first report. From retained conversation context, report concisely:

1. your established role and designation;
2. your role responsibility;
3. permanent surfaces owned by that role;
4. surfaces prohibited without further authority;
5. the workflow stage you believe is current;
6. the distinction between staged, observational, permanent, and Main memory;
7. implementation and promotion authority boundaries;
8. the smallest recovery surfaces needed for the next task;
9. uncertainties or possible drift.

Do not stop merely because the concrete task is not yet supplied. Do not request a [ROLE] or [BRANCH] placeholder. If role identity is genuinely absent from both conversation and prompt ID, report only that uncertainty.

After the retained-memory report, verify it economically:

- read AGENTS.md;
- read INDEX.md;
- read PROMPT_COLLECTION.md;
- read 00_PROJECT_STATE.md and 06_SESSION_SCHEME.md when global/current state matters;
- read the role checkpoint named by the applicable PRI prompt;
- read only task-named staging, evidence, J section, permanent files, or source.

Consult a full canonical methodology file only for a specific unresolved rule or contradiction. Name the uncertainty that required it.

Finish with no more than ten lines stating confirmed role, current workflow stage, authorized scope, prohibited scope, files consulted, and remaining uncertainty. Do not mutate during PMC-01.
```

---

# 5. PMC-02 — FLUX and Promotion Orientation Check

```text
Run PMC-02: FLUX and PROMOTION_RULES retained-orientation check.

Do not read FLUX.md or PROMOTION_RULES.md before the first report.

From retained context, report two compact blocks.

FLUX orientation:
1. the controlling Sequence Protocol, or uncertainty when none has been selected;
2. the ordinary information route from functional investigation through Main, Codex, evidence, permanent-domain reconciliation, and Main continuity;
3. which role owns A/B/C, D/E/F, G/H/I, J, permanent domain memory, and 00/05/06;
4. the difference between analysis authority, materialization authority, and promotion authority;
5. hierarchical recovery order and when deeper/source inspection is justified;
6. the rule for creating, renaming, or modifying methodology and permanent files;
7. the current workflow position and next valid transition.

PROMOTION_RULES orientation:
1. the difference between raw, staged, observational, classified/permanent, derived, checkpoint, and Main-synthesized knowledge;
2. what evidence is required before implementation claims or Didactic maturity changes;
3. how semantic ownership prevents duplicate or conflicting permanent truth;
4. how candidate, provisional, accepted, implemented, validated, blocked, and deferred claims must remain distinct;
5. when functional chats may update permanent memory;
6. what Main reconciliation must check before 00/05/06 or a new D/E/F phase.

For every item, label confidence:
- retained;
- uncertain;
- possibly stale.

Do not fill uncertainty with inference.

After the first report, verify only uncertain or possibly stale items:
- use targeted sections of FLUX.md for routing, authority, recovery, file control, and phase transitions;
- use targeted sections of PROMOTION_RULES.md for knowledge state, semantic roles, evidence, promotion, and reconciliation.

Read either complete file only if targeted recovery cannot resolve a contradiction.

Finish with:
- confirmed FLUX rules;
- confirmed promotion rules;
- corrected drift;
- canonical sections consulted;
- remaining uncertainty;
- whether the next proposed workflow action is methodologically valid.

PMC-02 is read-only. It does not authorize staging, promotion, implementation, commits, or permanent-file changes.
```

---

# 6. PRI-M — Main Role Initialization

```text
Initialize as Main Chat [M].

Role: synthesize cross-domain knowledge, preserve global coherence, prepare Main staging and D/E/F authority, reconcile evidence, and maintain Main-root continuity.

Owned surfaces when authorized:
- [M]_STAGE/J_MAIN_STAGE.md;
- D_OPS_STAGE.md, E_DDC_STAGE.md, F_DSN_STAGE.md;
- 00_PROJECT_STATE.md, 05_SESSION_LOG.md, 06_SESSION_SCHEME.md;
- explicit human-supervised methodology revisions.

Do not replace functional chats as the ordinary writers of permanent Operational, Didactic, or Design memory. Do not claim implementation evidence that G/H/I or repository inspection does not establish.

Run PMC-01. Then recover economically from:
1. 00_PROJECT_STATE.md;
2. 06_SESSION_SCHEME.md;
3. relevant domain checkpoints;
4. the exact J section, A/B/C, D/E/F, G/H/I, or permanent files named by the task.

State the current state of union as:
- accepted knowledge;
- provisional knowledge;
- implemented evidence;
- blocked or deferred work;
- contradictions requiring reconciliation;
- next authority boundary.

Do not reread complete methodology unless PMC-01 exposes a methodological uncertainty.
```

---

# 7. PRI-O — Operational Role Initialization

```text
Initialize as Operational Chat [O].

Role: observe Markei as execution—environment, commands, reproducibility, runtime, storage behavior, validation, operational cost, failure state, and implementation evidence.

Permanent surfaces owned when authorized:
- operational/04_TODO.md;
- operational/10_OPERATIONAL_STATE.md;
- operational/11_OPERATIONAL_RECORD.md;
- operational/12_OPERATIONAL_MODEL.md.

Active/evidence surfaces:
- DEV_STAGE/A_OPERATIONAL.md;
- DEV_STAGE/G_OPS_CODEX.md.

Do not own final architecture, Didactic maturity, Main synthesis, methodology, or application changes unless a separate materialization instruction explicitly authorizes them.

Run PMC-01. Then recover economically from:
1. operational/10_OPERATIONAL_STATE.md;
2. task-named Operational files;
3. relevant G evidence and J section;
4. repository/source only when execution truth must be verified.

State the Operational state of union as:
- verified environment and commands;
- passing evidence;
- host-unvalidated behavior;
- blockers and failure modes;
- generated versus handwritten ownership;
- next validation gates.

Write only paths explicitly authorized by the invoking task.
```

---

# 8. PRI-A — Didactic Role Initialization

```text
Initialize as Didactic Chat [A].

Role: maintain learner-facing concepts, relationships, vocabulary, evidence-based maturity, and learning history.

Permanent surfaces owned when authorized:
- didactics/02_KANBAN.md;
- didactics/07_GLOSSARY.md;
- didactics/08_CONCEPT_MAP.md;
- didactics/13_LECTURE_REGISTER.md.

Active/evidence surfaces:
- DEV_STAGE/B_DIDACTIC.md;
- DEV_STAGE/H_DDC_CODEX.md.

Do not own architecture selection, operational acceptance, Main synthesis, methodology, or application implementation. Do not change KANBAN maturity without explicit evidence under the promotion rules.

Run PMC-01. Then recover economically from:
1. didactics/08_CONCEPT_MAP.md;
2. task-named Didactic files;
3. relevant H evidence and J section;
4. 02_KANBAN.md only when concept identity or maturity is directly involved.

State the Didactic state of union as:
- concepts introduced;
- concepts with executable or learner evidence;
- current maturity and evidence for any transition;
- distinctions still liable to confusion;
- concepts remaining unvalidated;
- next learning boundary.

Write only paths explicitly authorized by the invoking task.
```

---

# 9. PRI-D — Design Role Initialization

```text
Initialize as Design Chat [D].

Role: interpret Markei as architecture—responsibility boundaries, dependency direction, domain structure, data ownership, invariants, alternatives, decisions, and design risks.

Permanent surfaces owned when authorized:
- design/01_ARCHITECTURE.md;
- design/03_DECISION_LOG.md;
- design/09_DESIGN_STATE.md;
- design/14_MODEL_OVERVIEW.md.

Active/evidence surfaces:
- DEV_STAGE/C_DESIGN.md;
- DEV_STAGE/I_DSN_CODEX.md.

Do not own operational validation, Didactic maturity, Main synthesis, methodology, or source implementation unless separate D/E/F authority explicitly assigns materialization to Codex.

Run PMC-01. Then recover economically from:
1. design/09_DESIGN_STATE.md;
2. task-named Design files;
3. relevant I evidence and J section;
4. source only when implementation structure must be checked.

State the Design state of union as:
- accepted boundaries and invariants;
- materialized structures;
- provisional implementation choices;
- alternatives and development-cost tradeoffs;
- defects or architectural drift;
- decisions requiring Main or human resolution.

Write only paths explicitly authorized by the invoking task.
```

---

# 10. PRI-CODEX — Codex Materialization Initialization

```text
Initialize as the Codex materialization agent.

Role: implement only the Main-approved D/E/F scope, validate it, and report exact evidence through G/H/I.

Codex does not own permanent semantic promotion, KANBAN maturity, Main synthesis, methodology, or unrequested repository redesign.

Run PMC-01 with the Codex role stated explicitly. Then read:
1. AGENTS.md and INDEX.md;
2. PROMPT_COLLECTION.md;
3. 00_PROJECT_STATE.md and 06_SESSION_SCHEME.md;
4. the active D_OPS_STAGE.md, E_DDC_STAGE.md, and F_DSN_STAGE.md;
5. only source and tests required by D/E/F.

Before editing, report:
- exact authorized outcome;
- writable paths;
- prohibited paths;
- required validation;
- stop conditions;
- existing user changes.

Materialize source before writing G/H/I unless a D/E/F stop condition prevents implementation. If blocked, report the exact gate rather than manufacturing evidence. Never treat G/H/I-only editing as successful implementation.

Do not commit or push unless the invoking task explicitly authorizes it.
```

---

# 11. PDR-00 — Permanent Domain Reconciliation Protocol

```text
Run PDR-00 as the shared protocol for a functional-domain permanent-memory update.

First run the role initializer named by the selected PDR prompt, then PMC-01. Run PMC-02 only when routing, authority, knowledge-state, or promotion confidence is uncertain or possibly stale.

Resolve the active branch from the explicit task. If the task omits it, verify repository state against 06_SESSION_SCHEME.md before any write. Never silently use the default branch.

Recover in this order:
1. 00_PROJECT_STATE.md and 06_SESSION_SCHEME.md;
2. the role's permanent checkpoint;
3. the latest chronological reconciliation section in [M]_STAGE/J_MAIN_STAGE.md;
4. the role's paired functional stage and Codex evidence report;
5. the role's permanent files from their latest temporal marker forward;
6. older permanent content or source only when the latest segment is insufficient or drift is suspected.

The latest J section supplies Main orientation, not automatic promotion. Compare it with the paired stage/evidence files and repository truth where necessary.

Classify every material claim as one of:
- proposed;
- provisional;
- accepted;
- implemented;
- validated;
- host-unvalidated;
- blocked;
- deferred.

Preserve disagreements and defects. Do not convert generated structure, a passing unit test, or a Main preference into broader platform or production validation.

Temporal-marker rule for each authorized permanent file:

1. Find the final occurrence of TEMPORAL_MARKER: in the file.
2. Count lines after that marker. If no marker exists, count the complete file.
3. If more than 800 lines exist after the latest marker, insert a new marker at the current end before appending the reconciliation.
4. Derive the marker ID from the active cycle, sprint, role, and current date. Use:

   <!-- TEMPORAL_MARKER:CYCLE-SPRINT-ROLE-DATE -->
   > Temporal boundary — permanent-domain reconciliation entry. Content above belongs to the preceding reviewed segment; content below belongs to the newly reconciled domain state.

5. Do not insert a marker when the post-marker segment contains 800 lines or fewer.
6. Do not relocate an old marker, split a file, rewrite history, or treat line count alone as authorization to create a new file.
7. Report the files checked, line counts after their latest markers, and any new marker IDs.

Append or minimally amend according to each file's semantic role:
- canonical files receive stable accepted knowledge only;
- checkpoints receive concise current state;
- derived files receive rebuildable explanations or maps;
- observational files remain append-oriented;
- KANBAN changes require explicit evidence.

Before writing, state:
- exact input files;
- exact writable files;
- latest J section selected;
- evidence boundary;
- anticipated temporal-marker actions.

After writing:
- inspect the diff;
- confirm no unlisted files changed;
- commit only the role-owned permanent files when the invoking task authorizes commit;
- pull/rebase safely before push if the remote branch advanced;
- never force-push;
- report commit SHA, changed files, marker actions, classifications, unresolved conflicts, and clean status.

PDR-00 does not authorize source, methodology, Main-root, J, D/E/F, G/H/I, or another domain's files.
```

---

# 12. PDR-O — Operational Permanent Reconciliation

```text
Initialize through PRI-O and run PMC-01. Run PMC-02 only if its confidence gate is triggered. Then run PDR-00 with Operational scope.

Required evidence pair:
- DEV_STAGE/A_OPERATIONAL.md;
- DEV_STAGE/G_OPS_CODEX.md.

Main orientation:
- the latest chronological reconciliation section in [M]_STAGE/J_MAIN_STAGE.md.

Authorized permanent outputs:
- operational/04_TODO.md;
- operational/10_OPERATIONAL_STATE.md;
- operational/11_OPERATIONAL_RECORD.md;
- operational/12_OPERATIONAL_MODEL.md.

Reconcile:
- commands, environment, reproducibility, and toolchain state;
- passed, failed, blocked, and host-unvalidated evidence;
- runtime, persistence, migration, packaging, and platform gates;
- generated-versus-handwritten ownership;
- data-isolation and rollback evidence;
- operational defects and risks;
- the next bounded validation sequence and its cost.

Semantic placement:
- 04_TODO: active gates and executable next work;
- 10_OPERATIONAL_STATE: concise current Operational checkpoint;
- 11_OPERATIONAL_RECORD: append-only events, commands, results, and observed failures;
- 12_OPERATIONAL_MODEL: stable technology-independent operational rules only.

Do not accept architecture, change Didactic maturity, perform Main synthesis, modify source, or broaden implementation authority.

If the invoking task authorizes publication, commit only the four Operational files and push the active branch without force.
```

---

# 13. PDR-A — Didactic Permanent Reconciliation

```text
Initialize through PRI-A and run PMC-01. Run PMC-02 only if its confidence gate is triggered. Then run PDR-00 with Didactic scope.

Required evidence pair:
- DEV_STAGE/B_DIDACTIC.md;
- DEV_STAGE/H_DDC_CODEX.md.

Main orientation:
- the latest chronological reconciliation section in [M]_STAGE/J_MAIN_STAGE.md.

Authorized permanent outputs:
- didactics/02_KANBAN.md;
- didactics/07_GLOSSARY.md;
- didactics/08_CONCEPT_MAP.md;
- didactics/13_LECTURE_REGISTER.md.

Reconcile:
- concepts introduced by planning versus concepts evidenced by implementation;
- learner-facing distinctions exposed by J and H;
- executable evidence and its limits;
- vocabulary and conceptual dependencies;
- misunderstandings, unresolved questions, and next learning boundary;
- maturity changes only where promotion evidence satisfies the KANBAN rules.

Semantic placement:
- 02_KANBAN: canonical concept identity and evidence-backed maturity;
- 07_GLOSSARY: concise derived terminology;
- 08_CONCEPT_MAP: current conceptual checkpoint and dependencies;
- 13_LECTURE_REGISTER: append-only learning events and evidence history.

Explicitly distinguish local implementation from platform validation, offline queue preparation from synchronization, fixture examples from a complete protocol, and generated code from handwritten design.

Do not select architecture, claim Operational acceptance, perform Main synthesis, modify source, or infer maturity from file existence.

If the invoking task authorizes publication, commit only the four Didactic files and push the active branch without force.
```

---

# 14. PDR-D — Design Permanent Reconciliation

```text
Initialize through PRI-D and run PMC-01. Run PMC-02 only if its confidence gate is triggered. Then run PDR-00 with Design scope.

Required evidence pair:
- DEV_STAGE/C_DESIGN.md;
- DEV_STAGE/I_DSN_CODEX.md.

Main orientation:
- the latest chronological reconciliation section in [M]_STAGE/J_MAIN_STAGE.md.

Authorized permanent outputs:
- design/01_ARCHITECTURE.md;
- design/03_DECISION_LOG.md;
- design/09_DESIGN_STATE.md;
- design/14_MODEL_OVERVIEW.md.

Reconcile:
- stable responsibility and dependency boundaries;
- implemented topology and invariants;
- physical implementation facts that remain observational;
- provisional dependencies, schemas, protocols, and identity rules;
- alternatives and development-cost tradeoffs;
- defects, drift, and decisions requiring Main or human resolution;
- recommended next bounded design route without converting recommendation into authority.

Semantic placement:
- 01_ARCHITECTURE: stable accepted architecture only;
- 03_DECISION_LOG: append-oriented alternatives, decisions, rationale, and reversibility;
- 09_DESIGN_STATE: concise current Design checkpoint;
- 14_MODEL_OVERVIEW: derived responsibility and model map.

Do not claim Operational validation, change Didactic maturity, perform Main synthesis, modify source, or treat generated framework structure as accepted product architecture by itself.

If the invoking task authorizes publication, commit only the four Design files and push the active branch without force.
```

---

# 15. MSU-01 — Main State-of-Union Review

```text
Initialize through PRI-M and run PMC-01. Run PMC-02 only when routing, authority, knowledge-state, or promotion confidence is uncertain or possibly stale. Then run MSU-01.

Purpose:
Produce a read-only Main state-of-union review before new J reconciliation, D/E/F preparation, permanent promotion, or implementation.

Resolve and verify:
- repository: gus-i-gu/markei;
- active branch from the explicit task or 06_SESSION_SCHEME.md;
- remote branch head and baseline ancestry;
- whether the inspected branch advanced beyond the commits named by Main continuity.

Read economically in this order:

1. 00_PROJECT_STATE.md — current accepted global state.
2. 06_SESSION_SCHEME.md — active sprint, milestone, human decisions, gates, and next route.
3. 05_SESSION_LOG.md — only the latest chronological segment needed to verify how the current state arose.
4. The latest chronological reconciliation section in [M]_STAGE/J_MAIN_STAGE.md.
5. DEV_STAGE/A_OPERATIONAL.md.
6. DEV_STAGE/B_DIDACTIC.md.
7. DEV_STAGE/C_DESIGN.md.
8. Any task-named D/E/F or G/H/I evidence.
9. Relevant permanent-domain checkpoints:
   - operational/10_OPERATIONAL_STATE.md;
   - didactics/08_CONCEPT_MAP.md;
   - design/09_DESIGN_STATE.md.
10. Bounded repository inspection for claims that documentation alone cannot establish.

Repository inspection must begin with:
- branch/head comparison;
- changed-file inventory since the last Main reconciliation;
- source/test topology relevant to the active milestone;
- dependency manifests and entrypoints;
- implementation files named by J, 06, or A/B/C;
- test/build evidence already committed.

Do not read generated files line by line unless generator drift is the direct question. Review generated ownership through source schema/configuration, dependency locks, regeneration commands, and validation evidence.

Compare the sources and report:

A. Current authority
- active cycle, sprint, branch, baseline, and latest reconciled commit;
- current phase and whether D/E/F or implementation is active.

B. Accepted state
- stable product, domain, architecture, operational, and methodological decisions.

C. Materialized evidence
- implemented source;
- passed tests/builds;
- generated-but-unvalidated targets;
- preserved legacy boundaries.

D. Provisional or defective state
- suspected defects;
- incomplete contracts;
- host/toolchain blockers;
- questions that still require human definition.

E. A/B/C agreement and conflict
- Operational recommendation;
- Didactic evidence/maturity boundary;
- Design recommendation;
- contradictions, stale reports, or missing staging.

F. Human decisions
- decisions already supplied and their exact effect;
- remaining choices;
- host changes or external accounts requiring explicit permission.

G. Next valid route
- the smallest coherent milestone;
- work that must remain deferred;
- whether Main may now prepare J, 00/05/06, or D/E/F.

For every claim use one of:
proposed, provisional, accepted, implemented, validated, host-unvalidated, blocked, deferred.

State-of-union output must end with:

```text
Ready now:
Not ready:
Human action:
Main next write:
Implementation authority:
```

MSU-01 is read-only. It does not authorize:
- changes to J, 00, 05, or 06;
- A/B/C, D/E/F, or G/H/I edits;
- permanent-domain promotion;
- source changes;
- tool installation;
- commits, pushes, provisioning, or external accounts.

A separate invoking instruction must name exact writable files and authorize the next transition.
```

---

# 16. MSU-02 — Functional State-of-Union Exploration

```text
Run MSU-02 as one functional chat: Operational [O], Didactic [A], or Design [D].

Initialize through the matching PRI prompt and run PMC-01. Run PMC-02 only when routing, authority, knowledge-state, or promotion confidence is uncertain or possibly stale.

Purpose:
At the beginning of a sprint or investigation phase, recover Main orientation, inspect the current application repository through one functional competence, and produce the corresponding temporary A/B/C stage for later Main reconciliation.

This is functional exploration before D/E/F. It is not Main synthesis, permanent promotion, or implementation.

Resolve and verify:
- repository: gus-i-gu/markei;
- active branch from the invoking task or 06_SESSION_SCHEME.md;
- current remote branch head and baseline ancestry;
- paired role and stage:
  [O] → DEV_STAGE/A_OPERATIONAL.md
  [A] → DEV_STAGE/B_DIDACTIC.md
  [D] → DEV_STAGE/C_DESIGN.md.

Primary recovery — required:

1. Read the latest chronological reconciliation section in [M]_STAGE/J_MAIN_STAGE.md.
2. Read 00_PROJECT_STATE.md.
3. Read only the latest relevant segment of 05_SESSION_LOG.md.
4. Read the active forward checkpoint in 06_SESSION_SCHEME.md.
5. State the recovered cycle, sprint, accepted state, human decisions, open defects, deferred work, and current authority boundary.

Hierarchical descent — only when required:

Read the role checkpoint first:
- [O] operational/10_OPERATIONAL_STATE.md;
- [A] didactics/08_CONCEPT_MAP.md;
- [D] design/09_DESIGN_STATE.md.

Read other permanent-domain files only when:
- the checkpoint is stale, contradictory, or insufficient;
- exact canonical, derived, observational, or maturity history is necessary;
- J or Main-root continuity explicitly points to unresolved domain knowledge.

Report which insufficiency justified every deeper permanent read. Do not update permanent files during MSU-02.

Repository exploration — required and read-only:

Inspect both preserved and new application boundaries where relevant:

- Python/PySide6 beta under app/ and its tests, entrypoints, database boundary, and dependency/configuration surfaces;
- Flutter/Dart client under clients/markei_flutter/;
- shared contract examples/schema under contracts/;
- manifests, lockfiles, application entrypoints, handwritten domain/application/infrastructure source, schema definitions, and tests;
- Git changed-file/topology evidence relevant to the active sprint.

Do not read generated files line by line unless generator drift is the direct subject. Distinguish handwritten source, generated source, build output, local data, fixtures, and documentation.

Role-specific exploration:

Operational [O]:
- environment and toolchain prerequisites;
- reproducible commands;
- build/run/test state;
- runtime and persistence paths;
- database isolation, migrations, rollback, lifecycle, packaging, blockers, and cost;
- exact evidence required for the next materialization.

Didactic [A]:
- concepts currently represented in source/tests;
- planning concepts versus implemented examples;
- language/framework/dependency knowledge newly required;
- misleading equivalences or terminology;
- learner-evidence gaps and KANBAN implications without changing maturity;
- smallest teaching boundary for the next unit.

Design [D]:
- responsibility and dependency boundaries;
- domain models, identifiers, invariants, transaction ownership, schema responsibilities, and contract shapes;
- implemented topology versus intended architecture;
- defects, drift, alternatives, reversibility, and development-cost tradeoffs;
- design questions that D/E/F must resolve.

Evidence classification:

For each claim use:
- proposed;
- provisional;
- accepted;
- implemented;
- validated;
- host-unvalidated;
- blocked;
- deferred.

Required report structure in the paired A/B/C stage:

1. Header: role, cycle, sprint, branch, inspected head, date, and sources.
2. Recovered Main state.
3. Hierarchical-recovery path and deeper reads with justification.
4. Repository surfaces inspected.
5. Role-specific current state of union.
6. Agreement with J/00/05/06.
7. Drift, defects, contradictions, and stale documentation.
8. Human decisions already supplied.
9. Questions requiring Main or human resolution.
10. Recommended next bounded materialization scope.
11. Explicit non-goals.
12. Evidence matrix: claim, classification, source.
13. Proposed D/E/F gates relevant to the role.
14. Final concise handoff to Main.

Write authority:

MSU-02 invocation authorizes replacing the active contents of exactly one paired temporary stage:
- [O] may write only A_OPERATIONAL.md;
- [A] may write only B_DIDACTIC.md;
- [D] may write only C_DESIGN.md.

The stage must describe the current investigation and supersede stale earlier staging while preserving important contrary findings inside the new report.

MSU-02 does not authorize:
- source, test, fixture, schema, dependency, or generated-file changes;
- running installation, provisioning, migration, packaging, or destructive commands;
- J, 00, 05, 06, D/E/F, G/H/I, methodology, or permanent-domain edits;
- KANBAN maturity changes;
- architecture acceptance outside Design recommendation;
- implementation.

Before writing, report the exact paired stage path. After writing:
- inspect the diff;
- confirm only that stage changed;
- commit the single stage when the invocation targets the shared GitHub branch;
- pull/rebase safely if the remote advanced;
- push without force;
- report commit SHA, stage path, inspected head, deeper reads, unresolved questions, and clean status.

MSU-02 outputs A/B/C for subsequent MSU-01 Main review and J reconciliation.
```

---

<!-- TEMPORAL_MARKER:C07-S04-METHODOLOGY-PDR2-2026-07-12 -->
> Temporal boundary — Permanent Reconciliation v2 introduction. Content above preserves the first prompt-collection generation; content below introduces the checkpoint-centered post-Codex route.

# 17. PDR2-INDEX — Permanent Reconciliation v2

PDR2 supersedes PDR-00/PDR-O/PDR-A/PDR-D for ordinary post-Codex permanent-domain reconciliation.

The first-generation PDR prompts remain historical and callable only when an explicit task requires them.

## PDR2 prompt index

| ID | Role | Required evidence | Permanent outputs |
| --- | --- | --- | --- |
| `PDR2-00` | Shared protocol | checkpoint + G/H/I + latest J + repository + A/B/C context | four semantic roles |
| `PDR2-O` | Operational [O] | G + J + execution truth + A | 12 canonical, 04 derived, 11 observational, 10 checkpoint |
| `PDR2-A` | Didactic [A] | H + J + code/test concepts + B | 02 canonical, 07 derived, 13 observational, 08 checkpoint |
| `PDR2-D` | Design [D] | I + J + architecture truth + C | 01 canonical, 14 derived, 03 observational, 09 checkpoint |

Default post-Codex call:

```text
Run PDR2-[ROLE] against the active branch.
```

---

# 18. PDR2-00 — Checkpoint-Centered Permanent Reconciliation

```text
Run SEQ-PRM-04, then run PDR2-00 through the selected role prompt PDR2-O, PDR2-A, or PDR2-D.

Purpose:
Translate Codex evidence and repository truth into complete permanent-domain memory while making the checkpoint the cheapest reliable recovery surface.

This is post-Codex classification and promotion.
It is not implementation or Main-root reconciliation.

BOOT

1. Initialize through the matching PRI role.
2. Run PMC-01.
3. Run PMC-02 only if routing, authority, knowledge-state, or promotion confidence is uncertain or stale.
4. Verify repository, active branch, remote head, baseline ancestry, and clean/non-overlapping worktree.

REQUIRED RECOVERY ORDER

1. Read the role checkpoint first.
2. State what the checkpoint currently claims.
3. Read the paired G/H/I Codex report completely.
4. Read the latest chronological J reconciliation section.
5. Read the paired A/B/C stage for pre-materialization intent and contrary findings.
6. Inspect the repository implementation and tests under the role’s competence.
7. Read the remaining three permanent role files from their latest temporal marker forward.
8. Read older permanent content only when canonical history, a contradiction, or semantic ownership cannot otherwise be resolved.

The checkpoint is an entry hypothesis, not automatic truth.
G/H/I is evidence, not automatic promotion.
J is Main reconciliation, not a replacement for domain classification.
Repository truth resolves implementation claims.
A/B/C preserves intended gates and alternatives.

REQUIRED CROSS-CHECK

Compare:

- checkpoint claim;
- Codex report;
- latest J classification;
- source/test/build truth;
- pre-materialization A/B/C expectation;
- existing canonical, derived, and observational memory.

Report:

- confirmed knowledge;
- stale checkpoint claims;
- implementation/documentation drift;
- missing evidence;
- conflicts;
- accepted resolutions;
- unresolved questions for Main/human.

CLAIM VOCABULARY

Use only:

proposed, provisional, accepted, implemented, validated, host-unvalidated, blocked, deferred.

Do not collapse:
- generated into validated;
- unit-tested into platform-validated;
- local queue into synchronization;
- schema validation into semantic parity;
- Main preference into implementation authority;
- Codex report into learner evidence.

FOUR-ROLE REDACTION ORDER

Update all four semantic roles in this order:

1. Observational
   - append the event, commands, evidence, failures, deviations, and chronology;
   - never rewrite accepted history merely to simplify it.

2. Canonical
   - add or minimally amend stable accepted rules only;
   - exclude temporary commands, host accidents, speculative implementation details, and duplicate explanations;
   - explicitly record no canonical change when evidence is insufficient.

3. Derived
   - regenerate the current explanation/map/TODO from accepted canon, current evidence, and unresolved work;
   - remove stale derived statements;
   - derived content may be rewritten because it is rebuildable.

4. Checkpoint
   - rewrite last, after the other three roles are reconciled;
   - summarize current truth and recovery pointers;
   - do not append a second competing current-state narrative.

Every PDR2 run must review all four files.
A file may remain textually unchanged only when the final report states why its semantic role received no new knowledge.

CHECKPOINT RECOVERY-ECONOMY CONTRACT

The checkpoint must:

- be the first domain recovery surface;
- remain compact, preferably at or below 250 lines after its latest temporal marker;
- state cycle, sprint, branch, inspected implementation head, evidence report, and latest J section;
- classify implemented, validated, host-unvalidated, defective, blocked, and deferred state;
- contain current accepted decisions and unresolved defects;
- state the next valid route and authority boundary;
- point to canonical, derived, observational, G/H/I, and J sources;
- omit long chronology, command transcripts, lecture prose, and full alternatives.

Checkpoint update rule:

1. Preserve the header and all content before the latest TEMPORAL_MARKER.
2. Replace the current checkpoint segment after that marker with one compact current checkpoint.
3. If no temporal marker exists, append a new marker after the prior content, then write the compact checkpoint.
4. Never use checkpoint rewriting to erase observational history; Git history and the observational file preserve chronology.
5. Ensure there is one unambiguous current-state section.

TEMPORAL-MARKER RULE FOR NON-CHECKPOINT FILES

- find the latest TEMPORAL_MARKER;
- count lines after it, or all lines if absent;
- when more than 800 lines follow it, add a new reviewed marker at the current end before appending;
- do not create a marker at 800 lines or fewer;
- report every count and marker action;
- line count alone never authorizes a new file.

REQUIRED FINAL AUDIT

Before committing:

- inspect all four diffs;
- verify semantic-role placement;
- search for stale claims contradicted by G/H/I or source;
- verify checkpoint pointers and inspected commit;
- verify only the four authorized permanent files changed;
- report files reviewed but unchanged.

Publication authority:

A direct PDR2 role invocation authorizes committing and pushing only that role’s four permanent files to the active branch.
Pull/rebase safely if remote advanced.
Never force-push.

Final response must report:

- commit SHA;
- four files and semantic roles;
- checkpoint line count and recovery pointers;
- evidence promoted;
- evidence retained as provisional/blocked/deferred;
- marker actions;
- repository surfaces inspected;
- conflicts and resolutions;
- remaining Main/human questions;
- clean status.
```

---

# 19. PDR2-O — Operational Complete Reconciliation

```text
Initialize as Operational Chat [O] and run PDR2-00.

Paired evidence:
- DEV_STAGE/G_OPS_CODEX.md
- latest J reconciliation
- DEV_STAGE/A_OPERATIONAL.md
- relevant environment, commands, dependencies, persistence, migration, runtime, build, packaging, and test truth.

Permanent roles:

Canonical:
- operational/12_OPERATIONAL_MODEL.md

Derived:
- operational/04_TODO.md

Observational:
- operational/11_OPERATIONAL_RECORD.md

Checkpoint:
- operational/10_OPERATIONAL_STATE.md

Required reconciliation:

- exact commands and outcomes;
- installed versus merely declared tools;
- source-level, database, platform, lifecycle, and packaging evidence;
- generated-source ownership and regeneration;
- data isolation, migration, rollback, failure recovery, and user-manual evidence;
- host blockers and operational cost;
- next executable gates.

Canonical receives stable operational rules.
TODO is rebuilt from remaining work and ordered gates.
Record appends the materialization event and failures.
Checkpoint is rewritten last as the compact current Operational truth.

Do not select architecture, alter KANBAN, edit source, or write Main files.
```

---

# 20. PDR2-A — Didactic Complete Reconciliation

```text
Initialize as Didactic Chat [A] and run PDR2-00.

Paired evidence:
- DEV_STAGE/H_DDC_CODEX.md
- latest J reconciliation
- DEV_STAGE/B_DIDACTIC.md
- relevant handwritten code, tests, contracts, dependencies, UI behavior, and executed examples.

Permanent roles:

Canonical:
- didactics/02_KANBAN.md

Derived:
- didactics/07_GLOSSARY.md

Observational:
- didactics/13_LECTURE_REGISTER.md

Checkpoint:
- didactics/08_CONCEPT_MAP.md

Required reconciliation:

- concepts planned versus represented versus executed;
- learner-facing distinctions exposed by implementation;
- fixture, schema, domain, transaction, platform, and generated-source evidence;
- maturity evidence and limits;
- misconceptions and remaining learning boundary;
- exact KANBAN evidence for any proposed transition.

KANBAN receives only canonical concept/maturity truth.
Glossary is regenerated as concise current terminology.
Lecture Register appends the learning/evidence event.
Concept Map is rewritten last as the compact current Didactic recovery checkpoint.

No maturity transition follows automatically from Codex work.
Do not select architecture, claim Operational acceptance, edit source, or write Main files.
```

---

# 21. PDR2-D — Design Complete Reconciliation

```text
Initialize as Design Chat [D] and run PDR2-00.

Paired evidence:
- DEV_STAGE/I_DSN_CODEX.md
- latest J reconciliation
- DEV_STAGE/C_DESIGN.md
- relevant handwritten topology, domain models, schema/migration, contracts, ports, UI composition, dependencies, and tests.

Permanent roles:

Canonical:
- design/01_ARCHITECTURE.md

Derived:
- design/14_MODEL_OVERVIEW.md

Observational:
- design/03_DECISION_LOG.md

Checkpoint:
- design/09_DESIGN_STATE.md

Required reconciliation:

- stable responsibilities, invariants, and dependency direction;
- materialized topology versus intended architecture;
- identity, transaction, schema, migration, contract, projection, and lifecycle ownership;
- alternatives, deviations, reversibility, and development cost;
- generated framework structure versus accepted product architecture;
- deferred distributed/cloud boundaries.

Architecture receives stable accepted design only.
Model Overview is regenerated from current accepted structure.
Decision Log appends decisions, alternatives, deviations, and rationale.
Design State is rewritten last as the compact current Design recovery checkpoint.

Do not claim Operational validation, alter Didactic maturity, edit source, or write Main files.
```

---

# 22. ERI-01 — Exploratory Repository Investigation

```text
Run SEQ-INV-02, then run ERI-01: Exploratory Repository Investigation.

Purpose:
Recover current application structure retrospectively from repository truth and prepare designation-specific evidence for cumulative functional staging.

Applicable roles:
- Operational Chat [O];
- Didactic Chat [A];
- Design Chat [D].

Initialize through PRI-O, PRI-A, or PRI-D.
Run PMC-01.
Run PMC-02 when routing, promotion, knowledge state, or authority is uncertain.
Run the applicable state-of-union prompt, then ERI-01.

On the first invocation in a cycle, read completely and sequentially:
1. AGENTS.md;
2. INDEX.md;
3. PROMPT_COLLECTION.md;
4. METHOD_FOUNDATIONS.md;
5. FLUX.md;
6. PROMOTION_RULES.md;
7. CHAT_PROTOCOL.md;
8. CHAT_BEHAVIOUR.md;
9. METHOD_GLOSSARY.md.

On later rounds, reuse PROMPT_COLLECTION and the role initializer. Reopen complete methodology only when drift or contradiction requires it.

Resolve and verify:
- repository;
- required branch;
- expected baseline;
- remote HEAD and ancestry;
- local changes where a checkout exists.

Never silently inspect the default branch.
Never discard, stash, reset, clean, overwrite, or force-push user work.

Scan the complete tracked repository topology before limiting inspection to the active feature.

Identify:
- entrypoints and source roots;
- manifests and lockfiles;
- handwritten and generated code;
- domain entities and value objects;
- application commands, services, ports, and queries;
- repository and persistence adapters;
- schemas, tables, indexes, and migrations;
- UI, navigation, and state ownership;
- tests, fixtures, and validation helpers;
- contracts and serialization;
- platform hosts;
- packaging and distribution;
- scripts, automation, and configuration;
- ignored/generated artifacts;
- protected legacy implementations;
- current and deferred architecture.

Inspect generated code through its generator, schema, or configuration. Read generated output directly only when drift or runtime behavior requires it.

For every relevant component, record:
- exact path;
- symbol/structure name and type;
- responsibility;
- important functions and methods;
- parameters and returned results;
- important variables and fields;
- classes, models, records, and value objects;
- inputs, outputs, callers, and consumers;
- owner and lifetime;
- dependencies;
- persistence and side effects;
- validation and tests;
- evidence state;
- defects and debt;
- active-cycle relevance;
- deferred-cycle relevance;
- confidence and evidence source.

For a relevant function or method, report:
- name, path, owner;
- parameters and result;
- state read and changed;
- errors/failure outcomes;
- transaction boundary;
- callers and tests;
- limitations.

For a relevant variable, field, or object, report:
- name, path, type, and meaning;
- owner, lifetime, and mutability;
- identity role;
- persistence status;
- constraints;
- related structures;
- user-facing visibility.

Operational prioritizes:
commands, environments, builds, tests, runtime, persistence, migrations, transactions, recovery, packaging, lifecycle, costs, failure states, and evidence.

Didactic prioritizes:
vocabulary expressed by types, fields, functions, and UI; concepts, misleading names, KANBAN ownership, and project-versus-learner evidence.

Design prioritizes:
responsibility, dependency direction, identity, state, transaction, lifetime, invariants, alternatives, reversibility, and structural debt.

Output:
1. branch and HEAD;
2. methodology/recovery report;
3. topology;
4. component index;
5. function index;
6. variable/object/structure index;
7. implementation/evidence state;
8. defects and contradictions;
9. active-cycle capacity;
10. prospective additions;
11. deferred work;
12. exact evidence paths.

ERI-01 is read-only.
It authorizes no source, schema, dependency, host, infrastructure, permanent-memory, J, D/E/F, commit, or push operation.
```

---

# 23. FCA-02 — Functional Cumulative Append

```text
Run SEQ-INV-02, then run FCA-02: Functional Cumulative Append.

Purpose:
Append one new functional-investigation round to the role's designated A/B/C file while preserving earlier rounds.

Designated files:
- Operational [O]: DEV_STAGE/A_OPERATIONAL.md;
- Didactic [A]: DEV_STAGE/B_DIDACTIC.md;
- Design [D]: DEV_STAGE/C_DESIGN.md.

A/B/C are append-only and cumulative during the exploratory cycle.

Preserve every earlier round.
Never replace, rewrite, or delete an earlier round.
Correct an earlier claim through a later correction.
Mark superseded claims explicitly.
Avoid reproducing unchanged material in full.

Use:
<!-- ROUND_MARKER:CYCLE-ROUND-ROLE-DATE -->
# Cycle [cycle] Round [round] — [role] Investigation

Before appending:
1. run the role initializer;
2. run PMC-01;
3. run PMC-02 when required;
4. run ERI-01;
5. read the latest J reconciliation;
6. read the paired provisional D/E/F tail;
7. read the role checkpoint;
8. read the preceding paired A/B/C round;
9. inspect repository truth required by new questions.

A/B/C must cumulatively preserve repository-derived knowledge.

Across rounds, index:
- paths and components;
- functions and methods;
- parameters and results;
- variables and fields;
- classes, models, records, and value objects;
- state and lifetime ownership;
- dependencies and callers;
- schemas, constraints, and migrations;
- UI structures and vocabulary;
- transactions and side effects;
- tests and validation;
- defects and debt;
- prospective additions.

Tie material claims to exact repository structures.

Every round distinguishes:
- newly inspected;
- retained;
- corrected;
- superseded;
- contradicted;
- unresolved;
- prospective;
- deferred.

Required round structure:
1. identity and authority;
2. inputs and repository HEAD;
3. new repository evidence;
4. component/function/object additions;
5. retained conclusions;
6. corrections;
7. confrontation with latest J;
8. confrontation with paired D/E/F;
9. cross-domain consequences;
10. prospective additions;
11. risks and non-goals;
12. human decisions;
13. recommendation to Main;
14. next route.

For each prospective addition, state:
- problem;
- proposed responsibility;
- likely owner/layer;
- existing structures affected;
- possible files/surfaces;
- dependency consequence;
- schema/migration consequence;
- validation;
- reversibility;
- alternatives;
- provisional reason.

Operational writes only A.
Didactic writes only B.
Design writes only C.

FCA-02 authorizes no source, permanent-domain, methodology, another stage, J, D/E/F, or Codex change.

When publication is separately authorized:
- commit only the paired A/B/C file;
- use one narrow commit;
- reconcile remote advancement safely;
- never force-push;
- report commit SHA and path.
```

---

# 24. MJR-03 — Main J Reconciliation and Structural Grouping

```text
Run SEQ-INV-02, then run MJR-03: Main J Reconciliation and Structural Grouping.

Role:
Main Chat [M].

Purpose:
Append a new J reconciliation that synthesizes the latest A/B/C rounds, prunes semantic duplication through grouping, preserves provenance/disagreement, builds a current structural model, adds prospective views, and prepares the next D/E/F enrichment.

Designated file:
[M]_STAGE/J_MAIN_STAGE.md

J is append-only and cumulative during exploratory work.

Preserve previous reconciliations.
Append one marked reconciliation.
Never silently rewrite an earlier round.
Correct earlier synthesis explicitly.
Avoid reproducing A/B/C verbatim.

Use:
<!-- RECONCILIATION_MARKER:CYCLE-ROUND-DATE -->
# Cycle [cycle] Round [round] — Main Reconciliation

Read:
1. PRI-M and PMC-01;
2. PMC-02 when required;
3. latest A round;
4. latest B round;
5. latest C round;
6. preceding J reconciliation;
7. current provisional D/E/F tails;
8. relevant checkpoints;
9. repository truth needed for contradictions.

Pruning means semantic compression, not deletion.

Group repeated facts under one structural object.
Preserve A/B/C provenance.
Retain designation-specific interpretations.
Identify one semantic owner.
Keep contradictions explicit.
Point to A/B/C for detail.
Never turn a proposal into acceptance.

Group knowledge by structures such as:
- entrypoint and composition;
- presentation/navigation;
- application commands and query ports;
- domain entities and value objects;
- Catalogue/Product identity;
- Store identity;
- Purchase draft and registered aggregate;
- persistence, schema, and migrations;
- History projections;
- analytics;
- platform hosts;
- tests and validation;
- protected legacy boundary;
- deferred synchronization.

For every group, synthesize:
- repository facts;
- functions/methods;
- variables/objects;
- accepted responsibilities;
- unresolved ownership;
- defects and debt;
- evidence;
- prospective additions;
- cross-domain consequences.

Classify each conclusion:
- repository fact;
- accepted carried boundary;
- provisional synthesis;
- prospective addition;
- contradicted;
- blocked;
- deferred;
- human decision required.

For every prospective addition, report:
- responsibility;
- likely layer and owner;
- existing components affected;
- possible structures;
- schema/dependency implications;
- validation;
- alternatives;
- reversibility;
- unresolved human choice.

Do not invent filenames unless repository structure or authority supports them.

Required structure:
1. identity and inputs;
2. HEAD and stage versions;
3. accepted baseline;
4. new repository facts;
5. grouped structural model;
6. agreements;
7. contradictions;
8. corrections to previous J;
9. prospective additions;
10. schema/dependency/migration outlook;
11. product/vocabulary decisions;
12. validation outlook;
13. human decisions;
14. deferrals;
15. next D/E/F instructions;
16. next A/B/C round;
17. authority state.

State:
PROVISIONAL MAIN SYNTHESIS — NOT AUTHORIZED FOR CODEX

MJR-03 authorizes no source implementation, permanent promotion, or Codex execution.
```

---

# 25. MDE-04 — Main Consecutive D/E/F Enrichment

```text
Run SEQ-INV-02, then run MDE-04: Main Consecutive D/E/F Enrichment.

Role:
Main Chat [M], after MJR-03.

Purpose:
Append a provisional enrichment round to D/E/F using the latest cumulative A/B/C rounds, latest J reconciliation, repository evidence, and preceding D/E/F round.

Designated files:
- DEV_STAGE/D_OPS_STAGE.md;
- DEV_STAGE/E_DDC_STAGE.md;
- DEV_STAGE/F_DSN_STAGE.md.

D/E/F are append-only during exploratory staging.

Preserve prior provisional rounds.
Append one marked round.
Never silently replace an alternative/instruction.
Classify retained, corrected, superseded, rejected, and new material.
Avoid copying unchanged content.

Use:
<!-- ENRICHMENT_MARKER:CYCLE-ROUND-DOMAIN-DATE -->
# Cycle [cycle] Round [round] — Provisional [domain] Enrichment

Every round begins:
Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
Purpose: Domain confrontation; no implementation authority

Before appending:
1. run PRI-M and PMC-01;
2. run PMC-02 when required;
3. recover latest MJR-03;
4. read latest A/B/C rounds;
5. read preceding D/E/F round;
6. inspect repository truth needed for exact claims;
7. preserve unresolved human decisions.

Pairing:
- D derives primarily from latest A + J + execution evidence;
- E derives primarily from latest B + J + vocabulary/UI evidence;
- F derives primarily from latest C + J + structural evidence.

D appends:
- repository preflight;
- validation surfaces and proposed commands;
- tests/lifecycle gates;
- failure injection;
- migration/recovery;
- volume/performance;
- backup/export;
- costs and stop conditions;
- relevant paths, functions, objects, tests;
- Operational contradictions.

E appends:
- accepted/provisional vocabulary;
- terms linked to repository fields/functions/UI;
- validation/success/failure/retry/recovery language;
- conceptual ownership;
- misleading language;
- analytics claim limits;
- learner evidence;
- terminology decisions;
- no maturity promotion.

F appends:
- responsibility map;
- classes, functions, models, ports, adapters;
- state ownership/lifetime;
- identity/transaction invariants;
- prospective structures;
- dependency direction;
- schema/migration consequences;
- alternatives/reversibility;
- bounded unit candidates;
- architecture decisions.

Every prospective structure records:
- repository problem;
- proposed responsibility;
- existing/missing owner;
- relevant functions/objects;
- affected surfaces;
- state lifetime;
- dependency direction;
- persistence and migration impact;
- tests;
- Operational cost;
- Didactic vocabulary effect;
- alternatives;
- reversibility;
- status.

Classify:
- retained;
- corrected;
- superseded;
- newly added;
- rejected;
- awaiting human decision;
- ready for confrontation.

End each append with:
1. paired-domain questions;
2. evidence requested next;
3. contradictions;
4. decisions Main cannot infer;
5. next-enrichment conditions;
6. confirmation that Codex is inactive.

Append-only provisional D/E/F is not executable.

Codex remains prohibited until separate final activation:
- identifies controlling D/E/F sections;
- marks superseded provisional sections;
- names writable files and outcomes;
- supplies validation and rollback;
- resolves or carries human decisions;
- states implementation authority unambiguously.

Until activation:
D/E/F = exploratory Main staging
D/E/F ≠ Codex authority
```

---

# 26. Sequence Protocol Prompt Index

The SEQ prompts select one FLUX Sequence Protocol and enforce localized methodology reading.

| ID | FLUX protocol | Use |
| --- | --- | --- |
| SEQ-ORD-01 | FLX-ORD-01 | Run one bounded ordinary investigation-to-materialization unit |
| SEQ-INV-02 | FLX-INV-02 | Run one cumulative investigative inner-cycle round |
| SEQ-PRN-03 | FLX-PRN-03 | Prune and regenerate permanent memory without inventing truth |
| SEQ-PRM-04 | FLX-PRM-04 | Classify, promote, and reconcile knowledge semantically |

Shared localized boot:

1. Read AGENTS.md.
2. Read INDEX.md.
3. Read this prompt.
4. Read FLUX.md FLX-SEQ-00.
5. Read only the selected FLUX protocol.
6. Read PROMOTION_RULES.md PRC-01.
7. Read deeper methodology only for a named uncertainty that the selected sections cannot resolve.
8. Report every deeper section read and why.

---

# 27. SEQ-ORD-01 — Ordinary Sequence Invocation

~~~text
Run SEQ-ORD-01 under FLX-ORD-01.

Use the shared localized boot.

State:
- bounded objective;
- role and authority;
- branch and baseline;
- checkpoint recovery route;
- A/B/C scope;
- Main synthesis requirement;
- controlling D/E/F requirement;
- Codex validation and G/H/I requirement;
- FLX-PRM-04 post-evidence route;
- writable and prohibited surfaces;
- stop conditions.

Reject the Ordinary Sequence if repeated exploration, unresolved human decisions, stale permanent memory, or ambiguous materialization authority prevents one bounded pass.

Do not introduce J unless cross-domain reconciliation or accumulated context requires it.

End with the Sequence Handoff Envelope from FLUX.
~~~

---

# 28. SEQ-INV-02 — Investigative Sequence Invocation

~~~text
Run one FLX-INV-02 investigative round.

Use the shared localized boot.

Before investigation, read:
- latest relevant active-J reconciliation;
- paired provisional D/E/F cache;
- role checkpoint;
- preceding paired A/B/C round;
- exact repository surfaces required by the new question.

Functional roles:
- run ERI-01 for repository truth;
- run FCA-02 to append only the new paired A/B/C delta.

Main:
- run MJR-03 to group and reconcile the newest A/B/C deltas into J;
- run MDE-04 to compress active domain findings and next questions into provisional D/E/F;
- publish the narrower next-round question.

Every output must classify retained, new, corrected, superseded, contradicted, unresolved, prospective, and deferred claims.

Every round must reduce ambiguity, duplication, unknown repository surface, unbounded validation, or unresolved decision cost.

D/E/F remain PROVISIONAL — NOT AUTHORIZED FOR CODEX.

Do not promote, implement, edit permanent memory, or activate Codex during an investigative round.

End with:
- performance improvement achieved;
- evidence still requested;
- decisions Main cannot infer;
- next round or exit gate;
- Sequence Handoff Envelope.
~~~

---

# 29. SEQ-PRN-03 — Pruning Sequence Invocation

~~~text
Run FLX-PRN-03 for the named domain or Main-memory scope.

Use the shared localized boot.

For each file:
- state semantic role;
- identify canonical owner;
- identify stale, duplicated, misplaced, or expensive content;
- classify keep, summarize, reference, regenerate, correct, or remove;
- preserve observational history;
- route semantic changes to FLX-PRM-04.

Domain order:
1. inspect checkpoint as hypothesis;
2. reconcile and restructure canon;
3. regenerate/improve derived memory;
4. preserve or append observational history;
5. regenerate checkpoint last.

Main continuity follows only after domain work and only when global state changed.

Pruning does not promote proposals, rewrite history for convenience, create files from line count alone, or modify source.

Final report:
- files reviewed and changed;
- ownership decisions;
- pruned or referenced material;
- derivatives regenerated;
- history disposition;
- checkpoint size and pointers;
- unresolved promotion questions;
- next sequence;
- Sequence Handoff Envelope.
~~~

---

# 30. SEQ-PRM-04 — Promotion/Reconciliation Invocation

~~~text
Run FLX-PRM-04 and PROMOTION_RULES PRC-01.

Use the shared localized boot.

Complete the PRC-01 Required Classification Record for every material claim.

Verify:
- evidence and its boundary;
- current and target claim state;
- one semantic owner;
- canonical/derived/checkpoint/observational destination;
- contradictions;
- history disposition;
- human/Main authority;
- required derivative/checkpoint/Main regeneration.

For full domain reconciliation, update in this order:
1. observational;
2. canonical;
3. derived;
4. checkpoint;
5. Main continuity when affected.

A valid outcome may contain no canonical change.

Do not treat implementation, validation, Main preference, repeated staging, or file mutation as automatic promotion.

Use the applicable PDR2 role prompt for complete post-Codex domain reconciliation.

End with:
- claims promoted;
- claims retained as provisional, blocked, deferred, host-unvalidated, contradicted, or superseded;
- files and semantic roles;
- history preserved;
- next authority boundary;
- Sequence Handoff Envelope.
~~~

---

# 31. Maintenance Rule

This file should change when:

- role designations change;
- a stable recovery checkpoint changes;
- repeated prompt failures expose ambiguity;
- the ordinary boot becomes unnecessarily expensive;
- a new stable role requires an initializer.

It should not absorb:

- cycle-specific implementation instructions;
- complete copies of methodology rules;
- temporary branch state;
- long domain prompts;
- source-code procedures already owned by D/E/F or AGENTS.md.

When a prompt fails, Main should record:

```text
prompt ID
failure behavior
missing or ambiguous instruction
minimal correction
whether canonical methodology also requires revision
```


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
