# E_DDC_STAGE — Cycle 08 Product-Beta Language Directive

> Cycle: 08 — Shared-Client Product Beta
> Directive: C08-PB-01
> Status: ACTIVE — CODEX PRODUCT IMPLEMENTATION AUTHORIZED
> Authority: explicit human instruction reconciled by Main [M]
> Paired directives: `D_OPS_STAGE.md` and `F_DSN_STAGE.md`
> Control: this directive fully supersedes C08-IMP-01 and every earlier E authorization

## 1. Product journey

The implemented interface must communicate this complete sequence:

```text
find or create Product
→ choose or create Store
→ stage and edit Items
→ review Purchase
→ register Purchase locally
→ inspect Purchase History and details
→ compare compatible personal price observations
```

Do not collapse these stages into one undifferentiated form.

## 2. Controlling terminology

| Concept | User-facing term |
| --- | --- |
| reusable private collection | Products |
| reusable entry | Product |
| likely but unconfirmed match | similar Product |
| pre-registration collection | Purchase draft / Items to register |
| editable pre-registration line | staged Item |
| committed line | Purchase Item |
| pre-commit confirmation | Review purchase |
| local commit action | Register purchase |
| successful local result | Purchase registered locally |
| chronological records | Purchase History |
| derived comparison | Price change in your purchases |
| no compatible pair | Not enough comparable purchases |
| local persistence boundary | Data is stored on this device |

“Catalogue” may remain in architecture/documentation, but the UI uses **Products**.

## 3. Product and Store language

Product code remains required in this beta. Explain it as a user-visible Product reference, never as the internal UUID.

The Product flow must distinguish:

- use existing Product;
- create new Product;
- similar Product found;
- use this Product;
- create anyway.

“Similar” is advisory. Do not say “duplicate” unless exact identity is established.

The Store flow must distinguish:

- choose Store;
- create Store;
- Store name already available for reuse.

Do not claim normalized branch identity, merging or duplicate prevention.

## 4. Quantity and currency boundary

Cycle 08 remains explicitly **MASS + BRL** in the active Purchase UI.

Use clear labels such as:

- package size;
- packages bought;
- total amount bought;
- line total.

Do not imply that volume, count or arbitrary currencies are currently supported merely because domain types can represent them.

Normalized quantity and derived unit price are computed representations, not raw receipt facts.

## 5. State language

Every implemented asynchronous or mutating journey must distinguish:

- loading;
- genuine empty;
- data/success;
- field validation;
- recoverable failure;
- action in progress.

History failure must never appear as “no purchases.”

Product search with no match must invite Product creation, not look like a query failure.

Registration success is shown only after the atomic repository result returns. During submission, the Register action is disabled. Failure retains the draft where current state permits.

Durable unknown-outcome and identical/conflicting retry language is prohibited because SubmissionId is not implemented.

## 6. History and analytics claims

History detail must present registered facts: date/time, Store, Items, quantity basis, line totals and Purchase total.

The first analytic is narrowly defined:

- same Product;
- same currency;
- same quantity kind and canonical unit;
- previous and latest compatible observations;
- normalized purchased-unit price;
- percentage change;
- both source dates and Stores.

Use **Price change in your purchases**.

Do not use “official inflation,” “market inflation,” forecasts or population-level conclusions. “Personal inflation/deflation” remains deferred.

## 7. Failure and privacy boundary

Ordinary UI must not expose:

- exception strings or stack traces;
- UUIDs;
- Device sequence;
- Event/cursor/queue terminology;
- Drift or database internals;
- authentication/account claims;
- synchronization/upload claims;
- backup claims.

Use concise recovery language and a visible retry action where the operation is safely repeatable.

## 8. Local-data notice

The beta must communicate:

- data is stored locally on this device;
- synchronization is not active;
- export/restore is not yet provided;
- uninstalling or clearing app data may remove local data.

This is an honest boundary, not a backup feature.

## 9. Accessibility and comprehension

Touched flows must:

- expose state through text, not color alone;
- use descriptive action labels;
- provide semantic labels for navigation, progress and destructive draft removal;
- remain understandable at larger text sizes and narrow widths;
- keep review totals and actions readable without horizontal overflow.

## 10. Evidence boundary

Implementation and tests may establish that these concepts and words are present. They do not automatically establish learner mastery, permanent Didactic promotion, full accessibility acceptance, synchronization, backup or production readiness.

No KANBAN maturity change is authorized.

## 11. Deferred decisions

Do not reopen during C08-PB-01:

- optional Product code;
- general quantity/currency UI;
- Store branch identity;
- process-death draft recovery;
- durable idempotency wording;
- personal-inflation terminology;
- export/restore promise beyond the local-only notice.

A need to change these decisions returns to Main.
