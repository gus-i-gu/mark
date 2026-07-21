[CmdletBinding()]
param(
    [ValidateSet("runtime", "migration")]
    [string]$Identity = "runtime",

    [ValidateSet("connect", "verify-device")]
    [string]$Action = "connect"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# EDIT ONLY THIS VALUE.
# Use only the hostname beginning with ep- and ending with .neon.tech.
$NeonHost = "ep-withered-bread-afszn7ua.c-2.us-west-2.aws.neon.tech"

$NeonDatabase = "markei"
$NeonPort = "5432"

if ($NeonHost -notmatch '^ep-[a-z0-9.-]+\.neon\.tech$') {
    throw @"
NeonHost is invalid.

It must look like:
ep-example.c-2.us-west-2.aws.neon.tech

Do not include:
postgresql://
username
password
@
/markei
?sslmode
"@
}

if ($Identity -eq "runtime") {
    $Role = "markei_runtime"
}
else {
    $Role = "markei_migrator"
}

if ($Action -eq "verify-device" -and $Identity -ne "migration") {
    throw "verify-device requires -Identity migration for read-only inspection."
}

$DeviceId = $null
if ($Action -eq "verify-device") {
    $DeviceId = (Read-Host "Device A UUID (input remains local)").Trim()
    $ParsedDeviceId = [guid]::Empty

    if (-not [guid]::TryParse($DeviceId, [ref]$ParsedDeviceId)) {
        throw "Device A UUID is invalid."
    }

    $DeviceId = $ParsedDeviceId.ToString()
}

$Credential = Get-Credential `
    -UserName $Role `
    -Message "Enter the current Neon password for $Role"

if ($Credential.UserName -ne $Role) {
    throw "Expected username $Role."
}

try {
    $env:PGHOST = $NeonHost
    $env:PGPORT = $NeonPort
    $env:PGDATABASE = $NeonDatabase
    $env:PGUSER = $Role
    $env:PGPASSWORD = $Credential.GetNetworkCredential().Password
    $env:PGSSLMODE = "require"
    $env:PGCHANNELBINDING = "require"

    $PsqlArguments = @(
        "-X"
        "-v"
        "ON_ERROR_STOP=1"
    )

    if ($Action -eq "connect") {
        $PsqlArguments += @(
            "-c"
            "SELECT current_user, current_database();"
        )
    }
    else {
        $VerificationSql = @"
BEGIN TRANSACTION READ ONLY;
SELECT count(*) AS submission_count
FROM submissions
WHERE device_id = :'device_id'::uuid;
SELECT count(*) AS sync_event_count
FROM sync_events
WHERE device_id = :'device_id'::uuid;
SELECT next_expected_sequence AS device_next_expected_sequence
FROM devices
WHERE device_id = :'device_id'::uuid;
ROLLBACK;
"@

        $PsqlArguments += @(
            "-c"
            ($VerificationSql -replace ":'device_id'", "'$DeviceId'")
        )
    }

    docker run --rm `
        --env PGHOST `
        --env PGPORT `
        --env PGDATABASE `
        --env PGUSER `
        --env PGPASSWORD `
        --env PGSSLMODE `
        --env PGCHANNELBINDING `
        postgres:18-alpine `
        psql @PsqlArguments

    if ($LASTEXITCODE -ne 0) {
        throw "Neon $Action failed."
    }

    Write-Host ""
    Write-Host "PASS: Neon $Action completed as $Role on $NeonDatabase." `
        -ForegroundColor Green
}
finally {
    Remove-Item Env:PGHOST -ErrorAction SilentlyContinue
    Remove-Item Env:PGPORT -ErrorAction SilentlyContinue
    Remove-Item Env:PGDATABASE -ErrorAction SilentlyContinue
    Remove-Item Env:PGUSER -ErrorAction SilentlyContinue
    Remove-Item Env:PGPASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:PGSSLMODE -ErrorAction SilentlyContinue
    Remove-Item Env:PGCHANNELBINDING -ErrorAction SilentlyContinue

    $Credential = $null
    $DeviceId = $null
    $ParsedDeviceId = $null
    $VerificationSql = $null
    $PsqlArguments = $null
}
