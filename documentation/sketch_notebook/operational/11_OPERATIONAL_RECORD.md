# 11_OPERATIONAL_RECORD.md

> Version: Cycle 07 observational record 0.3
> Status: Active observational history
> Persistence Class: Observational
> Knowledge Class: Operational
> Branch: `cycle-07-mobile-preparation`
> Scope: Chronological Operational recovery, materialization, validation, correction, and reconciliation evidence
> Truth boundary: Present rules belong to `12_OPERATIONAL_MODEL.md`, active work to `04_TODO.md`, and current state to `10_OPERATIONAL_STATE.md`.

---

# 1. Reading Rule

This file records what occurred. It does not independently define present Operational truth. Later reconciled canon and checkpoints govern when older observations become stale.

# 2. Recovery and Repopulation — 2026-07-10

The Operational domain was recovered on `sketch-notebook-recovery` after methodology boot from `INDEX.md` and the required methodology sequence.

The initial execution spine recovered was:

```text
main.py
→ app.main.main()
→ MainWindow
→ desktop pages
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

The first structural A stage was committed as:

```text
ce14d2549311f90144f95f0a54eafcbeb24bc126
```

An initial canonical promotion used an incorrect Main reference and was later replaced. The correct reconciliation route was restored through:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

Canonical, derived, and checkpoint reconstruction commits included:

```text
572f7043d2d721e70e6638713054b64237984661  corrected Operational canon
792a6bf32efb658127161e1a628f42a0731879f8  Operational TODO derivative
74e18af3fbedbf7508c4e808568681d5539fed40  first Operational checkpoint
72b6f6f2a6ca8506d1a4435a3f7d9558fec8142d  checkpoint routing correction
```

A temporary extra A-stage filename was created and later corrected. The durable routing rule remains that Operational Chat refreshes only `DEV_STAGE/A_OPERATIONAL.md` unless Main explicitly changes the file map.

The recovery also preserved the distinction between historical artifact success and coherent methodology-cycle closure. Main-branch Cycle 05 packaging claims were treated as history, not current recovery-branch validation.

# 3. Cycle 06 Sprint 01 — First Windows Release-Enablement Unit

## 2026-07-12 — Materialization and reconciliation

Sprint 01 changed or created:

```text
Markei.spec
scripts/build_windows.ps1
main.py
app/desktop/main_window.py
app/startup_diagnostics.py
requirements-build.txt
installer/Markei.iss
scripts/build_installer.ps1
tests/test_release_configuration.py
```

It established:

- `Markei.spec` as authoritative one-folder packaging source;
- schema-only production packaging;
- exclusion of seed, live database, WAL/SHM, logs, tests, and caches;
- per-user installer source and compile wrapper;
- startup diagnostics;
- focused release tests;
- bounded MainWindow shutdown coordination.

Observed toolchain:

```text
Python 3.14.6
PySide6 6.11.1
PyInstaller 6.21.0
```

Observed commands:

```text
python -m compileall app main.py       passed
python -m pytest                       blocked: pytest unavailable
python -m unittest discover -s tests  passed: 5 tests
scripts/build_windows.ps1             passed
scripts/build_installer.ps1           blocked: ISCC.exe unavailable
```

Frozen artifact evidence:

```text
dist\Markei\Markei.exe
SHA256 E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B
```

Focused shutdown validation initially failed because the isolated SQLite file remained open after `MainWindow.close()`. A bounded `MainWindow.closeEvent()` coordinator then closed all four page-owned services idempotently. Rerun evidence showed all repositories closed, the isolated database directory became removable, and immediate frozen reopen succeeded.

Sprint 01 ended with:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

Permanent Operational reconciliation was committed at:

```text
193a96e2202a649feb86d4259b626a8e553ad0cb
```

# 4. Cycle 06 Sprint 02 — Installer and Installed Lifecycle

## 2026-07-12 — Toolchain prerequisite resolved

Initial failure:

```text
scripts/build_installer.ps1
→ ISCC.exe not found
```

Inno Setup was installed through `winget`:

```text
JRSoftware.InnoSetup 6.7.3
```

Observed per-user compiler path:

```text
C:\Users\gusrm\AppData\Local\Programs\Inno Setup 6\ISCC.exe
```

Bounded correction:

```text
scripts/build_installer.ps1
→ add %LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe discovery
```

Rerun result:

```text
scripts/build_installer.ps1  passed
```

Inno Setup emitted a non-blocking warning that `x64` is deprecated and `x64compatible` is preferred.

## Structural production-default failure and correction

The fresh installed Register-equivalent workflow initially failed with:

```text
sqlite3.IntegrityError: FOREIGN KEY constraint failed
```

The schema-only production database lacked the category and store identifiers required by current Register defaults.

Bounded correction:

```text
category F / General
store 1 / Default Store
```

These rows were added idempotently through database compatibility handling. They are structural application defaults, not sample business data. Tests continue to require zero sample products and zero sample purchases.

After correction:

```text
python -m compileall app main.py       passed
python -m unittest discover -s tests  passed: 5 tests
scripts/build_windows.ps1             passed
scripts/build_installer.ps1           passed
```

## Sprint 02 artifact evidence

Frozen executable:

```text
dist\Markei\Markei.exe
SHA256 E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
size 2,173,220 bytes
```

Installer:

```text
dist\installer\Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

Distribution inspection confirmed `schema.sql` and excluded `seed.sql`, live database, WAL/SHM, and startup logs.

## Automated installed lifecycle evidence

Environment:

- current ordinary Windows user;
- existing `%LOCALAPPDATA%\Markei` backed up before lifecycle testing;
- original user state restored afterward;
- no dedicated clean account used.

Validated transitions:

```text
silent per-user install
→ installed executable under %LOCALAPPDATA%\Programs\Markei
→ Start Menu shortcut launch
→ external database creation
→ Register-equivalent ProductService persistence
→ Lists / History / Settings projection evidence
→ normal close
→ immediate reopen
→ same-version reinstall with retained data
→ uninstall with database retained
→ reinstall and retained-data recovery
```

Technical dataset evidence:

```text
category count  1
store count     1
product count   1
purchase count  1
product         T006 / Cycle 06 Test Product
quantity        2 unit
latest price    3.5
status          in-house
week boundary   wednesday
```

Installed close/reopen succeeded repeatedly, with `CloseMainWindow()` returning true and data remaining present.

## SmartScreen and antivirus boundary

Observed:

```text
Microsoft Defender enabled
real-time protection enabled
installer Authenticode: NotSigned
executable Authenticode: NotSigned
```

No SmartScreen prompt was observed during silent/programmatic execution. Human-visible SmartScreen behavior remains unknown.

## Evidence classification after Main reconciliation

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Human-visible installer wizard behavior, full visible Register/Lists/History/Settings walkthrough, visible close/reopen confirmation, SmartScreen interaction, and final human/Main acceptance remain pending.

# 5. Generated Installer Repository Contradiction

`G_OPS_CODEX.md` states that the installer was generated but not committed. Current branch evidence shows:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
blob SHA a586406f660e78a58ddf13cc09a061ddb7385269
```

The binary therefore exists in repository history. Operational classification:

```text
report statement: incorrect
repository state: generated installer binary committed
policy: generated release binaries should not remain ordinary source-controlled files
```

This documentation update does not remove the artifact. A separate authorized cleanup should remove it, add ignore coverage, and retain the binary through an approved release/artifact channel with its recorded hash and size.

# 6. Current Record Boundary

Sprint 02 technically completed the compiled-installer and automated installed-lifecycle route. Cycle 06 remains open because acceptance is a separate human/Main gate.

Retained debt:

- workflow atomicity across multi-commit user actions;
- Inno Setup `x64` deprecation warning;
- optional dedicated-account rerun if current-user evidence is later judged ambiguous;
- broader migration/reset failure validation;
- generated-artifact repository cleanup.

Future entries should record human-visible acceptance evidence, artifact cleanup, any bounded correction triggered by manual walkthrough, and final Cycle 06 closure.

# 7. Cycle 07 Sprint 01 — Mobile Portability Investigation and Reconciliation

## 2026-07-12 — Investigation boundary

Cycle 07 began on `cycle-07-mobile-preparation` from the accepted Cycle 06 closure baseline. Sprint 01 was investigation-only. No application code, framework project, toolchain, database, or ordinary desktop user data was modified or opened.

The investigation observed:

```text
reusable behavior exists
≠
the current desktop application is mobile-portable
```

Likely reusable surfaces were Python domain models, validation and calculation rules, workflow meanings, schema semantics, structural defaults, and deterministic desktop behavior as a fixture source. Coupled surfaces included concrete service/repository construction, SQLite lifecycle and global paths, presentation-shaped service projections, incomplete abstract contracts, and separately committed workflow mutations.

No Android/iOS runtime, package, lifecycle persistence, semantic-parity suite, accessibility behavior, or distribution path was demonstrated.

## Preserved pathway 1 — Operational challenger

Operational recorded a time-boxed Python-native Android experiment as the cheapest direct falsification test for existing Python reuse.

The apparent economy is direct: reuse the Python models, calculations, services, repository behavior, and possibly SQLite schema inside one Android package; initialize a fresh app-private store; execute one receipt workflow; close and reopen; verify persistence.

This pathway becomes expensive if the supposedly narrow experiment expands into broad construction refactoring, custom binary recipes, repeated SDK/NDK/JDK/WSL troubleshooting, native bridges, framework-specific lifecycle corrections, accessibility/platform-integration workarounds, or a separate iOS adaptation. Debugging may cross Python, framework runtime, packaging recipes, Gradle/Android tooling, and device behavior. An Android success would not prove iOS feasibility, maintainability, or distribution readiness.

Observed classification:

```text
cheapest direct experiment
bounded challenger
not final architecture evidence
not authorized
```

## Preserved pathway 2 — Design strategic direction

Design recorded a native/cross-platform client with explicit, language-neutral contracts and deterministic fixtures as the stronger current direction for maintained Android/iOS development.

Its cost begins earlier and is more visible: learn and configure another language/framework; establish Android and iOS SDK boundaries; reimplement relevant behavior and persistence; construct shared fixtures; and verify semantic parity with accepted desktop behavior.

That cost may reduce later expense when the mobile client has conventional ownership of navigation, accessibility, lifecycle, local persistence, packaging, and platform integration; contracts keep business facts separate from presentation labels; fixtures expose drift; and Android/iOS maintenance follows supported framework paths rather than a layered embedded-Python packaging boundary.

Android and iOS still have different operational environments. Android development may use Windows-supported tooling, while iOS build, signing, simulator/device, and distribution validation require macOS/Xcode. Cross-platform source does not remove separate platform gates.

Observed classification:

```text
stronger strategic candidate
higher initial setup and behavior-porting cost
potentially lower maintained-product cost
not empirically proven
framework not selected
not authorized
```

## Human/Main planning preference

Human/Main direction currently favors the Design pathway. This is recorded as a planning preference, not as empirical proof, framework acceptance, or implementation authorization.

The two pathways answer different questions:

```text
Operational:
What is the cheapest bounded experiment that can falsify direct Python reuse?

Design:
What architecture is strongest if mobile becomes a maintained Android/iOS product?
```

They remain preserved rather than collapsed into a false consensus.

## Unresolved cost assumptions

The following remain assumptions until measured:

- how much current Python behavior can execute unchanged in a mobile package;
- whether required construction and path seams remain narrow;
- how much business behavior a strategic client must reimplement;
- the cost of producing language-neutral contracts and golden fixtures;
- mobile SQLite/library maturity and migration ownership;
- suspend/resume and terminate/relaunch failure behavior;
- debugging cost across runtime and native-toolchain boundaries;
- accessible UI and platform-integration effort;
- Android-versus-iOS build and device differences;
- dependency upgrade and packaging maintenance over time.

A cheap prototype becomes expensive when success requires continuing exceptions, custom packaging, duplicated lifecycle work, or an architecture that cannot satisfy maintained-product requirements. A costly initial architecture reduces later cost only when its contracts, fixtures, persistence ownership, tests, and supported platform tooling actually prevent drift and repeated rework.

## Reconciliation result

```text
Cycle 06: accepted and closed
Cycle 07 Sprint 01: complete
strategic planning preference: Design pathway
bounded challenger: Operational Python-native Android experiment
backend: deferred
implementation authorization: none
D/E/F: postponed
next work: documentation, contract/fixture specification, and explicit later experiment gates
```

No stable Operational rule was promoted into `12_OPERATIONAL_MODEL.md` during this pass. The pathway comparison and cost assumptions remain observational; current state and active evidence gaps were refreshed separately.
