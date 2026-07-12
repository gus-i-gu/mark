# E_DDC_STAGE — Cycle 06 Sprint 02 Final Desktop Validation

> Status: Main-approved Didactic materialization stage
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Inputs: `A_OPERATIONAL.md`, `B_DIDACTIC.md`, `C_DESIGN.md`
> Codex report target: `DEV_STAGE/H_DDC_CODEX.md`

## 1. Objective

Prepare only the Didactic evidence required to interpret Sprint 02 correctly.

No new canonical concept is authorized. The existing Cycle 06 concepts already cover the remaining boundaries:

```text
&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

All remain Red. No Green promotion is authorized.

## 2. Materialization Rule

Codex must not modify permanent Didactic files during Sprint 02 implementation.

It must report evidence only through:

```text
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
```

Permanent KANBAN, glossary, Concept Map, and Lecture Register updates belong to later Didactic reconciliation after G/H/I and Main review.

## 3. Required Evidence Distinctions

H must preserve these distinctions:

```text
installer configuration ≠ compiled installer artifact
frozen launch ≠ installed launch
installed launch ≠ installed workflow validation
external data placement ≠ observed preservation
no uninstall deletion rule ≠ validated retention
reinstall success ≠ upgrade compatibility
SmartScreen warning ≠ application malfunction
technical validation ≠ learner mastery
technical validation ≠ Main/human acceptance
```

A successful `ISCC.exe` command proves installer artifact generation only.

A Start Menu launch without Python or source checkout is required to support the installed-execution claim.

Observed retention requires data to exist before uninstall, remain afterward, and reopen after reinstall.

## 4. Concepts to Reinforce

### `&&&05` — Evidence State and Validation Boundary

Record the actual evidence progression:

```text
installer configured
→ installer compiled
→ application installed
→ installed workflows observed
→ lifecycle validated
→ Main/human acceptance
```

Mark each step only when matching evidence exists.

Classify SmartScreen and antivirus behavior as Windows reputation/security observations unless they produce a demonstrated runtime failure.

### `&&%04` — Source, Frozen, and Installed Execution Context

Record how installed execution differs from source and frozen-directory execution through:

- installer-created placement;
- Start Menu launch path;
- absence of Python/source checkout requirements;
- installed permissions and resource lookup;
- uninstall registration;
- external writable user state.

### `&%%06` — Packaging and Installation Artifact Lifecycle

Use the concrete Sprint 02 chain:

```text
installer/Markei.iss
    installer configuration

dist/installer/Markei-Setup-0.1.0-x64.exe
    compiled installer artifact

%LOCALAPPDATA%/Programs/Markei
    installed program files

%LOCALAPPDATA%/Markei
    retained writable user state
```

Do not treat an anticipated path as observed until evidence exists.

### `%%%06` — Build-Time, Runtime, and Installer-Time Dependency

Record `ISCC.exe` as an installer-time prerequisite. Its presence or absence does not determine whether the frozen application can run, and it must not become an installed runtime dependency.

### Existing resource and cleanup concepts

Where matching evidence exists, note reinforcement of:

```text
%%%05  Bundled Resource Versus Writable User Data
&&&04  Resource Ownership and Lifetime
&&%03  Context Manager and Deterministic Cleanup
%%%02  SQLite Connection and Cursor Ownership
&&&03  Naming as Data Contract
```

Installed close/reopen evidence must be kept separate from Sprint 01 source/frozen cleanup evidence.

## 5. Maturity Discipline

All four Cycle 06 concepts remain Red during Codex execution.

H may recommend later Didactic review but must not change maturity.

Software validation, successful installation, or human beta acceptance does not demonstrate learner mastery.

No new KANBAN identifier may be introduced unless Sprint 02 exposes a genuinely reusable distinction that cannot be expressed by existing canon. Such a discovery must be reported as a candidate only, not materialized.

## 6. Learner-Evidence Questions

H should record which questions the observed evidence can answer:

1. What exact state did each successful command prove?
2. How was installed launch distinguished from frozen launch?
3. Which installed files are replaceable, and which user-state files survive uninstall?
4. What direct evidence proved or failed to prove retention?
5. Why does the Start Menu launch route matter?
6. How were SmartScreen or antivirus observations classified?
7. Did installed close/reopen preserve the same cleanup boundary as frozen execution?
8. Why does installer compilation not prove workflows, reinstall, uninstall, or recovery?
9. Why is `ISCC.exe` installer-time rather than runtime?
10. Who retains authority to declare the beta accepted?

Do not claim the learner answered these questions unless explicit learner evidence exists.

## 7. H Report Contract

Replace `DEV_STAGE/H_DDC_CODEX.md` with a concise Sprint 02 evidence report containing:

1. the evidence states actually reached;
2. the four existing concepts reinforced;
3. exact project examples produced by installer compilation, installation, workflows, close/reopen, uninstall, and recovery;
4. distinctions that remain blocked or unproven;
5. SmartScreen/antivirus classification;
6. any newly exposed conceptual gap, as a candidate only;
7. confirmation that all four concepts remain Red;
8. confirmation that no concept became Green;
9. confirmation that permanent Didactic files were not modified;
10. recommended post-evidence Didactic updates for later reconciliation.

Do not repeat G’s command log. Reference Operational evidence compactly and focus on conceptual classification.