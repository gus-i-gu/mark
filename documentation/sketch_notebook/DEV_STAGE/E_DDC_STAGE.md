# DEV_STAGE/E_DDC_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Scope: Cycle 04 didactic evidence capture for Settings boundary correction

---

# Cycle 04 Didactic Materialization Stage

## 1. Purpose

This stage gives Codex didactic reporting instructions for Cycle 04 Settings stabilization.

Codex must preserve learning evidence for Didactic Chat in:

```text
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
```

Codex must not edit permanent didactic files during this pass.

## 2. Required Bootstrap and Source Inputs

Read first:

- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/00_PROJECT_STATE.md`
- `documentation/sketch_notebook/06_SESSION_SCHEME.md`

Then read:

- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

Use `documentation/sketch_notebook/` as the active notebook root.

## 3. Didactic Invariants

Codex should preserve and report these distinctions:

- Settings values are configuration state, not the calculations themselves.
- SettingsPage edits preferences; services interpret preferences.
- Defaults are fallback contracts.
- Validation is separate from UI rendering.
- Enumerated choices should use stable semantic values, not only display labels.
- Time reference must be treated as a behavioral anchor, not as a vague label.
- Week/month grouping is time bucketing.
- Mobile readiness means stable contracts and boundaries, not mobile implementation.
- Placeholder fields are not working capabilities.

## 4. Concepts Codex Should Report for Didactic Chat

Report these as implementation evidence or concept candidates in `H_DDC_CODEX.md`.

Foundational concepts:

- Configuration State.
- Default Value as Fallback Contract.
- Validation Boundary.
- Time Reference as Behavioral Anchor.
- Time Bucketing.
- Mobile Readiness Without Rewrite.
- Adapter Boundary.
- Capability Versus Placeholder.

Language / implementation concepts:

- Enumerated Choice Values.
- Date/Datetime Boundary Handling.
- UI View State versus persisted Settings state.
- Platform-neutral settings/read-model shape.

Markei-specific concepts:

- Settings-Owned Preferences.
- History Grouping Service Responsibility.
- Service Contract Stability.
- ProductService-owned settings interpretation.
- Repository-owned settings persistence.

## 5. Learning Evidence Codex Should Capture

### Settings boundary evidence

Report where each responsibility ended up:

- SettingsPage UI controls.
- ProductService validation and interpretation.
- Repository persistence.
- SQLite key/value storage.
- HistoryPage/ListPage rendering only.

### Defaults and validation evidence

Report:

- what default values were introduced or preserved;
- how invalid values are handled;
- whether validation happens outside UI-only controls;
- how existing persisted values are preserved.

### Time reference evidence

Report:

- whether `time_reference.day_boundary_time` was persisted;
- whether it is validated as `HH:MM`;
- whether any current behavior consumes it;
- if not consumed, why the data model does not yet support material effect.

### Time bucketing evidence

Report:

- how seven-day week boundary support works;
- how month boundary mode works;
- where History grouping consumes these settings.

### Mobile-readiness evidence

Report only boundary preparation:

- stable semantic values;
- service-level interpretation;
- UI-label versus stored-value separation;
- no mobile implementation performed.

## 6. Concepts Not Ready for Canon

Codex should report these as deferred or unstable if they appear:

- mobile UI implementation;
- platform-specific mobile framework choices;
- active external service integration;
- receipt recognition;
- store deletion behavior;
- active `pages.order` tab ordering;
- permanent KANBAN promotion.

## 7. H_DDC_CODEX.md Report Shape

After materialization, write `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`.

Required sections:

1. Source stage files read.
2. Coding concepts exposed.
3. Concept candidates by marker.
4. Existing concepts reinforced.
5. Settings boundary evidence.
6. Defaults and validation evidence.
7. Time reference evidence.
8. Time bucketing evidence.
9. Service vs Repository vs UI responsibility evidence.
10. Mobile-readiness boundary evidence.
11. Concepts deferred / not ready for canon.
12. Didactic risks or remaining confusions.
13. Suggested Didactic Chat follow-up.

Keep the report compact and evidence-oriented. Do not reproduce long code. Do not edit permanent didactic files.
