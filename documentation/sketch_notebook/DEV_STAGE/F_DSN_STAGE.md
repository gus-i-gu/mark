# DEV_STAGE/F_DSN_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Scope: Cycle 04 architectural guardrails for Settings boundary correction

---

# Cycle 04 Design Materialization Stage

## 1. Purpose

This stage gives Codex design guardrails for Cycle 04 Settings stabilization.

It translates Design staging and Main synthesis into implementation boundaries. Permanent design files remain for later Design Chat absorption after Codex reports.

Codex must report design evidence into:

```text
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex must not edit methodology files or permanent design files during this pass.

## 2. Required Bootstrap and Source Inputs

Read first:

- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/00_PROJECT_STATE.md`
- `documentation/sketch_notebook/06_SESSION_SCHEME.md`

Then read:

- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`

Use `documentation/sketch_notebook/` as the active notebook root.

## 3. Accepted Design Decisions

- Settings is the user-facing configuration and store-management surface.
- SettingsPage owns controls, layout, edit events, and loading/saving UI state.
- SettingsPage must not own History grouping, Lists status, date interpretation, or future mobile semantics.
- ProductService owns validation and interpretation of behavior-affecting settings.
- Repository owns low-level persistence of key/value settings.
- SQLite owns persisted settings and existing application facts.
- `time_reference.day_boundary_time` is the accepted Cycle 04 key for the operational-day boundary preference.
- Week boundary and month boundary must use semantic values that can survive UI label changes.
- Mobile readiness means contract and boundary stabilization, not mobile implementation.

## 4. Responsibility Map

### SettingsPage owns

- rendering Settings controls;
- loading service-prepared current settings;
- collecting user edits;
- triggering save through service flow;
- rendering store create/update UI;
- keeping the store section compact where practical.

SettingsPage must not calculate History grouping or Lists status.

### ProductService owns

- setting validation;
- default fallback interpretation;
- History week boundary semantics;
- History month boundary semantics;
- operational-day boundary helper for `time_reference.day_boundary_time`;
- safe fallback when persisted settings are invalid;
- service-facing settings contract used by UI.

### Repository owns

- reading settings records;
- writing settings records;
- preserving existing key/value persistence behavior;
- row mapping or low-level retrieval support.

Repository must not decide History period semantics.

### SQLite/schema owns

- persisted settings rows;
- existing products, purchases, stores, and relationships.

Schema changes should be avoided unless implementation discovers a real blocker. Existing user data must be preserved.

### HistoryPage owns

- rendering grouped History output;
- refreshing after settings changes where current app flow supports it.

HistoryPage must not calculate week/month buckets directly.

### ListsPage owns

- rendering service-prepared list rows;
- refreshing after settings changes where relevant.

ListsPage must not interpret time reference in this pass.

### MainWindow owns

- public tab mounting;
- refresh orchestration;
- preserving public tabs as Register, Lists, History, Settings.

Do not activate `pages.order` tab sorting in this pass.

## 5. Settings Contract Guidance

Preferred semantic settings:

```text
history.week_boundary
history.month_boundary_mode
history.month_boundary_weekday
history.month_boundary_day
time_reference.day_boundary_time
```

Required design properties:

- stored values should be stable semantic values, not display labels only;
- display labels may be localized or changed later without changing stored meaning;
- invalid persisted values should fall back safely;
- UI should not duplicate service validation as the only line of defense;
- service methods should remain usable by a future non-desktop presentation layer.

## 6. Time Reference Boundary

`time_reference.day_boundary_time` means the time at which Markei's operational day rolls over.

Cycle 04 limit:

- implement persistence and validation;
- expose a service-owned interpretation helper;
- apply only where current data supports safe interpretation;
- do not alter Lists status, purchase rhythm, depletion prediction, or expected next purchase unless existing data already contains reliable time-of-day information.

If current data only stores dates, report that the design is present but behavior remains mostly future-ready.

## 7. Mobile Preparation Boundary

Prepare now:

- typed or type-like settings contracts;
- semantic values separated from labels;
- service-owned settings interpretation;
- validation independent from UI widgets;
- compact Settings structure;
- evidence that future presentation layers could reuse service behavior.

Defer:

- mobile UI;
- platform-specific mobile choices;
- server/shared-backend work;
- cross-device synchronization;
- receipt recognition;
- replacement of PySide6.

## 8. Boundary Drift Risks Codex Must Watch

Report any drift in `I_DSN_CODEX.md`.

High-risk drift:

- SettingsPage calculates History periods.
- Repository decides week/month semantics.
- HistoryPage duplicates grouping logic already owned by ProductService.
- ListsPage starts interpreting time reference directly.
- MainWindow activates stale `pages.order` values.
- Register gains store-management controls.
- Mobile preparation expands into mobile implementation.
- Settings grows into an unbounded page without compact sections.

## 9. I_DSN_CODEX.md Report Shape

After materialization, write `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`.

Required sections:

1. Source stage files read.
2. Architectural decisions materialized.
3. Files changed or created for design reasons.
4. Responsibility boundaries preserved.
5. Boundary drift, if any.
6. SettingsPage boundary evidence.
7. ProductService settings interpretation evidence.
8. Repository persistence boundary evidence.
9. History grouping boundary evidence.
10. Time reference boundary evidence.
11. Persistence/schema decision evidence.
12. Mobile-readiness boundary evidence.
13. Deferred design items.
14. Open design questions.
15. Suggested Design Chat follow-up.

Keep the report compact and evidence-oriented.
