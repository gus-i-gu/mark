# I_DSN_CODEX - Hosted Purchase Correction Design Evidence

- Authority marker: C10-MCG02-HOSTED-PURCHASE-CORRECTION_20260720T193745Z
- Baseline HEAD before correction: be0462a7de79de706420dbbeb9686f01579baed6
- Final commit SHA: resolved after commit; Codex terminal response reports it.

## Dependency Direction

The correction preserves the selected boundary:

`Catalogue UI -> CatalogueQueryRepository Store port -> LocalQueryRepository -> existing stores table`

`Purchase UI -> ExistingStoreReference -> LocalPurchaseRepository transaction -> Purchase + Items + purchase.registered v3 + PendingEvent`

Widgets still depend on application ports. Drift operations remain in infrastructure. No domain object, event payload contract, server API, server authorization path or schema version was changed.

## Repository and Transaction Correction

`CatalogueQueryRepository` now exposes `createStore(AccountId, displayName)`. `LocalQueryRepository` implements it through a transaction that:

- trims and validates the Store name;
- ensures the Account with insert-ignore semantics;
- reuses an exact same-Account duplicate deterministically;
- inserts a new Store only for the active Account.

`LocalPurchaseRepository` now ensures local Account and SyncState rows with insert-ignore semantics instead of upsert rewrite. This preserves existing hosted Account rows and existing cursor state during purchase registration. Device identity remains insert-ignore. Registration remains one transaction.

## Store Account Scope

Store listing was already Account-scoped and remains so. Store creation scopes duplicate lookup and insertion by the active Account. Cross-Account Store visibility is denied by repository tests and no UI path exposes foreign Stores.

## Hosted Registration Invariant

After restart, the hosted composition still supplies the hosted AccountId and server DeviceId. Hosted-bound Purchase A registration now succeeds using an existing same-Account Store and Product. The resulting `purchase.registered` event embeds:

- AccountId `11111111-1111-4111-8111-111111111111`;
- DeviceId `22222222-2222-4222-8222-222222222222`;
- payload version `3`.

No local-only event is relabeled or translated.

## Event and Outbox Invariants

Success creates exactly one immutable SyncEvent and one PendingEvent. The event content hash revalidates from canonical JSON. Rollback leaves no partial Store, Purchase, PurchaseItem, SyncEvent, PendingEvent or Device sequence mutation from the failed transaction. Close/reopen preserves Store, Purchase, event, pending outbox row, active binding and next Device sequence.

## UI Boundary

Catalogue gained a minimal Stores section. Purchase removed inline Store creation and reloads Catalogue data when the app refresh signal changes, preserving staged in-memory Items while navigating through the existing `IndexedStack`. Navigation architecture, visual language, Analytics, PIN pages, Settings and unrelated pages were not redesigned.

## Compatibility Choices

`NewStoreReference` remains in the application command type and repository implementation for existing isolated tests and compatibility. Production Purchase UI now uses only `ExistingStoreReference`. Inline NewStore handling became duplicate-aware but is no longer the intended user path.

## Deviations and Residual Risks

No schema migration was needed. The exact provider-side Purchase A retry remains a human/provider gate after this local correction is published. This unit does not prove provider convergence, Device B enrollment, revocation denial, API outage recovery, logout token ephemerality, permanent promotion, MCG-02 closure, MCG-03 or MCG-04.
