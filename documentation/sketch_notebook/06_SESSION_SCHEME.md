# 06_SESSION_SCHEME.md

> Status: Forward checkpoint
> Authority: Main Chat
> Persistence class: Refreshable planning checkpoint
> Scope: Next-session agenda, expected files, unresolved decisions, and continuity frame

---

# 1. Next Session Focus

Begin with a short post-Cycle 04 verification session before opening another feature cycle.

Primary objective:

```text
Verify the remaining interactive and period-boundary risks without reopening completed Cycle 04 architecture.
```

Recommended sequence:

1. Human Settings save-feedback QA.
2. Human store create/update UI QA.
3. Verify first-weekday operational-month period-end labels.
4. Confirm dependent-page refresh after Settings save.
5. Decide whether any defect requires a small corrective materialization pass.

Do not begin a broad Cycle 05 feature stage until this verification result is recorded.

# 2. Current Closure State

Cycle 04 is closed as:

```text
materialized
validated at service/offscreen level
reconciled into Operational, Didactic, and Design memory
globally checkpointed by Main
```

Current implementation commit lineage includes:

- Cycle 04 materialization: `c9e9244a5187c32a2812641f05eac8856801a7d4`
- Operational reconciliation through `1491dcabc02cbba7ded947e233da11bea19eaa02`
- Didactic checkpoint reconciliation: `1e07b48c73708c44fbe8274ef977af1ffae947dc`
- Design reconciliation through `82142888065a53a3fde5c71c599a63a8debd7177`
- Main global closure follows these domain commits.

# 3. Recovery Route

Read only:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

Then consult the relevant domain checkpoint:

```text
Operational: documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
Didactic:    documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
Design:      documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

Read G/H/I or source only if verification or drift investigation requires them.

# 4. Verified Stable State

- Public tabs are Register, Lists, History, Settings.
- Settings owns configuration and store-editing surfaces.
- ProductService owns Settings validation, fallback, and interpretation.
- Repository owns generic settings persistence.
- Week boundary supports seven weekdays.
- Month boundary supports first weekday or day-of-month.
- Day-boundary time is persisted and validated.
- Date-only purchases are not shifted by day-boundary time.
- `pages.order` remains inert.
- No second-platform implementation was introduced.

# 5. Immediate Open Risks

Operational:

- interactive Settings validation-message behavior;
- store-editor interaction and refresh behavior;
- first-weekday period-end correctness;
- full UI regression coverage.

Existing application risks:

- invalid analytics date text behaves like omitted boundary;
- same-day average timelapse can be sub-day;
- multi-store analytics needs richer fixture validation;
- old inventory page files remain transitional;
- legacy month key and canonical keys may coexist;
- `pages.order` remains misleading persisted residue.

# 6. Deferred Decisions

Do not resolve without a new explicit cycle or correction stage:

- legacy month-key migration/removal;
- `pages.order` removal or implementation;
- purchase time-of-day storage;
- operational-day effects on Lists or predictions;
- Settings internal component split;
- second-platform architecture;
- broad external integration work.

# 7. Next Session Exit Criteria

A successful next session should leave one clear result:

1. Verification passes and Cycle 05 may be prepared.
2. A small defect is confirmed and a focused A/B/C -> D/E/F correction pass is prepared.
3. Verification remains incomplete and the exact missing human checks are recorded.

Avoid reopening already reconciled Cycle 04 decisions unless repository evidence contradicts them.
