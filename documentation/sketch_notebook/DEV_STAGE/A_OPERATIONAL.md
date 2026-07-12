# A_OPERATIONAL — Cycle 06 Sprint 02

> Status: Complete compact Operational delta
> Role: Operational Chat [O]
> Branch: `sketch-notebook-recovery`
> Authority: Main reconciliation input only
> Milestone: Fully executable and installable Windows primary beta

## Main Synthesis Summary

Sprint 01 already established a configured, built, and launched one-folder frozen runtime. Sprint 02 does not need another packaging redesign. Its operational task is to cross the remaining evidence boundaries: resolve Inno Setup, compile and inspect the installer, exercise an ordinary per-user installation, validate principal workflows and immediate reopen, then prove retention through reinstall, uninstall, and recovery.

The repository route is concrete. `scripts/build_installer.ps1` requires `dist\Markei\Markei.exe`, resolves `ISCC.exe` from an explicit `-ISCCPath`, `ISCC_PATH`, or the two normal Inno Setup 6 installation locations, compiles `installer\Markei.iss`, and expects `dist\installer\Markei-Setup-0.1.0-x64.exe`. The installer is configured for lowest-privilege per-user placement under `%LOCALAPPDATA%\Programs\Markei`, a Start Menu shortcut, optional desktop shortcut, and no removal of `%LOCALAPPDATA%\Markei` user state.

No current evidence justifies an implementation correction. The immediate route is validation-first: provide Inno Setup 6, rebuild the frozen distribution, compile, inspect, and run the lifecycle in a dedicated Windows test account. A dedicated account is preferred over redirecting only environment variables because the installer and shortcuts use Windows per-user shell locations. It protects ordinary user data while preserving realistic Start Menu, uninstall-registration, and Local AppData behavior.

Codex can execute static tests, frozen rebuild, compiler discovery, installer compilation, hashes, file inspection, and some scripted install-state checks when desktop access permits. Human interaction remains required for installer UI, SmartScreen/antivirus observations, Start Menu usability, the four application workflows, visible close/reopen behavior, and final acceptance. Any failure must be classified before a correction is staged. The beta remains `installed: blocked`, `validated: partial`, and `accepted: no` until all acceptance gates pass.

## Inherited Evidence

Do not repeat or reopen Sprint 01 findings unless drift appears:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and immediate reopen
installed: blocked
validated: partial
accepted: no
```

Validated evidence includes source compilation, five standard-library tests, a clean one-folder build, schema-only first launch, resource exclusions, startup-log creation, bounded shutdown correction, closure of four page-owned repositories, and frozen immediate reopen. The built executable was reported at `dist\Markei\Markei.exe` with SHA256 `E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B`.

The previous installer attempt was blocked solely because `ISCC.exe` was unavailable. No compiled installer or installed-lifecycle evidence exists.

## Essential Evidence Index

| ID | File or evidence | Sprint 02 relevance |
| -- | -- | -- |
| E1 | `installer/Markei.iss` | Defines per-user placement, identity, file source, shortcuts, output name, and configured preservation behavior. |
| E2 | `scripts/build_installer.ps1` | Defines compiler discovery, prerequisites, compile invocation, and expected artifact path. |
| E3 | `Markei.spec` | Confirms the installer input is the schema-only windowed one-folder runtime. |
| E4 | `scripts/build_windows.ps1` and `requirements-build.txt` | Provide the reproducible frozen rebuild route and observed build dependencies. |
| E5 | `tests/test_release_configuration.py` | Checks package policy, installer source policy, identity, diagnostics, and schema-only first launch. |
| E6 | `DEV_STAGE/G_OPS_CODEX.md` | Records successful Sprint 01 gates, executable hash, shutdown correction, and the `ISCC.exe` blocker. |
| E7 | Main continuity and Operational checkpoint | Establish the remaining lifecycle route and prohibit status inflation. |

## Installer Toolchain Route

### Prerequisite and resolution

Provide Inno Setup 6 so that `ISCC.exe` is available by one repository-supported route, in this precedence order:

1. explicit parameter:
   ```powershell
   .\scripts\build_installer.ps1 -ISCCPath "C:\path\to\ISCC.exe"
   ```
2. environment variable:
   ```powershell
   $env:ISCC_PATH = "C:\path\to\ISCC.exe"
   .\scripts\build_installer.ps1
   ```
3. automatic discovery under either:
   ```text
   %ProgramFiles(x86)%\Inno Setup 6\ISCC.exe
   %ProgramFiles%\Inno Setup 6\ISCC.exe
   ```

Before compilation, confirm the path exists and capture the compiler version. Missing compiler remains a `toolchain prerequisite` blocker, not an installer defect.

### Build and compile

From the repository root on `sketch-notebook-recovery`:

```powershell
python -m unittest discover -s tests
.\scripts\build_windows.ps1
.\scripts\build_installer.ps1 -ISCCPath "C:\path\to\ISCC.exe"
```

Expected input:

```text
dist\Markei\Markei.exe
```

Expected output:

```text
dist\installer\Markei-Setup-0.1.0-x64.exe
```

### Artifact inspection

Record compiler path/version, command exit code, artifact path, byte size, timestamp, and SHA256. Verify Windows file properties and installer-visible identity agree with `Markei`, `0.1.0`, publisher `Markei`, and x64. Inspect the packaged source set or installed files to confirm the installer consumes `dist\Markei` and does not introduce source files, tests, `seed.sql`, `market.sqlite`, WAL/SHM, logs, caches, or development residue.

A compiled artifact advances the state to `installer built`; it does not establish `installed` or lifecycle `validated`.

## Installed Lifecycle Test Route

### Safe test environment

Use a dedicated ordinary Windows test account with no existing Markei state. Before starting, record whether these paths exist:

```text
%LOCALAPPDATA%\Programs\Markei
%LOCALAPPDATA%\Markei
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Markei
```

Do not delete or repurpose the ordinary user’s Markei directory. Preserve a copy of the dedicated account’s test database before destructive lifecycle transitions.

### Clean install and launch

1. Run `dist\installer\Markei-Setup-0.1.0-x64.exe` interactively.
2. Confirm per-user destination and no administrator requirement.
3. Leave the optional desktop shortcut unselected for the primary route; test it separately if selected.
4. Confirm installed program files exist under `%LOCALAPPDATA%\Programs\Markei`.
5. Confirm the Start Menu entry exists.
6. Launch only from the Start Menu, with no active development shell, Python command, or repository working directory.
7. Record process start, visible MainWindow, and any startup log or error dialog.

### Principal workflow evidence

Exercise a small, uniquely identifiable dataset:

1. Settings: create or edit a test store and save settings.
2. Register: register one identifiable product and purchase.
3. Lists: verify the product appears in the appropriate current projection.
4. History: verify the purchase appears with the expected values.
5. Return to Settings and confirm saved values remain visible.

Capture the entered identifiers and observed results, not just screenshots of an open window.

### Close, reopen, and persistence

Close through the normal window control. Immediately relaunch from the Start Menu. Confirm no database-lock or startup error appears and that the store, product, purchase, Lists projection, History entry, and settings persist. Record `%LOCALAPPDATA%\Markei\market.sqlite` existence and modification time. Installed shutdown is `validated` only after this installed-context route passes; Sprint 01 frozen evidence is insufficient.

### Reinstall, uninstall, and recovery

Run the same-version installer again and confirm program files are replaced or repaired without losing the test dataset. If a compatible version change is staged later, repeat with the same AppId and verify the existing database opens.

Uninstall through Windows Installed Apps or the registered Markei uninstaller. Confirm program files and shortcuts are removed, then separately verify `%LOCALAPPDATA%\Markei\market.sqlite` remains. External placement and absence of installer deletion directives are only configuration evidence; direct post-uninstall inspection is required.

Reinstall the same compatible package, launch from Start Menu, and verify the retained test dataset reappears without manual database copying. Capture before/after database hash or a query-based record summary when practical; hashes may change during normal SQLite access, so semantic row evidence remains required.

## Human Validation Boundary

Codex may execute or automate:

- compiler discovery and version capture;
- standard-library tests and frozen rebuild;
- installer compilation;
- artifact hashing and file-set inspection;
- scripted existence checks for program, shortcut, and data paths;
- database row queries before and after lifecycle transitions;
- unattended steps only when they do not hide required human observations.

Human validation is required for:

- installer wizard, destination, and privilege behavior;
- SmartScreen prompts and antivirus detections or absence thereof;
- Start Menu and optional desktop shortcut usability;
- visible launch without development tooling;
- Register, Lists, History, and Settings workflow correctness;
- normal close and immediate reopen behavior;
- acceptance of retained-data behavior;
- final beta acceptance.

Unsigned reputation warnings must be recorded as Windows reputation/security observations, not automatically classified as application defects.

## Failure Classification

Classify the first failing gate before changing files:

| Class | Examples |
| -- | -- |
| toolchain prerequisite | `ISCC.exe` missing or inaccessible |
| installer configuration defect | compile error, wrong output, shortcut or uninstall registration absent |
| packaging defect | missing executable, Qt plugin, schema, or forbidden bundled data |
| installed runtime defect | installed executable fails before workflows begin |
| application workflow defect | Register, Lists, History, or Settings behaves incorrectly only after launch |
| data-retention defect | data lost or overwritten during reinstall, uninstall, or recovery |
| Windows reputation/security observation | SmartScreen warning or antivirus action |
| human acceptance failure | technically passing artifact rejected for observable beta usability |

Stop dependent gates after a failure and retain the original evidence.

## Potential Bounded Corrections

No correction is presently authorized. After a demonstrated failure, Main may stage only the smallest relevant change, such as:

- compiler-path or actionable-error correction in `build_installer.ps1`;
- output-name/path synchronization between the wrapper and `.iss`;
- a narrow Inno Setup file, shortcut, identity, or uninstall-registration correction;
- a missing packaged runtime/resource correction in `Markei.spec`;
- an installed-only startup diagnostic correction;
- an installed shutdown correction only if the existing `MainWindow.closeEvent()` route fails in the installed context;
- a workflow correction only for a reproducible beta-blocking workflow failure;
- a retention correction only if direct lifecycle evidence contradicts the accepted preserve-data policy.

Do not use Sprint 02 failures to authorize broad service/repository, transaction, schema, migration, UI, or composition redesign.

## Acceptance Gates

| Gate | Required evidence | Current state |
| -- | -- | -- |
| Compiler | Inno Setup 6 path and version captured | blocked |
| Installer artifact | compile succeeds; identity, contents, size, hash inspected | blocked |
| Clean installation | ordinary per-user install and registered shortcuts | blocked |
| Installed launch | Start Menu launch without Python/source checkout | blocked |
| Workflows | Register, Lists, History, Settings pass with recorded data | blocked |
| Installed close/reopen | immediate reopen with no retained lock and persisted data | blocked |
| Reinstall/upgrade | compatible replacement preserves and opens data | blocked |
| Uninstall retention | program removed; `%LOCALAPPDATA%\Markei` retained | blocked |
| Reinstall recovery | retained compatible data reopens after reinstall | blocked |
| Windows observations | SmartScreen/antivirus behavior recorded | pending |
| Acceptance | Main/human explicitly accepts the complete lifecycle | pending |

## Main Handoff

Operational finds no new policy decision and no justified preemptive source change. Main should define Sprint 02 as one validation-centered materialization unit: make Inno Setup available, compile and inspect the installer, add only safe evidence automation needed for a dedicated Windows test account, execute the complete installed lifecycle, and patch only a failed beta gate. The critical separation is maintained: configured installer source is not a compiled artifact; a compiled artifact is not installation; installation is not lifecycle validation; validation is not acceptance. Until the dedicated-account route passes, the current status remains `installed: blocked`, `validated: partial`, and `accepted: no`.