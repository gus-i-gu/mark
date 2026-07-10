# Cycle 05 Operational Retrospective

> Status: Temporary recovery-stage evidence
> Role: Operational Chat [O]
> Branch inspected: `main`
> Target branch: `sketch-notebook-recovery`
> Scope: Commit retrospective from Cycle 04 closure through Cycle 05 Sprint 01 reconciliation
> Persistence class: DEV_STAGE / ephemeral
> Canonical comparator: `operational/12_OPERATIONAL_MODEL.md`
> Checkpoint target: `operational/10_OPERATIONAL_STATE.md`

---

# 1. Purpose

This temporary report reconstructs the failed precedent Cycle 05 as an execution and notebook-process event.

It does not redefine operational canon. It supplies historical and current-state evidence needed to rebuild the Operational checkpoint.

The retrospective distinguishes:

```text
implementation outcome
from
cycle/process outcome
```

A generated runtime may succeed while the development cycle that produced and documented it still fails to close coherently.

---

# 2. Bounded Commit Window

The reviewed main-branch sequence is:

```text
Cycle 04 reconciliation and closure
→ post-Cycle 04 recovery scheme
→ Cycle 05 mobile-preparation staging
→ Cycle 05 planning session
→ `cycle 5.0 outburst mode`
→ Sprint 01 operational checkpoint/TODO reconciliation
→ Sprint 01 operational evidence absorption
→ desktop packaging operational model
```

Primary commits:

```text
c84e8506  Close Cycle 04 global project state
777a30b3  Record Cycle 04 session closure
bd4b4cd9  Prepare post-Cycle 04 recovery scheme
e9cf0f08  Stage Cycle 05 mobile preparation synthesis
a4f77326  Prepare Cycle 05 mobile development planning session
c51938b7  cycle 5.0 outburst mode
11a931f6  Reconcile Cycle 05 Sprint 01 operational checkpoint
bc4d3a5c  Reconcile Cycle 05 Sprint 01 operational TODO
d4a14485  Append Cycle 05 Sprint 01 operational evidence
fbeef65c  Add desktop packaging operational model
```

The full repository history was not replayed. The bounded window is sufficient because it captures the accepted Cycle 04 baseline, the intended Cycle 05 direction, the divergence event, and the subsequent operational promotion chain.

---

# 3. Precedent Cycle Intent

Cycle 05 was initially prepared as a planning and architecture-ordering cycle for mobile development.

Its stated prerequisites included:

- close remaining Cycle 04 verification risks;
- define mobile product scope;
- audit platform coupling;
- establish typed contracts and dependency boundaries;
- decide persistence, synchronization, backend, identity, and migration models;
- build an automated validation foundation;
- avoid broad mobile coding until those decisions were reconciled.

The intended cycle was therefore a controlled preparation cycle, not an authorization for either broad mobile implementation or unrelated release work.

---

# 4. Divergence Event

Commit `c51938b7` introduced an oversized "outburst mode" materialization.

Operationally relevant characteristics:

- the active direction changed from mobile preparation to a split Cycle 05 where Sprint 01 became Windows packaging and installation;
- large cross-domain reports were expanded in one commit;
- staged material mixed recovered baseline, didactic classification, design reasoning, packaging analysis, and implementation planning;
- the change exceeded the economical, role-specific staging pattern intended by the methodology;
- the cycle direction was superseded during execution rather than cleanly reconciled before materialization.

This commit is not classified here as wholly invalid. It contained useful packaging analysis and helped expose release boundaries. The failure concerns cycle coherence, scope control, and memory routing.

---

# 5. Materialized Implementation Outcome

The post-outburst Sprint 01 reconciliation recorded the following implementation state on main:

## Implemented and reported validated

- PyInstaller one-folder runtime;
- frozen executable build and launch;
- working-directory-independent schema discovery;
- external writable database under `%LOCALAPPDATA%\Markei`;
- schema-only, seed-free production initialization;
- empty first-launch business tables with six default settings;
- first receipt registration without a seeded store;
- startup failure logging;
- pinned PySide6 and PyInstaller dependencies;
- construction of Register, Lists, History, and Settings in the frozen runtime;
- exclusion of seed, live database, WAL/SHM files, and sample records from the production runtime.

## Configured but not validated

- Inno Setup per-user installer;
- installation placement;
- Start Menu shortcut;
- uninstall registration;
- upgrade identity and replacement behavior;
- preservation of external user data through installed upgrade, uninstall, and reinstall.

## Blocked

- installer compilation;
- installed lifecycle validation;
- blocker recorded as unavailable `ISCC.exe`.

## Deferred

- SmartScreen and antivirus behavior;
- production signing;
- rollback;
- automatic update;
- Sprint 02 mobile preparation;
- backend, API, account, and synchronization work.

---

# 6. Evidence and Memory Drift

The operational evidence absorption commit recorded a critical mismatch:

```text
G_OPS_CODEX.md
H_DDC_CODEX.md
I_DSN_CODEX.md
```

still described Cycle 04 while Cycle 05 Sprint 01 evidence was being promoted.

The main-branch operational record therefore relied on human-provided accepted evidence while explicitly retaining the stale-report mismatch as drift.

Operational consequences:

1. the promoted runtime claims may be credible, but the ordinary materialization-report chain was incomplete;
2. notebook state and Codex reports were not synchronized at promotion time;
3. subsequent checkpoint/TODO/model files encoded a recovered interpretation rather than a clean report-driven closure;
4. the cycle could not provide a fully traceable execution chain from approved stage to matching Codex report to permanent memory.

---

# 7. Why the Precedent Cycle Is Classified as Failed

The failed-cycle classification is process-oriented.

```text
Artifact result:
    partial success

Cycle closure:
    failed / incoherent
```

The frozen one-folder runtime appears to have been successfully built and exercised. However, the cycle failed to achieve coherent methodological closure because:

- the objective changed materially after Cycle 05 had been staged for mobile preparation;
- oversized cross-domain materialization weakened role and stage boundaries;
- Codex evidence files were stale relative to the promoted Sprint 01 claims;
- the installer—the user-facing completion target—was not compiled or lifecycle-tested;
- permanent operational memory was reconciled after the fact from mixed evidence;
- unresolved Cycle 04 human UI checks remained open;
- Sprint 02 mobile preparation was deferred, leaving the original Cycle 05 objective unfulfilled.

The cycle must therefore not be summarized as either a total implementation failure or a completed release cycle.

Accepted retrospective statement:

```text
Cycle 05 produced a validated frozen desktop runtime and useful packaging knowledge,
but failed as a coherent end-to-end cycle because direction, staging, evidence,
and installed-release closure did not remain synchronized.
```

---

# 8. Conflict Against Current Operational Canon

The reconstructed canon and main retrospective agree on:

- Desktop → ProductService → Repository → Database Manager → SQLite;
- external user-local database ownership;
- bundled-resource versus writable-data separation;
- need to distinguish configured, built, launched, installed, and lifecycle-validated states;
- installer configuration not proving installed behavior;
- external data placement not proving upgrade/uninstall/reinstall preservation;
- manual interactive UI validation remaining distinct from offscreen or frozen construction;
- release acceptance requiring evidence beyond successful packaging.

The retrospective does not override current canon where main-branch Cycle 05 changed source behavior that is not present or not yet verified on `sketch-notebook-recovery`.

Checkpoint use:

- retain main-branch Cycle 05 as historical continuity and failed-cycle evidence;
- describe recovery-branch implementation using current canon and repository inspection;
- do not claim the recovery branch currently contains or has validated the same packaging artifacts unless directly confirmed;
- carry installer and lifecycle claims as precedent-cycle evidence, not current recovery validation.

---

# 9. Checkpoint Implications

The rebuilt checkpoint should state:

1. current recovery branch has reconstructed canon and derivative memory;
2. contemporary application structure is known from direct inspection;
3. the precedent Cycle 05 failed methodologically despite a reported successful frozen runtime;
4. main-branch packaging evidence remains historical context, not automatically current-branch validation;
5. current highest operational risks are deterministic shutdown, non-atomic workflows, seed policy, migration validation, and release-resource/lifecycle verification;
6. checkpoint recovery should continue from `10_OPERATIONAL_STATE.md`, then consult `04_TODO.md`, then canon as needed;
7. observational history remains empty until this checkpoint is completed, after which the recovery milestone may be recorded.

---

# 10. Retrospective Disposition

This file is temporary DEV_STAGE evidence.

After checkpoint reconstruction:

- stable operational rules remain in `12_OPERATIONAL_MODEL.md`;
- active work remains in `04_TODO.md`;
- current state and failed-cycle continuity move into `10_OPERATIONAL_STATE.md`;
- the recovery event may later be summarized in `11_OPERATIONAL_RECORD.md`;
- `DEV_STAGE/A_OPERATIONAL.md` may be refreshed for the next Operational functional stage when Main authorizes it.
