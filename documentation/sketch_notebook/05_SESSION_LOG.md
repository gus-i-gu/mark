# 05_SESSION_LOG.md

> Version: Global history 0.2
> Status: Active Global Observational History
> Persistence Class: Observational
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Current-state source: `00_PROJECT_STATE.md`
> Domain-history sources: `operational/11_OPERATIONAL_RECORD.md`, `didactics/13_LECTURE_REGISTER.md`, and `design/03_DECISION_LOG.md`
> Scope: Main-level chronology, reconciliation events, corrections, and session continuity

---

# 1. Reading Rule

This file records what happened across Main coordination sessions. It does not independently define present application truth, architecture, operational rules, learning status, or future implementation authority.

Authority order:

```text
current global state       00_PROJECT_STATE.md
current Operational state  operational/10_OPERATIONAL_STATE.md
current Didactic state     didactics/08_CONCEPT_MAP.md
current Design state       design/09_DESIGN_STATE.md
future session boundary    06_SESSION_SCHEME.md
session chronology         05_SESSION_LOG.md
```

When an older observation conflicts with current authority, preserve the observation as history and follow current authority.

---

# 2. Session 001 — Recovery Reconstruction

```text
Date: 2026-07-10
Repository: gus-i-gu/markei
Branch: sketch-notebook-recovery
Class: global recovery and permanent-memory reconstruction
```

The numbered and lettered notebook surfaces had been intentionally emptied while the application source remained available. Main loaded the methodology from `documentation/sketch_notebook/INDEX.md`, followed the prescribed boot sequence, and recovered the application through branch-qualified repository inspection.

Recovered application spine:

```text
main.py
→ app.main.main()
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

The recovery established:

- public desktop surfaces and Lists modes;
- the domain and persistence model;
- `%LOCALAPPDATA%/Markei/market.sqlite` as writable user state;
- schema and optional seed resources;
- four page-owned service/repository/connection chains;
- local cleanup capability without one authoritative shutdown owner;
- multi-commit receipt and deletion workflows;
- current architecture and unresolved design questions.

Operational, Didactic, and Design chats produced A/B/C stages. Main reconciled them through:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

All three permanent domains were repopulated with canonical, derived, checkpoint, and observational surfaces. `00_PROJECT_STATE.md` was rebuilt as the global recovery entrypoint.

Important methodology corrections recorded during recovery:

- direct exact-ref GitHub access was required when branch search was unreliable;
- every repository read and write was pinned to `sketch-notebook-recovery`;
- the human-designated Main surface `J_[M]_STAGE.md` prevailed over stale naming references;
- repository implementation remained evidence rather than automatic canon;
- semantic promotion remained separate from physical materialization.

The previous Cycle 05 was classified as a useful partial artifact outcome but an incoherent methodology-cycle closure. Its durable lessons were one explicit milestone, fractioned inspection and staging, preservation of inherited debt, and reconciliation before shared-surface replacement.

---

# 3. Session 002 — Cycle 06 Sprint 01 Release Enablement

```text
Date: 2026-07-11 to 2026-07-12
Repository: gus-i-gu/markei
Branch: sketch-notebook-recovery
Class: Windows primary-beta release enablement
Milestone: fully executable and installable Windows primary beta
Sprint outcome: frozen runtime built and partially validated; installed lifecycle blocked
```

## 3.1 Cycle activation

`06_SESSION_SCHEME.md` established one active Cycle 06 milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

The milestone explicitly rejected source execution, a PyInstaller command, a build-directory executable, or an unexercised installer as sufficient completion.

## 3.2 Functional staging and token correction

Operational, Didactic, and Design chats loaded methodology and recovered their domain state before receiving functional prompts.

Initial functional prompts risked repeating the Cycle 05 token-burst pattern. Main introduced a compression amendment:

```text
compact Main synthesis summary
+ essential evidence index
+ blocking decisions
+ bounded handoff
```

The resulting stages were:

```text
DEV_STAGE/A_OPERATIONAL.md
DEV_STAGE/B_DIDACTIC.md
DEV_STAGE/C_DESIGN.md
```

Main reconciled the stages and resolved one direct contradiction: `Markei.spec` existed on the recovery branch despite one Design report failing to locate it.

## 3.3 Accepted Sprint 01 decisions

Main accepted:

```text
production seed      schema.sql included; sample-bearing seed.sql excluded
uninstall retention  preserve %LOCALAPPDATA%/Markei by default
identity             Markei / Markei.exe / 0.1.0 / publisher Markei / stable AppId
packaging authority  Markei.spec
build wrapper         scripts/build_windows.ps1 invokes the spec
packaging topology    one-folder, windowed, UPX disabled
shortcuts             Start Menu required; desktop shortcut optional
shutdown policy       validate first; patch only demonstrated failure
```

D/E/F staged one bounded materialization unit. Codex was instructed to load `AGENTS.md`, then `documentation/sketch_notebook/INDEX.md` and the complete methodology route before reading J and D/E/F.

## 3.4 Codex materialization

Codex modified or added:

```text
Markei.spec
scripts/build_windows.ps1
requirements-build.txt
installer/Markei.iss
scripts/build_installer.ps1
main.py
app/startup_diagnostics.py
app/desktop/main_window.py
tests/test_release_configuration.py
```

Codex reported through:

```text
DEV_STAGE/G_OPS_CODEX.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/I_DSN_CODEX.md
```

Materialized release boundary:

- authoritative one-folder PyInstaller spec;
- schema-only production packaging;
- exclusion of live database, WAL/SHM, logs, tests, and seed fixtures;
- coordinated Windows identity metadata;
- per-user Inno Setup source;
- Start Menu shortcut and optional desktop shortcut;
- preserved external user data by default;
- writable startup diagnostics;
- focused release-configuration tests.

## 3.5 Validation and evidence-triggered correction

Successful evidence included:

```text
python -m compileall app main.py       passed
python -m unittest discover -s tests  passed, 5 tests
scripts/build_windows.ps1             passed
frozen isolated launch                passed
frozen immediate reopen               passed
schema-only first launch              passed
resource exclusion inspection         passed
startup-log creation                  passed
```

`pytest` was unavailable in the active environment, so the standard-library test suite became the executed evidence surface.

Initial focused shutdown validation failed because the isolated SQLite database remained held open after `MainWindow.close()`. Codex then added a bounded `MainWindow.closeEvent()` coordinator that idempotently closed all four page-owned services. Rerun evidence showed all repositories closed and the isolated database directory became removable.

This correction remained within the accepted desktop composition boundary and did not introduce a composition-root redesign.

## 3.6 Installer blocker

The installer compile wrapper could not locate `ISCC.exe`.

Therefore:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

No installer artifact was produced. Clean installation, Start Menu launch, installed workflows, compatible reinstall or upgrade, uninstall retention, reinstall recovery, Windows reputation observations, and human acceptance remained open.

## 3.7 Post-Codex reconciliation and domain absorption

Main reviewed G/H/I and the critical implementation files. The reports matched the implementation at the release, diagnostic, retention, and shutdown boundaries.

Main then issued separate permanent-memory reconciliation prompts to Operational, Didactic, and Design chats.

The domains absorbed Sprint 01 evidence:

### Operational

Recorded the built and partially validated frozen runtime, configured installer source, blocked installer compile, shutdown correction, artifact hash, and remaining installed-lifecycle gates.

### Didactic

Added four canonical Red concepts:

```text
&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

No concept became Green.

### Design

Absorbed the deployment-layer boundary, schema-only production policy, retained external data, coordinated release identity, launcher-owned startup diagnostics, installer boundary, and MainWindow-owned final shutdown coordination.

The domains converge on the same evidence classification and remaining blocker set.

---

# 4. Current Continuity Event — Cycle 06 Sprint 02 Preparation

Main refreshed:

```text
00_PROJECT_STATE.md
05_SESSION_LOG.md
06_SESSION_SCHEME.md
[M]_STAGE/J_[M]_STAGE.md
```

Sprint 02 continues the same Cycle 06 milestone. It is not a new feature milestone.

Its bounded purpose is:

```text
provide Inno Setup / ISCC.exe
→ compile and inspect the installer
→ clean per-user install
→ Start Menu launch
→ installed principal workflow validation
→ close and immediate reopen
→ persistence verification
→ compatible reinstall or upgrade
→ uninstall retention verification
→ reinstall recovery
→ SmartScreen / antivirus observation
→ human acceptance
```

Only narrowly evidenced corrections required to pass these gates are authorized. Mobile, backend, synchronization, authentication, cloud work, broad architecture changes, unrelated UI work, and opportunistic refactoring remain outside Cycle 06.

---

# 5. Current Historical Classification

Cycle 06 Sprint 01 is classified as:

```text
successful bounded materialization
+
partial release validation
+
blocked installed lifecycle
```

The next historical entry must record Sprint 02 execution evidence, any bounded corrections, installer artifact identity, installed lifecycle results, and Main/human acceptance or remaining blockers.