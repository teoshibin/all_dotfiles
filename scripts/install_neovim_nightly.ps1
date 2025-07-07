#Requires -Version 5.1
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

# Configuration
$nvimPath = "$env:USERPROFILE\nvim-nightly"
$downloadUrl = "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip"
$zipPath = "$env:TEMP\nvim-nightly.zip"
$extractPath = "$env:TEMP\nvim-extract"

Write-Host "`nNeovim Nightly Installer" -ForegroundColor Cyan
Write-Host "========================`n" -ForegroundColor Cyan

# Remove existing installation
if (Test-Path $nvimPath) {
    Write-Host "Removing existing installation..." -ForegroundColor Yellow
    try {
        Remove-Item -Path $nvimPath -Recurse -Force -ErrorAction Stop
    } catch {
        Write-Host "Failed to remove existing installation: $_" -ForegroundColor Red
        exit 1
    }
}

# Download
Write-Host "Downloading Neovim nightly..." -ForegroundColor Green
try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -UseBasicParsing
    $ProgressPreference = 'Continue'
} catch {
    Write-Host "Download failed: $_" -ForegroundColor Red
    exit 1
}

# Verify download
if (-not (Test-Path $zipPath) -or (Get-Item $zipPath).Length -eq 0) {
    Write-Host "Download verification failed" -ForegroundColor Red
    exit 1
}

# Extract to temp then move
Write-Host "Extracting files..." -ForegroundColor Green
if (Test-Path $extractPath) {
    Remove-Item -Path $extractPath -Recurse -Force
}

try {
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
} catch {
    Write-Host "Extraction failed: $_" -ForegroundColor Red
    Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
    exit 1
}

# Verify extraction structure
$nvimSourcePath = "$extractPath\nvim-win64"
if (-not (Test-Path $nvimSourcePath)) {
    Write-Host "Unexpected archive structure: nvim-win64 folder not found" -ForegroundColor Red
    Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
    Remove-Item $extractPath -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}

# Move to destination
try {
    Move-Item -Path $nvimSourcePath -Destination $nvimPath -Force -ErrorAction Stop
} catch {
    Write-Host "Failed to move files: $_" -ForegroundColor Red
    Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
    Remove-Item $extractPath -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}

# Cleanup temp files
Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
Remove-Item $extractPath -Recurse -Force -ErrorAction SilentlyContinue

# Rename nvim.exe to nvin.exe
$nvimExe = "$nvimPath\bin\nvim.exe"
$nvinExe = "$nvimPath\bin\nvin.exe"

if (-not (Test-Path $nvimExe)) {
    Write-Host "Error: nvim.exe not found at expected location" -ForegroundColor Red
    exit 1
}

if (Test-Path $nvinExe) {
    Remove-Item $nvinExe -Force
}

try {
    Rename-Item -Path $nvimExe -NewName "nvin.exe" -ErrorAction Stop
    Write-Host "Renamed nvim.exe to nvin.exe" -ForegroundColor Green
} catch {
    Write-Host "Failed to rename executable: $_" -ForegroundColor Red
    exit 1
}

# Update PATH
$binPath = "$nvimPath\bin"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Initialize empty string if null
if ([string]::IsNullOrWhiteSpace($userPath)) {
    $userPath = ""
}

# Case-insensitive path check
$pathExists = $false
$pathSegments = $userPath -split ';'
foreach ($segment in $pathSegments) {
    if ($segment -and (Resolve-Path $segment -ErrorAction SilentlyContinue) -eq (Resolve-Path $binPath -ErrorAction SilentlyContinue)) {
        $pathExists = $true
        break
    }
}

if (-not $pathExists) {
    Write-Host "Adding $binPath to PATH..." -ForegroundColor Green
    try {
        $newPath = if ($userPath) { "$userPath;$binPath" } else { $binPath }
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + $newPath
    } catch {
        Write-Host "Warning: Failed to update PATH: $_" -ForegroundColor Yellow
    }
} else {
    Write-Host "PATH already contains $binPath" -ForegroundColor Yellow
}

# Verify installation
Write-Host "`nInstallation complete!" -ForegroundColor Green
Write-Host "Location: $nvimPath" -ForegroundColor Gray
Write-Host "Command: nvin" -ForegroundColor Gray

# Test in current session
$nvinPath = "$nvimPath\bin\nvin.exe"
if (Test-Path $nvinPath) {
    try {
        $version = & $nvinPath --version 2>&1 | Select-Object -First 1
        Write-Host "Version: $version" -ForegroundColor Gray
    } catch {
        Write-Host "Note: Restart your terminal to use the nvin command" -ForegroundColor Yellow
    }
} else {
    Write-Host "Warning: nvin.exe not found at expected location" -ForegroundColor Yellow
}
