param(
    [string]$inputFile, # Path to the text file containing directories to copy
    [string]$backupRoot, # Root directory of the backup
    [string]$logDirectory # Directory where logs should be stored
)

$date = Get-Date -Format "yyyyMMdd"
$logFile = Join-Path $logDirectory "BackupLog_$date.txt"

function Backup-Directory {
    param(
        [string]$sourcePath,
        [string]$destPath,
        [string]$logFile
    )

    Robocopy $sourcePath $destPath /s /xj /r:2 /w:2 /mt:8 /z /LOG+:$logFile
}

# Read the list of directories from the input file
$directories = Get-Content $inputFile

foreach ($dir in $directories) {
    $sourcePath = $dir
    $destPath = $dir -replace '^[A-Za-z]:', $backupRoot

    Backup-Directory -sourcePath $sourcePath -destPath $destPath -logFile $logFile
}
