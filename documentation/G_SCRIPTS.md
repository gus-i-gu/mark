# Markei General Scripts

> Canonical executable catalogue for the human-supervised GRIMOIRE interface.
> Repository: `gus-i-gu/markei`; branch: `cycle10-intermid-grimoire`.

## 0. Execution contract

```text
GRIMOIRE_INDEX block
→ canonical GS-* procedure in this file
→ NS_COORDINATES.md supplies non-secret values
→ terminal requests only the remaining role/UUID/secret input
→ reviewed PowerShell or SQL performs the operation
→ sanitized result returns to the operator
```

Keep this active five-file set together:

```text
documentation/GRIMOIRE.md
documentation/GENERAL_SCRIPTS.md
documentation/NS_COORDINATES.md
documentation/NEON_CHECK.ps1
documentation/NEON_ACTION.sql
```

Run PowerShell commands from the repository root. Copy only complete fenced
code bodies. Do not replace values already supplied by `NS_COORDINATES.md`.

The canonical Neon launcher form is process-scoped and does not permanently
alter PowerShell execution policy:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role <runtime|migrator|dbowner> `
  -Action <action>
```

Passwords are requested through `Read-Host -AsSecureString`, converted only
for the current process/container call, and cleared in `finally`.

## 1. Neon terminal and read-only actions

Requirements: Windows PowerShell, Docker Desktop running, access to the
`postgres:18-alpine` image, and verified non-secret Neon coordinates. Local
`psql` is not required.

### `GS-NEON-00` — Guided role/action launcher

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md"
```

The terminal requests the role number, action number, and selected role
password. An action-specific UUID or confirmation is requested only when
required.

### `GS-NEON-01` — Migrator connection proof

Canonical SQL block: `NEON_ACTION.sql` → `NA-01` / `connection`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action connection
```

### `GS-NEON-02` — Open migrator psql

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action shell
```

Exit `psql` with `\q`.

### `GS-NEON-03` — Open runtime psql

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role runtime `
  -Action shell
```

Exit `psql` with `\q`.

### `GS-NEON-04` — Gate 02 postflight

Canonical SQL block: `NEON_ACTION.sql` → `NA-03` /
`gate02-postflight`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action gate02-postflight
```

Required current result:

- migration `007_account_cursor_provisioning` exists with checksum
  `c10-mcg02-account-cursor-provisioning-v1`;
- readiness-v2 is true;
- provisioning function exists and trigger count is `1`;
- missing/orphan cursor-state counts are `0`;
- runtime `SELECT=true`, `INSERT=false`, `DELETE=false`;
- runtime can update only `next_cursor`;
- runtime can execute readiness-v2 but not provisioning;
- transaction ends with `ROLLBACK`; action ends with `PASS`.

### `GS-NEON-05` — Migration ledger

Canonical SQL block: `NEON_ACTION.sql` → `NA-04` /
`migration-ledger`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action migration-ledger
```

### `GS-NEON-06` — Schema and RLS inventory

Canonical SQL block: `NEON_ACTION.sql` → `NA-06` /
`schema-inventory`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action schema-inventory
```

### `GS-NEON-07` — Runtime privilege inventory

Canonical SQL block: `NEON_ACTION.sql` → `NA-05` /
`runtime-privileges`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action runtime-privileges
```

### `GS-NEON-08` — Sanitized device inventory

Canonical SQL block: `NEON_ACTION.sql` → `NA-07` /
`list-devices-sanitized`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action list-devices-sanitized
```

### `GS-NEON-09` — Verify one device's counters

Canonical SQL block: `NEON_ACTION.sql` → `NA-08` / `verify-device`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action verify-device
```

The terminal requests the device UUID locally. It is passed as a `psql`
variable, not written to any repository file.

### `GS-NEON-10` — Runtime readiness-v2 query

Run only inside the runtime `psql` opened by `GS-NEON-03`:

```sql
BEGIN TRANSACTION READ ONLY;
SELECT
    current_user AS connected_role,
    current_database() AS connected_database,
    public.markei_hosted_runtime_ready_v2() AS ready;
ROLLBACK;
```

Expected: `markei_runtime`, `markei_sync_dev`, `ready = t`, and `ROLLBACK`.

## 2. Git alignment

### `GS-GIT-01` — Verify exact branch/remote alignment

This procedure reads `RepositoryBranch` from `NS_COORDINATES.md`, requires a
clean worktree, and stops on branch or SHA divergence.

```powershell
$NsPath = Resolve-Path ".\documentation\NS_COORDINATES.md"
$NsText = Get-Content -LiteralPath $NsPath -Raw

function Get-NsCoordinate {
    param([Parameter(Mandatory)] [string]$Name)
    $Match = [regex]::Match(
        $NsText,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success) {
        throw "Missing '$Name' in $NsPath."
    }
    $Value = $Match.Groups[1].Value.Trim()
    if ($Value -match '^<[^>]+>$') {
        throw "Replace the '$Name' placeholder in $NsPath."
    }
    return $Value
}

$ExpectedBranch = Get-NsCoordinate "RepositoryBranch"
$CurrentBranch = (& git branch --show-current).Trim()
if ($LASTEXITCODE -ne 0 -or $CurrentBranch -ne $ExpectedBranch) {
    throw "Expected branch '$ExpectedBranch'; found '$CurrentBranch'."
}

$Dirty = @(& git status --porcelain)
if ($LASTEXITCODE -ne 0 -or $Dirty.Count -ne 0) {
    throw "Working tree is not clean."
}

& git fetch --prune origin
if ($LASTEXITCODE -ne 0) {
    throw "git fetch failed."
}

$LocalSha = (& git rev-parse HEAD).Trim()
$RemoteSha = (& git rev-parse "origin/$ExpectedBranch").Trim()
$Divergence = ((& git rev-list --left-right --count `
    "origin/$ExpectedBranch...HEAD").Trim() -split '\s+')

if ($LASTEXITCODE -ne 0 -or
    $Divergence.Count -ne 2 -or
    $Divergence[0] -ne "0" -or
    $Divergence[1] -ne "0" -or
    $LocalSha -ne $RemoteSha) {
    throw "Local and remote branch state diverged."
}

[pscustomobject]@{
    Branch = $CurrentBranch
    LocalHead = $LocalSha
    RemoteHead = $RemoteSha
    Behind = [int]$Divergence[0]
    Ahead = [int]$Divergence[1]
    Worktree = "clean"
}
```

## 3. Render public health

### `GS-HOST-01` — Verify live and ready contracts

This procedure reads the public origin and route paths from
`NS_COORDINATES.md`. It rejects placeholders, non-HTTPS origins, embedded
credentials, query strings, fragments, redirects, non-200 responses, and
unexpected response classes.

```powershell
$NsPath = Resolve-Path ".\documentation\NS_COORDINATES.md"
$NsText = Get-Content -LiteralPath $NsPath -Raw

function Get-NsCoordinate {
    param([Parameter(Mandatory)] [string]$Name)
    $Match = [regex]::Match(
        $NsText,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success) {
        throw "Missing '$Name' in $NsPath."
    }
    $Value = $Match.Groups[1].Value.Trim()
    if ($Value -match '^<[^>]+>$') {
        throw "Replace the '$Name' placeholder in $NsPath."
    }
    return $Value
}

$Origin = (Get-NsCoordinate "RenderPublicOrigin").TrimEnd("/")
$LivePath = Get-NsCoordinate "RenderLivePath"
$ReadyPath = Get-NsCoordinate "RenderReadyPath"

$OriginUri = $null
if (-not [uri]::TryCreate(
        $Origin,
        [UriKind]::Absolute,
        [ref]$OriginUri
    ) -or
    $OriginUri.Scheme -ne "https" -or
    -not [string]::IsNullOrEmpty($OriginUri.UserInfo) -or
    -not [string]::IsNullOrEmpty($OriginUri.Query) -or
    -not [string]::IsNullOrEmpty($OriginUri.Fragment)) {
    throw "RenderPublicOrigin must be a secret-free HTTPS origin."
}

$OriginBase = [uri]($Origin + "/")
$LiveUri = [uri]::new(
    $OriginBase,
    $LivePath.TrimStart([char]"/")
).AbsoluteUri
$ReadyUri = [uri]::new(
    $OriginBase,
    $ReadyPath.TrimStart([char]"/")
).AbsoluteUri

$LiveResponse = Invoke-WebRequest `
    -UseBasicParsing `
    -Uri $LiveUri `
    -Method Get `
    -MaximumRedirection 0
$ReadyResponse = Invoke-WebRequest `
    -UseBasicParsing `
    -Uri $ReadyUri `
    -Method Get `
    -MaximumRedirection 0

$LiveBody = $LiveResponse.Content | ConvertFrom-Json
$ReadyBody = $ReadyResponse.Content | ConvertFrom-Json
if ([int]$LiveResponse.StatusCode -ne 200 -or
    [int]$ReadyResponse.StatusCode -ne 200 -or
    $LiveBody.status -ne "live" -or
    $ReadyBody.status -ne "ready") {
    throw "Hosted health contract did not pass."
}

[pscustomobject]@{
    Origin = $Origin
    LiveStatus = [int]$LiveResponse.StatusCode
    LiveClass = $LiveBody.status
    ReadyStatus = [int]$ReadyResponse.StatusCode
    ReadyClass = $ReadyBody.status
}
```

## 4. Auth0 public metadata

### `GS-AUTH-01` — Verify OIDC discovery and RS256 JWKS

This procedure reads only public Auth0 coordinates. It never requests or
prints an access token or client secret.

```powershell
$NsPath = Resolve-Path ".\documentation\NS_COORDINATES.md"
$NsText = Get-Content -LiteralPath $NsPath -Raw

function Get-NsCoordinate {
    param([Parameter(Mandatory)] [string]$Name)
    $Match = [regex]::Match(
        $NsText,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success) {
        throw "Missing '$Name' in $NsPath."
    }
    $Value = $Match.Groups[1].Value.Trim()
    if ($Value -match '^<[^>]+>$') {
        throw "Replace the '$Name' placeholder in $NsPath."
    }
    return $Value
}

$Issuer = (Get-NsCoordinate "Auth0Issuer").TrimEnd("/")
$Audience = Get-NsCoordinate "Auth0Audience"
$Algorithm = Get-NsCoordinate "Auth0Algorithm"
$DiscoveryPath = Get-NsCoordinate "Auth0DiscoveryPath"
$JwksPath = Get-NsCoordinate "Auth0JwksPath"

$IssuerUri = $null
if (-not [uri]::TryCreate(
        $Issuer,
        [UriKind]::Absolute,
        [ref]$IssuerUri
    ) -or
    $IssuerUri.Scheme -ne "https" -or
    -not [string]::IsNullOrEmpty($IssuerUri.UserInfo) -or
    -not [string]::IsNullOrEmpty($IssuerUri.Query) -or
    -not [string]::IsNullOrEmpty($IssuerUri.Fragment)) {
    throw "Auth0Issuer must be a secret-free HTTPS URL."
}

$IssuerBase = [uri]($Issuer + "/")
$DiscoveryUri = [uri]::new(
    $IssuerBase,
    $DiscoveryPath.TrimStart([char]"/")
).AbsoluteUri
$JwksUri = [uri]::new(
    $IssuerBase,
    $JwksPath.TrimStart([char]"/")
).AbsoluteUri

$Discovery = Invoke-RestMethod -Method Get -Uri $DiscoveryUri
$Jwks = Invoke-RestMethod -Method Get -Uri $JwksUri

$IssuerMatches = (
    $Discovery.issuer.TrimEnd("/") -eq $Issuer
)
$DiscoveryJwksMatches = (
    $Discovery.jwks_uri.TrimEnd("/") -eq $JwksUri.TrimEnd("/")
)
$MatchingKeys = @($Jwks.keys | Where-Object {
    $_.kty -eq "RSA" -and
    $_.use -eq "sig" -and
    $_.alg -eq $Algorithm
})

if (-not $IssuerMatches -or
    -not $DiscoveryJwksMatches -or
    $Algorithm -ne "RS256" -or
    $MatchingKeys.Count -lt 1) {
    throw "Auth0 public metadata contract did not pass."
}

[pscustomobject]@{
    Issuer = $Issuer
    AudienceCoordinate = $Audience
    IssuerMatches = $IssuerMatches
    DiscoveryJwksMatches = $DiscoveryJwksMatches
    Algorithm = $Algorithm
    MatchingSigningKeys = $MatchingKeys.Count
}
```

This verifies public provider metadata and the configured audience coordinate.
It does not prove that a real token was issued for that audience.

## 5. Build and regression checks

### `GS-BUILD-01` — Sync API validation

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

### `GS-BUILD-02` — Flutter validation

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

## 6. Historical diagnostics and mutation record

These procedures are retained for traceability and are excluded from the
active `GRIMOIRE_INDEX`.

### `GS-NEON-H01` — Gate 02 preflight diagnostic

Canonical SQL block: `NEON_ACTION.sql` → `NA-02` /
`gate02-preflight`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action gate02-preflight
```

Gate 02 is closed; current inspection should use `GS-NEON-04`.

### `GS-MIG-H01` — Migration 007 apply command; do not rerun

Migration 007 was applied successfully on 2026-07-23 with file SHA-256:

```text
89AB11302F8B860C52AA1C74FBFEDF6A4DB3A0EE62FE7CB715B20B74AEF99AC6
```

The command below is append-oriented evidence only:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action apply-migration `
  -MigrationPath ".\services\markei_sync_api\migrations\007_account_cursor_provisioning.sql"
```

Do not copy or execute it during ordinary recovery. Use `GS-NEON-04` or
`GS-NEON-05` for read-only verification.

## 7. Stop conditions

Stop before mutation if:

- the target branch may be production;
- the selected identity is not the intended role;
- any non-secret coordinate remains unknown or disagrees with its provider;
- a password, token, complete connection URL, or real identity UUID would be
  written to Git, chat, Markdown, SQL, screenshots, or shell history;
- migration prerequisites or checksums disagree;
- migration 007 is already present or its outcome is uncertain;
- the migration file is dirty or untracked;
- GitHub advanced, the local/remote SHAs diverge, or the worktree overlaps;
- another deployment is active or the watched Render branch is uncertain;
- a health, readiness, identity, or provider baseline differs from the
  procedure's expected boundary.

After an unclear migration result, use only read-only postflight and ledger
checks. Never reconstruct or partially rerun a migration by hand.
