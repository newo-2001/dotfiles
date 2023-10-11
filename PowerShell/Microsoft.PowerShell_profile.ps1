if (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue)
{
    $theme = Join-Path $env:POSH_THEMES_PATH "custom.omp.json"
    oh-my-posh init pwsh --config $theme | Invoke-Expression
}

function lst
{
    eza -lh --git --icons --no-permissions --no-user --no-time --color-scale
}