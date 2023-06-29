$WSL_ENV = "USERPROFILE/up";

& {
    Write-Output "Installing Microsoft PowerShell Profile..."
    $source = Join-Path 'PowerShell' 'Microsoft.PowerShell_profile.ps1'
    $mirror = [IO.Path]::Combine($HOME, 'Documents', 'WindowsPowerShell')
    $null = New-Item -Path $mirror -Name 'Microsoft.PowerShell_profile.ps1' -ItemType SymbolicLink -Value $source -Force
}

# Test if Oh-My-Posh is installed
if (Test-Path 'env:POSH_THEMES_PATH')
{
    Write-Output "Installing Oh-My-Posh Theme..."
    $source = Join-Path 'Oh-My-Posh' 'custom.omp.json'
    $null = New-Item -Path $Env:POSH_THEMES_PATH -Name 'custom.omp.json' -ItemType SymbolicLink -Value $source -Force
    $WSL_ENV += ":POSH_THEMES_PATH/up";
}

# Configure shared environment variables for WSL
Write-Output "Sharing environment variables with WSL..."
[Environment]::SetEnvironmentVariable("WSLENV", $WSL_ENV, [EnvironmentVariableTarget]::User)

Write-Output "Done."