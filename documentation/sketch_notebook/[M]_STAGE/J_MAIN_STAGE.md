# J_MAIN_STAGE — Cycle 10 Local Convergence Evidence Reconciliation

> Sequence: FLX-ORD-01 Codex materialization → Main evidence reconciliation
> Unit: C10-S01B — Local synchronization convergence completion
> Status: LOCAL CONVERGENCE ACCEPTED; MCG-01 ELIGIBLE BUT NOT STARTED
> Branch: `intermid-cycle-recovery`
> Controlling implementation: `14c7894e21139390f83a8787be368d3633aa20dd`
> Reconciled authority: J/D/E/F at `cb890dcdaf86cefa875e6984f20a71e20a912f60`
> Inputs: G/H/I, implementation diff and focused source/test inspection
> Authority: human-supervised Main synthesis

---

<!-- ROUND_MARKER:C10-S01B-EVIDENCE-RECONCILIATION-2026-07-14 -->

## 1. Main finding

Main accepts the C10-S01B decisive local convergence proof. The implementation replaces the prior
download, acknowledgement, transport and remote-apply stubs with one executable path:

```text
isolated Drift A
→ Flutter HTTP transport
→ loopback Fastify A
→ disposable PostgreSQL 18
→ loopback Fastify B
→ Flutter HTTP transport
→ isolated Drift B
```

The evidence is sufficient to close the corrective local slice. It is not evidence of live Neon,
production authentication, deployed service operation, long-term retention, backup, restore or
product-ready multi-device synchronization.

Terminal classification:

```text
C10-S01B_LOCAL_CONVERGENCE_PROVED
MCG-01_NOT_STARTED
```

## 2. Evidence accepted

### 2.1 Protocol and transport

- `purchase.registered` payload version 3 now carries closed immutable Store, Product, Purchase,
  Item, quantity and Money facts.
- Nested contract objects reject undeclared fields through `additionalProperties: false`.
- Canonical recursively sorted UTF-8 JSON and lowercase SHA-256 remain aligned in Dart and
  TypeScript for the shared fixture.
- `HttpSyncTransport` implements upload, download and acknowledgement through injected URI, token
  source, HTTP client, timeouts and bounded responses without payload or credential logging.
- Cursor tokens use the versioned opaque `c10b:<integer>` lab representation. Client application
  stores and echoes the token and verifies page continuity.

### 2.2 Local fact application

- `DriftRemoteEventApplier` validates Account, type/version, content hash and cursor continuity.
- `RemotePurchaseFactWriter` inserts or reuses equivalent Store/Product/Purchase/Item facts.
- Facts, inbox identity and cursor commit in one Drift transaction.
- Duplicate-equivalent replay has no second business effect.
- Identity/content conflict stops without cursor advancement.
- Remote apply creates no outbound `SyncEvent` or `PendingEvent` echo.
- Greatest acknowledgement cursor now comes from committed `sync_state.account_cursor`, not the
  maximum observed inbox cursor.

### 2.3 API and PostgreSQL

- Upload, download and acknowledgement authenticate through the injected verifier and execute
  against PostgreSQL rather than fixed route responses.
- Account/Device identity comes from verified context; queries retain explicit Account predicates.
- Transactions set Account/Device database context and use serializable isolation.
- SQLSTATE `40001` and `40P01` have a bounded maximum of three transaction attempts within the
  implementation deadline.
- Upload preserves Submission replay, Event duplicate equivalence, exact DeviceSequence and atomic
  cursor allocation.
- Download returns ordered Account events with bounded page size.
- Acknowledgement rejects a cursor above the Account high-water mark and persists a monotonic
  per-Device cursor.
- Forward-only migration `002_coordination_hardening.sql` leaves 001 unchanged and adds composite
  Account/Device FKs, indexes, migration ledger evidence, runtime grants and Account RLS policies.

### 2.4 Decisive system story

The lab-gated test proved:

1. Device A registered one Purchase while local.
2. The server committed the upload and the first response was dropped.
3. A retained `unknown-outcome` and retried the same SubmissionId.
4. PostgreSQL retained one server Event and returned the equivalent stored response.
5. Device B downloaded one Event over HTTP.
6. B applied one Store/Product/Purchase/Item aggregate atomically.
7. Replay was duplicate-equivalent and produced no outbox echo.
8. B acknowledged one committed cursor through HTTP.
9. Reopened A and B each contained one Purchase and one Item.
10. Disposable containers and volumes were torn down.

## 3. Validation accepted

G reports the following passed at implementation commit `14c7894`:

- Drift generation, Dart formatting, Flutter analysis and the complete Flutter suite;
- the explicit lab-gated HTTP/PostgreSQL convergence harness with `CONVERGED=true`;
- TypeScript format, lint, typecheck, tests and production-dependency audit;
- protected Python regressions;
- Windows release and Android debug builds;
- `git diff --check`, credential-pattern scan and disposable-resource teardown.

These results validate the stated local host/build boundary. Builds do not establish Android runtime,
manual Windows workflow, accessibility, production network or provider acceptance.

## 4. Evidence corrections and residual gaps

Main corrects one report inconsistency: G labels its changed-path inventory complete but omits the
new file `clients/markei_flutter/test/sync/real_convergence_harness_support.dart`. The Git commit's
26-path inventory controls over the prose inventory.

The accepted proof is intentionally narrower than the complete D/F adversarial floor:

- serialization/deadlock retry code exists, but retry exhaustion is not expanded into a decisive
  database fault-injection matrix;
- malformed, oversized and every closed-schema rejection branch are not exhaustively exercised;
- RLS, constraints and Account predicates exist, but per-table cross-Account SELECT/INSERT/UPDATE
  probes are not reported as a complete matrix;
- the decisive harness covers one page and replay, not a full empty/paged/gapped/reordered cursor
  matrix through the real HTTP/PostgreSQL path;
- non-null Person and Payment Method references are rejected until complete immutable snapshots
  exist; the proved fixture uses the supported null-reference boundary;
- the normal application remains synchronization-disabled and has no production composition.

These gaps do not reopen the bounded local convergence story. They remain mandatory hardening before
production credentials, external beta acceptance or a claim of robust multi-device operation.

## 5. Semantic and Didactic reconciliation

Accepted meanings remain:

```text
saved-local → waiting-upload → uploading → server-accepted
download-received → downloaded-applied → acknowledged by this Device
duplicate-equivalent | conflict | not-applied | unknown-outcome
```

`server-accepted` does not mean another Device applied the event. `acknowledged` does not mean every
Device converged. Synchronization is not backup, export, restore or permanent relay history.

No sync dashboard, pairing page, Device-management page, navigation change or Cycle 11 visual work
was added. Learner/KANBAN maturity remains unchanged because repository evidence cannot manufacture
direct learner evidence.

## 6. Architecture retained

The accepted dependency direction is:

```text
Flutter domain/application ports
→ Drift and HTTP infrastructure adapters
→ API authentication/application boundary
→ PostgreSQL runtime transactions
```

Flutter never receives PostgreSQL credentials and never connects directly to PostgreSQL. Fixture
claims are limited to tests and the explicit loopback lab entrypoint; normal runtime still refuses
authentication. PostgreSQL remains disposable local infrastructure in this evidence round.

No decision is made here for the production identity provider, Device enrollment, hosted runtime,
Neon physical layout, retention duration, snapshots, rebootstrap, account deletion or edits/deletes.

## 7. MCG-01 disposition

C10-S01B satisfies the local prerequisite for considering MCG-01. MCG-01 is not automatically
executed or validated by this reconciliation. It may begin only as a separate, human-controlled
provider configuration unit with a clean repository checkpoint.

Human actions at MCG-01 remain:

1. create or select an isolated Neon project and non-production development branch;
2. confirm plan support, branch behavior, region, PostgreSQL version, costs and teardown ownership;
3. create a disposable database plus separate migration and least-privilege runtime roles;
4. place connection material only in approved local/deployment secret storage;
5. run sanitized connectivity, migration-hash and privilege probes;
6. return aliases, role names, version, timestamps and redacted pass/fail evidence only.

Do not paste passwords, tokens, credential-bearing URLs or private keys into chat, Git, screenshots
or notebook files. If the subscription exposes only a production branch, stop and investigate the
plan/project configuration; do not repurpose production as the disposable development target.

## 8. Next Main decision gate

Before any second provider-backed implementation, Main must reconcile:

- the actual MCG-01 redacted evidence and Neon branch constraints;
- whether the residual adversarial matrix is completed locally before provider integration;
- production authentication and Device enrollment alternatives;
- hosted API runtime and server-only secret injection;
- migration ownership and environment promotion rules;
- retention, acknowledgement expiry, snapshot and rebootstrap policy;
- the non-null Person/Payment snapshot contract;
- two physical Device fixtures and teardown rules for later MCG-03/MCG-04.

MCG-02, MCG-03 and MCG-04 remain inactive. UI/UX polishing, visual convergence, accessibility and
Analytics remain Cycle 11 work.

## 9. Publication boundary

This reconciliation updates J only. G/H/I remain observational evidence and D/E/F remain the
historical controlling contract for C10-S01B. Permanent Operational, Didactic, Design and Main-root
owners are unchanged. No source, dependency, provider resource or secret is modified here.
