# P0G Safety Skill

The Safety Skill provides the "Zero Gravity" safety net — comprehensive backup, rollback, and recovery capabilities that ensure no work is ever lost.

---

## Table of Contents

1. [Overview](#overview)
2. [Core Functions](#core-functions)
3. [Advanced Functions](#advanced-functions)
4. [Usage Patterns](#usage-patterns)
5. [Configuration](#configuration)
6. [Troubleshooting](#troubleshooting)

---

## Overview

### Philosophy

> "Code fearlessly. The safety net catches everything."

The Safety Skill ensures that:
- Every modification can be undone
- System state is always recoverable
- Experiments are risk-free
- Debugging has restore points

### Architecture

```
.p0g/
├── backups/
│   ├── backup_20240115_103000.tar.gz    # Full backups
│   ├── backup_20240115_110000.tar.gz
│   └── ...
├── snapshots/
│   ├── task_001_before.tar.gz           # Task-level snapshots
│   ├── task_001_after.tar.gz
│   └── ...
├── checkpoints/
│   ├── checkpoint_feature_1.tar.gz      # Feature checkpoints
│   └── ...
└── state.json                           # Current system state
```

---

## Core Functions

### 1. `backup`

Creates a timestamped compressed archive of the entire codebase.

**When to use**: Before starting any P0G execution phase, before risky operations.

**Command**:
```bash
mkdir -p .p0g/backups && \
tar -czf .p0g/backups/backup_$(date +%Y%m%d_%H%M%S).tar.gz \
    --exclude='.p0g/backups' \
    --exclude='.p0g/snapshots' \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='dist' \
    --exclude='build' \
    --exclude='.next' \
    --exclude='__pycache__' \
    --exclude='*.pyc' \
    --exclude='.venv' \
    --exclude='venv' \
    .
```

**Output**: `.p0g/backups/backup_YYYYMMDD_HHMMSS.tar.gz`

**Verification**:
```bash
test -f .p0g/backups/backup_*.tar.gz && echo "Backup created"
```

---

### 2. `rollback`

Restores the codebase to the most recent backup state.

**When to use**: After a failed task, system corruption, or unrecoverable error.

**Command**:
```bash
LATEST=$(ls -t .p0g/backups/*.tar.gz 2>/dev/null | head -n 1) && \
[ -n "$LATEST" ] && \
tar -xzf "$LATEST" -C . && \
echo "Rolled back to: $LATEST"
```

**With confirmation**:
```bash
LATEST=$(ls -t .p0g/backups/*.tar.gz | head -n 1) && \
echo "Rolling back to: $LATEST" && \
echo "Contents:" && \
tar -tzf "$LATEST" | head -20 && \
read -p "Proceed? [y/N] " confirm && \
[ "$confirm" = "y" ] && tar -xzf "$LATEST" -C .
```

**Verification**:
```bash
# Check restore timestamp matches backup
ls -la --time-style=long-iso . | head -5
```

---

### 3. `rollback_to`

Restores to a specific backup by name or index.

**When to use**: When you need a specific point in time, not just the latest.

**Command (by name)**:
```bash
BACKUP=".p0g/backups/backup_20240115_103000.tar.gz" && \
[ -f "$BACKUP" ] && \
tar -xzf "$BACKUP" -C . && \
echo "Restored: $BACKUP"
```

**Command (by index, 0 = latest)**:
```bash
INDEX=2 && \
BACKUP=$(ls -t .p0g/backups/*.tar.gz | sed -n "$((INDEX+1))p") && \
[ -f "$BACKUP" ] && \
tar -xzf "$BACKUP" -C . && \
echo "Restored: $BACKUP"
```

---

### 4. `list_backups`

Shows all available backups with metadata.

**Command**:
```bash
echo "Available backups:" && \
ls -lh .p0g/backups/*.tar.gz 2>/dev/null | \
awk '{print NR-1": "$NF" ("$5", "$6" "$7")"}' | \
tac
```

**Sample output**:
```
Available backups:
0: backup_20240115_110000.tar.gz (2.3M, 2024-01-15 11:00)
1: backup_20240115_103000.tar.gz (2.1M, 2024-01-15 10:30)
2: backup_20240115_090000.tar.gz (2.0M, 2024-01-15 09:00)
```

---

## Advanced Functions

### 5. `snapshot_task`

Creates a lightweight snapshot before/after a specific task.

**When to use**: Automatically before each task execution.

**Before task**:
```bash
TASK_ID=$1 && \
mkdir -p .p0g/snapshots && \
tar -czf ".p0g/snapshots/task_${TASK_ID}_before.tar.gz" \
    --exclude='.p0g' \
    --exclude='.git' \
    --exclude='node_modules' \
    .
```

**After task**:
```bash
TASK_ID=$1 && \
tar -czf ".p0g/snapshots/task_${TASK_ID}_after.tar.gz" \
    --exclude='.p0g' \
    --exclude='.git' \
    --exclude='node_modules' \
    .
```

**Verification**:
```bash
test -f ".p0g/snapshots/task_${TASK_ID}_before.tar.gz" && \
test -f ".p0g/snapshots/task_${TASK_ID}_after.tar.gz"
```

---

### 6. `checkpoint_feature`

Creates a named checkpoint after completing a feature.

**When to use**: After all tasks for a feature pass.

**Command**:
```bash
FEATURE_ID=$1 && \
FEATURE_NAME=$2 && \
mkdir -p .p0g/checkpoints && \
tar -czf ".p0g/checkpoints/checkpoint_feature_${FEATURE_ID}_${FEATURE_NAME// /_}.tar.gz" \
    --exclude='.p0g/backups' \
    --exclude='.p0g/snapshots' \
    --exclude='.git' \
    --exclude='node_modules' \
    . && \
echo "Checkpoint created for feature #${FEATURE_ID}: ${FEATURE_NAME}"
```

---

### 7. `diff_backup`

Shows what changed between current state and a backup.

**When to use**: Before rollback to understand impact.

**Command**:
```bash
BACKUP=$1 && \
TEMP_DIR=$(mktemp -d) && \
tar -xzf "$BACKUP" -C "$TEMP_DIR" && \
diff -rq "$TEMP_DIR" . \
    --exclude='.p0g' \
    --exclude='.git' \
    --exclude='node_modules' && \
rm -rf "$TEMP_DIR"
```

**Detailed diff**:
```bash
BACKUP=$1 && \
FILE=$2 && \
TEMP_DIR=$(mktemp -d) && \
tar -xzf "$BACKUP" -C "$TEMP_DIR" && \
diff -u "$TEMP_DIR/$FILE" "$FILE" && \
rm -rf "$TEMP_DIR"
```

---

### 8. `restore_file`

Restores a single file from a backup.

**When to use**: When only one file needs recovery.

**Command**:
```bash
BACKUP=$1 && \
FILE=$2 && \
tar -xzf "$BACKUP" "$FILE" && \
echo "Restored: $FILE from $BACKUP"
```

**With preview**:
```bash
BACKUP=$1 && \
FILE=$2 && \
tar -xzf "$BACKUP" -O "$FILE" | head -50
```

---

### 9. `cleanup_backups`

Removes old backups, keeping only the N most recent.

**When to use**: Periodically to manage disk space.

**Command (keep last 10)**:
```bash
KEEP=10 && \
ls -t .p0g/backups/*.tar.gz 2>/dev/null | \
tail -n +$((KEEP+1)) | \
xargs -r rm -v
```

**With size report**:
```bash
echo "Current backup usage:" && \
du -sh .p0g/backups/ && \
echo "Keeping last 10 backups..." && \
ls -t .p0g/backups/*.tar.gz | tail -n +11 | xargs -r rm -v && \
echo "New backup usage:" && \
du -sh .p0g/backups/
```

---

### 10. `verify_backup`

Validates backup integrity.

**When to use**: Before critical rollbacks, periodically for health checks.

**Command**:
```bash
BACKUP=$1 && \
tar -tzf "$BACKUP" > /dev/null 2>&1 && \
echo "Backup valid: $BACKUP" || \
echo "Backup corrupted: $BACKUP"
```

**Full verification with checksums**:
```bash
BACKUP=$1 && \
echo "Verifying: $BACKUP" && \
echo "Size: $(du -h "$BACKUP" | cut -f1)" && \
echo "Files: $(tar -tzf "$BACKUP" | wc -l)" && \
echo "Checksum: $(md5sum "$BACKUP" | cut -d' ' -f1)" && \
tar -tzf "$BACKUP" > /dev/null && echo "Integrity: OK"
```

---

## Usage Patterns

### Pattern 1: Standard Task Execution

```
┌────────────────────────────────────────┐
│ 1. snapshot_task(id, "before")         │
│ 2. Execute task                        │
│ 3. Run verification_cmd                │
│ 4. If PASS: snapshot_task(id, "after") │
│ 5. If FAIL: rollback to before         │
└────────────────────────────────────────┘
```

### Pattern 2: Feature Completion

```
┌────────────────────────────────────────┐
│ 1. backup() at feature start           │
│ 2. Execute all feature tasks           │
│ 3. All tasks pass?                     │
│    YES: checkpoint_feature(id, name)   │
│    NO: rollback() to feature start     │
└────────────────────────────────────────┘
```

### Pattern 3: Experimental Changes

```
┌────────────────────────────────────────┐
│ 1. backup() before experiment          │
│ 2. Make experimental changes           │
│ 3. Test thoroughly                     │
│ 4. Satisfied?                          │
│    YES: Continue (backup preserved)    │
│    NO: rollback() and try different    │
└────────────────────────────────────────┘
```

### Pattern 4: Debugging Recovery

```
┌────────────────────────────────────────┐
│ 1. list_backups() to find good state   │
│ 2. diff_backup() to see changes        │
│ 3. Identify problematic change         │
│ 4. Either:                             │
│    - restore_file() for single file    │
│    - rollback_to() for full restore    │
└────────────────────────────────────────┘
```

---

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `P0G_BACKUP_DIR` | `.p0g/backups` | Backup storage location |
| `P0G_MAX_BACKUPS` | `20` | Maximum backups to retain |
| `P0G_EXCLUDE_PATTERNS` | (see below) | Paths to exclude |

### Default Exclusions

```bash
EXCLUDE_PATTERNS=(
    '.p0g/backups'
    '.p0g/snapshots'
    '.git'
    'node_modules'
    'dist'
    'build'
    '.next'
    '__pycache__'
    '*.pyc'
    '.venv'
    'venv'
    '.env'
    '*.log'
    '.DS_Store'
)
```

### Custom Exclusions

Add to `.p0g/config.json`:
```json
{
  "backup": {
    "exclude": [
      "data/large_files",
      "tmp",
      "*.tmp"
    ]
  }
}
```

---

## Troubleshooting

### Common Issues

| Problem | Cause | Solution |
|---------|-------|----------|
| "No backups found" | Empty backup directory | Run `backup` first |
| "Backup corrupted" | Incomplete write | Delete corrupted, create new |
| "Disk full" | Too many backups | Run `cleanup_backups` |
| "Permission denied" | Wrong file permissions | `chmod -R u+rw .p0g/` |
| "Restore conflicts" | Modified files | Use `tar --overwrite` |

### Recovery from Corrupted Backup

```bash
# List and verify all backups
for f in .p0g/backups/*.tar.gz; do
    tar -tzf "$f" > /dev/null 2>&1 && \
    echo "OK: $f" || \
    echo "CORRUPT: $f"
done

# Remove corrupted backups
for f in .p0g/backups/*.tar.gz; do
    tar -tzf "$f" > /dev/null 2>&1 || rm -v "$f"
done
```

### Emergency Recovery

If `.p0g/` is corrupted:

```bash
# Recreate structure
mkdir -p .p0g/{backups,snapshots,checkpoints}

# Initialize state
echo '{"status": "recovered", "timestamp": "'$(date -Iseconds)'"}' > .p0g/state.json

# Create fresh backup
tar -czf .p0g/backups/recovery_$(date +%Y%m%d_%H%M%S).tar.gz \
    --exclude='.p0g' --exclude='.git' --exclude='node_modules' .
```

---

## Rules

### Mandatory

1. **Backup before modification** — Every P0G Loop iteration must start with a backup
2. **Verify before rollback** — Always check backup integrity first
3. **Never delete all backups** — Keep at least one backup at all times
4. **Log all operations** — Record backup/rollback events in `progress.txt`

### Recommended

1. Create checkpoints at feature boundaries
2. Use task snapshots for granular recovery
3. Run `cleanup_backups` weekly
4. Verify backup integrity monthly

---

## Quick Reference

| Action | Command |
|--------|---------|
| Create backup | `backup` |
| Restore latest | `rollback` |
| List backups | `list_backups` |
| Restore specific | `rollback_to <backup>` |
| Restore file | `restore_file <backup> <file>` |
| Compare changes | `diff_backup <backup>` |
| Verify integrity | `verify_backup <backup>` |
| Clean old backups | `cleanup_backups` |
