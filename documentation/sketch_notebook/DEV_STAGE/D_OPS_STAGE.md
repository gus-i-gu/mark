# D_OPS_STAGE — Cycle 08 Codex Operational Directive

> Cycle: 08 — Shared-Client Product Beta
> Directive: C08-IMP-01
> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED
> Authority: explicit human instruction reconciled by Main [M]
> Branch: `cycle-08-shared-client-product-beta`
> Paired directives: `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
> Evidence outputs: `G_OPS_CODEX.md`, `H_DDC_CODEX.md`, `I_DSN_CODEX.md`
> Temporal control: this directive supersedes the earlier provisional and C08-ACT-01 text in this file

## 1. Authorized outcome

Codex shall materialize one bounded, reversible implementation unit:

**C08-IMP-01 — responsive application shell plus explicit presentation states.**

The completed unit must:

1. preserve the currently implemented Purchase and History destinations;
2. render navigation according to available width rather than host platform;
3. preserve the selected destination while the layout changes;
4. preserve the current mounted Purchase draft behavior across destination changes;
5. distinguish loading, genuine empty, failure and data states in History;
6. keep Purchase registration feedback semantically distinct from validation and failure;
7. remove raw exceptions and Device identity/sequence from ordinary user-facing copy touched by this unit;
8. add focused tests for the behavior above.

This directive authorizes the Flutter source and test edits strictly necessary for that outcome.

## 2. Mandatory preflight

Before source edits, Codex must:

```text
git status --short --branch
git branch --show-current
git pull --ff-only
git rev-parse HEAD
```

Then:

- load `AGENTS.md`, `INDEX.md` and `PROMPT_COLLECTION.md`;
- run `PRI-CODEX` and `PMC-01`;
- run `PMC-02` only if routing, authority, FLUX or promotion remains uncertain;
- read all three active D/E/F directives;
- inspect only the source/tests needed to establish implementation truth;
- report existing worktree changes before editing.

Stop if the required branch is not active, the pull is not fast-forwardable, unrelated work cannot be preserved, or D/E/F conflict.

## 3. Writable implementation surface

Codex may modify:

- the Flutter application shell/composition surface;
- the existing Purchase and History presentation surfaces touched by C08-IMP-01;
- small presentation-only state types required by those surfaces;
- focused Flutter unit/widget tests;
- generated files only when an existing repository command legitimately regenerates them;
- G/H/I after source materialization and validation.

Codex must keep handwritten and generated ownership explicit.

## 4. Required operational behavior

### Responsive shell

- Use one semantic destination model.
- Use a compact navigation treatment below a locally defined constraint breakpoint.
- Use a wide navigation treatment at or above that breakpoint.
- Keep the breakpoint as one named presentation constant.
- Test immediately below and at/above the breakpoint.
- Preserve destination selection and mounted page state across resize.

### Presentation states

History must show distinct states for:

- loading;
- no registered Purchases;
- failed load with a safe retry path when supported by the current surface;
- loaded Purchase summaries.

Purchase registration must not display a successful result before repository success is known. Existing validation errors must remain distinguishable from registration failure.

### User-facing safety

Ordinary copy must not expose:

- exception strings or stack details;
- Device UUID or Device sequence;
- Drift/database terminology;
- synchronization, upload or backup claims.

## 5. Validation gates

Run the narrowest focused tests during implementation, then the available baseline:

```text
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Also attempt, when the host supports them:

```text
flutter build windows
flutter build apk --debug
python -m unittest discover -s tests
```

A command not runnable on the host must be reported as **host-unvalidated**, never passed.

Acceptance requires:

- focused responsive-shell tests;
- destination-preservation test;
- Purchase-draft preservation regression;
- History loading/empty/failure/data tests;
- touched Purchase result/copy tests;
- no unrelated source changes;
- no regression to the protected Python beta.

## 6. Prohibited changes

C08-IMP-01 does not authorize:

- new packages, dependency versions or tool installation;
- schema, migration or persistence-model changes;
- new top-level Catalogue or Store destinations;
- draft coordinator or durable draft work;
- Product resolution, Product-code policy or Store identity work;
- SubmissionId or durable idempotency;
- History detail, observations or analytics;
- backup/restore or Device redesign;
- authentication, API, Neon or synchronization;
- Python/PySide6 source or database changes;
- deletion, reset, stash, cleanup or overwrite of unrelated work;
- commit or push unless the invoking Codex instruction separately grants publication authority.

Encountering one of these needs is a stop condition and must return to Main.

## 7. Evidence and handoff

After implementation, Codex must write exact evidence:

- **G**: environment, commands, results, failures, host limits and changed-file inventory;
- **H**: implemented state language, copy boundaries and unresolved teaching claims;
- **I**: final responsibility map, dependency direction, state ownership and deviations.

Evidence must distinguish implemented, test-validated, host-validated, host-unvalidated, blocked and deferred claims.

## 8. Later-unit boundary

The gathered Cycle 08 work supports later bounded units, but they are not activated by this directive:

1. draft coordinator and explicit review;
2. Product reuse/resolution and Store selection;
3. isolated durable submission identity;
4. History detail and Product observations;
5. first versioned personal price comparison;
6. recovery/export and installation-Device hardening.

Each later unit requires a new Main D/E/F activation after its human decisions and schema/dependency consequences are resolved.
