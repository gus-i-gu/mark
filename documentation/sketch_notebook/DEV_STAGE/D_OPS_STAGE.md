# D_OPS_STAGE — MCG-02 Decisive Provider Acceptance

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-DECISIVE-PROVIDER_20260718T152829Z
> Required ancestor: df904fb
> Status: **ACTIVE HUMAN EVIDENCE CONTRACT; NO CODEX SOURCE MUTATION**

## Objective

Execute the flagged Markei closure surface on Android and Windows through the configured disposable
Auth0, Render and Neon environment. Prove two native Devices authenticate, enroll and converge one
synthetic Account without copying tokens or losing local work.

## Safety boundary

- Use only the development Auth0 tenant, Render service and Neon child branch/database.
- Keep every provider value, token, subject, UUID, hostname, URL and credential outside Git/chat.
- Do not use the production Neon branch or ordinary personal purchase data.
- Do not change source, migrations, provider architecture or production traffic.
- Codex may diagnose sanitized output only; it must not receive private values or operate consoles.

## Gate 1 — Platform readiness

- Pull `df904fb` with fast-forward-only behavior and confirm a clean tracked tree.
- Enable Windows Developer Mode/symlink support, then build the Windows release binary.
- Build/install Android debug on an emulator or controlled device.
- Supply non-secret Auth0 domain/client/audience/origin values only through private compile-time
  launch configuration; enable `MARKEI_NATIVE_CLOSURE_SURFACE=true`.
- Ensure Android Gradle callback domain and Dart Auth0 domain are identical.
- Confirm the Closure destination is absent without the flag and present with valid configuration.

## Gate 2 — Controlled identity and membership

- Create/use one synthetic Auth0 development user.
- Complete native login on the first client without copying the access token.
- Obtain the issuer/subject privately and map it to one synthetic Account through the controlled
  migrator procedure already authorized by migrations 004–006.
- Never derive AccountId or DeviceId from Auth0 claims.
- Record only aliases and row counts in evidence.

## Gate 3 — Two native Devices

For Android, then Windows:

1. Sign in through the system browser and return through the configured callback.
2. Confirm semantic state `authenticated`.
3. Enroll/query the installation through the application route.
4. Confirm `device-enrolled` and a distinct Device row for each installation.
5. Retry the same enrollment and confirm idempotent equivalent outcome.
6. Confirm no token, subject or UUID appears in the app surface or logs.

## Gate 4 — Hosted convergence

- Register one synthetic purchase locally on Device A and run Sync.
- Require `sync-completed` or truthful `sync-no-new-events` after a subsequent run.
- Run Sync on Device B and confirm the same authoritative purchase facts appear after commit.
- Register a second synthetic purchase on B, sync B then A, and compare facts again.
- Close/reopen both clients and confirm facts, cursor and resolved outbox state persist.
- Verify acknowledgements advance only after local application commits.

## Gate 5 — Selected denials and continuity

Prove sanitized outcomes for:

- no bearer token -> 401/authentication-required;
- unknown external identity -> denied with no protected advance;
- unknown Device before enrollment -> device-enrollment-required;
- revoked Device -> device-revoked and no protected advance;
- cross-Account Device/membership mismatch -> denied;
- Render unavailable -> local purchase registration and pending outbox remain available;
- logout -> signed-out-cleared and hosted actions require authentication again.

Wrong issuer/audience/expiry cryptographic cases may retain the already accepted closed server tests;
do not manufacture or paste tokens merely to repeat them manually.

## Gate 6 — Evidence and cleanup

Return a sanitized evidence block containing:

- date, Git SHA and platform/build pass/fail;
- native login/callback/logout pass/fail per platform;
- identity/membership/Device row counts only;
- named sync and denial outcomes;
- fact/outbox/cursor/ack counts or opaque ranges;
- Render health/status classes and log secret scan;
- local continuity and reopen result;
- remaining synthetic resources and cleanup owner.

Do not return screenshots or output containing provider identifiers or private values. Remove
synthetic facts/mappings/Devices after Main accepts the proof, or record their bounded retention.

Success terminal:

~~~text
MCG-02_ANDROID_NATIVE_PROVIDER=true
MCG-02_WINDOWS_NATIVE_PROVIDER=true
MCG-02_TWO_DEVICE_ENROLLMENT=true
MCG-02_HOSTED_CONVERGENCE=true
MCG-02_PROVIDER_DENIALS=true
MCG-02_LOCAL_CONTINUITY=true
MCG-02_DECISIVE_PROVIDER_PROOF_COMPLETE
~~~

Otherwise report `MCG-02_DECISIVE_PROVIDER_PROOF_PARTIAL` with the exact gate and sanitized error.
Main must reconcile the result before promotion, Cycle 10 closure or MCG-03.
