[CmdletBinding()]
param(
    [ValidateSet("runtime", "migrator", "dbowner")]
    [string]$Role,

    [ValidateSet(
        "connection",
        "verify-device",
        "list-devices-sanitized",
        "migration-ledger",
        "runtime-privileges",
        "schema-inventory",
        "shell"
    )]
    [string]$Action,

    [string]$ConfigPath = (Join-Path $PSScriptRoot "NEON_CRED.md"),
    [string]$ActionPath = (Join-Path $PSScriptRoot "NEON_ACTION.sql")
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Select-Value {
    param(
        [Parameter(Mandatory)] [string]$Prompt,
        [Parameter(Mandatory)] [string[]]$Values
    )

    for ($Index = 0; $Index -lt $Values.Count; $Index++) {
        Write-Host ("[{0}] {1}" -f ($Index + 1), $Values[$Index])
    }

    $Selection = Read-Host $Prompt
    $Number = 0
    if (-not [int]::TryParse($Selection, [ref]$Number) -or
        $Number -lt 1 -or $Number -gt $Values.Count) {
        throw "Invalid selection."
    }

    return $Values[$Number - 1]
}

function Read-ConfigValue {
    param(
        [Parameter(Mandatory)] [string]$Content,
        [Parameter(Mandatory)] [string]$Name
    )

    $Match = [regex]::Match(
        $Content,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success) {
        throw "Missing '$Name' in $ConfigPath."
    }

    $Value = $Match.Groups[1].Value.Trim()
    if ($Value.StartsWith("<") -or $Value.EndsWith(">")) {
        throw "Replace the placeholder for '$Name' in $ConfigPath."
    }
    return $Value
}

function Get-ActionSql {
    param(
        [Parameter(Mandatory)] [string]$Content,
        [Parameter(Mandatory)] [string]$Name
    )

    $Pattern = "(?ms)^-- ACTION: $([regex]::Escape($Name))\s*\r?\n" +
        "(.*?)^-- END ACTION\s*$"
    $Match = [regex]::Match($Content, $Pattern)
    if (-not $Match.Success) {
        throw "Action '$Name' is missing from $ActionPath."
    }
    return $Match.Groups[1].Value.Trim()
}

if (-not (Test-Path -LiteralPath $ConfigPath -PathType Leaf)) {
    throw "Configuration file not found: $ConfigPath"
}
if (-not (Test-Path -LiteralPath $ActionPath -PathType Leaf)) {
    throw "Action catalogue not found: $ActionPath"
}

if ([string]::IsNullOrWhiteSpace($Role)) {
    Write-Host "Select Neon role:"
    $Role = Select-Value -Prompt "Role number" -Values @(
        "runtime", "migrator", "dbowner"
    )
}

$Actions = @(
    "connection",
    "verify-device",
    "list-devices-sanitized",
    "migration-ledger",
    "runtime-privileges",
    "schema-inventory",
    "shell"
)
if ([string]::IsNullOrWhiteSpace($Action)) {
    Write-Host "Select action:"
    $Action = Select-Value -Prompt "Action number" -Values $Actions
}

$ConfigContent = Get-Content -LiteralPath $ConfigPath -Raw
$NeonHost = Read-ConfigValue -Content $ConfigContent -Name "Host"
$NeonPort = Read-ConfigValue -Content $ConfigContent -Name "Port"
$NeonDatabase = Read-ConfigValue -Content $ConfigContent -Name "Database"

$RoleKey = switch ($Role) {
    "runtime" { "RuntimeUser" }
    "migrator" { "MigratorUser" }
    "dbowner" { "DbOwnerUser" }
}
$DatabaseUser = Read-ConfigValue -Content $ConfigContent -Name $RoleKey

if ($NeonHost -notmatch '^ep-[a-z0-9.-]+\.neon\.tech$') {
    throw "Host must contain only the direct ep-*.neon.tech hostname."
}
if ($NeonPort -notmatch '^\d{1,5}$') {
    throw "Port must be numeric."
}
if ($NeonDatabase -notmatch '^[A-Za-z_][A-Za-z0-9_-]*$') {
    throw "Database name contains unexpected characters."
}
if ($DatabaseUser -notmatch '^[A-Za-z_][A-Za-z0-9_-]*$') {
    throw "Role username contains unexpected characters."
}

if ($Action -eq "verify-device" -and $Role -eq "runtime") {
    throw "verify-device requires migrator or dbowner inspection access."
}

$DeviceInput = $null
$DeviceId = $null
$ParsedDeviceId = $null
$Sql = $null
$PsqlVariables = @()
if ($Action -eq "verify-device") {
    $DeviceInput = (Read-Host "Device A UUID (kept local)").Trim()
    $ParsedDeviceId = [guid]::Empty
    if (-not [guid]::TryParse($DeviceInput, [ref]$ParsedDeviceId)) {
        throw "Device UUID is invalid."
    }
    $DeviceId = $ParsedDeviceId.ToString()
    $PsqlVariables = @("-v", "device_id=$DeviceId")
}

$Credential = Get-Credential -UserName $DatabaseUser `
    -Message "Enter the current Neon password for $DatabaseUser"
if ($Credential.UserName -ne $DatabaseUser) {
    throw "Expected username $DatabaseUser."
}

try {
    $env:PGHOST = $NeonHost
    $env:PGPORT = $NeonPort
    $env:PGDATABASE = $NeonDatabase
    $env:PGUSER = $DatabaseUser
    $env:PGPASSWORD = $Credential.GetNetworkCredential().Password
    $env:PGSSLMODE = "require"
    $env:PGCHANNELBINDING = "require"

    $DockerArguments = @(
        "run", "--rm", "-i",
        "--env", "PGHOST",
        "--env", "PGPORT",
        "--env", "PGDATABASE",
        "--env", "PGUSER",
        "--env", "PGPASSWORD",
        "--env", "PGSSLMODE",
        "--env", "PGCHANNELBINDING",
        "postgres:18-alpine",
        "psql", "-X", "-v", "ON_ERROR_STOP=1"
    )

    if ($Action -eq "shell") {
        Write-Host "Opening psql as $DatabaseUser. Use \q to exit."
        & docker @DockerArguments
    }
    else {
        $ActionContent = Get-Content -LiteralPath $ActionPath -Raw
        $Sql = Get-ActionSql -Content $ActionContent -Name $Action
        $Sql | & docker @DockerArguments @PsqlVariables
    }

    if ($LASTEXITCODE -ne 0) {
        throw "Neon action '$Action' failed."
    }

    Write-Host "PASS: '$Action' completed as $DatabaseUser on $NeonDatabase." `
        -ForegroundColor Green
}
finally {
    @(
        "PGHOST", "PGPORT", "PGDATABASE", "PGUSER", "PGPASSWORD",
        "PGSSLMODE", "PGCHANNELBINDING"
    ) | ForEach-Object {
        Remove-Item "Env:$_" -ErrorAction SilentlyContinue
    }

    $Credential = $null
    $DeviceInput = $null
    $DeviceId = $null
    $ParsedDeviceId = $null
    $Sql = $null
    $PsqlVariables = $null
}
