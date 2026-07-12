# J_[M]_STAGE — Cycle 06 Main Reconciliation

> Status: Active Main synthesis
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Branch: `sketch-notebook-recovery`
> Inputs: `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`, `DEV_STAGE/G_OPS_CODEX.md`, `DEV_STAGE/H_DDC_CODEX.md`, `DEV_STAGE/I_DSN_CODEX.md`
> Knowledge state: Reconciled staging; not permanent canon
> Milestone: Fully executable and installable Windows primary beta

---

## 1. Main Synthesis Summary

The three functional domains converged on one bounded Cycle 06 implementation path. Markei's current layered desktop architecture could be packaged without broad redesign. Main accepted one-folder packaging, schema-only production initialization, retained external user data, coordinated release identity, startup diagnostics, and validation-first shutdown treatment.

Codex materialized that bounded unit. Current-branch evidence now supports `configured`, `built`, and `launched` states for the frozen one-folder runtime. Static/source validation, schema-only first launch, resource exclusion, startup-log creation, and shutdown/immediate-reopen behavior were validated. Installer compilation remains blocked because `ISCC.exe` was unavailable. Therefore `installed`, full installed-lifecycle `validated`, and release `accepted` remain false.

The materialization preserved the application boundary:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

No broad service/repository decomposition, transaction redesign, schema redesign, migration framework, mobile, backend, authentication, synchronization, or cloud work was introduced.

## 2. Reconciled Materialization Facts

Accepted current facts after G/H/I review and direct source verification:

- `Markei.spec` is the authoritative one-folder PyInstaller definition;
- `scripts/build_windows.ps1` invokes the spec instead of independently defining package contents;
- production packaging includes `schema.sql` and excludes sample-bearing `seed.sql`;
- live SQLite data, WAL/SHM files, logs, tests, caches, and development residue are not production package content;
- `requirements-build.txt` records the successful build environment observed by Codex;
- root `main.py` owns the outer startup-exception boundary;
- startup failures are written under `%LOCALAPPDATA%/Markei/logs/startup.log`;
- `installer/Markei.iss` implements per-user installation, stable identity, Start Menu launch, optional desktop shortcut, and default preservation of `%LOCALAPPDATA%/Markei`;
- `scripts/build_installer.ps1` exists but could not compile because `ISCC.exe` was unavailable;
- focused shutdown validation initially failed because the isolated SQLite file remained open;
- the evidence-triggered `MainWindow.closeEvent()` correction now closes all four page-owned services idempotently;
- source/static checks, five standard-library release tests, frozen build, isolated launch, schema-only first launch, and frozen reopen passed;
- no installer artifact exists yet;
- principal installed workflows, upgrade, uninstall, retained-data recovery, and reinstall remain unvalidated;
- workflow atomicity remains inherited debt and was not changed.

## 3. Evidence-State Classification

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
installed: blocked
validated: partial — source/static/frozen/resource/startup/shutdown gates
accepted: no
blocked: installer compilation and installed lifecycle
```

A successful frozen build and launch do not satisfy the Cycle 06 milestone.

## 4. Codex Report Reconciliation

### 4.1 Operational report — G

`G_OPS_CODEX.md` is accepted as implementation evidence for the bounded D stage.

It establishes:

- exact changed and created files;
- successful `compileall`;
- successful five-test `unittest` suite;
- successful one-folder PyInstaller build;
- artifact inspection and executable hash;
- successful isolated frozen first launch and reopen;
- schema-only first-launch business state;
- shutdown failure discovery and bounded correction;
- installer compilation blocker;
- remaining human lifecycle debt.

`pytest` absence is a validation-environment limitation, not an application defect. The standard-library tests remain executable and passed.

### 4.2 Didactic report — H

`H_DDC_CODEX.md` is accepted as evidence input for Didactic classification, not as permanent Didactic promotion.

The four Red candidates remain eligible for functional-domain materialization:

```text
&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

No Green promotion is authorized.

### 4.3 Design report — I

`I_DSN_CODEX.md` is accepted as evidence input for Design absorption.

The following boundaries are materially demonstrated:

- packaging and installation remain deployment concerns;
- resources and writable user state remain separated;
- schema-only production initialization is implemented;
- uninstall retention is configured but not lifecycle-validated;
- startup diagnostics belong at the launcher boundary;
- bounded MainWindow shutdown coordination was required by evidence;
- installer and installed lifecycle acceptance remain blocked.

## 5. Primary Reconciliation Outcome

The first Cycle 06 materialization unit is technically successful but does not close the milestone.

Main classifies the state as:

```text
release configuration materialized
+ frozen runtime built and partially validated
+ installer source materialized
+ installed lifecycle blocked
```

Permanent-domain updates are now authorized only as evidence-appropriate reconciliation:

- Operational must record the successful source/frozen gates, the shutdown correction, the `ISCC.exe` blocker, and the exact remaining lifecycle validation route.
- Didactic must classify and, where justified, materialize the four Red concepts and derived terminology without Green promotion.
- Design must absorb the implemented package/resource/identity/startup/shutdown boundaries while explicitly preserving `installed: blocked` and `accepted: no`.

## 6. Remaining Cycle 06 Gates

Before beta acceptance:

```text
provide Inno Setup / ISCC.exe
→ compile installer
→ inspect installer artifact
→ install in an ordinary user environment
→ launch from Start Menu without Python/source checkout
→ exercise Register / Lists / History / Settings
→ close and immediate reopen
→ verify retained data
→ test compatible reinstall or upgrade
→ uninstall
→ verify accepted data preservation
→ reinstall and recover retained compatible data
→ record SmartScreen / antivirus observations
→ obtain human acceptance
```

Any failure in these gates must be staged as a bounded follow-up rather than hidden by status inflation.

## 7. Documentation-Update Authorization

Main authorizes separate [O], [A], and [D] functional reconciliation passes.

Each domain must:

- read its relevant Codex report plus G where needed;
- verify only the exact changed implementation files relevant to its domain;
- update permanent domain memory according to canonical / derived / checkpoint / observational roles;
- avoid copying Codex reports verbatim;
- preserve blocked and unvalidated states;
- commit its own domain updates separately;
- report compactly to Main.

Main does not yet authorize `00_PROJECT_STATE.md`, `05_SESSION_LOG.md`, or `06_SESSION_SCHEME.md` closure updates. Those follow after domain reconciliation and the remaining installer/lifecycle work.