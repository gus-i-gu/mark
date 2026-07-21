# H_DDC_CODEX - Hosted Device Header Semantics

> Unit: C10-MCG02-HOSTED-DEVICE-HEADER-CORRECTION_20260721T124452Z
> Result: HOSTED_FIXTURE_REJECTS_MISSING_OR_WRONG_DEVICE=true

## Materialized Semantics

- Hosted Sync transport is scoped to one active hosted server Device ID.
- Every protected Sync request carries `x-markei-device-id`.
- A missing active hosted binding is a closed hosted-composition failure, not a transport created with guessed or empty identity.
- Server protocol code `device-enrollment-required` remains distinct from generic conflict in Flutter.
- Native hosted fixture now enforces the same protected-route Device header requirement that Render enforces.

## Named Semantic Tests

- `HttpSyncTransport sends the hosted Device header on every protected route`
- `hosted sync fixture rejects missing or wrong Device header`
- existing local Sync application tests for ordered upload, typed failures, rollback, and recovery
- existing real convergence harness tests for canonical order and production coordinator behavior
- existing real recovery harness tests for rebootstrap and recovery closure behavior
- full Flutter test suite
- server format, lint, typecheck, tests, and build

## Failure-Code Behavior

- `device-enrollment-required` maps to `SyncStatusCode.deviceEnrollmentRequired`.
- `HostedSyncCoordinator` maps that status to the existing Device-enrollment-required hosted outcome.
- Existing recognized server codes remain preserved:
  - `sequence-gap`;
  - `wrong-account`;
  - `hash-mismatch`.
- Unknown server codes remain bounded and do not expose IDs, hashes, payloads, SQL, tokens, provider configuration, or database internals.

## User-Visible Bounds

The UI still invokes the existing Sync action. No submission-ID control, repair page, Device reenrollment flow, provider retest control, or diagnostic disclosure was added.

The user-visible effect is bounded: hosted Sync without the required server Device identity fails closed through existing hosted unavailable/enrollment outcomes, while valid hosted composition sends the Device header on all protected routes.

## Privacy Evidence

Tests use fixture UUIDs, semantic protocol codes, request-header assertions, counts, and route names. No production provider data, private credential, hosted token, human database row, payload content, content hash, or SQL detail was read or exposed.

Provider/human completion is not claimed by this unit. The Windows provider retest remains a later human-controlled step.
