# P0G Backups Directory

This directory stores timestamped compressed archives of your codebase.

Backups are created automatically before each task execution in the `/p0g-loop` workflow.

## Format

Backups follow the naming convention:
```
backup_YYYYMMDD_HHMMSS.tar.gz
backup_YYYYMMDD_HHMMSS_task_T-XXX.tar.gz  (task-specific)
```

## Cleanup

Old backups are retained according to `P0G_MAX_BACKUPS` (default: 20).

Use the Safety Skill's `cleanup_backups` function to manage disk space.
