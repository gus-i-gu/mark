# PROVISORY_[M]_DOUBLE_LAB.MD

> Status: Provisional lab bridge
> Authority: Main Chat + specialized methodology chat
> Scope: Temporary communication surface for Sketch Notebook system refinement
> Warning: This is not canonical methodology. It exists only for the current mid-sprint lab unless later promoted, registered, or removed.

---

# 1. Context

This provisional note summarizes recent Main Chat observations after Markei Cycle 03 and prepares a methodology-specialized chat to refine the Sketch Notebook system.

Cycle 03 successfully completed a full Sketch Notebook loop:

```text
A/B/C functional staging
→ D/E/F Main synthesis
→ Codex materialization
→ G/H/I Codex reports
→ O/A/D domain absorption
→ Main reconciliation
```

The application result was strong. The methodology result was promising but exposed file-growth and reconciliation issues.

---

# 2. Markei Cycle 03 Outcome

Implemented and reconciled:

- unified Lists page;
- internal views replacing public Storage / Shortage / Market tabs;
- embedded History analytics;
- service-owned Lists read model;
- service-owned History analytics read model;
- global latest/delta price display;
- no schema change;
- no mobile rewrite.

Current classification:

```text
Desktop architecture: improved and mostly stable, pending manual QA.
Mobile readiness: improved for future discussion, not ready for mobile implementation.
Methodology: successful but over-verbose.
```

---

# 3. Methodology Problem Exposed

The domain reports and domain-memory absorption were accurate but over-verbose.

Verbosity worked acceptably for ever-growing files, but caused concern for:

- checkpoints;
- derived files;
- global state summaries;
- future recovery cost.

The system needs a rule that distinguishes file semantic role from allowed growth behavior.

---

# 4. Proposed File Classes

## 4.1 Ever-growing

Append-oriented files preserving sequence and evidence.

Examples:

```text
05_SESSION_LOG.md
operational/11_OPERATIONAL_RECORD.md
didactics/13_LECTURE_REGISTER.md
design/03_DECISION_LOG.md
```

## 4.2 Refreshable

Current-state files rewritten or compactly refreshed.

Examples:

```text
00_PROJECT_STATE.md
06_SESSION_SCHEME.md
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

## 4.3 Derived / resorted

Files that reorganize or summarize canonical truth.

Examples:

```text
operational/04_TODO.md
didactics/07_GLOSSARY.md
design/14_MODEL_OVERVIEW.md
```

## 4.4 Canonical

Accepted truth owned by a domain.

Examples:

```text
operational/12_OPERATIONAL_MODEL.md
didactics/02_KANBAN.md
design/01_ARCHITECTURE.md
methodology/*.md
```

## 4.5 Forward checkpoint

A refreshable planning checkpoint for the next session.

Candidate:

```text
06_SESSION_SCHEME.md
```

---

# 5. Proposed Length Protocol

Candidate variables:

```text
SPRINT_READ_LIMIT = 800 lines
REPARTITION_REVIEW_LIMIT = 1300 lines
```

At 800 lines:

- define read-window policy;
- avoid full reread by default;
- prefer header + latest entry + targeted search.

At 1300 lines:

- perform repartition review;
- consider compaction, indexing, or Main-approved structural change.

Checkpoint guidance:

```text
Target: 200–300 lines
Review: near 400 lines
Failure: 800 lines
```

---

# 6. Proposed Reconciliation Protocol

## 6.1 Vertical reconciliation

Checks coherence through time and semantic maturity layers:

```text
observational evidence
↓
canonical / derived updates
↓
checkpoint refresh
↓
global project state
```

## 6.2 Horizontal reconciliation

Checks coherence across domains:

```text
Operational ↔ Design ↔ Didactics ↔ Main
```

Goal:

- complementary constraints;
- no duplicate canonical ownership;
- no cross-domain contradiction;
- clear ownership of shared terms.

---

# 7. 00_PROJECT_STATE.md Ambiguity

`00_PROJECT_STATE.md` is special.

It behaves both as:

1. global checkpoint;
2. Main-owned current-state canon.

Proposed term:

```text
Global State Canon-Checkpoint
```

This should be described in methodology, likely across:

```text
PROMOTION_RULES.md
FLUX.md
INDEX.md
METHOD_GLOSSARY.md
```

---

# 8. Main-Root Files Initialized

Main has now sample-initialized:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
```

Suggested roles:

- `00_PROJECT_STATE.md`: current global state and essential recovery context;
- `05_SESSION_LOG.md`: ever-growing session history;
- `06_SESSION_SCHEME.md`: forward checkpoint for next session agenda.

These files still require methodology registration and consistency review.

---

# 9. Structural Questions For Specialized Methodology Chat

1. Should `[M]_STAGE/J_MAIN_STAGE.md` become a permanent Main staging route?
2. Should `PROVISORY_[M]_DOUBLE_LAB.MD` remain a temporary lab bridge, be promoted, or be removed after use?
3. Should file-growth rules live in `FLUX.md`, a new protocol file, or both?
4. Should vertical/horizontal reconciliation live in `PROMOTION_RULES.md`, `FLUX.md`, or a new protocol file?
5. How should `00_PROJECT_STATE.md` be formally classified?
6. Should `INDEX.md` be updated immediately to register `06_SESSION_SCHEME.md`, `[M]_STAGE`, and this provisional file?
7. How should prompts enforce read-window policies after large files cross threshold?
8. How should canonical registers such as `didactics/02_KANBAN.md` be recovered without full reread?

---

# 10. Recommended Immediate Direction

Do not start a new Markei implementation feature until the Main-root and methodology-routing gaps are resolved or deliberately deferred.

Prioritize:

1. review this provisional lab bridge;
2. refine terminology with the specialized methodology chat;
3. patch `INDEX.md` for current root/stage surfaces;
4. patch `PROMOTION_RULES.md` for global state special class and reconciliation types;
5. patch `FLUX.md` for file-growth/read-window routing;
6. patch `METHOD_GLOSSARY.md` for new terms;
7. run a canon consistency audit after methodology routing is updated.
