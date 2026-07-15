<!-- TEMPORAL_MARKER:C10-S03-HOSTED-DEVELOPMENT-INVESTIGATION-2026-07-15 -->
# A_OPERATIONAL — C10-S03 Hosted Development Authentication and Synchronization Proof
Sequence: FLX-INV-02
Role: Operational [O]
Branch: `intermid-cycle-recovery`
Inspected HEAD: `de1319dc05e1f04ba84b6cfd681f5b72a4568f88`
Required ancestor: `de1319dc05e1f04ba84b6cfd681f5b72a4568f88`
Evidence date: 2026-07-15
Authority: candidate/proposed/provisional Operational staging only; no deployment, provider mutation, credential access or source materialization.

## 1. Methodology retained
Loaded root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md` and `CHAT_PROTOCOL.md` in the full canonical route.
Retained:
- Operational owns execution order, environment contracts, validation, provider boundaries, rollback, teardown, redaction and stop gates.
- `A_OPERATIONAL.md` is functional staging for Main synthesis, not canon or Codex authority.
- PRC-01 keeps provisional provider evidence, accepted local evidence, implementation and validation distinct.
- G/H/I remain observational; sanitized human evidence remains provisional until Main reconciliation.
- Connectivity does not prove authentication, authorization, Device ownership, synchronization, retention, recovery or production readiness.
- Only this A stage may change; secret-bearing files, provider notes and MCG material are excluded.
GitHub comparison reported the required commit and branch as identical before investigation. Connector evidence cannot inspect local dirty state or run host commands; blob concurrency and branch comparison are the available publication guards.

## 2. Evidence boundary and discrepancy
Accepted repository evidence:
- C10-S01B proved one local Drift→HTTP→Fastify→PostgreSQL→HTTP→Drift convergence path.
- C10-S02 at `de1319dc` proved local retention, compatible snapshot publication, coverage-gated cleanup, typed cursor expiry, resumable fresh-target rebootstrap and catch-up.
- migrations 001–003 are forward-only local proofs; migration 003 has not been applied to Neon.
- normal API composition still injects `RefusingAuthVerifier`.
- `lab.ts` and recovery lab use fixture authentication and must never be hosted.
- protected Python `unittest` passed; `pytest` was unavailable.
G’s changed-path inventory omitted the modified G/H/I report files. The Git commit controls the physical inventory; this is a reporting discrepancy, not evidence invalidation or authority to rewrite G/H/I.
Provisional sanitized human evidence:
- isolated Neon development branch; alias `markei_sync_dev`; PostgreSQL 18.4; `us-west-2`;
- separate `markei_migrator` and `markei_runtime`; TLS, runtime DDL denial, CRUD probes and secret-outside-Git handling passed;
- Auth0 development tenant, custom API and separate Android/Windows Native Applications prepared with development-only audience;
- Render linked to the intended repository; no service deployed.
These facts support planning only. No credential, connection string, dashboard or secret-bearing file was inspected.

## 3. Official documentation consulted
Accessed 2026-07-15:
- Render Web Services and Free Instances documentation.
- Render Environment Variables, monorepo/root-directory and rollback documentation as linked from Web Services.
- Auth0 Validate Access Tokens, Validate JWTs and Application Settings documentation.
- Neon Connection Pooling and Manage Roles documentation.
- Node.js Releases documentation.
- PostgreSQL 18 transaction, RLS and migration behavior already controlling local evidence.
Documented guarantees relevant to the hypothesis:
- Render web services must bind HTTP to `0.0.0.0` and should use `PORT`; HTTPS terminates at Render’s load balancer.
- Render build and start commands are explicit; environment variables/secrets are dashboard-managed.
- Free web services may spin down after 15 minutes idle, take roughly one minute to wake, and have ephemeral local files; Free is not recommended for production.
- Node 24 is LTS on the accessed Node release schedule.
- Auth0 API access tokens must be rejected when JWT validation, issuer/signature/expiry, audience or required permissions fail.
- Auth0 Native Applications are public clients; client secrets must not be embedded in Android or Windows clients.
- Neon recommends pooled connections for web applications and direct connections for migrations; transaction pooling does not support session-level `SET` persistence.
Provider assumptions still unresolved: exact Render Node runtime availability, outbound access to Auth0 JWKS and Neon from the selected region, Free-instance limits for this workspace, and current Auth0/Render plan constraints.

## 4. Exact hosted-readiness gaps
Repository gaps:
- `main.ts` injects `RefusingAuthVerifier`, accepts only `MARKEI_SYNC_DATABASE_URL`, and binds `127.0.0.1:3100`.
- no production Auth0/JWKS verifier, token cache policy, hosted environment schema or startup redaction exists.
- no membership mapping from Auth0 subject to Markei Account exists.
- no production Device enrollment, ownership proof, revocation or replacement path exists.
- no production-safe server entrypoint or hosted start command exists.
- `package.json` has test/lab scripts only; no `build`, `start` or compiled output contract.
- no Render root/build/start/health configuration exists.
- migrations 001–003 seed fixture Accounts/Devices operationally but do not own hosted identity membership/enrollment.
- no reviewed Neon migration ledger evidence for hosted migration 004 exists.
- Flutter sync transport accepts token sources, but interactive Auth0 login/token refresh/secure storage and hosted API composition are not accepted.
- no Android/Windows hosted two-Device proof, invalid-token matrix or synthetic teardown exists.
Operational conclusion: C10-S03 is not currently deployable or authorized.

## 5. Recommended unit boundary
Recommend splitting C10-S03 into two coupled subunits:
- `C10-S03A`: repository implementation plus disposable local hosted-composition proof; Codex-owned after Main D/E/F.
- `C10-S03B`: human-controlled Neon migration, Render deployment, Auth0/Device enrollment and Android/Windows decisive proof.
Reason: provider mutation and interactive authentication cannot be safely rolled back or evidenced by the same authority as source materialization. A single unit may remain one Main milestone, but publication gates must separate implementation from manual provider proof.
Confidence: high for the split; medium for exact provider commands until MCG-02 facts are reconciled.

## 6. OP1–OP10 checkpoint sequence
### OP1 — Contracts and hosted configuration
Prerequisites: accepted S01B/S02 evidence; frozen environment-name list; no secrets.
Codex mutation: typed environment loader, closed error/status contracts, redaction tests, build/start scripts.
Proposed names:
```text
NODE_ENV
PORT
MARKEI_SYNC_DATABASE_URL_RUNTIME
AUTH0_ISSUER_BASE_URL
AUTH0_AUDIENCE
AUTH0_JWKS_URI        optional derived override
AUTH0_REQUIRED_SCOPE  optional explicit policy
MARKEI_LOG_LEVEL
MARKEI_DEPLOYMENT_ENV=development
```
Migration URL must never be a web-service runtime variable.
Evidence: missing/invalid variables fail before listen; logs show names/codes only.
Failure: malformed issuer/audience/PORT/URL, accidental secret echo.
Rollback: revert configuration unit; local lab remains available.
Stop: any secret default, fixture-auth fallback or payload logging.
Responsibility: Codex.

### OP2 — Identity/membership schema migration
Prerequisites: Main selects subject→Account ownership and enrollment authority.
Proposal: forward-only `004_hosted_identity_membership.sql`; never edit 001–003.
Candidate tables: `account_memberships`, `device_enrollment_challenges` or equivalent, Device auth-subject/audit fields, revocation metadata and migration ledger row/checksum.
Invariant: Auth0 `sub` identifies an external subject; authorization derives Account membership from PostgreSQL, never from client-supplied AccountId.
Evidence: fresh 001→004 and representative 001→003→004 rehearsal, checksum, RLS, grants and rollback checkpoint.
Failure: duplicate subject membership, wrong Account, partial migration, runtime DDL.
Rollback: stop deployment and forward-correct; disposable Neon branch may be recreated only by human ownership.
Stop: ambiguous multi-Account membership policy or migration requiring destructive rewrite.
Responsibility: Codex locally; human applies reviewed migration to Neon.

### OP3 — Production AuthVerifier and authorization
Prerequisites: issuer, audience, signing algorithm and required scopes accepted.
Codex mutation: production verifier using OIDC/JWKS; bounded cache/refresh; fail-closed errors; AuthContext contains verified subject only, then membership lookup derives Account.
Evidence: valid token; invalid signature; expired; not-before; wrong issuer; wrong audience; missing scope; unknown subject; JWKS unavailable/rotation.
Failure injection: stale key cache, unknown `kid`, outbound timeout, malformed bearer header.
Rollback: deploy prior refusing-auth build or disable service; never switch to fixture auth.
Stop: token decoded without cryptographic verification, ID token accepted as API access token, or claims trusted as Account authority.
Responsibility: Codex.

### OP4 — Device enrollment/revocation
Prerequisites: Main selects first-device bootstrap, additional-device approval and reinstall semantics.
Proposal: authenticated membership may request a short-lived one-time enrollment challenge; server creates a new Device identity; client stores no server secret beyond normal OAuth material and Device identifier.
Evidence: first enrollment, second Device, replayed/expired challenge, subject mismatch, revoked/unknown Device denial, replacement uses new Device and sequence.
Failure: stolen challenge, concurrent redemption, revoked Device retries sync/recovery.
Rollback: revoke newly enrolled synthetic Devices; preserve Account facts.
Stop: self-asserted Device ownership, reusable enrollment token, old Device identity reuse or unbounded challenge lifetime.
Responsibility: Codex contracts/local proof; human interactive enrollment proof.

### OP5 — Hosted server entrypoint
Prerequisites: OP1–OP4 local green.
Codex mutation: production-only entrypoint, no fixture imports, `0.0.0.0`, `PORT`, graceful shutdown, pool timeouts and minimal health.
Health proposal:
- `GET /health/live`: unauthenticated, static process liveness, no provider/database details.
- `GET /health/ready`: optional deployment health, bounded DB probe, generic status only; Main must decide public exposure.
Render hypothesis:
```text
Root Directory: services/markei_sync_api
Runtime: Node
Build Command: npm ci && npm run build
Start Command: npm start
Health Check Path: /health/live
Node: 24.x pinned through package engines and Render-supported mechanism
```
Evidence: compiled JS starts with production dependencies only; SIGTERM closes HTTP/pool; no local filesystem state.
Failure: missing `PORT`, DB unavailable, Auth0 JWKS unavailable, shutdown during request.
Rollback: Render rollback to prior deploy or suspend/delete undeployed development service.
Stop: listening on loopback, `tsx`/devDependencies required at runtime, or lab entrypoint selected.
Responsibility: Codex.

### OP6 — Local hosted-composition proof
Prerequisites: production entrypoint and AuthVerifier ports implemented.
Codex proof: local HTTPS-equivalent proxy or HTTP loopback with real JWT test issuer/JWKS, production composition, PostgreSQL 001–004, two Devices and no fixture verifier.
Evidence: login-token analogue→membership→enrollment→upload/download/ack→snapshot/rebootstrap; restart and key rotation.
Failure matrix includes all auth, Device and cross-Account denials.
Rollback: disposable containers/keys/Drift files removed.
Stop: any direct replay, fixture-auth escape, cross-Account row, secret/payload log or local-only fallback regression.
Responsibility: Codex.

### OP7 — Reviewed Neon migration
Prerequisites: OP6 green; Main accepts sanitized MCG-01; human confirms target alias/version/roles.
Human mutation: direct `markei_migrator` connection applies 001–004 or only unapplied ledger entries; runtime pooled identity remains separate.
Procedure: record pre-migration ledger/hash and branch checkpoint; apply one transaction where supported; verify schema, ledger, grants, RLS and runtime denial; do not seed ordinary data.
Evidence: aliases, PostgreSQL version, migration IDs/checksums, timestamps, row/table counts and pass/fail only.
Failure: hash mismatch, existing object conflict, permission denial, partial ledger/schema, wrong branch.
Rollback: stop; use Neon branch restore/recreate under human ownership or forward correction. Never downgrade production-like facts destructively.
Stop: target ambiguity, migrator using pooled URL, runtime using direct migrator identity, or secret exposure.
Responsibility: human; Codex supplies reviewed commands/tests only.

### OP8 — Render configuration/deployment
Prerequisites: OP7 green; approved commit; MCG-02 checklist.
Human mutation: create development Web Service on intended branch/root; inject runtime pooled URL and Auth0 public configuration/secrets through Render; disable auto-deploy initially.
Evidence: build/start logs sanitized, Node version, commit SHA, HTTPS hostname alias, health status, deploy ID and cold-start observation.
Failure: build dependency drift, port detection failure, JWKS/Neon outbound failure, cold-start timeout, environment validation failure.
Rollback: rollback/suspend/delete service; rotate credentials only if exposure occurred.
Stop: migrator URL present, fixture auth reachable, secrets printed, wrong repository/branch/root, or Free-tier behavior incompatible with decisive tests.
Responsibility: human.

### OP9 — Android/Windows decisive proof
Prerequisites: hosted API green; separate Auth0 Native Application callback/logout configuration; synthetic test subject.
Human/Codex-assisted proof:
1. Android Device A authenticates, enrolls, registers offline and uploads.
2. Windows Device B authenticates same membership, enrolls separately, downloads/applies/acks.
3. timeout/restart and cold-start cases preserve unknown-outcome identity.
4. revoke A; A upload/download/recovery denied; B remains functional.
5. wrong-account subject, mismatched Device and invalid-token matrix denied.
6. snapshot/rebootstrap tested on a fresh synthetic replacement Device if retained in S03 scope.
Evidence: commit/build IDs, platform versions, hashed Account/Device aliases, counts, cursors, status codes and timings only.
Rollback: revoke synthetic Devices/user, disable hosted sync composition, retain autonomous local facts.
Stop: ordinary user data, token screenshots/logs, Android/Windows client secret, cross-Account visibility, or inability to restore local-only operation.
Responsibility: human execution; Codex provides harness/build support after authority.

### OP10 — teardown, evidence and rollback
Prerequisites: inventory before creation.
Human: revoke/delete synthetic Auth0 user and Device grants, remove Render service or suspend it, revoke/rotate development credentials as appropriate, delete only inventoried Neon synthetic rows/branch under ownership.
Codex: G/H/I exact inventory, commands, exclusions and discrepancies.
Success: no service unexpectedly active, no synthetic membership/Device rows, no secrets/artifacts in Git, local-only app remains runnable.
Stop: ownership ambiguity or teardown would affect production/unrelated resources.
Responsibility: shared, with provider actions human-only.

## 7. Validation and failure matrix
| Boundary | Required evidence |
| --- | --- |
| configuration | missing/invalid env fails closed; secret-pattern/redaction tests |
| build | `npm ci`, compile, lint, typecheck, test, production install/start |
| auth | valid, expired, wrong issuer/audience/signature/scope, unknown `kid`, JWKS outage |
| membership | unknown subject, wrong Account, duplicate/disabled membership |
| Device | enroll/replay/expiry/revoke/replace/mismatch/unknown denial |
| database | 001→004 ledger/hash, direct migrator, pooled runtime, DDL denial, RLS matrix |
| network | Render cold start, timeout, reconnect, Auth0/Neon outage, TLS only |
| sync | unknown outcome same SubmissionId, convergence, ack, cursor expiry, rebootstrap |
| platform | Android and Windows authentication, secure token storage, restart/logout/revoke |
| privacy | no token, URL credential, payload, snapshot bytes or PII in logs/reports |
| teardown | synthetic rows/identities/service inventoried and removed |
Smallest repository command hypothesis:
```text
npm --prefix services/markei_sync_api ci
npm --prefix services/markei_sync_api run format:check
npm --prefix services/markei_sync_api run lint
npm --prefix services/markei_sync_api run typecheck
npm --prefix services/markei_sync_api test
npm --prefix services/markei_sync_api run build
npm --prefix services/markei_sync_api run test:hosted-local
flutter analyze
flutter test
python -m unittest discover -s tests
git diff --check
```
Script names beyond existing package scripts are proposals.

## 8. Migration/deployment order and rollback boundary
Required order:
```text
Main accepts S03A D/E/F
→ contracts/config/auth/membership/enrollment/entrypoint
→ local production-composition proof
→ Main reviews G/H/I
→ human Neon migration with direct migrator
→ runtime pooled privilege/RLS probes
→ human Render deployment with auto-deploy off
→ health/JWKS/database probes
→ Android/Windows synthetic proof
→ teardown or explicit retained-development decision
```
Never deploy application code requiring 004 before 004 is verified. Prefer backward-compatible 004 and an entrypoint that refuses readiness until required migration IDs exist.
Rollback boundary: before hosted proof, disable/suspend Render first; do not reverse 004 destructively; use prior compatible application build or forward correction; preserve local Device facts and pending submissions.

## 9. Provider/manual responsibility matrix
| Action | Codex | Human |
| --- | --- | --- |
| source/contracts/tests/build scripts | materialize after D/E/F | review |
| inspect credentials/dashboards | prohibited | controlled |
| apply Neon migration | prepare/check only | execute |
| create Render service/env | prohibited | execute |
| configure Auth0 apps/API/callbacks | inspect docs only | execute |
| issue interactive tokens | prohibited | execute through clients |
| run Android/Windows proof | support harness/build | operate Devices |
| sanitized evidence | draft schema/check | supply aliases/results |
| provider teardown | inventory guidance | execute |

## 10. Secret and privacy controls
- Never commit or paste database URLs, passwords, bearer/refresh/ID tokens, client secrets, JWKS private material or callback session data.
- Android/Windows Native Applications contain public Client IDs and domain/audience configuration only; no client secret.
- Render receives only runtime pooled database credentials, never migrator credentials.
- Logs use correlation ID, hashed subject/Account/Device aliases, operation, status, cursor/count/timing and migration IDs/checksums.
- Authorization errors do not reveal whether another Account, Device, snapshot or event exists.
- Health responses expose no versions, database names, regions, issuer, audience or role names.
- Secret-pattern scan covers tracked diff and generated build configuration; false positives are reviewed without printing matched secret values.

## 11. MCG-02 sanitized evidence template
Main should receive only:
```text
Repository commit / branch:
Render service alias / region / runtime / Node major:
Root directory / build command / start command:
HTTPS hostname alias and health pass timestamp:
Free/paid development instance and observed cold-start class:
Neon database alias / region / PostgreSQL version:
Applied migration IDs + checksums / ledger pass:
Runtime pooled / migrator direct separation: PASS|FAIL
Runtime DDL denial and RLS cross-Account matrix: PASS|FAIL
Auth0 tenant alias / issuer-domain class / API audience alias:
Android and Windows Native Application aliases:
Token validation matrix counts: passed/failed
Membership and Device denial matrix counts: passed/failed
Android→Windows convergence counts/cursors: sanitized
Rollback/teardown inventory and owner:
Secrets, credential URLs and payloads absent: PASS|FAIL
```
Do not include raw host connection strings, tenant secrets, tokens, client secrets, subject IDs or user payloads.

## 12. Stop gates and unresolved Main decisions
Stop before any provider mutation if:
- MCG-01 sanitized evidence is contradictory or not Main-accepted;
- S03A implementation/local proof is not green and reconciled;
- production AuthVerifier can fall back to fixture auth;
- membership or first-Device enrollment authority is undefined;
- migrator/runtime URLs or roles are confused;
- migration 004 compatibility/checksum/ledger is unresolved;
- Render repository, branch, root, runtime or teardown owner is ambiguous;
- invalid token, revoked Device or cross-Account probes leak data or succeed;
- secrets/payloads appear in logs, screenshots, Git or notebook evidence;
- Android/Windows cannot return to local-only operation;
- provider cost, cold-start or outbound limits prevent bounded testing.
Main must decide:
- one Account per Auth0 subject versus explicit multi-Account membership;
- first-Device and additional-Device enrollment authority;
- revocation, reinstall and Device replacement semantics;
- scopes/permissions and whether roles belong in Auth0 or Markei PostgreSQL;
- migration 004 schema and compatibility window;
- public `/health/ready` versus liveness-only health;
- Render Free suitability and cold-start acceptance threshold;
- whether snapshot/rebootstrap is included in S03 decisive proof;
- exact synthetic teardown retention and whether development service remains after proof;
- whether S03A/S03B are separate Codex/Main rounds.

## 13. Explicit speculative status
This report is an Operational hypothesis. It does not authorize C10-S03, migration 004, Auth0 integration, Neon mutation, Render deployment, Device enrollment or hosted synchronization. Sanitized MCG-01/Auth0/Render facts remain provisional until Main reconciliation. Recommended next action is Main synthesis selecting the S03A/S03B boundary and issuing new D/E/F only for the local implementation subunit first.