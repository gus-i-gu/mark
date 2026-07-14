# 04_TODO.md

> Version: Cycle 09 post-Codex Operational actions
> Status: Active derived view
> Persistence Class: Derived
> Knowledge Class: Operational
> Branch: `intermid-cycle-recovery`
> Implementation evidence: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Canonical owner: `operational/12_OPERATIONAL_MODEL.md`
> History: `operational/11_OPERATIONAL_RECORD.md`

---

# Cycle 09 Remaining Operational Actions

## Closed with bounded evidence

- Schema v3 and generated Drift code exist.
- Fresh v3, v1 migration and file-backed v2→v3/reopen tests exist.
- People, Payment Methods, optional Purchase references and archived-label resolution exist.
- Quantity comma/point parsing and kg/g/L/ml/un handling exist; fractional COUNT rejection is tested.
- Exact Product lookup ports, typed failure infrastructure, Home/Lists/Catalogue/Settings, History selection, CSV and PDF bytes exist.
- Flutter suite passed: 39; analysis clean.
- Windows release build and bounded launch passed.
- Protected Python `unittest` regressions passed: 5.

These closures retain their automated/build/smoke boundaries.

## P0 — Correct contradicted or partial Cycle 09 behavior

1. Implement BULK price-per-unit input and accepted deterministic total rounding; stop using Line total as the only BULK price input.
2. Carry typed failure code/title/field/recovery/retryability/outcome consistently through Purchase and Catalogue UI.
3. Expose visible exact Product lookup by code or full identifying combination; keep substring search and advisory similarity distinct.
4. Correct Person/Payment Method uniqueness so arbitrary archived history is retained while active nickname uniqueness remains enforced.
5. Decide and enforce the Product-code persistence invariant; do not claim database NOT NULL while columns remain nullable.
6. Add History select-all if still accepted; classify desktop double-click as optional convenience.
7. Decide whether Product details require a shared adaptive route; retain explicit tap/action accessibility.
8. Replace temporary fixed-path PDF behavior with an accepted save-destination/cancel flow before calling it share-ready. Native share remains a separate decision.

Each correction requires Main-controlled D/E/F and renewed G/H/I evidence.

## P0 — Validation gaps

- Run focused tests for every correction above, then full Flutter tests and analysis.
- Add explicit injected migration-failure/collision rollback evidence if not already covered.
- Perform manual Windows Home → Catalogue → Purchase → Lists → History → Settings workflow.
- Verify file save/cancel and selected-data boundaries manually on Windows.
- Exercise dense phone-width navigation, long Purchase form, larger text, keyboard/focus, Back, rotation, background/resume and cold relaunch.
- Restore Java/JDK only under explicit host authority; then build/install/launch Android and repeat the relevant workflow/lifecycle matrix.
- Keep Android host-unvalidated until those gates pass.

## P1 — Performance and recovery

- Measure Lists, Catalogue similarity/search, exact lookup, History detail and export at representative volumes before adding indexes or paging.
- Verify projection invalidation after registration and threshold changes.
- Rehearse v3 recovery from migration rejection without silent reset.
- Define export backup/restore language before calling exported files backups.
- Retain the protected Python/PySide6 database boundary.
- Resolve tracked Python bytecode/ignore-policy hygiene in a separate bounded unit.

## Deferred

- Product correction/merge and Store identity redesign;
- durable SubmissionId and persisted drafts;
- registered Purchase edit/delete;
- native share plugin unless separately accepted;
- Analytics calculations and Household behavior;
- authentication, TypeScript API, Neon, upload/download and convergence;
- iOS, physical-device breadth, signing, production distribution and PySide6 retirement.

## Next route

```text
Operational/Didactic/Design permanent reconciliation
→ Main reconciles refreshed checkpoints
→ Main/human selects one bounded correction or validation unit
→ controlling D/E/F
→ Codex materialization and G/H/I
→ renewed FLX-PRM-04
```

No source, schema, dependency or host authority is active.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
