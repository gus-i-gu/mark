# D_OPS_STAGE — Cycle 07 Sprint 04 Windows Local Vertical Slice

> Role owner: Main Chat [M]
> Operational sources: `A_OPERATIONAL.md`, J §21, `06_SESSION_SCHEME.md`
> Status: Main-approved Codex materialization authority
> Repository: `gus-i-gu/markei`
> Required branch: `cycle-07-mobile-preparation`
> Accepted baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> A/B/C inspected head: `495dea0c3bc82f04037bcf55d4f11505e3b482b5`
> J authority commit: `93605b64ebe685ab795790de7121c968e347fb85`
> Sprint outcome: corrected, schema-validated, user-visible local Flutter Purchase workflow executed on Windows
> Maximum scope: this D/E/F package only

---

# 1. Materialization mandate

This is an implementation task.

Codex must modify the authorized Flutter source, local Drift schema, versioned contracts, tests, and G/H/I reports.

A documentation-only response is failure unless a stop condition prevents source work.

The protected Python/PySide6 beta remains untouched and recoverable.

The ordinary Cycle 06 database must never be opened, copied, hashed, migrated, reset, or used by Flutter.

---

# 2. Required result

Implement and validate:

```text
device sequence correction
+ Product identity separation
+ Product user code
+ Unicode normalization v2
+ Drift schema v2 migration
+ shared_beta/v2 JSON Schemas and examples
+ minimal multi-item Purchase interface
+ visible local Purchase history
+ application-private database composition
+ close/reopen persistence
+ Windows build and launch
+ conditional Android build
+ Python regressions
```

Do not begin TypeScript, API, Postgres, Neon, authentication, or actual synchronization.

---

# 3. Preflight

Before editing, run and record:

```powershell
git status --short --branch
git branch --show-current
git rev-parse HEAD
git rev-parse origin/cycle-07-mobile-preparation
git merge-base --is-ancestor f6414fbe7394453387067a5a34ca6cc7621bbed3 HEAD
git diff --name-only
flutter --version
dart --version
flutter doctor -v
flutter devices
python --version
```

Required branch:

```text
cycle-07-mobile-preparation
```

Stop before editing when:

- the required branch is not active;
- the accepted baseline is not an ancestor;
- uncommitted changes overlap authorized paths;
- remote/local divergence cannot be reconciled without force;
- D/E/F disagree;
- the ordinary database cannot remain isolated.

Non-overlapping user changes must be preserved.

Never run `git reset --hard`, `git clean`, destructive checkout, or force-push.

---

# 4. Environment baseline

Expected recorded environment from Sprint 03:

```text
Flutter 3.44.6 stable
Dart 3.12.2
Windows host
Android SDK absent
Visual Studio C++ workload absent
```

Use the installed Flutter stable toolchain.

Do not upgrade Flutter/Dart unless the current project cannot resolve with the recorded version and the user separately approves the upgrade.

Commit the resolved `pubspec.lock`.

---

# 5. Authorized Dart dependencies

Authorize:

```yaml
unorm_dart: ^0.3.2
json_schema: ^5.2.2
```

Use `unorm_dart` for local Unicode normalization.

Use `json_schema` in contract-validation tests.

No runtime remote schema fetch is allowed.

Schema references must resolve from local files or in-memory caches.

No new state-management, routing, networking, authentication, telemetry, or cloud dependency is authorized.

If dependency resolution selects compatible newer patch versions, retain the lockfile and report exact versions.

Stop if either package cannot resolve with the current Dart SDK.

---

# 6. Windows tooling permission

The user authorizes Windows tool installation required by this D/E/F package.

First diagnose:

```powershell
flutter doctor -v
winget --version
winget list --id Microsoft.VisualStudio.2022.Community
winget list --id Microsoft.VisualStudio.2022.BuildTools
```

Required Flutter workload:

```text
Microsoft.VisualStudio.Workload.NativeDesktop
Desktop development with C++
MSVC toolchain
Windows SDK
CMake tools
```

If no suitable Visual Studio installation exists, Codex may request sandbox/UAC approval and run:

```powershell
winget install --id Microsoft.VisualStudio.2022.Community -e --override "--wait --passive --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended"
```

If Visual Studio exists without the workload:

- prefer modifying it through Visual Studio Installer;
- request the required UAC approval;
- select `Desktop development with C++`;
- do not remove existing workloads;
- do not install optional unrelated workloads.

After installation:

```powershell
flutter doctor -v
flutter devices
```

Pass requires:

- Visual Studio Windows-development check passes;
- a Windows device appears.

Stop and report when:

- enterprise policy blocks installation;
- UAC is denied;
- winget is unavailable;
- a reboot is required;
- installation would replace/remove unrelated components;
- Flutter doctor remains red after one bounded repair attempt.

Do not repeatedly reinstall Visual Studio.

---

# 7. Android boundary

Android installation is not authorized by this package.

Run:

```powershell
flutter doctor -v
flutter devices
```

If an Android SDK is already healthy:

```powershell
flutter build apk --debug
```

If it is absent or unhealthy:

- do not install Android Studio;
- do not install SDK packages;
- record the exact doctor/device blocker;
- classify Android as host-blocked without failing Sprint 04.

Android execution is not required.

iOS is outside scope.

---

# 8. Authorized repository paths

Codex may create or modify only:

```text
clients/markei_flutter/pubspec.yaml
clients/markei_flutter/pubspec.lock
clients/markei_flutter/lib/**
clients/markei_flutter/test/**
clients/markei_flutter/integration_test/**
clients/markei_flutter/windows/** only when Flutter regeneration changes required generated integration
clients/markei_flutter/android/** only when an authorized conditional build requires conventional regeneration
contracts/shared_beta/v2/**
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Generated `local_database.g.dart` may be regenerated and committed.

Do not edit generated source manually.

Do not modify:

```text
app/**
tests/** except running the existing Python tests
contracts/shared_beta/v1/**
documentation/sketch_notebook permanent files
A/B/C
D/E/F after materialization begins
J
00/05/06
methodology/**
installer/**
build/**
dist/**
ordinary SQLite data
```

If a required change falls outside authorized paths, stop and report.

---

# 9. Implementation order

Use this order:

1. Add dependencies.
2. Add failing Product identity/Unicode tests.
3. Correct domain identity behavior.
4. Add failing repeated-sequence tests.
5. Correct Device creation/allocation and uniqueness.
6. Advance Drift schema to v2.
7. Add v1→v2 migration rehearsal.
8. Create v2 JSON Schemas/examples.
9. Add schema-validation tests.
10. Add repository read/query operations.
11. Add composition root and local database lifecycle.
12. Add minimal Purchase UI.
13. Add local history UI.
14. Add widget/integration tests.
15. Run generation, format, analysis, and tests.
16. Install/validate Windows tooling when needed.
17. Build and launch Windows.
18. Attempt Android build only if already available.
19. Run Python regressions.
20. Audit scope and update G/H/I.

Do not implement UI before correctness tests exist.

---

# 10. Required correctness tests

Product tests must prove:

- internal Product ID is immutable and UUID v4 for new rows;
- user Product code is required;
- display code is preserved;
- normalized code is account-scoped and case-insensitively unique;
- code length after trim is 1–64 characters;
- composed/decomposed Portuguese accents normalize equally;
- display name and brand are preserved;
- semantic normalization does not remove `é`, `ã`, `ç`, or `ó`;
- PACKAGED identity includes canonical quantity;
- BULK identity excludes package quantity;
- gram/kilogram equivalence remains;
- similarity only warns;
- no automatic merge occurs.

Sequence tests must prove:

- first registration uses sequence 1;
- second uses 2;
- third uses 3;
- reopen continues with 4;
- invalid Purchase does not consume a committed sequence;
- duplicate account/device/sequence is rejected;
- Device registration never resets an existing sequence.

Migration tests must prove:

- fresh v2 creation;
- v1 Product/Purchase/event data survives v2 open;
- old Product IDs and Purchase references remain unchanged;
- legacy Product rows receive unique temporary user codes;
- migration ledger records runtime execution;
- migration failure does not silently delete/reset data.

---

# 11. Contract validation commands

Contract tests run through Flutter/Dart tests.

Required schemas:

```text
contracts/shared_beta/v2/schemas/catalogue_product.schema.json
contracts/shared_beta/v2/schemas/purchase_aggregate.schema.json
contracts/shared_beta/v2/schemas/purchase_registered_event.schema.json
```

Required example groups:

```text
contracts/shared_beta/v2/examples/valid/**
contracts/shared_beta/v2/examples/invalid/**
```

Tests must:

- load every schema locally;
- validate every valid example;
- reject every invalid example;
- assert expected validation failures;
- separately test cross-field domain invariants;
- avoid network access.

Schema Draft 7 is the accepted structural target.

---

# 12. Required Flutter validation

From `clients/markei_flutter`:

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format .
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

All must pass.

Do not suppress analyzer failures broadly.

Do not delete meaningful tests to obtain a pass.

---

# 13. Windows build and launch

After doctor passes:

```powershell
flutter build windows
flutter run -d windows
```

Required launch evidence:

- Markei window opens;
- no startup exception;
- app-private database initializes;
- Purchase form is visible;
- history view is reachable;
- no Cycle 06 path is opened.

If interactive automation is unavailable, Codex must:

1. launch successfully;
2. record console/startup evidence;
3. provide the human checklist in G;
4. classify human interaction as pending rather than fabricated.

Do not claim the UI workflow passed without executed interaction evidence.

---

# 14. Human manual acceptance checklist

Ask the user to perform only after a successful Windows launch:

1. Start a Purchase.
2. Enter a Store.
3. Create a Product with a personal Product code.
4. Add two Purchase Items.
5. Review the displayed total.
6. Register the Purchase.
7. Confirm success.
8. Open history.
9. Confirm Store, time, total, and item count.
10. Close the app.
11. Launch it again.
12. Confirm the Purchase still appears.

The user reports pass/fail and any visible message.

Codex records human-reported evidence distinctly from automated evidence.

---

# 15. Python regression boundary

Run from repository root:

```powershell
python -m unittest discover -s tests
```

Before and after, verify:

```powershell
git status --short
git diff -- app/database/market.sqlite
```

Do not launch the ordinary Python application as incidental validation.

Do not run destructive reset helpers.

Pass requires no tracked Python/database change.

---

# 16. Data isolation evidence

Flutter must use:

```text
platform application-support directory
/ markei_shared_beta.sqlite
```

Tests use temporary or in-memory databases.

Add safe diagnostic access sufficient to report the Flutter database path without reading user data.

Prove the path differs from Cycle 06 `%LOCALAPPDATA%/Markei/market.sqlite`.

Never print Purchase contents, Product names, or other user data in diagnostic logs.

---

# 17. Failure and rollback behavior

Implementation failures must not trigger:

- silent database deletion;
- schema reset;
- fallback to Cycle 06 database;
- partial Purchase persistence;
- partial sequence allocation;
- Product auto-merge;
- dependency/toolchain broad upgrade;
- source changes outside scope.

If schema migration fails, preserve the database and surface an actionable error.

Rollback means reverting only the new Sprint 04 implementation changes through an intentional later patch.

Do not erase evidence.

---

# 18. G/H/I reporting

Update G with:

- environment and tool versions;
- authorized installations;
- commands and results;
- changed files;
- generated files;
- Windows build/launch evidence;
- Android result/blocker;
- database-path isolation;
- Python regression;
- manual checklist status;
- failures and stop conditions.

Update H with:

- fixtures and concepts evidenced;
- code/internal/central identity distinction;
- Unicode and schema-validation evidence;
- local queue versus sync distinction;
- learner evidence limits;
- no automatic maturity change.

Update I with:

- final topology;
- Product identity responsibilities;
- schema v2 and migration;
- transaction/sequence ownership;
- UI/application dependency direction;
- contract ownership;
- deviations and deferred boundaries.

Do not update permanent documentation.

---

# 19. Final scope audit

Run:

```powershell
git status --short
git diff --stat
git diff --name-only
```

Report every changed path.

Only authorized paths may remain.

Do not commit or push unless the invoking Codex prompt separately authorizes publication.

Final response must lead with:

- source implemented;
- tests passed/failed;
- Windows build/launch state;
- human action still needed;
- exact blockers;
- G/H/I updated.
