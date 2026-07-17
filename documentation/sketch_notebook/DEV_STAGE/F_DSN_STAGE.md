# F_DSN_STAGE — MCG-02 Provider-Proof Design Authority

> Authority marker: C10-MCG02-PROVIDER-PROOF_20260717T171443Z
> Status: **PROVIDER FOUNDATION CONFIGURATION AND EVIDENCE ONLY**

## Selected topology

~~~text
Android / Windows Native clients
        -> Auth0 Authorization Code + PKCE (not yet composed in Flutter)
        -> Render HTTPS hosted Fastify composition
        -> pooled Neon markei_runtime

controlled migration session
        -> direct Neon markei_migrator
~~~

The selected target has Auth0 validate login and issue an access token. The API validates signature, issuer,
audience, expiry and algorithm through JWKS. PostgreSQL remains authoritative for Account
membership, Device enrollment/revocation and synchronization state.

Current gap: Flutter exposes bearer-token transport ports but has no Auth0 SDK dependency, login
composition or production credential supplier. Provider setup cannot substitute for that code.

## Configuration contract

The hosted runtime consumes only:

- `NODE_ENV`;
- Render-provided `PORT`;
- pooled `MARKEI_SYNC_DATABASE_URL` for `markei_runtime`;
- `MARKEI_AUTH_ISSUER` with trailing slash;
- exact `MARKEI_AUTH_AUDIENCE`;
- optional derived or explicit HTTPS `MARKEI_AUTH_JWKS_URI`;
- exact HTTPS `MARKEI_PUBLIC_ORIGIN`;
- bounded `MARKEI_LOG_LEVEL`.

The runtime rejects a migrator URL. Migrator credentials never enter Render or Flutter. Native
applications have public client IDs but no embedded client secret.

## Database boundary

Apply immutable migrations 001–006 in order over a direct connection. Existing migration hashes
must be checked before execution; never edit an applied file. Runtime receives only grants defined
by the migrations and must remain unable to read/write `migration_ledger`, create schema objects,
administer roles, enroll identities by direct table mutation or bypass Account predicates.

The provider proof may seed synthetic identity/membership rows only through a controlled migrator
session. Ordinary synchronization uses the runtime role and application routes.

## Authentication and authorization

Token verification is necessary but insufficient:

1. verify RS256 signature through issuer-bound JWKS;
2. verify exact issuer, audience and expiry;
3. resolve `(issuer, subject)` to an active external identity;
4. resolve explicit active Account membership;
5. resolve/enroll the request's Device idempotently;
6. authorize the Device and Account again inside protected transactions.

No Auth0 claim becomes AccountId or DeviceId. No credential or token becomes durable Drift state.

## Transaction and retry rules

- Enrollment identity and request hash define replay identity.
- Same identity/hash returns the same result; same identity/different hash conflicts.
- Authorization changes committed before the transaction fence must deny protected mutation.
- Response loss must be resolved by query/replay, never blind identity regeneration.
- Retry exhaustion fails closed and preserves pre-attempt protected state.
- Acknowledgement occurs only after committed local application.

## Provider foundation boundary

Use one disposable development branch/database. This unit may deploy the existing hosted
composition and verify its health/configuration boundary, but it must not fabricate native login by
manually copying tokens. It may not add provider-specific shortcuts, production credentials,
automatic user provisioning, social login, Device replacement, billing, telemetry or production
retention policy.

## Security checks

- TLS for Auth0, Render and Neon;
- no secrets in Git, build output, logs, screenshots or reports;
- no token/fact-payload logging;
- exact callback/logout allowlists;
- wrong issuer/audience/algorithm/key fail closed;
- cross-Account and revoked/unknown Device requests fail closed;
- runtime DDL and migration-ledger access denied;
- production Neon branch not used;
- Render contains runtime credentials only.

## Evidence and rollback

Provider configuration is reversible: disable Render auto-deploy/service, revoke test Devices,
delete synthetic rows, rotate credentials, and remove disposable Auth0/Neon resources after Main
acceptance. Preserve only sanitized evidence and resource inventory before teardown.

The missing native auth composition is already identified. Stop after foundation evidence and
return it to Main. Do not patch source under this authority. Main must issue new D/E/F for the
bounded client-auth round and later decisive provider proof.

## Deferred decisions

Production hosting tier, custom domain, production tenant, social providers, account recovery,
Device replacement, provider monitoring, backup/PITR policy and MCG-03/04 definitions remain open.
