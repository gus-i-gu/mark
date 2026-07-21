# I_DSN_CODEX - Closure Diagnostics Design

> Unit: C10-MCG02-CLOSURE-DIAGNOSTICS_20260721
> Result: C10_MCG02_CLOSURE_DIAGNOSTICS_IMPLEMENTED

## Final Architecture

```text
NativeClosurePage
  -> NativeAuthClosureRunner
       -> existing auth/enrollment/sync commands
       -> ClosureDiagnosticsQuery
       -> SyncAttemptRecorder

ClosureDiagnosticsQuery / SyncAttemptRecorder
  -> DriftClosureDiagnosticsRepository
       -> local Drift tables only
```

Closure remains separate from Settings. Widgets render diagnostic view models and never depend on Drift rows.

## Query And Ledger Responsibilities

`ClosureDiagnosticsQuery` owns read-only snapshot retrieval for the active Account/environment scope.

`SyncAttemptRecorder` owns the local-only attempt lifecycle:

```text
beginSyncAttempt
  -> HostedSyncCoordinator.run
  -> completeSyncAttempt exactly once for returned/caught terminal outcome
```

The recorder is outside Purchase/event/outbox transactions. A diagnostic write does not change synchronization decisions, transport behavior, event identity, outbox ordering, recovery representation or server transaction boundaries.

## Migration Direction

Local Drift schema version is now 9.

The migration direction is strictly forward:

```text
v8 -> v9: create sync_attempts
```

No existing user fact is reset, relabeled, deleted, merged or synthesized. No PostgreSQL migration or server schema change exists in this unit.

## Snapshot Invariants

Snapshots are Account/environment scoped and contain:

- authentication state supplied by the runner;
- hosted enrollment state from local hosted-auth state;
- readiness code derived from auth, enrollment and local queue state;
- pending, uploading, failed and unknown queue counts;
- current local Device next sequence;
- last locally recorded successful Sync completion;
- newest 20 Sync attempts;
- newest 20 pending/failed/unknown actionable events;
- redacted Device summaries;
- refresh timestamp.

Ordering is deterministic: newest timestamps first where applicable, with local ID or stable event order tie-breakers. Fingerprints are presentation-safe derivatives and are not replacement identities.

## UI Boundary

The Closure page contains vertically stacked diagnostic sections plus the existing command buttons. `Refresh diagnostics` invokes only the local query. `Clear diagnostic history` is guarded by a confirmation dialog and delegates only to the attempt-ledger clear operation.

Actions refresh diagnostics after completion and do not clear prior diagnostics while running.

## Preservation Guarantees

This unit does not modify:

- server API routes;
- event versions or payload contracts;
- EventId, AccountId, DeviceId, Device sequence, payload, occurrence time or content hash;
- sync upload/download/acknowledgement decisions;
- ordered outbox selection or failed/notApplied recovery representation;
- hosted Account/Device binding semantics;
- cursor or acknowledgement state;
- Purchase registration or History behavior;
- Settings navigation or unrelated pages.

## Deviations And Residual Work

The first Windows release build failed because a local `markei` process locked build output. After stopping that local process only, the Windows release build passed.

No provider retest was run. Human/provider completion remains pending outside this commit.
