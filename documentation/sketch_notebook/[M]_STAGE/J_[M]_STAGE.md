# J_[M]_STAGE — Cycle 06 Main Reconciliation

> Status: Active Main synthesis
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Branch: `sketch-notebook-recovery`
> Inputs: `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`
> Knowledge state: Reconciled staging; not permanent canon
> Milestone: Fully executable and installable Windows primary beta

---

## 1. Main Synthesis Summary

The three functional domains converge on one bounded Cycle 06 implementation path. Markei's current layered desktop architecture can be packaged without broad redesign. The recovery branch already contains a root launcher, frozen-resource handling, external writable SQLite state, `Markei.spec`, `scripts/build_windows.ps1`, and Windows version metadata. It does not contain contemporary evidence of a built, installed, validated, or accepted beta.

The first materialization unit will repair and unify release configuration rather than redesign business layers. `Markei.spec` becomes the authoritative packaging definition; the PowerShell build script invokes it. Production packaging excludes the sample-bearing `seed.sql` and includes `schema.sql`. Application files remain replaceable; `%LOCALAPPDATA%/Markei` remains retained writable user state. The first beta keeps the one-folder topology and identity `Markei` / `Markei.exe` / version `0.1.0`. Installer identity must be stable across upgrades. Publisher metadata will use `Markei` unless a later explicit human correction is supplied.

Startup failures must become inspectable through a writable log outside installed program files. Shutdown structure will be validated before alteration; Codex may add only a bounded MainWindow-owned close path if focused validation demonstrates retained connections, cleanup exceptions, database locks, or failed immediate reopen.

The Didactic stage will preserve four Red candidates and reinforce existing persistence, cleanup, and atomicity concepts. It will not promote concepts to Green or treat PyInstaller/Inno Setup as concepts.

## 2. Reconciled Current Facts

Accepted current facts:

- runtime boundary remains `Desktop UI → ProductService → Repository → Database Manager → SQLite`;
- `main.py` is the packaged launcher and delegates to `app.main.main()`;
- `schema.sql` is a required bundled read-only resource;
- the live database is writable state under `%LOCALAPPDATA%/Markei`;
- `market.sqlite`, WAL, SHM, and generated logs must not be bundled;
- `Markei.spec` and `scripts/build_windows.ps1` currently duplicate packaging authority;
- both currently include `seed.sql`;
- the current seed includes structural defaults and sample business data;
- version `0.1.0` exists in application and Windows metadata but is not yet one coordinated release contract;
- no current Cycle 06 evidence supports status beyond `configured`;
- distributed repository cleanup and multi-commit workflows are risks requiring evidence, not proven release failures.

## 3. Contradiction Resolution

### Packaging-source contradiction

Operational found `Markei.spec`; Design reported no recoverable current specification. Direct branch-qualified Main inspection confirms that `Markei.spec` exists, as does `scripts/build_windows.ps1`.

Resolution:

```text
Operational file evidence prevails.
Markei.spec exists but requires repair.
The build script exists but must stop independently defining package contents.
```

### Installer topology

No contemporary installer definition was established by the functional reports.

Resolution:

```text
Codex must locate any current branch installer source before creating one.
If none exists, add one bounded Inno Setup definition and compile wrapper.
Historical main-branch installer evidence is precedent only.
```

## 4. Accepted Cycle 06 Decisions

### 4.1 Production seed policy

Accepted:

```text
Production package includes schema.sql.
Production package excludes seed.sql.
Fresh production databases receive only structural defaults supplied by current initialization/migration behavior.
No named store, category fixture, product fixture, purchase fixture, or demonstration business row is shipped.
```

`seed.sql` remains a development/test fixture unless later reclassified.

### 4.2 Uninstall data-retention policy

Accepted for the primary beta:

```text
Uninstall removes installed program files and shortcuts.
Uninstall preserves %LOCALAPPDATA%/Markei by default.
No installer UI for optional data deletion is required in Cycle 06.
```

This policy must be validated through uninstall and reinstall evidence.

### 4.3 Release identity

Accepted minimum contract:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Installer identity: one stable AppId retained across compatible upgrades
Architecture: Windows x64 primary beta
```

Application, executable metadata, build output, and installer metadata must not silently diverge. A future branding correction may revise publisher metadata deliberately; it must not block the first controlled beta.

### 4.4 Packaging authority and topology

Accepted:

```text
Markei.spec is the authoritative PyInstaller source.
scripts/build_windows.ps1 invokes Markei.spec.
one-folder remains the primary beta topology.
UPX is disabled unless contemporary validation explicitly supports it.
A diagnostic console build may exist, but the distributable installed beta is windowed.
```

### 4.5 Shortcuts

Accepted:

```text
Start Menu shortcut required.
Desktop shortcut optional through an installer task; not unconditional.
```

### 4.6 Shutdown response

Accepted:

```text
Validate current cleanup first.
Do not preemptively redesign lifetime ownership.
Add a bounded MainWindow/application shutdown correction only if focused evidence fails.
```

Workflow transaction redesign is not part of the first materialization unit and becomes a beta blocker only if ordinary acceptance testing exposes unacceptable partial state.

## 5. First Materialization Boundary

Codex receives one bounded release-enablement unit:

1. repair `Markei.spec` as authoritative one-folder packaging source;
2. make `scripts/build_windows.ps1` invoke the spec and support clean diagnostic/windowed builds without duplicating datas;
3. exclude `seed.sql`, live database files, WAL/SHM, caches, build residue, and development fixtures from production artifacts;
4. include `schema.sql` and attach version metadata;
5. add or repair a version-controlled Inno Setup installer definition and compile wrapper;
6. apply accepted identity, Start Menu shortcut, optional desktop shortcut, and preserve-data uninstall policy;
7. add writable startup diagnostics at the outer entrypoint;
8. add focused build/resource/lifecycle validation assets;
9. validate shutdown and immediate reopen before altering ownership;
10. if and only if shutdown validation fails, make the smallest desktop-composition correction and report it explicitly.

This unit excludes broad service/repository decomposition, transaction redesign, schema redesign, migration-framework replacement, UI redesign, signing, auto-update, rollback infrastructure, mobile, backend, synchronization, authentication, and cloud work.

## 6. Evidence Vocabulary

Codex and later chats must use only evidence-appropriate states:

```text
configured
built
launched
installed
validated
accepted
blocked
unknown
```

A successful build is not installation. Installation is not workflow validation. Validation is not Main/human acceptance.

## 7. D/E/F Routing

- `DEV_STAGE/D_OPS_STAGE.md` contains executable file changes, commands, validation gates, and G report requirements.
- `DEV_STAGE/E_DDC_STAGE.md` contains bounded Didactic materialization for four Red candidates and reinforcement notes, without Green promotion.
- `DEV_STAGE/F_DSN_STAGE.md` contains accepted release boundaries and post-materialization Design evidence requirements.

D/E/F correspond to the same Cycle 06 materialization unit. G/H/I must report only this unit.

## 8. Human Validation Boundary

Codex may build and exercise what its environment supports, but Cycle 06 cannot close without human-observable installed lifecycle evidence on Windows:

```text
compile installer
→ clean install
→ Start Menu launch
→ principal workflows
→ close
→ immediate reopen
→ persistence check
→ compatible reinstall/upgrade
→ uninstall
→ retained-data confirmation
→ reinstall and recovery
```

SmartScreen and antivirus observations must be recorded without confusing reputation warnings with application correctness.

## 9. Main Authorization

Main authorizes D/E/F staging for the bounded unit above.

Main does not yet accept a beta release, permanent domain promotion, or Cycle 06 closure.
