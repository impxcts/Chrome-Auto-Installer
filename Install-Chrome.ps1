<#
.SYNOPSIS
    Downloads and silently installs Google Chrome (64-bit) on Windows.

.DESCRIPTION
    Intended for use on a freshly imaged / first-boot PC. Requires an active
    internet connection and admin rights (for a machine-wide install).

.NOTES
    Run from an elevated PowerShell prompt:
        powershell.exe -ExecutionPolicy Bypass -File .\Install-Chrome.ps1
#>

# Require admin rights for a machine-wide install
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator. Right-click PowerShell and choose 'Run as administrator'."
    exit 1
}

$ErrorActionPreference = "Stop"

$installerUrl  = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B2A8A2D50-6BC1-4F1D-9E90-8B5B0F4C1234%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue/chrome/install/ChromeStandaloneSetup64.exe"
$installerPath = Join-Path $env:TEMP "ChromeStandaloneSetup64.exe"

Write-Host "Downloading Google Chrome installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -UseBasicParsing

Write-Host "Installing Google Chrome silently..."
$process = Start-Process -FilePath $installerPath -ArgumentList "/silent", "/install" -Wait -PassThru

if ($process.ExitCode -eq 0) {
    Write-Host "Google Chrome installed successfully."
} else {
    Write-Warning "Installer exited with code $($process.ExitCode)."
}

# Clean up the installer
Remove-Item $installerPath -Force -ErrorAction SilentlyContinue

# Launch Chrome once installed
$chromePaths = @(
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)
$chromeExe = $chromePaths | Where-Object { Test-Path $_ } | Select-Object -First 1

if ($chromeExe) {
    Write-Host "Launching Google Chrome..."
    Start-Process -FilePath $chromeExe
} else {
    Write-Warning "Could not locate chrome.exe to launch it automatically."
}
