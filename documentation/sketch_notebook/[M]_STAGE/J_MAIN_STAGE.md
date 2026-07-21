# J_MAIN_STAGE — Unknown-Outbox Recovery Reconciliation

> Sequence: FLX-PRM-04
> Authority marker: C10-MCG02-UNKNOWN-RECOVERY_20260721
> Materialization commit: `3d99f20f634a26ed04c72eafa5caf930ad6619d0`
> Materialization tree: `a7a20635866b7718e82e0870ebc95bf2b9103226`
> Status: **IMPLEMENTATION ACCEPTED; CANCELLED PREFLIGHT VERIFICATION ACTIVE**

## 1. Reconciliation result

Closure diagnostics are implemented, repository-validated and manually verified on the upgraded
Windows database. Two consecutive refreshes showed the same sanitized state and the second refresh
performed no Sync, authentication flow or mutation.

~~~text
authenticated / device-enrolled
unknown-work-needs-review
pending 0 / uploading 0 / failed 0 / unknown 2
unknown Device sequences 1 and 2
next local Device sequence 3
no locally recorded attempt history
~~~

The latest bounded hosted observation remains `submissions 0 / events 0 / next sequence 1`. This is
consistent with a retryable first submission but does not by itself authorize queue mutation or
prove the exact local submission shape.

Manual verification also exposed two separate product defects: Windows lacked installed
`auth0flutter://` protocol registration, and the desktop navigation rail overflowed at the tested
height. Manual current-user registration enabled sign-in; it is evidence of the missing packaging
step, not the permanent solution.

## 2. Materialization reconciliation

Codex returned:

`C10_MCG02_UNKNOWN_RECOVERY_IMPLEMENTED`

The branch is exactly one bounded commit ahead of the authorized stage. The changed paths match the
unit: Closure application/repository/UI code, Sync outbox behavior, Windows registration helper,
developer guidance, focused tests, and G/H/I. No migration, server API, event contract or provider
configuration changed.

Repository evidence accepts these implementation claims:

- one eligible unknown submission is retried with its original submission identity, request hash,
  ordered members, event identity/content and Device sequences;
- malformed, ambiguous, cross-scope and non-isolated state fails closed before transport;
- cancellation and blocked preflight do not start transport or mutate the queue;
- a confirmed invocation delegates to the existing authenticated coordinator and attempt ledger;
- accepted, duplicate-equivalent, repeated-unknown and stable-not-applied outcomes have focused
  persistence tests;
- Windows callback registration is repository-owned and current-user scoped;
- desktop navigation remains reachable without overflow at tested short and tall heights.

Reported validation passed: 167 Flutter tests with 4 skips, clean Flutter analysis and formatting,
Android debug and Windows release builds, 46 API tests plus API format/lint/typecheck/build, diff
checking and bounded privacy/path review.

## 3. PRC-01 classification record

| Candidate claim | Evidence / confidence | Semantic owner and state |
| --- | --- | --- |
| Guarded exact-identity unknown retry exists | Source inspection plus named file-backed and outcome tests; high for repository behavior | Design/Operational permanent memory: eligible after cancelled runtime preflight |
| Windows protocol helper and scrollable navigation exist | Source inspection, contract/widget tests and successful Windows release build; high for implementation | Operational/Design permanent memory: eligible after Windows observation |
| Real sequences 1–2 converge with hosted state | Not tested; provider access was prohibited | Remains unvalidated and must not be promoted |
| Hosted state is still `0 / 0 / 1` | Earlier bounded observation only | Observational and stale until explicitly rechecked |
| MCG-02 is complete | Unknown recovery implementation exists, but provider convergence remains pending | Blocked; no canonical acceptance yet |

G/H/I remain observational evidence. Domain chats may absorb repository architecture and validation
only after the cancelled preflight gate; they must preserve the distinction between local behavior,
platform observation and real hosted convergence.

## 4. Acceptance sequence

1. Human updates the Windows checkout to the reconciled materialization commit.
2. Human runs the repository-owned current-user protocol-registration helper for the built debug
   executable and relaunches Markei with the existing private configuration.
3. Human verifies sign-in, scrollable navigation and unchanged Closure baseline.
4. Human opens `Retry unresolved submission`, verifies an eligible sanitized preflight and cancels.
5. Main reviews that cancellation caused no transport, attempt record or queue mutation.
6. Main may then authorize at most one controlled unknown-submission retry.
7. Human captures sanitized Closure before/after evidence plus hosted `submissions/events/next`
   counts.
8. Convergence is accepted only if local and hosted evidence agree; otherwise Sync remains blocked
   and the stable outcome determines the next unit.

## 5. Current prohibition

Until step 6, do not confirm recovery or press ordinary Sync. Query, Enroll, Clear diagnostic
history, direct database editing, new purchase creation and provider mutation are outside the
verification path. Opening the recovery preflight and cancelling it is authorized.

Success terminal: `C10_MCG02_UNKNOWN_RECOVERY_IMPLEMENTED`
