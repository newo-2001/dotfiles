$WSL_ENV = "USERPROFILE/up";

& {
    # Install PowerShell Profile
    Write-Output "Installing Microsoft PowerShell profile..."
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
Write-Output "Installing Oh-My-Posh theme..."
$source = Join-Path "Oh-My-Posh" "custom.omp.json"
$null = New-Item -Path $Env:POSH_THEMES_PATH -Name "custom.omp.json" -ItemType SymbolicLink -Value $source -Force
$WSL_ENV += ":POSH_THEMES_PATH/up";

# Configure shared environment variables for WSL
Write-Output "Sharing environment variables with WSL..."
[Environment]::SetEnvironmentVariable("WSLENV", $WSL_ENV, [EnvironmentVariableTarget]::User)

# Test if VSCode is installed
#if (Get-Command "code" -ErrorAction SilentlyContinue)
#{
#    # Install VSCode extensions
#    Write-Output "Installing VSCode extensions..."
#    $arguments = ""
#    foreach ($extension in Get-Content (Join-Path "VSCode" "extensions.txt"))
#    {
#        $arguments += "--install-extension $extension --force "
#    }
#    Start-Process "code" -ArgumentList $arguments -NoNewWindow -Wait
#}

# Test if Git is installed
if (Get-Command "git" -ErrorAction SilentlyContinue)
{
    # Install .gitconfig
    Write-Output "Installing Git configuration..."
    $source = Join-Path "Git" ".gitconfig"
    $null = New-Item -Path $HOME -Name ".gitconfig" -ItemType SymbolicLink -Value $source -Force
}

if (!(Get-Command "delta" -ErrorAction SilentlyContinue))
{
    # Install Delta
    Write-Output "Installing Delta..."
    winget install dandavison.delta
}

Write-Output "Done."