if (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue)
{
    $theme = Join-Path $env:POSH_THEMES_PATH "custom.omp.json"
    oh-my-posh init pwsh --config $theme | Invoke-Expression
}