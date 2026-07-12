# 03_DECISION_LOG.md

> Version: 0.2-cycle06
> Status: Active Observational Record
> Persistence Class: Observational History
> Knowledge Class: Design History
> Authority: Design Chat [D]
> Scope: Chronological Design-domain decisions, reconciliation events, materializations, corrections, and deferred boundaries
> Current Coverage: Recovery repopulation through Cycle 06 post-Codex Design absorption

---

# 1. Purpose and Reading Rule

This file records what happened in the Design domain and why. It is append-oriented observational history; it does not independently define current architecture.

For current truth, read:

```text
Canonical architecture
    design/01_ARCHITECTURE.md

Derived architecture map
    design/14_MODEL_OVERVIEW.md

Current checkpoint
    design/09_DESIGN_STATE.md
```

Earlier events remain historical even when later events revise current architecture.

---

# 2. Recovery Repopulation Record

## Event 01 — Methodology boot and empty-domain detection

The recovery began after permanent Design files had been intentionally pruned. Domain Symmetry assigned:

```text
C_DESIGN.md          functional reasoning
01_ARCHITECTURE.md   canonical knowledge
14_MODEL_OVERVIEW.md derived knowledge
09_DESIGN_STATE.md   checkpoint
03_DECISION_LOG.md   observational history
```

Application source was evidence, not automatic canon.

## Event 02 — Initial structural review

Repository inspection recovered the application direction:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

MainWindow was identified as desktop composer and coordinator; ProductService as application facade; Repository as persistence facade; and Database Manager as lifecycle owner.

Functional staging commits:

```text
0c7143e13cd27e1b6a20506cadf045631e2eeeae
    Stage initial design recovery review

3f40e25109ede1501541fa8eefce84465dcb47bd
    Consolidate design structural recovery
```

## Event 03 — Lifecycle and transaction constraints clarified

All four public pages were confirmed to create separate ProductService → Repository → SQLite connection chains. Cleanup capability existed locally, while application-wide shutdown ownership was distributed and implicit.

Receipt registration and purchase deletion/recalculation were confirmed as multi-commit workflows. This was recorded as current implementation property, not accepted future target architecture.

## Event 04 — Main-stage routing correction

The initial lookup used obsolete path:

```text
[M]_STAGE/J_MAIN_STAGE.md
```

The human-corrected authoritative path was:

```text
[M]_STAGE/J_[M]_STAGE.md
```

A concurrent content-SHA conflict was also handled by re-reading before writing. These events established that exact stage paths and current blob SHAs are part of reconciliation safety.

Corrective staging commit:

```text
65199e4e3d02541fc4f25f9f677e307c40447973
    Stage initial design canon candidate
```

## Event 05 — Canonical, derived, and checkpoint repopulation

Main reconciliation authorized stable current architecture while excluding unresolved future targets.

Permanent Design materialization:

| Commit | Result |
| --- | --- |
| `4431a25c8365e0c847c4c97b2775a90eda21ea0b` | Canonical architecture repopulated |
| `b019063163e45dc72ffb04a9010483a035e858e2` | Derived model overview repopulated |
| `32a6834ef845280ed372c518ddcf1edb1e4e2112` | Design checkpoint rebuilt |

Temporary retrospective staging:

```text
ec9a1b6dc5d5252e1031e0890a468ecc38321b55
    Stage design checkpoint retrospective
```

The failed Cycle 05 precedent was classified as cycle-control and knowledge-routing overload, not proof that the layered application architecture had failed.

## Event 06 — Recovery decisions and deliberate non-decisions

Recovery established:

1. functional stages remain temporary reasoning surfaces;
2. Main reconciliation filters what may enter permanent memory;
3. canon stores accepted stable architecture;
4. the overview reorganizes canon without independent truth;
5. the checkpoint stores current state and active tensions;
6. this log stores chronology and rationale.

The recovery deliberately left open shared versus page-local services, shutdown ownership, workflow atomicity, ProductService/Repository decomposition, complete contracts, typed projections, migration versioning, Promotion status, `pages.order`, and Product's long-term hybrid role.

---

# 3. Event 07 — Cycle 06 Primary-Beta Design Reconciliation

## Context

Cycle 06 established one milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Functional A/B/C reports were reconciled in `J_[M]_STAGE.md`. Main authorized one bounded release-enablement unit without broad application redesign.

## Policy decisions accepted before materialization

### Schema-only production initialization

Decision:

```text
production package includes schema.sql
production package excludes sample-bearing seed.sql
fresh production data contains structural/default settings only
no sample store, category, product, purchase, or business fixture ships
```

Rationale: bundled sample data would blur application resources, development fixtures, and user-owned state.

### Preserve-user-data uninstall policy

Decision:

```text
uninstall removes replaceable program files and shortcuts
uninstall preserves %LOCALAPPDATA%/Markei by default
```

Rationale: the database and settings are user-owned writable state, not installer-owned replaceable content. Optional data-deletion UX was deferred.

### Coordinated release identity

Decision:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Stable AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Target: Windows x64 controlled beta
```

Rationale: executable, package, installer, shortcuts, and compatible upgrades require one stable identity contract.

### Authoritative PyInstaller specification

Decision:

```text
Markei.spec
    authoritative package composition

scripts/build_windows.ps1
    invocation wrapper only
```

Rationale: duplicated command flags and spec contents had created two drifting package definitions.

### Shortcut policy

Decision:

```text
Start Menu shortcut required
desktop shortcut optional installer task
```

Rationale: Start Menu launch is part of ordinary installed use; desktop placement remains user choice.

### Validation-first shutdown policy

Decision:

```text
validate distributed cleanup first
add only a bounded close coordinator if direct evidence fails
```

Rationale: distributed lifecycle ownership was a structural concern, not yet proof of a leak or retained lock.

---

# 4. Event 08 — Cycle 06 Materialization Evidence

## Source boundaries materialized

Codex materialized:

- root `main.py` as launcher and outer startup-diagnostic boundary;
- `app.main.main()` unchanged as Qt application construction;
- `Markei.spec` as authoritative one-folder package definition;
- `scripts/build_windows.ps1` as the invocation wrapper;
- `installer/Markei.iss` as placement, identity, shortcuts, and uninstall-registration source;
- `scripts/build_installer.ps1` as compiler-discovery and compile wrapper;
- external startup logs under `%LOCALAPPDATA%/Markei/logs`;
- schema-only production packaging and exclusion of writable/transient state.

## Frozen evidence

Operational evidence recorded:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
validated: partial
```

Source/static checks, five standard-library release tests, frozen build, resource inspection, schema-only first launch, startup-log creation, and frozen reopen passed.

## Observed shutdown failure

The validate-first probe failed:

```text
MainWindow.close()
→ isolated SQLite file remained open
→ isolated LOCALAPPDATA removal failed with WinError 32
```

This converted a plausible structural risk into an observed bounded lifecycle defect.

## Bounded MainWindow correction

Codex added:

```text
MainWindow.closeEvent()
→ close_page_services()
→ idempotent closure of Register, Lists, History, and Settings services
```

Rerun evidence showed all four repositories open before close and closed afterward; the isolated database directory became removable.

Design classification:

```text
MainWindow coordinates final closure
local service/repository close ownership remains intact
not a composition-root redesign
not dependency injection
```

## Installer blocker

`installer/Markei.iss` and `scripts/build_installer.ps1` were configured, but `ISCC.exe` was unavailable.

Therefore:

```text
installer source: configured
compiled installer: blocked
installed execution: blocked
installed lifecycle: unvalidated
beta acceptance: no
```

No installer configuration was promoted as installation evidence.

---

# 5. Event 09 — Main Post-Codex Reconciliation

Main reviewed G/H/I and critical implementation files in commit:

```text
f402c9394d3401ef8c2df5696d052b18358758dc
    Reconcile Cycle 06 Codex materialization evidence
```

Main accepted the bounded unit as technically successful but insufficient to close Cycle 06.

Accepted Design absorption:

- deployment states remain distinct: source, frozen runtime, installer source, installed program files, and writable user state;
- launcher-owned startup diagnostics are stable;
- `schema.sql` is production resource and `seed.sql` is fixture-only;
- retained user data remains external;
- release identity and stable AppId form one contract;
- MainWindow final service-close coordination is accepted;
- packaging and installer layers do not own workflows or persistence semantics.

Preserved evidence boundary:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

Remaining lifecycle route:

```text
provide ISCC.exe
→ compile installer
→ inspect artifact
→ install per-user
→ Start Menu launch
→ principal workflows
→ close/reopen
→ retained-data verification
→ compatible reinstall/upgrade
→ uninstall preservation
→ reinstall recovery
→ human acceptance
```

---

# 6. Explicit Deferrals Preserved

Cycle 06 did not introduce or authorize:

- composition-root or dependency-injection redesign;
- ProductService/Repository decomposition;
- transaction redesign;
- schema redesign or migration ledger;
- mobile, backend/API, synchronization, authentication, or cloud persistence;
- automatic update, signing, rollback framework, or one-file packaging;
- optional uninstall data-deletion UX;
- broad UI/navigation redesign.

Workflow atomicity remains inherited Design debt unless a later bounded failure and Main reconciliation reopen it.

---

# 7. Current Observational Result

```text
canonical release boundaries absorbed
model overview refreshed
design checkpoint refreshed
installer lifecycle still blocked
application source unchanged by Design absorption
other domains unchanged
methodology unchanged
Main-root continuity unchanged
```

The next append should record installer compilation and installed-lifecycle evidence, or a bounded failure discovered during those gates.