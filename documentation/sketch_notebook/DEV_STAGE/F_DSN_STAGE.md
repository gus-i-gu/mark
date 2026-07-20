# F_DSN_STAGE — Store Selection Design Correction

> Authority marker: C10-MCG02-STORE-SELECTION-CORRECTION_20260720T201904Z
> Status: **ACTIVE CODEX DESIGN AUTHORITY**

## Selected state model

~~~text
Account-scoped List<Store>
  + selectedStoreId: StoreId?
  -> resolve Store by ID in current list
  -> ExistingStoreReference(selectedStoreId)
  -> LocalPurchaseRepository transaction
~~~

The widget stores a stable ID, not a `Store` row/object instance. An explicit placeholder represents
null selection. Refresh retains the ID only when the current Account-scoped list contains it.
Presentation resolves the Store name from the current list and shows explicit confirmation.

## Invariants

- availability, display and selection are separate states;
- no first-row implicit fallback after initial load or refresh;
- foreign/cross-Account Store IDs cannot become command references;
- selection survives valid refresh/navigation and clears deterministically when invalid;
- Purchase submission uses only `ExistingStoreReference`;
- Store selection and Item staging failures remain distinguishable;
- registration, event v3, outbox, binding and rollback invariants from `bf78a39` remain unchanged.

No schema, migration, API, event or provider change is authorized. Durable Purchase draft storage,
Store edit/archive UX, broader Catalogue redesign and MCG-03/04 remain deferred.
