# D_OPS_STAGE — Hosted Transport Observability

> Unit: C10-MCG02-TRANSPORT-OBSERVABILITY_20260721
> Authority: Main Chat
> Status: READY FOR MATERIALIZATION

## 1. Verified baseline

One controlled exact-identity retry of the preserved unknown submission was invoked. The local
attempt ledger recorded `sync-interrupted / transport-or-closure`; local events 1–2 remained
`unknown`; next local Device sequence remained 3; Render exposed no corresponding application log;
and Neon remained `accounts 1 / devices 1 / cursor 0 / submissions 0 / events 0 /
acknowledgements 0`.

This proves neither a Render outage nor a client-only fault. It localizes the missing evidence to
the client-to-hosted transport boundary. No second submission retry is authorized by this unit.

Repository inspection also establishes:

- Fastify currently uses `logger: false`;
- the API already owns unauthenticated `GET /health/live` and `GET /health/ready` routes;
- the Flutter Sync transport defaults to a five-second timeout;
- the Closure runner collapses the interruption to `transport-or-closure`.

The human has selected a paid Render service instance for Markei's early MVP phases. Record this as
an operational environment decision that removes free-instance sleeping as a future test variable.
Do not claim that payment fixes the observed fault, and do not purchase, configure or deploy Render
from Codex.

## 2. Operational objective

Make every future hosted connectivity or Sync attempt answer, without private data:

1. whether local preflight completed;
2. whether access-token acquisition completed;
3. whether an HTTP request was constructed and transport began;
4. whether any HTTP response was received;
5. whether the response was parsed into a protocol outcome;
6. which bounded failure class terminated the attempt;
7. whether Render received and completed the correlated request.

Before another unknown-submission retry, Closure must provide a deliberate non-mutating
`Check hosted connection` action that probes the existing live and ready endpoints and records a
sanitized result. It must never upload, download, enroll, authenticate through a browser, mutate the
outbox, or write hosted data.

## 3. Client attempt evidence

Extend the durable Closure attempt evidence with a bounded stage/result model. Use stable codes,
not raw exceptions. At minimum distinguish:

- `preflight-passed`;
- `token-acquired` or `token-acquisition-failed`;
- `request-created`;
- `transport-started`;
- `response-received` with bounded HTTP status when available;
- `response-parsed`;
- `dns-failed`;
- `tls-failed`;
- `connection-failed`;
- `timeout-before-response`;
- `timeout-during-response` when the transport can prove it;
- `request-cancelled`;
- `authorization-rejected` for 401/403;
- `hosted-rejected` for other bounded non-success statuses;
- `protocol-failed`;
- `closure-failed` for non-transport client defects;
- `outcome-unknown` only when no more stable classification is justified.

Persist only what is needed for diagnostic continuity: operation kind, latest completed stage,
bounded result code, start/finish timestamps, shortened correlation fingerprint, optional HTTP
status, whether response headers were received, and stable guidance. Preserve historical rows and
provide an additive Drift migration if the schema must change.

Never store or display tokens, authorization headers, payloads, response bodies, full URLs,
provider hosts, callback URLs, SQL, stack traces, raw exception text, complete identifiers or full
correlation values.

## 4. Hosted connection check

Add a Closure action that:

- confirms the configured HTTPS origin is structurally valid without displaying it;
- calls existing `/health/live` first;
- calls `/health/ready` only after live returns successfully;
- uses no bearer token because these existing health routes are deliberately outside protected
  route inventory;
- uses a cold-start-tolerant, explicitly bounded deadline separate from the five-second Sync
  default;
- displays live reachability, database readiness, elapsed-time band, bounded failure stage/result,
  and a shortened correlation fingerprint;
- records exactly one durable diagnostic attempt for one confirmed check;
- disables duplicate invocation while busy;
- changes no authentication, enrollment, queue, submission or provider state.

The UI must make clear that `live` proves process reachability, `ready` proves the API's existing
database-readiness contract, and neither proves that Sync will succeed.

## 5. Hosted request logs

Add structured sanitized application logging at the API boundary. The hosted process must emit
bounded events for:

- request received;
- authentication accepted/rejected for protected routes;
- operation validation started;
- database transaction started when applicable;
- response completed;
- request failed.

Each record may contain timestamp, stable operation/route class, method, bounded status/result,
elapsed-time band and a correlation fingerprint suitable for matching the client display. Do not
log raw headers, bearer tokens, bodies, query parameters, provider configuration, complete paths
containing identifiers, full correlation IDs, Account/Device/Event/Submission IDs, hashes, SQL or
stack traces.

Health logging must be visible enough to prove the harmless connectivity check reached the same
deployed process. Tests must also prove that arbitrary or malformed correlation input cannot inject
log lines or bypass redaction.

## 6. Timeout and failure handling

Inspect enrollment and Sync URL construction side by side and report whether they share the same
validated origin/path policy. Do not silently change the hosted protocol.

Replace broad exception collapse only where a stable bounded classification is possible. Preserve
unknown-outcome semantics: a timeout after transport started must never be represented as a known
non-application, and it must not reclassify the preserved unknown events.

Timeout policy must be explicit and tested. The harmless health check may tolerate a cold start;
submission transport must retain a finite deadline and exact-idempotency behavior. Codex may adjust
the five-second submission deadline only if repository tests and documented reasoning show that the
new value remains bounded and does not blur timeout versus response handling.

## 7. Validation

Run and report:

- client unit tests for every reachable failure classification;
- live-only success, live-not-ready, live failure, ready failure, timeout, cancellation,
  malformed response, repeated press and missing/invalid origin tests;
- proof that the connection check sends no authorization header and mutates no local Sync state;
- attempt-ledger migration/reopen/backfill tests if schema changes;
- exact one-attempt finalization and shortened-correlation tests;
- API structured-log success, 401/403, validation failure, database failure, completion and
  redaction/injection tests;
- regression tests for route inventory and both health routes;
- comparison tests for enrollment and Sync origin/path construction;
- existing exact-identity unknown-retry tests without executing a real retry;
- Dart formatting, Flutter analysis and complete Flutter tests;
- API format, lint, typecheck, tests and build;
- Android debug and Windows release builds;
- `git diff --check`, exact changed-path review and tracked/staged secret scan.

Use local injection/fake transports and disposable local PostgreSQL/Docker only where existing
repository validation requires them. Do not contact Auth0, Render or Neon.

## 8. Stop conditions and prohibitions

Stop and report if safe correlation requires revealing a full identifier, health routes differ
from the inspected contract, a migration would overwrite historical evidence, or classification
would require guessing whether the server applied a request.

Do not:

- execute Sync or retry the human unknown submission;
- edit the human local database;
- mutate providers, purchase/configure Render, deploy or run Neon SQL;
- relabel, replace, resequence or delete events 1–2;
- weaken JWT, RLS, enrollment, route-inventory or callback validation;
- enable raw Fastify request/body/header logging;
- add telemetry, analytics or diagnostic export;
- begin MCG-03/04 or Cycle 11;
- update permanent domain memory.
