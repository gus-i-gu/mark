# F_DSN_STAGE — Persistent Transaction Diagnostic Design

> Authority marker: C10-MCG02-PURCHASE-TRANSACTION-DIAGNOSTIC_20260720T205714Z
> Status: **ACTIVE CODEX DESIGN AUTHORITY**

## Boundary

~~~text
PurchasePage
  -> RegisterPurchaseCommand
  -> LocalPurchaseRepository phase boundary
  -> one Drift transaction
  -> typed safe failure or committed Purchase/event/outbox
~~~

Phase classification belongs at the application/infrastructure boundary that knows the current
operation. UI renders the closed result and does not inspect Drift exceptions. Tests may retain the
original exception as an in-memory cause for assertions; production messages/logs may not serialize
it.

## Representative lifecycle

~~~text
historical schema -> supported migration to v7 -> reopen
local Account/Device/facts -> hosted enrollment state -> restart binding
existing hosted Store/Product -> explicit selection -> registration
~~~

## Invariants

- one outer transaction owns every registration mutation and phase;
- phase wrapping does not convert typed domain failures into unknown failures;
- rollback never advances Device sequence or creates partial event/outbox state;
- migrated and fresh databases obey the same Account/Device/Store/Product relationships;
- no fix may relabel local facts, synthesize missing human rows or weaken foreign keys;
- payload v3, StoreId selection, hosted binding and provider configuration remain unchanged.

No schema migration is authorized. If the cause needs one, stop for Main restaging. Human database
forensics, durable drafts, broader error telemetry, provider operations and MCG-03/04 are deferred.
