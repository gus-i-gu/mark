# 10_OPERATIONAL_STATE.md

> Version: Cycle 09 post-Codex checkpoint
> Status: Active Operational checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Operational
> Branch: `intermid-cycle-recovery`
> Inspected implementation: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Evidence: `DEV_STAGE/G_OPS_CODEX.md`
> Main reference: latest `[M]_STAGE/J_MAIN_STAGE.md`
> Canonical owner: `operational/12_OPERATIONAL_MODEL.md`
> Active actions: `operational/04_TODO.md`

---

# Current Operational State

Cycle 09 C09-U02 is materialized and reconciled within the evidence boundaries below. No further source, schema, dependency, host, staging or Main-root authority is active.

## Implemented

- Flutter/Drift schema v3 with People, Payment Methods, Account preferences, nullable Purchase references, nullable BULK package count and Product normalization v3.
- Sequential v1/v2 migration handling, deterministic legacy-code retention, collision preflight and generated Drift update.
- Home-first responsive navigation; Lists, Purchase, History, Catalogue, Guide, Documentation and Settings; Analytics and Household remain disabled/PIN-labelled.
- kg/g/L/ml/un support, comma/point quantity input and fractional COUNT rejection.
- Exact Product lookup ports and advisory-only similarity.
- Typed application failure infrastructure.
- Versioned transient `personal-cycle-v1` Storage/Shortage/Market/All projections.
- Accessible History checkbox/tap multi-selection, selected-Purchase CSV and PDF-byte/local-file generation.
- Protected Python/PySide6 source and database remained unchanged.

## Validated within named scope

- Flutter dependency resolution and Drift regeneration passed.
- Dart formatting passed.
- Flutter tests: 39 passed.
- Flutter analysis: no issues.
- Diff whitespace check passed, with CRLF notices only.
- Python release-configuration `unittest`: 5 passed.
- Windows release build passed.
- Built Windows process remained running for a bounded five-second smoke.

Repository inspection confirms code existence. Commands above are Codex-host evidence and were not rerun during permanent reconciliation.

## Partial or contradicted

- BULK hides package count, but still requests Line total; accepted price-per-unit and total derivation are incomplete.
- Typed failures exist, but Purchase/Catalogue frequently present generic catch-all errors.
- Exact lookup ports exist, while visible Catalogue search remains substring-based.
- PDF generation/local temporary save exists; destination/cancel and native sharing do not.
- History selection exists; select-all and desktop double-click were not found.
- Product details use tap/long-press panel; shared adaptive route and desktop double-click were not found.
- Nickname uniqueness also restricts duplicate archived nicknames, exceeding the intended active-only rule.
- Product codes are populated by creation/migration, but schema columns remain nullable.
- Migration-failure injection and full manual workflow evidence were not reported.

## Host-unvalidated

- Android build/runtime/lifecycle: Codex host lacked Java and `JAVA_HOME`.
- Dense phone-width manual workflow and lifecycle matrix.
- Full Windows manual workflow, file destination/cancellation and native-share behavior.
- iOS, physical devices, signing and release distribution.

Android is host-unvalidated, not failed at product level. Windows build/smoke is not full manual acceptance.

## Deferred

Product correction/merge, Store redesign, SubmissionId, persisted drafts, registered Purchase edit/delete, native share, Analytics calculations, Household behavior, authentication, API/Neon/synchronization, production distribution and PySide6 retirement.

## Current action

Main/human should choose one bounded follow-up from `04_TODO.md`. Recommended first unit:

```text
BULK price-per-unit correction
+ typed failure presentation
+ exact Catalogue lookup UI
+ focused regression tests
```

Keep schema invariants (nickname uniqueness and Product-code nullability) in a separate migration unit unless Main explicitly combines them with representative migration/recovery evidence.

## Recovery route

1. Read this checkpoint.
2. Read `04_TODO.md` for ordered active actions.
3. Read the latest Cycle 09 entry in `11_OPERATIONAL_RECORD.md` for chronology and command evidence.
4. Read the Cycle 09 section of `12_OPERATIONAL_MODEL.md` for stable execution rules.
5. Read G and post-Codex J for materialization evidence and cross-domain contradictions.
6. Inspect `06714d7..e37cb70` only when reports conflict or precision is insufficient.

## Handoff

```text
Operational checkpoint refreshed
→ Main reconciles O/A/D checkpoints
→ bounded D/E/F unit
→ Codex implementation/validation
→ G/H/I
→ renewed FLX-PRM-04
```


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
