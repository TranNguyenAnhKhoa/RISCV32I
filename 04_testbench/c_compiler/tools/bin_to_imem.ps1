param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile,

    [Parameter(Mandatory = $true)]
    [string]$OutputFile,

    [ValidateRange(4, 2147483647)]
    [int]$MaximumBytes = 1024
)

$ErrorActionPreference = "Stop"

$inputPath = [System.IO.Path]::GetFullPath($InputFile)
$outputPath = [System.IO.Path]::GetFullPath($OutputFile)

if (-not [System.IO.File]::Exists($inputPath)) {
    throw "Input binary does not exist: $inputPath"
}

$programBytes = [System.IO.File]::ReadAllBytes($inputPath)

if ($programBytes.Length -eq 0) {
    throw "Input binary is empty: $inputPath"
}

if ($programBytes.Length -gt $MaximumBytes) {
    throw "Program is $($programBytes.Length) bytes; IMEM limit is $MaximumBytes bytes"
}

if (($programBytes.Length % 4) -ne 0) {
    throw "RV32I program size must be a multiple of four bytes; got $($programBytes.Length)"
}

$outputDirectory = [System.IO.Path]::GetDirectoryName($outputPath)
if (-not [string]::IsNullOrWhiteSpace($outputDirectory)) {
    [System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null
}

$outputLines = New-Object System.Collections.Generic.List[string]

for ($byteIndex = 0; $byteIndex -lt $programBytes.Length; $byteIndex += 4) {
    # GNU objcopy emits little-endian RISC-V instruction bytes. IMEM.v joins
    # four byte entries MSB first, so reverse each 32-bit instruction here.
    $outputLines.Add(
        ("{0:X2} {1:X2} {2:X2} {3:X2}" -f
            $programBytes[$byteIndex + 3],
            $programBytes[$byteIndex + 2],
            $programBytes[$byteIndex + 1],
            $programBytes[$byteIndex + 0])
    )
}

$utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllLines($outputPath, $outputLines, $utf8WithoutBom)

Write-Host (
    "Generated {0} instructions ({1} bytes): {2}" -f
        ($programBytes.Length / 4),
        $programBytes.Length,
        $outputPath
)

