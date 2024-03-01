function Get-RealScriptPath()
{
    $link_target = Get-Item $PSCommandPath | Select-Object -ExpandProperty Target

    if (-Not $link_target)
    {
        return $ScriptPath
    }

    if ([System.IO.Path]::IsPathRooted($link_target))
    {
        return $link_target
    }

    return Resolve-Path -Path (Join-Path $PSScriptRoot $link_target)
}

if (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue)
{
    $theme = Join-Path $env:POSH_THEMES_PATH "custom.omp.json"
    oh-my-posh init pwsh --config $theme | Invoke-Expression
}

if (Get-Command "zoxide" -ErrorAction SilentlyContinue)
{
    Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
}

$Env:DOTFILES = (Get-RealScriptPath) | Split-Path | Split-Path
$ezaColorsPath = [IO.Path]::Combine($Env:DOTFILES, "Eza", "colors.txt")
$Env:EZA_COLORS = (Get-Content -Path $ezaColorsPath) -split "\r\n" -join ':'

function lst
{
    eza -lh --git --icons --no-permissions --no-user --no-time --color-scale --sort type
}

Set-Alias vim nvim
Set-Alias cat bat -Option AllScope
Set-Alias ls lst -Option AllScope
$Env:BAT_THEME = "Catppuccin-mocha"
