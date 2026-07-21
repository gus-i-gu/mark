# I_DSN_CODEX - Unknown Recovery Design

> Unit: C10-MCG02-UNKNOWN-RECOVERY_20260721
> Result: C10_MCG02_UNKNOWN_RECOVERY_IMPLEMENTED

## Final Dependency Direction

```text
NativeClosurePage
  -> NativeAuthClosureRunner
       -> ExternalAuthenticationSession
       -> ClosureDiagnosticsQuery
       -> existing hosted Sync probe

ClosureDiagnosticsQuery
  -> DriftClosureDiagnosticsRepository
       -> local Drift diagnostic and outbox tables

UploadPendingEvents
  -> SyncOutboxRepository
       -> DriftSyncOutboxRepository
  -> SyncTransport
```

Closure remains separate from Settings. Widgets consume application view models and do not depend on Drift rows.

## Port And Repository Responsibilities

`ClosureDiagnosticsQuery.unknownSubmissionRetryPreflight` is the read-only application query for the Closure recovery action. It accepts only the current authentication state from the runner and uses the repository's configured Account/environment/Device scope.

`DriftClosureDiagnosticsRepository` verifies:

- authenticated state;
- active local hosted binding and enrollment;
- scoped Device row;
- zero scoped pending/uploading/failed work beside unknown work;
- exactly one scoped unknown submission;
- complete membership rows ordered by position;
- unique and contiguous membership positions;
- existing member events;
- scoped Account/Device consistency;
- unique and contiguous Device sequences;
- event payload/content hash consistency;
- pending rows for every member in `unknown`;
- recomputed request identity equals the stored identity;
- local next Device sequence follows the last member sequence.

It returns only bounded state/guidance codes and sanitized counts/fingerprint.

## Retry Boundary

`NativeClosurePage` performs preflight before confirmation. Cancellation or blocked preflight stops locally without transport, outbox mutation or attempt-ledger write.

After user confirmation, `NativeAuthClosureRunner.retryUnresolvedSubmission` delegates to the existing hosted Sync probe. That path retains the existing authentication, enrollment, coordinator, attempt ledger, transport and outbox behavior.

`DriftSyncOutboxRepository.leasePending` now treats a single valid unknown submission as an exact idempotent retry candidate when no pending rows exist. It returns the original upload submission and does not create a replacement submission. If scoped pending work exists beside unknown work, or if multiple unknown submissions exist, it fails closed with `local-batch-invalid`.

## Immutable Event Guarantees

The implementation never modifies:

- EventId;
- AccountId;
- DeviceId;
- Device sequence;
- payload;
- payload version;
- occurrence time;
- content hash;
- stored request hash for unknown retry;
- ordered submission membership.

The only durable state transitions happen through the existing upload-result persistence:

- accepted and duplicate-equivalent -> accepted submission and pending rows;
- repeated unknown -> unknown submission and pending rows remain reusable;
- stable not-applied/conflict -> failed submission and pending rows, available to existing failed/notApplied recovery rules where eligible.

## Idempotency And Concurrency Rules

The durable idempotency key is the existing unknown submission identity plus stored request hash and ordered member list. Reopen or repeated retry uses the same rows as long as the state remains unknown and valid.

Preflight is transactional and read-only. Upload lease revalidates the persisted unknown shape in a transaction immediately before returning the upload submission. Ambiguous or malformed state returns a bounded local failure before transport.

The existing upload-result transaction remains the convergence boundary for accepted, duplicate-equivalent, unknown and failed outcomes.

## Windows Design

`tool/register_windows_auth0flutter_protocol.ps1` is a repository-owned development/install helper for Windows. It writes the current-user protocol registration under `HKCU:\Software\Classes\auth0flutter`, resolves the supplied executable path, and stores a command with quoted executable and quoted `%1`.

The helper intentionally contains no tenant, credential, provider origin or callback data. Strict callback-prefix validation and single-instance forwarding stay in the existing runtime code.

Desktop navigation uses `NavigationRail(scrollable: true)`, preserving destination order, selected-index alignment and compact navigation behavior while allowing short-height Windows layouts to reach Closure.

## Schema And Migration

No Drift or PostgreSQL migration was added. The local Drift schema remains at the prior version from the Closure Diagnostics unit.

## Deviations And Residual Work

- No real provider Sync or unknown recovery invocation was performed.
- No hosted state freshness is claimed.
- The Windows provider retest remains a later human-controlled step.
- Final commit and tree SHAs are reported by Codex after commit because they cannot be embedded in the committed report file without changing themselves.
