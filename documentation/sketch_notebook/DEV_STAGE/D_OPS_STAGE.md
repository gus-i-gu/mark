# D_OPS_STAGE — Explicit Purchase Store Selection Correction

> Authority marker: C10-MCG02-STORE-SELECTION-CORRECTION_20260720T201904Z
> Required ancestor: bf78a3908ad05b3e7a0decc197fa2f99970059f1
> Status: **ACTIVE CODEX MATERIALIZATION AUTHORITY**

## Objective

Make an existing same-Account Store explicitly and durably selectable in Purchase, then prove the
complete Catalogue Store creation through local Purchase registration flow under a hosted binding.

## Checkpoints

1. Reproduce the observed flow with a widget/integration test before fixing it: create Store in
   Catalogue, navigate to Purchase, select it, refresh/navigate, stage an existing Product and
   register.
2. Determine whether failure is selection state, object identity, refresh ordering, missing staged
   Product or another evidenced cause. Record the exact cause in G/I; do not preserve a hypothesis
   as fact.
3. Bind Purchase selection through stable `StoreId` rather than reconstructed Store object identity.
4. Do not silently select the first Store. Show a `Select Store` placeholder and require a deliberate
   user choice. Display a bounded `Selected Store: <name>` confirmation after selection.
5. Preserve a valid selected StoreId across Catalogue refresh and IndexedStack navigation; clear it
   with truthful feedback only when that Store is absent from the active Account.
6. Keep Store creation in Catalogue and Purchase registration limited to `ExistingStoreReference`.
7. Distinguish `store-required` from `item-required`; registration must not imply the Store is unset
   when only the Item draft is missing.
8. Prove successful hosted-bound registration creates one Purchase, one v3 event and one pending
   outbox row, with rollback and draft-preservation regressions still passing.

## Validation

- focused Store-selection and full Catalogue-to-Purchase widget tests;
- local-only and hosted-binding repository tests;
- `flutter analyze`, complete `flutter test`, format check;
- supported Android debug and Windows release builds;
- `git diff --check`, exact changed paths and tracked/staged secret scan.

## Boundaries and stop rules

Do not migrate/reset Drift, access Auth0/Render/Neon, deploy, alter event/API contracts, redesign
navigation, change unrelated pages, promote permanent memory or start MCG-03/04. Preserve private
untracked files and existing application databases. Replace G/H/I with evidence, commit and push
one bounded correction without force.

Success terminal:

~~~text
C10_MCG02_STORE_SELECTION_CORRECTED
~~~

Otherwise report `C10_MCG02_STORE_SELECTION_PARTIAL` and the exact blocker.
