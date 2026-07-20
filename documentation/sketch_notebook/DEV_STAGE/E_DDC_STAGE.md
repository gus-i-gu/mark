# E_DDC_STAGE — Explicit Store Selection Semantics

> Authority marker: C10-MCG02-STORE-SELECTION-CORRECTION_20260720T201904Z
> Status: **ACTIVE CODEX SEMANTIC AUTHORITY**

- `store-available` — Store exists for the active Account; this is not selection.
- `store-selection-required` — no StoreId has been deliberately selected.
- `store-selected` — one visible Store name maps to one stable same-Account StoreId.
- `store-selection-invalidated` — the selected ID disappeared on refresh; no fallback is inferred.
- `item-required` — Store is selected but no Purchase Item is staged.
- `purchase-registered-locally` — selected Store and staged Items committed atomically.

The control must not equate displaying the first Store with user selection. Feedback must identify
whether Store or Item is missing. A refresh may preserve the selection only by matching StoreId.
No wording may claim hosted sync, convergence or MCG-02 closure from local registration.
