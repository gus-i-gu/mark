# 04_TODO.md

> Version: Cycle 06 active derivative 0.3
> Status: Active operational derivative
> Persistence Class: Derived
> Knowledge Class: Operational
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Branch: `sketch-notebook-recovery`

---

# 1. Fast Recovery Card

Current evidence:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Technically completed:

- Inno Setup 6.7.3 resolved from a per-user installation;
- frozen runtime rebuilt and inspected;
- installer compiled, inspected, sized, and hashed;
- per-user installation completed;
- Start Menu shortcut launched the installed executable;
- external database initialized with structural defaults and no sample products or purchases;
- Register-equivalent persistence plus Lists, History, and Settings projections passed;
- installed close and immediate reopen passed;
- same-version reinstall preserved data;
- uninstall retained user data;
- reinstall recovered retained compatible data.

# 2. Remaining Cycle 06 Work

## P0 — Human-visible installer and UI walkthrough

Using the compiled controlled-beta package, observe and record:

```text
interactive installer wizard and destination
→ privilege behavior
→ Start Menu usability
→ visible Register workflow
→ visible Lists result
→ visible History result
→ visible Settings/store behavior
→ normal close
→ immediate Start Menu reopen
→ persisted values visible after reopen
```

Automated service/database evidence supports this route but does not replace human UI acceptance.

## P0 — Windows security and reputation observation

Record the human-visible behavior of:

- SmartScreen during interactive installer execution;
- Microsoft Defender or other active antivirus;
- any quarantine, warning, block, or absence of warning;
- the unsigned `NotSigned` status as release context, not automatically an application defect.

Silent execution produced no observed SmartScreen prompt, so human-visible behavior remains `unknown`.

## P0 — Final human/Main acceptance

Main/human review must decide whether the installer and principal visible workflows are acceptable for controlled beta use. Operational evidence cannot declare acceptance.

## P1 — Resolve generated-artifact repository drift

Current contradiction:

```text
G_OPS_CODEX
    installer described as generated but uncommitted

current branch
    dist/installer/Markei-Setup-0.1.0-x64.exe exists
```

Operational policy is that generated release binaries should not be ordinary source-controlled files. A separately authorized cleanup should:

1. remove the committed installer binary from source history going forward;
2. add appropriate ignore coverage for generated `dist/` release outputs;
3. retain the installer hash, size, toolchain, and command evidence in documentation or an approved release channel;
4. publish controlled-beta binaries through an approved release/artifact surface.

This documentation pass does not modify the binary or ignore rules.

## P1 — Installer architecture warning

Replace deprecated Inno Setup architecture identifier `x64` with the accepted `x64compatible` form only through a bounded installer-maintenance stage followed by installer rebuild and lifecycle regression evidence. The current warning is non-blocking.

# 3. Retained Inherited Debt

## Workflow atomicity

Receipt registration and purchase deletion/recalculation span multiple committed mutations. Retain as inherited debt:

- inject failure between mutation boundaries;
- record durable partial states;
- escalate only if beta use demonstrates a blocking user-visible defect or Main stages a transaction correction.

## Additional non-blocking validation debt

- dedicated clean-account lifecycle evidence, if later required because current-user backup/restore evidence proves ambiguous;
- additive migration failure behavior;
- reset behavior with active connections and WAL/SHM;
- broader interactive regression beyond the accepted beta route.

# 4. Evidence Already Captured

```text
python -m compileall app main.py       passed
python -m unittest discover -s tests  passed, 5 tests
scripts/build_windows.ps1             passed
scripts/build_installer.ps1           passed
```

Installer evidence:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

# 5. Completion Boundary

Cycle 06 remains open until the human-visible installer/UI/security route is observed and Main/human acceptance is recorded. Technical lifecycle completion alone does not close the milestone.

When this file conflicts with canon:

```text
12_OPERATIONAL_MODEL.md wins
→ identify derivative drift
→ refresh 04_TODO.md
```