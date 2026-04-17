# =============================================================================
# initializationForWindows.ps1 - Windows Development Environment Setup Script
# =============================================================================
#
# Description:
#   Automated setup script for Windows development environment including
#   Chocolatey, Python (pyenv-win), uv, MiniConda, Volta, Oh My Posh,
#   PowerToys, PSReadLine, and WSL.
#
# Usage:
#   .\initializationForWindows.ps1 [-Proxy PROXY] [-SkipWSL] [-WhatIf]
#
# Options:
#   -Proxy PROXY   HTTP/HTTPS proxy server (e.g., "localhost:7890")
#   -SkipWSL      Skip WSL installation
#   -WhatIf        Show what would be executed without running
#
# Requirements:
#   - Windows 10/11
#   - PowerShell 5.1+ or PowerShell 7+
#   - Administrator privileges for Chocolatey
#
# =============================================================================

param(
    [string]$Proxy = "",
    [switch]$SkipWSL,
    [switch]$WhatIf
)

$ErrorActionPreference = "Stop"
$IS_DRY_RUN = $WhatIf.IsPresent

function write_info {
    param([string]$Message)
    Write-Host "==> $Message"
}

function write_error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
    exit 1
}

function run_command {
    param([scriptblock]$Command, [string]$Description)
    if ($IS_DRY_RUN) {
        Write-Host "[DRY-RUN] $Description" -ForegroundColor Yellow
        return
    }
    try { & $Command } catch { write_error "Failed: $Description - $_" }
}

function install_chocolatey {
    write_info "Installing Chocolatey..."
    if ($IS_DRY_RUN) { Write-Host "[DRY-RUN] Would install Chocolatey" -ForegroundColor Yellow; return }
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        try {
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        } catch { write_error "Failed to install Chocolatey: $_" }
    } else { write_info "Chocolatey already installed" }
}

function install_python {
    write_info "Installing Python via pyenv-win..."
    run_command -Command { choco install pyenv-win -y } -Description "Install pyenv-win"
    run_command -Command { pip config set global.index-url https://mirrors.sustech.edu.cn/pypi/web/simple } -Description "Set pip mirror"
}

function install_uv {
    write_info "Installing uv..."
    run_command -Command { choco install uv -y } -Description "Install uv"
}

function install_volta {
    write_info "Installing Volta..."
    run_command -Command { choco install volta -y } -Description "Install Volta"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    run_command -Command { volta install node } -Description "Install Node.js"
}

function install_oh_my_posh {
    write_info "Installing Oh My Posh..."
    run_command -Command { choco install oh-my-posh -y } -Description "Install Oh My Posh"
}

function install_powertoys {
    write_info "Installing PowerToys..."
    run_command -Command { winget install Microsoft.PowerToys --accept-source-agreements --accept-package-agreements } -Description "Install PowerToys"
}

function install_psreadline {
    write_info "Installing PSReadLine..."
    run_command -Command { Install-Module -Name PSReadLine -Scope CurrentUser -Force } -Description "Install PSReadLine"
}

function setup_wsl {
    write_info "Setting up WSL..."
    if ($SkipWSL) { write_info "Skipping WSL installation"; return }
    if ($Proxy) { $env:HTTP_PROXY = "http://$Proxy"; $env:HTTPS_PROXY = "http://$Proxy" }
    run_command -Command { wsl --install } -Description "Install WSL"
    run_command -Command { wsl --install kali } -Description "Install Kali WSL"
}

function install {
    write_info "Starting Windows development environment setup..."
    install_chocolatey
    install_python
    install_uv
    install_volta
    install_oh_my_posh
    install_powertoys
    install_psreadline
    setup_wsl
    write_info "Setup complete!"
}

install
