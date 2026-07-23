# Markei Operational Grimoire

## Purpose

This collection reduces repeated operational typing while keeping the human
decision points visible. It is hemi-automated: scripts perform mechanical
validation; the operator confirms provider targets and authorizes mutations.

## Canonical five-file set

| File | Responsibility |
| --- | --- |
| `GENERAL_SCRIPTS.md` | Short copy/paste commands and expected outcomes |
| `GRIMOIRE.md` | Architecture, setup, maintenance, and failure guidance |
| `NEON_CHECK.ps1` | Windows-proven launcher with terminal prompt, enforced transport, and parent-walk containment |
| `NEON_ACTION.sql` | Aligned named SQL inspection blocks |
| `NEON_CRED.md` | Minimal non-secret coordinates and aligned role names |

These files are collectively canonical under `documentation/`. The former
`documentation/models/` layer was pruned after its proven launcher and aligned
SQL catalogue were promoted here. Historical source fidelity remains recorded
in Git and J; duplicate executable copies are not retained in the live tree.

## First setup

1. Keep the five canonical files together in `documentation/`.
2. Keep only minimal non-secret coordinates in `documentation/NEON_CRED.md`.
3. Keep passwords and complete URLs out of every file.
4. Start Docker Desktop.
5. Open PowerShell in the file directory.
6. Run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role migrator `
  -Action connection
```

The bypass applies only to this child PowerShell process. If organizational
policy blocks it, use the locally approved signed-script method.

## Normal use

For guided selection:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md"
```

For deterministic reuse:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role <runtime|migrator|dbowner> `
  -Action <action>
```

The password prompt is masked. The script temporarily passes the password to
the Docker container using `PGPASSWORD`, removes the container after the
action, and clears the temporary process variables in `finally`.

## Role boundaries

| Role | Routine purpose | Must not become |
| --- | --- | --- |
| `runtime` | Hosted API and least-privilege smoke checks | Migration identity |
| `migrator` | Migrations, ledger, catalog checks | Render runtime identity |
| `dbowner` | Explicit owner-only recovery | Default operational role |

Migration and Gate 02 actions are locked to `migrator`.

## How SQL actions work

Each active action in `NEON_ACTION.sql` is delimited by:

```sql
-- ACTION: action-name
...
-- END ACTION
```

`NEON_CHECK.ps1` extracts only the selected block. To add an action:

1. Prefer a read-only transaction.
2. Return sanitized evidence only.
3. Add its name to both PowerShell `ValidateSet` and `$Actions`.
4. Add role restrictions when necessary.
5. Update `GENERAL_SCRIPTS.md`.
6. Test against the disposable development target.

## Migration design

`apply-migration` accepts a path instead of embedding SQL. It verifies that the
file is tracked and clean, shows its SHA-256, performs a role/database/TLS
preflight, and asks for `APPLY-ONCE`.

The operator must still confirm the Neon dashboard branch. A PostgreSQL
hostname/database response cannot independently prove a human-readable Neon
branch alias.

Migration `007_account_cursor_provisioning` was applied once on 2026-07-23 and
passed postflight. Its apply command is historical evidence and must not be
treated as a routine index command.

## Credential and coordinate map

| Requested item | Source | Storage |
| --- | --- | --- |
| Direct host | Neon Connect, intended branch | `NEON_CRED.md` |
| Database/role names | Neon/Markei configuration | `NEON_CRED.md` |
| Role password | Current rotated secret | Masked prompt only |
| Complete runtime URL | Neon pooled connector | Private secret store/Render |
| Render origin | Render service | Private note or prompt |
| Render API token/service ID | Render | Private secret store only |
| Auth0 issuer/audience/client ID | Auth0 application/API | Private configuration |
| Auth0 client secret/tokens | Auth0 | Secret store only; never mobile client |
| Device/account UUID | Local/provider evidence | Prompt when action requires it |

The committed mitigated-risk coordinate file uses this exact field interface:

```text
Environment: development
Host: <direct ep-*.neon.tech hostname>
Port: 5432
Database: markei_sync_dev
RuntimeUser: markei_runtime
MigratorUser: markei_migrator
DbOwnerUser: <development database owner role>
```

`ProjectAlias` is documentation-only and is not required by the launcher.

## Failure classifications

| Failure | Meaning / next move |
| --- | --- |
| Docker unavailable | Start Docker Desktop; no database call occurred |
| Placeholder remains | Complete non-secret coordinate file |
| Authentication rejected | Confirm selected role and current rotated password |
| Identity mismatch | Stop; coordinate or credential is wrong |
| TLS mismatch | Stop; do not open shell or mutate |
| Migration dirty/untracked | Restore an exact committed migration first |
| Migration reports error | Do not retry; inspect ledger/postflight read-only |
| Wrong branch uncertainty | Stop and verify Neon dashboard target |

## Gate 02 order

```text
connection proof
→ Gate 02 preflight
→ exact committed migration once
→ Gate 02 postflight
→ runtime readiness proof
→ authorized Git/Render deployment
→ health checks
→ only then a controlled Sync action
```

No script in this collection triggers Sync, enrollment, revocation, or replay.

## Proven Gate 02 checkpoint — 2026-07-23

The development database returned:

- migration 007 ledger checksum
  `c10-mcg02-account-cursor-provisioning-v1`;
- readiness-v2 `true`;
- one provisioning function and exactly one provisioning trigger;
- one Account and one corresponding cursor-state row;
- zero missing cursor-state rows and zero orphan cursor-state rows;
- runtime `SELECT=true`, `INSERT=false`, `DELETE=false`;
- runtime scoped `next_cursor UPDATE=true`;
- runtime readiness execution `true`;
- runtime privileged provisioning execution `false`.

The `false` privilege values are expected security boundaries. They do not
depend on Flutter activity. Gate 02 is closed; migration 007 must not be
reapplied.

## Maintenance rule

Treat variable and action names as an interface. When one changes, search all
five files and update every reference in the same commit:

```powershell
rg "NEON_CHECK|NEON_ACTION|NEON_CRED|gate02|markei_" documentation
```

## GRIMOIRE_INDEX

Each entry has exactly: development origin, utility, copy/paste command,
required or expected inputs, and expected response. Mutation commands that
have already completed are intentionally excluded from the active index.

### Open migrator psql

- Developed in: `Cycle 10 / GCM-02 / Gate 02 / human-operationalisation inner sprint`
- Utility: open an authenticated Neon development `psql` session as the
  migration role after identity and encrypted-transport enforcement.
- Command:

  ```powershell
  powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
    -Role migrator `
    -Action shell
  ```

- Required/expected inputs: Docker Desktop running; private
  `documentation\NEON_CRED.md`; current `markei_migrator` password entered at
  the masked terminal prompt.
- Expected response: `PASS: role=markei_migrator
  database=markei_sync_dev TLS=active`, followed by the `psql` prompt.

### Verify Gate 02 postflight

- Developed in: `Cycle 10 / GCM-02 / Gate 02 / post-migration verification`
- Utility: repeat the read-only ledger, provisioning, cursor-integrity, and
  runtime privilege inspection without reapplying migration 007.
- Command:

  ```powershell
  powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
    -Role migrator `
    -Action gate02-postflight
  ```

- Required/expected inputs: Docker Desktop running; private coordinates;
  current migrator password.
- Expected response: migration 007 present; readiness-v2 `t`; trigger count
  `1`; missing/orphan counts `0`; intended runtime grants/denials; transaction
  `ROLLBACK`; final action `PASS`.

### Open runtime psql

- Developed in: `Cycle 10 / GCM-02 / post-Gate-02 runtime boundary check`
- Utility: open Neon using the least-privilege API identity for runtime-only
  validation.
- Command:

  ```powershell
  powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
    -Role runtime `
    -Action shell
  ```

- Required/expected inputs: Docker Desktop running; private coordinates;
  current `markei_runtime` password entered at the masked terminal prompt.
- Expected response: `PASS: role=markei_runtime database=markei_sync_dev
  TLS=active`, followed by the `psql` prompt.

### Query runtime readiness

- Developed in: `Cycle 10 / GCM-02 / post-Gate-02 runtime boundary check`
- Utility: verify that the runtime role can execute the safe readiness-v2
  function.
- Command:

  ```sql
  SELECT current_user, current_database(),
         public.markei_hosted_runtime_ready_v2() AS ready;
  ```

- Required/expected inputs: an open runtime-role `psql` session.
- Expected response: `markei_runtime`, `markei_sync_dev`, and `ready = t`.

### Inspect migration ledger

- Developed in: `Cycle 10 / GCM-02 / provider migration controls`
- Utility: list committed provider migrations read-only.
- Command:

  ```powershell
  powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
    -Role migrator `
    -Action migration-ledger
  ```

- Required/expected inputs: current migrator password.
- Expected response: ordered ledger rows including
  `007_account_cursor_provisioning`, followed by `ROLLBACK` and action `PASS`.

### Verify Git alignment

- Developed in: `intermediate-cycle recovery / repository alignment`
- Utility: compare local HEAD with the remote recovery branch before
  deployment or further materialization.
- Command:

  ```powershell
  git fetch --prune origin
  git status --short --branch
  git rev-parse HEAD
  git rev-parse origin/cycle10-intermid-grimoire
  git rev-list --left-right --count origin/cycle10-intermid-grimoire...HEAD
  ```

- Required/expected inputs: repository root; network access to `origin`; no
  unresolved local overlap.
- Expected response: identical full SHAs and divergence count `0 0`; otherwise
  stop and reconcile.

### Verify hosted health

- Developed in: `Cycle 10 / GCM-02 / Render deployment verification`
- Utility: inspect live and ready HTTP status for the operator-confirmed Render
  origin.
- Command:

  ```powershell
  $Origin = (Read-Host "Render public origin").TrimEnd("/")
  $Live = Invoke-WebRequest -Uri "$Origin/health/live" -Method Get `
    -MaximumRedirection 0 -SkipHttpErrorCheck
  $Ready = Invoke-WebRequest -Uri "$Origin/health/ready" -Method Get `
    -MaximumRedirection 0 -SkipHttpErrorCheck
  [pscustomobject]@{
    LiveStatus = [int]$Live.StatusCode
    ReadyStatus = [int]$Ready.StatusCode
    LiveClass = $Live.Content
    ReadyClass = $Ready.Content
  }
  ```

- Required/expected inputs: the public Render service origin, without secrets.
- Expected response: after authorized deployment, both HTTP statuses are `200`;
  otherwise stop before any Sync attempt.
