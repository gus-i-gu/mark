# E_DDC_STAGE — Cycle 08 Codex Language Directive

> Cycle: 08 — Shared-Client Product Beta
> Directive: C08-IMP-01
> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED
> Authority: explicit human instruction reconciled by Main [M]
> Scope: user-facing concepts and state language for the active bounded unit
> Paired directives: `D_OPS_STAGE.md`, `F_DSN_STAGE.md`
> Temporal control: this directive supersedes the earlier provisional and C08-ACT-01 text in this file

## 1. Required product language

C08-IMP-01 must present current local behavior honestly and consistently.

The active product sequence remains:

```text
stage Purchase Items
→ register Purchase locally
→ inspect Purchase History
```

Catalogue reuse, Store selection, review, durable retry and analytics belong to later units and must not be implied by this implementation.

## 2. Controlling vocabulary

Use these meanings:

| Meaning | Required term or rule |
| --- | --- |
| current entry workflow | Purchase |
| committed aggregate | registered Purchase |
| pre-commit line | staged Item |
| committed line | Purchase Item |
| local successful result | Purchase registered locally |
| chronological local records | Purchase History |
| no records | No purchases yet |
| unavailable query result | Couldn’t load purchase history |
| repeat query action | Try again |
| incomplete/invalid input | field-specific validation message |
| technical failure | safe product-language failure, never the raw exception |

Capitalization may follow the surrounding UI, but meanings must not drift.

## 3. Required state distinctions

### History

The UI and tests must distinguish:

1. **Loading** — progress is visible; do not show empty-state copy.
2. **Empty** — query succeeded and returned no Purchases.
3. **Failure** — query failed; show safe failure copy and retry when supported.
4. **Data** — one or more Purchase summaries are visible.

Failure must never be rendered as empty.

### Purchase registration

The UI must distinguish:

1. editable input;
2. field validation failure;
3. registration in progress;
4. locally registered success;
5. known registration failure.

Do not introduce “unknown outcome,” “identical retry,” or “conflicting retry” copy because durable submission identity is outside C08-IMP-01.

## 4. Prohibited claims and leakage

Do not expose or claim:

- raw exception text;
- Device UUID, sequence or Event identity;
- database, Drift or transaction internals;
- synced, uploaded, cloud-saved or backed-up state;
- account ownership;
- duplicate-safe retry;
- Catalogue or Store identity semantics;
- official inflation or general market conclusions.

“Saved” alone is too broad. Prefer “Purchase registered locally” where the current repository result establishes local success.

## 5. Accessibility and comprehension

For every touched state:

- provide visible text in addition to color or icon differences;
- keep actions labeled by outcome;
- maintain meaningful semantics for navigation and progress;
- avoid technical recovery instructions;
- preserve legibility under larger text and narrow constraints.

Tests should locate important states through stable semantic text or keys without coupling to incidental layout structure.

## 6. Evidence boundary

G/H/I and tests may establish that copy and state distinctions were implemented. They do not automatically establish:

- learner mastery;
- KANBAN maturity promotion;
- Windows or Android accessibility acceptance;
- synchronization, backup or production readiness.

No permanent Didactic promotion is authorized in this phase.

## 7. Deferred language decisions

The following remain unresolved and must not be silently selected by Codex:

- Catalogue versus Products versus My products;
- Product-code visibility or optionality;
- quantity-entry truth;
- Store branch/location identity;
- separate review presentation;
- draft recovery promise;
- durable retry language;
- price change versus personal inflation wording;
- export/restore promise.

A need to decide any item above returns to Main.
