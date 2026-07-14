# D_OPS_STAGE — Cycle 09 Implementation and Evidence

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Unit: C09-U02 — Local Product and Database Expansion
> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED with E/F
> Branch: `intermid-cycle-recovery`
> Required baseline: descendant of `b93c688496d2995c17d5328aadb348ee8c980da5`
> Report: replace `DEV_STAGE/G_OPS_CODEX.md` with a ≤250-line C09 report

## 1. Objective

Materialize the reconciled Cycle 09 local Flutter/Drift beta defined by J and the
controlling D/E/F envelope. Preserve the protected Python/PySide6 application and its
database. No cloud, authentication, sync or production-release work is authorized.

## 2. Safety before mutation

1. Read AGENTS.md, INDEX.md, J and all D/E/F.
2. Verify branch, clean/understood worktree, remote relation and baseline ancestry.
3. Preserve unrelated work; never stash/reset/clean/force-push.
4. Inventory affected source, tests, schema version, generated Drift files and deps.
5. Stop if D/E/F conflict or migration cannot preserve existing data.

## 3. Required operational units

### A. Input, identity and failures

- expose MASS/VOLUME/COUNT and `kg/g/L/ml/un` correctly;
- accept comma/point quantity decimals; keep storage locale-neutral;
- reject fractional COUNT and mixed/ambiguous numeric input;
- implement exact Product-code and exact-identification lookup;
- preserve advisory similarity and exact-collision blocking;
- introduce typed failures with code, field/operation, recovery, retryability and outcome;
- keep retryable drafts available and show unknown outcome distinctly.

### B. Schema v3

- dedicated Person and Payment Method tables;
- nullable single Purchase references;
- active/archive lifecycle with historical resolution;
- no credentials or external retention;
- nullable package count for BULK;
- Account preference for shortage threshold, default 5;
- new Product normalization version and deterministic legacy-code backfill;
- sequential representative v2→v3 migration; no silent reset.

### C. Product/UI pages

- Home becomes landing page with bundled truthful cards;
- responsive Home/Lists/Purchase/History/Catalogue shell;
- disabled/PIN Analytics and Household; bounded Guide/Docs/Settings;
- Catalogue exact lookup, creation, similarity and Product details;
- Purchase PACKAGED/BULK fields, optional Person/Payment Method and typed errors;
- Product details explicit action/tap/keyboard; double-click optional.

### D. Lists and History

- implement `personal-cycle-v1` exactly as J defines it;
- Storage/Shortage/Market/All plus explicit unavailable result;
- threshold editing and invalidation after registration;
- avoid N+1/full-history per Product where a bounded query can serve projections;
- History multi-selection through accessible controls;
- Move to Analytics visible disabled;
- deterministic CSV export;
- PDF grouped list + explicit save/share behavior using minimal compatible deps;
- export/share is explicit and read-only; no silent upload.

## 4. Required validation

From `clients/markei_flutter/`, run and report exact commands/results:

1. dependency resolution and generated-code regeneration;
2. formatting for touched Dart files;
3. targeted quantity/identity/error/cycle/export tests;
4. targeted navigation/Catalogue/Purchase/History/Lists/Settings widget tests;
5. fresh-v3 database test;
6. representative file-backed v2→v3 migration, close/reopen and archived-reference test;
7. injected migration/registration failure proving rollback/no silent reset;
8. full Flutter test suite;
9. Flutter analysis;
10. Windows release build and bounded manual smoke when available;
11. Android build/runtime checks when the host permits;
12. protected Python regression suite.

Classify separately: source inspection, unit/widget evidence, file-backed evidence, build,
manual runtime, lifecycle, host-unvalidated and deferred.

## 5. Stop conditions

Stop and report before broader mutation if:

- v2 data cannot migrate without Product collision/merge or Purchase rewrite;
- optional references block registration/history/export;
- exact lookup weakens Account isolation or identity uniqueness;
- BULK pricing requires competing authoritative money facts;
- Lists must invent history or persist an unapproved cache;
- PDF/share requires unsupported, abandoned or incompatible dependencies;
- export includes unselected/private data or uploads it;
- atomic Purchase registration or Python database isolation changes;
- work expands into Store identity, SubmissionId, persisted drafts, sync or release.

## 6. G report

Replace G with a concise C09 report: starting/final commit, changed/created/deleted paths,
dependencies, schema/migration actions, commands/results, completed/skipped instructions,
platform evidence boundaries, blockers, residual risks and rollback notes. Maximum 250 lines.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
