# D_OPS_STAGE — Windows Native Authentication Callback Correction

> Authority marker: C10-MCG02-WINDOWS-AUTH-CALLBACK_20260719T011836Z
> Required ancestor: 65ae6a7dac349db0512d604c940d01a6f500d1a4
> Status: **ACTIVE BOUNDED CODEX AUTHORITY**

## Objective

Correct and prove the Windows boundary from a successful Auth0 user login through callback
consumption, authorization-code exchange and usable in-memory credentials. Preserve the accepted
provider, server, database and hosted-identity designs; stop before Device enrollment or sync.

## Controlling human evidence

- Windows release build: passed.
- Native closure surface: launched under explicit non-secret compile-time configuration.
- Auth0 Native application, PKCE, callback/logout allowlists and user-delegated API access: passed.
- Current-user `auth0flutter` protocol dispatch: exercised.
- Auth0 signup, email verification and login: successful in sanitized tenant logs.
- Markei post-login state: `authentication-rejected`.
- Enrollment and hosted synchronization: not run.

## Required implementation

1. Compare `windows/runner/main.cpp` with the callback contract of repository-pinned
   `auth0_flutter` 2.4.0. Prove the waiting SDK transaction consumes the callback; foregrounding the
   window alone is insufficient.
2. Preserve exact callback-prefix validation, current-user pipe isolation, bounded framing and
   single-instance forwarding. Reject malformed, oversized, wrong-scheme, duplicate, stale and
   no-active-transaction callbacks.
3. Replace generic rejection collapse with a closed, bounded diagnostic map covering callback not
   received/state rejected, code exchange rejected, missing access/ID token, expired credentials,
   token confusion, provider outage and unknown rejection.
4. Never expose tokens, authorization codes, PKCE verifier/challenge, OAuth state/nonce, email,
   subject, Account/Device IDs or complete callback URLs in UI, logs, exceptions or reports.
5. Accept `authenticated` only for non-empty, distinct, unexpired access and ID tokens returned by
   the SDK. Client checks remain defensive; server JWT verification remains authoritative.
6. Preserve cancellation, consent rejection, logout and cold-start token absence as distinct states.

## Tests

Add focused deterministic tests for safe error mapping, credential acceptance/rejection, callback
prefix and bounds, duplicate/stale/cross-transaction rejection, single-instance forwarding where
host-testable, and closure UI wording. Prove enrollment and Sync are not invoked by this unit.

Run Dart formatting, Flutter analysis, focused and full Flutter tests, Windows release build when
host-supported, Android debug only if shared native-auth code changes, `git diff --check`, changed-
path inventory and tracked/staged secret scans. A compile pass is not runtime callback acceptance.

## Boundaries

No provider operation, dependency upgrade, migration, PostgreSQL/Drift schema change, server
authorization change, hosted identity binding implementation, enrollment, synchronization,
installer, product UI redesign, permanent documentation, methodology, MCG-03 or MCG-04 work is
authorized. If the pinned SDK cannot satisfy its documented contract, stop and report versioned
evidence before changing dependencies.

Replace only G/H/I reports after implementation. Commit and push one bounded unit.

Success terminal:

~~~text
MCG-02_WINDOWS_AUTH_CALLBACK_CORRECTED
MCG-02_PROVIDER_RETEST_REQUIRED
~~~

Otherwise report `MCG-02_WINDOWS_AUTH_CALLBACK_PARTIAL` with the exact blocker.
