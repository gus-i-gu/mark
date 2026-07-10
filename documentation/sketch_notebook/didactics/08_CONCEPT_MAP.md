# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Checkpoint
> Current Milestone: Cycle 04 — Settings Stabilization

---

## Current Milestone

Cycle 04 absorbs Settings Stabilization as verified learning evidence:

```text
persisted preference
→ service validation / fallback
→ interpreted behavior
→ read model or operational helper
→ PySide6 presentation
```

SettingsPage is a presentation/editing adapter. ProductService validates, normalizes, and interprets settings. Repository and SQLite persist generic key/value state.

## Stable Concepts

- None fully Green yet.

## Active / Stronger Yellow Concepts

- &&&05 — Time Bucketing
- &&&08 — Configuration State
- &&&15 — Default Value as Fallback Contract
- &&&16 — Validation Boundary
- &&&17 — Time Reference as Behavioral Anchor
- &&%03 — Date/Datetime Boundary Handling
- &&%04 — Platform-Neutral Read-Model Shape
- &&%07 — Enumerated Choice Values
- &&%08 — UI View State Versus Persisted Settings State
- &%%04 — Service-Owned Calculation Responsibility
- &%%06 — Settings-Owned Preferences
- &%%08 — History Grouping Service Responsibility
- &%%12 — Service Contract Stability
- &%%13 — ProductService-Owned Settings Interpretation
- &%%14 — Repository-Owned Settings Persistence
- %%%04 — SQLite Settings Persistence
- %%%05 — PySide6 Editable Form Composition
- %%%09 — PySide6 Settings Controls as Presentation Adapter

## Early / Unstable Concepts

- &&&14 — Mobile Readiness Without Rewrite
- &&&18 — Adapter Boundary
- &&&19 — Capability Versus Placeholder

## Verified Cycle 04 Distinctions

```text
user preference
is not
interpreted behavior
```

SettingsPage edits preferences; ProductService gives them behavioral meaning.

```text
strict rejection of invalid user edits
is not
fallback recovery from corrupt persisted values
```

`validate_history_settings_input()` raises for invalid save input. `validated_settings()` replaces invalid persisted values with safe defaults.

```text
display label
is not
stored semantic value
```

PySide6 combo boxes display human labels while carrying lowercase semantic values such as `monday`, `first_weekday`, and `day_of_month`.

```text
factual purchase date
is not
derived operational date
```

Purchase records remain factual date-only values. `operational_date()` derives an operational date only when given a datetime or an explicit boundary interpretation.

```text
operational-day contract readiness
is not
current material effect on date-only purchase records
```

`time_reference.day_boundary_time` is persisted and validated, and `operational_date()` exists, but `get_history_view()` still parses date-only purchases directly. Therefore the boundary time does not currently change History grouping for existing purchase rows.

```text
mobile preparation
is not
mobile implementation
```

Semantic values and service-owned validation can be reused by another adapter, but no mobile framework, synchronization, backend, authentication, or receipt recognition was implemented.

## Explicit Cycle 04 Evidence

- Week boundary supports all seven semantic weekdays.
- Month boundary supports `first_weekday` or `day_of_month`.
- Day-of-month is constrained to 1–28.
- Defaults are centralized in `ProductService.DEFAULT_SETTINGS`.
- Invalid user edits are rejected before persistence.
- Invalid persisted values recover through defaults.
- SQLite migration inserts defaults with `INSERT OR IGNORE`.
- Existing user choices are not overwritten.
- Repository remains generic key/value persistence.
- `history.month_boundary_rule` is compatibility residue, not canonical current configuration.

## Dependency Spine

```text
&&&03 Naming as Data Contract
↓
&&&08 Configuration State
↓
&&&15 Default Value as Fallback Contract
↓
&&&16 Validation Boundary
↓
&&%07 Enumerated Choice Values
↓
&%%06 Settings-Owned Preferences
↓
&%%13 ProductService-Owned Settings Interpretation
↓
&%%14 Repository-Owned Settings Persistence
↓
&&&05 Time Bucketing
↓
&&%03 Date/Datetime Boundary Handling
↓
&%%08 History Grouping Service Responsibility
↓
&&&17 Time Reference as Behavioral Anchor
↓
&&%04 Platform-Neutral Read-Model Shape
↓
&&&18 Adapter Boundary
↓
&&&14 Mobile Readiness Without Rewrite
```

## Project Learning Spine

```text
PySide6 labels and controls
↓
semantic setting values
↓
strict save validation
↓
generic repository persistence
↓
tolerant persisted-value normalization
↓
History week/month interpretation
↓
operational-date helper
↓
future adapter reuse
```

## Deferred Learning

- mobile framework selection;
- mobile UI implementation;
- synchronization and shared backend;
- authentication;
- external supermarket/reward integration;
- receipt or NFC-e recognition;
- material operational-day effects on Lists status, prediction, or date-only History rows;
- cleanup or migration policy for legacy `history.month_boundary_rule`;
- active `pages.order` behavior.

## Next Concepts

1. Practice the difference between rejection and fallback.
2. Trace one setting from UI label to semantic value to persistence to interpreted behavior.
3. Compare factual dates with derived operational dates.
4. Test time bucketing at week and month boundaries.
5. Revisit Adapter Boundary only when a second presentation adapter exists.
6. Keep mobile implementation deferred until contracts, tests, and persistence strategy mature.

## Session Delta

Cycle 04 implementation evidence from commit `c9e9244a5187c32a2812641f05eac8856801a7d4` was reconciled with `H_DDC_CODEX.md`, `G_OPS_CODEX.md`, and `I_DSN_CODEX.md`. Settings concepts advanced conservatively to Yellow; no concept advanced to Green. Operational-day support is recorded as contract-ready but not materially applied to date-only purchase grouping.
