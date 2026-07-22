# H_DDC_CODEX

Authority marker: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722

Didactic result: the failure vocabulary now separates an observed bounded server failure from client timeout and from genuinely unknown application outcome.

Final bounded vocabulary:
- `service-unavailable`: server reached and returned a bounded protocol failure. For the reproduced missing cursor-state case it is `not-applied`, retryable false, and instructs preservation of evidence.
- `unknownOutcome`: transport did not provide a trustworthy protocol response, such as timeout/no response before classification.
- `conflict`, `sequence-gap`, `wrong-account`, `hash-mismatch`: remain distinct recognized non-application or non-accepted protocol failures.
- `sync-interrupted` / `transport-or-closure`: historical Closure attempt remains unchanged and was not reinterpreted.

Named semantic tests:
- `protected submission fails closed when account cursor state is missing`
- `unexpected protected submission failures do not log successful request-failed status`
- `HTTP sync transport preserves observed service failure response`
- existing exact-identity unknown retry regressions in the full Flutter suite
- disposable HTTP/PostgreSQL convergence and recovery harness tests

User-visible semantics:
- An observed `service-unavailable` response is not presented as a generic conflict.
- A timeout/no-response path remains unknown and retry-preserving.
- No complete identifiers, payloads, hashes, headers, tokens, provider origins, SQL, stack traces or raw exceptions are surfaced.

Privacy evidence:
- Tests use synthetic Account/Device/Event/Submission values only.
- Lifecycle assertions inspect bounded event names, status classes and short correlation behavior only.
- Raw fixture exception text is asserted absent from lifecycle events.
- No provider credentials, private files, human database rows or real provider requests were accessed.

Provider boundary:
- This unit corrects the locally reproduced failure mode and observability anomaly.
- Human provider completion remains a separate retest; no provider success or MCG-02 closure is claimed.
