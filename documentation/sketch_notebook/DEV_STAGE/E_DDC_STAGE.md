# E_DDC_STAGE — Server Failure and Client Evidence Semantics

> Unit: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722
> Sequence: FLX-ORD-01
> Authority: Main Chat
> Status: READY FOR MATERIALIZATION

## 1. Learning objective

Replace the remaining ambiguous `provider-evidence-unavailable` explanation with a truthful model of
two related but distinct observations:

```text
server produced a final response
!= client observed that response within its deadline
```

For the controlled retry, Render observed a protected request and returned `500`; Closure observed no
headers before its boundary. The server outcome is therefore known from correlated external evidence,
while the historical client row must remain an honest record of what that client invocation observed.

## 2. Required distinctions

Code, UI guidance, tests and H must distinguish:

- **transport reached server:** correlated request ingress exists;
- **authentication accepted:** hosted authentication completed successfully;
- **operation validation started/completed:** request shape and operation checks are distinct from
  authentication and persistence;
- **transaction started:** database work actually began;
- **transaction committed or rolled back:** durable effect is evidenced;
- **server failure:** the service returned a non-success response;
- **client timeout:** the client did not observe the response before its deadline;
- **unknown application outcome:** neither available client nor correlated server/database evidence
  determines whether application occurred.

A server `500` with unchanged database is not a successful Sync and is not merely a connectivity
failure. A historical client timeout must not be rewritten retroactively, even when later Render and
Neon evidence permits Main to classify the wider incident more precisely.

## 3. Stable bounded vocabulary

Prefer existing vocabulary where it remains accurate. Add the smallest stable codes needed to name:

- unexpected server failure;
- validation rejection;
- authorization rejection;
- transaction failure/rollback when actually known;
- client response deadline exceeded;
- sanitized internal failure class for operators.

Do not expose raw exceptions, stack traces, SQL, bodies, tokens, origins or identifiers. Do not teach
that HTTP `500` reveals its own cause; the cause requires local reproduction or bounded server-stage
evidence.

## 4. User-facing behavior

Closure should explain only evidence available to that invocation. It may say that no response was
observed before the deadline, but it must not claim that Render was not reached or that nothing was
applied. A newly observed `500` must be shown as a hosted/server rejection or failure with bounded
guidance, not collapsed into provider absence.

The guidance must discourage repeated attempts and preserve the exact-identity recovery rule. Busy,
failure and disabled states must remain keyboard reachable, readable without color, and usable at the
supported Windows sizes.

## 5. Didactic evidence required in H

Report:

- the locally reproduced cause, or explicitly that it remains unresolved;
- the final stage/result vocabulary and observable evidence for each term;
- how server failure differs from client timeout and unknown application outcome;
- why unchanged Neon counts prove no durable write for this attempt but not the internal cause;
- how the historical attempt is preserved;
- synthetic test examples only;
- residual ambiguity and the next safe human check.
