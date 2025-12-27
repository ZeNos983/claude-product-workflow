# Claude Product Workflow - Windows Installation Script
# Run this script in PowerShell

$ErrorActionPreference = "Stop"

Write-Host "Installing Claude Product Workflow..." -ForegroundColor Cyan

# Define paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = "$env:USERPROFILE\.claude"

# Check if Claude directory exists
if (-not (Test-Path $ClaudeDir)) {
    Write-Host "Creating Claude config directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
}

# Create subdirectories if they don't exist
$Subdirs = @("templates", "agents", "commands", "skills\product-workflow")
foreach ($Subdir in $Subdirs) {
    $FullPath = Join-Path $ClaudeDir $Subdir
    if (-not (Test-Path $FullPath)) {
        New-Item -ItemType Directory -Path $FullPath -Force | Out-Null
    }
}

# Copy templates
Write-Host "Installing templates..." -ForegroundColor Green
Copy-Item -Path "$ScriptDir\templates\*" -Destination "$ClaudeDir\templates\" -Force -Recurse

# Copy agents
Write-Host "Installing agents..." -ForegroundColor Green
Copy-Item -Path "$ScriptDir\agents\*" -Destination "$ClaudeDir\agents\" -Force -Recurse

# Copy commands
Write-Host "Installing commands..." -ForegroundColor Green
Copy-Item -Path "$ScriptDir\commands\*" -Destination "$ClaudeDir\commands\" -Force -Recurse

# Copy skills
Write-Host "Installing skills..." -ForegroundColor Green
Copy-Item -Path "$ScriptDir\skills\*" -Destination "$ClaudeDir\skills\" -Force -Recurse

Write-Host ""
Write-Host "Installation complete!" -ForegroundColor Cyan
Write-Host ""
Write-Host "Installed files:" -ForegroundColor White
Write-Host "  - 5 templates in $ClaudeDir\templates\"
Write-Host "  - 5 agents in $ClaudeDir\agents\"
Write-Host "  - 7 commands in $ClaudeDir\commands\"
Write-Host "  - 1 skill in $ClaudeDir\skills\product-workflow\"
Write-Host ""
Write-Host "Usage:" -ForegroundColor White
Write-Host "  /product-init my-app 'Description of your product'"
Write-Host ""
Write-Host "For more information, see: https://github.com/yourusername/claude-product-workflow"
