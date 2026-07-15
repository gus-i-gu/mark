# 08_CONCEPT_MAP.md

> Status: Cycle 10 recovered Didactic checkpoint
> Branch: `intermid-cycle-recovery`
> Promotion baseline: `75fbba66d19df722820b8667ac7886c09b64fb2b`
> Sequence: FLX-PRM-04
> Canonical owner: `02_KANBAN.md`
> Derived retrieval: `07_GLOSSARY.md`
> Learner maturity: unchanged

## Current milestone

Cycle 10 has accepted local implementation evidence for synchronization, bounded retention,
snapshots and fresh-target rebootstrap inside disposable development topologies. A sanitized manual
MCG-01 development-environment probe is accepted within its stated provider boundary. MCG-02
provider-dashboard preparation is partial, but hosted authentication and synchronization proof were
not performed.

C10-S03A remains stopped by a transaction-time authorization contradiction and incomplete decisive
validation. Cycle 10 is not closed.

```text
C10-S03A_CONTRADICTED_STOP
MCG-02_HOSTED_PROOF_NOT_PERFORMED
```

## Maturity

No KANBAN status changed.

- Source, tests, builds, local convergence, provider configuration and manual probes are project evidence.
- Learner maturity still requires direct explanation, comparison, debugging, prediction or transfer.
- No Lecture Register event is created by this promotion.
- MCG-03 and MCG-04 remain undefined candidates and are not active learning commitments.

## PRC-01 promotion result

| Candidate | Result | Boundary |
| --- | --- | --- |
| MCG-01 sanitized development-environment evidence | checkpoint promotion | manual, redacted development probe only |
| MCG-02 provider-dashboard preparation | checkpoint promotion as partial | configuration preparation; no hosted workflow proof |
| manual configuration versus validation | promote relationship | durable evidence distinction |
| authentication, membership, enrollment and authorization distinction | promote relationship | durable domain semantics |
| accepted local synchronization and recovery evidence | checkpoint promotion | disposable local/lab topology |
| hosted-auth readiness | reject | contradicted by Main reconciliation |
| provider acceptance or deployment | reject | no hosted proof |
| Cycle 10 closure | reject | blocking corrective work remains |
| learner maturity change | reject | no learner evidence |
| MCG-03/04 vocabulary | retain outside active memory | not defined or authorized |

## Stable evidence relationships

```text
configuration prepared
!= provider workflow executed
!= hosted validation
!= production acceptance

build passed
!= deployed
!= authenticated workflow accepted

local disposable proof
!= hosted provider proof
!= production readiness

human observation
→ sanitized evidence
→ Main PRC-01 classification
→ domain-owned promotion
→ later gate decision
```

A provider dashboard can record that settings were entered or preparation steps were traversed. It
does not prove that an application received a token, that the API accepted it, that membership and
Device authorization succeeded, or that facts synchronized.

## Identity and authorization spine

```text
external identity
→ token presented
→ token verified
→ Account membership resolved
→ installation enrollment resolved
→ server Device authorized
→ protected operation permitted
```

These stages remain distinct:

- an external subject identifies one principal at an issuer; it is not a Markei AccountId;
- token verification establishes token validity for the intended issuer/audience boundary;
- Account membership associates the external principal with one Markei Account;
- an InstallationId identifies one local installation context;
- Device enrollment binds an installation to a server Device identity under an Account;
- Device authorization checks whether that enrolled Device may perform the named operation;
- revocation withdraws server authorization but does not remotely erase autonomous local facts;
- authentication failure and authorization denial are different outcomes.

The implemented C10-S03A model demonstrates several of these concepts locally, but route-wide
transaction-time authorization is not accepted because the membership/enrollment check and protected
mutation do not share the required transaction boundary.

## Synchronization and recovery spine

```text
saved locally
→ queued
→ server accepted
→ downloaded
→ facts applied
→ acknowledged by this Device
→ named convergence evidence
```

```text
valid retained cursor
→ incremental catch-up

expired cursor
→ compatible application snapshot
→ fresh-target rebootstrap
→ incremental catch-up
→ acknowledgement and reopen evidence
```

Accepted local evidence includes:

- one complete Purchase aggregate moving through Flutter HTTP, API, PostgreSQL and another Drift database;
- idempotent replay after an unknown upload outcome;
- duplicate-equivalent apply without a second business effect;
- Device acknowledgement after committed local application;
- bounded event retention guarded by eligible-Device acknowledgement and validated snapshot coverage;
- typed cursor expiry distinct from a valid empty page;
- resumable snapshot transfer and fresh-target rebootstrap;
- local unsent changes blocking destructive rebootstrap;
- server cleanup leaving autonomous local Purchase history intact.

These claims remain limited to synthetic, disposable development evidence. Synchronization is not
provider backup, export, permanent retention, universal delivery or future recovery under every
offline duration.

## MCG-01 accepted evidence boundary

The sanitized development-environment evidence establishes only that a disposable managed
PostgreSQL development environment was manually exercised with:

- an isolated non-production development branch and disposable database;
- separate migration and least-privilege runtime identities;
- encrypted client connectivity;
- transactional rollback behavior;
- explicitly granted runtime CRUD;
- runtime DDL denial;
- cleanup of probe objects;
- credentials kept outside Git and permanent notebook memory.

It does not establish:

- application migrations 003/004 on the provider;
- hosted API behavior;
- Auth0 login or token acceptance;
- Device enrollment through a real provider-backed workflow;
- provider backup or application recovery;
- production RLS, deployment, availability or acceptance.

## MCG-02 partial preparation boundary

The recovered preparation evidence establishes that development-provider dashboards and native
application/API configuration paths were explored and partly prepared. It may be described only as:

```text
MCG-02_PROVIDER_DASHBOARD_PREPARATION_PARTIAL
```

It must not be described as deployment, hosted authentication success or hosted synchronization.
No approved hosted secret set, real login, token acceptance, provider-backed enrollment, Neon
migration, Render deployment or hosted convergence proof was completed.

## Provider and secret boundary

- Native clients do not embed a confidential client secret.
- Database credentials remain server-side and never enter Flutter.
- Exact tenant identifiers, callbacks, certificate fingerprints, audiences, provider URLs,
  connection strings, tokens and passwords do not belong in permanent Didactic memory.
- Safe evidence includes provider role/category names, versions, redacted aliases, operation results,
  counts, timings, hashes and explicit exclusions.
- Sanitization removes secrets without converting an unvalidated action into accepted evidence.

## Open and contradicted knowledge

- Route-wide membership, enrollment and Device state must be rechecked or locked in the same
  transaction as each protected mutation.
- JWT/JWKS adversarial, rotation, outage and bounded-response validation remains incomplete.
- The decisive hosted HTTP topology has not been proved under a separate least-privilege runtime identity.
- Cross-Account denial, membership removal, concurrent enrollment/revocation and restart coverage remain incomplete.
- The neutral Flutter hosted-auth composition remains incomplete.
- Real Auth0, Neon migration and Render deployment evidence remain absent.
- Android and Windows hosted workflow parity remains unproved.

## Misconceptions to prevent

- Local authentication readiness is not hosted authentication success.
- Token verification is not Account membership.
- Account membership is not Device enrollment.
- Installation identity is not automatically the server DeviceId.
- Enrollment does not prevent later revocation.
- Authentication failure is not authorization denial.
- Server acceptance is not peer application.
- Acknowledgement is not all-Device convergence or backup.
- Provider configuration is not deployment or acceptance.
- A managed database backup is not a Markei application snapshot.
- One local or hosted test cannot establish universal synchronization or permanent recovery.
- Implementation evidence cannot manufacture learner maturity.

## Cycle boundary

Cycle 10 may continue correcting authentication/authorization contracts, tests, provider gates and
neutral diagnostics. It does not authorize authentication pages, Device-management screens,
polished status presentation, navigation changes, accessibility composition or Analytics.
Those presentation decisions remain Cycle 11 work.

## Recovery pointers

1. `02_KANBAN.md` — canonical concepts and unchanged maturity.
2. `07_GLOSSARY.md` — compact durable terminology.
3. `[M]_STAGE/J_MAIN_STAGE.md` at `75fbba6` — controlling accepted, partial and contradicted classifications.
4. `DEV_STAGE/B_DIDACTIC.md` — provisional semantic investigation.
5. `DEV_STAGE/E_DDC_STAGE.md` — controlling semantic materialization requirements.
6. `DEV_STAGE/H_DDC_CODEX.md` — implementation evidence requiring Main interpretation.
7. `DEV_STAGE/G_OPS_CODEX.md` and `I_DSN_CODEX.md` — execution and architecture evidence.
8. relevant synchronization, recovery and hosted-auth source/tests — implementation truth.
9. `13_LECTURE_REGISTER.md` — learner history; unchanged because no learner event was evidenced.

## Next valid route

Corrective C10-S03A-R1 staging, implementation and Main reconciliation must occur before MCG-02
hosted proof can be activated. Any later permanent promotion must retain the exact evidence boundary
and must not infer provider acceptance, Cycle closure or learner maturity.