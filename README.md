# README for Backup PowerShell Script

## Introduction
This PowerShell script performs backups of subdirectories based on a list of parent directories specified in a YAML configuration file. It uses `Robocopy` for efficient and reliable copying, maintaining the directory structure, and creating logs for each operation.

## Requirements
- PowerShell environment.
- A YAML file specifying source directories, a destination directory, and a log directory.

> ***INFO*** - for efficiency subdirectories of the source directories are identified and copied first, after which the entire source directory is copied.

## YAML File Format
The YAML file should be structured as follows:
```yaml
destination: "Path\To\Backup\Destination"
logsdirectory: "Path\To\Log\Directory"
sources:
  - "Path\To\Parent\Source\Directory1"
  - "Path\To\Parent\Source\Directory2"
  ...
```

## How to Run the Script
1. **Save the Script**: Save the PowerShell script as `BackupScript.ps1`.
2. **Prepare YAML File**: Create your YAML configuration file with the required structure.
3. **Execute the Script**: Run the script in PowerShell with the following command:
   ```powershell
   .\BackupScript.ps1 -yamlFile "Path\To\Your\File.yaml"
   ```
   Replace `Path\To\Your\File.yaml` with the actual path to your YAML file.

Example:
```
.\BackupScript.ps1 -yamlFile "dirs-to-backup.yml"
```

## Input Parameter
- `yamlFile`: Path to the YAML file containing the backup configuration.


## Default Settings
- **Robocopy Flags**: `/s` (copy subdirectories, but not empty ones), `/xj` (exclude junction points), `/r:2` (retry 2 times), `/w:2` (wait 2 seconds between retries), `/mt:8` (use 8 threads), `/z` (copy in restartable mode).
- **Log File**: Logs are appended to a file named `BackupLog_YYYYMMDD_HHMMSS.txt` in the specified log directory.

## Modifying the Script
- **Update Robocopy Settings**: Modify the `Robocopy` command within the `Backup-Directory` function to change flags or add new ones as needed.
- **Script Customization**: For further customization, update the PowerShell script as required. A basic understanding of PowerShell and `Robocopy` is advised to ensure proper functionality and to avoid unintended behavior.

> **Note**: It's recommended to have a foundational understanding of PowerShell and `Robocopy` before modifying the script, ensuring that changes are effective and align with the intended functionality.

## Troubleshooting
- Ensure the YAML file is correctly formatted, contains all necessary fields, and is accessible.
- Check the PowerShell execution policy if the script does not run.
- Review the log file for any errors or warnings after running the backup.
