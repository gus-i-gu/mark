# Markei General Scripts

> User-facing command index. Short commands dispatch to reviewed scripts.
> Repository: `gus-i-gu/markei`; branch: `intermid-cycle-recovery`.

## 0. Execution model

```text
User
→ minimal command copied from this file
→ proven implementation in models/NEON_CHECK.ps1 / models/NEON_ACTION.sql
→ masked credential or local coordinate request only when required
→ sanitized result
```

Keep these files together:

```text
GENERAL_SCRIPTS.md
GRIMOIRE.md
NEON_CRED.md
models/NEON_CHECK.ps1
models/NEON_ACTION.sql
models/NEON_CRED.md
```

The root `NEON_CHECK.ps1` and `NEON_ACTION.sql` are uploaded originals retained
for inspection. Active commands use the Windows-proven model launcher; the
root `NEON_CRED.md` supplies only non-secret coordinates.

Run commands from the repository root. The canonical Windows launcher form is
process-scoped and does not persistently alter PowerShell execution policy:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\models\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role <runtime|migrator|dbowner> `
  -Action <action>
```

## Pre-5 — Neon terminal and checks

Requirements: Windows PowerShell, Docker Desktop running, and PostgreSQL
`postgres:18-alpine` image access. Local `psql` is not required.

### Interactive terminal

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\models\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role migrator `
  -Action shell
```

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\models\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role runtime `
  -Action shell
```

The script reads the selected username from `NEON_CRED.md` and asks for its
password in a masked prompt. Exit psql with `\q`.

### Sanitized connection proof

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\models\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role migrator `
  -Action connection
```

### Gate 02 preflight action — retained read-only diagnostic

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\models\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role migrator `
  -Action gate02-preflight
```

Before migration 007, this action established:

- migration 006 exists with checksum
  `c10-s03a-r3-hosted-authorization-v1`;
- migration 007 is absent;
- readiness-v2 and provisioning objects are absent;
- the missing cursor-state count is recorded.

Gate 02 is now closed. If run again, the same read-only action should instead
show both migrations 006 and 007 plus the installed provisioning objects. Use
`gate02-postflight` for the authoritative current checkpoint.

### Applied migration 007 — historical command; do not rerun

Migration 007 was applied successfully on 2026-07-23 with SHA-256
`89AB11302F8B860C52AA1C74FBFEDF6A4DB3A0EE62FE7CB715B20B74AEF99AC6`.
The following command is retained only as append-oriented operational history:

Run from the repository root, adjusting only the helper path if these files are
stored elsewhere:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\models\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role migrator `
  -Action apply-migration `
  -MigrationPath ".\services\markei_sync_api\migrations\007_account_cursor_provisioning.sql"
```

Do not copy or execute this command during ordinary recovery. Use
`gate02-postflight` or `migration-ledger` for read-only verification.

### Gate 02 postflight

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\models\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role migrator `
  -Action gate02-postflight
```

Required:

- one migration-007 ledger row with checksum
  `c10-mcg02-account-cursor-provisioning-v1`;
- readiness-v2 is true;
- provisioning function exists and trigger count is `1`;
- missing and orphan cursor-state counts are `0`;
- runtime `SELECT=true`, `INSERT=false`, `DELETE=false`;
- runtime can update only `next_cursor`;
- runtime can execute readiness-v2 but not provisioning.

### Runtime readiness proof

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\models\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NEON_CRED.md" `
  -Role runtime `
  -Action shell
```

Then:

```sql
SELECT current_user, current_database(),
       public.markei_hosted_runtime_ready_v2() AS ready;
```

## 1. Other Neon actions

```powershell
.\NEON_CHECK.ps1 -Role migrator -Action migration-ledger
.\NEON_CHECK.ps1 -Role migrator -Action schema-inventory
.\NEON_CHECK.ps1 -Role migrator -Action runtime-privileges
.\NEON_CHECK.ps1 -Role migrator -Action list-devices-sanitized
.\NEON_CHECK.ps1 -Role migrator -Action verify-device
```

Running without arguments opens role and action menus:

```powershell
.\NEON_CHECK.ps1
```

## 2. Git alignment

```powershell
git fetch --prune origin
git status --short --branch
git rev-parse HEAD
git rev-parse origin/intermid-cycle-recovery
git rev-list --left-right --count origin/intermid-cycle-recovery...HEAD
```

`0 0` means local and remote agree. Record full SHAs. Stop on divergence or a
dirty overlap.

## 3. Render deployment checks

Before deployment:

- migration postflight passed;
- GitHub branch head is the authorized full SHA;
- Render watches the correct repository and branch;
- no deployment is active;
- auto-deploy state is known.

With auto-deploy off, trigger exactly one **Deploy latest commit** only after
confirming “latest” equals the authorized SHA.

Health check:

```powershell
$Origin = Read-Host "Render public origin"
$Origin = $Origin.TrimEnd("/")
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

## 4. Auth0 public checks

```powershell
$Issuer = (Read-Host "Auth0 issuer").TrimEnd("/")
$Discovery = Invoke-RestMethod "$Issuer/.well-known/openid-configuration"
$Jwks = Invoke-RestMethod "$Issuer/.well-known/jwks.json"
[pscustomobject]@{
  IssuerMatches = ($Discovery.issuer.TrimEnd("/") -eq $Issuer)
  JwksKeys = @($Jwks.keys).Count
  HasRs256Key = @($Jwks.keys | Where-Object {
    $_.kty -eq "RSA" -and $_.use -eq "sig" -and $_.alg -eq "RS256"
  }).Count -gt 0
}
```

This checks public metadata only. Never print access tokens or client secrets.

## 5. Build checks

Sync API:

```powershell
Push-Location services\markei_sync_api
npm ci --include=dev
npm run format:check
npm run lint
npm run typecheck
npm test
npm run build
Pop-Location
```

Flutter:

```powershell
flutter pub get
flutter analyze
flutter test
flutter build windows --release
flutter build apk --debug
```

## 6. Stop conditions

Stop before mutation if the target branch may be production, the role is not
`markei_migrator`, prerequisites/checksums disagree, migration 007 already
exists unexpectedly, the migration file is dirty, GitHub advanced, another
deployment is active, or any command would disclose a secret.

After an unclear migration result, run read-only postflight/ledger checks.
Never reconstruct or partially rerun the migration by hand.
