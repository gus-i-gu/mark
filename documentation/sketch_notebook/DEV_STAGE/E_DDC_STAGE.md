# E_DDC_STAGE — MCG-02 Native Authentication Semantics

> Authority marker: C10-MCG02-NATIVE-CLOSURE_20260718T140335Z
> Status: **ACTIVE SEMANTIC AUTHORITY**

## Claim boundary

~~~text
provider-foundation-ready
+ native-auth-composition-ready
!= native provider acceptance
!= hosted convergence
!= MCG-02 complete
~~~

Codex may claim composition readiness only from implemented adapters, closed tests and supported
platform builds. Android/Windows authentication is accepted only after a human executes real Auth0
login through each client. Full MCG-02 requires that authentication to continue through membership,
Device enrollment and hosted synchronization.

## Vocabulary

- **Native sign-in** — system-browser Authorization Code + PKCE flow initiated by Markei.
- **Access token** — ephemeral bearer credential for the exact Markei API audience.
- **ID token** — client identity information; never an API bearer-token substitute.
- **External identity** — issuer plus subject resolved by PostgreSQL; not AccountId or DeviceId.
- **Composition readiness** — real SDK/adapters/configuration are wired and locally validated.
- **Provider acceptance** — real Android/Windows, Auth0, Render and Neon executed evidence.
- **Local continuity** — registration/outbox remain available without hosted authentication.

## Required states

~~~text
configuration-missing
configuration-invalid
signed-out
signing-in
sign-in-cancelled
authenticated
token-expired
authentication-rejected
provider-unavailable
identity-unknown
membership-inactive
device-unknown
device-revoked
device-enrolled
hosted-sync-available
hosted-sync-unavailable
signed-out-cleared
~~~

No state before real provider acceptance may say connected, synchronized, restored, converged,
secure or complete. Cancellation is neutral, not an authentication error. Provider unavailability
does not imply local-data failure.

## Privacy and diagnostic language

Diagnostics may show state names, HTTP status classes and opaque correlation aliases. They must not
show tokens, raw claims, issuer/tenant domains, client IDs, subjects, email addresses, Account or
Device UUIDs, connection strings or fact payloads. Tokens must not be durable or recoverable after a
cold restart.

## Denial semantics

Missing/expired token, wrong issuer/audience, unknown identity, inactive membership, unknown or
revoked Device and cross-Account mismatch all fail closed without protected-state advance. Unknown
enrollment outcomes remain queryable/replayable; same identity/hash replays, different hash
conflicts.

## Human closure language

After Codex readiness, human evidence must distinguish:

1. Android native login and logout;
2. Windows native login and logout;
3. two distinct Device enrollments under one synthetic Account;
4. hosted synchronization convergence;
5. denial matrix and protected-state-no-advance;
6. offline/local registration continuity.

Only Main may reconcile that evidence into `MCG-02_PROVIDER_PROOF_COMPLETE`. Production readiness,
Cycle 10 closure and MCG-03/04 remain separate decisions. Learner maturity and Cycle 11 UX history
must not change in this unit.
