# Tool for patching existing json files
# This script only works properly in PowerShell 7

param(
    [Parameter(Mandatory=$true)]
    [string] $Target,
   
    [Parameter(Mandatory=$true)]
    [string] $Patch
)

function Patch-Object
{
    param(
        [Parameter(Mandatory=$true)]
        [HashTable] $Target,

        [Parameter(Mandatory=$true)]
        [HashTable] $Patch
    )

    foreach ($property in $Patch.GetEnumerator())
    {
        if ($Target.ContainsKey($property.Name))
        {
            $child = $Target[$property.Name]
            if ($child -is [HashTable] -and $property.Value -is [HashTable])
            {
                Patch-Object -Target $child -Patch $Patch[$property.Name]
            }
            else
            {
                $Target[$property.Name] = $property.Value
            }
        }
        else
        {
            $Target[$property.Name] = $Patch[$property.Name]
        }
    }
}

$patchContent = Get-Content -Raw -Path $Patch | ConvertFrom-Json -AsHashTable
$targetContent = Get-Content -Raw -Path $Target | ConvertFrom-Json -AsHashTable

Patch-Object -Target $targetContent -Patch $patchContent

($targetContent | ConvertTo-Json -Depth 10) -replace "`r", " " | Out-File -NoNewLine -FilePath $Target
