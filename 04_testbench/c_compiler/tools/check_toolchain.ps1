param(
    [Parameter(Mandatory = $true)]
    [string]$Compiler,

    [Parameter(Mandatory = $true)]
    [string]$Objcopy,

    [Parameter(Mandatory = $true)]
    [string]$Objdump,

    [Parameter(Mandatory = $true)]
    [string]$SizeTool
)

$ErrorActionPreference = "Stop"

function Resolve-ToolPath
{
    param(
        [Parameter(Mandatory = $true)]
        [string]$ToolName
    )

    $pathCandidates = @($ToolName, "$ToolName.exe")
    foreach ($pathCandidate in $pathCandidates) {
        if ([System.IO.File]::Exists($pathCandidate)) {
            return [System.IO.Path]::GetFullPath($pathCandidate)
        }
    }

    $command = Get-Command $ToolName -ErrorAction SilentlyContinue
    if ($null -ne $command) {
        return $command.Source
    }

    return $null
}

$requiredTools = [ordered]@{
    "gcc" = $Compiler
    "objcopy" = $Objcopy
    "objdump" = $Objdump
    "size" = $SizeTool
}

$missingToolCount = 0

foreach ($toolEntry in $requiredTools.GetEnumerator()) {
    $resolvedPath = Resolve-ToolPath -ToolName $toolEntry.Value
    if ($null -eq $resolvedPath) {
        Write-Host "[MISSING] $($toolEntry.Key): $($toolEntry.Value)" -ForegroundColor Red
        $missingToolCount++
    } else {
        Write-Host "[OK]      $($toolEntry.Key): $resolvedPath" -ForegroundColor Green
    }
}

if ($missingToolCount -ne 0) {
    Write-Host ""
    Write-Host "Configure TOOLCHAIN_BIN and CROSS_COMPILE in toolchain.mk." -ForegroundColor Yellow
    exit 1
}

exit 0

