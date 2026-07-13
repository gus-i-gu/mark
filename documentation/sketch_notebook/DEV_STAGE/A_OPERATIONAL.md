# A_OPERATIONAL — Cycle 08 Round C08-R01

> Role: Operational Chat [O]
> Cycle: 08 — Shared-Client Product Beta
> Round: C08-R01
> Status: FUNCTIONAL STAGING — FOR MAIN RECONCILIATION
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> HEAD: `60105fab8eac4ac858d8a36674e358737e1c9f98`
> Scope: investigation and evidence only; no implementation authority

## 1. Methodology loaded and authority check

The complete Cycle 08 boot route was consulted in the required order: root `AGENTS.md`, `INDEX.md`, `PROMPT_COLLECTION.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, `CHAT_BEHAVIOUR.md`, and `METHOD_GLOSSARY.md`.

PRI-O establishes Operational ownership of execution, environments, reproducibility, runtime, persistence, validation, operational cost, failure states, and implementation evidence. PMC-01 confirms that this chat may write only the explicitly authorized functional stage. PMC-02 confirms the route `A/B/C ↔ J ↔ provisional D/E/F ↔ renewed A/B/C`, with D/E/F non-executable until final human/Main activation. MSU-02 authorizes this read-only investigation and replacement of A only.

Prohibited here: application source, dependencies, schemas, tools, infrastructure, permanent memory, methodology, J, D/E/F, G/H/I, architecture selection, Didactic promotion, commit, or push.

Knowledge-state discipline: repository and G evidence may establish implemented or tested facts; generated host structure is not runtime validation; build/startup is not complete interaction acceptance; proposed Cycle 08 work remains staged, not accepted implementation.

## 2. Branch and repository-state verification

GitHub branch lookup confirmed `cycle-08-shared-client-product-beta`. Comparing the expected commit with the branch returned `identical`, `ahead_by: 0`, and `behind_by: 0`; therefore the remote branch HEAD is exactly `60105fab8eac4ac858d8a36674e358737e1c9f98`.

The supplied local workspace was not a usable checkout, so local `git status`, `git branch`, and `git pull` could not be executed. All investigation reads were therefore made through GitHub with the branch ref explicitly pinned. This is an environment limitation, not repository drift. No default-branch content or uploaded ZIP was used.

Notebook contradiction: older headers in `00_PROJECT_STATE.md` and `06_SESSION_SCHEME.md` still name the Cycle 07 branch/baseline, while their latest temporal sections correctly activate Cycle 08 on the present branch. Latest temporal sections control recovery, but Main should eventually refresh those headers.

## 3. Repository topology and Operational component inventory

The branch exposes five relevant boundaries:

1. protected Python/PySide6 desktop application (`main.py`, `app/`, `tests/`, `requirements.txt`);
2. Flutter shared client (`clients/markei_flutter/`), including handwritten Dart, generated Drift/plugin code, tests, and Windows/Android hosts;
3. language-neutral contracts/fixtures used for normalization and shared-beta semantics;
4. Sketch Notebook methodology, continuity, domain memory, and staging;
5. local runtime/build outputs, which must remain untracked and data-isolated.

| Exact path/component | Responsibility and ownership | Present state/evidence | Failure modes, debt, Cycle 08 relevance |
| --- | --- | --- | --- |
| `main.py`, `app/main.py` | Handwritten protected Python/PySide6 entrypoints | Still present; five Python regressions previously passed | Must remain runnable and must not open Flutter data. Regression gate throughout Cycle 08. |
| `requirements.txt` | Handwritten Python dependency boundary | Minimal PySide6 requirement | Unpinned dependency resolution reduces long-term reproducibility; packaging baseline remains protected. |
| `clients/markei_flutter/pubspec.yaml` | Handwritten Flutter dependency and SDK contract | Dart `^3.12.2`; Drift, path provider, SQLite, UUID, normalization and test tooling declared | Caret ranges plus a committed lockfile are usable for application builds; upgrades must be deliberate. No new Cycle 08 package is yet justified. |
| `clients/markei_flutter/pubspec.lock` | Generated dependency resolution, repository-owned | Locks the resolved graph, including Drift 2.34.x in the inspected branch | Regeneration can alter build behavior; require clean diff and full regression gates. |
| `clients/markei_flutter/lib/main.dart` and `lib/app/` | Handwritten Flutter bootstrap/composition | App-private composition is created before `runApp` | Initialization failure needs visible, privacy-safe failure handling; lifecycle close/reopen remains incomplete evidence. |
| Flutter domain/application/persistence sources under `clients/markei_flutter/lib/` | Handwritten business workflow and Drift adapter; `.g.dart` files are generated | Account-private catalogue, Store, Purchase/Items, local event queue, History and Device UUID foundation are implemented | Catalogue reuse, Store workflow, staged edit/remove/review, detailed History, price comparison, large-data behavior and recovery remain Cycle 08 work/evidence. |
| Drift schema/migration and generated companions under the Flutter client | Handwritten schema/migration declarations plus generated companions | Schema v2 migration, atomic Purchase transaction, rollback, close/reopen, monotonic sequence and Device persistence were previously tested | Migration chain has only bounded evidence; never silently recreate/reset on migration failure. Backup/export decision is still open. |
| `clients/markei_flutter/test/` | Handwritten unit/widget/integration-style local tests | Latest accepted checkpoint records 27 Flutter tests passing | Automated tests do not cover complete keyboard, Back, focus, rotation, resume, restart, larger text, device diversity or production packaging. |
| `clients/markei_flutter/windows/` | Mostly Flutter-generated host with repository-owned configuration | Release build and startup smoke passed; Windows local workflow human-validated | No production installer/update channel for Flutter, signing, crash recovery, or broad accessibility evidence. Cycle 10 distribution boundary. |
| `clients/markei_flutter/android/app/build.gradle.kts` | Generated host adapted by hand | Stable `com.gusigu.markei`, SDK 36, Java 17; debug APK/install/launch previously validated | Release still uses debug signing and explicitly lacks production signing. Physical-device breadth and full lifecycle remain unvalidated. |
| `clients/markei_flutter/android/app/src/main/AndroidManifest.xml` | Generated host configuration, repository-owned | Markei label, `singleTop`, `adjustResize`, rotation/keyboard config changes, no broad storage permission observed | Manifest flags do not prove keyboard, Back, focus, rotation, process recreation or resume behavior. Manual Cycle 08 matrix required. |
| shared-beta contracts/fixtures | Handwritten language-neutral semantic boundary | v2 normalization/identity and structural examples previously tested | They are not yet a cloud wire protocol or synchronization proof. Preserve through Cycle 08; Cycle 09 activates protocol use. |
| `documentation/sketch_notebook/` | Mixed protected methodology, Main continuity, domain memory and staging | Latest 00/06 sections activate Cycle 08 investigation; A was cleared for replacement | Header/path drift must be reported, not repaired here. `LEGACY_RECONCILIATION.md` was not loaded. |

The GitHub connector exposed pinned file inspection but not a branch-recursive tree endpoint. Consequently the topology above is the verified operational boundary inventory, not a claim that every tracked generated host file was enumerated line-by-line. A later Codex/local checkout should attach `git ls-files` evidence before implementation.

## 4. Verified implementation and evidence state

Accepted carried evidence:

- Flutter 3.44.6 / Dart 3.12.2 environment recorded in Cycle 07 evidence;
- 27 Flutter tests passed;
- Windows Flutter build passed and the local workflow was human-validated;
- Android debug build, install, launch, Purchase registration, and app-private persistence were runtime-evidenced;
- five Python regressions passed;
- persistent installation Device UUID, monotonic sequence, Drift v2 migration, atomic Purchase/Items/event commit, rollback, and bounded close/reopen behavior were implemented/tested;
- protected Python/PySide6 source and ordinary database remain the rollback/reference boundary.

Not established:

- complete Catalogue browse/search/reuse or duplicate-warning journey;
- Store browse/search/select/create and duplicate behavior;
- staged Item edit/remove/cancel/review and duplicate-submit prevention;
- detailed History and first versioned personal price comparison;
- large Catalogue/History responsiveness or measured performance;
- full keyboard, Back, focus, rotation, background/resume, larger-text and cold-relaunch matrix;
- corrupted/missing/unreadable database recovery;
- export, import or backup restoration;
- physical-device breadth, production signing, packaged distribution, upgrade channel, diagnostics/support or privacy operations.

## 5. Cycle 08 operational capacity

The repository can support an additive local-first product-beta implementation without cloud infrastructure. Existing composition, Drift persistence, atomic Purchase transaction, local History foundation, tests, Windows host and Android debug host are sufficient starting capacity.

The economical implementation sequence is:

```text
responsive shell and state/error harness
→ Catalogue and Store selection/create
→ staged Purchase edit/remove/review
→ detailed History
→ versioned price comparison
→ migration/reopen/recovery and volume checks
→ Windows/Android manual acceptance
```

Each unit should retain the Python regressions and avoid dependency/schema expansion unless the unit proves it necessary.

## 6. Carried lifecycle and Device debt

Mandatory carried lifecycle evidence:

- narrow portrait and landscape without overflow;
- keyboard does not hide the active field/action; focus order and validation recovery are coherent;
- Android Back dismisses transient UI first and does not silently discard staged Purchase data;
- rotation and window resize preserve or intentionally reset staged state with explicit behavior;
- background/resume preserves durable facts and defines staged-state behavior;
- process termination and cold relaunch preserve registered Purchases/History;
- larger text, safe areas, scrolling, and tap targets remain usable;
- database close/open and migration failures never silently reset local data.

Device UUID is accepted only for the bounded local prototype. Before Cycle 09 multi-device synchronization, define one current installation relation, uniqueness/concurrency rules, recreation/uninstall behavior, and sequence allocation under concurrent access. Cycle 08 must avoid presenting local Device identity as account authentication.

## 7. Proposed validation gates and costs

| Gate | Evidence | Relative cost |
| --- | --- | --- |
| Repository safety | exact branch/HEAD; `git status`; `git ls-files`; generated diff review; protected Python/database unchanged | Low once a checkout exists |
| Static/generated consistency | `dart format --output=none --set-exit-if-changed .`; `flutter analyze`; Drift generation check | Low–medium |
| Automated regression | complete Flutter tests plus `python -m unittest discover -s tests` | Low–medium |
| Transaction/retry | invalid Item rollback; double-submit/retry; no partial facts/event; sequence continuity | Medium |
| Migration/reopen | fresh DB, previous schema fixture, close/reopen, process restart, failed migration without reset | Medium |
| Product workflow | Catalogue/Store reuse/create, two-item stage/edit/remove/review/register, History detail, comparison | Medium; widget plus manual |
| Responsive/lifecycle | Windows narrow/wide; Android portrait/landscape, keyboard, focus, Back, background/resume, restart, larger text | High; repeated manual matrix |
| Volume/performance | seeded tiers such as 100/1,000/10,000 Products and Purchases; record launch, search, History and detail latency/memory | Medium–high; define budgets before acceptance |
| Platform build | debug Android APK/run and Windows release build/startup | Medium |
| Production packaging | release signing, installer/update, distribution and upgrade rehearsal | High; deferred to Cycle 10 |

Recommended pre-implementation command baseline from `clients/markei_flutter`:

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

Run host builds only on hosts that support them and record versions, duration, warnings, device class, and whether evidence was automated or human-observed.

## 8. Migration, recovery, backup/export boundaries

- Flutter continues using app-private local storage; no broad Android storage permission should be added.
- Cycle 06 Python SQLite and Flutter Drift databases remain separate. No direct legacy conversion is authorized.
- Every schema change needs an explicit old-version fixture, forward migration, rollback/failure test, and no-silent-reset invariant.
- Registered raw facts remain authoritative; projections and price analytics must be rebuildable and versioned.
- Android uninstall/data-clear destroys app-private local-only data unless export/backup exists; this must be plainly documented before beta acceptance.
- Cycle 08 must make a human decision between: (A) supported export plus restore rehearsal; (B) documented device-local beta with explicit destructive-loss warning. A UI button without restoration evidence is not an accepted backup.
- Export should be user-initiated, bounded, integrity-checkable, privacy-conscious and independent of privileged cloud credentials. Import/restore may be deferred only if the beta promise says so explicitly.
- Recovery must distinguish missing database, migration failure, SQLite corruption, insufficient storage, permission/path failure, and user-requested reset. Diagnostics must not expose real Purchase contents.

## 9. Blockers, contradictions, and failure states

1. No usable local checkout was supplied, so current commands/tests and a recursive tracked-file inventory could not be executed in this investigation.
2. Main continuity headers retain Cycle 07 metadata although their latest sections correctly activate Cycle 08.
3. Operational checkpoint drift noted at Cycle 07 materialization may remain; latest Main continuity and repository evidence supersede it for this stage.
4. Product-beta performance budgets and seed volumes are undefined.
5. Backup/export and restore promise is undecided.
6. Staged Purchase survival across navigation, rotation, backgrounding and process death is undefined.
7. Error/retry semantics must prevent duplicate or partial Purchases while keeping user input recoverable.
8. Android release uses debug signing; public distribution is forbidden at this state.
9. No evidence supports production diagnostics, support workflow, privacy deletion, or upgrade recovery.

## 10. Cycle 09/10 deferrals

Cycle 09: verified account, immutable Account UUID, TypeScript API, Neon/Postgres, authentication/authorization, idempotent upload, cursor download, bootstrap/convergence, multi-device current-installation invariant and network retry.

Cycle 10: production secrets, privacy/deletion operations, finalized export/import and disaster recovery, observability/support, release signing, Android distribution, Flutter Windows installer/update path, upgrade testing, controlled public beta, and broader device coverage.

Cycle 08 must preserve these boundaries but must not activate them.

## 11. Human questions

1. Must Cycle 08 beta include a supported export-and-restore workflow, or is an explicit local-only data-loss warning acceptable until Cycle 10?
2. Should staged, unregistered Purchase data survive only in-app navigation/rotation, or also process death?
3. Which physical Android device classes and Windows display/scaling combinations are mandatory for Cycle 08 acceptance?
4. What response-time budgets and maximum Catalogue/History volumes define an acceptable local beta?
5. Is manual Windows/Android acceptance expected after every feature sprint or only at bounded integration gates plus final Cycle acceptance?

## 12. Recommendations to Main

- Keep Sprint 01 read-only and reconcile A/B/C before any D/E/F.
- Split later D/E/F by bounded product units and require the provisional banner until final activation.
- Require a clean local checkout and `git ls-files` inventory as the first Codex preflight.
- Make lifecycle/staged-state behavior, backup promise, test volumes and performance budgets explicit before implementation.
- Preserve the protected Python beta and both database boundaries as rollback evidence.
- Require automated transaction/migration tests before manual UI acceptance and distinguish debug-host evidence from production readiness.
- Do not introduce cloud, auth, signing/distribution, or broad analytics into Cycle 08.

## 13. Exact next staging route

```text
C08-R01 A_OPERATIONAL
↔ C08-R01 B_DIDACTIC and C_DESIGN
→ Main reads A/B/C and writes/enriches J_MAIN_STAGE
→ Main prepares provisional D/E/F carrying:
   Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
→ O/A/D renew A/B/C against J and provisional D/E/F
→ Main enriches J and D/E/F
→ explicit final human/Main activation
→ Codex materialization
→ G/H/I evidence
→ permanent-domain reconciliation and Main continuity
```

Until explicit activation, no D/E/F content is executable.
