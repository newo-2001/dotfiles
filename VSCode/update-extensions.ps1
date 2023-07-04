$outfile = Join-Path $PSScriptRoot "extensions.txt"
Start-Process "code" -ArgumentList "--list-extensions" -NoNewWindow -RedirectStandardOutput $outfile