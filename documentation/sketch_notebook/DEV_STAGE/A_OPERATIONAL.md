<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Cycle 09 Sprint 02 Operational investigation. This stage authorizes no implementation.

# C09-S02 Operational Investigation — Responsive Product UI

Sequence: FLX-INV-02  
Role: Operational Chat [O]  
Branch: `intermid-cycle-recovery`  
Starting boundary: `c67d573f1335ffd55c659a9ee795982ca72c2c32`  
Implementation evidence boundary: `e37cb700feeca4001cc7835b584c46bb81926af3`  
Writable surface: this file only  
Evidence: repository inspection plus archived current screenshots 6–10 / target mockups 1–5 observations; no commands, binaries, emulator, device, or screenshots were directly executed/opened in this chat.

## 1. Recovered baseline

Loaded the INDEX route and complete methodology, including FLX-SEQ-00, FLX-INV-02, PRC-01, FLX-PRM-04, write/evidence/recovery/commit rules and sequence-aware Operational protocol. Recovered 00_PROJECT_STATE, 06_SESSION_SCHEME, Operational checkpoint/record, post-Codex J, Cycle 09 G, and all accessible post-marker A/B/C/J/Design/Operational evidence.

The branch is descended from the supplied boundary and was six documentation commits ahead when inspected; comparison showed no post-boundary application change. Current application truth therefore remains implementation commit `e37cb70`. Remote publication uses the latest A blob SHA as a concurrency guard because no local checkout exists. Local worktree/toolchain state cannot be claimed.

Inherited G evidence at `e37cb70`: `flutter pub get`, Drift regeneration, format, 39 Flutter tests, analysis, diff check, five protected Python unittests, Windows release build and bounded launch passed. Android APK was host-blocked by absent Java/JAVA_HOME; pytest was unavailable. These are inherited results, not rerun Sprint 02 acceptance.

## 2. Current implementation truth and practical gaps

- `lib/app/markei_app.dart`: Home-first ten-destination `IndexedStack`; rail/bar switch at 720 px; one seed color, no Markei token/component system. Ten compact destinations create density risk.
- `purchase_page.dart`: long `ListView`; Store has no immediately following editable local occurrence controls; registration supplies current UTC. Person/Payment selectors remain optional but show labels rather than ID + nickname. BULK hides package count yet still requests line total; no unit-price input/derived total.
- `products_page.dart`: substring search; tap/long-press reveals inline details. No persistent selection contract, explicit selection action, keyboard activation model, or desktop double-click.
- `lists_page.dart` + `local_query_repository.dart`: projection starts from all Products and relates Purchase Items/Purchases. Cycle calculation requires sufficient distinct-date history. Relational code exists, but the read model/UI is too thin and “not enough history” can visually resemble absence. Runtime failure requires a seeded reproduction; do not diagnose missing joins without it.
- `settings_page.dart`: immutable reference UUIDs exist internally, but ordinary rows omit visible ID.
- Major pages scroll vertically, but paired rows, chips, navigation, inline details and long forms remain overflow/focus risks at narrow width and large text.
- History has the strongest loading/error/retry/empty separation. Lists lacks equivalent recovery; Catalogue/Purchase commonly collapse failures into generic feedback.
- Widget evidence covers wide registration and basic 390×844 shell/history states, not full phone Purchase, keyboard obstruction, rotation, Back, text scale, process lifecycle or file-backed continuity.
- `pubspec.yaml` has no visual/table/date/share/file-picker package. Flutter SDK already supplies Material 3, icons, date/time pickers, focus/shortcuts, tables and adaptive primitives.

Archived visual evidence describes current screenshots 6–10 as a sparse pale Material scaffold with weak hierarchy, unused space, plain rows/cards and overflow warnings. Target mockups 1–5 propose cream/white surfaces, dark-green primary language, lavender secondary surfaces, branded navigation, cards/tables, status chips, filters and adaptive desktop/mobile compositions. Because image binaries were unavailable here, exact pixels, colors, spacing and clipping are unvalidated.

## 3. Approach comparison

### A — Material 3 theme + shared in-repository widgets; no visual dependency

Paths: `lib/app/markei_app.dart`, new `lib/app/theme/`, `lib/app/widgets/`, page files, widget tests.  
Complexity: medium; incremental adoption. Compatibility: strongest Windows/Android parity; SDK behavior only. Database: none. Runtime/a11y risk: low–medium, mainly custom focus/layout mistakes. Fidelity: medium–high if page compositions also change; theming alone is insufficient. Testability: high with ordinary widget/semantics tests. Maintenance: low. Rollback: theme/widgets and each converted page independently.

### B — Dedicated Markei component layer with tokens, adaptive layouts, tables/cards and page compositions

Paths: Approach A plus `lib/app/design/` or equivalent tokens, adaptive shell, responsive form grid, state panels, identity picker, Product result/detail surfaces, projection table/card, selection toolbar; application read models/query adapters and page/widget tests.  
Complexity: high but bounded by horizontal foundation then vertical slices. Compatibility: high if SDK-first and platform-neutral. Database: none for visual layer; possible separate visible-reference-code migration only if Main selects generated codes. Runtime/a11y risk: medium—breakpoints, semantics, focus ownership and state preservation require explicit tests. Fidelity: highest. Testability: high when tokens/components and pages are isolated. Maintenance: medium, controlled in-repo. Rollback: foundation commit plus one page slice at a time.

### C — Selective maintained dependencies only where SDK facilities are insufficient

Candidate paths: `pubspec.yaml`, lockfile, platform manifests/registrants, adapters and dependency-focused tests. Tables/icons/date/time do not presently justify a package: SDK facilities are adequate. A dependency may be justified later for native share or OS save/file selection after an API/platform/license/maintenance audit.  
Complexity: low per package, medium integration/release cost. Compatibility: plugin-specific; Windows/Android support must be proven. Database: none. Runtime/a11y risk: plugin lifecycle, platform channel, permissions and semantics. Fidelity: potentially helpful for specialized controls, not a substitute for composition. Testability: lower around native channels; requires fakes plus device/manual tests. Maintenance: highest (updates, transitive graph, platform support). Rollback: isolated adapter and dependency commit; stop if generated host changes cannot be bounded.

## 4. Recommendation and bounded checkpoints

Adopt B implemented SDK-first as an extension of A. Do not add a visual package. Keep C dormant until a concrete native share/save requirement demonstrates an SDK gap.

1. UI foundation only: tokens, Material 3 theme, adaptive shell/navigation, shared loading/empty/error/state panels. No query/schema/domain change.
2. Purchase vertical slice: controlled local default date/time after Store; `dd/mm/yyyy` and `HH:mm`; local→UTC command boundary; Product select/details; BULK canonical-unit price calculator and read-only derived total. No schema change.
3. Catalogue slice: explicit selected state, ordinary click/tap, keyboard Select/Enter, explicit View details, intentional desktop double-click to details.
4. Lists query/read-model correction: preserve all Products; zero/one-history explicit states; bounded joined/batched observations; deterministic latest facts; no N+1/cache table.
5. History/Settings slice: action hierarchy and ID + nickname presentation. If Main selects generated visible codes, perform a separately reviewed schema/migration unit; never bury it in restyling.
6. Platform/accessibility acceptance: responsive, lifecycle, file-backed and release workflows after functional units pass.

Each checkpoint must leave the app runnable and independently revertible. Never combine token overhaul, schema evolution, projection query change and platform validation in one mutation.

## 5. Validation matrix and commands

| Gate | Evidence / command | Required cases |
| --- | --- | --- |
| Resolution | `flutter pub get`; `flutter pub deps` if graph changes | locked graph; no unexplained transitive/plugin changes |
| Format/static | `dart format --output=none --set-exit-if-changed lib test`; `flutter analyze`; `git diff --check` | clean output |
| Focused | `flutter test test/domain test/application test/app` or exact existing paths | occurrence, selection/details, BULK rounding, Lists state/query, optional references |
| Full Flutter | `flutter test` | all existing 39 plus Sprint 02 tests |
| DB/migration | file-backed create/close/reopen; representative v1→v2→v3 only if schema changes; failed migration/rollback fixture | facts preserved; no silent reset; collision and downgrade stop |
| Responsive | widget sizes 390×844, 600, 720 boundary, 1024+, constrained desktop; text scales 1.0/1.3/2.0 | no overflow; reachability; stable selection/draft |
| Input/a11y | keyboard-only traversal, Space/Enter, double-click shortcut, semantics, Back, keyboard open, resize/rotation | shortcut never sole action; focus/message retained |
| States | injected loading/empty/no-match/typed error/unknown/retry | distinct copy, recovery and retained safe state |
| Windows | `flutter build windows --release`; launch; complete Catalogue→Purchase→Lists→History→restart workflow | no crash/overflow; file-backed continuity |
| Android | `flutter build apk --debug`; install/launch on emulator/device; background/resume, rotate, Back, keyboard, process recreation | lifecycle and narrow workflow evidence |
| Python | `python -m unittest tests.test_release_configuration` plus protected suite named by G | no protected beta regression |
| Visual | deterministic screenshot fixtures at accepted sizes; small component goldens only | compare hierarchy/states; tolerate platform fonts/render variance |

Goldens are useful for tokens and stable shared components, but full-page goldens are brittle across Flutter versions, fonts, platforms, clocks and dynamic text. Keep semantic/widget assertions authoritative; record manual Windows/Android screenshots with viewport, scale, fixture and commit.

## 6. Operational risks, recovery and stop conditions

- Stop if screenshots 1–10 cannot be retained/inventoried before pixel-level acceptance is written.
- Stop if local-time/DST behavior, future-date rule or BULK rounding/override authority remains unresolved at its checkpoint.
- Stop Lists work if a two-observation fixture contradicts the assumed relational path; diagnose query/data/schema before UI changes.
- Stop visible-ID work until Main selects UUID display versus generated immutable code; generated codes require migration/backfill/collision/reopen proof.
- Stop dependency adoption on unsupported Windows/Android, abandoned maintenance, license conflict, excessive generated host changes or inaccessible controls.
- Stop platform acceptance when host prerequisites are absent; record host-blocked, never product-failed.
- Revert by checkpoint; preserve existing schema/database, drafts and registered Purchase facts. No clean/reset/force operation.
- Performance gate: seed at least 1k Products and 10k Purchase Items; assert bounded query count, responsive interaction and measured render/query time before setting a numeric acceptance threshold.

## 7. Decisions Main must resolve

1. Approve SDK-first Markei component layer and horizontal-foundation/vertical-slice order.
2. Freeze compact navigation (`Home / Lists / Purchase / History / More`) and candidate breakpoints.
3. Freeze exact tokens, contrast target, light-only boundary and screenshot acceptance sizes.
4. Accept current UTC instant with editable local display, including repeated-hour limitation, or authorize zone metadata.
5. Confirm Catalogue double-click opens details while selection remains explicit; define Purchase double-click action.
6. Confirm Lists compatible-observation rules, status thresholds and `All` retaining zero-history Products.
7. Select visible reference identity: internal UUID display or generated immutable codes and format.
8. Confirm BULK calculated total is authoritative/read-only, price precision/range and half-up rule.
9. Confirm native share is blocking; otherwise retain deterministic PDF save/export and defer plugin work.
10. Approve error catalogue as typed code registry unless persistence has an explicit rationale.

## 8. Handoff

Recommended next handoff: Main resolves decisions 1–10, then writes separate D/E/F units for foundation, each functional slice, optional schema migration, and platform validation. Codex remains inactive until those boundaries name writable paths, tests and rollback gates.
