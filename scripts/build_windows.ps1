$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

if (-not (Test-Path "main.py")) {
    throw "Run this script from the Markei repository checkout."
}

$version = python -c "from app.core.config import VERSION; print(VERSION)"

python -m PyInstaller --noconfirm --clean packaging\markei.spec

if (-not (Test-Path "dist\Markei\Markei.exe")) {
    throw "PyInstaller did not produce dist\Markei\Markei.exe."
}

if (-not (Test-Path "dist\Markei\_internal\app\database\schema.sql")) {
    throw "Bundled schema.sql was not found in the frozen runtime."
}

$forbidden = Get-ChildItem -Path "dist\Markei" -Recurse -File |
    Where-Object {
        $_.Name -eq "seed.sql" -or
        $_.Name -eq "market.sqlite" -or
        $_.Extension -in ".sqlite", ".sqlite-wal", ".sqlite-shm"
    }

if ($forbidden) {
    $forbidden.FullName | ForEach-Object { Write-Error "Forbidden runtime payload: $_" }
    throw "Frozen runtime contains development seed or mutable SQLite state."
}

$iscc = Get-Command ISCC.exe -ErrorAction SilentlyContinue

if ($iscc) {
    & $iscc.Source "/DMyAppVersion=$version" "packaging\windows\markei.iss"

    $installer = "dist\installer\Markei-Setup-$version.exe"
    if (-not (Test-Path $installer)) {
        throw "Inno Setup did not produce $installer."
    }
} else {
    Write-Warning "ISCC.exe was not found. PyInstaller build completed; installer compilation skipped."
}
