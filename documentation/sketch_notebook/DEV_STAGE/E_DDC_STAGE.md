# E_DDC_STAGE

> Cycle: 08 — Shared-Client Product Beta
> Round: C08-R01
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
> Purpose: Domain confrontation; no implementation authority
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> Main source: `[M]_STAGE/J_[M]_STAGE.md` at reconciliation commit `fc22f0484b2896f3ee579cd76f489fab1487b56d`

This file is an iterative staging draft. It does not authorize source, dependency, schema, tool, host, infrastructure, permanent-memory, or Codex changes.


# 1. Conciliated Didactic outcome

Prepare Didactic Chat [A] to confront J’s product language and ensure later implementation instructions express every state without overstating evidence, identity, analytics or synchronization.

No KANBAN ID, maturity, Glossary entry or permanent Didactic promotion is authorized.

# 2. Provisional product-language spine

```text
choose or reuse Product
→ stage Items
→ review Purchase
→ register atomically
→ inspect History
→ compare like observations
```

The next round must test this language against repository behavior and the human’s product intent.

# 3. Working vocabulary

| Meaning | Provisional working term | Guardrail |
| --- | --- | --- |
| reusable private collection | Catalogue / Products / My products | human choice pending |
| deterministic reuse | existing Product / exact Product | do not call fuzzy likeness exact |
| advisory likeness | similar Product | never implies automatic merge |
| content of one package | package size | retain unit |
| number of packages | packages bought | distinct from amount |
| total acquired | total amount bought | distinct from normalized amount |
| editable pre-commit line | staged Item / Item to register | not historical fact |
| historical line | Purchase Item | exists after registration |
| pre-commit inspection | Review purchase | exact presentation pending |
| commit | Register purchase | never “upsert Purchase” |
| comparison | price change in your purchases | not official inflation |
| local result | registered locally | not synced/uploaded/backed up |

# 4. Required state language

Every later UI stage must name language for:

- initial state;
- empty state;
- searching/loading;
- no exact Product;
- similar Product advisory;
- validation error;
- editable draft;
- review;
- registration in progress;
- registration success;
- known registration failure;
- unknown outcome;
- identical retry;
- conflicting retry;
- retained/recovered draft;
- incompatible comparison;
- missing History;
- migration/recovery failure.

“Saved” must not be shown when the result is unknown.

# 5. Quantity confrontation

R02 must resolve whether Cycle 08 teaches and collects:

A. package size + packages bought, deriving total amount;  
B. package size + packages bought + total amount with consistency validation;  
C. different flows for PACKAGED and BULK.

The vocabulary must preserve:

- entered receipt facts;
- derived normalized quantity;
- comparability rules;
- human-readable units;
- line total and derived unit price.

Normalized quantity and unit price must not be presented as raw receipt facts.

# 6. Identity confrontation

R02 must distinguish in ordinary language:

- visible Product recognition;
- internal Product identity;
- Product code;
- exact normalized equivalence;
- similar Product;
- Store identity;
- optional branch/location description;
- Purchase draft;
- registered Purchase;
- submission identity;
- Device identity;
- Account/authentication.

UUID, Device sequence, event, cursor, Drift and normalization-version language should remain hidden from ordinary UI unless diagnostics explicitly require it.

# 7. Analytics confrontation

First-beta analytics must declare:

- Product being compared;
- source Purchases;
- dates;
- Stores;
- currency;
- quantity/package basis;
- formula/version;
- comparability or reason for incompatibility;
- percentage price change.

Preferred primary wording:

`Price change in your purchases`

“Personal inflation/deflation” remains secondary or deferred until the human chooses its explanatory role. General, official or population inflation claims are prohibited.

# 8. Learner-evidence boundary

Repository implementation, passing tests, runtime execution and usability observations do not by themselves change KANBAN maturity.

R02 may recommend learner checks, such as asking the learner to:

- distinguish exact from similar Product;
- distinguish staged Item from Purchase Item;
- explain package size versus packages bought;
- distinguish atomicity from idempotency;
- identify raw versus derived price facts;
- explain why personal price change is not general inflation.

No maturity change occurs unless explicit learner evidence is later recorded and promoted correctly.

# 9. Human decisions required

R02 must seek or preserve decisions on:

1. Catalogue, Products or My products;
2. Product code visibility and requirement;
3. quantity-entry model;
4. Store branch/location vocabulary;
5. Review as separate route or explicit list phase;
6. draft persistence language;
7. retry/unknown-outcome language;
8. price change versus personal inflation/deflation;
9. selected comparison basis and interval;
10. backup/export promise presented to the user.

# 10. Required R02 report

Replace B with C08-R02 and report:

- accepted and rejected vocabulary;
- conflicts with J or this E;
- concepts covered by existing KANBAN owners;
- genuinely uncovered teaching objects;
- exact user-facing state language candidates;
- analytics claim boundary;
- learner checks;
- unresolved human choices;
- recommendations for revised J and E.

Do not modify permanent Didactic files, product source or another stage.

---

<!-- ENRICHMENT_MARKER:C08-C08-R02-Didactic-2026-07-13 -->
# Cycle 08 Round C08-R02 — Provisional Didactic Enrichment

> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX  
> Purpose: Domain confrontation; no implementation authority  
> Main source: J C08-R02 reconciliation at `b244f41c9f76baec3123e7584364969bcc7bc588`  
> Inputs: latest cumulative A/B/C C08-R02 rounds and preceding D/E/F content

## 1. Successive-round classification

Retained:

- Catalogue Product versus Purchase Item;
- exact equivalence versus advisory similarity;
- package size/count/total amount distinctions;
- staged versus registered Item;
- review versus registration;
- raw fact versus derived comparison;
- personal price change versus general inflation;
- project evidence versus learner evidence.

Corrected:

- Product code is mandatory in current domain/UI, not merely advanced vocabulary;
- Catalogue list/similarity ports exist, but a user selection journey does not;
- Store selection/duplicate warning is absent;
- current UI is MASS-only and BRL/two-decimal;
- History loading/error currently appears empty;
- retry language is prospective because idempotency is absent;
- Device sequence and raw exceptions are current technical leakage, not intended vocabulary.

Newly added:

- explicit labels for current defect versus proposed outcome;
- Product-code decision as a structural vocabulary decision;
- Store record identity versus Store recognition;
- known failure versus unknown outcome;
- application-local versus restored draft language.

## 2. Current-versus-proposed vocabulary

| Current repository behavior | Proposed product language |
| --- | --- |
| Product code mandatory | Product code, with visibility still a human choice |
| UI always creates new reference | Choose existing Product or create a new Product |
| advisory warning after staging | Similar Product found; choose existing or create anyway |
| free-text Store name | Choose or create Store |
| MASS-only Quantity labels | Package size, packages bought, total amount bought |
| raw error string | Validation, registration failure, or unknown result |
| Device sequence in success | Purchase registered locally |
| History error as empty | Loading, no purchases, failed to load, retry |
| summary only | Purchase History, then Purchase details |
| no analytics | Price change in your purchases |

## 3. Required state-language algebra

Later implementation staging must distinguish:

- initial;
- loading/searching;
- genuine empty;
- no exact Product;
- similar advisory;
- invalid input;
- editable draft;
- review-ready;
- registering;
- registered locally;
- known failure;
- unknown outcome;
- retrying identical intent;
- conflicting retry;
- failed History load;
- incompatible comparison;
- recovered or discarded draft.

Do not promise identical/conflicting retry until Design/Operational evidence establishes SubmissionId behavior.

## 4. Product-code and identity boundary

R03 must confront:

- mandatory visible code;
- mandatory but visually secondary code;
- optional code requiring domain/schema/contracts;
- auto-generated visible code, provisionally discouraged because it risks confusing internal and human identity.

Internal Product UUID, normalization keys, Device, Event and sequence remain hidden from ordinary UI.

## 5. Quantity and Store boundary

Quantity language must follow the selected data truth:

- derive total amount from package size × count;
- record total as independent observed fact;
- or show both with consistency explanation.

Store language must distinguish:

- Store record;
- visible Store name;
- optional branch/location;
- similar Store warning;
- exact reuse.

No ordinary wording may imply that same-name Stores are already normalized or merged.

## 6. Analytics boundary

First comparison should state:

- Product;
- source Purchases;
- dates and Stores;
- currency;
- dimensional/unit basis;
- compared price;
- percentage change;
- incompatibility reason;
- algorithm/version in technical explanation, not necessarily primary UI.

Primary candidate remains:

`Price change in your purchases`

“Personal inflation/deflation” remains secondary or deferred.

## 7. Learner evidence requested for C08-R03

Ask the learner to explain or apply:

- Product code versus Product UUID;
- exact versus similar Product;
- Store identity versus Store name;
- package size/count/total amount;
- staged versus registered Item;
- atomicity versus idempotency;
- known failure versus unknown outcome;
- raw versus derived price data;
- personal price change versus general inflation.

No KANBAN maturity change follows automatically.

## 8. Decisions Main cannot infer

- Products/My products/Catalogue;
- code visibility/optionality;
- quantity model;
- Store branch language;
- Review presentation;
- draft-recovery promise;
- retry wording;
- price-change versus personal-inflation wording;
- export/restore promise.

## 9. Evidence requested from Didactic C08-R03

Report:

- preferred exact UI terms;
- current defect versus proposed-copy table;
- existing KANBAN owner for each distinction;
- genuinely uncovered concepts;
- learner checks;
- language consequences of each human alternative;
- corrections required in J/E.

Codex remains inactive. No Didactic promotion is authorized.
