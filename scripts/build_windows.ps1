param(
    [switch]$Windowed
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

if (-not (Test-Path "main.py")) {
    throw "Run this script from the Markei repository checkout."
}

$arguments = @(
    "-m", "PyInstaller",
    "--clean",
    "--noconfirm",
    "--name", "Markei",
    "--onedir",
    "--add-data", "app/database/schema.sql;app/database",
    "--add-data", "app/database/seed.sql;app/database"
)

if ($Windowed) {
    $arguments += "--windowed"
}

$arguments += "main.py"

python @arguments
