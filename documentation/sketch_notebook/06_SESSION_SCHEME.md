# 06_SESSION_SCHEME.md

> Version: Cycle 10 conditional forward checkpoint 1.0
> Status: Active Forward Checkpoint — perspective only
> Persistence Class: Forward Checkpoint
> Knowledge Class: Main / Prospective
> Authority: Main Chat [M]
> Branch: `intermid-cycle-recovery`
> Cycle 09 implementation: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Post-Codex reconciliation: `8c542c3174f3f070312c3d4169886a6f36bc00a0`
> Permanent-domain baseline inspected: `eaa12efe3815ecf9cac34255eadca5010c7af505`
> Current-state source: `00_PROJECT_STATE.md`

---

<!-- TEMPORAL_MARKER:C10-CONDITIONAL-PERSPECTIVE-2026-07-14 -->

# Cycle 10 Perspective — Cross-Platform Beta Consolidation

## 1. Status and governing condition

Cycle 09 Sprint 01 is reconciled. Cycle 10 is not active implementation authority.

Before activation, human/Main must choose one transition:

```text
Option A
    finish Cycle 09 with a bounded correction unit
    → reconcile it
    → activate Cycle 10 from a clean local-beta baseline

Option B
    accept/defer the remaining Cycle 09 contradictions explicitly
    → make them Cycle 10 Unit 01
    → freeze fresh A/B/C and D/E/F
```

The transition must not relabel partial behavior as accepted completion.

## 2. Proposed mission

Cycle 10 should consolidate the cross-platform local beta into a reliable, explainable and
recoverable application boundary.

Proposed mission:

> Correct the remaining local data/UI contradictions, complete truthful recovery/export
> interactions, and establish Windows/Android beta evidence before broader analytics,
> synchronization or public-release work.

This perspective narrows the older generic “release preparation” schedule. Production
release remains a later acceptance state unless Cycle 10 evidence actually earns it.

## 3. Expected starting state

Available from Cycle 09:

- Flutter/Drift schema v3 and sequential legacy migration route;
- Home, Lists, Purchase, History, Catalogue and Settings;
- local optional People/Payment Method labels;
- Product normalization/exact-lookup ports;
- quantity and unit normalization;
- transient personal-cycle Lists;
- History CSV and PDF-byte generation;
- Windows release build/smoke evidence;
- protected Python/PySide6 isolation.

Carried boundaries:

- Android host/runtime/lifecycle unvalidated at the Cycle 09 Codex host;
- incomplete BULK price-per-unit workflow;
- nickname archive uniqueness conflict;
- partial error, exact lookup, Product details and History interactions;
- manual temporary-file PDF flow only;
- missing Cycle 09 Didactic permanent absorption;
- no release, synchronization or Analytics acceptance.

## 4. Proposed workstreams

### A. Data and pricing correctness

- replace BULK Line total input with Price per unit and derived half-up minor-unit total;
- preserve one authoritative persisted price/total model;
- correct active-only nickname uniqueness without losing archived history;
- decide whether nullable Product-code storage remains compatibility policy;
- prove representative migration, failure rollback, close/reopen and no-silent-reset.

### B. Truthful interaction and recovery

- map typed failures to field/operation/recovery/outcome UI messages;
- expose exact Product-code and exact-identification lookup explicitly;
- complete adaptive Product details and accessible History selection conveniences;
- preserve drafts on known-not-applied failures and distinguish unknown outcomes;
- keep optional Person/Payment Method absence non-blocking.

### C. Export, portability and local recovery

- add user-selected CSV/PDF destinations with cancellation and failure reporting;
- decide native share scope per supported platform;
- define overwrite, cleanup and privacy behavior;
- investigate export/import or backup/restore without claiming cloud synchronization;
- keep exports selected, explicit, read-only and local unless the user chooses otherwise.

### D. Cross-platform beta evidence

- rerun full Flutter tests and analysis;
- validate Windows build plus complete manual Home→Catalogue→Purchase→Lists→History flow;
- restore Android Java/Gradle toolchain and validate build/install/launch;
- exercise narrow layouts, keyboard, Back, rotation, background/resume and larger text;
- preserve Python regression and database-isolation checks;
- classify emulator, physical-device, lifecycle and release evidence separately.

### E. Documentation and learning continuity

- absorb Cycle 09 terminology into Didactic permanent memory without changing maturity;
- keep project tests separate from learner evidence;
- document user-visible local-only/privacy boundaries;
- update Guide/Documentation copy only from accepted behavior.

## 5. Suggested bounded units

```text
C10-U01  A/B/C investigation and correction-scope decision
C10-U02  BULK pricing or schema-constraint correction — one migration boundary
C10-U03  typed errors, exact lookup and Product-detail interaction
C10-U04  export destination, PDF/native-share and recovery boundary
C10-U05  Windows/Android responsive and lifecycle acceptance
C10-U06  permanent-domain and Main-root reconciliation
```

Do not combine U02 schema work with unrelated UI/export dependencies merely for schedule
convenience. Each unit needs one invariant, rollback boundary and evidence story.

## 6. Explicit non-goals without new human direction

- authentication, authorization, TypeScript API or Neon;
- upload/download, cursor bootstrap, convergence or multi-device synchronization;
- remote usage analytics or developer-side data retention;
- full Analytics implementation; the current human direction places a small Analytics set
  around Cycle 11 rather than this immediate consolidation;
- Household collaboration behavior;
- Product merge/correction or Store redesign;
- public release, production signing or store publication;
- PySide6 retirement.

Local SyncEvent/PendingEvent rows remain preparation, not synchronization.

## 7. Evidence gates

Cycle 10 may claim a behavior only at its narrowest proven boundary:

| Claim | Minimum evidence |
| --- | --- |
| code exists | repository inspection |
| pricing/error/projection works | focused unit/widget tests |
| schema correction preserves data | file-backed migration, reopen and failure evidence |
| export/share works | generated artifact plus destination/cancel/platform observation |
| Windows beta workflow works | build and recorded manual workflow |
| Android beta workflow works | build/install/launch/runtime/lifecycle observation |
| learner maturity changed | explicit learner explanation or application evidence |
| release-ready | signing, upgrade, privacy, recovery, support and distribution evidence |

No single widget suite, emulator run or bounded launch proves production acceptance.

## 8. Human/Main decisions required at entry

1. Are the Cycle 09 contradictions a final Cycle 09 correction or Cycle 10 Unit 01?
2. Is native OS sharing required, or is user-selected save sufficient for the beta?
3. Does Cycle 10 require import/restore, or only deterministic export and documented local
   database recovery?
4. Which Windows and Android devices/lifecycle checks are mandatory for exit?
5. Should Product-code nullability be preserved for compatibility or corrected by migration?
6. Is the archived-nickname uniqueness correction required before further user testing?
7. Is Cycle 10 still local-only consolidation, with account/API/Neon deferred?

## 9. Entry and exit direction

Entry requires:

- latest shared branch pulled and clean/understood;
- Didactic no-change/follow-up disposition acknowledged;
- one human-selected first unit;
- fresh domain investigation where semantics remain unsettled;
- fresh D/E/F before source, schema, dependency or host mutation.

Proposed Cycle 10 exit:

- selected Cycle 09 contradictions corrected or explicitly deferred;
- migration/recovery evidence matches schema risk;
- export/share behavior is truthful and user-controlled;
- complete Windows beta workflow recorded;
- Android boundary either evidenced or explicitly host-unvalidated with a recovery plan;
- domain checkpoints and Main continuity reconciled;
- Analytics/synchronization/release claims remain inactive unless separately authorized and
  evidenced.

## 10. Recovery route and authority

Read in the next Main session:

1. `00_PROJECT_STATE.md`;
2. this forward checkpoint;
3. Operational and Design current checkpoints;
4. Didactic checkpoint and its Cycle 09 absorption status;
5. post-Codex J and G/H/I only for unresolved evidence;
6. repository source only for the selected first unit.

```text
Cycle 09 Sprint 01 authority: consumed
Cycle 10 perspective: active as planning only
A/B/C investigation: requires human/Main unit selection
D/E/F: not prepared
source/schema/dependency/host mutation: inactive
commit/push for future work: requires ordinary authority
```
