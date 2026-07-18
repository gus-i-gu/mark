# I_DSN_CODEX — MCG-02 Native Closure Design Evidence

- Authority marker: C10-MCG02-NATIVE-CLOSURE_20260718T140335Z
- Baseline SHA: 6fffad609bb83523d467a849e2d91f3c668af721
- Implementation tree before reports: d1f48239d213af5449736612544fc23afe99d7fb
- Final commit status: pending before commit.
- Evidence environment: official Auth0 Flutter SDK 2.4.0, Flutter 3.44.6, Dart 3.12.2, Android debug build, Windows runner source integration.
- Result classification: architecture and local composition proof complete; provider proof pending.

## Dependency Direction

Flutter composition now follows:

`MarkeiComposition -> NativeAuthClosureRunner -> HostedEnrollmentCoordinator -> ExternalAuthenticationSession / AccessTokenSource -> NativeAuth0Authentication -> auth0_flutter SDK`.

Auth0 SDK types remain isolated in infrastructure. Domain models and Drift do not depend on Auth0. Lab authentication remains in test/loopback proof code and is not selected by absent native configuration.

## Configuration And Callbacks

`NativeAuthConfiguration` validates non-secret compile-time inputs:

- Auth0 domain;
- Android or Windows public client ID;
- exact API audience;
- hosted HTTPS origin.

Missing or malformed values produce a fail-closed unavailable configuration. Android callback evidence derives from `https://<domain>/android/com.gusigu.markei/callback`; Windows callback evidence uses the SDK-required `auth0flutter://callback`.

Android Gradle placeholders are property-driven and have inert non-provider defaults. Windows runner integration captures startup protocol URIs, forwards second-instance callbacks through a current-user pipe, validates the fixed callback prefix and writes only accepted callbacks to `PLUGIN_STARTUP_URL`.

## Token Lifecycle

The SDK adapter uses Authorization Code + PKCE through platform web authentication and requests the configured API audience. Android disables SDK credential-manager storage for web auth and supplies an in-memory credentials manager. Windows credentials are already SDK-returned and manually held only in process memory.

Access tokens are rejected when expired, absent or equal to the ID token. Logout, rejection and expiry clear retained credentials. Provider/SDK exceptions are mapped to safe semantic states without logging raw exception content.

## Deviations And Residuals

Production deviation: Android `kotlin.incremental=false` was added because the Auth0 plugin Kotlin compile failed when incremental caches crossed the `H:` repository and `C:` pub-cache roots. This is build-tool containment, not authorization or provider behavior.

Windows residual: release build was not host-supported because Flutter plugin builds require symlink support and Developer Mode is disabled on this Windows host. Runner source integration and Dart semantics are materialized, but real Windows binary/provider acceptance remains human/provider proof.

Retained: migrations 001-006, server authorization semantics, Drift schema/reset behavior, Auth0/Neon/Render resources, automatic provisioning boundary, Device replacement boundary, permanent memory and methodology.
