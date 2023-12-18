param(
    [string]$inputFile, # Path to the text file containing directories to copy
    [string]$backupRoot, # Root directory of the backup
    [string]$logDirectory # Directory where logs should be stored
)

function Backup-Directory {
    param(
        [string]$sourcePath,
        [string]$destPath
    )

    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $logFile = Join-Path $logDirectory "BackupLog_$timestamp.txt"

    Robocopy $sourcePath $destPath /s /xj /r:2 /w:2 /mt:8 /z /LOG:$logFile
}

# Read the list of directories from the input file
$directories = Get-Content $inputFile

foreach ($dir in $directories) {
    $sourcePath = $dir
    $destPath = $dir -replace '^[A-Za-z]:', $backupRoot

    Backup-Directory -sourcePath $sourcePath -destPath $destPath
}
