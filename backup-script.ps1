param(
    [string]$yamlFile, # Path to the YAML file
    [string]$logDirectory # Directory where logs should be stored
)

# Simple YAML parsing function
function ParseYaml {
    param([string]$yamlPath)

    $yamlContent = Get-Content $yamlPath -Raw
    $lines = $yamlContent -split "`n" | Where-Object { $_ -match '\S' } # Split by newline and remove empty lines
    $parsedYaml = @{}
    $currentKey = $null

    foreach ($line in $lines) {
        if ($line -match '^\s*(\w+):\s*(.*)') {
            $currentKey = $matches[1]
            $parsedYaml[$currentKey] = ($matches[2] -replace '"', '').Trim()
        } elseif ($line -match '^\s*-\s*(.*)' -and $currentKey -eq 'sources') {
            if (-not $parsedYaml['sources']) { $parsedYaml['sources'] = @() }
            $parsedYaml['sources'] += ($matches[1] -replace '"', '').Trim()
        }
    }

    return $parsedYaml
}



# Parse the YAML file
$yamlData = ParseYaml -yamlPath $yamlFile
$backupRoot = $yamlData["destination"]
$sources = $yamlData["sources"]

# Print the destination folder
Write-Host "Destination Folder: $backupRoot"

# Print each source directory on a new line
Write-Host "Source Directories:"
foreach ($source in $sources) {
    Write-Host "  $source"
}


$date = Get-Date -Format "yyyyMMdd_HHmmss"
$logFile = Join-Path $logDirectory "BackupLog_$date.txt"

function Backup-Directory {
    param(
        [string]$sourcePath,
        [string]$destPath,
        [string]$logFile
    )

    Robocopy $sourcePath $destPath /s /xj /r:2 /w:2 /mt:8 /z /LOG+:$logFile
}

foreach ($sourcePath in $sources) {
    $destPath = $sourcePath -replace '^[A-Za-z]:', $backupRoot
    Write-Host ""
    Write-Host "Busy with '$sourcePath' ..."
    Backup-Directory -sourcePath $sourcePath -destPath $destPath -logFile $logFile
}
