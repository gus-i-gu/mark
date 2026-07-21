# E_DDC_STAGE — Transport Evidence Semantics

> Unit: C10-MCG02-TRANSPORT-OBSERVABILITY_20260721
> Authority: Main Chat
> Status: READY FOR MATERIALIZATION

## 1. Learning objective

The unit must turn the opaque phrase `transport-or-closure` into a truthful bounded explanation of
where execution stopped. The learner-facing distinction is:

```text
command accepted locally
!= request began
!= server received request
!= server authenticated request
!= database transaction began
!= hosted outcome committed
```

The UI and reports must not infer a later stage from an earlier one.

## 2. Required semantic distinctions

Teach through stable UI guidance and tests:

- **Process liveness:** the deployed API process answered `/health/live`.
- **Service readiness:** `/health/ready` confirmed the API's existing database-readiness function.
- **Transport reachability:** an HTTP response was observed.
- **Authorization:** a protected request was accepted or rejected by hosted authentication.
- **Protocol validity:** the response matched the expected Markei contract.
- **Application outcome:** the server returned a stable Sync result.
- **Unknown outcome:** transport began but available evidence cannot prove application or
  non-application.

`live`, `ready`, and a paid always-on instance reduce uncertainty but do not prove Sync correctness.

## 3. User-facing diagnostics

Closure must show a compact latest-attempt explanation containing:

- operation (`hosted-connection-check`, ordinary Sync, or unresolved-submission retry);
- latest completed stage;
- bounded result;
- shortened correlation fingerprint;
- HTTP status only when actually received;
- whether response headers were received;
- elapsed-time band, not false precision where unavailable;
- one stable next-action sentence.

Good guidance examples are semantic, not literal copy requirements:

- live timed out before any response: the hosted service was not reached within the bounded
  deadline; no Sync was attempted;
- ready returned not-ready: the API process answered but its database-readiness check did not pass;
- 401/403: the hosted service answered but rejected authorization;
- response parse failed: the service answered, but the client could not validate the Markei
  response contract;
- closure failed: a local non-transport step failed before a stable hosted outcome.

Do not expose raw exception messages or imply that the user should repeatedly retry.

## 4. Attempt history semantics

Preserve historical attempts. A stage is monotonic evidence within one invocation: later evidence
may supersede the displayed current stage but must not rewrite what operation occurred. One button
invocation produces one attempt record, finalized once.

The harmless connectivity check is observational. Its success must not be called synchronization,
enrollment, hosted convergence or MCG-02 completion.

The previous real attempt remains truthfully recorded as
`sync-interrupted / transport-or-closure`; do not retroactively invent a finer classification for
historical evidence that did not capture it.

## 5. Privacy and accessibility

Use short stable codes with plain-language explanations. Diagnostic text must be selectable or
otherwise readable, keyboard reachable, and usable at supported short/tall Windows heights.
Busy, success, failure and disabled states must not depend on color alone.

No complete identifiers, origins, tokens, headers, bodies, hashes, SQL, stack traces or provider
secrets may appear in UI, logs, fixtures or G/H/I.

## 6. Didactic evidence required in H

Report:

- the final stage/result vocabulary;
- how each term maps to observable evidence;
- how liveness, readiness, reachability, authorization, protocol and application outcome differ;
- why paid hosting removes sleeping but is not itself fault evidence;
- how historical opaque attempts are preserved;
- exact UI/test examples using synthetic values only;
- residual ambiguity after implementation.
