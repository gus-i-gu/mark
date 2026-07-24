# Markei Operational Grimoire

## 1. Purpose

The GRIMOIRE is Markei's human-supervised operational interface. It reduces
repeated terminal typing without hiding provider selection, identity, secret
entry, mutation authority, or expected evidence.

```text
human selects one indexed block
→ block identifies its canonical G_SCRIPTS procedure
→ NS_COORDINATES supplies reviewed non-secret values
→ terminal requests only missing role/UUID/secret input
→ reviewed launcher or query performs the operation
→ sanitized output is compared with the stated expectation
→ operator stops on any mismatch
```

The system is hemi-automated: scripts own mechanical checks; the human owns
target confirmation and mutation authority.

## 2. Canonical five-file system

| File | Responsibility |
| --- | --- |
| `documentation/GRIMOIRE.md` | System architecture, safety policy, usage guidance, and final concise execution index |
| `documentation/G_SCRIPTS.md` | Canonical expanded `GS-*` procedures and validation sequences |
| `documentation/NS_COORDINATES.md` | Strict allowlist of public/non-secret coordinates and lifecycle metadata |
| `documentation/NEON_CHECK.ps1` | Windows-proven launcher: coordinate loading, menus, masked secret input, Docker `psql`, transport enforcement, preflight, and dispatch |
| `documentation/NEON_ACTION.sql` | SQL-only indexed `NA-*` read-only action catalogue |

`NEON_ACTION.sql` remains the canonical singular filename. Historical
`NEON_ACTIONS.sql` wording does not create another interface.

The former `documentation/models/` and duplicate legacy execution layers were
pruned after their proven behavior was promoted into this set. Git and J retain
the historical evidence; the live tree retains one executable owner.

## 3. Interface hierarchy and identifiers

The three indexes serve different altitudes:

| Index | Meaning |
| --- | --- |
| `GRM-*` | Human-facing concise invocation block in `GRIMOIRE_INDEX` |
| `GS-*` | Canonical expanded command/query in `G_SCRIPTS.md` |
| `NA-*` | SQL-only action block in `NEON_ACTION.sql` |

Example:

```text
GRM-NEON-04
→ G_SCRIPTS.md / GS-NEON-04
→ NEON_CHECK.ps1 -Action gate02-postflight
→ NEON_ACTION.sql / NA-03
```

Treat all IDs, coordinate keys, action names, role names, and paths as one
versioned interface. Reconcile every live reference in the same focused change
when one changes.

## 4. Coordinate and secret policy

`NS_COORDINATES.md` contains only the minimum non-secret values needed to
identify repository, Render, Auth0, Neon, hosted-contract, and migration
surfaces. It retains every coordinate from the original `NEON_CRED.md` and adds
explicit lifecycle, acquisition, and exposure guidance.

Repository-safe does not mean consequence-free. The direct Neon hostname,
database name, and role names cannot authenticate anyone, but together reveal
the development topology. They remain committed under the approved
mitigated-risk policy and should not be redistributed unnecessarily.

Never commit:

- passwords or complete database URLs;
- tokens, client secrets, API keys, private keys, cookies, or authorization
  headers;
- real user subjects or account/device/submission/event UUIDs;
- environment dumps, provider screenshots, or terminal transcripts containing
  excluded values.

Current private input surface:

```text
documentation/SECRET_INPUTS.md
```

It remains ignored and untracked. Reviewed commands do not parse it
automatically; secrets are requested only when an operation needs them.

## 5. First setup

1. Keep the five canonical files together under `documentation/`.
2. Fill only independently verified non-secret placeholders in
   `NS_COORDINATES.md`.
3. Keep provider secrets outside the repository.
4. Start Docker Desktop.
5. Open PowerShell in the repository root.
6. Run the read-only migrator connection proof:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action connection
```

The execution-policy bypass applies only to the child PowerShell process. If
organizational policy blocks it, use the locally approved signed-script route.

## 6. Runtime input model

The procedures fetch stable non-secret values automatically:

```text
repository branch
Render public origin and route paths
Auth0 issuer/audience/public metadata paths
Neon environment/branch/host/port/database
PostgreSQL major version
runtime/migrator/owner role names
TLS and channel-binding policy
API contract and migration coordinates
```

The terminal requests only values that must not be persisted or that identify
one exact local operation:

| Runtime input | Acquisition |
| --- | --- |
| Neon role | Fixed by command or selected from the guided menu |
| Neon role password | Masked `Read-Host -AsSecureString` prompt |
| Device UUID | Local prompt only for `verify-device` |
| Migration authorization | Exact `APPLY-ONCE` phrase after dashboard target confirmation |
| Auth0 access token | Session-only masked handling in a separately reviewed procedure; no active index command yet |

The launcher temporarily exposes a role password to the Docker child through
`PGPASSWORD`, removes the container after the command, zeroes the BSTR, and
clears PostgreSQL process variables in `finally`.

## 7. Neon launcher behavior

The launcher:

1. resolves `NS_COORDINATES.md` and `NEON_ACTION.sql` beside itself;
2. validates Docker availability;
3. selects or validates the role and action;
4. reads the unique coordinate keys;
5. locks execution to `Environment: development`;
6. requires the direct `ep-*.neon.tech` hostname;
7. requires PostgreSQL 18, TLS `require`, and channel binding `require`;
8. prompts for the selected role password;
9. authenticates through `postgres:18-alpine`;
10. proves exact PostgreSQL role and database identity;
11. executes one SQL action, shell, or separately authorized migration;
12. returns a `PASS` marker or a terminal failure.

The launcher displays the intended Neon branch alias but cannot independently
prove it from the PostgreSQL connection. Confirm the human-readable branch in
Neon before any mutation.

## 8. Role boundaries

| Role | Routine purpose | Must not become |
| --- | --- | --- |
| `runtime` | Hosted API identity and least-privilege checks | Migration identity |
| `migrator` | Migrations, ledger, catalogue, and provider inspection | Render runtime identity |
| `dbowner` | Explicit owner-only recovery | Default operational role |

Gate 02 and migration actions are locked to `migrator`.

## 9. SQL action architecture

`NEON_ACTION.sql` remains valid SQL. All explanations are SQL comments. Each
action uses both a human index and the parser contract:

```sql
-- NA-03 | GATE 02 POSTFLIGHT
-- ACTION: gate02-postflight
...
-- END ACTION
```

The launcher extracts only the selected `ACTION` block. Routine blocks begin
with `BEGIN TRANSACTION READ ONLY` and terminate with `ROLLBACK`.

To change the catalogue:

1. preserve the exact action markers;
2. return sanitized evidence only;
3. prefer a read-only transaction;
4. update the `NA-*` block index;
5. update PowerShell `ValidateSet` and `$Actions` only if an action name changes;
6. update its `GS-*` canonical procedure and `GRM-*` block;
7. test against the disposable development target.

## 10. Migration boundary

`apply-migration` accepts a path rather than embedding SQL. It verifies that
the migration:

- lives inside the current repository;
- is tracked by Git;
- has no uncommitted changes;
- has the expected `.sql` extension.

It then prints the resolved path and SHA-256, displays the selected non-secret
environment/branch/database coordinates, and requires the exact phrase
`APPLY-ONCE`.

Migration `007_account_cursor_provisioning` was applied once on 2026-07-23 and
passed postflight. Its command remains historical evidence in
`G_SCRIPTS.md` and is intentionally absent from `GRIMOIRE_INDEX`.

## 11. Gate 02 proven checkpoint

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

The `false` values are intended security boundaries. Gate 02 is closed;
migration 007 must not be reapplied.

## 12. Failure classifications

| Failure | Meaning / next move |
| --- | --- |
| Docker unavailable | Start Docker Desktop; no provider call occurred |
| Coordinate placeholder remains | Verify and fill only that non-secret value |
| Authentication rejected | Confirm selected role and current rotated password |
| Role/database mismatch | Stop; target coordinate or credential is wrong |
| TLS/channel binding mismatch | Stop; do not open a shell or mutate |
| PostgreSQL version mismatch | Stop; launcher proof is pinned to major 18 |
| Migration dirty/untracked | Restore an exact committed migration |
| Migration reports an error | Do not retry; inspect ledger/postflight read-only |
| Neon branch uncertainty | Stop and verify the dashboard branch |
| Render origin/branch mismatch | Stop before deployment or Sync |
| Auth0 metadata mismatch | Stop before using a token |
| Health response mismatch | Stop before authenticated requests |

## 13. Maintenance and validation rule

Search the active five-file interface after every change:

```powershell
rg "NS_COORDINATES|NEON_CHECK|NEON_ACTION|GRM-|GS-|NA-" `
  documentation\GRIMOIRE.md `
  documentation\G_SCRIPTS.md `
  documentation\NS_COORDINATES.md `
  documentation\NEON_CHECK.ps1 `
  documentation\NEON_ACTION.sql
```

Historical `NEON_CRED.md` references in J or Git history are observational
records; do not rewrite them as if the old filename had never existed.

---

<!-- LANDLINE: GRIMOIRE_INDEX -->

## GRIMOIRE_INDEX

Index policy:

- Every active block has one `GRM-*` ID and functionality name.
- Sub-header `01` names the canonical `GS-*` command/query and hosting path.
- Only the fenced **Copy-paste-ready body** is intended for machine input.
- Explanations, required variables, and expected results stay outside the body.
- Bodies contain no secret and no manually edited placeholder.
- Mutations already completed, including migration 007, are excluded.

### `GRM-NEON-00` — Guided Neon role/action selection

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-00`
- Hosting path: `documentation/G_SCRIPTS.md`
- Dispatcher: `documentation/NEON_CHECK.ps1`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md"
```

#### What this does

Loads non-secret coordinates, shows role and action menus, validates the
selected target, and dispatches one reviewed operation.

#### Variables required

Role number; action number; selected role password in the masked prompt; an
action-specific UUID or confirmation only when requested.

#### Expected output or result

Selected target summary, exact role/database preflight `PASS`, selected action
output, and final action `PASS`; otherwise a terminal error before continuation.

### `GRM-NEON-01` — Prove migrator connection

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-01`
- Hosting path: `documentation/G_SCRIPTS.md`
- SQL block: `documentation/NEON_ACTION.sql` → `NA-01`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action connection
```

#### What this does

Authenticates the migration identity against the configured development
database under required TLS/channel binding, then runs a read-only proof.

#### Variables required

Current `markei_migrator` password in the masked terminal prompt.

#### Expected output or result

`role=markei_migrator`, `database=markei_sync_dev`, TLS active,
`transaction_read_only=on`, `ROLLBACK`, and action `PASS`.

### `GRM-NEON-02` — Open migrator psql

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-02`
- Hosting path: `documentation/G_SCRIPTS.md`
- Dispatcher: `documentation/NEON_CHECK.ps1` → `shell`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action shell
```

#### What this does

Opens an interactive development `psql` session as the migration/inspection
role after transport and identity enforcement.

#### Variables required

Current `markei_migrator` password in the masked terminal prompt.

#### Expected output or result

Target summary, connection `PASS`, then a `psql` prompt. Exit with `\q`.

### `GRM-NEON-03` — Open runtime psql

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-03`
- Hosting path: `documentation/G_SCRIPTS.md`
- Dispatcher: `documentation/NEON_CHECK.ps1` → `shell`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role runtime `
  -Action shell
```

#### What this does

Opens an interactive development `psql` session using the least-privilege
hosted API identity.

#### Variables required

Current `markei_runtime` password in the masked terminal prompt.

#### Expected output or result

Target summary, `role=markei_runtime`, `database=markei_sync_dev`, TLS active,
then a `psql` prompt. Exit with `\q`.

### `GRM-NEON-04` — Verify Gate 02 postflight

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-04`
- Hosting path: `documentation/G_SCRIPTS.md`
- SQL block: `documentation/NEON_ACTION.sql` → `NA-03`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action gate02-postflight
```

#### What this does

Repeats the read-only migration-007, readiness, provisioning,
cursor-integrity, and runtime privilege proof without reapplying SQL.

#### Variables required

Current `markei_migrator` password in the masked terminal prompt.

#### Expected output or result

Migration 007/checksum present; readiness true; trigger count `1`;
missing/orphan counts `0`; intended runtime allow/deny shape; `ROLLBACK`; action
`PASS`.

### `GRM-NEON-05` — Inspect migration ledger

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-05`
- Hosting path: `documentation/G_SCRIPTS.md`
- SQL block: `documentation/NEON_ACTION.sql` → `NA-04`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action migration-ledger
```

#### What this does

Lists applied provider migrations inside a read-only transaction.

#### Variables required

Current `markei_migrator` password in the masked terminal prompt.

#### Expected output or result

Ordered migration rows including `007_account_cursor_provisioning`, followed
by `ROLLBACK` and action `PASS`.

### `GRM-NEON-06` — Inspect schema and RLS policies

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-06`
- Hosting path: `documentation/G_SCRIPTS.md`
- SQL block: `documentation/NEON_ACTION.sql` → `NA-06`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action schema-inventory
```

#### What this does

Lists public tables and RLS policy names without reading application payloads.

#### Variables required

Current `markei_migrator` password in the masked terminal prompt.

#### Expected output or result

Committed public table/policy inventory, `ROLLBACK`, and action `PASS`.

### `GRM-NEON-07` — Inspect runtime privileges

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-07`
- Hosting path: `documentation/G_SCRIPTS.md`
- SQL block: `documentation/NEON_ACTION.sql` → `NA-05`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action runtime-privileges
```

#### What this does

Returns runtime table grants and the public-schema USAGE/CREATE boundary.

#### Variables required

Current `markei_migrator` password in the masked terminal prompt.

#### Expected output or result

Intended table grants, schema `USAGE=true`, schema `CREATE=false`, `ROLLBACK`,
and action `PASS`.

### `GRM-NEON-08` — List devices without UUIDs

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-08`
- Hosting path: `documentation/G_SCRIPTS.md`
- SQL block: `documentation/NEON_ACTION.sql` → `NA-07`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action list-devices-sanitized
```

#### What this does

Groups devices by state and next expected sequence without returning identity
UUIDs.

#### Variables required

Current `markei_migrator` password in the masked terminal prompt.

#### Expected output or result

Sanitized status/sequence counts, `ROLLBACK`, and action `PASS`.

### `GRM-NEON-09` — Verify exact device counters

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-NEON-09`
- Hosting path: `documentation/G_SCRIPTS.md`
- SQL block: `documentation/NEON_ACTION.sql` → `NA-08`

#### Copy-paste-ready body

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action verify-device
```

#### What this does

Passes one locally entered UUID to the read-only device counter query and
returns submission/event/sequence evidence.

#### Variables required

Device UUID in the local prompt; current `markei_migrator` password in the
masked prompt.

#### Expected output or result

Sanitized submission count, sync-event count, next expected sequence,
`ROLLBACK`, and action `PASS`.

### `GRM-NEON-10` — Query runtime readiness-v2

#### 01 — Canonical command/query

- Canonical query: `G_SCRIPTS.md` → `GS-NEON-10`
- Hosting path: `documentation/G_SCRIPTS.md`
- Required host: runtime `psql` opened by `GRM-NEON-03`

#### Copy-paste-ready body

```sql
BEGIN TRANSACTION READ ONLY;
SELECT
    current_user AS connected_role,
    current_database() AS connected_database,
    public.markei_hosted_runtime_ready_v2() AS ready;
ROLLBACK;
```

#### What this does

Verifies that the least-privilege runtime identity can execute the hosted
readiness-v2 contract without persisting changes.

#### Variables required

No additional variable after the runtime `psql` session is open.

#### Expected output or result

`markei_runtime`, `markei_sync_dev`, `ready = t`, and `ROLLBACK`.

### `GRM-GIT-01` — Verify exact Git alignment

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-GIT-01`
- Hosting path: `documentation/G_SCRIPTS.md`
- Coordinate source: `documentation/NS_COORDINATES.md`

#### Copy-paste-ready body

```powershell
$Ns = Get-Content ".\documentation\NS_COORDINATES.md" -Raw
$Match = [regex]::Match($Ns, "(?m)^RepositoryBranch:\s*(.+?)\s*$")
if (-not $Match.Success -or $Match.Groups[1].Value.Trim() -match '^<') {
    throw "RepositoryBranch is missing or unresolved."
}
$Branch = $Match.Groups[1].Value.Trim()
if ((git branch --show-current) -ne $Branch) {
    throw "Current branch does not match NS_COORDINATES.md."
}
if (@(git status --porcelain).Count -ne 0) {
    throw "Working tree is not clean."
}
git fetch --prune origin
if ($LASTEXITCODE -ne 0) { throw "git fetch failed." }
$Local = (git rev-parse HEAD).Trim()
$Remote = (git rev-parse "origin/$Branch").Trim()
$Counts = ((git rev-list --left-right --count `
    "origin/$Branch...HEAD").Trim() -split '\s+')
if ($Local -ne $Remote -or $Counts[0] -ne "0" -or $Counts[1] -ne "0") {
    throw "Local and remote branch state diverged."
}
[pscustomobject]@{
    Branch = $Branch
    LocalHead = $Local
    RemoteHead = $Remote
    Behind = [int]$Counts[0]
    Ahead = [int]$Counts[1]
    Worktree = "clean"
}
```

#### What this does

Loads the expected branch from the coordinate file, requires a clean
worktree, fetches `origin`, and compares full local/remote SHAs and divergence.

#### Variables required

No manual variable; network access to `origin`.

#### Expected output or result

Expected branch, identical full SHAs, `Behind=0`, `Ahead=0`, and
`Worktree=clean`; otherwise a stop error.

### `GRM-HOST-01` — Verify Render live and ready

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-HOST-01`
- Hosting path: `documentation/G_SCRIPTS.md`
- Coordinate source: `documentation/NS_COORDINATES.md`

#### Copy-paste-ready body

```powershell
$ProcedureId = "GS-HOST-01"
$CataloguePath = Resolve-Path ".\documentation\G_SCRIPTS.md"
$Catalogue = Get-Content -LiteralPath $CataloguePath -Raw

$HeadingPattern = '(?ms)^### `' +
    [regex]::Escape($ProcedureId) +
    '`[^\r\n]*\r?\n(?<Section>.*?)(?=^### `GS-|\z)'
$SectionMatch = [regex]::Match($Catalogue, $HeadingPattern)

if (-not $SectionMatch.Success) {
    throw "Canonical procedure '$ProcedureId' was not found in $CataloguePath."
}

$FencePattern =
    '(?ms)^```powershell[ \t]*\r?\n(?<Code>.*?)^```[ \t]*\r?$'
$FenceMatch = [regex]::Match(
    $SectionMatch.Groups["Section"].Value,
    $FencePattern
)

if (-not $FenceMatch.Success) {
    throw "Canonical procedure '$ProcedureId' has no PowerShell body."
}

& ([scriptblock]::Create($FenceMatch.Groups["Code"].Value))
```

#### What this does

Loads the exact canonical `GS-HOST-01` fenced PowerShell body from
`G_SCRIPTS.md`, then runs it. That procedure loads the public Render origin and
health paths, performs two redirect-blocked HTTPS requests, parses the JSON
contract, and fails closed on disagreement. The index no longer duplicates the
canonical health-check implementation.

#### Variables required

No terminal input after verified Render coordinates replace their placeholders.

#### Expected output or result

`LiveStatus=200`, `LiveClass=live`, `ReadyStatus=200`,
`ReadyClass=ready`; otherwise a stop error before Sync.

### `GRM-AUTH-01` — Verify Auth0 public metadata

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-AUTH-01`
- Hosting path: `documentation/G_SCRIPTS.md`
- Coordinate source: `documentation/NS_COORDINATES.md`

#### Copy-paste-ready body

```powershell
$Ns = Get-Content ".\documentation\NS_COORDINATES.md" -Raw
function Read-NsValue([string]$Name) {
    $Match = [regex]::Match(
        $Ns,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success -or $Match.Groups[1].Value.Trim() -match '^<') {
        throw "'$Name' is missing or unresolved."
    }
    $Match.Groups[1].Value.Trim()
}
$Issuer = (Read-NsValue "Auth0Issuer").TrimEnd("/")
$Audience = Read-NsValue "Auth0Audience"
$Algorithm = Read-NsValue "Auth0Algorithm"
$DiscoveryPath = Read-NsValue "Auth0DiscoveryPath"
$JwksPath = Read-NsValue "Auth0JwksPath"
if (([uri]$Issuer).Scheme -ne "https") {
    throw "Auth0Issuer must use HTTPS."
}
$Discovery = Invoke-RestMethod -Method Get `
  -Uri "$Issuer$DiscoveryPath"
$Jwks = Invoke-RestMethod -Method Get -Uri "$Issuer$JwksPath"
$Matches = @($Jwks.keys | Where-Object {
    $_.kty -eq "RSA" -and $_.use -eq "sig" -and $_.alg -eq $Algorithm
})
if ($Discovery.issuer.TrimEnd("/") -ne $Issuer -or
    $Algorithm -ne "RS256" -or $Matches.Count -lt 1) {
    throw "Auth0 public metadata contract did not pass."
}
[pscustomobject]@{
    Issuer = $Issuer
    AudienceCoordinate = $Audience
    IssuerMatches = $true
    Algorithm = $Algorithm
    MatchingSigningKeys = $Matches.Count
}
```

#### What this does

Retrieves public OIDC discovery/JWKS metadata and confirms the configured
issuer plus at least one RSA signing key marked for RS256.

#### Variables required

No terminal input after verified Auth0 public coordinates replace placeholders.
No token or client secret is requested.

#### Expected output or result

Issuer match, configured audience coordinate, `Algorithm=RS256`, and at least
one matching signing key. This does not prove a real token was issued.

### `GRM-BUILD-01` — Validate Sync API

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-BUILD-01`
- Hosting path: `documentation/G_SCRIPTS.md`
- Package root: `services/markei_sync_api`

#### Copy-paste-ready body

```powershell
Push-Location ".\services\markei_sync_api"
try {
    npm ci --include=dev
    if ($LASTEXITCODE -ne 0) { throw "npm ci failed." }
    npm run format:check
    if ($LASTEXITCODE -ne 0) { throw "format:check failed." }
    npm run lint
    if ($LASTEXITCODE -ne 0) { throw "lint failed." }
    npm run typecheck
    if ($LASTEXITCODE -ne 0) { throw "typecheck failed." }
    npm test
    if ($LASTEXITCODE -ne 0) { throw "tests failed." }
    npm run build
    if ($LASTEXITCODE -ne 0) { throw "build failed." }
}
finally {
    Pop-Location
}
```

#### What this does

Installs the exact lockfile dependency tree, checks formatting/lint/types,
runs all API tests, and compiles the hosted service.

#### Variables required

No manual variable; Node.js 24 and npm registry access.

#### Expected output or result

Every command exits `0`; currently expected suite is 53 passing tests and zero
failures, followed by a successful TypeScript build.

### `GRM-BUILD-02` — Validate Flutter clients

#### 01 — Canonical command/query

- Canonical procedure: `G_SCRIPTS.md` → `GS-BUILD-02`
- Hosting path: `documentation/G_SCRIPTS.md`
- Project root: repository root

#### Copy-paste-ready body

```powershell
flutter pub get
if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed." }
flutter analyze
if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed." }
flutter test
if ($LASTEXITCODE -ne 0) { throw "flutter test failed." }
flutter build windows --release
if ($LASTEXITCODE -ne 0) { throw "Windows release build failed." }
flutter build apk --debug
if ($LASTEXITCODE -ne 0) { throw "Android debug build failed." }
```

#### What this does

Resolves Flutter dependencies, analyzes/tests the client, then builds Windows
release and Android debug artifacts.

#### Variables required

No manual variable; configured Flutter/Windows/Android toolchains.

#### Expected output or result

Dependency resolution, analysis, tests, Windows release build, and Android
debug build all exit `0`.
