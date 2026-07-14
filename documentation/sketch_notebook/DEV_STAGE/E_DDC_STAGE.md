<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# E_DDC_STAGE — Semantic Guardrails for Edit Correction

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Status: CONTROLLING with D_OPS_STAGE.md and F_DSN_STAGE.md
> Authority: Main Chat
> Codex report destination: DEV_STAGE/H_DDC_CODEX.md

## Objective

Preserve the implemented distinction between Product identity and editable
Purchase Item values while Codex materializes the bounded correction.

## Required semantic behavior

- A Product reference identifies which Product the staged Item concerns.
- Quantity, unit, package count, and line total are editable Item values.
- Editing those values must not imply Product creation, replacement, similarity
  resolution, or identity change.
- A stable list key is not evidence of preserved Product identity.
- A passing regression is project evidence only; it is not learner-maturity
  evidence.

Existing user-facing language may be adjusted only if required to make the edit
action truthful and unambiguous. Do not introduce claims of synchronization,
backup, durable idempotency, or production acceptance.

## Report

Append a concise evidence note to:

```text
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
```

Record the vocabulary or behavior touched and the conceptual distinction proved
by the regression.

## Prohibitions

Do not update KANBAN status, create canonical concepts, promote Didactic memory,
rewrite lessons, change methodology, or expand into Store/schema/synchronization
teaching. H is evidence, not canon.
