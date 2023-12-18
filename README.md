# README for Backup PowerShell Script

## Introduction
This PowerShell script utilizes `Robocopy` to backup directories listed in a text file. It maintains the directory structure and logs each operation with a timestamp.

## How to Run the Script
1. Save the script as `BackupScript.ps1`.
2. Open PowerShell and navigate to the script's location.
3. Execute the script using the following command:
   ```powershell
   .\BackupScript.ps1 -inputFile "<path-to-text-file>" -backupRoot "<backup-root-directory>" -logDirectory "<log-directory>"
   ```

## Input Parameters
- `inputFile`: Path to the text file containing directories to be backed up. Each line in the file should be a path.
- `backupRoot`: The root directory where backups will be stored.
- `logDirectory`: Directory where the backup logs will be saved.

## Default Settings
- **Robocopy Flags**:
  - `/s`: Copies subdirectories, but not empty ones.
  - `/xj`: Excludes junction points.
  - `/r:2`: Retries 2 times on errors.
  - `/w:2`: Waits 2 seconds between retries.
  - `/mt:8`: Uses 8 threads for copying.
  - `/z`: Uses restartable mode.
- **Log File**: Named with the current timestamp to ensure uniqueness.

## Updating Robocopy Settings
To modify the Robocopy settings:
1. Open `BackupScript.ps1` in a text editor.
2. Locate the `Robocopy` command inside the `Backup-Directory` function.
3. Modify the flags as per your requirement. Refer to the [Robocopy documentation](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy) for detailed flag descriptions.
4. Save the changes.

> **Note**: It is recommended to have a basic understanding of PowerShell and `Robocopy` before modifying the script to ensure the changes are effective and do not disrupt the intended functionality.