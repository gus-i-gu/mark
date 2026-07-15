# J_MAIN_STAGE — C10-S03A-R3B Post-Codex Reconciliation

> Sequence: FLX-ORD-01 Main reconciliation
> Branch: `intermid-cycle-recovery`
> Controlling D/E/F: `8a219e63dc1b8c7f9b044ed1c3ba99649250ca69`
> Codex implementation: `d95d3a2a94935b850f10b9e4b0228ba128b3e728`
> Evidence: R3B G/H/I, Git delta and focused source/test inspection
> Date: 2026-07-15
> Status: five source contradictions corrected; decisive local proof incomplete

## 1. Methodology retained

Main recovered through:

```text
INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
```

Retained:

- G/H/I are observational evidence and cannot promote themselves.
- Git owns ancestry and changed-path inventory.
- Source inspection establishes implementation; named passing tests validate only their stated
  environment and case.
- Implemented, validated subset, partial, provider-pending and production-ready remain distinct.
- J may accept the five corrections while refusing the complete local-security diagnostic.
- Further Codex work requires new D/E/F authority.
- Provider proof, credential containment, permanent promotion and Cycle closure remain later gates.

Round identity:

```text
R3 reconciliation                2468c39
R3B D/E/F authority              8a219e6
R3B implementation/evidence      d95d3a2
R3B complete decisive proof      absent
```

## 2. Ancestry and exact delta

The controlling authority is an ancestor of the implementation:

```text
8a219e6 → d95d3a2
```

Git reports exactly 11 changed paths:

```text
clients/markei_flutter/lib/application/hosted_auth_ports.dart
clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart
clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart
clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
services/markei_sync_api/src/application/hosted_authorization.ts
services/markei_sync_api/src/application/jwt_verifier.ts
services/markei_sync_api/src/http/app.ts
services/markei_sync_api/test/hosted_auth.test.ts
```

No dependency/lockfile, migration, Drift schema, methodology, permanent memory, A/B/C, J or D/E/F
file changed. G left Final SHA pending; Git establishes `d95d3a2` as the final SHA.

## 3. Codex classification accepted

G/H/I report:

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3B_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

The hosted-local producer reports:

```text
AUTHORIZATION_RACE_MATRIX=partial
ROUTE_AUTHORIZATION_INVENTORY=true
LEAST_PRIVILEGE_HTTP=true
R3_LOCAL_SECURITY_PROVED=false
```

No forbidden success diagnostic was emitted. Main accepts the partial classification.

## 4. Source corrections accepted

### 4.1 Absolute Flutter attempt boundary

The HTTP transport now defaults to per-attempt owned clients, closes owned clients in `finally`,
captures one deadline and recomputes remaining time for body reads. Borrowed clients remain
caller-owned. This corrects the renewable-body-timeout structure.

Accepted state: implemented and unit/static validated subset. Real loopback slow-trickle,
cancellation and file-backed persistence evidence remains absent.

### 4.2 Closed enrollment and replay outcomes

`DeviceEnrollmentResult` now preserves `device-enrolled` versus `duplicate-equivalent`. The
coordinator maps them separately and persists replay conflict, unavailable and unknown outcomes
instead of leaving `enrolling`.

Accepted state: implemented and focused Flutter tests passed. Real HTTP, response loss and
file-backed close/reopen proof remains absent.

### 4.3 Bounded normalized JWKS state

One lookup now has one refresh budget. Expiry consumes it; an absent requested key receives negative
cooldown even when another key changed. Revision hashes only normalized `{kty,kid,use,alg,n,e}`
public RSA/RS256 material. Private, malformed, duplicate and unsupported keys reject.

Accepted state: implemented and focused frozen-state tests passed. Full producer aggregation is
absent, but no known source contradiction remains.

### 4.4 Readiness-time route inventory

Exact comparison now runs in Fastify `onReady`. Tests reject an injected unclassified route, a late
direct route and an encapsulated plugin route before service/injection.

Accepted state: implemented and locally validated for the named inventory cases.

### 4.5 Device status projection

`deviceStatus()` now returns `target.deviceStatus`, not enrollment state. `replaced` remains outside
the public active/revoked Device contract.

Accepted state: implemented. Complete owner/member/race and deliberately divergent database proof
belongs to the remaining authorization producer.

## 5. Reported validation accepted

G records:

- TypeScript format, lint, typecheck and build passed;
- 27 TypeScript tests passed;
- production dependency audit reported zero vulnerabilities;
- Flutter format and analysis passed;
- 58 Flutter tests passed with two lab-gated skips;
- Android debug and Windows release builds passed;
- five protected Python regressions passed;
- `git diff --check` passed;
- no provider/private helper access occurred.

These are accepted within their named local/build boundaries. Builds do not establish runtime,
provider or platform acceptance.

## 6. Decisive proof still absent

R3B completion is blocked by four evidence producers, not by a newly identified architecture:

1. deterministic authorization/revocation race matrix with denied-no-state-advance snapshots;
2. complete migration-006 fresh/upgrade/duplicate/rollback/owner/ACL/shadowing/tamper lifecycle;
3. real `HttpDeviceEnrollmentTransport` against loopback Fastify with file-backed Drift, real facts
   and a pending outbox row;
4. closed aggregator validating every required producer/case and remaining false for missing,
   skipped, partial, unavailable or failed input.

The two skipped Flutter lab gates cannot count toward completion.

## 7. PRC-01 reconciliation

| Claim | State after Main reconciliation |
| --- | --- |
| absolute transport deadline structure | implemented; focused subset validated |
| request-owned client closure | implemented; real loopback cancellation unproved |
| distinct enrollment success variants | implemented; focused tests passed |
| replay outcome persistence | implemented; focused tests passed |
| one-refresh normalized JWKS policy | implemented; focused tests passed |
| readiness-time route inventory | implemented; named route tests passed |
| Device-row status projection | implemented |
| complete authorization race proof | incomplete |
| complete migration-006 lifecycle proof | incomplete |
| real HTTP/file-backed Drift proof | incomplete/skipped |
| truthful complete aggregation | incomplete; current aggregate correctly false |
| provider proof | not performed/unauthorized |

## 8. Main decision and next unit

Main accepts `d95d3a2` as the bounded R3B contract correction and rejects complete local-security
acceptance.

The next unit is:

```text
C10-S03A-R3C — Decisive Local Proof Completion
```

R3C is proof-first. It must build the four missing producers and may make only narrow corrections
directly exposed by those proofs within the accepted contracts. It must not reopen the five selected
architectures without a new contradiction and Main restaging.

No migration 007, edit to migrations 001–006, dependency/lockfile change, Drift schema change,
provider access, UI work, permanent promotion or unrelated refactor is authorized.

## 9. Provider and credential boundary

No Auth0, Neon or Render proof occurred. MCG-02 remains pending. Before provider proof, the separate
human containment sequence still owns credential rotation, provider secret replacement, private
helper untracking and any authorized history assessment.

Codex must not inspect:

```text
.vscode/settings.json
documentation/NEON_DOC.md
documentation/NEON_SESSION.ps1
```

## 10. Terminal status

```text
C10-S03A_R3B_CORRECTIONS_ACCEPTED
C10-S03A_R3C_RESTAGING_REQUIRED
R3_LOCAL_SECURITY_PROVED=false
KNOWN_SOURCE_CONTRADICTIONS_CLOSED=true
DECISIVE_PROOF_PRODUCERS_COMPLETE=false
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Confidence is high for Git inventory, the five source corrections and the four missing producers;
medium-high for cancellation semantics until real loopback evidence establishes resource behavior.
