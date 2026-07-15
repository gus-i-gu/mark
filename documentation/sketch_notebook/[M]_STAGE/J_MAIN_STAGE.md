# J_MAIN_STAGE — C10-S03A-R3 Post-Codex Reconciliation

> Sequence: FLX-ORD-01 Main reconciliation
> Branch: `intermid-cycle-recovery`
> Controlling D/E/F: `6fc8e8d783400397025337da13ae346fd2d843cc`
> Codex implementation: `a995bd1385d5754f0a278b05df1c1f8f8431ec45`
> Evidence: R3 G/H/I plus direct Git and source inspection
> Date: 2026-07-15
> Status: substantial R3 correction accepted; decisive local proof and contract closure incomplete

## 1. Methodology retained

Main recovered through:

```text
INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
```

Retained:

- G/H/I are observational evidence and cannot promote themselves.
- Git owns the exact changed-path and ancestry inventory.
- Repository inspection establishes implemented structure; named execution establishes only its
  stated environment and scope.
- Implemented, validated, partial, contradicted, host-unvalidated and provider-pending remain
  distinct.
- J may accept bounded progress while refusing a completion diagnostic.
- D/E/F at `6fc8e8d` authorized R3 only; further correction requires new Main authority.
- Provider proof, permanent-memory promotion and Cycle closure remain separate later sequences.

Round identity:

```text
R3 investigation/reconciliation 421d794
R3 D/E/F authority              6fc8e8d
R3 partial implementation       a995bd1
R3 decisive proof               absent
```

The next eligible unit is a completion sub-round, `C10-S03A-R3B`, not provider proof and not a
claim that R3 already succeeded.

## 2. Ancestry and exact delta

The controlling authority is an ancestor of the implementation:

```text
6fc8e8d → a995bd1
```

Git reports exactly 17 changed paths:

```text
clients/markei_flutter/lib/application/hosted_auth_ports.dart
clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart
clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart
clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
services/markei_sync_api/migrations/006_hosted_authorization_r3.sql
services/markei_sync_api/src/application/hosted_authorization.ts
services/markei_sync_api/src/application/jwt_verifier.ts
services/markei_sync_api/src/hosted.ts
services/markei_sync_api/src/hosted_local_harness.ts
services/markei_sync_api/src/http/app.ts
services/markei_sync_api/src/lab.ts
services/markei_sync_api/src/main.ts
services/markei_sync_api/test/hosted_auth.test.ts
services/markei_sync_api/test/protocol.test.ts
```

G's path list matches Git. G leaves Final SHA pending; the authoritative Final SHA is `a995bd1`.
No dependency/lockfile, migration 001–005, permanent memory, methodology, A/B/C, D/E/F or prior J
file was changed by Codex.

## 3. Codex result accepted

G/H/I report:

```text
C10-S03A_R3_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

The hosted-local producer truthfully reports:

```text
AUTHORIZATION_RACE_MATRIX=partial
ROUTE_AUTHORIZATION_INVENTORY=true
LEAST_PRIVILEGE_HTTP=true
R3_LOCAL_SECURITY_PROVED=false
```

No aggregator emitted the forbidden success diagnostic. Main accepts this classification.

## 4. Bounded progress accepted

### 4.1 Migration 006

Implemented:

- forward migration identity `006_hosted_authorization_r3`;
- checksum `c10-s03a-r3-hosted-authorization-v1`;
- no-argument `public.markei_hosted_runtime_ready()`;
- static, `SECURITY DEFINER`, `STABLE`, fixed search path and qualified ledger reference;
- `PUBLIC` execute revocation and runtime-only execute grant;
- runtime execute revocation on `markei_required_migration_present(text)`;
- readiness calling only the new qualified capability.

The hosted-local lab reports readiness success, direct-ledger denial and old-probe denial under the
runtime role. Main accepts this as a locally validated subset. Complete fresh/upgrade/duplicate/
rollback/owner/shadowing evidence remains absent from G.

### 4.2 Hosted composition

`buildApp` now accepts one discriminated `AuthorizationComposition`:

```text
hosted  → identityService + transactionAuthorizer
fixture → verifier
disabled
```

Hosted protected operations dispatch through `HostedTransactionAuthorizer`; the independently
optional hosted-authorizer fallback was removed. Composition roots were updated without dependency
changes. This source correction is accepted.

### 4.3 Device actor/target separation

Source now:

- authorizes an identity-bound active actor;
- locks actor/target Device and enrollment rows in stable UUID order;
- permits a locked target snapshot to contain active or revoked state;
- conditionally changes enrollment/Device state and inserts one event;
- returns duplicate-equivalent for an already-revoked target while the actor remains authorized;
- denies the actor after self-revoke.

This implements the selected scoped-idempotence structure. Sequential source/harness evidence is
accepted; concurrency, one-event and full owner/member/self semantics remain unproved.

### 4.4 Route architecture subset

Typed descriptors and Fastify `onRoute` capture now exist. Current construction compares actual
method/path registrations with descriptors, handles the two health routes and normalizes automatic
HEAD. A unit test injects one direct unclassified route and observes rejection.

This is meaningful implementation and a validated direct-injection subset. It is not yet the full
structural guarantee; see Section 5.

### 4.5 JWKS architecture subset

Source adds:

- deterministic canonical hashing;
- semantic revision separate from cache timestamps;
- `changed | unchanged | stale-retained` refresh outcomes;
- per-key negative state;
- global failed-refresh cooldown;
- coalesced refresh and retained `jose` cryptography.

This is accepted as implemented structure. The current tests largely retain the earlier JWT subset
and do not prove the complete R3 state matrix. Direct inspection found remaining transitions in
Section 5.

### 4.6 Flutter architecture subset

The transport port now returns closed result classes, and the coordinator handles success,
conflict, unavailable and unknown outcomes without raw HTTP exceptions. The HTTP adapter bounds
response bytes, refuses redirects, computes a deadline, translates common timeout/client failures
and keeps one credential per attempt.

This is accepted as partial structure only. The real HTTP/file-backed proof is absent and direct
inspection found contract gaps in Section 5.

### 4.7 Reported validation

G records:

- TypeScript format/lint/typecheck/build passed;
- 22 TypeScript tests passed;
- npm audit passed with zero production vulnerabilities;
- disposable hosted-local harness completed with partial diagnostics;
- Dart format and Flutter analysis passed;
- 56 Flutter tests passed with two lab-gated skips;
- Android debug and Windows release builds passed;
- five protected Python tests passed;
- `git diff --check` passed;
- no provider/private helper access occurred.

Main accepts these as reported local/build evidence. Builds do not establish platform runtime or
provider acceptance.

## 5. Remaining source contradictions

The result is partial for code reasons as well as missing system proof.

### 5.1 Flutter deadline is not absolute and request cancellation is absent

`HttpDeviceEnrollmentTransport._send` computes one deadline, but then applies:

```text
client.send(...).timeout(remaining)
stream.timeout(remaining-computed-once)
```

Dart `Stream.timeout` is an inactivity/inter-event timeout; each arriving chunk renews the wait. A
slow trickle can therefore exceed the intended total attempt deadline. `Future.timeout` also stops
waiting without proving cancellation of the underlying `Client.send` request.

This contradicts D/E/F:

- one deadline across connect, headers and complete body;
- slow chunks cannot renew it;
- expiry cancels request-owned resources;
- borrowed client remains usable.

R3B must use remaining-deadline checks for the full operation plus a compile-proven cancellation or
owned-per-attempt client mechanism, and prove it against a slow loopback response.

### 5.2 Flutter closed semantics lose information and replay persistence

The server success body accepts both `device-enrolled` and `duplicate-equivalent`, but
`DeviceEnrollmentResult` does not retain that status. `_decode` maps both to
`DeviceEnrollmentTransportSuccess`, and the coordinator reports `applied`. The required closed
`duplicate-equivalent` transport meaning is therefore erased.

In `replay`, conflict/unavailable/unknown outcomes are returned without saving the corresponding
durable state. A state left as `enrolling` by interruption may remain `enrolling` after a known
replay outcome.

R3B must preserve the server success variant and persist every replay outcome truthfully without
altering facts/outbox/request identity.

### 5.3 JWKS unknown-key pressure is still incomplete

Three transitions remain inconsistent with D/F:

1. when an expired cache refreshes and the requested key is absent, `getKey` performs another
   refresh immediately; the request can cause two eligible fetches;
2. when the semantic key set changes but still lacks the requested key, no negative cooldown is
   installed because the code only sets it when outcome is not `changed`;
3. the revision hashes every object field after validating mainly `kid`, rather than a closed set of
   accepted public JWK fields; irrelevant/unaccepted metadata can appear as semantic key rotation.

R3B must permit at most one eligible unknown-key refresh per lookup, install cooldown whenever the
requested key remains absent after that refresh, and fingerprint a closed normalized public-key
shape. Add named frozen-clock tests for each transition.

### 5.4 Route inventory is a construction-time snapshot

`assertFastifyRouteInventory` runs inside `buildApp` immediately after current synchronous
registrations. It catches the injected direct test route, but callers can register another route
after `buildApp` returns, and encapsulated plugin routes may materialize during Fastify readiness
after the assertion has already run.

The current implementation therefore proves current synchronous registration, not that every route
present at readiness is classified. R3B must place the exact comparison at/after the relevant
Fastify readiness boundary and prove rejection of a plugin/late-added route, without parsing
`printRoutes()`.

### 5.5 Device status reports enrollment state instead of Device state

The locked snapshot contains both `deviceStatus` and `enrollmentState`, but `deviceStatus()` returns
`target.enrollmentState`. The selected public target status was active/revoked Device state. This is
currently equivalent after ordinary atomic transitions, but it admits the unrelated `replaced`
enrollment value and leaves the API meaning ambiguous.

R3B must return the selected Device status or explicitly prove/reconcile a different closed API
contract. Do not introduce replacement/reactivation behavior.

## 6. Decisive evidence still absent

Even after source correction, completion still requires:

1. membership disable/remove barriers against upload, download and acknowledgement;
2. membership disable/remove against capabilities and every rebootstrap route;
3. external identity disable against a protected mutation;
4. actor Device revoke against every protected operation class;
5. owner/member target status/revoke races, scoped repeat and exactly one event;
6. equivalent/conflicting enrollment concurrency, response loss, query/replay and restart;
7. complete denied-no-state-advance checks for facts/events, cursors/acks, recovery sessions,
   Device/enrollment state and security-event counts;
8. complete migration-006 fresh/upgrade/rollback/owner/ACL/shadowing probes;
9. complete JWT rotation/outage/stale-expiry/unknown-pressure suite;
10. real `HttpDeviceEnrollmentTransport` against loopback Fastify;
11. file-backed Drift with a real pending outbox row, facts and close/reopen;
12. one aggregator that remains false for any skipped, partial, unavailable or failed producer.

## 7. PRC-01 reconciliation

| Claim | State after Main reconciliation |
| --- | --- |
| migration 006 exists | implemented |
| exact readiness function shape | implemented; locally validated subset |
| complete migration-006 lifecycle/ACL proof | incomplete |
| hosted/fixture/disabled composition | implemented; typecheck/build reported passed |
| hosted fallback removed | implemented |
| actor/target separation | implemented; sequential subset reported validated |
| scoped revoke idempotence/one event | implemented structure; concurrency proof absent |
| current synchronous route inventory | implemented; direct injected-route test passed |
| readiness-time/plugin route completeness | contradicted/incomplete |
| semantic JWKS revision structure | implemented |
| complete unknown-key pressure policy | contradicted/incomplete |
| closed Flutter result structure | implemented partially |
| duplicate-equivalent transport semantics | contradicted/incomplete |
| absolute cancellable Flutter deadline | contradicted/incomplete |
| real Flutter HTTP/file-backed preservation | not implemented |
| deterministic authorization race matrix | incomplete |
| truthful R3 aggregate | correctly false |
| dependency upgrade required | not supported |
| provider proof | not performed/unauthorized |

## 8. Main decision and next unit

Main accepts `a995bd1` as substantial bounded R3 progress and rejects local-security completion.

The next eligible unit is:

```text
C10-S03A-R3B — Local Contract and Decisive-Proof Completion
```

R3B must remain one local correction/proof unit. It must:

1. close the five source contradictions in Section 5;
2. complete the twelve evidence groups in Section 6;
3. correct G's Final SHA and derive its path inventory from Git;
4. emit `R3_LOCAL_SECURITY_PROVED=true` only when every producer passes;
5. otherwise report R3B partial with the exact missing case.

Main must replace D/E/F before Codex begins R3B. A/B/C may be reused with this J; another broad
domain investigation is unnecessary unless D/E/F expose a new architectural contradiction.

No dependency upgrade, provider SDK, UI, Drift schema change, migration 007, edit to migrations
001–006, permanent-memory promotion or unrelated refactor is currently indicated.

## 9. Provider and credential-containment boundary

No Auth0, Neon or Render proof occurred. Migration 006 has not been applied to Neon. MCG-02 remains
pending.

Before any provider proof, separately complete:

- rotate the exposed Neon migrator/runtime passwords;
- replace any copied runtime credential in provider configuration;
- remove private helper/editor files from Git tracking and restore ignore rules;
- assess reachable history without reproducing secrets;
- perform separately authorized history removal only if committed secret material requires it.

Credential containment is not R3B implementation evidence.

## 10. Terminal status

```text
C10-S03A_R3_PARTIAL_ACCEPTED
C10-S03A_R3B_RESTAGING_REQUIRED
R3_LOCAL_SECURITY_PROVED=false
DEPENDENCY_UPGRADE_NOT_INDICATED
CREDENTIAL_ROTATION_AND_REPOSITORY_CONTAINMENT_REQUIRED
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Confidence is high for Git inventory, missing decisive evidence and the Flutter/JWKS source
contradictions; medium-high for the Fastify readiness-boundary finding pending an implementation
test against the pinned Fastify lifecycle; medium-high for Device status semantic drift because
ordinary atomic state currently keeps Device and enrollment status aligned.
