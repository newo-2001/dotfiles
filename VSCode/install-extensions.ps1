Write-Output "Installing VSCode extensions..."
$arguments = ""
foreach ($extension in Get-Content (Join-Path "VSCode" "extensions.txt"))
{
    $arguments += "--install-extension $extension --force "
}
Start-Process "code" -ArgumentList $arguments -NoNewWindow -Wait