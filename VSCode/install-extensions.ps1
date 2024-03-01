Write-Output "Installing VSCode extensions..."
$arguments = ""

foreach ($extension in Get-Content (Join-Path "VSCode" "extensions.txt"))
{
    if (($extension -eq "") -or $extension -match "^#.*")
    {
        continue
    }

    $extension | Write-Output
    $arguments += "--install-extension $extension --force "
}

Start-Process "code" -ArgumentList $arguments -NoNewWindow -Wait