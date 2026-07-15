# J_MAIN_STAGE — C10-S03A-R3 Investigation Reconciliation

> Sequence: FLX-INV-02 Main synthesis before FLX-ORD-01 restaging
> Branch / inspected HEAD: `intermid-cycle-recovery` / `06d694aa8fb88a43c47fca3eccd02c909c193f2f`
> R2 implementation: `032e13ae7c19f2639d2a60ff6c12c6104c59fd54`
> Evidence: current A/B/C, prior D/E/F and G/H/I, direct repository inspection
> Date: 2026-07-15
> Status: R3 investigation reconciled; implementation authority inactive

## 1. Methodology retained

Main recovered through:

```text
INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL
```

Retained:

- A/B/C are provisional domain investigations, not Codex authority.
- G/H/I remain observational R2 evidence and cannot promote themselves.
- D/E/F at `812a198` authorized R2 only; they are stale for a new implementation.
- Repository inspection proves code shape; named execution proves only its stated environment.
- Implemented, validated, contradicted, host-unvalidated, provider-pending and deferred remain
  distinct.
- J owns cross-domain synthesis but does not replace permanent domain memory.
- No provider mutation, source implementation or dependency change is authorized by this file.

Round numbering is now unambiguous:

```text
R2 staging       812a198
R2 implementation 032e13a
R2 reconciliation a4ce0d4 / clarified by 06d694a
R3 investigation  current A/B/C
R3 implementation absent
R3 G/H/I          absent
```

## 2. Investigation integrity

Three independent domain investigations replaced only:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

They inspected project-owned TypeScript, SQL, Dart, Flutter ports/adapters, composition roots,
tests, manifests and prior stage evidence. They did not read provider helper files, secrets or
dependency source trees; did not contact Auth0, Neon or Render; and did not edit source, migrations,
configuration, permanent memory or prior reports.

All three classify the six R2 defects as Markei-owned boundary errors or missing evidence. None
establishes a Java, Gradle, npm, Node, Fastify, `jose`, PostgreSQL, Dart `http`, Drift or Flutter
package defect. A dependency/version change is therefore not indicated.

Host execution remains unvalidated in this investigation checkout because installed TypeScript and
Flutter toolchains are absent. This is a host limitation, not product failure and not a contradiction
of G's recorded R2 validation.

## 3. Cross-domain causal synthesis

### 3.1 Device revocation/status

Current cause:

```text
deviceStatus/revoke
→ authorizeActorAndTargetDevice
→ requires actor active AND target active
→ revoked target rejected before status/idempotent transition logic
```

The helper combines actor authorization with target-state policy. The conditional update/event code
can already support one event per locked transition, but the target never reaches it after revocation.

R3 direction:

- keep identity-bound actor enrollment and actor Device strictly active;
- lock and return a same-Account target snapshot whether active or revoked;
- let status/revoke own target-state semantics;
- active→revoked changes enrollment and Device atomically and inserts one event;
- already revoked returns a duplicate-equivalent terminal result only to a currently authorized
  actor;
- foreign/cross-Account targets remain non-enumerating denials.

### 3.2 Hosted composition

Current cause:

```text
buildApp(auth, hosted?, hostedAuthorizer?, database?)
→ hostedAuthorizer is optional
→ protectedOperation may fall back to auth.verify + later transaction
```

The current hosted entrypoint composes safely, but the type permits a future unsafe composition.

R3 direction: one exhaustive authorization composition:

```text
hosted  → HostedIdentityService + HostedTransactionAuthorizer
fixture → AuthVerifier only
disabled
```

Hosted operation routes must have no fixture/precommitted fallback representable by the type.

### 3.3 Route authorization inventory

Current cause: descriptors register the current routes and `hasRoute` proves each described route
exists, but no mechanism rejects an extra route registered outside the descriptor path.

R3 direction:

- one classified registration gateway;
- a Fastify `onRoute` capture installed before registrations;
- exact comparison of normalized actual method/path pairs with descriptor inventory;
- only the two named health routes and explicitly normalized automatic HEAD forms are exceptions;
- reject missing, extra, duplicate, wrong-operation and wrong-class entries;
- prove rejection by injecting a real extra route.

### 3.4 JWT/JWKS unknown-key pressure

Current cause:

```text
unknown kid
→ forced refresh
→ successful fetch always changes freshUntil
→ timestamp comparison incorrectly implies key-set change
→ negative state cleared
```

A second defect found by A: `force:true` also bypasses the failed-refresh global cooldown, allowing
distinct unknown keys to create pressure after an outage.

R3 direction:

- normalize accepted JWK fields and compute a deterministic, order-independent key-set fingerprint;
- refresh returns `changed | unchanged | stale-retained`;
- unknown requested keys receive per-key cooldown after unchanged/stale-retained refresh;
- global failure cooldown also applies to forced unknown-key refresh;
- genuine key-set rotation, not timestamp movement, clears relevant negative state;
- keep `jose` as the cryptographic verifier; do not implement cryptography.

### 3.5 Flutter hosted-enrollment transport

Current cause:

```text
HttpDeviceEnrollmentTransport._send
→ raw timeout/client/stream exceptions may escape
→ coordinator catches only two custom exceptions
→ durable state can remain `enrolling`
```

Separate send and stream timeouts are renewable phase/inter-chunk limits, not one absolute attempt
deadline.

R3 direction:

- the HTTP adapter owns raw HTTP/IO/timeout/parse/size translation;
- the application port returns a closed success/conflict/unavailable/unknown outcome or equivalent
  closed typed failure;
- the coordinator persists the matching durable state and never sees HTTP package exceptions;
- one deadline spans connect, headers and body;
- expiry must cancel the request without closing a borrowed shared client;
- if the pinned `http 1.6.0` API cannot cancel one request, use an injected per-attempt owned client
  factory and prove teardown; do not upgrade speculatively;
- programming defects must not be swallowed as network outcomes.

### 3.6 Runtime readiness capability

Current cause: migration 005 grants runtime execute on
`markei_required_migration_present(text)`, so runtime can probe arbitrary ledger identifiers.

R3 direction: one additive migration only:

```text
006_hosted_authorization_r3.sql
markei_hosted_runtime_ready()
```

The no-argument function checks only the exact R3 readiness condition, returns a scalar boolean,
uses the migration owner, `SECURITY DEFINER`, fixed safe `search_path`, qualified objects, no dynamic
SQL, `PUBLIC` revoked and runtime execute only. Migration 006 revokes runtime execute on the old
arbitrary probe without editing/dropping migration 005 and preserves direct-ledger denial.

The final migration identifier/checksum must follow the repository migration runner's existing
convention. Codex must verify it before writing rather than inventing a parallel ledger format.

## 4. Main decision: self-revoke replay

R2 simultaneously required:

```text
actor Device must be active
member may manage its actor Device
repeated successful revoke is duplicate-equivalent
```

After a Device revokes itself, that same Device is no longer an active actor. Universal self-revoke
replay therefore cannot be authorized without a separate durable revoke-request/result identity or
an exception that weakens the active-actor rule.

Main selects the bounded security-first interpretation for R3:

- idempotent target-revoke replay is guaranteed when the retrying actor remains active and
  authorized;
- a self-revoke may commit once, after which the revoked actor is denied;
- exact self-revoke response-loss replay is deferred until Main separately authorizes a durable
  request/result contract;
- R3 must not add that schema/contract or weaken actor authentication implicitly.

This corrects the overly broad R2 wording. It does not claim universal revoke idempotence.

## 5. Evidence architecture selected

R3 decisive proof must be local, deterministic and producer-owned.

Required groups:

1. Device management: owner/member policy, active/revoked target status, scoped repeated revoke,
   self-revoke boundary, one transition/event and actor/target races.
2. Composition: compile-time invalid hosted/fixture combinations plus runtime branch tests; hosted
   operations cannot reach fixture verification fallback.
3. Routes: actual `onRoute` inventory rejects injected extra, missing, duplicate and mismatched
   classifications while preserving named health behavior.
4. Authorization barriers: membership/identity/actor revocation against upload, download,
   acknowledgement and every recovery class; controlled writers acquire the same fence; no sleeps.
5. Denied-state preservation: facts/events/cursors/acknowledgements/recovery sessions and security
   event counts do not advance incorrectly.
6. Enrollment: equivalent/conflicting concurrency, response loss, query/replay and process restart.
7. JWT/JWKS: unchanged unknown-key bursts, distinct-key outage pressure, genuine rotation,
   coalescing, stale expiry, recovery, timeout/abort and duplicate-key rejection.
8. Migration/ACL: fresh 001→006, upgrade 001→005→006, duplicate/failure rollback, owner/mode,
   function definition/search path/object shadowing, old-probe denial and direct-ledger denial.
9. Flutter: real `HttpDeviceEnrollmentTransport` against loopback Fastify; exact bearer equality,
   conflict, network loss, malformed/oversized response and slow trickle beyond the absolute
   deadline.
10. File-backed Drift: real pending outbox and facts survive failure and close/reopen; enrollment
    request identity/progress remains truthful.
11. Aggregation: each producer emits its own machine-readable result; one orchestrator may emit
    `R3_LOCAL_SECURITY_PROVED=true` only when every required producer passed.

Skipped, unavailable, partial or host-blocked producers must make the aggregate false.

## 6. Bounded R3 implementation surface

Expected project-owned surface, to be frozen in new D/E/F:

```text
services/markei_sync_api/migrations/006_hosted_authorization_r3.sql
services/markei_sync_api/src/application/hosted_authorization.ts
services/markei_sync_api/src/application/jwt_verifier.ts
services/markei_sync_api/src/http/app.ts
services/markei_sync_api/src/http/route_registry.ts        (optional extraction)
services/markei_sync_api/src/{hosted,main,lab,hosted_local_harness}.ts
services/markei_sync_api/test/hosted_auth.test.ts
services/markei_sync_api/package.json                      (script only if needed)
clients/markei_flutter/lib/application/hosted_auth_ports.dart
clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart
clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart
clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex may omit candidate files it proves unnecessary. It may not expand into dependency source,
provider SDKs, generated Drift code, UI, permanent memory or unrelated refactoring.

Versions remain unchanged unless a direct compile/API proof establishes a missing primitive:

```text
event payload v3
cursor c10b:*
recovery snapshot format 1
hosted enrollment contract v1
Drift schema v7
Node/npm/TypeScript/Fastify/jose/pg and Flutter package locks
```

## 7. Security, provider and repository-containment gates

R3 remains local-only. It may not contact Auth0, Neon or Render, deploy, use provider credentials,
apply migration 006 to Neon, begin MCG-03/04, promote permanent memory or claim Cycle 10 closure.

The repository exposure recorded in prior J remains a separate blocker. Before provider proof:

- rotate `markei_migrator` and `markei_runtime` passwords;
- replace any copied runtime credential in provider configuration;
- remove private helper/editor paths from Git tracking and restore ignore rules;
- assess reachable history without reproducing secret values;
- if secret material was committed, use separately authorized history-removal procedure only after
  rotation and safety backup.

Credential containment does not count as R3 code evidence.

## 8. PRC-01 classification

| Claim | State after second Main reconciliation |
| --- | --- |
| six R2 source contradictions | confirmed |
| forced unknown-key bypasses failure cooldown | newly confirmed |
| dependency/package mismatch causes failures | not supported |
| dependency upgrade required | rejected absent new evidence |
| scoped active-actor revoke replay | accepted R3 semantic boundary |
| universal self-revoke replay | deferred |
| discriminated hosted/fixture/disabled composition | selected |
| actual `onRoute` inventory | selected with explicit health/HEAD normalization |
| semantic JWKS key-set fingerprint | selected |
| closed Flutter outcomes + absolute deadline | selected; cancellation mechanism compile-proven later |
| migration 006 exact readiness capability | selected; not implemented |
| complete deterministic proof floor | selected; not implemented |
| R3 implementation | absent |
| R3 local validation | absent |
| provider proof | not performed/unauthorized |

## 9. Next authority and stopping rules

Main must now replace D/E/F as one active R3 materialization authority. Codex must not implement from
A/B/C or this J alone.

New D/E/F must stop implementation on:

- any edit to migrations 001–005;
- broad runtime table/ledger grants;
- hosted fallback that remains representable;
- inventory that cannot reject an injected real extra route;
- timestamp-based JWKS key-set identity or forced cooldown bypass;
- renewable timeout presented as an absolute deadline;
- blanket catch that hides programming errors;
- sleep-based or uncontrolled race proof;
- missing decisive producer reported as success;
- dependency upgrade without demonstrated API necessity;
- provider contact, secret read or unresolved repository exposure;
- permanent-memory/UI/MCG-03/04 expansion.

## 10. Terminal status

```text
C10-S03A_R3_INVESTIGATION_RECONCILED
C10-S03A_R3_IMPLEMENTATION_NOT_STARTED
D_E_F_R3_RESTAGING_REQUIRED
DEPENDENCY_UPGRADE_NOT_INDICATED
CREDENTIAL_ROTATION_AND_REPOSITORY_CONTAINMENT_REQUIRED
MCG-02_PROVIDER_PROOF_NOT_AUTHORIZED
```

Confidence is high for the causal diagnoses, dependency classification, bounded source surface and
selected SQL/composition/route/JWKS architecture; medium-high for the exact Flutter cancellation
mechanism until compiled against the pinned package; medium for product semantics of self-revoke,
which is deliberately bounded rather than silently generalized.
