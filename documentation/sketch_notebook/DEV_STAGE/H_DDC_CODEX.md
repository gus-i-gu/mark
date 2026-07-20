# H_DDC_CODEX - Store and Purchase Correction Semantics

- Authority marker: C10-MCG02-HOSTED-PURCHASE-CORRECTION_20260720T193745Z
- Baseline HEAD before correction: be0462a7de79de706420dbbeb9686f01579baed6
- Final commit SHA: resolved after commit; Codex terminal response reports it.
- Evidence boundary: local Flutter/Dart source, file-backed Drift tests, widget tests, Android/Windows local builds. No provider operation.

## Materialized Vocabulary

- `store-created`: materialized by `CatalogueQueryRepository.createStore()` and the Catalogue Stores section. A Store is durably available to the active Account.
- `store-required`: materialized by Purchase UI when no Store exists; the user is told to create a Store in Catalogue before registering.
- `purchase-registered-locally`: retained as the success message for local Purchase registration and not used as hosted sync completion.
- `purchase-registration-not-applied`: represented by typed `AppFailure` outcomes where the transaction rolls back and the in-memory draft remains.
- `purchase-registration-unknown`: materialized as the stable unexpected-error code; the UI tells the user to keep the draft and check History before retrying.
- `provider-sync-completed`: not introduced or claimed by this correction.

## UI and Draft Semantics

Catalogue now presents Stores as a section separate from Products. Store creation trims names, rejects empty names, and deterministically reuses exact same-Account duplicates. Cross-Account Stores are not listed.

Purchase now selects an existing Store only. Inline Store creation was removed from Purchase to avoid ambiguous registration-time catalogue mutation. If no Store exists, Purchase gives the truthful instruction to create one in Catalogue. Existing in-memory staged Items remain in the `IndexedStack` flow while navigating between Purchase and Catalogue; no durable draft persistence is claimed.

Typed `AppFailure` is caught separately and displayed through code, field-aware user message, outcome, recovery and draft-preservation wording. Unexpected errors display only `purchase-registration-unknown` and generic recovery. Production UI does not display exception text, SQL, paths, UUIDs, provider credentials, payload facts or stack traces.

## Named Semantic Tests

- `Catalogue creates a Store for the active Account`
- `empty Store name is rejected`
- `same-Account duplicate Store creation reuses the existing Store`
- `cross-Account Store visibility is denied`
- `Purchase requires an existing Store`
- `registration failure preserves the staged draft`
- `typed AppFailure produces sanitized UI diagnostics`
- `unexpected failure produces a stable generic code and logs no provider credentials or facts`
- `local-only purchase registration still succeeds`
- `hosted-bound Purchase A registration succeeds`
- `registration creates exactly one event and one pending outbox record`
- `transaction rollback leaves no partial Store/Purchase/Event mutation`
- `reopening the database preserves Store, Purchase, event, outbox, binding, and device sequence`

## Wording Guard

No source, test or report claims provider convergence, provider synchronization completion, MCG-02 closure, MCG-03 activation or MCG-04 activation. This is a local corrective implementation and validation boundary only.

## Exclusions

No provider credentials, tokens, callback URLs, identity subjects, Neon strings, Render secrets, SQL connection strings or private provider files were read or persisted.
