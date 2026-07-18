# D_OPS_STAGE — MCG-02 Native Authentication and Closure Harness

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-NATIVE-CLOSURE_20260718T140335Z
> Parent/provider commit: ade6e2c1f19ae3ebf318457d7ef76ac8dbe3bcae
> Status: **ACTIVE CODEX MATERIALIZATION AUTHORITY**

## Objective

Compose real Auth0 Authorization Code + PKCE authentication into the Flutter Android and Windows
clients, retain bearer tokens only in memory, and create a bounded development closure harness for
the later human two-client hosted proof.

This unit proves local composition readiness. It does not operate Auth0, Neon or Render; seed
membership; copy tokens; or claim provider acceptance.

## Preflight and stop rules

1. Read root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, then the canonical methodology route.
2. Confirm branch `intermid-cycle-recovery`, clean tracked state and ancestry `ade6e2c`.
3. Read J and D/E/F together; inspect existing hosted-auth ports, coordinator, transports,
   composition roots, Android/Windows runners and tests before editing.
4. Preserve untracked `.vscode/`, `documentation/NEON_*`, `.env*` and every unrelated user file.
5. Never read private provider files or request credentials/tokens/connection strings.
6. Stop on provider mutation, migration changes, required client secret, incompatible platform SDK,
   contradictory D/E/F, or a dependency that cannot support both target platforms safely.

## CP1 — Dependency and typed configuration

- Verify the current official Auth0 Flutter SDK guidance and Flutter/Dart/platform compatibility.
- Select and pin one exact compatible SDK version; update only required dependency/lock files.
- If Windows support requires a prerelease, record that explicitly and prove its compatibility; do
  not silently replace the selected SDK or add a second authentication library.
- Add a closed typed configuration loaded from non-secret compile-time inputs equivalent to:
  `AUTH0_DOMAIN`, platform client ID, API audience and hosted HTTPS origin.
- Validate HTTPS origin, Auth0 domain shape, nonempty client ID and audience. Fail closed with a
  neutral configuration state when any value is missing or malformed.
- Commit no real tenant domain, client ID, audience, endpoint, password, token or `.env` file.

## CP2 — Auth0 infrastructure adapter

Implement an Auth0 adapter behind `ExternalAuthenticationSession` and `AccessTokenSource`:

- login uses Authorization Code + PKCE through the platform browser;
- request an access token for the exact configured Markei API audience;
- do not substitute the ID token for API authorization;
- map login, cancellation, logout, expiry, rejected credentials and provider unavailability to
  closed typed states without exposing SDK exceptions or token material;
- expose an access token only on demand and only while credentials are valid;
- clear credentials from application memory after logout, rejection or expiry;
- never write access/refresh/ID tokens to Drift, files, preferences, diagnostics or logs;
- keep `LabAuthenticationSession` and `LabAccessTokenSource` confined to tests/loopback labs.

If the SDK persists credentials by default, disable that facility or stop and report the conflict.

## CP3 — Platform composition

### Android

- Preserve verified application ID `com.gusigu.markei` unless repository evidence contradicts it.
- Add only the manifest/Gradle callback configuration required by the official SDK.
- Keep callback/logout values derived from injected Auth0 domain and application ID.
- Do not embed a client secret or real tenant value.

### Windows

- Register the exact callback/protocol handler required by the selected official SDK.
- Keep callback handling within the Windows runner and Auth0 adapter boundary.
- Prove repeated launch, login cancellation and logout do not leave stale credentials.
- Stop if the SDK cannot support the repository's Windows target without unsupported native code.

## CP4 — Application composition and closure surface

- Compose the Auth0 adapter with the existing hosted enrollment coordinator, HTTP identity/enrollment
  transports, sync guard and synchronization application services.
- Preserve local purchase registration and outbox behavior when unauthenticated or offline.
- Hosted actions require a valid access token; missing/expired token fails closed without local loss.
- Add the smallest neutral development-only surface or runner needed to trigger:
  sign in, current identity, Device enrollment/query, hosted sync and logout.
- Show only semantic state/status aliases. Never render or copy tokens, claims, subject, AccountId,
  DeviceId, connection details or fact payloads.
- Do not redesign pages/navigation or introduce Cycle 11 UX.
- Do not auto-create external identities or Account memberships. Their controlled provider-proof
  setup remains a human action after the subject is known privately.

## CP5 — Deterministic proof

Add closed tests for at least:

- valid/missing/malformed native configuration;
- access token requested for exact audience;
- ID token rejected as API credential;
- login success, cancellation, provider error, expiry and logout;
- token absent from Drift bytes, files, preferences, retained state and diagnostics;
- Android callback derivation and Windows protocol routing;
- unknown identity, inactive membership, unknown/revoked Device and cross-Account denial mapping;
- same enrollment identity/hash replay and different-hash conflict;
- API outage preserves local facts and pending outbox work;
- no production composition references lab authentication;
- cold restart does not recover a prior token.

Fakes may prove application behavior, never real provider acceptance. Name the distinction in tests
and reports.

## CP6 — Validation

Run all applicable checks:

- dependency resolution and lockfile consistency;
- Dart format check, Flutter analysis and complete Flutter tests;
- Android debug build and Windows release build when host-supported;
- server format/lint/typecheck/tests/build if shared contracts changed;
- protected Python regressions if touched transitively;
- `git diff --check` and tracked/staged secret scan.

Record exact commands, versions, counts, exclusions and environment limitations. A build does not
equal runtime/provider acceptance.

## Reports and commit

Replace only G/H/I after implementation. G records paths, dependencies, commands/results, platform
builds and secret scan. H records states, wording and privacy evidence. I records dependency
direction, configuration, callback and token-lifecycle boundaries.

Commit source and G/H/I as one bounded unit and push only `intermid-cycle-recovery`; never force.

Complete local terminal:

~~~text
MCG-02_NATIVE_AUTH_COMPOSITION=true
MCG-02_ANDROID_AUTH_COMPOSITION=true
MCG-02_WINDOWS_AUTH_COMPOSITION=true
MCG-02_TOKEN_EPHEMERAL=true
MCG-02_LOCAL_REGISTRATION_INDEPENDENT=true
MCG-02_NATIVE_CLIENT_AUTH_INTEGRATION_READY
MCG-02_DECISIVE_PROVIDER_PROOF_PENDING
~~~

Otherwise report `MCG-02_NATIVE_AUTH_COMPOSITION_PARTIAL` with the exact blocker. Do not proceed to
human provider acceptance, pruning, permanent promotion, Cycle 10 closure, MCG-03 or MCG-04.
