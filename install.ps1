$WSL_ENV = "USERPROFILE/up:POSH_THEMES_PATH/up"

& {
    # Install PowerShell Profile
    Write-Output "Configuring Microsoft PowerShell profile..."
    $source = Join-Path "PowerShell" "Microsoft.PowerShell_profile.ps1"
    $mirror = [IO.Path]::Combine($HOME, "Documents", "WindowsPowerShell")
    $null = New-Item -Path $mirror -Name "Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value $source -Force
}

if (!(Get-Command "oh-my-posh" -ErrorAction SilentlyContinue))
{
    # Install Oh-My-Posh
    Write-Output "Installing Oh-My-Posh..."
    winget install JanDeDobbeleer.OhMyPosh -s winget
}

# Install Oh-My-Posh Theme
& {
    Write-Output "Configuring Oh-My-Posh theme..."
    $source = Join-Path "Oh-My-Posh" "custom.omp.json"
    $null = New-Item -Path $Env:POSH_THEMES_PATH -Name "custom.omp.json" -ItemType SymbolicLink -Value $source -Force
}

# Configure shared environment variables for WSL
Write-Output "Sharing environment variables with WSL..."
[Environment]::SetEnvironmentVariable("WSLENV", $WSL_ENV, [EnvironmentVariableTarget]::User)

# Test if Git is installed
if (Get-Command "git" -ErrorAction SilentlyContinue)
{
    # Install .gitconfig
    Write-Output "Configuring Git..."
    $source = Join-Path "Git" ".gitconfig"
    $null = New-Item -Path $HOME -Name ".gitconfig" -ItemType SymbolicLink -Value $source -Force

    # Install .git-templates
    $source = Join-Path "Git" "templates"
    $null = New-Item -Path $HOME -Name ".git-templates" -ItemType SymbolicLink -Value $source -Force

    if (!(Get-Command "delta" -ErrorAction SilentlyContinue))
    {
        # Install Delta
        Write-Output "Installing Delta..."
        winget install dandavison.delta
    }
}

# Check if PowerToys is installed
# TODO: Suppress output of this command
$process = Start-Process "winget" -ArgumentList "list --id Microsoft.PowerToys" -NoNewWindow -Wait -PassThru
if ($process.ExitCode -ne 0)
{
    Write-Output "Installing Microsoft PowerToys..."
    winget install Microsoft.PowerToys
}

# Create symlink for PowerToys keymap
& {
    Write-Output "Configuring Microsoft Powertoys..."
    $source = [IO.Path]::Combine("PowerToys", "KeyboardManager", "default.json")
    $destination = [IO.Path]::Combine($Env:LOCALAPPDATA, "Microsoft", "PowerToys", "Keyboard Manager")
    $null = New-Item -Path $destination -Name "default.json" -ItemType SymbolicLink -Value $source -Force
}

Write-Output "Done."