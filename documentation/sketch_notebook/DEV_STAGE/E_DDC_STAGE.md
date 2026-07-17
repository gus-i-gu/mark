# E_DDC_STAGE — MCG-02 Provider-Proof Semantic Authority

> Authority marker: C10-MCG02-PROVIDER-PROOF_20260717T171443Z
> Status: **ACTIVE MANUAL EVIDENCE CONTRACT**

## Claims

~~~text
R05 local proof complete
!= hosted provider proof
!= production readiness
!= Cycle 10 closure
~~~

Provider foundation may be claimed after Auth0 contract, Render HTTPS and disposable Neon
configuration pass. Full provider proof may be claimed only after real Auth0-issued native tokens,
Render HTTPS, the disposable Neon
development database, explicit Account membership and enrolled Devices participate in the same
executed path.

## Vocabulary

- **External identity** — Auth0 issuer plus subject; not an Account or Device identifier.
- **Membership** — explicit authorization connecting an external identity to one Account.
- **Device enrollment** — idempotent authorization of one installation under one membership.
- **Provider acceptance** — executed evidence from Auth0, Neon and Render together.
- **Local readiness** — R05's deterministic local proof; retained independently.
- **Production readiness** — not established by this development proof.

## Truthful states

~~~text
provider-preflight
auth0-contract-valid
neon-migrations-valid
render-runtime-live
provider-foundation-ready
native-auth-integration-pending
identity-mapped
device-enrolled
hosted-sync-converged
provider-proof-complete
provider-proof-partial
~~~

No foundation state may be described as authenticated end-to-end, synchronized, converged or
complete. A deployed healthy endpoint proves process readiness only.

## Required semantic denials

Evidence must distinguish:

- missing versus malformed bearer token;
- expired token;
- wrong issuer;
- wrong audience;
- unknown external identity;
- inactive membership;
- unknown Device;
- revoked Device;
- cross-Account mismatch;
- idempotent replay versus conflicting enrollment request.

Every denial must be paired with protected-state-no-advance evidence. Do not infer global denial
truth from HTTP status alone.

## Privacy and evidence language

Use synthetic users and opaque aliases. Reports may state claim names, status classes, counts,
algorithms, migration identifiers and pass/fail outcomes. Reports must omit tokens, credentials,
connection strings, provider domains/IDs, user email addresses, Auth0 subjects and fact payloads.

Allowed final wording:

> The disposable development environment completed the MCG-02 hosted provider proof with Auth0,
> Render HTTPS and Neon while preserving explicit Account and Device authorization boundaries.

Disallowed wording includes production-ready, backup-complete, permanently secure, universally
authenticated, provider-independent or Cycle 10 closed.

## Failure behavior

Unknown outcomes remain unknown until queried or safely replayed. Provider unavailability must not
erase local facts or outbox work. A failed provider checkpoint stops forward promotion but does not
invalidate R05 local proof.

## Completion boundary

This unit ends at `MCG-02_PROVIDER_FOUNDATION_READY`. It does not satisfy MCG-02 completion. Main
must next authorize native client authentication and then the decisive Account/Device/sync proof.
MCG-03/04 remain undefined and inactive. Learner maturity, lecture history and Cycle 11 UX claims
remain unchanged.
