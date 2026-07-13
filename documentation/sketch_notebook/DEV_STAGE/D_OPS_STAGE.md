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
