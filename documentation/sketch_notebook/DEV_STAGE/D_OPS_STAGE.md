# D_OPS_STAGE — Persistent Purchase Transaction Diagnostic

> Authority marker: C10-MCG02-PURCHASE-TRANSACTION-DIAGNOSTIC_20260720T205714Z
> Required ancestor: bf824cea0648202cf9e04ad98553239c00dab6e0
> Status: **ACTIVE CODEX DIAGNOSTIC/CORRECTION AUTHORITY**

## Objective

Identify the exact registration phase failing in a long-lived, migrated, hosted-bound Drift
database; correct only the evidenced cause; preserve atomicity and produce safe human diagnostics.

## Checkpoints

1. Add closed registration phases: `ensure-account`, `ensure-sync-state`, `ensure-device`,
   `resolve-store`, `resolve-references`, `resolve-product`, `build-purchase`, `insert-purchase`,
   `insert-items`, `allocate-sequence`, `serialize-event`, `insert-event`, `insert-outbox`.
2. Preserve typed `AppFailure`. Map unexpected failures at the current phase to a stable
   `purchase-registration-<phase>-failed` result without exception text, SQL, IDs, facts, paths,
   payloads, credentials or stack traces. Detailed cause/type may exist only in tests.
3. Build a file-backed fixture through supported historical Drift migrations to v7. Seed an
   ordinary local Account/Device and facts, then add a valid hosted binding/server Device, close and
   reopen, create/select same-Account Store/Product and attempt Purchase registration.
4. Add structural variants supported by real history: pre-existing SyncState/cursor, Device
   sequence, local-only facts/events, hosted binding, Catalogue facts and reopen. Do not fabricate
   invalid rows through disabled foreign keys.
5. Reproduce the human failure or establish the exact missing evidence boundary. Fix only the
   reproduced cause; never reset, rewrite or import the human database.
6. Prove failure rolls back Store/Purchase/Items/sequence/event/outbox and leaves draft/binding
   intact. Prove success produces exactly one Purchase, v3 event and pending outbox row.
7. Preserve Store-selection tests, local-only registration, hosted fresh-fixture registration and
   file-backed reopen behavior.

## Validation

- focused migration/reopen/transaction/phase-diagnostic tests;
- full Flutter tests, `flutter analyze`, format check;
- supported Android debug and Windows release builds;
- no TypeScript/API work unless a shared contract actually changes (not expected);
- `git diff --check`, exact changed paths, tracked/staged secret and artifact scan.

## Stop rules

No Auth0, Render, Neon, provider secrets, deployment, human database read/copy/reset, schema
migration, event/API change, authorization weakening, navigation redesign, permanent promotion or
MCG-03/04. If safe fixtures do not reproduce the cause, deliver phase diagnostics only and report
partial so the human can perform one controlled retest.

Success only when cause is reproduced and fixed:

~~~text
C10_MCG02_PERSISTENT_PURCHASE_TRANSACTION_CORRECTED
~~~

Otherwise:

~~~text
C10_MCG02_PERSISTENT_PURCHASE_TRANSACTION_PARTIAL
~~~

Include whether bounded diagnostics are ready for one human retest.
