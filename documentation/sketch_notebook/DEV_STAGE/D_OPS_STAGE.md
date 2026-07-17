# D_OPS_STAGE — MCG-02 Hosted Provider Proof Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-PROVIDER-PROOF_20260717T171443Z
> Staged at UTC: 2026-07-17T17:14:43Z
> Parent reconciliation: 2158c03f22b5181f1cccaf74d3aafa0450bf39ec
> Status: **HUMAN PROVIDER FOUNDATION ACTIVE; CODEX READ-ONLY ASSISTANCE**

## Objective

Establish and validate the disposable Auth0, Neon and Render foundation needed by the hosted
composition. This unit stops before native login: the repository has bearer-token transport ports
but no Auth0 Flutter SDK/login composition or production credential supplier. Its evidence prepares
a narrow Codex client-auth round; it does not complete MCG-02, MCG-03 or production launch.

## Authority split

Human may:

- configure Auth0 applications/API callbacks and retrieve non-secret identifiers;
- apply reviewed migrations to the disposable Neon development database as `markei_migrator`;
- configure and deploy one Render development Web Service;
- create synthetic test users, Account membership and Device enrollment state;
- run Android/Windows login and hosted synchronization probes;
- return sanitized results.

Codex may:

- inspect tracked repository configuration and public provider documentation;
- calculate migration hashes and prepare commands with placeholders;
- diagnose redacted build/runtime failures;
- verify sanitized evidence and later replace G/H/I if Main separately authorizes reporting.

Codex must not receive, print, store or use passwords, tokens, connection strings, provider IDs or
secret-bearing URLs. It must not operate provider consoles, deploy, mutate Neon, or read
`documentation/NEON_*`, `.env`, `.vscode` or other private local files.

## Checkpoints

### P0 — Preflight and containment

- Confirm branch `intermid-cycle-recovery` includes `2158c03`.
- Confirm the Neon child branch will remain alive throughout the proof.
- Confirm the database is `markei_sync_dev`; production branch is not selected.
- Confirm Auth0 tenant/API and Android/Windows Native Applications are development-scoped.
- Confirm Render service targets the same Git branch and is not yet production traffic.
- Inventory secrets only by variable name, never value.
- Rotate any credential ever committed or exposed before continuing.

### P1 — Auth0 contract

- Custom API audience exactly matches `MARKEI_AUTH_AUDIENCE`.
- Access tokens use RS256.
- Issuer is the tenant HTTPS URL with its trailing slash.
- JWKS is the issuer's `/.well-known/jwks.json` endpoint.
- Android and Windows applications remain Native Applications using Authorization Code + PKCE.
- Configure only the exact callback/logout URLs derived from the implemented clients.
- Do not create or embed a native client secret.
- Obtain one development access token and inspect only header/claims; never record the token.

Required sanitized evidence: tenant region alias, application types, algorithm, audience alias,
issuer-shape pass, JWKS HTTP status, and redacted claim checks for `iss`, `aud`, `sub`, `exp`.

### P2 — Neon migrations and privileges

- Use the direct endpoint and `markei_migrator` for migrations.
- Review SHA-256 for migrations 001–006 before execution.
- Apply 001 through 006 in order with `ON_ERROR_STOP=1`.
- Verify all ledger identifiers and 006 checksum.
- Use the pooled endpoint and `markei_runtime` for the hosted API.
- Prove runtime can call `markei_hosted_runtime_ready()` and cannot read the migration ledger,
  create schema objects or administer roles.
- Prove cross-Account access fails closed under the application transaction context.

Stop on a changed previously applied migration, partial ledger, privilege escalation or wrong branch.

### P3 — Render configuration and deployment

Service settings:

~~~text
Language: Node
Branch: intermid-cycle-recovery
Root directory: services/markei_sync_api
Build command: npm ci && npm run build
Start command: npm start
Health check path: /health/ready
Auto-deploy: Off during proof
~~~

Required variables:

~~~text
NODE_ENV=production
MARKEI_SYNC_DATABASE_URL=<pooled markei_runtime URL; secret>
MARKEI_AUTH_ISSUER=<Auth0 HTTPS issuer with trailing slash>
MARKEI_AUTH_AUDIENCE=<exact custom API audience>
MARKEI_PUBLIC_ORIGIN=<Render HTTPS service origin>
MARKEI_LOG_LEVEL=info
~~~

Do not add `MARKEI_SYNC_MIGRATOR_DATABASE_URL`; the application rejects it. Render supplies `PORT`.
Require a successful build, `MARKEI_HOSTED_SYNC_READY`, HTTPS health 200 and no secret/fact payload
in logs. Render must bind the service through the implementation's `0.0.0.0:$PORT` behavior.

### P4 — Hosted foundation probe

- Verify `/health/live` and `/health/ready` over Render HTTPS.
- Verify an unauthenticated protected route is denied.
- Verify the runtime readiness function succeeds through the pooled role.
- Inspect logs for secret, token and fact-payload absence.
- Confirm the Flutter repository has no Auth0 SDK/login composition and record this as the next
  implementation boundary, not as a failed provider configuration.

Do not create ordinary users, memberships or Devices until Main stages the client-auth integration
and decisive hosted proof. A manually copied dashboard token is not Android/Windows login evidence.

## Evidence return

Return a sanitized block with timestamp, Git SHA, provider aliases, migration IDs/hashes, HTTP
status classes, row counts, named pass/fail cases, deployment SHA, log-scan result and remaining
resources. Never return hostnames, tenant domain, client IDs, subjects, Account/Device UUIDs,
passwords, tokens, URLs containing credentials or screenshots containing them.

Foundation success terminal:

~~~text
MCG-02_AUTH0_TOKEN_CONTRACT=true
MCG-02_NEON_MIGRATIONS_AND_PRIVILEGES=true
MCG-02_RENDER_HTTPS_RUNTIME=true
MCG-02_NATIVE_CLIENT_AUTH_INTEGRATION=false
MCG-02_PROVIDER_FOUNDATION_READY
MCG-02_PROVIDER_PROOF_PENDING
~~~

Otherwise report `MCG-02_PROVIDER_FOUNDATION_PARTIAL` and the exact checkpoint/blocker. Main must
reconcile either result before client implementation. Do not proceed to pruning, promotion, Cycle
10 closure, MCG-03 or MCG-04.
