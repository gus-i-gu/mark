# D_OPS_STAGE — Protected Submission 500 Diagnosis and Correction

> Unit: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722
> Sequence: FLX-ORD-01
> Authority: Main Chat
> Status: READY FOR MATERIALIZATION

## 1. Accepted runtime evidence

The transport-observability unit has passed its human-controlled provider check:

- one Closure hosted-connection check produced correlated `/health/live` and `/health/ready`
  requests with fingerprint `500a78db`, both status `200`;
- the pre-retry Neon baseline was `accounts 1 / devices 1 / cursor 0 / submissions 0 / events 0 /
  acknowledgements 0`;
- exactly one authorized exact-identity unresolved-submission retry reached
  `POST /v1/sync/submissions` with sanitized fingerprint `46e9a131`;
- Render recorded `request-received`, `operation-validation-started`, `request-failed`, then final
  `response-completed` status `500`, under one second;
- Render did not record authentication rejection or database-transaction-started evidence;
- the post-attempt Neon counts were unchanged;
- Closure reached its 1000 ms observation boundary without response headers and recorded
  `provider-evidence-unavailable`; events 1–2 remain unknown and next Device sequence remains 3.

The final `500` and unchanged database are accepted observational evidence. They localize a
reproducible failure before successful commit. They do not yet identify the internal cause. The
`request-failed status 200` followed by `response-completed status 500` is an observability defect or
ambiguous intermediate-status encoding and must be corrected.

No further real Sync, retry, enrollment, provider mutation or Neon write is authorized.

## 2. Operational objective

Reproduce the protected submission failure locally using synthetic identities and disposable local
PostgreSQL, identify the exact project-owned failure boundary, and apply the smallest safe correction.
The corrected path must either return the existing stable protocol outcome or a bounded non-secret
error classification; it must never manufacture success.

Codex must inspect, in execution order:

1. hosted composition and request lifecycle hooks;
2. JWT and hosted identity authorization;
3. request/body/header validation;
4. Account/Device context establishment;
5. transaction start and runtime-role/RLS setup;
6. upload service and persistence calls;
7. error mapping and structured lifecycle logging;
8. Flutter submission deadline, response observation and Closure finalization.

## 3. Required local reproduction

Build a focused automated regression that uses the same route class and structurally equivalent
synthetic request shape as the preserved submission, without reading or embedding human payloads,
identifiers, tokens, origins or provider configuration.

The reproduction must distinguish at least:

- authentication accepted versus rejected;
- operation validation accepted versus rejected;
- transaction attempted versus not attempted;
- database commit versus rollback/no write;
- stable application failure versus unexpected server defect;
- response completed before versus after the client observation deadline.

Use existing test fixtures, hosted authorization doubles and disposable PostgreSQL harnesses where
sufficient. If the cause appears dependent on hosted schema/ACL state, prove the expected contract
against fresh migrations locally; do not query or mutate Neon.

## 4. Correction authority

Codex may correct the cause only when a failing local regression identifies a project-owned defect.
Permitted bounded correction surfaces include:

- hosted route orchestration, authorization-to-transaction handoff and error mapping;
- PostgreSQL query/context code and a new forward-only migration only if a schema defect is proved;
- sanitized lifecycle event classification;
- Flutter response/deadline handling when tests prove that the server response can complete at the
  current boundary without being observed.

Do not edit migrations 001–006. Any database change must be additive, least-privilege, upgrade-safe
and validated from fresh plus existing migration state. Do not broaden runtime grants or RLS.

Do not merely extend the client deadline to hide the server fault. A deadline adjustment is allowed
only after the server cause is understood, remains finite, preserves cancellation and unknown-outcome
semantics, and has focused boundary tests. The UI must not report `provider-evidence-unavailable`
when a bounded HTTP response was actually observed within the supported deadline.

If no local reproduction identifies the cause, make no speculative source fix. Improve only the
sanitized internal failure classifier if that can be done without secrets, write truthful G/H/I, and
stop with `C10_MCG02_SUBMISSION_500_CAUSE_UNRESOLVED`.

## 5. Logging requirements

Correct lifecycle semantics so that:

- `request-failed` never carries an unrelated successful status;
- the final response status is authoritative;
- authentication acceptance/rejection, validation, transaction start, rollback/commit and bounded
  failure class are logged only when actually observed;
- one invocation retains one correlation fingerprint across its lifecycle;
- unexpected defects expose a stable internal class, never raw exception text or stack traces.

Tests must prove redaction of tokens, headers, bodies, complete identifiers, request hashes, provider
configuration, SQL and control-character/log-injection input.

## 6. Validation floor

Run and report:

- the new failing-then-passing protected-submission regression;
- API success, validation rejection, authorization rejection, database rollback and unexpected-error
  lifecycle tests;
- fresh and upgrade disposable PostgreSQL migration/ACL/RLS probes if database code changes;
- Flutter tests for response-before-deadline, response-at/after-boundary, timeout, cancellation,
  server `500`, headers absent/present and exact one-attempt finalization;
- exact-identity retry regressions proving events 1–2 semantics are not rewritten;
- API format, lint, typecheck, full tests and build;
- Dart format, Flutter analysis and full tests;
- Windows release and Android debug builds when the host supports them;
- protected Python regressions, `git diff --check`, changed-path review and secret-safe scan.

No validation may contact Auth0, Render or Neon. Classify unavailable platform/toolchain checks as
host-unvalidated, not passed or failed.

## 7. Prohibitions and stop conditions

Do not:

- execute a real Sync or unresolved-submission retry;
- alter the human local database or events 1–2;
- enroll, revoke, deploy, change provider configuration or run Neon SQL;
- expose private evidence in tests, logs or reports;
- weaken JWT/JWKS, callback, route inventory, RLS or runtime-role boundaries;
- begin MCG-03/04, Cycle 11 or permanent-memory promotion.

Stop on an unreproduced provider-only hypothesis, required secret access, migration mutation,
privilege broadening, indeterminate commit semantics, or unrelated dirty overlap.

Success terminal:

`C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED`
