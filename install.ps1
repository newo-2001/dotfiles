$WSL_ENV = "USERPROFILE/up";

& {
    # Install PowerShell Profile
    Write-Output "Installing Microsoft PowerShell profile..."
    $source = Join-Path "PowerShell" "Microsoft.PowerShell_profile.ps1"
    $mirror = [IO.Path]::Combine($HOME, "Documents", "WindowsPowerShell")
    $null = New-Item -Path $mirror -Name "Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value $source -Force
}

# Test if Oh-My-Posh is installed
if (Test-Path "env:POSH_THEMES_PATH")
{
    # Install Oh-My-Posh Theme
    Write-Output "Installing Oh-My-Posh theme..."
    $source = Join-Path "Oh-My-Posh" "custom.omp.json"
    $null = New-Item -Path $Env:POSH_THEMES_PATH -Name "custom.omp.json" -ItemType SymbolicLink -Value $source -Force
    $WSL_ENV += ":POSH_THEMES_PATH/up";
}

# Configure shared environment variables for WSL
Write-Output "Sharing environment variables with WSL..."
[Environment]::SetEnvironmentVariable("WSLENV", $WSL_ENV, [EnvironmentVariableTarget]::User)

& {
    # Install Git hooks for this repository
    Write-Output "Installing Git hooks for this repository..."
    $source = Join-Path "Git" "hooks"
    $mirror = Join-Path ".git" "hooks"
    $null = Remove-Item -Path $mirror -Recurse
    $null = New-Item -Path $mirror -ItemType Junction -Value $source -Force
}

# Test if VSCode is installed
if (Get-Command "code" -ErrorAction SilentlyContinue)
{
    # Install VSCode extensions
    Write-Output "Installing VSCode extensions..."
    $arguments = ""
    foreach ($extension in Get-Content (Join-Path "VSCode" "extensions.txt"))
    {
        $arguments += "--install-extension $extension --force "
    }
    Start-Process "code" -ArgumentList $arguments -NoNewWindow -Wait
}

Write-Output "Done."