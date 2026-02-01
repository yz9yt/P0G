# P0G Snapshots Directory

This directory stores task-level snapshots (before/after states).

Snapshots are lighter than full backups and specific to task execution.

## Format

```
task_XXX_before.tar.gz   # State before task execution
task_XXX_after.tar.gz    # State after successful completion
```

## Usage

Snapshots enable granular rollback to specific task states during debugging.
