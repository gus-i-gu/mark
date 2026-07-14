<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.

---

## 2026-07-14 — Codex Design Evidence: Edit-State Ownership

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

Changed paths:
- clients/markei_flutter/lib/app/pages/purchase_page.dart
- clients/markei_flutter/test/app/markei_app_test.dart
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

Chosen edit-state ownership:
- PurchasePage now retains edit-state ownership for `_editingKey`, `_editingReference`, and `_editingProductLabel`.
- Entering edit mode copies the selected draft line's ProductReference and label into explicit edit state.
- Saving an edit calls one save path that rebuilds only PurchaseItemDraft values from editable controls and reuses the retained reference and label.
- Removing an edited line, saving an edited line, or registering the purchase clears associated edit state.

Invariant evidence:
- Regression `editing an existing Product Item preserves Product identity` creates one existing Product, selects/stages it through the widget flow, edits package count, quantity, and line total, registers, and verifies:
  - Product row count remains 1;
  - registered PurchaseDetailItem.productId matches the original Product ID;
  - edited package count, purchased amount, and line total are persisted.

Commands and results:
- dart format lib/app/pages/purchase_page.dart test/app/markei_app_test.dart: passed.
- flutter test test/app/markei_app_test.dart: final run passed, 7 tests passed.
- flutter test: passed, 32 tests passed.
- flutter analyze: passed, No issues found.

Deviation:
- No deviation from authorized source scope.
- A presentation-local selected Product clear was added after line save so dropdown state cannot retain a stale Product instance across catalogue reload; staged identity remains owned by the line/edit state.

Stop-condition audit:
- No schema or migration change.
- No Product merge/correction semantics.
- No Store identity work.
- No durable submission identity.
- No persisted drafts.
- No synchronization architecture.
- No source changes outside the authorized paths.

Unresolved risks:
- None identified within the local widget/regression boundary.

Suggested functional follow-up:
- Design Chat may classify the page as having presentation-local edit identity ownership for staged line edits.
