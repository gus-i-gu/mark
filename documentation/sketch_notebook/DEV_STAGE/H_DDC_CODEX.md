<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.

---

## 2026-07-14 — Codex Didactic Evidence: Product Identity vs Item Values

Sequence: FLX-ORD-01
Role: Codex materialization evidence
Round or unit: Existing-product staged Item edit correction
Branch: intermid-cycle-recovery
Baseline / inspected HEAD: a73b1dc9e23cdd247a93d43222ff6107a041b9f5
Authority: D_OPS_STAGE.md + E_DDC_STAGE.md + F_DSN_STAGE.md controlling envelope
Writable surfaces: authorized source paths and G/H/I Codex reports
Evidence boundary: local Flutter widget regression, full tests, and analysis

Source stage files:
- documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
- documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
- documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md

Vocabulary or behavior touched:
- The visible edit action remains "Save staged Item".
- While editing, the "Create anyway" action is hidden so the edit action does not imply Product creation.
- The Product selection is cleared after saving a line; staged identity is carried by the draft line, not by the current dropdown selection.

Conceptual distinction proved by regression:
- Product identity is the retained ProductReference from the staged line.
- Quantity, package count, and line total are editable Item values.
- Saving an edit updates Item values while preserving the existing Product ID and Product row count.

Commands and results:
- dart format lib/app/pages/purchase_page.dart test/app/markei_app_test.dart: passed.
- flutter test test/app/markei_app_test.dart: final run passed, 7 tests passed.
- flutter test: passed, 32 tests passed.
- flutter analyze: passed, No issues found.

Instructions completed:
- Added project evidence for the Product identity / Item values distinction.
- Did not update KANBAN status, create concepts, promote Didactic memory, rewrite lessons, or expand into Store/schema/synchronization teaching.

Instructions skipped: none.

Failures or blockers:
- No final blockers.

Unresolved risks:
- This is implementation evidence only; it is not learner-maturity evidence.

Suggested functional follow-up:
- Didactic Chat may classify the regression as evidence that ProductReference ownership and editable Item-value ownership remain distinct.
