# Cycle 04 Didactic Report

> Status: Active functional stage report
> Domain: Didactic
> Authority: Didactic Chat [A]
> Persistence class: Functional stage material
> Scope: Learning structure, concept sequencing, Settings concepts, mobile-readiness concepts

---

## 1. Recovery Notes

### Files read

Boot / methodology:

```text
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

Didactic recovery:

```text
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

### Learning-state recovery

The concept map is not empty. It currently records Cycle 03 as the last fully absorbed didactic state: read-model consolidation, Lists unification, embedded History analytics, and mobile readiness as a boundary concept rather than a mobile implementation decision.

The existing didactic stage file was a pruned placeholder, not an active report. This report replaces that placeholder with a clean Cycle 04 didactic staging surface.

### Path drift / route mismatch observed

The requested path `sketch_notebook/INDEX.md` was not available through the connected GitHub repository during this recovery attempt.

The repository exposed the notebook at:

```text
documentation/sketch_notebook/INDEX.md
```

This is the path declared canonical by the current repository notebook. Therefore, this report treats the prompt path as a route mismatch/path-drift observation, not as permission to invent or migrate files.

---

## 2. Current Learning Problem

Cycle 04 requires the developer to understand Settings as a configuration boundary rather than a miscellaneous page.

The learning problem is not only “how to add fields to Settings.” The deeper problem is understanding how saved preferences affect later calculations, UI state, read models, validation, and future platform work without making Settings itself own all behavior.

The key conceptual tension is:

```text
Settings stores and edits preferences.
Services interpret preferences.
Read models expose interpreted results.
UI pages render and select views.
```

For Cycle 04, the developer should learn how configuration values become inputs into behavior without becoming the behavior itself.

This is especially important for “time reference time,” because it sounds like a single setting but can mean several different concepts:

- the date/time used as “now” when classifying products;
- the boundary used to group History into weeks or months;
- the anchor used for testing or replaying behavior;
- the reference point for predicted depletion, shortage, or market status;
- a user preference that changes display behavior across sessions.

Before implementation, the learner needs to distinguish these meanings so that one vague setting does not accidentally collapse several responsibilities into one field.

---

## 3. Settings Concepts

### &&& Configuration State

Settings work depends first on `&&&08 — Configuration State`.

A setting is persisted preference data. It is not the calculation itself. The setting should answer:

```text
What did the user choose?
```

It should not answer:

```text
How should every page calculate every derived result?
```

Learning status: Red → should become active Yellow during Cycle 04.

### &%% Settings-Owned Preferences

`&%%06 — Settings-Owned Preferences` is the Markei-specific form of configuration state.

Settings owns:

- exposing the preference to the user;
- validating acceptable preference values;
- saving the preference;
- loading the preference back into UI controls.

Settings does not own:

- History grouping calculations;
- Lists status classification;
- product duration prediction;
- mobile behavior;
- API integration behavior.

Learning status: Red → immediate Cycle 04 focus.

### &&& Default Value

The learner should understand default values as the behavior used before the user changes a setting.

In Cycle 04, defaults matter for:

- default shortage threshold;
- default week boundary;
- default month boundary logic;
- default “time reference” mode;
- default mobile-readiness behavior when mobile preferences do not yet exist.

A default should be explicit, stable, and explainable.

Proposed marker: `&&&15 — Default Value as Fallback Contract`.

Learning status: Red.

### &&& Validation Boundary

Settings requires validation before persistence.

Validation means a setting must be checked against allowed choices before it becomes stored state. For example, a weekday setting should be one of seven weekdays, not arbitrary text.

Validation is conceptually separate from rendering. A combo box may reduce invalid input, but the application still needs a rule for what counts as valid configuration.

Proposed marker: `&&&16 — Validation Boundary`.

Learning status: Red.

### &&% Enumerated Choice

Several Settings values are choices from a small fixed set:

- weekday boundary;
- month boundary strategy;
- time reference mode;
- mobile-readiness preference flags;
- placeholder API provider type.

The developer should learn the concept of an enumerated choice: a value constrained to a known set of valid options.

Proposed marker: `&&%07 — Enumerated Choice Values`.

Learning status: Red.

### &&& Time Reference

“Time reference time” should be learned as a conceptual dependency, not only as a UI field.

A time reference is the point in time from which time-sensitive calculations interpret the app state.

Possible meanings must be separated:

1. **Current-time reference** — What does “today” mean for classification?
2. **History boundary reference** — What weekday or day starts a reporting period?
3. **Testing/reference override** — Can the app pretend today is another date for testing or review?
4. **Prediction reference** — From which date are expected depletion, shortage, and market states measured?
5. **Display reference** — Which date/time is shown or selected in the UI?

The didactic conclusion is that “time reference time” is not yet a single Green concept. It should be decomposed before implementation instructions are written.

Proposed marker: `&&&17 — Time Reference as Behavioral Anchor`.

Learning status: Red.

### &&% Date/Datetime Boundary Handling

`&&%03 — Date/Datetime Boundary Handling` already exists and remains Red.

Cycle 04 should reinforce it through:

- free-choice week boundary;
- month boundary by selected date or first weekday;
- inclusive/exclusive period membership;
- current reference date for “now”-based classifications.

Learning status: Red → active Yellow target.

### &&& Time Bucketing

`&&&05 — Time Bucketing` already exists and remains Red.

Cycle 04 extends it from a fixed Wednesday rule into a configurable boundary rule.

The learner should understand:

```text
A date does not naturally belong to a project period until the app applies a boundary rule.
```

Learning status: Red → active Yellow target.

### &&% UI View State

`&&%06 — UI View State` already exists and is Yellow.

Settings introduces a more persistent version of state:

```text
UI view state may be temporary.
Settings state persists across sessions.
```

The learner should distinguish temporary control state from saved preference state.

Learning status: Yellow.

### &%% History Grouping Service Responsibility

`&%%08 — History Grouping Service Responsibility` remains relevant.

If Settings allows free week/month boundary choices, History services should interpret the saved preference. History UI should not own the period math.

Learning status: Yellow.

---

## 4. Mobile-Readiness Concepts

Cycle 04 should begin mobile learning as boundary preparation, not toolchain commitment.

### Reusable concepts to learn now

#### &&& Mobile Readiness Without Rewrite

Already present as `&&&14` and still Red.

The core idea remains: prepare portable contracts and boundaries before choosing or implementing mobile UI.

Learning status: Red → active Yellow target.

#### &&% Platform-Neutral Read-Model Shape

Already present as `&&%04` and Yellow.

This becomes more important because Settings preferences should be represented in simple shapes that another adapter could later consume.

Learning status: Yellow.

#### &%% Service Contract Stability

Already present as `&%%12` and Yellow.

Mobile development depends on stable service contracts. A future mobile UI should not need to rediscover business rules hidden in PySide6 pages.

Learning status: Yellow.

#### &&& Adapter Boundary

The developer should learn adapter boundary before mobile coding.

An adapter boundary is the separation between reusable application behavior and platform-specific input/output.

Proposed marker: `&&&18 — Adapter Boundary`.

Learning status: Red.

#### &&& Capability Versus Placeholder

Cycle 04 mentions API integration and future mobile features such as receipt recognition. The learner should distinguish a placeholder field from a working capability.

A placeholder can preserve a future integration slot without pretending the app already integrates with an external system.

Proposed marker: `&&&19 — Capability Versus Placeholder`.

Learning status: Red.

### Technology-specific concepts to defer

The following should not become immediate learning prerequisites unless Main chooses a mobile stack:

- Android/iOS packaging;
- camera APIs;
- NFC-e/OCR recognition pipeline;
- app-store distribution;
- mobile database sync;
- offline-first conflict resolution;
- authentication and remote backend design;
- framework-specific mobile widgets.

These are real future concepts, but they are not needed before Cycle 04 Settings boundary correction.

### Package/dependency concepts

No new package/dependency concept should be promoted yet.

Potential future `%%%` candidates may include a mobile UI framework or OCR/receipt-recognition package, but only after the project chooses an actual technology path.

---

## 5. Proposed Learning Sequence

### Immediate Cycle 04 progression

1. `&&&08 — Configuration State` — Red → Yellow
2. `&%%06 — Settings-Owned Preferences` — Red → Yellow
3. `&&&15 — Default Value as Fallback Contract` — Red
4. `&&&16 — Validation Boundary` — Red
5. `&&%07 — Enumerated Choice Values` — Red
6. `&&&17 — Time Reference as Behavioral Anchor` — Red
7. `&&%03 — Date/Datetime Boundary Handling` — Red → Yellow
8. `&&&05 — Time Bucketing` — Red → Yellow
9. `&%%08 — History Grouping Service Responsibility` — Yellow reinforcement
10. `&&&14 — Mobile Readiness Without Rewrite` — Red → Yellow
11. `&&&18 — Adapter Boundary` — Red
12. `&%%12 — Service Contract Stability` — Yellow reinforcement
13. `&&&19 — Capability Versus Placeholder` — Red

### Compact dependency spine

```text
&&&08 Configuration State
↓
&%%06 Settings-Owned Preferences
↓
&&&15 Default Value as Fallback Contract
↓
&&&16 Validation Boundary
↓
&&%07 Enumerated Choice Values
↓
&&&17 Time Reference as Behavioral Anchor
↓
&&%03 Date/Datetime Boundary Handling
↓
&&&05 Time Bucketing
↓
&%%08 History Grouping Service Responsibility
↓
&&&14 Mobile Readiness Without Rewrite
↓
&&&18 Adapter Boundary
↓
&%%12 Service Contract Stability
```

### Maturity summary

Green:

- None newly promoted.
- Existing concept map still reports no fully Green concepts.

Yellow:

- `&&&01 — Domain Model Field Semantics`
- `&&&02 — Raw Data Versus Derived Data`
- `&&&03 — Naming as Data Contract`
- `&&%04 — Platform-Neutral Read-Model Shape`
- `&&%06 — UI View State`
- `&%%04 — Service-Owned Calculation Responsibility`
- `&%%08 — History Grouping Service Responsibility`
- `&%%12 — Service Contract Stability`

Red:

- `&&&05 — Time Bucketing`
- `&&&08 — Configuration State`
- `&&&14 — Mobile Readiness Without Rewrite`
- `&&%03 — Date/Datetime Boundary Handling`
- `&%%06 — Settings-Owned Preferences`
- `&&&15 — Default Value as Fallback Contract`
- `&&&16 — Validation Boundary`
- `&&%07 — Enumerated Choice Values`
- `&&&17 — Time Reference as Behavioral Anchor`
- `&&&18 — Adapter Boundary`
- `&&&19 — Capability Versus Placeholder`

---

## 6. KANBAN Candidates

Do not promote yet. Candidate concepts for later `02_KANBAN.md` update:

### `&&&15 — Default Value as Fallback Contract`

A default value is the explicit fallback used when no user preference has been set.

### `&&&16 — Validation Boundary`

A validation boundary is the point where incoming or editable data is checked before it is accepted as application state.

### `&&&17 — Time Reference as Behavioral Anchor`

A time reference is the temporal anchor used by calculations, classification, prediction, or display to interpret time-sensitive records.

### `&&&18 — Adapter Boundary`

An adapter boundary separates reusable application behavior from platform-specific rendering, device input, or external integration code.

### `&&&19 — Capability Versus Placeholder`

A capability performs a real behavior. A placeholder preserves a future slot or configuration surface without pretending the behavior exists yet.

### `&&%07 — Enumerated Choice Values`

An enumerated choice value is a value constrained to a known set of valid options, such as weekdays or mode names.

Potential later `%%%` concepts are deferred until a mobile or integration dependency is actually selected.

---

## 7. Main Chat Handoff

### Didactic conclusions ready for Main synthesis

1. Settings should be taught as configuration state plus preference persistence, not as an all-purpose behavior owner.
2. “Time reference time” should not be implemented as a vague setting until Main/Design clarifies which temporal role it owns.
3. The most didactically useful decomposition is:

```text
current-time reference
history boundary reference
testing/reference override
prediction reference
display reference
```

4. Cycle 04 Settings learning should reinforce existing Red concepts: Configuration State, Settings-Owned Preferences, Time Bucketing, and Date/Datetime Boundary Handling.
5. New concept candidates should remain staged, not promoted, until implementation direction or Codex evidence confirms them.
6. Mobile development should begin as a boundary lesson: service contracts, adapter boundary, platform-neutral read models, and placeholder discipline.
7. Technology-specific mobile topics should remain deferred until the project chooses a concrete mobile stack or integration path.
8. API/reward-system fields should be taught as placeholders unless implementation actually connects to an external provider.

### Unresolved learning questions

1. Does “time reference time” mean app-wide current-date override, History grouping boundary, prediction anchor, UI display preference, or more than one separate setting?
2. Should week/month boundary preferences be taught as one generalized time-bucketing concept or as separate weekly/monthly configuration concepts?
3. Should Settings include mobile-readiness preferences now, or should mobile readiness remain a service-contract concept without Settings UI?
4. Should API/reward-system placeholders be part of Settings learning now, or should they remain operational/design placeholders only?
5. Does Main want Cycle 04 didactics to promote new KANBAN entries after implementation evidence, or keep this cycle as staged learning support only?
