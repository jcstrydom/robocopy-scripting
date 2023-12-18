# README for Backup PowerShell Script

## Introduction
This PowerShell script performs backups based on a list of directories specified in a YAML configuration file. It uses `Robocopy` to ensure efficient and reliable copying, maintaining the directory structure and creating logs for each operation.

## Requirements
- PowerShell environment.
- A YAML file specifying source directories and a destination directory.

## YAML File Format
The YAML file should be structured as follows:
```yaml
destination: "Path\To\Backup\Destination"
sources:
  - "Path\To\Source\Directory1"
  - "Path\To\Source\Directory2"
  ...
```

## How to Run the Script
1. **Save the Script**: Save the PowerShell script as `BackupScript.ps1`.
2. **Prepare YAML File**: Create your YAML configuration file with the required structure.
3. **Execute the Script**: Run the script in PowerShell with the following command:
   ```powershell
   .\backup-script.ps1 -yamlFile "Path\To\Your\File.yaml" -logDirectory "Path\To\Log\Directory"
   ```
   Replace paths with the actual paths to your YAML file and desired log directory.


As an example:
```
.\backup-script.ps1 -inputFile "dirs-to-backup.txt" -backupRoot "D:\C-Drive\" -logDirectory ".\logs\"
```

## Input Parameters
- `yamlFile`: Path to the YAML file containing the backup configuration.
- `logDirectory`: Directory where backup logs should be stored.

## Default Settings
- **Robocopy Flags**: `/s` (copy subdirectories, but not empty ones), `/xj` (exclude junction points), `/r:2` (retry 2 times), `/w:2` (wait 2 seconds between retries), `/mt:8` (use 8 threads), `/z` (copy in restartable mode).
- **Log File**: Logs are appended to a file named `BackupLog_YYYYMMDD_HHMMSS.txt` in the specified log directory.

## Modifying the Script
- **Update Robocopy Settings**: If necessary, modify the `Robocopy` command within the `Backup-Directory` function to change flags or add new ones.
- **Script Customization**: For additional customization, update the PowerShell script as needed. Ensure you have a basic understanding of PowerShell and `Robocopy` to avoid unwanted behavior.

> **Note**: It is recommended to have a basic understanding of PowerShell and `Robocopy` before modifying the script to ensure the changes are effective and do not disrupt the intended functionality.


## Troubleshooting
- Ensure the YAML file is correctly formatted and accessible.
- Check the PowerShell execution policy if the script does not run.
- Review the log file for errors or warnings after running the backup.


