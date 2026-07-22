# H_DDC_CODEX

Authority marker: C10-MCG02-TRANSPORT-OBSERVABILITY_20260721

Didactic result: Closure now teaches the operator a bounded distinction between hosted reachability and Sync success.

Materialized states and codes:
- operationKind: sync, hosted-connection-check.
- stages: preflight-passed, request-created, transport-started, response-received, response-parsed, request-not-started, closure-failed.
- results: hosted-connection-ready, hosted-live-not-ready, invalid-origin, timeout-before-response, timeout-during-response when provable, dns-failed, tls-failed, connection-failed, request-cancelled when surfaced by the client, authorization-rejected, hosted-rejected, protocol-failed, closure-failed, outcome-unknown only as the residual category.
- elapsed bands: lt-250ms, lt-1s, lt-3s, lt-10s, lt-30s, gte-30s.

User-visible guidance:
- Live means the API process answered.
- Ready means the API database readiness contract passed.
- Neither result proves Sync success.
- Retry guidance remains stable and bounded; raw exceptions and infrastructure details are absent.

Named semantic tests:
- hosted connection check calls live then ready without bearer auth.
- ready not-ready is bounded and does not prove Sync success.
- live failure does not call ready.
- invalid origin fails before transport.
- timeout before response is classified without raw exception details.
- malformed JSON response is protocol-failed after headers.
- correlation fingerprint is short and sanitized against injection.
- Check hosted connection records one non-Sync attempt.
- records one terminal hosted connection diagnostic attempt.
- migrates v9 attempts to v10 observability columns without reset.
- health lifecycle logs are sanitized and correlated by fingerprint.
- lifecycle observer failure does not alter health response.
- protected route authentication rejection is lifecycle logged.

Privacy evidence:
- Closure displays short fingerprints only.
- Ledger stores no tokens, authorization headers, request/response bodies, provider hostnames, callback URLs, SQL, hashes, stack traces, raw exceptions, payload JSON, or complete identifiers.
- API lifecycle logs include only timestamp, bounded event/operation/route class, method, status/result, elapsed band, and short correlation fingerprint.
- Fastify unrestricted request logging remains disabled.

Provider/human boundary:
- The previous sync-interrupted / transport-or-closure attempt remains historical evidence only.
- No retrospective result was synthesized.
- No real provider Sync or unknown recovery was executed.
- Human provider retest remains pending.
