# 14_MODEL_OVERVIEW.md

> Version: 0.4
> Status: Draft
> Persistence Class: Derived
> Knowledge Class: Design / Model Overview
> Authority: Design Chat
> Scope: Compact model ownership summary for Markei

---

# 1. Domain Entities

## Product

Product is the permanent inventory record.

Owns:

- product identity;
- editable product metadata;
- current inventory state;
- accepted cached product-level summaries.

Relevant summaries:

- `average_duration_days`;
- `expected_next_purchase`;
- `average_shelf_life_days`;
- `expected_expiration_date`.

Product must not own individual purchase history rows, History aggregate rows, Lists display rows, Settings semantics, operational-date rules, or History analytics rows.

## Purchase

Purchase is the immutable receipt/batch history record.

Owns:

- factual purchase date;
- quantity and unit;
- unit price and total price;
- promotion flag;
- product relationship;
- store relationship;
- optional `expiration_date`;
- notes.

Current purchase records store date values without reliable time-of-day. Operational date remains a derived service interpretation rather than a replacement persisted fact.

## Store

Store is the identity/location record.

Owns:

- store ID;
- name;
- city;
- state;
- nullable address.

Store create/update editing belongs in Settings rather than RegisterPage.

---

# 2. Settings Model

Settings is application configuration, not product or purchase data.

Current persistence shape:

```text
settings(key, value)
```

Canonical Cycle 04 settings:

| Key | Semantic value | Owner of interpretation | Current effect |
| --- | --- | --- | --- |
| `history.week_boundary` | lowercase weekday | ProductService | weekly History bucket start |
| `history.month_boundary_mode` | `first_weekday` or `day_of_month` | ProductService | operational month strategy |
| `history.month_boundary_weekday` | lowercase weekday | ProductService | weekday used by `first_weekday` mode |
| `history.month_boundary_day` | string/integer 1–28 | ProductService | day used by `day_of_month` mode |
| `time_reference.day_boundary_time` | normalized `HH:MM` | ProductService | operational-date derivation helper |
| `pages.order` | persisted page-order text | none in active UI | inert; MainWindow does not consume it |

Ownership:

- SQLite stores setting rows.
- Repository reads/writes generic key/value values.
- ProductService defines defaults, validates submitted values, normalizes persisted values, and interprets behavior.
- SettingsPage presents controls, separates labels from semantic item values, collects edits, and triggers save.

Validation distinction:

```text
invalid user edit
    -> strict rejection before persistence

invalid persisted value
    -> tolerant fallback to service default
```

Compatibility:

- `history.month_boundary_rule` is legacy compatibility residue.
- ProductService may map old `first_<weekday>` values only when canonical month keys are absent.
- The legacy key is not current canonical design.

---

# 3. Derived Product View Model

Product View is a service-prepared read model rendered by `ProductDetailPanel`.

Derived data includes:

- product identity;
- average price;
- average shelf-life;
- expected expiration;
- latest store-price rows;
- recent purchase rows.

Average price remains derived from Purchase rows.

---

# 4. Derived Lists View Model

Lists View is a service-prepared read model rendered by `ListsPage`.

Internal meanings:

```text
in-house  -> former Storage meaning
shortage  -> former Shortage meaning
to-buy    -> former Market meaning
```

Supported views:

- all-products hybrid view;
- `in-house`;
- `shortage`;
- `to-buy`;
- `in-house + shortage`;
- `shortage + to-buy`.

Derived row data includes identity, brand, quantity, latest price, delta price, product cycle, expected next purchase, remaining days, status, and display labels.

Ownership:

- ProductService owns status, latest/delta meaning, remaining-days interpretation, and row assembly.
- ListsPage owns view selection and rendering.
- Repository retrieves supporting rows.

Cycle 04 invariant:

- ListsPage does not read or interpret `time_reference.day_boundary_time`.
- Lists status remains purchase-rhythm based.
- Operational-day semantics do not yet change Lists classification or prediction behavior.

---

# 5. Derived History View Model

History View is a service-prepared read model rendered by HistoryPage.

Derived grouped data includes:

- operational month sections;
- week sections;
- ordered purchase rows;
- period labels and boundaries;
- summaries and total rows;
- diagnostics for unparsed rows.

Current grouping inputs:

```text
history.week_boundary
history.month_boundary_mode
history.month_boundary_weekday
history.month_boundary_day
```

Grouping ownership:

- ProductService reads normalized settings and constructs month/week buckets.
- HistoryPage renders prepared sections and does not calculate period membership.
- Repository retrieves raw purchase/store/settings rows.

Month modes:

```text
first_weekday
    first configured weekday of each calendar month

day_of_month
    configured day 1-28 of each calendar month
```

The displayed end of a period should be the day before the next period begins. The current first-weekday period-end implementation requires operational verification.

---

# 6. Derived History Analytics View Model

History Analytics is a service-prepared read model rendered by an embedded read-only History component.

Analytics frame:

```text
date range + optional store filter
```

Derived summary data includes parsed/unparsed/excluded counts, total spent, and frame average purchase timelapse.

Derived product rows include product totals, expenditure percentages, purchase count, product cycle, frame average, cycle difference, comparison label, and insufficient-data reason.

Ownership:

- ProductService owns frame interpretation and analytics calculations.
- HistoryPage owns controls and rendering.
- Repository retrieves supporting rows.
- SQLite does not persist analytics cache fields.

---

# 7. Temporal Model

Markei distinguishes factual time, operational interpretation, product rhythms, History grouping, and analytics frames.

```text
Factual purchase date
    stored on Purchase

Operational date
    derived by ProductService from date/datetime + day-boundary time

Purchase rhythm
    average_duration_days
    expected_next_purchase

Shelf-life rhythm
    average_shelf_life_days
    expected_expiration_date

History grouping
    history.week_boundary
    history.month_boundary_mode
    history.month_boundary_weekday
    history.month_boundary_day

Operational-day reference
    time_reference.day_boundary_time

Analytics frame timelapse
    average interval between parsed purchases in selected date/store frame
```

Invariants:

- Factual purchase date and operational date are different semantic values.
- Operational date is derived, not persisted as a replacement fact.
- A datetime before the configured boundary maps to the previous operational date.
- A date-only value remains that date because no time-of-day evidence exists.
- The Cycle 04 setting is contract-ready but does not materially shift existing date-only History rows.
- Purchase rhythm answers expected rebuy timing.
- Shelf-life rhythm answers expected batch expiration.
- History grouping answers reporting bucket membership.
- Analytics frame timelapse answers purchase density inside a selected frame.
- Lists classification remains purchase-rhythm based.

---

# 8. UI Model Boundary

## ProductDetailPanel

Receives prepared data and renders it. It does not query repositories or calculate domain meaning.

## RegisterPage

Owns receipt entry and ProductDetailPanel composition. It does not own store management.

## ListsPage

Owns view controls, rendering, refresh, and product-opening events. It does not calculate status, prices, remaining days, or operational-date behavior.

## HistoryPage

Owns rendering, date/store analytics controls, and refresh. It does not group raw purchases, interpret History settings, or calculate analytics.

## SettingsPage

Owns:

- configuration controls;
- desktop labels;
- semantic combo item values;
- edit state;
- save events;
- validation feedback presentation;
- store create/update UI.

It must not:

- calculate History grouping;
- interpret the operational-day boundary;
- mutate HistoryPage directly;
- bypass ProductService/Repository;
- activate page ordering through MainWindow.

## MainWindow

Owns static public tab mounting and refresh orchestration. Current public tabs remain Register, Lists, History, and Settings. `pages.order` remains inert.

---

# 9. Persistence and Migration Overview

- Cycle 04 required no new table or column.
- Canonical defaults are added through non-destructive default insertion.
- Existing values are preserved.
- Fresh databases seed canonical Cycle 04 keys.
- Legacy month-boundary values may remain stored but are compatibility input rather than canonical state.
- Migration/removal of legacy keys requires a later explicit decision.

---

# 10. Mobile Readiness Overview

Cycle 04 improves portability through:

- service-owned Settings defaults and validation;
- semantic stored values separate from desktop labels;
- ProductService-owned period interpretation;
- a platform-neutral operational-date helper;
- unchanged generic Repository persistence.

Still not ready:

- mobile presentation implementation;
- platform selection;
- server/shared backend;
- authentication or synchronization;
- mobile persistence;
- typed service contracts;
- dependency injection/service factory;
- time-of-day capture strategy;
- comprehensive automated testing.

Mobile readiness remains preparation through boundaries, not authorization for a mobile rewrite.
