<!-- TEMPORAL_MARKER:C10-S03A-R3-OPERATIONAL-INVESTIGATION-2026-07-15 -->
# A_OPERATIONAL — C10-S03A-R3 Local Correction and Proof

Sequence: FLX-INV-02
Role: Operational [O]
Branch: `intermid-cycle-recovery`
Inspected HEAD: `06d694aa8fb88a43c47fca3eccd02c909c193f2f`
R2 implementation: `032e13ae7c19f2639d2a60ff6c12c6104c59fd54`
Evidence date: 2026-07-15
Status: PROVISIONAL, local-only investigation for Main; not Codex authority

## 1. Boundary and evidence

Required methodology and current J/D/E/F/G/H/I were read. J accepts R2 only as partial and requires
new D/E/F before implementation. This round inspected project-owned code/tests behind every J
contradiction and proof gap. No source, provider, credential, permanent memory or prior migration was
modified or contacted.

Classification vocabulary:

- **project code**: behavior/API in repository source;
- **DB contract**: forward SQL, ACL, lock or schema behavior;
- **dependency/toolchain**: host or third-party execution constraint;
- **missing evidence**: required assertion/proof producer does not exist, independent of code presence.

## 2. Current call paths

```text
hosted.ts
  -> buildApp(auth, hosted?, hostedAuthorizer?, database)
  -> protectedOperation
  -> hostedAuthorizer.authorizeOperation OR auth.verify + later transaction

Device status/revoke route
  -> HostedIdentityService.deviceStatus/revoke
  -> resolveOneMembership -> migration-005 authorization fence
  -> authorizeActorAndTargetDevice -> target action

JWT verify -> BoundedJwksSource.getKey -> refresh -> fetchAndCache

Flutter coordinator -> DeviceEnrollmentTransport.enroll/query
  -> HttpDeviceEnrollmentTransport._send -> _decode
  -> DriftHostedIdentityRepository.save

/health/ready -> readyStatus
  -> markei_required_migration_present($1)
```

## 3. R2 contradictions and minimal R3 options

### O1 — Revoked targets are rejected before idempotent handling

Classification: **project code**, with a DB-proof consequence.

Evidence: `hosted_authorization.ts:219-295,357-405`. `authorizeActorAndTargetDevice` requires both
actor and target `devices.status='active'`. Therefore a second revoke and owner status read of a
revoked target fail before the guarded update at lines 268-292. The update/event pattern itself can
emit one event when all writers share the locked transition.

Minimal R3 option:

1. keep the actor enrollment and actor Device strictly active;
2. require only same-Account target existence for status/revoke;
3. return a closed terminal result when the locked target is already revoked;
4. update Device + enrollment and insert the event only for the locked active-to-revoked transition.

Decision needed: blanket replay of self-revoke conflicts with “actor must be active,” because after
self-revoke actor and target are the same revoked Device. Main must scope idempotency to an active
actor replaying a target revoke (minimal), or authorize a separate request-idempotency record/explicit
self-replay exception. Do not silently weaken actor authentication. Validate owner/member, distinct
and self target, sequential/concurrent repeats, status-after-revoke, and exactly one event.

Risk/confidence: high-confidence defect; medium risk until self-revoke replay semantics are frozen.

### O2 — Hosted authorization is optional at the composition boundary

Classification: **project code**.

Evidence: `http/app.ts:136-142,249-495`. `buildApp` accepts `auth`, `hosted` and optional
`hostedAuthorizer` independently; `protectedOperation` falls back to precommitted `auth.verify`.
`hosted.ts:28-33` is safe today, but the API permits a future hosted bypass.

Minimal R3 option: replace the option bag with a discriminated union or separate builders:

```text
fixture composition -> AuthVerifier, no HostedIdentityService/HostedTransactionAuthorizer
hosted composition  -> HostedIdentityService + HostedTransactionAuthorizer, no fallback verifier
```

Keep one shared route implementation if useful, but select authorization by a required composition
kind, not presence detection. Update `hosted.ts`, `main.ts`, `lab.ts`, harnesses and tests. Validate a
compile-time negative hosted-without-authorizer case plus runtime fixture/hosted route tests.

Risk/confidence: high confidence; low-medium refactor risk across three composition roots.

### O3 — Inventory proves described routes exist, not that all actual routes are described

Classification: **project code**; no dependency mismatch established.

Evidence: `http/app.ts:146-149,172-478,554-582`. The descriptor array drives the current 13 routes,
and `hasRoute` checks each one. Health routes are registered outside it. Nothing rejects a later
`app.get/post` or plugin route not present in `routes`; `hosted_auth.test.ts:225-244` compares only a
hard-coded operation list to the exported descriptors.

Minimal R3 option: install a synchronous Fastify `onRoute` inventory guard before registration and
route health plus application endpoints through one private registration wrapper. The guard records
method/path and rejects any non-health route registered without exactly one policy descriptor.
Validate duplicate method/path, wrong operation, missing classification and an injected extra route.

Risk/confidence: high confidence; medium risk around Fastify-generated HEAD/plugin routes, which
must be explicitly normalized rather than ignored broadly.

### O4 — Unknown-key throttling uses timestamps instead of key-set identity

Classification: **project code**.

Evidence: `jwt_verifier.ts:121-145,148-190`. A forced successful refresh always changes
`freshUntil`, so an unchanged JWKS deletes the negative `kid` entry. A second defect is visible:
`force:true` bypasses `nextRefreshAfter`, so distinct unknown keys can bypass the global cooldown
after a failed refresh.

Minimal R3 option: make `fetchAndCache` produce a stable, order-independent key-set revision and make
`refresh` return `changed | unchanged | stale-retained`. Set per-`kid` cooldown after unchanged or
stale-retained refresh; clear relevant negatives only on genuine key-set change; never let forced
unknown-key refresh bypass an active failure cooldown. Keep `jose` for cryptography.

Validate frozen-clock fresh/stale/final-expiry transitions, unchanged unknown-key burst, distinct-kid
failure pressure, coalescing, timeout/abort, duplicate `kid`, outage/recovery and genuine rotation.

Risk/confidence: high confidence for both defects; medium implementation risk in canonical key-set
identity and concurrent refresh state.

### O5 — Flutter transport has neither typed closure nor one absolute deadline

Classification: **project code**, **missing evidence**, and one bounded dependency API question.

Evidence: `http_device_enrollment_transport.dart:67-93` lets `TimeoutException`,
`http.ClientException` and send/stream errors escape. It applies separate send and inter-chunk
timeouts, allowing a slow stream to exceed the intended total. `hosted_enrollment_coordinator.dart:
55-76,95-117` catches only typed enrollment exceptions, so enroll may remain durably `enrolling`.
The replay path also does not close a possible `DeviceEnrollmentConflict`.

Minimal R3 option: enforce one deadline around send plus bounded body consumption, translate expected
network/timeout/abort failures to a typed unknown/unavailable outcome, and preserve programming
errors. Ensure the deadline cancels or closes the underlying request, not only the waiting Future;
retain explicit owned/borrowed client lifecycle. Confirm the pinned `http 1.6.0` abort API during
materialization; dependency source was unavailable because Flutter SDK/cache is absent here. No
dependency version change is currently justified.

Validate with the real transport against loopback Fastify: success/replay, 409, connection failure,
absolute slow-trickle deadline, malformed/oversized body, bearer-token equality and teardown.

Risk/confidence: high-confidence project defect; medium risk around cancellation of a borrowed client.

### O6 — Readiness accepts a caller-selected migration identifier

Classification: **DB contract** plus **project code**.

Evidence: migration `005_hosted_authorization_fence.sql:48-67` grants runtime execute on
`markei_required_migration_present(text)`; `http/app.ts:509-519` supplies the current identifier.
Runtime can probe any migration id, contrary to the selected exact-capability contract.

Minimal R3 option: additive migration 006 only:

- create a no-argument, security-definer exact hosted-readiness function with qualified objects,
  bounded boolean output, fixed safe search path, `PUBLIC` revoked and runtime execute only;
- revoke runtime execute on the migration-005 arbitrary probe without editing 005;
- update `readyStatus` to invoke the qualified no-argument function.

Validate fresh 001→006 and 001→005→006, ledger/ACL/function owner/mode/search-path/object-shadowing,
exact ready/not-ready and denial of direct ledger plus arbitrary probe. Risk: an R2 binary against a
006 database becomes not-ready after the old execute grant is revoked; future deployment/rollback
ordering must acknowledge this. Confidence: high.

## 4. Decisive proof still absent

Classification: **missing evidence**, requiring bounded project test/harness code; it is not a
provider or dependency requirement.

Current evidence boundaries:

- `hosted_local_harness.ts:71-188` is sequential and truthfully prints
  `AUTHORIZATION_RACE_MATRIX=partial` and `R2_LOCAL_SECURITY_PROVED=false`;
- `hosted_auth.test.ts` covers a JWT subset and descriptor constant only;
- Flutter `hosted_identity_repository_test.dart` uses in-memory Drift and a fake transport;
- no test-only barrier/hook, file-backed hosted HTTP proof or cross-producer aggregator exists.

Minimal proof architecture:

1. add deterministic authorization-phase hooks/barriers (no sleeps) and controlled
   identity/membership writers that acquire the migration-005 fence in the same transaction;
2. cover disable/remove and actor revoke against upload, download, acknowledgement and all five
   recovery operations, with bounded waits and commit-order assertions;
3. snapshot submissions/events/cursors/acks/rebootstrap sessions/security-event counts before and
   after every denied path;
4. cover concurrent equivalent/conflicting enrollments, installation/request permutations, response
   loss, query/replay and process restart;
5. add migration-005/006 owner, ACL, denial and shadowing probes;
6. run a real `HttpDeviceEnrollmentTransport` against loopback Fastify with
   `LocalDatabase.file`, a real pending outbox row, close/reopen and fact/outbox equality;
7. add one aggregator that executes TypeScript, disposable PostgreSQL and Flutter producers and emits
   the R3 success diagnostic only after consuming each successful exit/result. Each producer retains
   its own truthful diagnostic ownership.

PostgreSQL serializable retry already exists in `postgres/database.ts:16-54`; tests must tolerate a
bounded retry while still proving lock order. Existing Drift file/outbox test helpers can be reused;
no Drift schema/version change is indicated.

## 5. Candidate R3 file surface

Smallest expected source/test surface for Main to freeze:

```text
services/markei_sync_api/migrations/006_<exact_readiness>.sql
services/markei_sync_api/src/application/hosted_authorization.ts
services/markei_sync_api/src/application/jwt_verifier.ts
services/markei_sync_api/src/http/app.ts
services/markei_sync_api/src/{hosted,main,lab,hosted_local_harness}.ts
services/markei_sync_api/test/hosted_auth.test.ts
services/markei_sync_api/package.json                         (aggregator/script only if selected)
clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart
clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart
clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart
```

`hosted_auth_ports.dart` needs change only if Main selects richer typed failure values.
Do not edit migrations 001–005, generated Drift files, permanent notebook memory or provider files.

## 6. Validation and host state

Investigation rerun attempt:

```text
node v24.14.0 / npm 11.9.0
npm test -> host-unvalidated: node_modules absent; tsx ERR_MODULE_NOT_FOUND
flutter --version -> host-unvalidated: flutter command absent; .dart_tool absent
```

These are toolchain/setup blockers, not product failures and not evidence against G's recorded R2
run. Before R3 validation, restore pinned dependencies in a clean local environment, then run the
D/E/F floor: format/lint/typecheck/unit/build/audit; fresh+upgrade disposable dual-role PostgreSQL
harness; race/enrollment/JWT gates; real Flutter HTTP/file-backed gate; Flutter analysis/tests/builds;
Python tests; secret-safe diff scan; teardown; `git diff --check`. No gate may print true when its
producer is skipped, host-blocked or partial.

## 7. Operational recommendation and stop rules

Recommended order:

```text
R3A: freeze self-revoke semantics + migration 006 + composition/route/revoke corrections
R3B: JWT state fix + deterministic PostgreSQL race/enrollment/ACL proof
R3C: absolute Flutter transport closure + real HTTP/file-backed proof
R3D: aggregator + complete local validation and exact G/H/I inventory
```

Stop on unresolved self-revoke semantics, privilege broadening, mutation of 001–005, non-cancelling
deadline presented as bounded, nondeterministic race proof, unavailable decisive producer, provider
dependency, or any secret exposure. R3 remains local-only: no Auth0/Neon/Render contact, deployment,
provider SDK, MCG-03/04, permanent-memory promotion or Cycle closure.

Recommended Main state:

```text
C10-S03A_R3_PROVISIONAL_INVESTIGATION_COMPLETE
C10-S03A_R3_RESTAGING_REQUIRED
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Confidence: high for project-code and DB-contract causes; high for the missing-evidence inventory;
medium for the exact Flutter cancellation mechanism until the pinned dependency API is available;
medium for a blanket idempotency claim until Main resolves self-revoke replay.
