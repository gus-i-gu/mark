# E_DDC_STAGE — Purchase Phase Diagnostic Semantics

> Authority marker: C10-MCG02-PURCHASE-TRANSACTION-DIAGNOSTIC_20260720T205714Z
> Status: **ACTIVE CODEX SEMANTIC AUTHORITY**

- `purchase-registration-<phase>-failed` — unexpected failure before commit at one closed phase;
- `purchase-registration-not-applied` — rollback confirmed; retry only after correction;
- `purchase-registration-unknown` — commit boundary cannot be established; check History first;
- `purchase-registered-locally` — Purchase/event/outbox committed atomically;
- `draft-preserved-in-memory` — current process retains staged input; restart persistence is absent;
- `binding-preserved` — hosted Account/server Device state was not changed by failure.

Phase feedback names only the operation boundary and recovery action. It must not expose exception
text or data. Absence from History after the reported failure validates `not-applied`, not
`unknown`. Fixture success does not override contradictory human evidence; provider sync and MCG-02
closure remain unclaimed.
