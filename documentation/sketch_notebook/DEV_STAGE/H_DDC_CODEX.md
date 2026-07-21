# H_DDC_CODEX - Closure Diagnostics Semantics

> Unit: C10-MCG02-CLOSURE-DIAGNOSTICS_20260721
> Result: C10_MCG02_CLOSURE_DIAGNOSTICS_IMPLEMENTED

## Materialized States

- `current status`: refreshed local observation from authentication state plus scoped local database snapshot.
- `sync attempt`: one explicit user Sync invocation recorded from start to one terminal result.
- `pending`, `uploading`, `failed`, `unknown`: queue states counted from durable local pending-event rows.
- `next Device sequence`: local current Device sequence only; no Neon expectation is inferred.
- `last successful sync`: displayed only from a persisted local attempt with completed outcome.
- `no-recorded-attempts`: the post-implementation ledger has no rows; it does not claim Sync was never tried.

## Display Behavior

Closure now shows:

- Sync overview: authentication, enrollment, readiness, last result, last successful Sync and recovery guidance;
- Local queue: pending, uploading, failed, unknown and next Device sequence;
- Recent sync attempts: newest 20, with fingerprint, stable code, outcome, phase, sanitized recovery code and duration;
- Devices: redacted current/local Device summaries;
- Actionable events: newest 20 pending/failed/unknown rows with fingerprint, event type, sequence, state and timestamps;
- Closure actions: existing Status, Sign in, Enroll, Query, Sync and Logout plus Refresh diagnostics and confirmed Clear diagnostic history.

Missing current values render as `Unavailable` or `Not recorded`; attempt-history absence renders as `No locally recorded attempt history`.

## Semantic Tests

- `snapshot is scoped, ordered, bounded and redacted`
- `clear history preserves queue, Device, binding and cursor state`
- `Closure renders signed-out empty diagnostics`
- `Closure renders enrolled pending failed unknown and history`
- `Refresh diagnostics is local only and does not invoke Sync`
- `Clear diagnostic history is confirmed and scoped to attempts`
- `runner records auth-required Sync terminal outcome once`
- `runner records no-new-events Sync terminal outcome once`
- `runner records completed Sync terminal outcome once`
- `runner records unavailable Sync terminal outcome once`
- `runner records interrupted Sync terminal outcome once`
- `migrates v8 database to v9 attempt ledger without reset`

## Privacy Semantics

The diagnostic surface uses short non-reversible fingerprints for row distinction. It does not display or persist access tokens, refresh tokens, Auth0 subjects, complete Account/Device/Event/Submission UUIDs, provider URLs or hosts, connection strings, HTTP bodies, event or purchase payload JSON, SQL, filesystem paths, stack traces or raw exception text.

Sync result history persists only stable bounded codes:

- phase;
- result code;
- outcome class;
- sanitized recovery code.

Provider-side success, request arrival and convergence remain unclaimed. The old real provider attempt remains external evidence only and is not backfilled into the ledger.

## User Boundaries

Refresh diagnostics is explicit, offline and read-only. It cannot start Sync, transport, recovery, download or acknowledgement.

Clear diagnostic history is user-confirmed and deletes only local attempt history. It does not alter queue rows, immutable events, Devices, purchases, hosted binding, credentials, sync cursor or acknowledgement state.
