---
description: Breakdown features into atomic, verifiable, and executable tasks
---

# /p0g-tasks — Task Breakdown

**Phase 3: Task Breakdown** — Converts features into granular, executable units of work.

---

## Recommended Model

> **Gemini 3.1 Pro** · Thinking Level: **Medium**
>
> Task decomposition needs good analytical reasoning without the latency of full deep thinking.
> Medium thinking balances decomposition quality with speed for generating the task DAG.

---

## Prerequisites

Before starting, verify:
- [ ] `prd.json` exists and contains a populated `"features"` array
- [ ] Each feature has a clear `id`, `name`, and `description`
- [ ] The project context is understood (run `/p0g-context` if needed)

## Core Principles

### 1. Atomicity
Each task must be:
- Completable in a **single iteration** (one focused action)
- **Independent** or with explicit dependencies
- **Testable** with a concrete verification command

### 2. Verifiability
Every task requires a `verification_cmd` that:
- Returns exit code `0` on success, non-zero on failure
- Can be executed repeatedly without side effects
- Validates the **outcome**, not just the action

### 3. Dependency Clarity
Tasks must declare dependencies explicitly:
- Use task `id` references in the `dependencies` array
- Circular dependencies are forbidden
- Tasks without dependencies can run in parallel

## Task Schema

```json
{
  "id": 1,
  "feature_id": 1,
  "description": "Create the user authentication module",
  "type": "create|modify|delete|configure|test",
  "passes": false,
  "dependencies": [],
  "verification_cmd": "test -f src/auth/index.ts && grep -q 'export class Auth' src/auth/index.ts",
  "context": "Optional notes for the executor"
}
```

### Field Reference

| Field | Required | Description |
|-------|----------|-------------|
| `id` | Yes | Unique integer identifier |
| `feature_id` | Yes | Parent feature this task implements |
| `description` | Yes | Clear, actionable description (verb + object) |
| `type` | Yes | Task category for routing |
| `passes` | Yes | Execution status (initially `false`) |
| `dependencies` | Yes | Array of task `id`s that must pass first |
| `verification_cmd` | Yes | Shell command to validate completion |
| `context` | No | Additional hints for the executor |

## Execution Steps

### Step 1: Load Context
```
Load agents/p0g/prompts/tasker.md for specialized breakdown logic.
```

### Step 2: Analyze Features
For each feature in `prd.json["features"]`:
1. Identify the minimal steps required to implement it
2. Consider file operations, configurations, and tests
3. Order steps by natural dependency flow

### Step 3: Generate Tasks
Apply these breakdown patterns:

| Feature Type | Typical Task Sequence |
|--------------|----------------------|
| New file/module | Create directory → Create file → Add exports → Add tests |
| API endpoint | Define route → Implement handler → Add validation → Add tests |
| Configuration | Create config file → Set values → Validate schema |
| Integration | Install dependency → Configure → Implement adapter → Test |

### Step 4: Validate Task Graph
Ensure:
- No orphan tasks (all linked to a feature)
- No circular dependencies
- All `verification_cmd` commands are valid shell syntax
- Task `id`s are sequential and unique

### Step 5: Update Status
```json
{
  "status": "ready_for_execution",
  "tasks_count": <number>,
  "ready_tasks": [<ids of tasks with no pending dependencies>]
}
```

## Verification Command Examples

```bash
# File exists
test -f path/to/file.ts

# File contains pattern
grep -q 'pattern' path/to/file.ts

# Directory exists
test -d path/to/directory

# Command succeeds
npm run build --silent

# Tests pass
npm test -- --grep "module name" --silent

# JSON is valid
jq empty path/to/config.json

# Multiple conditions
test -f file.ts && grep -q 'export' file.ts && npm run typecheck --silent
```

## Error Handling

| Error | Resolution |
|-------|------------|
| `prd.json` missing features | Return to `/p0g-features` |
| Feature too vague to atomize | Request clarification from user |
| Circular dependency detected | Restructure task order |
| Invalid verification command | Fix syntax before proceeding |

## Output

On completion:
1. `prd.json` updated with complete `tasks` array
2. Status set to `ready_for_execution`
3. Summary displayed: total tasks, dependency graph depth, ready tasks

**Next step**: Run `/p0g-loop` to begin execution.
