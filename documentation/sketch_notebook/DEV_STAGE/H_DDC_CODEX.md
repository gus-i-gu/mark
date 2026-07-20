# H_DDC_CODEX - Hosted Binding State Evidence

- Authority marker: C10-MCG02-HOSTED-BINDING-R2_20260720T131954Z
- Baseline after fast-forward: 9e7af2e306a5159eb51eba9169f5fe0c5f60b5e7
- Final commit SHA: resolved after commit; Codex terminal response reports it.
- Evidence boundary: local file-backed Drift, loopback HTTP, disposable Docker/PostgreSQL lab API, Flutter/Dart tests, Android/Windows local builds. No provider operation.

## Materialized States

- `local-only-identity`: retained. Fresh production composition without a valid hosted binding still selects `local-account` and a local Device.
- `hosted-binding-recorded`: retained and tightened. Enrollment persists hosted AccountId, server DeviceId, installationId, requestId, state and generation.
- `hosted-restart-required`: materialized. First successful enrollment returns this state, and the same process cannot authorize hosted sync from the pre-enrollment local composition.
- `hosted-binding-active`: materialized on restart only after validation of environment, active completed state, AccountId, server DeviceId, installation identity and positive generation.
- `local-only-pending`: materialized in tests. Older pending events remain unchanged and outside scoped hosted leasing.
- `hosted-sync-ready`: locally evidenced by scoped file-backed/loopback and Docker lab proofs only.
- `binding-invalid`, `binding-revoked`, `binding-expired`: materialized as fail-closed guard outcomes; invalid/revoked/expired bindings do not authorize hosted sync.
- `cross-account-rejected`: materialized. A foreign Account page returns conflict with no purchase, inbox or cursor mutation.

## Wording Guard

No source, test or report claims:

- provider synchronization passed;
- provider convergence passed;
- clean Auth0 retest passed;
- MCG-02 closed;
- MCG-03 or MCG-04 started.

The implementation uses local proof wording: `hosted-restart-required`, `hosted-binding-active`,
`sync-completed`, `sync-interrupted`, `device-revoked`, `binding-invalid`, and `cross-account`
conflict behavior. The accepted packaging proof remains separate, and the fresh human Auth0 retest
remains pending/unpromoted.

## Didactic Evidence Boundary

This unit reinforces the distinction between:

- enrollment recording and synchronization;
- stored binding and active composition;
- local-only facts and hosted facts;
- local loopback/server proof and provider proof;
- duplicate-equivalent enrollment and restart-required enrollment.

The R05 proof fixture was updated so the first enrollment case accepts `hosted-restart-required`
instead of the previous generic `applied` status. Existing duplicate-equivalent replay remains a
distinct state.

## Exclusions

No provider credentials, tokens, callback URLs, identity subjects, Neon strings, Render secrets or
private provider files were read or persisted. No provider-validated wording was introduced.
