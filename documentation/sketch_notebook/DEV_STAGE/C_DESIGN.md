# DEV_STAGE/C_DESIGN.md

> Status: Active Functional Stage
> Authority: Design Chat
> Persistence class: Functional stage material
> Knowledge class: Design stage report
> Scope: Cycle 04 Settings, time reference, mobile readiness, and Settings priority classification

---

# Cycle 04 Design Report

## 1. Recovery Notes

Files read:

- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
- `documentation/sketch_notebook/methodology/FLUX.md`
- `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
- `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`
- `documentation/sketch_notebook/design/09_DESIGN_STATE.md`
- `documentation/sketch_notebook/design/01_ARCHITECTURE.md`
- `documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md`

Path drift observed:

- Requested path `sketch_notebook/INDEX.md` did not resolve in the connected repository.
- The active repository root for the notebook is `documentation/sketch_notebook/`.
- This is classified as path drift, not as permission to invent a new root.

Checkpoint status:

- `design/09_DESIGN_STATE.md` is populated and current through Cycles 01-03.
- It was enough for orientation but not enough for Cycle 04 Settings/time-reference/mobile analysis, so the canonical architecture and model overview were read.

## 2. Primary Design Concern

The design problem is not simply to add more Settings controls.

The design problem is to prevent Settings from becoming an unbounded page that owns business meaning.

Current boundary:

```text
Desktop UI
ProductService
Repository
SQLite schema / storage
```

Design conclusion:

```text
SettingsPage may own configuration editing.
SettingsPage must not own configuration meaning.
```

Settings choices can affect History grouping, list thresholds, analytics frames, and later mobile behavior. Those meanings must remain service-owned.

## 3. Settings Page Responsibility

Settings is the user-facing configuration and store-management surface.

Stable ownership:

- SettingsPage owns configuration editing surfaces.
- SettingsPage owns store-editing placement.
- Store create/update belongs in Settings, not RegisterPage.
- Repository persists settings and store records.
- ProductService interprets setting values.
- SQLite key/value settings persistence remains accepted.

Settings may host:

- global app preferences;
- list thresholds;
- time reference behavior;
- store management;
- future mobile-preparation preferences.

Boundary rule:

```text
SettingsPage edits values.
ProductService interprets values.
Repository persists values.
HistoryPage and ListsPage render service-prepared data.
```

## 4. Time Reference Design

"Time reference time" should be defined as a global temporal interpretation preference.

Proposed setting key:

```text
time_reference.day_boundary_time
```

Conceptual meaning:

- Defines when Markei considers one operational day to end and the next operational day to begin.
- It is different from `history.week_boundary`.
- It is different from `history.month_boundary_rule`.
- It is different from `purchase_date` as a receipt fact.

Ownership proposal:

```text
SettingsPage edits the preference.
Repository persists the key/value setting.
ProductService interprets operational dates and grouped views.
HistoryPage and ListsPage render prepared outputs.
```

Affected areas:

- History grouping;
- History analytics frames, if operational-day frames are adopted;
- Lists remaining-day/status calculations, if they compare against operational today;
- Product View date displays, if they later use operational today;
- RegisterPage only as an input/display surface, not as interpreter.

Design distinction:

```text
purchase_date: factual purchase date or datetime
operational_date: derived service interpretation after applying time reference
history.week_boundary: weekly bucket boundary
history.month_boundary_rule: operational month boundary rule
time_reference.day_boundary_time: operational day rollover time
```

Cycle 04 warning:

- Do not replace factual purchase dates with operational dates.
- Derive operational grouping in ProductService.
- Defer persisted derived operational dates unless later needed for performance or cross-device behavior.

## 5. Mobile Development Readiness

Current classification:

```text
Prepared for mobile discussion.
Not ready for mobile implementation.
```

Prepared now:

- service-owned Lists read model;
- service-owned History analytics read model;
- platform-neutral dictionary/list outputs;
- UI logic mostly limited to rendering and events;
- business meanings no longer tied to old Storage/Shortage/Market pages.

Not ready:

- mobile presentation layer;
- server or shared-backend strategy;
- cross-device account/synchronization strategy;
- mobile persistence strategy;
- typed service contracts;
- service factory or dependency boundary;
- explicit date validation model;
- automated service-level tests;
- UI label versus semantic value separation.

Immediate mobile risks:

- desktop widgets must not become the only home of business behavior;
- key/value settings need typed contracts before reuse outside desktop;
- mobile navigation should not inherit desktop tab-order assumptions;
- date/time validation must be service-level, not widget-specific;
- store management should be compacted before Settings expands further.

Must stabilize before mobile work:

```text
typed setting keys and values
time reference semantics
week/month boundary semantics
service-owned interpretation
date validation behavior
UI label vs semantic value separation
service-level tests for settings-dependent read models
```

Can remain deferred:

```text
mobile implementation
server/shared-backend strategy
cross-device synchronization
mobile persistence implementation
receipt recognition
page-order consumption by MainWindow
store deletion referential behavior
analytics caching
```

## 6. Priority Classification

### MVP-critical

1. Settings ownership clarification.
2. History week boundary free choice.
3. History month boundary rule.
4. Time reference day-boundary setting.
5. Compact store-management section.
6. Validation/default behavior for settings.

### Mobile-preparation

1. Typed settings contract.
2. Semantic values separated from UI labels.
3. Service factory or dependency boundary.
4. Date/time validation model.
5. Service-level tests for settings-dependent behavior.

### Deferred

1. Mobile UI implementation.
2. Server/shared-backend strategy.
3. Cross-device account and synchronization strategy.
4. Mobile persistence strategy.
5. Receipt recognition.
6. Supermarket/rewards integration.
7. Page-order consumption by MainWindow.
8. Store deletion referential behavior.
9. Analytics caching.
10. Configurable cycle-comparison tolerance.

## 7. Main Chat Handoff

Ready for Main synthesis:

1. Settings should own user-facing configuration surfaces, but not business interpretation.
2. ProductService remains the owner of settings interpretation for History grouping, Lists status, analytics frames, and operational date behavior.
3. Repository remains the persistence boundary for settings.
4. "Time reference time" should be promoted as `time_reference.day_boundary_time`, meaning operational day rollover time.
5. Week boundary and month boundary should be generalized beyond Wednesday.
6. Store management remains in Settings but should be compacted/componentized.
7. Mobile work should begin with contracts and boundary stabilization, not with a mobile UI rewrite.
8. Mobile readiness should be improved through typed settings, semantic-value separation, date validation, and tests before larger platform work.

Unresolved design questions:

1. Should `time_reference.day_boundary_time` affect only History grouping in Cycle 04, or also Lists remaining-days behavior immediately?
2. Should purchase records eventually store time-of-day, or should Cycle 04 only interpret dates with a global day-boundary preference?
3. Should operational date be purely derived, or cached later for performance/cross-device needs?
4. What persisted representation should be used for weekdays: integer, lowercase enum string, or ISO weekday?
5. What persisted representation should be used for month boundary rule?
6. Should Settings use separate internal components for Time, Lists, Stores, and Mobile Prep now, or only after the first Settings expansion?
7. Should mobile-preparation settings be visible to users, or remain internal architecture work until mobile implementation begins?

Design classification:

```text
Stable enough for Main:
    Settings ownership boundary
    service-owned interpretation
    repository-owned persistence
    time reference as operational day-boundary concept
    mobile readiness as contract-first, not UI-first

Still design-open:
    exact persisted formats
    first implementation scope of time_reference.day_boundary_time
    operational-date caching
    mobile settings visibility
```
