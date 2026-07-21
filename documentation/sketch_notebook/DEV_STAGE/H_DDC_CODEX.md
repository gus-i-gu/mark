# H_DDC_CODEX - Unknown Recovery Semantics

> Unit: C10-MCG02-UNKNOWN-RECOVERY_20260721
> Result: C10_MCG02_UNKNOWN_RECOVERY_IMPLEMENTED

## Materialized States

- `unknown-retry-authentication-required`: Closure recovery action is blocked before transport when the user is not authenticated.
- `unknown-retry-device-enrollment-required`: recovery is blocked when the active local hosted binding is absent or not enrolled for the scoped Account/Device.
- `unknown-retry-no-unresolved-submission`: zero eligible unknown submissions is an ordinary no-op.
- `unknown-retry-ambiguous-unresolved-submission`: multiple scoped unknown submissions are ambiguous and fail closed.
- `unknown-retry-queue-not-isolated`: unknown recovery is blocked while scoped pending/uploading/failed work is also present.
- `unknown-retry-state-invalid`: malformed membership, missing member rows, non-contiguous positions or sequences, request identity mismatch, payload/content mismatch or stale local sequence fails closed.
- `unknown-retry-eligible`: one scoped unresolved submission can be retried through normal Sync after explicit user confirmation.
- `unknown-retry-cancelled`: user cancellation performs no transport request and no queue or submission mutation.

## User Semantics

Closure now includes `Retry unresolved submission` as a deliberate action separate from ordinary Refresh and Sync. The confirmation dialog displays only sanitized facts:

- bounded Device sequence range;
- next local Device sequence;
- short submission fingerprint;
- stable guidance that the hosted outcome is unresolved.

The UI does not display submission IDs, request hashes, event IDs, Account IDs, Device IDs, payloads, provider hosts, tokens, SQL, stack traces or raw exception text.

Blocked preflight and cancellation do not record a diagnostic attempt. A confirmed eligible recovery delegates to the existing hosted Sync probe path, which records exactly one durable diagnostic attempt for the invocation and refreshes diagnostics after the terminal result.

## Retry Semantics

Ordinary Sync already preserved unknown retry identity once the outbox contained one unknown submission and no pending work. This unit strengthens that behavior by:

- proving the persisted membership shape before exposing a user action;
- rejecting ambiguous or malformed unknown state;
- preventing ordinary scoped Sync from bypassing unknown work with unrelated pending work;
- proving upload serialization uses the existing ordered membership.

The retry reuses:

- the same submission identity;
- the same request hash;
- the same ordered members;
- the same event identity and content;
- the same Device sequences.

No replacement submission is allocated for an eligible unknown retry.

## Outcome Semantics

Terminal persistence through the normal outbox path now has focused tests for:

- accepted: original rows converge to accepted;
- duplicate-equivalent: original rows converge to accepted without duplicate local identity;
- repeated unknown: original rows remain unknown with the same retry identity;
- stable not-applied: original rows move to failed using existing failed/recovery representation;
- sequence/hash/Account/Device conflicts: existing typed failure-code behavior remains preserved and visible through bounded result codes.

Malformed, cross-scope, non-contiguous, missing-member, multiple-unknown or non-isolated states fail closed before transport.

## Semantic Tests

- `unknown retry preflight proves exact persisted submission shape`
- `unknown retry preflight blocks malformed persisted identity`
- `unknown retry preflight fails closed for ambiguous candidates`
- `unknown retry preflight blocks unauthenticated and non-isolated queues`
- `file-backed unknown retry reuses exact submission for sequences one and two`
- `same-submission unknown retry persists accepted`
- `same-submission unknown retry persists duplicate-equivalent`
- `same-submission unknown retry persists repeated-unknown`
- `same-submission unknown retry persists stable-not-applied`
- `ordinary sync cannot bypass a scoped unknown submission with pending work`
- `ordinary sync fails closed for multiple unknown submissions`
- `Retry unresolved submission cancellation does not start Sync`
- `Retry unresolved submission confirms and refreshes diagnostics`
- `Retry unresolved submission blocked preflight is non-mutating`
- `runner retry blocks before ledger when preflight is ineligible`
- `Windows auth0flutter protocol registration contract`
- `desktop rail reaches Closure at short height without overflow`
- `desktop rail reaches Closure at tall height without overflow`

## Windows Semantics

The repository-owned Windows helper registers only the current-user `auth0flutter` protocol handler. It requires a local executable path, quotes the executable and `%1`, and carries no tenant/provider/callback values. Developer setup guidance uses placeholders only.

Desktop navigation preserves destination order and selected-index alignment. The rail is vertically scrollable at short heights, so Closure remains reachable without RenderFlex overflow.

## Privacy Evidence

Reports and UI use stable bounded codes and short fingerprints only. No provider-side success, hosted state freshness, or human database correction is claimed. The real Windows provider retest remains pending.
