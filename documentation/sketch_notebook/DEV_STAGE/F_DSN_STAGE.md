# F_DSN_STAGE — Windows Callback and Credential Design

> Authority marker: C10-MCG02-WINDOWS-AUTH-CALLBACK_20260719T011836Z
> Status: **ACTIVE DESIGN AUTHORITY**

## Selected boundary

~~~text
Auth0 browser transaction
-> auth0flutter protocol activation
-> secondary runner process
-> current-user named pipe
-> primary runner process
-> pinned Auth0 SDK waiting transaction
-> code exchange
-> defensive credential checks
-> ExternalAuthenticationSession
~~~

The native runner owns OS activation and bounded forwarding. The pinned SDK owns OAuth transaction
state and code exchange. `NativeAuth0Authentication` adapts SDK outcomes into closed application
states. `NativeAuthClosureRunner` and the development page expose only neutral semantic evidence.

## Invariants

- One callback belongs to one active transaction and is consumed at most once.
- Wrong prefix/scheme, stale, duplicate, oversized or unsolicited callback input fails closed.
- Pipe access remains restricted to the current user; callback data is never logged.
- Tokens remain process-memory bounded and disappear on rejection, expiry, logout and restart.
- Access and ID tokens are non-empty and distinct before `authenticated`.
- Client inspection does not replace hosted issuer/audience/signature/authorization verification.
- Provider login success remains distinct from client authentication success.

## Deferred design

The hosted Account/Device binding and scoped synchronization model previously staged remains the
next unit after successful provider retest. Production installer protocol registration, an
intermediary HTTPS callback, dependency upgrades, secure persistent sessions and general Account
migration remain outside this correction.

Rollback restores the accepted native adapter while retaining provider configuration and all local
facts; it must not weaken callback validation or expose raw errors.
