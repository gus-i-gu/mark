# J_MAIN_STAGE — C10-S03A Post-Codex Reconciliation

> Sequence: FLX-PRM-04 post-materialization reconciliation
> Role: Main Chat
> Cycle/unit: Cycle 10 / C10-S03A
> Branch: `intermid-cycle-recovery`
> Staging authority: `7bf3bc1c7acf5d4077cedc42ea2162a1bba99e35`
> Codex evidence commit: `d345f5800b55206f5352232c5a12ac383ccdee34`
> Status: `C10-S03A_CONTRADICTED_STOP`
> Provider authority: none

## 1. Methodology retained

Main loaded root and notebook `AGENTS.md`, `INDEX.md`, then the complete
`METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL` route.

Retained controls:

- Main owns cross-domain reconciliation and the next materialization authority.
- D/E/F jointly define the accepted implementation contract.
- G/H/I are observational reports and cannot promote their own terminal claim.
- Repository inspection establishes existence; named validation establishes bounded behavior.
- PRC-01 keeps implemented, validated, host-unvalidated, contradicted and deferred claims distinct.
- A security-boundary deviation is a stop condition, not an ordinary implementation detail.
- Permanent memory remains owned by the Operational, Didactic and Design domains.
- Provider mutation, provider credentials and interactive identity remain human-controlled.
- Learner maturity does not advance from repository implementation alone.

## 2. Ancestry and evidence inventory

The remote branch is linear through:

```text
75ce8a10  C10-S03 investigations reconciled
↓
7bf3bc1c  J/D/E/F C10-S03A materialization authority
↓
d345f580  Codex implementation plus G/H/I
```

Git confirms `7bf3bc1c` is an ancestor of `d345f580`. The Codex commit changes 23 paths:

- 6 Flutter/Drift source or test paths;
- 14 server, migration, dependency or test paths;
- G, H and I.

G's changed-path inventory matches Git and includes G/H/I. Migrations 001, 002 and 003 are
byte-identical to the pre-S03A baseline; migration 004 is the only PostgreSQL migration added.

Evidence consulted:

- J/D/E/F at `7bf3bc1c`;
- G/H/I at `d345f580`;
- the complete `7bf3bc1c..d345f580` Git inventory;
- migration 004, hosted configuration and entrypoint;
- JWT/JWKS verifier and tests;
- hosted identity/enrollment/authorization service;
- all sync/recovery HTTP routes and transaction helpers;
- hosted-local harness;
- Drift v7 schema, repository and migration tests;
- package build/start definitions.

## 3. Implementation summary

Codex materially added:

- forward-only PostgreSQL migration 004 for external identities, memberships, enrollment
  requests/bindings and security events;
- a `jose`-based RS256 access-token verifier;
- hosted configuration and a compiled Node entrypoint;
- identity, enrollment, status and revocation routes;
- hosted authorization in front of existing sync/recovery routes;
- Drift v7 hosted-identity state and application ports;
- a disposable PostgreSQL/JWKS/HTTP harness;
- refreshed G/H/I evidence.

The harness emitted `HOSTED_AUTH_READY=true`, and G reported the terminal pair
`C10-S03A_LOCAL_HOSTED_AUTH_READY / MCG-02_PROVIDER_PROOF_PENDING`. Main does not accept that
terminal classification because the implementation contradicts a controlling transaction-time
authorization invariant and leaves other decisive gates incomplete.

## 4. D/E/F checkpoint reconciliation

| Area | Evidence | Main result |
| --- | --- | --- |
| Closed contracts/configuration | Hosted config and typed contracts exist; value-redacted failures are partly tested | implemented, partially validated |
| Migration 004 | Additive schema, RLS/grants, ledger evidence and rollback probes reported | implemented, locally validated within reported probes |
| JWT/JWKS | RS256, issuer, audience, time and subject checks use `jose`; only a narrow test subset exists | implemented, decisive validation incomplete |
| Identity/membership | Exact issuer+subject resolves database membership; Account is not token-derived | implemented and locally exercised |
| Enrollment/revocation | Basic replay, hash conflict, two enrollments and revocation denial exercised | implemented; race and privilege matrix incomplete |
| Route authorization | Auth is checked before each route transaction, not rechecked within that mutation transaction | **security contradiction** |
| Hosted entrypoint | Compiled entrypoint, config-before-listen, generic health and no fixture import | implemented and smoke-tested by G |
| Drift v7 | Additive hosted-auth state; existing state reported preserved | implemented and locally validated |
| Flutter hosted lab | Ports/repository exist; no opt-in authentication/enrollment lab composition or transport was added | incomplete |
| Decisive topology | Real loopback HTTP/JWKS/PostgreSQL used; harness connection performs migration, seeding and runtime calls | partial; least-privilege runtime HTTP proof absent |
| Regression/builds | TS and Flutter suites reported; Android passed; Windows blocked by host Developer Mode | accepted with host exclusion |
| Provider boundary | G/H/I report no Auth0, Neon or Render access | accepted local evidence only |

### 4.1 Controlling security contradiction

F requires authorization to lock or recheck membership, enrollment and Device state inside the
protected operation transaction, and explicitly prohibits authorizing once outside the transaction
then mutating without recheck.

Materialized flow:

```text
HostedAuthVerifier.verify
  → inTransactionWithContext
  → resolve membership and Device enrollment
  → COMMIT

HTTP route
  → inTransaction
  → sync/recovery operation
  → COMMIT
```

Membership may be removed or enrollment revoked between those transactions. Some existing service
operations recheck the base `devices.status`, but they do not all recheck external identity,
membership and enrollment under the same transaction/lock. The derived `AuthContext` therefore
crosses a transaction boundary without satisfying D/F's required recheck.

Consequences:

- route-wide hosted authorization is not transactionally established;
- membership-removal and enrollment-revocation races remain open;
- H's `device-authorized` description and I's route-transaction claim overstate the source;
- provider deployment must remain blocked.

### 4.2 Additional decisive gaps

- G explicitly lists the required JWT/JWKS cases not exhaustively represented: duplicate/malformed
  bearer, invalid signature, wrong issuer/algorithm, expiry/nbf, missing subject/kid, rotation,
  cached outage, timeout, malformed/oversized JWKS and refresh stampede.
- The verifier delegates JWKS retrieval to `createRemoteJWKSet`; the required explicit maximum JWKS
  response-size control is not materialized or tested.
- The harness uses one supplied database URL to migrate, seed and serve HTTP. Separate SQL probes
  show runtime denials, but the decisive HTTP path is not proved under the least-privilege runtime
  identity required by D/F.
- The harness does not prove two Accounts or the required cross-Account, membership-disable/removal,
  concurrent enrollment/revocation and restart matrix.
- Flutter contains ports and durable state only; the opt-in hosted-auth lab composition authorized by
  J/D/F is absent.
- Independent reconciliation test execution was not repeated because this clean checkout has no
  installed `tsx` dependency. This environment exclusion does not negate G's recorded run, but it
  adds no new validation evidence.

## 5. PRC-01 material-claim classification

The fields below are the controlling classification cache. Human/Main authority is Main unless
otherwise stated; no result grants provider authority.

### 5.1 C10-S02 recovery behavior

- Claim: prior retention, snapshot and rebootstrap convergence remains available.
- Source: `de1319d`, prior G/H/I, unchanged regression surface.
- Prior/current state: locally validated / retained.
- Evidence: prior `RECOVERY_CONVERGED=true`; current full suites reported passing.
- Boundary: local disposable topology.
- Contradictions: none found in this reconciliation.
- Semantic owner/target: Operational + Design / permanent-domain review later.
- History disposition: retain prior evidence by reference.
- Confidence: high.
- Result: accepted retained local behavior.

### 5.2 Migration 004

- Claim: additive hosted identity/enrollment persistence exists.
- Source: migration 004, G and I.
- Prior/current state: staged / implemented and locally probed.
- Evidence: fresh and incremental migration, ledger, rollback, RLS and denial reports.
- Boundary: disposable PostgreSQL 18; not Neon-applied.
- Contradictions: decisive HTTP harness does not use separated runtime identity.
- Semantic owner/target: Design + Operational / retain for corrective unit.
- History disposition: preserve implementation and evidence.
- Confidence: medium-high.
- Result: accepted existence; hosted acceptance deferred.

### 5.3 Drift v7

- Claim: additive hosted identity state preserves v6 data.
- Source: Drift schema/repository/tests, G/H/I.
- Prior/current state: staged / implemented and locally validated.
- Evidence: reported migration, reopen and no-reset tests.
- Boundary: local Flutter databases; Windows runtime unproved.
- Contradictions: no hosted Flutter composition exists.
- Semantic owner/target: Design / retain for corrective unit.
- History disposition: preserve.
- Confidence: high for schema, low for provider workflow.
- Result: accepted additive schema only.

### 5.4 JWT/JWKS verification

- Claim: production-shaped access-token verification is ready.
- Source: verifier, tests and G.
- Prior/current state: staged / implemented but under-validated.
- Evidence: valid RS256, wrong audience, missing bearer and oversized token.
- Boundary: local loopback issuer.
- Contradictions: required adversarial/rotation/outage matrix and JWKS size bound absent.
- Semantic owner/target: Design + Operational / corrective D/F and Codex tests.
- History disposition: preserve partial implementation; supersede ready claim.
- Confidence: high in gap classification.
- Result: partial, not readiness evidence.

### 5.5 External identity and membership

- Claim: token identity is distinct from Account membership.
- Source: migration 004 and hosted authorization service.
- Prior/current state: staged / implemented.
- Evidence: exact issuer+subject lookup and database membership resolution.
- Boundary: synthetic identities; provisioning remains manual.
- Contradictions: membership is not rechecked in each mutation transaction.
- Semantic owner/target: Design / corrective F.
- History disposition: retain model; correct transaction use.
- Confidence: high.
- Result: model accepted; authorization readiness contradicted.

### 5.6 Device enrollment and revocation

- Claim: installations enroll idempotently and revocation is immediately enforced.
- Source: service, migration and harness.
- Prior/current state: staged / basic path implemented.
- Evidence: equivalent replay, hash conflict, two Devices and sequential revocation denial.
- Boundary: one Account; no concurrent race proof.
- Contradictions: authorization/mutation split and incomplete concurrency/role matrix.
- Semantic owner/target: Design + Operational / corrective D/F.
- History disposition: retain basic evidence; reject complete claim.
- Confidence: high.
- Result: partial.

### 5.7 Route-wide authorization

- Claim: every sync/recovery mutation rechecks hosted authority transactionally.
- Source: D/F requirement, H/I claim, HTTP and database source.
- Prior/current state: required / contradicted.
- Evidence: `verify()` commits before route `inTransaction()` begins.
- Boundary: all hosted protected routes using this composition.
- Contradictions: direct contradiction with F section 5.
- Semantic owner/target: Design / new D/E/F before correction.
- History disposition: record contradiction; supersede H/I wording.
- Confidence: high.
- Result: security blocker.

### 5.8 Hosted server entrypoint

- Claim: a production-shaped compiled entrypoint exists without fixture fallback.
- Source: `hosted.ts`, package scripts, config and G.
- Prior/current state: staged / implemented and smoke-tested.
- Evidence: compiled start, generic health, config failure and source inspection.
- Boundary: local process; no Render/TLS acceptance.
- Contradictions: application authorization beneath it is not ready.
- Semantic owner/target: Operational + Design / retain.
- History disposition: preserve.
- Confidence: high.
- Result: accepted component, not deployable unit.

### 5.9 Flutter hosted-auth boundary

- Claim: an opt-in neutral Flutter hosted-auth lab is ready for later provider proof.
- Source: J/D/F requirement, Flutter diff and H/I.
- Prior/current state: required / incomplete.
- Evidence: ports and local repository only.
- Boundary: no Auth0 SDK, callbacks, token source, HTTP enrollment transport or lab entrypoint.
- Contradictions: G/H/I do not identify a materialized lab composition.
- Semantic owner/target: Operational + Design / corrective staging.
- History disposition: retain ports; keep lab pending.
- Confidence: high.
- Result: partial.

### 5.10 Local decisive harness

- Claim: decisive hosted-auth readiness was proved.
- Source: harness and G terminal diagnostic.
- Prior/current state: required / diagnostic passed but gate invalidated.
- Evidence: real HTTP/JWKS/PostgreSQL, enrollment, sync, ack and revocation.
- Boundary: one Account and one connection authority.
- Contradictions: runtime-role topology, race matrix and transaction invariant are unproved.
- Semantic owner/target: Operational / corrective harness.
- History disposition: preserve diagnostic as partial evidence.
- Confidence: high.
- Result: `HOSTED_AUTH_READY=true` is insufficient for terminal readiness.

### 5.11 Provider non-use

- Claim: implementation did not contact Auth0, Neon or Render.
- Source: G/H/I and synthetic configuration.
- Prior/current state: prohibited / respected.
- Evidence: reported local-only execution and no provider values in inventory.
- Boundary: Codex report; no external audit.
- Contradictions: none found.
- Semantic owner/target: Operational / later permanent record.
- History disposition: preserve.
- Confidence: medium-high.
- Result: accepted local evidence.

### 5.12 MCG-01 evidence

- Claim: an isolated Neon development environment and separated roles were manually proved.
- Source: sanitized human evidence dated 2026-07-15.
- Prior/current state: sanitized evidence ready / accepted with unchanged boundary.
- Evidence: PostgreSQL 18.4, development branch, TLS, rollback, CRUD, DDL denial, teardown.
- Boundary: no migration 003/004, hosted auth or production proof.
- Contradictions: none.
- Semantic owner/target: Operational / permanent promotion after corrective reconciliation.
- History disposition: preserve sanitized summary only.
- Confidence: medium-high.
- Human/Main authority: human observation accepted by Main.
- Result: accepted development-environment evidence.

### 5.13 MCG-02 and Cycle 10 closure

- Claim: repository readiness permits MCG-02 and Cycle 10 closure progression.
- Source: G terminal claim versus source reconciliation.
- Prior/current state: blocked pending S03A / remains blocked.
- Evidence: security contradiction and decisive validation gaps above.
- Boundary: this reconciliation does not assess real providers.
- Contradictions: G claims local readiness; Main rejects it.
- Semantic owner/target: Main / new corrective D/E/F.
- History disposition: record blocked state; do not promote.
- Confidence: high.
- Result: MCG-02 not ready; Cycle 10 not closable.

## 6. Accepted, partial, contradicted and deferred claims

Accepted:

- migrations 001–003 unchanged and migration 004 added forward-only;
- additive Drift v7 hosted state;
- identity/membership/installation/Device concepts remain distinct;
- hosted entrypoint excludes `FixtureAuthVerifier` and uses compiled JavaScript;
- basic local enrollment, sync, acknowledgement and sequential revocation flow;
- Android debug build and other validations recorded by G;
- provider non-use and local-first preservation within reported evidence;
- sanitized MCG-01 development-environment evidence.

Partial:

- JWT/JWKS hardening and failure injection;
- enrollment/revocation concurrency and role behavior;
- least-privilege decisive topology;
- Flutter hosted-auth lab composition;
- Windows build/runtime evidence.

Contradicted:

- route-wide transaction-time hosted authorization;
- H/I wording that membership/enrollment/Device are rechecked inside each operation transaction;
- the terminal `C10-S03A_LOCAL_HOSTED_AUTH_READY` classification.

Deferred:

- all real Auth0, Neon and Render evidence;
- provider tuning and production acceptance;
- Account selection, invitations, replacement/reactivation and product UI;
- MCG-03/04 definition and execution;
- Cycle 10 closure.

## 7. MCG-01 classification

Retain MCG-01 as accepted sanitized development-environment evidence only:

- isolated Neon development branch and disposable `markei_sync_dev`;
- PostgreSQL 18.4 in `us-west-2`;
- separate direct migrator and pooled-intended runtime identities;
- TLS, transactional rollback, explicit runtime CRUD, runtime DDL denial and teardown.

It does not prove migration 003/004 application, pooled RLS, hosted authentication, deployment,
backup/PITR or production acceptance. No provider hostname, connection string, credential, endpoint
ID or token belongs in J.

### 7.1 Recovered MCG-01 human evidence

Main recovers the following from the human-observed 2026-07-15 session as sanitized operational
evidence. It was previously present in conversation but not promoted into permanent domain memory.

Environment observations:

- Neon Free development environment in `us-west-2` with PostgreSQL 18.4;
- child development branch `markei-cycle10-development` derived from `production`;
- disposable database `markei_sync_dev`;
- production branch not used for probes;
- branch expiry was adjusted during the session, but its current expiry requires reconfirmation.

Role and connectivity observations:

- SQL-created `markei_migrator` and `markei_runtime` login identities;
- neither identity reported superuser, role-administration, replication, bypass-RLS or
  `neon_superuser` membership;
- migrator connected through the direct endpoint and could create schema objects;
- runtime connected and could not create schema objects;
- client connection negotiated TLS 1.3 and the separate channel-binding configuration worked;
- credentials remained outside Git and were not included in sanitized evidence.

Transactional and privilege probes:

- migrator created and inserted into a disposable table inside a transaction;
- rollback removed both inserted data and the table;
- runtime performed explicitly granted SELECT, INSERT, UPDATE and DELETE on a probe table;
- runtime `CREATE TABLE` failed with permission denied for schema `public`;
- the unauthorized table was absent;
- all three probe objects were absent after cleanup.

PRC-01 result:

```text
MCG-01_SANITIZED_DEVELOPMENT_ENVIRONMENT_PASS
```

Evidence boundary: manual observation and pasted terminal output. No secret or provider identifier
is preserved. This does not establish migration 003/004 application, production RLS, hosted API
behavior, backup/PITR, provider availability or production acceptance.

### 7.2 Recovered MCG-02 preparation evidence

Main recovers the following as provider-dashboard preparation only:

- Render Web Service and Auth0 were selected as the provisional development providers;
- separate Auth0 Native Applications were prepared for Android and Windows;
- the Android application identifier was configured and its certificate/deep-link steps were
  traversed in the Auth0 quickstart;
- a Windows Native Application and callback/protocol preparation were traversed;
- a Markei custom API/audience and RS256-shaped token boundary were prepared;
- no native client secret was intended or authorized;
- Render was connected to the GitHub repository and the New Web Service form was reached;
- the intended service was recognized as a Node service under `services/markei_sync_api`, although
  the dashboard initially inferred the repository as Python;
- environment-variable entry was identified, but no approved hosted secret set was established;
- no Render deployment, Neon migration, real hosted login, token acceptance, Device enrollment or
  hosted synchronization proof was completed.

The exact Auth0 tenant/app identifiers, callbacks, certificate fingerprint, audience, Render URL,
Neon hostname and all credentials remain excluded from J and permanent documentation.

PRC-01 result:

```text
MCG-02_PROVIDER_DASHBOARD_PREPARATION_PARTIAL
MCG-02_HOSTED_PROOF_NOT_PERFORMED
```

This recovered evidence cannot activate C10-S03B because the C10-S03A transaction-time
authorization contradiction remains unresolved.

### 7.3 Manual-action methodology recovery

Future Manual Configuration Gates use this evidence route:

```text
human observation
→ sanitized evidence block
→ Main staging and PRC-01 boundary
→ Operational/Didactic/Design promotion by semantic ownership
→ Main reconciliation
→ next provider gate
```

Dashboard completion marks configuration state, not application validation. A provider mutation is
not permanent project truth until its sanitized evidence, environment, exclusions and unknown
outcomes are staged and reconciled. Main may capture cross-domain gate state in J, but permanent
Operational, Didactic and Design meaning remains owned by the corresponding domain chats.

### 7.4 Permanent-domain promotion handoff for recovered MCG evidence

Operational promotion candidates:

- MCG-01 sanitized pass, commands/probes, cleanup and current branch-expiry recheck;
- MCG-02 dashboard preparation, incomplete deployment and exact remaining manual gates;
- the rule separating direct migrator and pooled runtime connections.

Didactic promotion candidates:

- manual configuration versus validation;
- authentication versus membership, enrollment and authorization;
- build/deployment evidence versus hosted workflow acceptance.

No learner maturity or Lecture Register change follows automatically.

Design promotion candidates:

- provider trust boundaries and server-only secrets;
- migrator/runtime responsibility separation;
- separate Native Applications and no embedded native client secret;
- dashboard/provider choices as provisional until hosted proof.

Domain chats must use PRC-01 and must retain `C10-S03A_CONTRADICTED_STOP`. They may promote MCG-01
evidence and MCG-02 preparation state, but not hosted-auth readiness or Cycle 10 closure.

## 8. C10-S03B / MCG-02 readiness

`C10-S03B` is **not ready**. Do not migrate Neon, deploy Render, enter provider secrets, provision
real identities or begin Android/Windows Auth0 proof.

The previously proposed MCG-02 manual sequence remains staged but inactive. It may be reactivated
only after C10-S03A-R1 corrects the security boundary, completes the decisive validation floor and
Main reconciles new G/H/I evidence.

## 9. Corrective restaging authority

This J reconciliation does not itself authorize source correction. The next bounded sequence is:

1. A/B/C investigate only the transaction-time authorization, JWT/JWKS failure floor,
   least-privilege harness topology and missing Flutter lab boundary.
2. Main reconciles new J/D/E/F for `C10-S03A-R1`.
3. Corrective D/F must place membership, enrollment and Device rechecks/locks in the same database
   transaction as each protected operation, without passing a trusted context across transactions.
4. Corrective D/F must define a bounded JWKS fetch/parse layer or equivalent explicit response-size
   control and the full named adversarial matrix.
5. The decisive harness must migrate/provision with a migrator identity and run hosted HTTP with a
   separate least-privilege runtime identity.
6. The harness must add two Accounts, cross-Account denial, membership disable/removal,
   concurrent enrollment/revocation, restart and route-wide recovery cases.
7. D/E/F must decide whether the neutral Flutter lab composition remains required for S03A-R1 or is
   explicitly moved to human MCG-02 without overstating readiness.
8. Codex publishes corrected implementation and new G/H/I.
9. Main performs a new post-Codex reconciliation before any provider activity.

## 10. Permanent-domain handoff

FLX-PRM-04 permanent promotion is blocked for the hosted-readiness claim. Domain chats may later
retain the contradiction as observational history, but must not promote C10-S03A readiness.

Future destinations after successful corrective reconciliation remain:

- Operational: `operational/04_TODO.md`, `10_OPERATIONAL_STATE.md`,
  `11_OPERATIONAL_RECORD.md`, `12_OPERATIONAL_MODEL.md`;
- Didactic: `didactics/02_KANBAN.md`, `07_GLOSSARY.md`, `08_CONCEPT_MAP.md`,
  `13_LECTURE_REGISTER.md`;
- Design: `design/01_ARCHITECTURE.md`, `03_DECISION_LOG.md`, `09_DESIGN_STATE.md`,
  `14_MODEL_OVERVIEW.md`.

No file is assumed to require change. Learner maturity and lecture history still require explicit
learner evidence.

## 11. MCG-03 and MCG-04 definition gate

The current runbook defines MCG-01 and MCG-02 only. Because MCG-02 is blocked, no MCG-03/04
candidate is mature enough for authorization or provider instructions.

Any future candidate must remain:

```text
CANDIDATE — NOT AUTHORIZED
```

and state the problem not already closed by MCG-02, manual/provider action, repository support,
evidence, security/privacy boundary, MCG-02 dependency and Cycle ownership.

## 12. Cycle 10 closure readiness

Cycle 10 remains open. Current blockers are:

- C10-S03A transaction-time authorization contradiction;
- incomplete JWT/JWKS and concurrency failure evidence;
- missing least-privilege decisive HTTP topology;
- unresolved Flutter lab boundary;
- incomplete MCG-02 provider proof.

No Cycle 11 UI/UX or Analytics work is activated by this result.

## 13. Terminal Main reconciliation status

```text
C10-S03A_CONTRADICTED_STOP
```

Provider progression stops. New D/E/F authority is required before corrective materialization.
