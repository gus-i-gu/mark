# D_OPS_STAGE — C10-S03A-R3 Operational Materialization Authority

> Sequence: FLX-ORD-01
> Branch: `intermid-cycle-recovery`
> Controlling Main reconciliation: `421d79405e0435d150b61ca092a6923fc603e53e`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: local correction and decisive proof only

## 1. Objective and terminal condition

Correct the six confirmed R2 defects and prove the complete local hosted-authorization boundary:

```text
scoped idempotent Device revocation
+ structurally mandatory hosted transaction authorization
+ exact actual-route classification
+ bounded JWKS unknown-key behavior
+ closed Flutter transport outcomes under one absolute deadline
+ exact least-privilege runtime readiness
+ deterministic authorization/HTTP/file-backed evidence
```

Success requires:

```text
R3_LOCAL_SECURITY_PROVED=true
C10-S03A_R3_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

If any decisive producer is missing, skipped, partial or host-blocked, report:

```text
C10-S03A_R3_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

## 2. Repository and security safety

Before editing:

1. read root `AGENTS.md`, `INDEX.md`, sketch-notebook `AGENTS.md`, then
   `METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL`;
2. read current A/B/C/J and this D/E/F together;
3. fetch and pull `intermid-cycle-recovery` with fast-forward-only behavior;
4. confirm `421d794` is an ancestor of HEAD;
5. inspect status and stop on divergence, conflicts or dirty overlap;
6. preserve every unrelated and untracked file;
7. never read `.vscode/settings.json`, `documentation/NEON_DOC.md`,
   `documentation/NEON_SESSION.ps1` or secret-bearing provider files;
8. never stash, reset, clean, discard, overwrite or force-push.

No Auth0, Neon, Render, deployment or provider credential use is authorized. Bind disposable
services to loopback and use only synthetic identities/facts.

## 3. CP1 — Device status and scoped revoke idempotence

Refactor Device-management authorization so actor authority and target state are separate.

Required rules:

- verified principal resolves through the migration-005 identity/membership fence;
- actor comes from `x-markei-device-id` plus identity-owned active enrollment and active Device;
- target comes from the path and never authenticates the actor;
- owner may target a same-Account Device; member may target only the actor Device;
- cross-Account, missing and foreign targets fail without enumeration;
- actor and target rows lock in stable UUID order; identical IDs use one lock;
- authorization returns a locked target snapshot that may be active or revoked;
- status reports the authorized target's actual active/revoked state;
- revoke changes enrollment and Device state in one transaction;
- an active→revoked transition inserts exactly one security event;
- an already-revoked target returns `duplicate-equivalent` only when the retrying actor remains
  active and authorized;
- after self-revoke commits, that actor is denied; universal self-revoke replay is not implemented.

Do not add a revoke-request table, reactivation/replacement workflow, unique event constraint,
provider Device management or UI.

Prove owner/member, same/foreign Account, distinct/self target, status after revoke, sequential and
concurrent repeats, one transition/event and the explicit self-revoke boundary.

## 4. CP2 — Structurally closed HTTP composition

Replace independent optional `auth`, `hosted` and `hostedAuthorizer` options with one exhaustive
composition equivalent to:

```text
hosted  { identityService, transactionAuthorizer }
fixture { verifier }
disabled
```

Requirements:

- hosted protected sync/recovery routes cannot reach a fixture/precommitted verifier fallback;
- fixture authentication remains available only to tests and loopback lab compositions;
- disabled/refusing normal composition remains safe;
- `hosted.ts`, `main.ts`, `lab.ts`, `hosted_local_harness.ts` and tests choose explicitly;
- invalid combinations fail typecheck or construction rather than silently degrading;
- avoid duplicate route implementations.

Add compile/type-level negative evidence where practical and runtime tests for each valid branch.

## 5. CP3 — Exact actual-route authorization inventory

Keep one typed descriptor for every application route and mechanically compare it with Fastify's
actual registered inventory.

Implement a project-owned classified registration gateway plus a root `onRoute` capture installed
before route/plugin registration. Normalize method/path pairs deterministically.

Required behavior:

- all 13 current non-health hosted/sync/recovery routes have exactly one descriptor;
- each descriptor has method, path, operation and authorization class;
- only `/health/live`, `/health/ready` and explicitly understood Fastify automatic HEAD forms are
  exempt or normalized;
- reject an actual extra route, missing route, duplicate method/path, wrong operation, wrong class
  and hosted route without hosted authorizer;
- do not parse `printRoutes()` output or compare two parallel constants;
- do not broadly ignore plugin/generated routes without exact evidence.

Tests must inject a real extra route and prove construction/readiness fails closed.

## 6. CP4 — JWT/JWKS cache and pressure state machine

Continue using `jose` for JWT/JWK cryptography. Do not implement signature algorithms.

Replace timestamp-as-key-identity logic with a stable, order-independent semantic key-set
fingerprint/revision over validated accepted JWK fields. Refresh must return an outcome equivalent
to:

```text
changed
unchanged
stale-retained
```

Required behavior:

- issuer, audience, expiry and RS256 remain pinned;
- HTTPS issuer requires same-origin HTTPS JWKS;
- timeout, redirect, response bytes, key count and fields remain bounded;
- duplicate `kid` always rejects;
- concurrent refresh coalesces;
- cache freshness and absolute stale expiry remain distinct from key-set identity;
- unknown requested key permits at most one eligible refresh;
- unchanged or stale-retained refresh sets per-key negative cooldown;
- forced unknown-key refresh obeys the active global failed-refresh cooldown;
- genuine semantic key-set change clears only relevant negative state;
- unknown keys are never accepted from stale material;
- public errors/logs contain no token, claims, URI, `kid`, key or body.

Use injected Clock/fetch. Prove frozen-time fresh/stale/final-expiry transitions, unchanged and
distinct-unknown-key bursts, failed-refresh pressure, coalescing, timeout/abort, duplicate `kid`,
outage/recovery, changed set without requested key and genuine rotation.

## 7. CP5 — Closed Flutter transport and absolute deadline

The HTTP adapter owns raw `package:http`, IO, timeout, stream, parse, size and status behavior. The
coordinator must receive only a closed application result/failure contract.

Required outcomes:

```text
success
duplicate-equivalent
conflict
unavailable
unknown-outcome
```

Requirements:

- coordinator obtains one access token per attempt and passes that exact in-memory value;
- transport never obtains or persists another token;
- one absolute deadline spans connect, headers and full bounded body consumption;
- expiry cancels the request/attempt and cannot be extended by a slow trickle;
- borrowed shared clients are not closed by one failed request;
- an owned per-attempt client factory may be used if pinned `http 1.6.0` cannot cancel one request;
- expected network/timeout/stream failures become closed typed outcomes;
- programming errors remain visible and are not swallowed by `catch Object`;
- coordinator always persists a truthful retryable/terminal state; it cannot remain `enrolling`;
- conflict and unavailable/unknown paths preserve facts, outbox and request identity;
- redirects, malformed/additional/missing fields and oversized bodies fail closed.

No Flutter/Drift schema migration, Auth0 SDK, callback, UI, platform channel or dependency upgrade is
authorized.

## 8. CP6 — Forward migration 006 exact readiness

Create exactly:

```text
services/markei_sync_api/migrations/006_hosted_authorization_r3.sql
```

Never edit migrations 001–005.

Migration 006 must:

- register its exact migration identity/checksum using the existing ledger convention;
- create `public.markei_hosted_runtime_ready()` with no caller arguments;
- return only a scalar boolean for the exact hosted R3 readiness condition;
- use migration-owner creation, `SECURITY DEFINER`, `STABLE`, fixed safe `search_path`, qualified
  references and no dynamic SQL;
- revoke execute from `PUBLIC`;
- grant execute only to `markei_runtime`;
- revoke runtime execute on `markei_required_migration_present(text)`;
- preserve runtime direct `migration_ledger` denial;
- apply ledger/DDL/ACL changes transactionally and roll back all on failure.

Update readiness code to call only the qualified no-argument function. Do not drop the old function;
an application rollback may coexist with forward migration 006 but may report not-ready.

Prove fresh 001→006, upgrade 001→005→006, duplicate apply, failure rollback, exact ledger row,
function body/owner/mode/ACL/search path, object shadowing, old-probe denial, direct-ledger denial and
ready/not-ready outcomes under distinct migrator/runtime roles.

## 9. CP7 — Deterministic authorization and enrollment barriers

Extend the disposable PostgreSQL/Fastify harness with test-only hooks or controlled barriers. No
production sleeps or timing guesses.

Required authorization races:

1. membership disable/remove against upload and download;
2. membership disable/remove against acknowledgement;
3. membership disable/remove against start/query/chunk/complete recovery routes;
4. external identity disable against a protected mutation;
5. actor Device revoke against every protected route class;
6. owner target revoke against concurrent owner/member status or revoke;
7. deterministic lock ordering and bounded serialization/deadlock retry/exhaustion.

Controlled identity/membership writers must acquire the migration-005 fence before update.

For each denied/losing path, query before/after state and prove no incorrect advancement of:

```text
facts/events
cursors/acknowledgements
rebootstrap sessions/progress
Device/enrollment state
security-event counts
```

Required enrollment cases:

- equivalent concurrent requests;
- same request identity with different hash;
- same installation with different request identities;
- response loss after commit followed by same-identity query/replay;
- restart after durable request state;
- cross-Account and unknown/revoked actor denial.

## 10. CP8 — Real Flutter HTTP and file-backed proof

Run the real `HttpDeviceEnrollmentTransport` against loopback Fastify. Use `LocalDatabase.file`, not
an in-memory-only repository or fake transport.

Prove:

- successful enrollment and equivalent query/replay;
- request bearer equals the coordinator's single token without logging it;
- HTTP 409 becomes conflict, never success;
- connection loss, header/body timeout and slow trickle beyond the absolute deadline close safely;
- malformed, additional/missing-field and oversized responses close safely;
- request cancellation and owned/borrowed client teardown are correct;
- a real pending outbox row and authoritative facts survive every failure;
- enrollment request identity/progress survives close/reopen;
- no local reset, reassignment or silent discard occurs.

## 11. CP9 — Truthful aggregation

Each TypeScript/PostgreSQL/JWT/Flutter producer owns and emits its own machine-readable case results.
One bounded local orchestrator may start disposable services and invoke producers.

It may print:

```text
R3_LOCAL_SECURITY_PROVED=true
```

only after every required case has executed and passed. A skip, unavailable toolchain, partial
matrix, missing case, timeout or producer failure must make the aggregate false and exit nonzero.

Direct service calls, fake Flutter transport, in-memory-only Drift or a hand-set boolean do not
satisfy the terminal gate.

## 12. Validation floor

Run and record exact commands, versions, counts and exclusions:

- TypeScript formatting, lint, typecheck, unit tests and build;
- npm audit with production dependencies;
- disposable dual-role PostgreSQL migrations, ACL/RLS/function and race harness;
- JWT/JWKS state suite;
- Dart formatting and Flutter analysis/tests;
- real Flutter HTTP/file-backed gate;
- Android debug and Windows release builds when host-supported;
- protected Python regression tests;
- aggregator terminal diagnostic;
- `git diff --check`;
- tracked/staged secret scan without printing secret values;
- disposable resource teardown.

Build success is not platform runtime acceptance. Provider proof remains absent.

## 13. File, report and publication discipline

- Keep handwritten files near 250 lines where practical; split by responsibility.
- No dependency or lockfile change without a direct compile/API proof that the pinned primitive is
  insufficient. Stop for Main rather than upgrading silently.
- Do not modify event v3, `c10b:*`, recovery format 1, hosted contract v1 or Drift v7.
- Do not edit A/B/C/J, permanent memory, methodology, Main-root files, provider helpers or UI.
- No unrelated formatting/cleanup.

After implementation, replace only:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

G must derive baseline/final SHA and changed paths from Git, list exact validation evidence and
teardown, and state whether every decisive producer ran. H and I follow E/F. Commit one bounded R3
unit and push only `intermid-cycle-recovery` without force.

Stop on contradiction among D/E/F, provider dependency, secret exposure, unsafe privilege, edits to
001–005, uncontrolled race proof, renewable timeout presented as absolute, hosted fallback still
representable, missing route rejection, unavailable decisive producer or scope expansion.
