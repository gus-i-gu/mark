# H_DDC_CODEX - Purchase Transaction Diagnostic Semantics

- Authority marker: C10-MCG02-PURCHASE-TRANSACTION-DIAGNOSTIC_20260720T205714Z
- Baseline HEAD before diagnostic: 3bad6f819776094a0e621231c2bee3d4a252a1ff
- Final commit SHA: self-referential Git SHA is reported in the Codex terminal response.
- Evidence boundary: local Flutter source, file-backed migration fixture, repository/widget tests, local Android/Windows builds. No provider or private database operation.

## Materialized Diagnostics

- `purchase-registration-<phase>-failed`: materialized for unexpected repository failures before commit.
- `purchase-registration-insert-purchase-failed`: reproduced from the migrated file-backed fixture.
- `purchase-registration-not-applied`: represented by `FailureOutcome.notApplied` and verified by unchanged History/Purchase/event/outbox/sequence counts.
- `purchase-registration-unknown`: retained for UI-level unexpected failures outside typed repository diagnostics.
- `draft-preserved-in-memory`: retained by existing widget tests for typed and unexpected registration failures.
- `binding-preserved`: verified in the migrated lifecycle by applying hosted binding before the failing registration and preserving persisted identity state.

## User-Visible Semantics

Production UI receives an `AppFailure` code and existing bounded recovery wording. It does not display SQL text, raw exception messages, stack traces, filesystem paths, Account/Device/Store/Product/Purchase identifiers, payload facts, credentials or provider configuration.

The original exception is retained only in `AppFailure.debugCause` for in-memory test assertions. `AppFailure.userMessage` and `toString()` do not render that cause.

## History Semantics

The migrated fixture proves that absence from History after this phase failure means `not-applied`: after the registration attempt, History still contains exactly the one pre-existing Purchase and no new Purchase/event/outbox row appears.

This unit intentionally does not use wording that implies a hidden successful commit, provider synchronization, convergence, MCG-02 closure, MCG-03 activation or MCG-04 activation.

## Named Tests

- `migrated hosted lifecycle reports insert-purchase phase and preserves state`
- Retained focused tests: local-only registration, hosted-bound registration, exactly one event/outbox on success, rollback without partial mutation, close/reopen preservation, Store selection and draft-preservation widget tests, and local database migration tests.

## Partial Boundary

The semantic correction is diagnostic, not a completed transaction repair. The reproduced root cause needs a schema repair/restaging, which is outside the current D/E/F authority.
