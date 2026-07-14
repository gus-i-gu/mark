# J_MAIN_STAGE — Cycle 09 Post-Codex Reconciliation

> Sequence: FLX-ORD-01 → FLX-PRM-04
> Unit: C09-U02 — Local Product and Database Expansion
> Status: POST-CODEX EVIDENCE RECONCILED; DOMAIN PROMOTION AUTHORIZED
> Branch: `intermid-cycle-recovery`
> Staging commit: `06714d719c22ebd6b64008b7dcec745faee8fcd5`
> Inspected implementation HEAD: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Inputs: J/D/E/F, G/H/I, implementation diff, targeted repository inspection
> Authority: Human-supervised Main Chat

---

<!-- ROUND_MARKER:C09-U02-POST-CODEX-RECONCILIATION-2026-07-14 -->

## 1. Purpose and boundary

This refresh supersedes J's implementation-activation state; Git history preserves it.
It is the compact reference for Operational, Didactic and Design post-Codex chats.

G/H/I are evidence, not canon. Domain chats must classify claims through PRC-01, inspect
the repository when evidence conflicts or is incomplete, update only their authorized
permanent surfaces, regenerate derivatives, and refresh their checkpoint last.

No new source implementation, methodology change, file creation/rename, 00/05/06 update,
commit, push, cloud/auth/sync/release work, or Cycle 10 activation is authorized here.

## 2. Repository and report audit

- Remote-tracking `origin/intermid-cycle-recovery` is at inspected HEAD `e37cb70` with
  message `Implement cycle 09 local product expansion`, directly after `06714d7`.
- The implementation changes 35 paths: 32 Flutter source/test paths and G/H/I.
- G/H/I were replaced for C09-U02 and are respectively 63, 50 and 63 lines, below the
  250-line report limit.
- Source inspection confirms schema v3, People, Payment Methods, Account preference,
  optional Purchase references, nullable BULK package count, Home/Lists/Settings,
  Catalogue details, typed failure infrastructure, History selection, CSV/PDF bytes,
  quantity parsing, projection logic, migrations and focused tests exist.
- G records 39 passing Flutter tests, clean analysis, Windows release build and bounded
  launch at Codex's host. Android is host-unvalidated; protected Python has five passing
  `unittest` regressions while `pytest` was unavailable.
- This Main host cannot independently rerun Flutter tests because `flutter` is absent.
  Current validation therefore remains Codex-host evidence plus repository inspection.
- G omits its required final commit field and exact changed-path inventory. J supplies the
  inspected final commit and Git diff boundary; G remains adequate but incomplete evidence.

## 3. Reconciled claim states

### 3.1 Implemented with named evidence

The following are **implemented** at `e37cb70`; validation is limited to G's named scope:

1. Home-first adaptive navigation and static truthful Home descriptors.
2. Visible navigation for Home, Lists, Purchase, History, Catalogue, disabled/PIN
   Analytics and Household, Guide, Documentation and Settings.
3. Quantity parsing for comma/point decimals and units `kg`, `g`, `L`, `ml`, `un`, with
   fractional COUNT rejection.
4. Exact Product lookup repository ports by Account-scoped code and exact identity;
   normalization v3 separates PACKAGED and BULK identity rules.
5. Schema v3 tables/columns, v1/v2 migration route, collision preflight, deterministic
   legacy Product-code backfill and file-backed migration/reopen tests.
6. Optional Person and Payment Method references, archive-aware History labels and local
   Settings management with no credential fields.
7. Versioned transient `personal-cycle-v1` projections and Storage/Shortage/Market/All.
8. Transient History multi-selection, deterministic selected-Purchase CSV, PDF-byte
   generation, and disabled Analytics/edit/delete actions.
9. Typed `AppFailure` exists in the application layer and is used by repository paths.
10. Protected Python/PySide6 source and database were not changed by the implementation.

These facts may be promoted only to their unique domain owners with their evidence boundary.

### 3.2 Partial or contradicted against D/E/F

1. **BULK pricing — contradicted completion claim.** Purchase UI still requests `Line
   total`; it does not request `Price per unit` or derive the total with the authorized
   half-up calculation. Nullable BULK package count is implemented, but the pricing flow is
   not complete.
2. **Share list — partial.** The action generates PDF bytes and writes a fixed file in the
   system temporary directory, then asks the user to share manually. There is no save
   destination/cancellation flow or OS-native share adapter. Treat PDF generation as
   implemented; treat share capability as deferred/partial.
3. **Error presentation — partial.** Typed repository failures exist, but Purchase and
   Catalogue pages commonly catch `Object` and show generic messages, so the complete
   code/field/recovery/outcome contract is not consistently presented to users.
4. **Catalogue exact lookup UI — partial.** Exact lookup ports exist, while the visible
   Catalogue search performs in-memory substring filtering over code/name/brand instead
   of explicitly executing code-or-identifying-fields exact lookup.
5. **History interaction — partial.** Accessible checkbox/tap selection exists. The
   requested double-click selection shortcut and explicit select-all control were not
   found in the inspected page.
6. **Product-details interaction — partial.** Catalogue tap/long-press reveals a detail
   panel. A shared adaptive detail route and explicit desktop double-click convenience were
   not found.
7. **Reference nickname uniqueness — contradicted design detail.** Database unique keys use
   `(accountId, normalizedNickname, active)`. This enforces one active nickname, but also
   permits at most one archived row with that nickname. The frozen rule required uniqueness
   among active rows only while retaining arbitrary historical archived rows.
8. **Product code schema — partial.** Creation and migration supply codes, but the Drift
   Product code columns remain nullable. Domain chats must not document a database-level
   NOT NULL invariant.
9. **Validation envelope — partial.** No Android evidence exists. G does not report an
   injected migration-failure test, a full manual workflow smoke, or native share behavior.

These claims must not be promoted as completed or validated. Route source corrections to a
future Main-authorized implementation unit after domain reconciliation.

### 3.3 Deferred and unchanged boundaries

Authentication, cloud/API synchronization, external analytics, Product correction/merge,
Store redesign, SubmissionId, persisted drafts, registered Purchase mutation, native share,
Analytics calculations, Household behavior and production release remain deferred.

## 4. Repository conflict-search protocol for domain chats

When a report, stage and repository disagree:

1. preserve each claim and its state; do not blend wording into false consensus;
2. inspect `06714d7..e37cb70`, then the smallest source/test path owning the claim;
3. distinguish code existence, test evidence, platform build, manual runtime and learner
   evidence; one must not stand in for another;
4. record exact path/symbol/test and environment; avoid copying raw G/H/I prose as canon;
5. classify as accepted, implemented, validated, partial, host-unvalidated, blocked,
   deferred or contradicted;
6. update the unique semantic owner, then derivatives, then the domain checkpoint last;
7. preserve observational history and log contradictions requiring future implementation;
8. stop and return to Main if ownership, evidence or write authority remains ambiguous.

Primary repository evidence surfaces:

- UI: `clients/markei_flutter/lib/app/` and `test/app/markei_app_test.dart`;
- application semantics: `lib/application/` and `test/application/`;
- domain invariants: `lib/domain/` and `test/domain/`;
- schema/repositories: `lib/infrastructure/local/`, migration and repository tests;
- exact change inventory: `git diff --name-status 06714d7..e37cb70`.

Generated `local_database.g.dart` is derived evidence; handwritten schema authority is
`local_database.dart`.

## 5. Domain handoffs and writable surfaces

### Operational Chat

Read A, D, G, this J, relevant source/tests, then PRC-01. Preserve execution evidence in
`operational/11_OPERATIONAL_RECORD.md`; reconcile stable workflow in
`operational/12_OPERATIONAL_MODEL.md`; derive actions in `operational/04_TODO.md`; refresh
`operational/10_OPERATIONAL_STATE.md` last. Track the nine partial/contradicted items as
active actions or future TODOs without claiming validation.

### Didactic Chat

Read B, E, H, this J and visible UI/test copy. Update `didactics/13_LECTURE_REGISTER.md`
only for actual teaching events; reconcile accepted terms in `didactics/07_GLOSSARY.md` and
other existing didactic owners as justified; regenerate `didactics/08_CONCEPT_MAP.md`; refresh
the didactic checkpoint last. Do not change learner maturity or KANBAN from project tests.

### Design Chat

Read C, F, I, this J and handwritten schema/application/domain sources. Preserve design
decisions/corrections in `design/03_DECISION_LOG.md`; reconcile stable architecture in
existing canonical Design owners; regenerate `design/14_MODEL_OVERVIEW.md`; refresh
`design/09_DESIGN_STATE.md` last. Explicitly resolve or defer BULK pricing, active-only
nickname uniqueness, nullable Product code, native share and adaptive details.

Each domain may write only its existing permanent domain files plus its own A/B/C handoff
when methodology requires it. Cross-domain or structural-file changes return to Main.

## 6. Sequence handoff envelope

```text
Sequence: FLX-PRM-04
Role: Operational / Didactic / Design functional chat
Unit: C09-U02 post-Codex reconciliation
Branch: intermid-cycle-recovery
Inspected HEAD: e37cb700feeca4001cc7835b584c46bb81926af3
Question: Which evidenced claims should enter this domain's permanent memory?
Inputs: domain A/B/C + D/E/F + G/H/I + J + targeted repository evidence
New evidence: Cycle 09 implementation commit and Main conflict audit
Current states: implemented, partial, contradicted, deferred, host-unvalidated
Contradictions: J §3.2
Writable surfaces: existing files in the receiving permanent domain
Prohibited: source, methodology, other domains, 00/05/06, commit/push without authority
Authority: post-Codex domain reconciliation only
Next sequence: return reconciled domain handoff to Main
Stop condition: unresolved evidence, semantic owner, or authority
```

## 7. Closure condition

J now authorizes the three domain reconciliation passes. Cycle 09 is not fully closed until
their permanent-memory updates return to Main and the partial/contradicted implementation
items are classified for a correction unit or explicit deferral.
