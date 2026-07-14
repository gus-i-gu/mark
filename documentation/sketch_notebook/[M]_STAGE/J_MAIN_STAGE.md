# J_MAIN_STAGE — Cycle 10 Opening Charter and Investigation Conciliation

> Sequence: Cycle 09 closure → human scope expansion → A/B/C investigation → later Main reconciliation
> Cycle: 10 — Cross-Platform Local Beta Consolidation and Inter-Device Coordination
> Status: OPENING CHARTER; A/B/C INVESTIGATION AUTHORIZED; SOURCE IMPLEMENTATION INACTIVE
> Branch: `intermid-cycle-recovery`
> Required starting ancestry: `7ac003e754a486dc7f24016386a737bdb6dee830`
> Cycle 09 implementation baseline: `1d817972aea0229c9f109f236f4d224671927aab`
> Authority: human direction reconciled by Main Chat [M]

---

<!-- ROUND_MARKER:C10-OPENING-CHARTER-2026-07-14 -->

## 1. Purpose and current authority

This J opens Cycle 10 and describes the investigation envelope for A/B/C. It supersedes the
Cycle 09 closure assumption that API/Neon/synchronization would remain outside Cycle 10.

Cycle 10 now combines:

1. the already proposed local-beta consolidation work; and
2. an API-mediated Neon/PostgreSQL foundation for inter-device updating.

This is an investigative charter, not D/E/F and not Codex authority. Functional chats may inspect
the repository, existing documentation and relevant authoritative external specifications, then
write only their A/B/C stages. No source, schema, dependency, cloud resource or permanent-domain
mutation is authorized by this file.

## 2. Reconciled starting state

Cycle 09 closed with schema v4, mandatory Product codes, local Person/Payment references, manual
Purchase occurrence, exact-code autofill, same-unit BULK calculation and local export generation.
Its named automated and Windows build/smoke evidence remains narrow; Android and complete manual
platform evidence remain open.

Repository inspection shows existing synchronization preparation:

- local Account and app-private Device identities;
- Device-owned monotonic sequence allocation;
- immutable local `SyncEvent` envelopes;
- `PendingEvent` state;
- synchronization metadata and migration ledger;
- atomic Purchase/event/pending-event persistence;
- older architecture preference for a controlled API in front of Neon Postgres.

These are foundations, not proof of upload, download, authentication, acknowledgement, conflict
resolution, convergence or secure cloud operation. Existing local identity selection is explicitly
prototype-bounded and must be revisited before realistic multi-device history.

## 3. Governing topology and security boundary

The accepted direction to investigate is:

```text
local01 Drift database
    ↕ authenticated HTTPS synchronization
controlled application API
    ↕ least-privilege server connection
Neon-hosted PostgreSQL coordination state
    ↕ controlled application API
local02 Drift database
```

Neon is the managed PostgreSQL layer, not a client-facing application API. Flutter clients must
not contain privileged PostgreSQL/Neon credentials or connect directly to the database.

Local Drift remains the offline-first operational store. Server-side coordination exists only for
accepted synchronization purposes. No developer analytics, unrelated profiling, advertising data
use or silent external export enters scope.

“Ephemeral” cannot mean deletion before an offline receiving Device can recover an update. A/B/C
must investigate a bounded retention lifecycle involving acknowledgement, expiry, retry, recovery
and account deletion. Exact retention time is not yet accepted.

## 4. Manual configuration break rule

Cycle 10 uses explicit Manual Configuration Gates (MCGs). An MCG is a minimal localized sprint
performed by the human when external Neon/API configuration is required.

At every MCG:

1. Codex and domain work stop before the external mutation;
2. the repository remains runnable at the last verified checkpoint;
3. the human receives a short provider-console/local-environment checklist;
4. secrets remain outside Git, notebook prose, screenshots, logs and chat output;
5. only secret names, scopes, fingerprints or redacted presence may be reported;
6. a bounded connectivity/permission probe is recorded;
7. continuation requires explicit human confirmation.

No repo refactoring may continue merely because a configuration step was assumed successful.

Proposed manual gates, subject to A/B/C investigation:

- **MCG-01 — isolated Neon environment:** create/select project, branch, database and least-privilege
  roles; establish secret injection and disposal boundaries.
- **MCG-02 — API runtime:** configure deployment/local runtime variables, TLS endpoint, migration
  identity and server-only database access.
- **MCG-03 — Account/Device test identities:** configure the minimum authentication or pairing
  material for two controlled test Devices without embedding permanent secrets.
- **MCG-04 — two-device evidence environment:** prepare local01/local02 fixtures, server cleanup,
  retention observation and teardown.

## 5. Ten Cycle 10 phases

### C10-01 — Baseline, vocabulary and threat model

Freeze the implementation/documentation baseline; inventory existing sync scaffolding; define
assets, trust boundaries, threats, evidence matrix, fixtures and rollback rules. Decide which
external facts require current official documentation. Prepare MCG-01; do not configure it yet.

### C10-02 — Account, installation and Device identity

Resolve provisional `local-account`, current-installation ownership, Device lifecycle, pairing,
credential storage, revoked/lost Device behavior and preserved historical Devices. Identity must
not be inferred from hardware identifiers, labels or Product/User nicknames.

### C10-03 — Local outbox/inbox and idempotent event model

Reconcile existing SyncEvent/PendingEvent structures with upload and download needs. Define event
identity, SubmissionId/retry identity, sequence/cursor rules, payload versioning, inbox deduplication,
atomic apply, unknown outcomes and crash recovery before network implementation.

### C10-04 — API contract and Neon/PostgreSQL transition schema

Define authenticated endpoints, request/response envelopes, authorization, validation, error
semantics, physical server ownership, migrations, indexes and least-privilege roles. Prove locally
or disposition MCG-01/MCG-02 before repo integration. Exact framework/tooling remains investigative.

### C10-05 — Upload, download, acknowledgement and retention

Define batching, cursors, safe retries, accepted/rejected outcomes, per-Device acknowledgement,
bounded retention, expiry, cleanup, account deletion and recovery when a Device remains offline or
never acknowledges. Demonstrate that server deletion cannot silently strand required updates.

### C10-06 — Conflict, retry and convergence policy

Classify entities and facts as immutable, append-only, replaceable or derived. Define duplicate,
concurrent and out-of-order handling; conflict surfacing; deterministic convergence; and rebuild of
derived Lists. Do not use blanket last-write-wins without entity-specific justification.

### C10-07 — Local migration, recovery and export integrity

Complete representative v1/v2/v3→v4 migration/reopen/failure evidence; test rollback and no-silent-
reset; validate deterministic CSV/PDF artifacts; and decide export-only versus local backup/restore.
Cloud synchronization must not become an undocumented backup substitute.

### C10-08 — Measurement and behavior-preserving modularization

Measure Lists, lookup, History, export and sync queues before indexes/paging. Extract oversized
Purchase/Catalogue/History code only behind regression evidence and without intentional UI/UX change.
Pause around MCGs rather than mixing provider configuration with broad refactoring.

### C10-09 — Windows, Android and two-device evidence

After MCG-03/MCG-04, validate offline operation, upload, download, retry, duplicate delivery,
interrupted transfer, acknowledgement, convergence and teardown across controlled local01/local02.
Classify Windows, Android, emulator, physical-device, lifecycle and manual evidence separately.

### C10-10 — Promotion, reconciliation and closure

Codex reports G/H/I after authorized materialization. Domain chats perform PRC-01 promotion into
permanent memory. Main reconciles evidence, human observations, configuration records and domain
checkpoints before refreshing 00/05/06. No cloud/security/release claim is closed by code presence.

## 6. Cycle 11 boundary

Cycle 11 continues to own target-image UI polishing, page-level UX recomposition, full Lists visual
presentation, shared-component adoption, Product-detail/History interaction refinement, native-share
presentation, accessibility improvement and the proposed minimum Analytics page.

Cycle 10 may extract code without intentional visible change and may record UX/accessibility
observations. It must not consume the Cycle 11 redesign merely to make synchronization visible.

## 7. Required A/B/C investigation outputs

All domains must classify claims with PRC-01 vocabulary and distinguish accepted direction,
existing implementation, named validation, host-unvalidated state, proposals, blockers and deferral.

### A — Operational

Own the executable phase/checkpoint plan, environments, MCG runbooks, secret-safe evidence,
dependency/toolchain inventory, rollback, validation matrix, failure injection and stop conditions.

### B — Didactic/UX

Own stable synchronization vocabulary, user-visible state/recovery semantics, offline/online truth,
privacy explanations, configuration learning risks and evidence boundaries. Do not redesign Cycle 11 UI
or change learner maturity without learner evidence.

### C — Design/Architecture

Own trust boundaries, Account/installation/Device identity, event protocol, API responsibilities,
Neon/Postgres schema alternatives, acknowledgement/retention, conflict/convergence, local/cloud
authority and migration boundaries. Do not operationally validate or select tools without evidence.

## 8. Decisions Main must reconcile after A/B/C

1. Account authentication and Device enrollment model.
2. Explicit current-installation→Device invariant and migration.
3. SubmissionId/event/cursor/inbox identity rules.
4. API language/framework, hosting and migration tooling.
5. Neon project/branch/database/role layout and environment separation.
6. Payload scope: which facts synchronize in the first vertical slice.
7. Per-entity conflict and convergence policy.
8. Acknowledgement, retention, expiry, cleanup and account-deletion policy.
9. Export-only versus local backup/restore boundary.
10. Required Windows/Android/two-device acceptance matrix.

## 9. Preserved prohibitions

- never commit or print credentials, tokens, connection strings or private keys;
- no privileged client database access;
- no implicit upload, analytics or unrelated retention;
- no production environment before disposable/local protocol evidence;
- no cloud claim from local queue preparation alone;
- no broad refactor across an unresolved manual configuration gate;
- no source implementation until A/B/C are reconciled into active D/E/F;
- no public release, store publication, Household behavior or Cycle 11 UI/Analytics work.

```text
Cycle 10: investigation opened
A/B/C staging: authorized
manual Neon/API configuration: gated and human-confirmed
D/E/F: not prepared
Codex/source/cloud mutation: inactive
```
