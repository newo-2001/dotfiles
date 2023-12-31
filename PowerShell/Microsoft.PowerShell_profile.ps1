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

$scriptDir = Split-Path (Get-RealScriptPath)
$path = [IO.Path]::Combine($scriptDir, "..", "Eza", "colors.txt")
$Env:EZA_COLORS = (Get-Content -Path $path) -split "\r\n" -join ':'

function lst
{
    eza -lh --git --icons --no-permissions --no-user --no-time --color-scale --sort type
}