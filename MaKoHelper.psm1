#Requires -PSEdition Desktop 

Set-StrictMode -Version 2.0

$verbosePreference = "SilentlyContinue"
$warningPreference = 'Continue'
$errorActionPreference = 'Stop'

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdministrator = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
try {
    $myUsername = $currentPrincipal.Identity.Name
} catch {
    $myUsername = (whoami)
}


# Docker Functions
. (Join-Path $PSScriptRoot ".\Docker\Switch-DockerServices.ps1")


# Powershell Functions
. (Join-Path $PSScriptRoot ".\PowershellModule\Get-DuplicatedModules.ps1")
. (Join-Path $PSScriptRoot ".\PowershellModule\Remove-DuplicatedModules.ps1")
