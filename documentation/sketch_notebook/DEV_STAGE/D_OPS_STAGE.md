# D_OPS_STAGE — C10-S03A-R3B Operational Materialization Authority

> Sequence: FLX-ORD-01
> Branch: `intermid-cycle-recovery`
> Controlling Main reconciliation: `2468c3912f1d0f3582e5eb241f104226b14c876f`
> Accepted implementation baseline: `a995bd1385d5754f0a278b05df1c1f8f8431ec45`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: local contract correction and decisive proof only

## 1. Objective and terminal condition

Complete the five R3 source contradictions and the missing decisive evidence without reopening the
accepted architecture:

```text
absolute cancellable Flutter attempt
+ lossless durable enrollment outcomes
+ bounded normalized JWKS refresh behavior
+ readiness-time exact route inventory
+ Device status semantic correction
+ complete local authorization/migration/HTTP/file-backed proof
```

Success requires every named producer to pass and the aggregate to emit:

```text
R3_LOCAL_SECURITY_PROVED=true
C10-S03A_R3B_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

If any case is failed, skipped, unavailable, partial or host-unvalidated, emit:

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3B_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Report the exact missing producer/case. Never infer success from test counts or builds.

## 2. Repository and security safety

Before editing:

1. read root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, then
   `METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL`;
2. read J at `2468c39` and this D/E/F together;
3. fetch and pull `intermid-cycle-recovery` fast-forward-only;
4. confirm `2468c39` is an ancestor of HEAD;
5. inspect status and stop on divergence, conflicts or dirty overlap;
6. preserve unrelated and untracked files;
7. never stash, reset, clean, discard, overwrite or force-push.

Never read or modify:

```text
.vscode/settings.json
documentation/NEON_DOC.md
documentation/NEON_SESSION.ps1
secret-bearing provider files
```

No Auth0, Neon, Render, deployment, provider credential or public endpoint use is authorized.
Use synthetic identities/facts and loopback disposable services only.

## 3. Retain accepted R3 structure

Preserve unless a narrow correction below requires a local change:

- migration 006 and its exact readiness function;
- hosted/fixture/disabled authorization composition;
- identity/membership transaction fence;
- actor/target Device separation and stable locking;
- scoped repeat-revoke semantics and one transition event;
- typed route descriptors and `onRoute` capture;
- `jose` cryptographic verification;
- closed Flutter transport result family;
- event v3, `c10b:*`, recovery format 1, enrollment contract v1 and Drift v7.

Do not add migration 007, edit migrations 001–006, change Drift schema, add provider SDKs, redesign
UI or perform broad refactoring.

## 4. CP1 — Absolute Flutter deadline and cancellation

Correct `HttpDeviceEnrollmentTransport` so one monotonic deadline covers:

```text
request start → connection → response headers → complete bounded body
```

Requirements:

- calculate one deadline at attempt start;
- recompute remaining duration before each asynchronous phase and body read;
- reject when the total deadline expires even if chunks keep arriving;
- do not use a renewable stream inactivity timeout as the total deadline;
- on expiry, cancel request-owned work by closing a per-attempt owned `http.Client` or another
  compile-proven cancellation primitive;
- a caller-borrowed client must never be closed;
- do not claim borrowed-client cancellation unless the pinned API proves it;
- late transport completion must not mutate coordinator/repository state;
- body ceiling, redirect refusal and malformed-response handling remain closed.

Preferred bounded mechanism: inject a client factory for hosted attempts; create and close one
owned client per attempt. If an existing borrowed-client constructor remains for unit tests, its
ownership limits must be explicit and it cannot satisfy the decisive cancellation claim.

Prove with loopback HTTP:

- response before deadline succeeds;
- headers stall past deadline;
- body trickles below inactivity thresholds but exceeds total deadline;
- oversized body fails;
- redirect fails;
- timeout closes request-owned resources;
- borrowed client remains usable after failure;
- no late state change occurs.

If the pinned `package:http` API cannot implement a truthful cancellation boundary without a
dependency change, stop and report the compile/runtime evidence. Do not upgrade silently.

## 5. CP2 — Lossless enrollment outcomes and durable replay state

Preserve the server success variant through the transport and coordinator:

```text
device-enrolled
duplicate-equivalent
```

The generic transport-success type must carry a closed success status or use two distinct success
types. The coordinator must return `applied` only for `device-enrolled` and
`duplicate-equivalent` only for that server result.

For first attempt and replay, persist a truthful terminal/recoverable state for every known result:

```text
device-enrolled
duplicate-equivalent
conflict
unavailable
unknown-outcome
```

Requirements:

- replay conflict/unavailable/unknown must not leave durable state as `enrolling`;
- request identity remains unchanged across query/replay;
- local facts, outbox rows and cursors remain unchanged by enrollment failures;
- interrupted/unknown outcomes remain queryable and never become success by inference;
- malformed or unrecognized server success status becomes `unknown-outcome`, not success;
- close/reopen reproduces the same stored meaning.

Use the existing Drift v7 persistence model. No schema change is authorized.

## 6. CP3 — Bounded normalized JWKS behavior

Retain `jose` for signature and claim verification. Correct only Markei-owned retrieval/cache state.

For one `getKey(kid)` lookup:

- permit at most one eligible network refresh;
- if expired cache refresh already occurred, do not immediately refresh again for the same miss;
- whenever the requested key is absent after the eligible refresh, install its negative cooldown,
  including when another key changed the semantic revision;
- failed refresh uses global failed-refresh cooldown;
- stale known keys may be retained only within the accepted stale window;
- stale/unknown keys never authorize a token.

Normalize each accepted signing key to a closed public RSA/RS256 projection equivalent to:

```text
{ kty, kid, use, alg, n, e }
```

Validate bounded strings, unique non-empty `kid`, `kty=RSA`, `use=sig`, `alg=RS256`, and required
public modulus/exponent. Reject private key material and malformed/duplicate entries. Fingerprint
only the normalized projection in deterministic order. Irrelevant provider metadata must not alter
semantic revision; genuine public-key changes must.

Named frozen-clock tests must cover:

- expired cache miss performs one fetch, not two;
- changed set still missing requested `kid` installs cooldown;
- irrelevant metadata does not rotate revision;
- genuine `n`/`e` or key membership change rotates revision;
- concurrent same-key misses coalesce;
- different unknown keys remain bounded;
- outage cooldown and retry after expiry;
- stale known-key boundary and stale expiry;
- malformed, duplicate, private or non-RS256 key rejection.

## 7. CP4 — Readiness-time exact route inventory

Move the exact route comparison to Fastify's readiness lifecycle after registered plugins/routes
have materialized. Keep root `onRoute` capture installed before application/plugin registration.

Requirements:

- `app.ready()`, `app.listen()` and `app.inject()` cannot proceed when inventory is invalid;
- all current non-health method/path registrations exactly match typed descriptors;
- automatic HEAD and the two health routes are handled only by explicit normalization;
- unexpected, missing, duplicate, wrong-operation or wrong-class routes reject readiness;
- a route registered directly after `buildApp` but before readiness is detected;
- a route registered through an encapsulated plugin is detected;
- no `printRoutes()` parsing and no second parallel expected-route constant;
- ordinary valid construction still proves the expected current inventory.

Use a readiness hook or equivalent pinned-Fastify mechanism. Tests must await readiness/injection;
a construction-time-only assertion is insufficient.

## 8. CP5 — Device status semantic correction

`deviceStatus()` must return the locked target Device state:

```text
active | revoked
```

It must not return enrollment state. `replaced` remains an enrollment-only value and must never
appear as public Device status. Preserve owner/member target policy, non-enumerating denial and the
existing revoke transaction. Do not add replacement or reactivation behavior.

Prove active target, revoked target, deliberately divergent fixture state, member self-target,
owner other-target and denied foreign/cross-Account cases.

## 9. CP6 — Deterministic authorization and race matrix

Extend the disposable PostgreSQL/loopback harness with deterministic barriers, not timing sleeps.
Prove every protected operation class:

```text
upload
download
acknowledgement
capabilities
rebootstrap start
rebootstrap status
rebootstrap chunk
rebootstrap complete
Device status
Device revoke
```

Required barriers/races:

- membership disabled before authorization lock;
- membership removed before authorization lock;
- external identity disabled before protected mutation;
- actor Device revoked before each operation class;
- owner and member target status/revoke policy;
- concurrent equivalent enrollment identities;
- conflicting enrollment identity/hash;
- response loss followed by query/replay and process restart;
- concurrent target revoke produces one transition and exactly one event;
- scoped repeat by an independently active authorized actor is duplicate-equivalent;
- self-revoked actor is denied on subsequent work.

For every denial compare before/after snapshots of:

```text
facts and events
cursors and acknowledgements
recovery sessions/chunk progress
Device and enrollment rows
security-event count
```

Denied work must advance none of them. SQL errors must fail closed and roll back.

## 10. CP7 — Migration 006 proof without migration edits

Do not edit migrations 001–006. Prove the existing migration 006 against disposable PostgreSQL:

- fresh `001→006`;
- upgrade `001→005`, then 006;
- duplicate runner/ledger behavior;
- failure rollback on a disposable modified copy while originals remain unchanged;
- function owner and `SECURITY DEFINER`, `STABLE`, no-arg shape;
- fixed search path and qualified ledger lookup;
- `PUBLIC` denial;
- runtime execute only on `markei_hosted_runtime_ready()`;
- runtime denial on old parameterized probe and direct ledger;
- migrator/owner expected authority;
- hostile temp/public shadow objects do not affect result;
- absent/tampered ledger state returns false or fails closed as specified.

If the existing migration fails, report the contradiction to Main. Migration 007 and edits to 006
remain unauthorized.

## 11. CP8 — Real Flutter HTTP/file-backed proof

Run the actual `HttpDeviceEnrollmentTransport` against loopback Fastify and a real file-backed
Drift v7 database.

The fixture must contain:

- one synthetic Account and local identity;
- authoritative local facts;
- one real pending outbox event;
- one durable enrollment request identity/state.

Prove:

1. enrollment success and duplicate-equivalent remain distinct;
2. conflict, unavailable, malformed response, timeout and unknown outcome are persisted truthfully;
3. response loss supports query/replay with the same request identity;
4. close/reopen preserves facts, outbox, request identity and outcome;
5. no token is persisted or logged;
6. provider/API unavailability does not prevent ordinary local registration;
7. slow-trickle deadline and request-owned cancellation pass.

Direct repository fakes or in-memory-only Drift do not satisfy this gate.

## 12. CP9 — Truthful aggregation

Create or finish one local orchestrator that consumes explicit machine-readable results from:

- TypeScript/JWT/route tests;
- migration/ACL probes;
- authorization/race harness;
- Flutter HTTP/file-backed harness;
- relevant static/build checks.

The aggregate is true only when every required producer and named case is present and true. Missing,
skipped, malformed, partial, unavailable or false input makes it false and identifies the blocker.
Do not infer producer success from process exit alone.

## 13. Validation floor

Run all applicable checks and record exact commands, environment, counts and exclusions:

- TypeScript format, lint, typecheck, tests and build;
- `npm audit --omit=dev`;
- migration/ACL and hosted-local decisive harness;
- Dart format and Flutter analysis/tests;
- real Flutter HTTP/file-backed lab gate;
- Android debug and Windows release builds when host-supported;
- protected Python regressions;
- `git diff --check`;
- tracked/staged secret scan without opening excluded private files;
- disposable resource teardown.

A build is not runtime acceptance. Host-unvalidated is not pass or product failure.

## 14. Reports, file discipline and publication

After implementation replace only:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

G must derive baseline/final SHA and changed paths from Git and include the full producer matrix,
migration/ACL evidence, race counts, Flutter file path type (not secret path), teardown and exact
blockers. H must record closed meanings and named semantic tests. I must record final dependency
direction, deadline/cancellation ownership, JWKS state, readiness inventory and deviations.

Keep handwritten files near 250 lines where practical; split source/tests by responsibility. Do not
modify methodology, permanent memory, A/B/C, J, D/E/F, Main-root continuity or unrelated files.

Review the full diff, commit one bounded R3B unit and push only `intermid-cycle-recovery` without
force. No success diagnostic is permitted unless CP1–CP9 all pass.

## 15. Stop conditions

Stop before mutation or completion claim if:

- D/E/F contradict each other or current J;
- a dependency upgrade, migration change, provider action or secret access appears necessary;
- deterministic proof cannot observe a required state boundary;
- an unrelated dirty change overlaps the task;
- any decisive producer remains skipped or partial.

Partial implementation may be committed only with truthful R3B partial diagnostics and the exact
remaining evidence boundary.
