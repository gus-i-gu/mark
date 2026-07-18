# F_DSN_STAGE — MCG-02 Native Authentication Design Authority

> Authority marker: C10-MCG02-NATIVE-CLOSURE_20260718T140335Z
> Status: **ACTIVE DESIGN AUTHORITY**

## Selected dependency direction

~~~text
Flutter presentation/development closure surface
        -> hosted enrollment/sync application services
        -> ExternalAuthenticationSession / AccessTokenSource ports
        -> Auth0 Flutter infrastructure adapter
        -> official Android/Windows platform integration

application services
        -> HTTP identity/enrollment/sync adapters
        -> Render HTTPS
        -> pooled Neon markei_runtime
~~~

Auth0 SDK types must not enter domain models or Drift. The hosted API remains responsible for JWT
verification and PostgreSQL authorization. PostgreSQL remains authoritative for identity mapping,
Account membership and Device lifecycle.

## Configuration boundary

Create one immutable typed configuration from non-secret compile-time values. It must hold only the
Auth0 domain, platform client ID, exact Markei API audience and Render HTTPS origin. Validate before
constructing SDK or HTTP adapters. Missing/malformed configuration selects a fail-closed local-only
composition.

No real defaults, `.env`, JSON credential asset, client secret, database URL or token may be added.
Android and Windows may use distinct public client IDs. Provider aliases belong in private launch
commands or IDE settings outside Git.

## Authentication adapter boundary

- The adapter owns SDK interaction and converts SDK results/errors to application states.
- Authorization Code + PKCE and the system browser are mandatory.
- Only an unexpired access token for the configured audience may satisfy `AccessTokenSource`.
- ID tokens never authorize API requests.
- Token values never cross into diagnostics, repositories or exception messages.
- Token lifetime is process-memory bounded; logout/expiry/rejection clears it.
- If the SDK requires durable credential storage, stop rather than weakening this invariant.
- Lab adapters remain test/loopback-only and unreachable from production composition.

## Platform boundaries

Android keeps package/application identity `com.gusigu.markei` subject to repository verification and
derives callbacks from the official SDK contract. Windows registers only the exact custom protocol
required by the pinned SDK. Both platforms must route callbacks to the same adapter semantics and
must support cancellation and logout without stale session state.

Platform changes may include only required Gradle/manifest/runner/protocol registration. Do not add
unrelated native plugins, permissions, analytics or background services.

## Application and continuity boundary

Authentication enables hosted actions; it does not gate local purchase registration. Missing token,
provider outage or denied membership leaves local facts and outbox intact. Existing enrollment
idempotency, query-after-unknown, absolute deadlines and synchronization acknowledgement rules
remain unchanged.

The development closure surface is an adapter-driving diagnostic, not product UX. It may expose
semantic states and actions but no credentials/identifiers/payloads. It must be excluded or inert
when native configuration is absent.

## Provider-proof handoff

Codex prepares but does not execute the final provider proof. Human execution later supplies private
non-secret launch configuration, authenticates one synthetic user on Android and Windows, performs
controlled identity/membership setup, enrolls two distinct Devices and synchronizes one synthetic
Account through Render/Neon.

Required hosted acceptance includes valid login/sync plus missing, malformed, expired, wrong-issuer,
wrong-audience, unknown identity, inactive membership, unknown/revoked Device and cross-Account
denials with no protected advance. Manual token copying does not count.

## Change and rollback boundary

Allowed changes:

- Flutter dependency and lock files;
- Auth0 configuration/adapters and application composition;
- required Android/Windows callback integration;
- minimal development closure surface;
- focused tests and G/H/I reports.

Forbidden changes:

- PostgreSQL migrations 001–006 or server authorization semantics;
- provider resources, secrets or deployment;
- Drift schema/reset, automatic provisioning or Device replacement;
- product navigation/visual redesign, telemetry or permanent notebook memory.

Rollback is removal of the adapter/composition/platform registration and dependency changes. It must
leave local registration, Drift facts/outbox, R05 proof and provider foundation intact.

## Validation and residual risks

Prove config validation, audience selection, callback routing, state mapping, token ephemerality,
local continuity and supported platform builds. Record the pinned SDK/prerelease status and any
Windows limitation. Real browser/provider behavior, account mapping and two-Device convergence
remain residual until human acceptance.

Production tenant/domain, hosting tier, social providers, account recovery, Device replacement,
monitoring, backup policy, pruning/promotion and MCG-03/04 remain deferred.
