$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

$version = python -c "from app.core.config import VERSION; print(VERSION)"
$runtime = "dist\Markei"

if (-not (Test-Path "$runtime\Markei.exe")) {
    throw "Missing frozen executable: $runtime\Markei.exe"
}

if (-not (Test-Path "$runtime\_internal\app\database\schema.sql")) {
    throw "Missing bundled schema resource."
}

$forbidden = Get-ChildItem -Path $runtime -Recurse -File |
    Where-Object {
        $_.Name -eq "seed.sql" -or
        $_.Name -eq "market.sqlite" -or
        $_.Extension -in ".sqlite", ".sqlite-wal", ".sqlite-shm"
    }

if ($forbidden) {
    $forbidden.FullName | ForEach-Object { Write-Error "Forbidden payload: $_" }
    throw "Runtime payload contains seed or mutable SQLite state."
}

if (Test-Path "dist\installer") {
    $installer = "dist\installer\Markei-Setup-$version.exe"
    if (-not (Test-Path $installer)) {
        throw "Installer directory exists, but expected $installer was not found."
    }
}

Write-Host "Package validation checks passed for Markei $version."
