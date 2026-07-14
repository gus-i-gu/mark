# 00_PROJECT_STATE.md

> Version: Cycle 09 Sprint 01 Main closure 1.0
> Status: Active Global State Canon-Checkpoint
> Persistence Class: Canon-Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `intermid-cycle-recovery`
> Inspected implementation: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Post-Codex reconciliation: `8c542c3174f3f070312c3d4169886a6f36bc00a0`
> Latest permanent-domain head inspected: `eaa12efe3815ecf9cac34255eadca5010c7af505`
> Scope: Current global state after Cycle 09 Sprint 01 reconciliation

---

<!-- TEMPORAL_MARKER:C09-S01-MAIN-CLOSURE-2026-07-14 -->

# Cycle 09 Sprint 01 — Main Closure State

## 1. Current milestone

Cycle 09 Sprint 01 materialized and reconciled the local Product/database expansion on
`intermid-cycle-recovery`.

```text
Cycle 08 / Intermid recovery foundation: closed
Cycle 09 Sprint 01 investigation and staging: complete
Cycle 09 C09-U02 materialization: complete at e37cb70
post-Codex Main reconciliation: complete at 8c542c3
Operational permanent reconciliation: complete at e2339b7
Design permanent reconciliation: complete at eaa12ef
Didactic Cycle 09 permanent return: no new commit observed
Cycle 10 perspective: prepared, inactive
```

The protected Python/PySide6 beta and its database remain isolated and recoverable.

## 2. Current application state

The active Flutter/Drift local beta now includes:

- Home-first responsive navigation;
- Home, Lists, Purchase, History, Catalogue and Settings;
- disabled/PIN-labelled Analytics and Household placeholders;
- schema v3 People, Payment Methods and Account preferences;
- optional Purchase references with archive-aware historical labels;
- Product normalization v3, code/exact-identity lookup ports and collision preflight;
- PACKAGED/BULK distinction with nullable BULK package count;
- `kg`, `g`, `L`, `ml`, `un`, comma/point input and fractional COUNT rejection;
- transient `personal-cycle-v1` Storage/Shortage/Market/All projections;
- History multi-selection, deterministic CSV and PDF-byte/local-file generation;
- typed application failure infrastructure;
- v1/v2→v3 migration handling and generated Drift reconciliation.

No cloud service, authentication, remote analytics, external data retention or real
synchronization was introduced.

## 3. Evidence boundary

Codex reported at `e37cb70`:

```text
Flutter tests                              39 passed
Flutter analysis                           no issues
Drift regeneration and Dart formatting     passed
Windows release build                      passed
Windows bounded five-second launch          passed
Python release-configuration unittest       5 passed
Android build/runtime                       host-unvalidated: Java unavailable
```

File-backed migration/reopen tests exist. This Main closure did not rerun Flutter or
platform commands because the reconciliation host has no Flutter executable.

The Windows result is build/smoke evidence, not a complete manual workflow or lifecycle
acceptance. Android is host-unvalidated, not failed.

## 4. Permanent-memory reconciliation

Operational memory records the implementation, validation boundary and ordered corrective
actions. Design memory accepts the schema/application topology and preserves the identified
contradictions. Their current checkpoints are authoritative for domain depth.

No Cycle 09 Didactic permanent-memory commit was found after J. No learner-maturity change
is justified by project implementation or tests. Existing Didactic canon remains in force;
Cycle 09 vocabulary absorption remains an explicit documentation follow-up rather than an
assumed promotion.

Main continuity summarizes these results and does not replace domain ownership.

## 5. Partial, contradicted and deferred state

Priority correction candidates:

1. BULK still requests Line total instead of Price per unit with derived half-up total.
2. `(accountId, normalizedNickname, active)` also restricts duplicate archived nicknames.
3. typed failures exist but many UI paths still collapse them into generic messages.
4. exact Product lookup ports exist but Catalogue presentation remains substring-based.
5. Product-details adaptation and History double-click/select-all remain partial.
6. PDF generation exists; save destination, cancellation and native share remain absent.
7. Product codes are populated by commands/migration but remain nullable in Drift storage.

Still deferred:

- Product correction/merge and Store redesign;
- durable SubmissionId and persisted drafts;
- registered Purchase edit/delete;
- Analytics calculations and Household behavior;
- authentication, API, Neon, upload/download and convergence;
- production signing, distribution and public release;
- PySide6 retirement.

## 6. Current authority

Cycle 09 Sprint 01 D/E/F authority is consumed. No source, schema, dependency, host or
release change is active.

Before Cycle 10 materialization, Main/human must decide whether the correction candidates
form a final Cycle 09 correction unit or the first bounded Cycle 10 unit. Either route
requires fresh A/B/C investigation where meaning is unsettled and fresh controlling D/E/F.

Cycle 10 is a forward perspective only. It does not authorize implementation.

## 7. Active risks

- incomplete BULK pricing behavior can store a manually supplied total rather than the
  intended unit-price-derived value;
- the nickname constraint may reject legitimate archived-history patterns;
- generic UI errors weaken recovery guidance;
- temporary fixed-name export files lack destination/cancellation/native-share behavior;
- Android and dense responsive/lifecycle behavior remain unvalidated;
- missing Cycle 09 Didactic absorption may leave terminology recovery stale;
- calling the beta release-ready would exceed current evidence.

## 8. Recovery route

Read next:

1. `06_SESSION_SCHEME.md` for the conditional Cycle 10 perspective;
2. `operational/10_OPERATIONAL_STATE.md` for evidence and action priority;
3. `design/09_DESIGN_STATE.md` for architecture classifications;
4. `didactics/08_CONCEPT_MAP.md` for the inherited learning checkpoint;
5. `[M]_STAGE/J_MAIN_STAGE.md` for the post-Codex conflict audit;
6. G/H/I and repository source only when the checkpoints cannot resolve a claim.
