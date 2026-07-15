# J_MAIN_STAGE — C10-S03A-R2 Post-Codex Reconciliation

> Sequence: FLX-ORD-01 Main reconciliation
> Branch: `intermid-cycle-recovery`
> Controlling stage: `812a19842bfa3066adaf843c419bfda78c9fc8de`
> Codex implementation: `032e13ae7c19f2639d2a60ff6c12c6104c59fd54`
> Reconciled repository head: `8087238f206e27ef2ade8c2b7d45a5e0ea0b3aa3`
> Evidence: G/H/I plus direct repository inspection
> Date: 2026-07-15
> Status: R2 bounded progress accepted; R3 not materialized; credential containment required

## 1. Methodology retained

Main recovered through:

```text
INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
```

Retained:

- G/H/I are observational evidence and cannot promote themselves.
- Repository inspection establishes that code exists; named execution establishes only its stated
  environment and scope.
- Implemented, validated, partial, contradicted, host-unvalidated and provider-pending remain
  distinct.
- J reconciles evidence; it does not replace domain canon or authorize provider mutation.
- D/E/F at `812a198` authorized R2 only. They do not silently authorize another refactor.

Round numbering is determined by the controlling D/E/F authority and the G/H/I unit labels, not by
the number of Git recovery, reconciliation or Codex attempts. The current evidence is R2. No R3
implementation commit or R3 G/H/I report exists.

## 2. Ancestry and exact repository delta

The controlling staging commit is an ancestor of the implementation commit, reconciliation commit
and current branch head:

```text
812a198 → 032e13a → a4ce0d4 → 8087238
```

Git reports exactly 14 changed paths:

```text
clients/markei_flutter/lib/application/hosted_auth_ports.dart
clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart
clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart
clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
services/markei_sync_api/migrations/005_hosted_authorization_fence.sql
services/markei_sync_api/src/application/hosted_authorization.ts
services/markei_sync_api/src/application/jwt_verifier.ts
services/markei_sync_api/src/hosted.ts
services/markei_sync_api/src/hosted_local_harness.ts
services/markei_sync_api/src/http/app.ts
services/markei_sync_api/test/hosted_auth.test.ts
```

No migration 001–004, permanent memory, methodology, A/B/C, D/E/F or J was changed by Codex.

### Report inventory drift

G lists `hosted_config.ts`, `hosted_contracts.ts` and `postgres/database.ts` as changed, but Git does
not. G also leaves Final SHA as pending. These are report defects. The authoritative implementation
inventory is the 14-path Git list above and Final SHA is `032e13a`.

### Subsequent repository exposure commit

Commit `8087238` does not advance C10-S03A to R3. It adds only:

```text
.vscode/settings.json
documentation/NEON_DOC.md
documentation/NEON_SESSION.ps1
```

These paths are unrelated to the R2 implementation and G/H/I evidence. Their contents were
deliberately not inspected during this reconciliation. The human reports that database connection
information was pushed, so Main treats affected credentials as exposed until rotation proves
otherwise.

Before any provider proof:

1. rotate both Neon login passwords (`markei_migrator` and `markei_runtime`);
2. replace any copied runtime credential in Render or other provider configuration;
3. remove the three private paths from Git tracking while preserving needed local copies outside
   Git;
4. restore ignore rules for local editor/provider helper files;
5. scan reachable Git history without reproducing secrets in logs or chat;
6. if secret material was committed, perform explicit history removal only after rotation, with a
   safety bundle and coordinated force-update authority.

Deleting the paths in a later commit does not remove already published material from Git history.

## 3. Codex classification accepted

G/H/I correctly report:

```text
C10-S03A_R2_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

They explicitly refuse the decisive result because:

- `AUTHORIZATION_RACE_MATRIX=partial`;
- `R2_LOCAL_SECURITY_PROVED=false`;
- the complete deterministic identity/membership/Device race matrix is absent;
- real Flutter-to-loopback-Fastify HTTP evidence is absent;
- file-backed Drift close/reopen and real outbox preservation are absent;
- the complete JWT rotation/outage/stale-expiry/unknown-key-pressure suite is absent.

Main accepts this self-classification.

## 4. Bounded progress accepted

Direct source inspection confirms meaningful R2 implementation.

### 4.1 Migration 005 and readiness

Implemented:

- forward migration `005_hosted_authorization_fence`;
- `markei_authorize_identity_membership(text,text)` security-definer function;
- bounded issuer/subject predicates;
- fixed function search path and qualified table references;
- active identity and membership row locks in deterministic Account order;
- runtime execute grant with `PUBLIC` revoked;
- runtime direct ledger and identity/membership mutation revocation;
- readiness moved away from direct runtime ledger reads.

G reports the disposable dual-role harness successfully proved distinct runtime identity, readiness,
direct ledger denial, DDL denial and identity/membership mutation denial. Main accepts this as local
lab evidence only.

### 4.2 Transaction authorizer

The hosted entrypoint now explicitly composes:

```text
RefusingAuthVerifier
+ HostedTransactionAuthorizer
```

Protected operations use one serializable transaction for fenced membership resolution, active
actor enrollment/Device checks and the protected callback. This is a material correction over R1.

### 4.3 Actor and target separation

Source now distinguishes:

- actor Device from `x-markei-device-id` plus identity-owned active enrollment;
- target Device from the path;
- owner same-Account target authority;
- member self-only authority;
- stable UUID ordering for actor/target Device locks.

The hosted harness exercised owner revocation of another same-Account Device and later denial of the
revoked Device. This is accepted as a sequential subset, not race proof.

### 4.4 Route and HTTP contracts

Thirteen descriptors cover hosted identity/enrollment/Device routes plus eight sync/recovery routes.
Current registrations are built from descriptor-bearing route values and checked for expected
presence. Enrollment conflict now maps to HTTP 409.

### 4.5 Flutter credential flow

The coordinator obtains one token per attempt and passes it explicitly into `enroll` or `query`.
The transport no longer independently fetches a credential. It refuses redirects, bounds response
bytes, rejects non-2xx success decoding and applies a closed six-field success shape.

### 4.6 JWT/JWKS subset

Source adds same-origin HTTPS checks for HTTPS issuers, fresh/stale ceilings, duplicate-`kid`
rejection, global refresh cooldown, per-key state scaffolding and refresh coalescing while retaining
`jose` cryptography. Main accepts this as implemented structure with partial tests.

### 4.7 Reported validation

G reports successful TypeScript formatting/lint/typecheck/build, 21 tests, npm audit, disposable
hosted harness, Flutter formatting/analysis, 56 tests, Android debug build, Windows release build,
five Python tests, diff check, secret scan and resource teardown.

Main did not independently rerun these checks. A local rerun attempt was blocked during `npm ci` by
the current host npm cache/filesystem (`/root/.npm`, corrupted tar/ENOENT) before tests began. This
is classified host-unvalidated and does not contradict G's recorded execution.

## 5. Source contradictions remaining after R2

The result is partial for more than missing tests. Direct inspection found the following behavior
gaps.

### 5.1 Revocation is not idempotent

`authorizeActorAndTargetDevice` requires the target Device status to be `active` before `revoke`
runs. A repeated revoke therefore fails before reaching the update that would return an equivalent
terminal result. The same condition prevents an authorized owner from reading status for an
already-revoked target.

This contradicts the selected R2 contract:

```text
repeated revoke → duplicate-equivalent terminal result
one active→revoked transition → at most one security event
```

### 5.2 Hosted transaction authorization is not structurally mandatory

`buildApp` still accepts `hosted`, `auth` and optional `hostedAuthorizer` independently. If another
composition supplies hosted routes without the authorizer, protected sync/recovery falls back to
`auth.verify` and a later transaction.

The current production entrypoint is safe because it supplies `RefusingAuthVerifier` plus the
authorizer, but the type/API still permits the forbidden future composition. R2 required a
discriminated hosted-vs-fixture composition, not convention alone.

### 5.3 Route inventory does not reject every extra Fastify route

The descriptor comparison checks the internal route list against another expected descriptor list,
and `hasRoute` checks that described routes exist. It does not enumerate Fastify and reject an extra
non-health route registered outside the descriptor path.

Current routes are covered, but the structural “no bypass route” invariant is incomplete.

### 5.4 Unknown-key cooldown is ineffective after an unchanged successful refresh

The JWT source decides whether to set negative `kid` cooldown by comparing `freshUntil` before and
after refresh. Every successful fetch recalculates `freshUntil`, even when the JWKS is unchanged.
The comparison therefore treats an unchanged successful refresh as changed and deletes negative
state. Repeated unknown keys can continue forcing refreshes.

The full unknown-key pressure/rotation suite is absent, so this defect was not detected by the 21
tests.

### 5.5 Flutter transport failures are not closed

`HttpDeviceEnrollmentTransport._send` may throw `TimeoutException`, `ClientException` or other
transport errors directly. `HostedEnrollmentCoordinator` catches only
`DeviceEnrollmentUnavailable` and `DeviceEnrollmentConflict`.

Consequences:

- timeout/network failure may escape rather than become durable `unknown`/`service-unavailable`;
- the coordinator may leave state at `enrolling` without returning its promised bounded outcome;
- the response-stream timeout is inter-chunk rather than one absolute request deadline, so a slow
  trickle is not bounded by the stated total timeout.

The missing real HTTP test is therefore a behavior blocker, not merely an evidence omission.

### 5.6 Readiness capability is broader than selected

`markei_required_migration_present(text)` allows runtime to query existence for arbitrary migration
identifiers. The R2 design selected a capability answering only the exact required readiness
condition. This is a small least-privilege deviation.

Migration 005 is now committed forward history. Any correction must be additive migration 006;
do not edit migration 005.

## 6. Incomplete decisive evidence

Still required after correcting the source gaps:

1. barrier-controlled membership disable/remove against upload, download, acknowledgement and all
   recovery route classes;
2. external identity disable against a protected mutation using the same fence;
3. actor Device revoke against protected operations;
4. owner/member status/revoke races and repeated-revoke event count;
5. equivalent/conflicting concurrent enrollment, response loss and restart replay;
6. complete denied-state non-advancement for events, cursors, acknowledgements, recovery sessions
   and security events;
7. exact route inventory rejection of an injected extra route;
8. JWT rotation, outage/recovery, stale expiry, timeout and unknown-key burst cases;
9. security-definer owner, ACL, safe-search-path and object-shadowing probes;
10. real Flutter HTTP transport against loopback Fastify;
11. file-backed Drift close/reopen with a real pending outbox row preserved;
12. one truthful aggregator that cannot emit success unless every producer passed.

## 7. PRC-01 reconciliation

| Claim | State after Main reconciliation |
| --- | --- |
| migration 005 exists | implemented |
| narrow local readiness path | implemented; locally reported validated subset |
| transaction-scoped hosted entrypoint | implemented; current composition accepted |
| structurally impossible hosted fallback | contradicted/incomplete |
| actor/target separation | implemented; sequential subset validated |
| idempotent Device revocation | contradicted by source |
| current 13-route coverage | implemented; local subset reported validated |
| future extra-route rejection | incomplete |
| server/Flutter HTTP 409 agreement | implemented |
| bounded Flutter network outcomes | contradicted/incomplete |
| one token passed coordinator→transport | implemented; fake-adapter test boundary |
| complete JWT/JWKS floor | partial; unknown-key logic contradicted |
| deterministic authorization race matrix | incomplete |
| real Flutter HTTP/file-backed proof | not implemented |
| local R2 security proof | not validated |
| provider proof | not performed |

## 8. Main decision and next unit

Main accepts R2 as substantial bounded progress and rejects completion.

The next eligible unit is one narrow local correction/proof round:

```text
C10-S03A-R3
```

R3 must:

1. make repeated revoke idempotent while preserving actor-active requirements and one event;
2. make hosted-vs-fixture authorization structurally discriminated;
3. make actual non-health route inventory reject extra/unclassified routes;
4. fix unknown-`kid` negative cooldown using JWKS/key-set identity rather than timestamps;
5. translate all bounded Flutter transport failures into typed outcomes under an absolute deadline;
6. add migration 006 for an exact readiness capability and revoke runtime use of the arbitrary
   readiness probe, without editing 005;
7. materialize the complete barrier/JWT/Flutter/file-backed evidence floor listed above;
8. correct G's final SHA and changed-path inventory in the next G report.

R3 remains local-only. It may not contact Auth0, Neon or Render, deploy, add provider SDK/native
callbacks, modify permanent memory, begin MCG-03/04 or claim Cycle 10 closure.

Main must restage D/E/F before Codex begins R3.

## 9. Provider boundary

MCG-01 sanitized evidence remains accepted within its recorded development boundary. Migration 003
still requires the later human Neon-owner bootstrap for the exact non-login recovery-worker role.
No Neon migration 001–006, Auth0 token flow or Render deployment has been proved here.

Provider proof remains stopped until local R3 succeeds and Main reconciles its G/H/I.
Credential rotation and repository containment are an additional prerequisite; they do not count as
R3 implementation evidence.

## 10. Terminal status

```text
C10-S03A_R2_PARTIAL_ACCEPTED
C10-S03A_R3_RESTAGING_REQUIRED
CREDENTIAL_ROTATION_AND_REPOSITORY_CONTAINMENT_REQUIRED
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Confidence is high for the source-level findings and Git inventory; medium-high for the local
execution claims because they are supported by G but could not be independently rerun on this host.
