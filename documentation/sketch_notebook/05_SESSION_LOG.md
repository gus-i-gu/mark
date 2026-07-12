# 05_SESSION_LOG.md

> Version: Global history 0.3
> Status: Active Global Observational History
> Persistence Class: Observational
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Current-state source: `00_PROJECT_STATE.md`
> Domain-history sources: `operational/11_OPERATIONAL_RECORD.md`, `didactics/13_LECTURE_REGISTER.md`, and `design/03_DECISION_LOG.md`
> Scope: Main-level chronology, reconciliation events, corrections, and cycle continuity

---

# 1. Reading Rule

This file records what happened. It does not independently define present truth or future implementation authority.

```text
current global state       00_PROJECT_STATE.md
current domain state       domain checkpoints
future cycle boundary      06_SESSION_SCHEME.md
session chronology         05_SESSION_LOG.md
```

When history conflicts with current authority, preserve the historical observation and follow current authority.

---

# 2. Session 001 — Recovery Reconstruction

```text
Date: 2026-07-10
Repository: gus-i-gu/markei
Branch: sketch-notebook-recovery
Class: global recovery and permanent-memory reconstruction
```

The Sketch Notebook methodology was loaded from `documentation/sketch_notebook/INDEX.md`. Main recovered the current application from branch-qualified repository evidence and rebuilt domain symmetry across Operational, Didactic, and Design memory.

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

Important recovery outcomes:

- exact branch/ref discipline was established;
- the human-designated `J_[M]_STAGE.md` route was retained;
- repository evidence remained distinct from canon;
- semantic promotion remained distinct from physical materialization;
- the previous Cycle 05 was classified as a useful partial artifact outcome but an incoherent methodology closure;
- fractioned inspection and compact staging became mandatory protections against token burst.

---

# 3. Session 002 — Cycle 06 Sprint 01 Release Enablement

```text
Date: 2026-07-11 to 2026-07-12
Class: Windows primary-beta release enablement
Outcome: frozen runtime built and partially validated; installer lifecycle blocked
```

Cycle 06 activated one milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Main reconciled A/B/C and accepted:

```text
schema.sql included
seed.sql excluded from production
external %LOCALAPPDATA% user data preserved
Markei / Markei.exe / 0.1.0 identity
Markei.spec as packaging authority
one-folder windowed package
Start Menu required; desktop shortcut optional
validate shutdown before changing it
```

Codex materialized packaging, installer source, build wrappers, startup diagnostics, tests, and version metadata.

Focused shutdown validation initially failed because SQLite remained open after `MainWindow.close()`. A bounded `MainWindow.closeEvent()` coordinator closed all four page-owned services. Rerun evidence passed.

Sprint 01 ended at:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

The blocker was unavailable `ISCC.exe`.

---

# 4. Session 003 — Cycle 06 Sprint 02 Installed Lifecycle

```text
Date: 2026-07-12
Class: installer compilation and installed-lifecycle completion
Outcome: controlled Windows beta technically validated and accepted
```

## 4.1 Functional and materialization route

Operational, Didactic, and Design produced compact Sprint 02 A/B/C deltas. They agreed that no new architecture or policy decision was required. D/E/F authorized one validation-centered Codex unit:

```text
provide Inno Setup
→ compile installer
→ install per user
→ launch from Start Menu
→ exercise technical workflows
→ close/reopen
→ reinstall
→ uninstall with retained data
→ reinstall and recover
→ correct only directly failed gates
```

Codex loaded `AGENTS.md`, `INDEX.md`, the full methodology route, current state, J, and D/E/F before execution.

## 4.2 Installer compiler correction

Initial installer compilation again failed because `ISCC.exe` was not found. Inno Setup 6.7.3 was installed per user through `winget` at:

```text
%LOCALAPPDATA%/Programs/Inno Setup 6/ISCC.exe
```

`scripts/build_installer.ps1` was extended to discover that supported per-user path. Compilation then passed.

## 4.3 Structural-default correction

Fresh production Register execution failed with a foreign-key error because schema-only initialization lacked the category and store expected by current Register defaults.

Codex added only idempotent structural defaults:

```text
category F / General
store 1 / Default Store
```

`seed.sql` remained excluded, and fresh production data still contained zero sample products and purchases.

## 4.4 Artifact and lifecycle evidence

Installer artifact:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

Frozen executable hash:

```text
E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
```

Validated technical lifecycle:

```text
per-user install
→ Start Menu launch
→ external database initialization
→ Register-equivalent persistence
→ Lists / History / Settings projections
→ installed close and immediate reopen
→ same-version reinstall with retained data
→ uninstall with retained data
→ reinstall and retained-data recovery
```

Validation used the current ordinary Windows user with existing Markei data backed up and restored. It did not establish dedicated-account isolation.

## 4.5 Evidence limits

Automated/service-backed workflow evidence was not a complete human visual walkthrough. Defender was enabled and the binaries were unsigned. No SmartScreen prompt was observed during silent/programmatic execution, so human-visible SmartScreen behavior remained unknown.

The installer binary appeared in the repository despite G describing it as generated but uncommitted. Operational classified generated release binaries as better suited to an approved release/artifact channel; cleanup remains separate release-hygiene work.

## 4.6 Domain absorption

Operational, Didactic, and Design updated permanent memory.

They converged on:

```text
configured: validated
built: validated
launched: validated — frozen and installed
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: pending Main/human direction
```

Didactic maturity did not change automatically. No concept became Green.

## 4.7 Main acceptance and closure

The human instructed Main to generate the final Cycle 06 commits and prepare Cycle 07. Main interpreted that direction as acceptance of the controlled beta, not as production/public maturity.

Final Cycle 06 classification:

```text
successful bounded desktop release cycle
+
compiled wizard installer
+
validated per-user installed lifecycle
+
accepted controlled Windows primary beta
```

Residual SmartScreen, signing, artifact-channel, cross-version upgrade, atomicity, and migration concerns remain recorded as non-blocking debt.

---

# 5. Cycle 07 Handoff

Cycle 07 begins as a mobile-development preparation and architecture-discovery cycle in an isolated cloned repository/worktree context.

It must preserve the accepted desktop baseline and avoid immediate platform rewrites.

Primary handoff:

```text
clone and isolate
→ load methodology
→ inventory reusable core
→ identify desktop-only coupling
→ compare mobile approaches
→ define local/offline and synchronization assumptions
→ prototype one minimal vertical slice
→ reconcile before choosing the mobile architecture
```

The authoritative Cycle 07 preparation boundary is `06_SESSION_SCHEME.md`.
