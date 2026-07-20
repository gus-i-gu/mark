# I_DSN_CODEX - Persistent Transaction Diagnostic Design Evidence

- Authority marker: C10-MCG02-PURCHASE-TRANSACTION-DIAGNOSTIC_20260720T205714Z
- Baseline HEAD before diagnostic: 3bad6f819776094a0e621231c2bee3d4a252a1ff
- Final commit SHA: self-referential Git SHA is reported in the Codex terminal response.

## Transaction Boundary

The Purchase registration path remains:

`PurchasePage -> RegisterPurchaseCommand -> LocalPurchaseRepository -> one Drift transaction -> typed AppFailure or committed Purchase/event/outbox`

`LocalPurchaseRepository` now holds the current closed phase inside the transaction. Typed domain/application failures rethrow unchanged. Unexpected infrastructure failures are converted to `AppFailure` with a phase-specific code and `FailureOutcome.notApplied`, causing Drift to roll back the transaction.

## Precise Root Cause

The migrated lifecycle fixture reproduced the first failing phase at `insert-purchase`. Schema inspection of the disposable file-backed database showed that the production v2-to-v7 migration leaves foreign keys in migrated tables pointing at dropped temporary tables:

- `purchases.payment_method_id -> payment_methods_old.id`;
- `purchases.person_id -> people_old.id`;
- `purchase_items.product_id -> products_old.id`.

The new Purchase insert fails before item insertion, sequence allocation, event serialization, event insertion or outbox insertion. This explains a local registration failure with no Purchase in History.

## Corrected Invariant

The corrected invariant in this bounded unit is diagnostic and transactional:

- every unexpected failure maps to the first closed phase;
- the failure is reported as not applied;
- no SQL, exception text, path, identifier, payload or credential reaches production UI;
- original cause remains test-only in memory;
- rollback preserves existing facts, cursor, binding, event/outbox rows and Device sequence.

The data/schema invariant itself is not corrected because that requires schema repair or migration authority.

## Migrated Lifecycle Fixture

The fixture starts from supported historical schema v2, migrates through `LocalDatabase` to v7, then applies hosted identity through `DriftHostedIdentityRepository`. It includes:

- pre-existing cursor;
- pre-existing local Device sequence;
- local-only pending event;
- previously synchronized hosted-device event;
- hosted binding applied after local facts already exist;
- Store and Product present before hosted binding;
- close/reopen before registration and close/reopen after failure.

## Account/Device/Fact Preservation

After failed registration, the fixture verifies:

- one pre-existing Purchase remains visible in History;
- no second Purchase is inserted;
- event and outbox counts remain unchanged;
- SyncState cursor is unchanged;
- hosted server Device sequence is unchanged;
- hosted binding remains persisted.

No local facts are relabeled, no hosted binding is rewritten, and no local-only event is translated.

## Deviations and Deferrals

No schema repair was attempted. D/E/F prohibit a Drift schema migration and explicitly require stopping for Main restaging when the cause needs one. The next authorized unit should decide how to repair existing v7 databases with malformed temporary-table foreign keys and how to validate a successful human retest afterward.

Provider synchronization proof, durable drafts, broader telemetry, MCG-02 closure, MCG-03 and MCG-04 remain deferred.
