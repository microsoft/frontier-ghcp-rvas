# Stage 2: Adding error handling and logging

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

The scripts from Stage 1 can fail without visible output when a machine is
offline, a temp directory is locked, or an AD query returns nothing. Add error
handling and structured logging to `Invoke-DiskCleanup.ps1`.

## Tasks

1. Wrap the `Invoke-Command` call in `Invoke-DiskCleanup.ps1` in a `try/catch` block. On failure, log the computer name and the error message using `Write-Error`. The script must continue to the next machine rather than stopping.
2. Add `Write-Verbose` lines before and after the cleanup steps inside the remote script block so operators can run the script with `-Verbose` and see progress.
3. Add a size-freed summary: capture the sizes of the directories before and after removal, compute the difference, and emit a `[PSCustomObject]` per machine with `ComputerName`, `BytesFreed`, and `Status` (`Success` or `Failed`).
4. Add a `-LogPath` parameter that, when specified, appends each result object as a CSV row to `$LogPath\DiskCleanup-<date>.csv` using `Export-Csv -Append`.

## Verification

- When a computer name does not resolve, `Invoke-DiskCleanup.ps1` writes a `Write-Error` message for that machine and processes remaining machines
- Running with `-Verbose` produces at least one progress line per machine
- The return value of the script is a collection of result objects with `ComputerName`, `BytesFreed`, and `Status` properties
- Running with `-LogPath` creates a CSV file in that directory

## What Copilot helps with vs. what requires your judgment

Copilot can draft `try/catch` blocks and `Export-Csv` calls. Check why
`$ErrorActionPreference = 'Stop'` is needed to catch errors here. You decide
whether partial cleanup counts as success and encode that rule in `Status`.

---

Previous: [Stage 1: Understanding and Fixing Existing Scripts](stage-1-understand-and-fix.md) | Next: [Stage 3: Azure Automation and Compliance](stage-3-azure-automation.md)
