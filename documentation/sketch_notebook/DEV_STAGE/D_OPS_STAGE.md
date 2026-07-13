# D_OPS_STAGE

> Cycle: 08 — Shared-Client Product Beta
> Round: C08-R01
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
> Purpose: Domain confrontation; no implementation authority
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> Main source: `[M]_STAGE/J_[M]_STAGE.md` at reconciliation commit `fc22f0484b2896f3ee579cd76f489fab1487b56d`

This file is an iterative staging draft. It does not authorize source, dependency, schema, tool, host, infrastructure, permanent-memory, or Codex changes.


# 1. Conciliated Operational outcome

Prepare Operational Chat [O] to test whether J’s proposed Cycle 08 product spine can become bounded, reproducible implementation units.

Current accepted evidence remains:

- protected Python/PySide6 beta and separate database;
- Flutter/Dart local client on Windows and Android;
- 27 previously reported Flutter tests and five Python regressions;
- Drift v2, one bounded migration, atomic Purchase persistence and rollback;
- Windows build/runtime and Android debug emulator evidence;
- persistent local Device UUID and monotonic sequence within the tested boundary.

Do not treat prior evidence as current revalidation or production acceptance.

# 2. Required preflight for any later materialization

Before final D/E/F activation, require:

1. usable checkout on the required branch;
2. clean or explicitly reconciled worktree;
3. exact HEAD and remote ancestry;
4. `git ls-files` inventory;
5. generated-versus-handwritten ownership;
6. current Flutter/Dart, Android, Windows, Python and build-tool versions;
7. protected Python database and Flutter app-private database paths;
8. baseline commands with exact pass/fail evidence.

Candidate baseline:

```text
flutter doctor -v
flutter devices
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build windows
flutter build apk --debug
python -m unittest discover -s tests
```

These commands are proposed validation, not authorized execution in this round.

# 3. Provisional validation sequence

## Gate O1 — Repository safety

Evidence:

- required branch and exact activated implementation commit;
- no unrelated changes;
- generated diff explained;
- no tracked build/runtime database artifacts;
- protected Python source/data unchanged.

Stop if repository state cannot be attributed safely.

## Gate O2 — Automated correctness

Require:

- formatting and static analysis;
- all Flutter tests;
- Python regressions;
- generated Drift consistency;
- Product exact-match and advisory-similarity tests;
- Store selection/create tests;
- draft edit/remove/review tests;
- atomic rollback;
- History detail/projection tests;
- analytics comparability fixtures.

## Gate O3 — Registration retry

Confront the favored submission-identity proposal with:

- ordinary double tap;
- identical retry;
- conflicting retry;
- failure before transaction;
- failure inside transaction;
- unknown result presentation;
- restart after committed result.

Pass only if no partial or duplicate Purchase is created and the UI can describe the outcome honestly.

A busy flag alone is insufficient.

## Gate O4 — Migration and recovery

Require:

- fresh database;
- representative schema-v2 database;
- any proposed next schema migration;
- close/reopen and cold restart;
- failed migration without silent reset;
- missing/unreadable database classification;
- insufficient-storage failure;
- corruption recovery boundary;
- no direct access to Python data.

## Gate O5 — Responsive and lifecycle matrix

Cover:

- Windows narrow and wide layouts;
- Windows scaling candidates;
- Android portrait and landscape;
- keyboard and focused-field visibility;
- Back behavior;
- larger text;
- background/resume;
- registered History after restart;
- explicit Purchase-draft behavior;
- no duplicate submission.

Automated widget evidence and manual host evidence must remain separately classified.

## Gate O6 — Volume and performance

Human/Main must first select dataset tiers and budgets. Candidate tiers for measurement only:

- 100, 1,000 and 10,000 Products;
- 100, 1,000 and 10,000 Purchases where locally practical.

Record launch, search, History list/detail and comparison latency plus failure behavior. Do not convert these candidates into acceptance thresholds without human approval.

## Gate O7 — Backup/export boundary

Compare:

A. versioned export plus tested restore;  
B. export-only with explicit non-backup wording;  
C. local-only beta with explicit uninstall/data-clear loss warning.

A UI export action without restoration evidence is not an accepted backup.

# 4. Carried Device gate

During Cycle 08, preserve current behavior without claiming multi-device correctness.

Before Cycle 09 require:

- exactly one current-installation relation;
- concurrency-safe bootstrap;
- unique Device/sequence ownership;
- historical Device preservation;
- defined uninstall/data-clear/reinstall/restore semantics;
- tests preventing backup restoration from cloning Device identity accidentally.

R02 must recommend whether this becomes a Cycle 08 Sprint 05 implementation or a Cycle 09 entry blocker.

# 5. Cost and sequencing constraints

Provisional relative costs:

- repository/static baseline: low;
- automated workflow coverage: medium;
- schema/idempotency migration: medium–high;
- manual responsive/lifecycle matrix: high;
- volume/performance evidence: medium–high;
- physical-device breadth: high;
- signing/distribution: Cycle 10.

Do not combine responsive restructuring, schema idempotency, analytics, Device migration and backup in one implementation unit.

# 6. Operational questions for C08-R02

Operational Chat must answer:

1. What existing tests can be extended without new dependencies?
2. Which proposed gates require schema or host mutation?
3. What exact evidence separates identical retry, conflict and unknown outcome?
4. Which lifecycle behavior is automated versus manual?
5. What dataset tiers are reproducible at reasonable cost?
6. Which backup alternative is operationally honest for Cycle 08?
7. When must Device correction occur?
8. What first implementation unit has the smallest reversible validation surface?

# 7. Required R02 report

Replace A with C08-R02 and report:

- agreement or conflict with J and this D;
- corrected gates;
- exact likely files/tests involved, without editing them;
- costs and stop conditions;
- human decisions still blocking executable staging;
- recommendation for the first bounded implementation unit.

No command execution, host mutation, commit, or source edit is authorized by this file.

---

<!-- ENRICHMENT_MARKER:C08-C08-R02-Operational-2026-07-13 -->
# Cycle 08 Round C08-R02 — Provisional Operational Enrichment

> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX  
> Purpose: Domain confrontation; no implementation authority  
> Main source: J C08-R02 reconciliation at `b244f41c9f76baec3123e7584364969bcc7bc588`  
> Inputs: latest cumulative A/B/C C08-R02 rounds and preceding D/E/F content

## 1. Successive-round classification

Retained:

- clean-checkout and tracked-file preflight;
- baseline analysis/tests/build evidence;
- atomicity and retry as separate gates;
- migration/no-silent-reset;
- responsive/lifecycle matrix;
- volume measurement before acceptance budgets;
- backup alternatives;
- Device hard gate before synchronization.

Corrected:

- current Catalogue/Store query ports are latent; Store/Product selection journeys are not implemented;
- tab-switch draft retention already exists through IndexedStack;
- History has fixed-50/N+1 behavior and collapses error/loading into empty;
- MASS/BRL are current UI limits;
- 100/1,000 are better initial measurement tiers than assuming 10,000 as an entry gate;
- corruption/insufficient-storage evidence may require explicit adapter seams or controlled fault injection.

Newly added:

- typed presentation/error-state validation;
- raw-exception and Device-sequence copy audit;
- current query-count evidence;
- Product-code cross-layer gate;
- Store normalization collision gate;
- schema-free versus schema-bearing execution split.

## 2. Exact current surfaces

Operational confrontation should trace:

- shell state: `app/markei_app.dart`;
- draft and registration UI: `app/pages/purchase_page.dart`;
- History states: `app/pages/history_page.dart`;
- Catalogue/Store ports: `application/catalogue_queries.dart`;
- command/result: `application/register_purchase.dart`;
- History summary contract: `application/purchase_history.dart`;
- local transaction: `infrastructure/local/local_purchase_repository.dart`;
- query cost: `infrastructure/local/local_query_repository.dart`;
- schema/migrations: `infrastructure/local/local_database.dart`;
- Device selection: `infrastructure/local/local_device_identity_repository.dart`.

## 3. Schema-free candidate gates

### O2.1 Shell and states

Proposed later evidence:

- constraint-driven narrow/wide destinations;
- selected destination preserved on resize;
- distinct loading, empty, error and success;
- raw exceptions never rendered;
- Device sequence absent from normal success copy;
- keyboard, focus, Back and larger text;
- current tab-switch draft retention preserved intentionally.

### O2.2 Draft coordinator

If session-only:

- add/replace/remove/cancel;
- stable draft-line identity;
- running total;
- review phase;
- busy/failure/success/unknown algebra;
- no persistence or migration;
- pure coordinator tests plus widget tests.

### O2.3 Product/Store selection presentation

Using existing ports:

- list/empty/search behavior;
- existing Product choice;
- similar advisory candidates;
- explicit create-anyway;
- Store list/select/create UI.

Do not claim durable Store deduplication until its identity policy exists.

### O2.4 History query correction

Before analytics:

- distinguish loading/empty/error;
- eliminate or measure N+1 Item counts;
- expose occurrence time;
- define bounded paging/list behavior;
- add Purchase detail query.

## 4. Schema-bearing candidate gates

Treat independently:

1. SubmissionId uniqueness and retry-result recovery;
2. Store normalized/branch identity;
3. optional Product code;
4. History performance indexes;
5. installation-to-Device relation;
6. durable drafts.

Each requires:

- explicit schema version;
- representative v2 fixture;
- backfill/collision policy;
- migration failure without reset;
- reopen/restart;
- generated Drift reconciliation;
- targeted transaction tests.

## 5. Evidence requests for Operational C08-R03

Report:

- exact current baseline commands and host requirements;
- which existing tests extend each schema-free candidate;
- query count/plan for current History;
- feasible failure injection for startup/query/transaction/migration;
- known-outcome versus unknown-outcome retry evidence;
- measured cost for 100/1,000 dataset tiers;
- minimum Windows/Android matrix;
- honest backup alternative;
- timing recommendation for Device correction;
- smallest reversible implementation unit.

## 6. Decisions Main cannot infer

- accepted destination topology;
- Product-code policy;
- quantity truth;
- Store identity;
- draft lifetime;
- busy-only versus durable idempotency;
- export/restore promise;
- performance budgets;
- Device timing.

## 7. Next enrichment condition

D may become more exact only after A C08-R03 reports repository/test evidence and the high-impact human choices are narrowed.

Codex remains inactive.


---

<!-- CODEX_ACTIVATION_MARKER:C08-ACT-01-Operational-2026-07-13 -->
# Cycle 08 — Codex Activation C08-ACT-01

> Status: ACTIVE — AUTHORIZED FOR CODEX IMPLEMENTATION
> Authority: explicit Main/human authorization on 2026-07-13
> Scope: bounded Unit 1 only — responsive shell and typed presentation states
> Supersedes: earlier “Codex remains inactive” and “not authorized” statements only for the scope defined below

## Authorized operational scope

Codex may now:

- verify and work only on `cycle-08-shared-client-product-beta`;
- modify the Flutter client source and tests required for bounded Unit 1;
- implement constraint-driven narrow/wide navigation while preserving destination selection;
- distinguish loading, empty, error and success presentation states where Unit 1 touches existing Purchase/History surfaces;
- replace raw exception and Device-sequence user copy where required by this unit;
- run the existing repository validation, analysis, test and build commands;
- materialize G/H/I evidence for this bounded unit.

## Required gates

Before editing, Codex must load the complete methodology through `INDEX.md` and `PROMPT_COLLECTION.md`, execute the Codex initialization prompts, verify branch/HEAD/worktree safety, and record baseline evidence.

Completion requires focused tests plus the existing Flutter test/analyze checks that are available in the host. Platform build evidence must be reported truthfully; unavailable host evidence is not a pass.

## Exclusions and stop conditions

This activation does not authorize:

- new dependencies or tool installation;
- schema or migration changes;
- Product-code, Store-identity, SubmissionId, durable-draft or Device redesign;
- authentication, API, Neon or synchronization;
- Python/PySide6 beta or its database;
- backup/restore, analytics, or later bounded units;
- silent deletion, reset, stash, cleanup or overwrite of unrelated work.

Codex must stop and return to Main if Unit 1 requires an excluded change, the branch/worktree is unsafe, or repository truth contradicts D/E/F.

This latest activation marker controls Codex authority for D.
