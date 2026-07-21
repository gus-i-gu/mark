param(
  [Parameter(Mandatory = $true)]
  [string] $ExecutablePath
)

$ErrorActionPreference = 'Stop'

$resolvedExecutable = (Resolve-Path -LiteralPath $ExecutablePath).Path
$protocolRoot = 'HKCU:\Software\Classes\auth0flutter'
$commandPath = Join-Path $protocolRoot 'shell\open\command'
$quotedCommand = '"{0}" "%1"' -f ($resolvedExecutable -replace '"', '\"')

New-Item -Path $protocolRoot -Force | Out-Null
Set-Item -Path $protocolRoot -Value 'URL:auth0flutter'
New-ItemProperty -Path $protocolRoot -Name 'URL Protocol' -Value '' -PropertyType String -Force | Out-Null
New-Item -Path $commandPath -Force | Out-Null
Set-Item -Path $commandPath -Value $quotedCommand

Write-Output 'auth0flutter protocol registered for current user'
