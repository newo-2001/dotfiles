$WSL_ENV = "USERPROFILE/up:LOCALAPPDATA/up"

# Disable progress bars
$ProgressPreference = "SilentlyContinue"

function refresh-path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")
}

if (-Not (Get-Command "pwsh" -ErrorAction SilentlyContinue))
{
    Write-Output "Installing PowerShell..."
    winget install --id Microsoft.Powershell --source winget
}

& {
    # Install PowerShell Profile
    Write-Output "Configuring Microsoft PowerShell profile..."
    $source = Join-Path "PowerShell" "Microsoft.PowerShell_profile.ps1"
    $documents = Join-Path $Env:USERPROFILE "Documents"
    $dest = Join-Path $documents "WindowsPowerShell"
    $null = New-Item -Path $dest -Name "Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value $source -Force
    $dest = Join-Path $documents "PowerShell"
    $null = New-Item -Path $dest -Name "Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value $source -Force
}

if (-Not (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue))
{
    # Install Oh-My-Posh
    Write-Output "Installing Oh-My-Posh..."
    winget install JanDeDobbeleer.OhMyPosh -s winget
}

& {
    # Install Oh-My-Posh Theme
    Write-Output "Configuring Oh-My-Posh theme..."
    $source = Join-Path "Oh-My-Posh" "custom.omp.json"
    $null = New-Item -Path $Env:POSH_THEMES_PATH -Name "custom.omp.json" -ItemType SymbolicLink -Value $source -Force
}

if (-Not (Get-Command "rg" -ErrorAction SilentlyContinue))
{
    # Install ripgrep
    Write-Output "Installing ripgrep"
    winget install BurntSushi.ripgrep.MSVC
}

& {
    # Configure WSL
    Write-Output "Configuring WSL..."
    [Environment]::SetEnvironmentVariable("WSLENV", $WSL_ENV, [EnvironmentVariableTarget]::User)
    $source = Join-Path "WSL" ".wslconfig"
    $null = New-Item -Path $Env:USERPROFILE -Name ".wslconfig" -ItemType SymbolicLink -Value $source -Force
}

# Test if Git is not installed
if (-Not (Get-Command "git" -ErrorAction SilentlyContinue))
{
    Write-Output "Installing Git..."
    winget install Git.Git
}

& {
    # Install .gitconfig
    Write-Output "Configuring Git..."
    $source = Join-Path "Git" ".gitconfig"
    $null = New-Item -Path $HOME -Name ".gitconfig" -ItemType SymbolicLink -Value $source -Force

    # Install .git-templates
    $source = Join-Path "Git" "templates"
    $null = New-Item -Path $HOME -Name ".git-templates" -ItemType SymbolicLink -Value $source -Force

    # Prompt user to initialize default git account details
    $userConfig = Join-Path $Env:USERPROFILE ".gitconfig-user"
    if (-Not (Test-Path -Path $userConfig))
    {
        Write-Host "This machine does not have a default git user, please enter the desired account details."
        $username = Read-Host -Prompt "Default username"
        $email = Read-Host -Prompt "Default email address"

        $null = New-Item -Path $Env:USERPROFILE -Name ".gitconfig-user"
        Set-Content $userConfig @"
[user]
    name = $username
    email = $email
"@
    }
}

# Check if delta is not installed
if (-Not (Get-Command "delta" -ErrorAction SilentlyContinue))
{
    # Install Delta
    Write-Output "Installing Delta..."
    winget install dandavison.delta
}

# Check if win32yank is not installed
if (-Not (Get-Command "win32yank" -ErrorAction SilentlyContinue))
{
    # Install win32yank
    Write-Output "Installing win32yank..."
    winget install equalsraf.win32yank
}

# Check if Eza is not installed
if (-Not (Get-Command "eza" -ErrorAction SilentlyContinue))
{
    # Install Eza
    Write-Output "Installing Eza"
    winget install eza-community.eza
}

# Check if zoxide is not installed
if (-Not (Get-Command "zoxide" -ErrorAction SilentlyContinue))
{
    # Install zoxide
    Write-Output "Installing zoxide"
    winget install ajeetdsouza.zoxide
}

# Check if fzf is not installed
if (-Not (Get-Command "fzf" -ErrorAction SilentlyContinue))
{
    # Install fzf
    Write-Output "Installing fzf"
    winget install fzf
}

# Check if bat is not installed
if (-Not (Get-Command "bat" -ErrorAction SilentlyContinue))
{
    # Install bat
    Write-Output "Installing bat..."
    winget install sharkdp.bat
    refresh-path
}

& {
    $batThemes = [IO.Path]::Combine($Env:APPDATA, "bat", "themes")
    $batCatppuccin = Join-Path $batThemes "Catppuccin-mocha.tmTheme"
    
    # Check if catppuccin theme for bat is not installed
    if (-Not (Test-Path -PathType Leaf -Path $batCatppuccin))
    {
        # Configure catppuccin theme for bat
        Write-Output "Configuring bat..."
        $null = New-Item -ItemType Directory -Force -Path $batThemes
        $null = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme" -OutFile $batCatppuccin
        bat cache --build
    }
}

# Check if PowerToys is not installed
# TODO: Suppress output of this command
$process = Start-Process "winget" -ArgumentList "list --id Microsoft.PowerToys" -NoNewWindow -Wait -PassThru
if ($process.ExitCode -ne 0)
{
    # Install PowerToys
    Write-Output "Installing Microsoft PowerToys..."
    winget install Microsoft.PowerToys
}

# Configure Windows Terminal
& {
    # Configure Windows Terminal
    Write-Output "Configuring Windows Terminal..."
    $source = Join-Path "WindowsTerminal" "terminal_wallpaper.jpg"
    $destination = Join-Path $Env:USERPROFILE ".config"

    $null = New-Item -Path $destination -Name "terminal_wallpaper.jpg" -ItemType SymbolicLink -Value $source -Force
    $source = Join-Path "WindowsTerminal" "settings.json"
    $destination = [IO.Path]::Combine($Env:LOCALAPPDATA, "Packages", "Microsoft.WindowsTerminal_8wekyb3d8bbwe", "LocalState")
    $null = New-Item -Path $destination -Name "settings.json" -ItemType SymbolicLink -Value $source -Force  
}

& {
    # Create symlinks for PowerToys
    Write-Output "Configuring Microsoft Powertoys..."
    $source = [IO.Path]::Combine("PowerToys", "KeyboardManager", "default.json")
    $destination = [IO.Path]::Combine($Env:LOCALAPPDATA, "Microsoft", "PowerToys", "Keyboard Manager")
    $null = New-Item -Path $destination -Name "default.json" -ItemType SymbolicLink -Value $source -Force

    $source = [IO.Path]::Combine("PowerToys", "FancyZones", "custom-layouts.json")
    $destination = [IO.Path]::Combine($Env:LOCALAPPDATA, "Microsoft", "PowerToys", "FancyZones")
    $null = New-Item -Path $destination -Name "custom-layouts.json" -ItemType SymbolicLink -Value $source -Force
}

& {
    # Create symlink for Neovim
    Write-Output "Configuring Neovim..."
    $null = New-Item -Path $Env:LOCALAPPDATA -Name "nvim" -ItemType SymbolicLink -Value "Neovim" -Force
}

& {
    # Install global .editorconfig
    Write-Output "Configuring global .editorconfig..."
    $null = New-Item -Path $Env:USERPROFILE -Name ".editorconfig" -ItemType SymbolicLink -Value ".editorconfig" -Force
}

function Get-Fonts {
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    (New-Object System.Drawing.Text.InstalledFontCollection).Families
}

# Check if the JetBrainsMono font not is installed
if (-Not ((Get-Fonts) -contains "JetBrainsMonoNL NFM"))
{
    # Create temp directory
    $tempDirectory = "temp"
    $null = New-Item -ItemType Directory -Force -Path $tempDirectory

    # Download
    Write-Output "Downloading JetBrainsMono font..."
    Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" -OutFile "./temp/JetBrainsMono.zip"
    
    # Extract
    Write-Output "Installing JetBrainsMono font..."
    Expand-Archive -Path "./temp/JetBrainsMono.zip" -DestinationPath "./temp/JetBrainsMono" -Force

    $fontsDirectory = Join-Path "temp" "JetBrainsMono"
    $userFontsDirectory = [IO.Path]::Combine($Env:LOCALAPPDATA, "Microsoft", "Windows", "Fonts")
    $fontFilter = "^JetBrainsMonoNLNerdFontMono-[A-Za-z]+.ttf$"
    $fonts = Get-ChildItem -Path $fontsDirectory -Name | Where-Object { $_ -match $fontFilter }

    foreach ($font in $fonts)
    {
        # Copy file to user fonts directory
        $destination = Join-Path $userFontsDirectory $font
        $font = Get-Item -Path "./temp/JetBrainsMono/$font"
        $null = Copy-Item $font.FullName -Destination $destination -Force

        # Create registry key
        $fontName = "$($font.BaseName) (True Type)"
        $registryKey = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
        $null = New-ItemProperty -Name $fontName -Path $registryKey -PropertyType string -Value $destination -Force
    }

    # Remove temp directory
    Remove-Item $tempDirectory -Recurse -Force
}

Write-Output "Done."
