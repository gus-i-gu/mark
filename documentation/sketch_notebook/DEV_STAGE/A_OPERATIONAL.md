# Main Synthesis Summary

Operational recommends that Sprint 02 prototype one **Android-first, offline-only vertical slice using the existing Python core behind an injected mobile database path**, with a Python-native UI as the cheapest first falsification test—not as a final architecture selection. The present models and calculations are reusable Python; the application is not mobile-portable as constructed. `ProductService()` creates a concrete `Repository`, which opens desktop-oriented SQLite lifecycle code, and `user_data_dir()` defaults to `~/AppData/Local/Markei`. A mobile run therefore requires a bounded construction/path seam before any UI can safely exercise the core.

If Main prioritizes long-term Android/iOS UX and conventional distribution over maximum immediate Python reuse, Approach C (a cross-platform client with explicit contracts and fixtures) is the stronger strategic candidate. It costs a second runtime implementation. Approach B is feasible but similarly cannot execute the current Python core locally without adding a bridge, rewrite, or service. Approach D has no demonstrated requirement and should be deferred.

Cycle 06 is accepted and closed. `operational/10_OPERATIONAL_STATE.md` still says acceptance is pending; this is inherited checkpoint drift, superseded for global status by `00_PROJECT_STATE.md` and `J_[M]_STAGE.md`. Nothing in this investigation reopens Cycle 06.

## Evidence and baseline

**Observation — repository identity.** Inspection explicitly used branch `cycle-07-mobile-preparation`. The recorded and verified Cycle 07 baseline is `f6414fbe7394453387067a5a34ca6cc7621bbed3` (`Close Cycle 06 and hand off Cycle 07`). That commit is an ancestor of the inspected HEAD. At inspection time, the branch and `origin/cycle-07-mobile-preparation` were at `889c9ac365e0d717ac33431bd82af286b0f343f1`, one later staging commit (`Stage Cycle 07 Sprint 01 domain investigation`). No default-branch or `sketch-notebook-recovery` content was used for recovery.

**Inspected project evidence.** Methodology boot and Cycle context followed the assigned order: `AGENTS.md`, `INDEX.md`, the four methodology files, `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, `operational/10_OPERATIONAL_STATE.md`, and `[M]_STAGE/J_[M]_STAGE.md`. Implementation inspection covered `app/core/models.py`, `contracts.py`, `services.py`, `repository.py`, `database.py`, `config.py`; all files under `app/desktop/`; empty `app/mobile/main.py`; `app/main.py`; root `main.py`; `app/database/schema.sql`; and, because dependencies and validation were uncertain, `requirements*.txt`, import maps, and `tests/test_release_configuration.py`. No tools were installed, no framework was initialized, no application command was run, and no database was opened.

External feasibility evidence was limited to current official documentation. Kivy documents Android packaging through python-for-android/Buildozer; Buildozer runs on Linux/macOS (Windows through WSL), downloads SDK/NDK prerequisites, and can build/deploy/run an APK. Its iOS route compiles Python/modules, creates an Xcode project, and requires macOS tooling. Capacitor currently requires Node 22+, Android Studio/SDK for Android, and macOS/Xcode for iOS; its guidance warns that browser `localStorage` is unsuitable for durable mobile records and distinguishes native storage. Flutter supports Android and iOS deployment, but iOS release likewise requires macOS/Xcode. These sources establish procedures, not compatibility with Markei.

## Implementation-surface classification

| Classification | Surfaces | Operational evidence |
| --- | --- | --- |
| Platform-neutral and likely reusable | `models.py`; calculation, validation, date/status functions in `services.py`; constants in `config.py`; schema semantics provisionally | Standard-library Python and dataclasses; no Qt imports in core. Business calculations can be unit-tested headlessly once persistence construction is isolated. |
| Platform-neutral but coupled by construction/imports | `contracts.py`; `ProductService`; UI-facing list/history dictionaries; `Repository` API | `ServiceContract` exists, but `ProductService.__init__` directly creates concrete `Repository`; repository contract does not cover all methods actually used. Read models contain formatted labels useful to the desktop presentation. |
| Desktop-specific | `app/main.py`, root `main.py`, all `app/desktop/`, startup diagnostics and Windows release files | Qt application/event loop, PySide6 widgets/dialogs, desktop page-owned services and refresh/close coordination. |
| Persistence-specific | `repository.py`, `database.py`, `schema.sql` | Concrete `sqlite3`, SQL/row mapping, commits, WAL, schema initialization/migration/defaults, global module paths. SQLite semantics may transfer; lifecycle/path code does not yet. |
| Presentation-specific | Qt pages/widgets plus formatted UI projection fields in service read models | Qt imports are confined to desktop, but labels/groupings encode presentation choices inside service output. |
| Unknown until tested | CPython/SQLite behavior inside chosen mobile runtime; WAL and file-lock lifecycle; schema resource bundling; suspend/resume; Unicode/date behavior; APK/AAB and iOS archive; accessibility/performance; backup/uninstall behavior | No mobile dependency, configuration, test, artifact, emulator evidence, or populated mobile entry point exists. |

**Observation.** `schema.sql` declares `products` before referenced `categories`; SQLite accepted this on desktop, but fresh initialization must still be tested on the packaged runtime. Dates are stored as formatted text and the service owns parsing, which avoids platform date APIs but requires fixture parity. Repository methods commit independently, preserving the inherited multi-step workflow atomicity risk.

## Operational approach comparison

| Approach | Reproducibility and platforms | Offline persistence/testability | Cost and failure states | Operational disposition |
| --- | --- | --- | --- | --- |
| A. Shared Python core + Python-native UI | Maximum source reuse. Android build introduces Linux/WSL, Buildozer, SDK/NDK, JDK and emulator/device layers. iOS adds macOS, Xcode and a separate Python-for-iOS build. Tool versions must be pinned beyond current `requirements.txt`, which contains only PySide6. | Python `sqlite3` and current schema are promising if the runtime includes SQLite and receives an app-private path. Headless service tests can reuse Python fixtures. | Native packaging, binary recipes, resource inclusion and mobile lifecycle are the main risks; custom UI/accessibility maturity must be tested. Windows alone cannot close iOS gates. | Best low-cost **prototype/falsification** route; do not treat first Android success as cross-platform acceptance. |
| B. Web/hybrid presentation | Familiar web tooling and fast UI iteration; Android Studio and Xcode remain for packaged targets. No web project exists. Current Python does not execute in a normal Capacitor client. | Needs a mobile SQLite plugin/adapter or IndexedDB design; lightweight preferences/localStorage are not adequate for Markei’s relational ledger. Contract tests must span JS/TS and Python behavior if rules are ported. | Plugin/version churn, bridge failures, webview lifecycle, database migrations, and a second business implementation or premature service are likely costs. | Viable if web skills dominate, but not the smallest evidence path from this repository. |
| C. Native/cross-platform client + explicit contracts | Flutter-like tooling provides established Android/iOS build paths; Android is accessible from Windows, iOS build/release requires macOS/Xcode. Python runtime reuse is low. | Mature local SQLite options are plausible but must be selected/tested. JSON fixtures and expected projections can test semantic parity independently of the desktop database. | Highest initial porting and dual-language maintenance cost; strongest conventional mobile lifecycle/UX path. Contract drift is the primary product risk. | Strong strategic candidate after contracts/fixtures are made executable; reasonable primary choice if Main values platform fit over immediate reuse. |
| D. Service-backed client | Adds server runtime, deployment, network observability, secrets/accounts and API compatibility to every client build. | Offline-first would still need local persistence, queues, retries, conflict resolution and migrations; a backend does not remove client storage. | Network failure, authentication, hosting cost, privacy, sync conflict and operational support become new mandatory surfaces. | **Constrained out:** no multi-device, household-sharing or account requirement currently justifies it. |

**Assumption.** The next prototype is single-user, single-device, offline-first and may use a fresh isolated database whose logical schema resembles desktop Markei. It neither opens nor copies the ordinary desktop database. Export/import and synchronization are deferred boundaries.

**Blockers to implementation, not to investigation.** No approach has been selected by Main; `app/mobile/main.py` is empty; no mobile requirements or lockfile exist; no injectable repository/database path exists; no mobile-safe lifecycle contract exists; no contract fixture suite exists; installed SDK/JDK/Android Studio/Xcode/device availability has been evidenced. iOS validation cannot be claimed without a macOS/Xcode execution environment and suitable signing/device arrangements.

## Later prototype commands and validation gates (do not execute yet)

Commands below are reproducibility templates. Exact pinned versions and framework-generated filenames must be authorized and recorded by the later materialization stage; placeholders must not be pasted blindly.

### Gate 0 — isolation and host inventory

```text
git switch cycle-07-mobile-preparation
git status --short --branch
git rev-parse HEAD
git merge-base --is-ancestor f6414fbe7394453387067a5a34ca6cc7621bbed3 HEAD
python --version
java -version
adb version
<framework-command> --version
```

Pass: correct descendant branch, clean intended scope, and captured host/tool versions. For Android, capture SDK/API, build-tools, NDK and emulator/device IDs. For iOS, separately capture `xcodebuild -version`, simulator/device target and signing boundary on macOS.

### Gate 1 — host-side contract and isolation tests

```text
python -m unittest discover -s tests -v
python -m unittest tests.test_mobile_core_contract -v
```

The future test must inject a temporary database directory, initialize schema/defaults, register one deterministic receipt, read one Lists projection, close, reopen, and assert persistence. It must assert that the resolved path is inside the temporary/mobile sandbox and differs from desktop `DATABASE_PATH`. Pass before framework build.

### Gate 2 — Android debug build and install

For an authorized Kivy/Buildozer spike, the official command shape is:

```text
buildozer android debug
adb devices
adb install -r <generated-debug-apk>
adb shell am start -n <application-id>/<activity>
adb logcat
```

Equivalent authorized framework commands may replace these, but gates remain: clean build; install; cold launch; no permission/path/schema error; isolated database created; empty list shown; one receipt registered; projection updated; app backgrounded/foregrounded; process stopped and relaunched; record remains; ordinary desktop database hash/path unchanged. Capture logs and artifact checksum. Then validate uninstall/reinstall semantics explicitly—data loss on uninstall may be expected, but must be recorded rather than inferred.

### Gate 3 — iOS parity

On macOS only, use the chosen framework’s generated Xcode project and `xcodebuild`/simulator procedure. Pass the same cold-launch, write/read, suspend/resume and terminate/reopen gates. Android success does not waive this gate or establish App Store distributability.

## Smallest vertical-slice constraint

**Recommendation.** Authorize one Android emulator/device slice: mobile launch → application-private fresh SQLite initialization → show only the Lists/Storage projection → register one product/purchase through the ProductService-equivalent workflow → return to the list → terminate and relaunch → verify the same record. Use one hard-coded/default category and store only where current structural defaults already define them. Exclude editing, History analytics, Settings, synchronization, desktop import, release signing and store publication.

For Approach A, the minimum enabling change is not a broad core refactor: permit `ProductService` to receive a repository (or equivalent persistence factory) and permit the database manager to receive/resolve a mobile app-private data/resource location. Keep the desktop default behavior intact and prove it with existing release tests. If that seam becomes invasive or the packaged SQLite/core cannot pass lifecycle gates, stop the Python-native spike and use the recorded contracts/fixtures to compare Approach C rather than adding a backend.

## Handoff to Main

Main should reconcile this with Design’s boundary recommendation and Didactic’s learning cost. Operationally, Approach A is the smallest Android evidence experiment; Approach C is the stronger long-term alternative if platform fit is decisive. Before D/E/F authorization, Main must select the framework, define pinned host/tool versions, authorize the narrow construction/path seam and fixture test, and identify an Android target. Keep iOS explicitly unvalidated until a macOS/Xcode gate runs; keep Approach D deferred absent a synchronization requirement.
