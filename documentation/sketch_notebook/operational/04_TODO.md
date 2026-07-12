# 04_TODO.md

> Version: Cycle 06 active derivative 0.2
> Status: Active operational derivative
> Persistence Class: Derived
> Knowledge Class: Operational
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Branch: `sketch-notebook-recovery`

---

# 1. Fast Recovery Card

Current evidence:

```text
configured: yes
built: yes
launched: yes — isolated frozen launch and immediate reopen
installed: blocked
validated: partial
accepted: no
```

Completed in the first Cycle 06 materialization unit:

- authoritative one-folder `Markei.spec`;
- build wrapper invoking the spec;
- schema-only production packaging;
- exclusion of seed/live database/WAL/SHM/logs;
- build dependency record;
- per-user installer source and compile wrapper;
- startup diagnostics;
- focused release tests;
- bounded MainWindow shutdown correction;
- successful source/static, frozen build, resource, first-launch, shutdown, and reopen gates.

# 2. Active Cycle 06 Work

## P0 — Provide installer compiler

- Install or provide Inno Setup 6 / `ISCC.exe`.
- Use `-ISCCPath` or `ISCC_PATH` when discovery does not find it.
- Record compiler path and version.

## P0 — Compile and inspect installer

Run the repository wrapper only after the frozen distribution exists:

```powershell
.\scripts\build_installer.ps1
```

Required evidence:

- compile exit status;
- artifact path and filename;
- artifact size and SHA256;
- expected version/publisher/application identity;
- no source tree, seed fixture, live database, WAL/SHM, logs, tests, or caches.

## P0 — Validate installed lifecycle

Use an ordinary user environment and capture:

```text
clean install
→ Start Menu launch
→ Register / Lists / History / Settings
→ store creation or editing
→ receipt registration
→ dependent-page refresh
→ close
→ immediate reopen
→ persistence verification
```

Then validate:

```text
compatible upgrade or same-version reinstall
→ data preservation
→ uninstall
→ accepted retention behavior
→ reinstall
→ retained-data recovery
```

Installed shutdown and retention remain unvalidated until these gates execute.

## P1 — Record Windows trust observations

- Record SmartScreen behavior.
- Record antivirus detections or absence of detections.
- Do not classify unsigned reputation warnings as application runtime defects without evidence.

## P1 — Obtain human acceptance

Acceptance requires review of the installed artifact and principal workflow path. Operational evidence may support but cannot grant final acceptance.

# 3. Retained Inherited Debt

## Workflow atomicity

Receipt registration and purchase deletion/recalculation span multiple committed mutations. Retain as inherited debt:

- inject failure between mutation boundaries;
- record exact durable partial states;
- escalate only if beta validation demonstrates a blocking user-visible defect or Main stages a transaction change.

## Additional non-blocking validation debt

- additive migration failure behavior;
- reset behavior with active connections and WAL/SHM;
- broader interactive workflow coverage beyond the beta smoke route.

# 4. Required Commands

Already evidenced in the materialization report:

```powershell
python -m compileall app main.py
python -m unittest discover -s tests
.\scripts\build_windows.ps1
```

`python -m pytest` was unavailable because `pytest` was not installed; this is an environment limitation, not an open release-test failure.

Next command:

```powershell
.\scripts\build_installer.ps1
```

Current result: `blocked` until `ISCC.exe` is available.

# 5. Completion Boundary

Cycle 06 remains open until a compiled installer is installed and the complete installed lifecycle is validated and accepted.

When this file conflicts with canon:

```text
12_OPERATIONAL_MODEL.md wins
→ identify derivative drift
→ refresh this file
```
