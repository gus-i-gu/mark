# I_DSN_CODEX

Authority marker: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722

Final dependency direction:
- Flutter Closure/Sync coordinator -> `HttpSyncTransport` -> Fastify protected Sync route.
- Fastify protected route -> authorization fixture/hosted composition -> transaction wrapper -> Sync application service -> PostgreSQL client.
- Sync application service owns protocol result selection; Fastify owns HTTP status mapping and sanitized lifecycle logging.

Failing call boundary:
- The failing boundary was inside `acceptSubmission` after Device sequence validation and before hosted event/submission insertion.
- Missing `account_cursor_state` caused a zero-row cursor update; the previous implementation treated the returned row as mandatory and threw.
- The correction checks the update row count and returns bounded `service-unavailable` without allocating a cursor or writing event/submission rows.

Error mapping:
- Protected Sync and recovery routes now use the existing `sendHostedResult` helper so `ProtocolFailure` maps to non-2xx HTTP status.
- `service-unavailable` maps to HTTP 503.
- Flutter maps protocol code `service-unavailable` to `SyncStatusCode.serviceUnavailable`.
- Coordinator treats that status as Sync unavailable, distinct from `unknownOutcome` interruption.

Transaction observation:
- The missing cursor-state result is a typed not-applied application result, so the transaction commits no hosted user facts and performs no immutable event/submission insert.
- Unexpected exceptions still flow through rollback and the error handler.
- Lifecycle request-failed no longer records a successful status when Fastify has not yet assigned the final error response.

Logging placement:
- Fastify lifecycle observer remains bounded and sanitized.
- The request-failed hook records either a non-success status already known at the hook or an `unexpected-server-error` result without status.
- Final `response-completed` remains the authoritative terminal HTTP status event.

Deadline decision:
- No client deadline extension was made.
- The local server cause is understood and corrected; timeout/no-response semantics remain unknown-outcome preserving.
- Observed HTTP 503 JSON before deadline is classified as a server protocol failure.

Migration decision:
- No Drift or PostgreSQL migration was added.
- Existing migrations 001-006 remain unchanged.
- The missing-row runtime path is now fail-closed; creating or repairing provider cursor state remains outside this unit unless Main authorizes a database policy change.

Preserved invariants:
- Event identity, payload, content hash, Device sequence and request identity are unchanged.
- JWT/JWKS, hosted authorization, Device enrollment, RLS, route inventory, recovery identity and server transaction behavior are not weakened.
- No provider configuration, credentials, private database, human event rows or deployment state were accessed or changed.
