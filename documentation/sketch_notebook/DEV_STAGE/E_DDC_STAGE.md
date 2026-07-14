# E_DDC_STAGE — Cycle 09 Semantic and Product-Language Contract

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Unit: C09-U02
> Status: ACTIVE — CONTROLLING WITH D/F
> Report: replace `DEV_STAGE/H_DDC_CODEX.md` with a ≤250-line C09 report

## 1. Core distinctions

Implementation and tests must preserve:

- Product UUID ≠ visible Product code ≠ exact identification set;
- Product identification ≠ retry idempotency;
- exact match/collision ≠ similar Product;
- Product facts ≠ Purchase Item facts;
- draft Item ≠ registered read-only Purchase Item;
- package quantity ≠ packages bought ≠ amount bought;
- amount bought ≠ BULK price per unit ≠ line total;
- Purchase facts ≠ personal Lists estimates;
- local Payment Method nickname ≠ payment credential;
- project evidence ≠ learner maturity.

Never auto-merge Products. `Create anyway` is available only for advisory similarity,
never exact code/identity collision.

## 2. Required visible vocabulary

Navigation:

```text
Home · Lists · Purchase · History · Catalogue
Analytics (PIN) · Household (PIN) · Guide · Documentation · Settings
```

Use `Catalogue` for the destination and `Product` for the entity. Settings collection is
`People`; Purchase field is `Person`. Use `Payment Methods` / `Payment Method`, `Nickname`,
`Not assigned`, `Active`, `Archived`, and `Nickname (archived)` in History where needed.

Optional helper:

> People and Payment Methods are optional labels stored locally on this device. A Payment
> Method stores no card number, bank detail or payment credential.

Units are `kg`, `g`, `L`, `ml`, `un`. Explain comma/point input with `1,5` and `1.5`.
PACKAGED uses Package quantity and Packages bought. BULK uses Amount bought and Price per
unit; do not show Packages bought for BULK.

## 3. Home truth boundary

Cards: Recent updates, Scheduled updates, What Markei is for, Mid-term perspectives, How
Markei works, For developers. Copy may be polished but must state only:

- one evolving Flutter codebase for desktop/mobile;
- local offline-first storage and normal use without network;
- local use currently sends no user data or usage analytics to the developer;
- Lists/comparisons are derived from user-registered history;
- sync, Analytics, Household, public distribution and GitHub link are future/unavailable.

Do not claim platform parity, backup, synchronization, measured inventory or release date.

## 4. Lists language

- Storage: estimated to remain available from personal Purchase history.
- Shortage: approaching estimated next-Purchase time.
- Market: estimated personal Purchase cycle has passed.
- All: all Products, including unavailable estimates.
- Not enough history: no reliable cycle yet.

Show algorithm/version only in details/help, not as ordinary jargon. Always pair expected
dates/totals with `Estimate`, `Approximate`, or `Based on your history`.

## 5. Product lookup and details

Visible prompts must distinguish:

- `Product code` — exact code lookup;
- `Product details` — exact identifying fields;
- `This Product already exists. Use the existing Product.`;
- `This Product code is already used...`;
- `A similar Product was found. Compare the details...`;
- `More than one Product matches...` only when ambiguity is real.

Technical UUIDs, normalization keys, Drift rows and raw exceptions stay hidden.

## 6. Error/recovery contract

Every user-facing failure answers what happened, responsible field/operation, safe next
action, and whether the operation is known not applied, known applied, or unknown.

Required distinctions include invalid unit/decimal/quantity, missing identity field,
code collision, exact Product exists, ambiguous lookup, missing Store, persistence failure
and unknown Purchase outcome. Known rollback says the Purchase was not registered and the
draft remains. Unknown outcome tells the user to keep the draft and check History before
retrying. Never expose raw database exceptions.

## 7. History/export language

Selection is accessible; double-click is only a shortcut. Actions:

- `Move to Analytics` — disabled/planned;
- `Export CSV` — active;
- `Share list (PDF)` — active only when generation/save/share succeeded;
- `Edit` and `Delete` — disabled/not supported.

Export copy must state destination/cancellation/failure truthfully and never imply upload.

## 8. Evidence and H report

Codex may change UI copy/tests needed for this contract. It must not update KANBAN maturity,
promote permanent Didactic memory, invent final learning evidence or claim platform
acceptance from widget tests.

Replace H with a concise report of vocabulary changed, conceptual invariants exercised,
tests supporting them, unresolved copy, and evidence limits. Maximum 250 lines.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
