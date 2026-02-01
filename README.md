# Project 0 Gravity (P0G) 🚀

![Project 0 Gravity Concept](assets/p0g-banner.png)

> **Transform Antigravity into a methodical, autonomous software engineer that never forgets.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Antigravity](https://img.shields.io/badge/Platform-Antigravity-blue.svg)](https://deepmind.google/technologies/gemini/antigravity/)
[![Status: Production Ready](https://img.shields.io/badge/Status-Production%20Ready-green.svg)]()

> ⚠️ **Antigravity Exclusive**: This methodology is designed specifically for [Google DeepMind's Antigravity](https://deepmind.google/technologies/gemini/antigravity/) and will not work with other AI assistants.

---

## 📖 What is P0G?

**Project 0 Gravity** is a revolutionary agent orchestration methodology built exclusively for **Google DeepMind's Antigravity**. It eliminates **Context Rot** — the degradation of AI understanding over time — by forcing every task to execute in a clean "Zero Gravity" state, inheriting knowledge only through persistent memory files.

P0G leverages Antigravity's native **workflow system** (`.agent/workflows/`) to transform chaotic AI development into a **rigorous engineering discipline**:

| Principle | Implementation |
|-----------|----------------|
| **Linear Phases** | No code until requirements are validated |
| **Persistent Memory** | Every decision documented in files |
| **Mandatory Backups** | Automatic snapshots before every change |
| **Verification-First** | Tasks pass only with automated checks |

---

## The Problem P0G Solves

| Problem | P0G Solution |
|---------|--------------|
| **Context Drift** | Agent forgets decisions | Persistent memory files |
| **Scope Creep** | Features added without validation | Blocking phase workflow |
| **Breaking Changes** | No safety net for bugs | Automatic backups + rollback |
| **Inconsistent Patterns** | Every file different style | AGENTS.md pattern documentation |
| **Silent Failures** | Bugs go unnoticed | Verification commands required |

---

## The P0G Workflow

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                           P0G METHODOLOGY FLOW                               │
└──────────────────────────────────────────────────────────────────────────────┘

  /p0g-context       /p0g-features      /p0g-tasks         /p0g-loop
  ────────────       ─────────────      ──────────         ─────────
       │                   │                 │                  │
       ▼                   ▼                 ▼                  ▼
  ┌─────────┐        ┌──────────┐      ┌──────────┐      ┌──────────┐
  │ Phase 1 │        │ Phase 2  │      │ Phase 3  │      │ Phase 4  │
  │Discovery│ ─────> │ Features │ ───> │  Tasks   │ ───> │Execution │
  └─────────┘        └──────────┘      └──────────┘      └──────────┘
       │                   │                 │                  │
       ▼                   ▼                 ▼                  ▼
   prd.json            +features          +tasks           passes:true
   (vision)            (designed)        (atomized)        (verified)

                  ┌───────────────────────────────────┐
                  │       PERSISTENT MEMORY           │
                  ├───────────────────────────────────┤
                  │  prd.json      → Project state    │
                  │  progress.txt  → Execution log    │
                  │  errors.log    → Error tracking   │
                  │  AGENTS.md     → Patterns & rules │
                  │  .p0g/backups/ → Safety snapshots │
                  └───────────────────────────────────┘
```

### Phase Dependencies

| Phase | Command | Requires | Produces |
|-------|---------|----------|----------|
| 1. Discovery | `/p0g-context` | User input | `prd.json` with vision |
| 2. Features | `/p0g-features` | Vision | `prd.json["features"]` |
| 3. Tasks | `/p0g-tasks` | Features | `prd.json["tasks"]` |
| 4. Execution | `/p0g-loop` | Tasks | Working code |

---

## ⚡ Quick Start (Antigravity Only)

> **Important**: P0G is designed exclusively for **Google DeepMind's Antigravity** AI assistant. It will not work with other AI tools.

### Prerequisites

- Access to **Antigravity** (Google DeepMind's AI coding assistant)
- A project directory you want to work on

### Installation

There are two ways to use P0G in Antigravity:

#### Option 1: Clone into your project (Recommended)

If you want P0G to manage your existing project:

```bash
# Navigate to your project
cd /path/to/your-project

# Clone P0G framework (this adds the workflows to your project)
git clone https://github.com/yz9yt/P0G.git .p0g-framework

# Copy workflows to your project
cp -r .p0g-framework/.agent .
cp -r .p0g-framework/agents .
cp -r .p0g-framework/.p0g .
cp .p0g-framework/AGENTS.md .
cp .p0g-framework/progress.txt .

# Optional: Remove cloned repo
rm -rf .p0g-framework

# Open in Antigravity
# Antigravity will auto-detect .agent/workflows/ and make /p0g-* commands available
```

#### Option 2: Start fresh with P0G

If you're starting a new project:

```bash
# Clone P0G as your project foundation
git clone https://github.com/yz9yt/P0G.git my-new-project
cd my-new-project

# Remove P0G's git history to start fresh
rm -rf .git
git init

# Open in Antigravity
# P0G workflows are ready to use
```

### Verification

Once installed, verify P0G is available in Antigravity:

1. Open your project in **Antigravity**
2. Type `/p0g` in the chat
3. You should see autocomplete suggestions for:
   - `/p0g-np` (Discovery)
   - `/p0g-plan` (Architecture)
   - `/p0g-tasks` (Task Breakdown)
   - `/p0g-loop` (Execution)

### First Run

Start your first P0G project:

#### Phase 1: Discovery
```bash
/p0g-context
```
The Discovery Agent interviews you using Socratic questioning:
- What problem are you solving?
- Who are the target users?
- What does success look like?
- What are the constraints?

**Output**: `prd.json` with vision, user stories, constraints, and risks.

#### Phase 2: Features
```bash
/p0g-features
```
Transform user stories into concrete features:
- Define feature scope and acceptance criteria
- Prioritize using MoSCoW method
- Identify dependencies between features

**Output**: `prd.json["features"]` populated.

#### Phase 3: Tasks
```bash
/p0g-tasks
```
Atomize features into executable tasks:
- Each task completable in one iteration
- Every task has a verification command
- Dependencies explicitly declared

**Output**: `prd.json["tasks"]` with verification commands.

#### Phase 4: Execution
```bash
/p0g-loop
```
Autonomous execution with safety net:
1. Create backup snapshot
2. Execute next task
3. Run verification command
4. Log to progress.txt
5. Mark task complete or retry

---

## Project Structure

```
P0G/
├── .agent/
│   └── workflows/              # Slash commands (/p0g-*)
│       ├── p0g-context.md      # Phase 1: Discovery
│       ├── p0g-features.md     # Phase 2: Feature definition
│       ├── p0g-tasks.md        # Phase 3: Task breakdown
│       └── p0g-loop.md         # Phase 4: Execution loop
│
├── agents/
│   └── p0g/
│       ├── prompts/            # Agent personalities
│       │   ├── discovery.md    # Requirements interviewer
│       │   ├── architect.md    # Technical designer
│       │   ├── tasker.md       # Task breakdown specialist
│       │   └── executor.md     # Implementation engineer
│       └── skills/
│           └── SKILL.md        # Backup/rollback/recovery
│
├── .p0g/                       # Internal state (auto-generated)
│   ├── backups/                # Timestamped .tar.gz snapshots
│   ├── snapshots/              # Task-level snapshots
│   ├── checkpoints/            # Feature checkpoints
│   └── state.json              # Current execution state
│
├── prd.json                    # Single source of truth
├── progress.txt                # Append-only execution log
├── errors.log                  # Error tracking
├── AGENTS.md                   # Guidelines and patterns
└── README.md                   # This file
```

---

## Core Concepts

### 1. prd.json — Single Source of Truth

```json
{
  "project": {
    "name": "Project Name",
    "version": "0.1.0",
    "status": "ready_for_execution"
  },
  "vision": {
    "elevator_pitch": "One sentence description",
    "problem_statement": "The problem we're solving",
    "target_users": [{"persona": "...", "pain_points": ["..."]}],
    "success_metrics": [{"metric": "...", "target": "..."}]
  },
  "features": [
    {
      "id": 1,
      "name": "Feature name",
      "description": "What it does",
      "priority": "must-have",
      "acceptance_criteria": ["Testable condition"]
    }
  ],
  "tasks": [
    {
      "id": 1,
      "feature_id": 1,
      "description": "Create the module",
      "type": "create",
      "passes": false,
      "dependencies": [],
      "verification_cmd": "test -f src/module.ts",
      "context": "Implementation notes"
    }
  ]
}
```

### 2. Task Schema

| Field | Required | Description |
|-------|----------|-------------|
| `id` | Yes | Unique integer identifier |
| `feature_id` | Yes | Parent feature reference |
| `description` | Yes | Actionable description (verb + object) |
| `type` | Yes | `create`, `modify`, `delete`, `configure`, `test` |
| `passes` | Yes | Execution status (initially `false`) |
| `dependencies` | Yes | Array of task IDs that must pass first |
| `verification_cmd` | Yes | Shell command returning exit 0 on success |
| `context` | No | Additional hints for executor |

### 3. Verification Commands

Every task requires a verification command that validates the outcome:

```bash
# File operations
test -f path/to/file.ts                    # File exists
test -d path/to/directory                  # Directory exists
test -s path/to/file.ts                    # File not empty

# Content verification
grep -q 'pattern' file.ts                  # Pattern exists
jq empty config.json                       # Valid JSON
jq -e '.key' config.json > /dev/null       # Key exists

# Build/test verification
npm run build --silent                     # Build succeeds
npm test -- --silent                       # Tests pass

# Combined checks
test -f file.ts && grep -q 'export' file.ts
```

### 4. Status Flow

```
Project Status:
  needs_context → needs_features → needs_tasks → ready_for_execution
                                                         ↓
                                               in_progress → completed
                                                         ↓
                                                      blocked

Task Status:
  pending → in_progress → passed
                       ↘ failed → retry → passed
                                       ↘ blocked
```

---

## Safety System

### Automatic Backups

Before every modification:
```bash
mkdir -p .p0g/backups && \
tar -czf .p0g/backups/backup_$(date +%Y%m%d_%H%M%S).tar.gz \
    --exclude='.p0g/backups' \
    --exclude='.git' \
    --exclude='node_modules' \
    .
```

### Rollback

Restore to latest backup:
```bash
LATEST=$(ls -t .p0g/backups/*.tar.gz | head -n 1) && \
tar -xzf "$LATEST" -C .
```

### Recovery Options

| Function | Purpose |
|----------|---------|
| `backup` | Create full snapshot |
| `rollback` | Restore latest backup |
| `rollback_to` | Restore specific backup |
| `restore_file` | Restore single file |
| `diff_backup` | Compare changes |
| `verify_backup` | Check integrity |
| `cleanup_backups` | Remove old backups |

---

## Agent Prompts

### Discovery Agent
- **Role**: Requirements interviewer
- **Method**: Socratic questioning
- **Focus**: Business value, not technical solutions
- **Output**: Complete PRD foundation

### Architect Agent
- **Role**: Technical designer
- **Method**: Pattern analysis
- **Focus**: Stack decisions, structure
- **Output**: Feature specifications

### Tasker Agent
- **Role**: Task breakdown specialist
- **Method**: Atomization
- **Focus**: Verifiable, independent tasks
- **Output**: Task dependency graph

### Executor Agent
- **Role**: Implementation engineer
- **Method**: Read → Implement → Verify → Log
- **Focus**: Clean, complete code
- **Output**: Working features

---

## Example Session

```bash
# Phase 1: Discovery
$ /p0g-context
> What are we building?
  "A REST API for user management"
> What problem does it solve?
  "Manual user data handling is error-prone"
> Who are the target users?
  "Backend developers integrating auth"
> What does success look like?
  "100 requests/second, <50ms latency"

# Phase 2: Features
$ /p0g-features
> Features identified:
>   [1] User Registration (must-have)
>   [2] User Authentication (must-have)
>   [3] Profile Management (should-have)
>   [4] Admin Dashboard (nice-to-have)

# Phase 3: Tasks
$ /p0g-tasks
> Tasks for Feature #1 (User Registration):
>   [1] Create user model schema
>       verify: test -f src/models/user.ts
>   [2] Implement registration endpoint
>       verify: grep -q 'POST /register' src/routes/auth.ts
>   [3] Add input validation
>       verify: npm test -- --grep "registration" --silent
>   [4] Write integration tests
>       verify: npm test -- --grep "register" --silent

# Phase 4: Execution
$ /p0g-loop
> [BACKUP] .p0g/backups/backup_20260201_180532.tar.gz
> [START]  Task #1: Create user model schema
> [INFO]   Creating src/models/user.ts
> [VERIFY] test -f src/models/user.ts → exit 0
> [DONE]   Task #1: PASSED
> [LOG]    Updated progress.txt
```

---

## Philosophy

> **"Context Rot is the silent killer of AI-assisted development."**

### Core Principles

| Principle | Meaning |
|-----------|---------|
| **Trust Nothing, Verify Everything** | Every claim backed by verification command |
| **Document Like You're Leaving** | Next iteration understands from files alone |
| **Fail Safe, Not Silent** | Backup is one command away |
| **Read Before Write** | Never modify without understanding |
| **Atomic Changes** | One task, one focus, one verification |

### Definition of Done

A task is `passes: true` only when:
- [ ] Code follows patterns in `AGENTS.md`
- [ ] Verification command returns exit 0
- [ ] Progress logged to `progress.txt`
- [ ] Backup exists before modification
- [ ] No placeholder code (`// TODO`, `FIXME`)

---

## Command Reference

| Command | Phase | Description |
|---------|-------|-------------|
| `/p0g-context` | 1 | Start discovery, create prd.json |
| `/p0g-features` | 2 | Define features from user stories |
| `/p0g-tasks` | 3 | Break features into atomic tasks |
| `/p0g-loop` | 4 | Execute tasks autonomously |

### Status Values

| Status | Meaning | Next Action |
|--------|---------|-------------|
| `needs_context` | No PRD | Run `/p0g-context` |
| `needs_features` | PRD exists, no features | Run `/p0g-features` |
| `needs_tasks` | Features exist, no tasks | Run `/p0g-tasks` |
| `ready_for_execution` | Tasks ready | Run `/p0g-loop` |
| `in_progress` | Executing | Wait or monitor |
| `completed` | All tasks passed | Done |
| `blocked` | Needs human input | Review errors.log |

---

## Error Handling

| Error Type | Auto-Retry | Resolution |
|------------|------------|------------|
| Syntax error | Yes | Fix and re-verify |
| Missing file | Yes | Check path, create if needed |
| Test failure | Yes | Debug, fix implementation |
| Permission denied | No | Escalate to human |
| Ambiguous requirement | No | Escalate to human |
| Circular dependency | No | Restructure task order |

### Recovery Protocol

```
1. Error occurs → Log to errors.log
2. Classify error type
3. If retryable → Attempt fix (max 3 tries)
4. If not retryable → Mark as blocked
5. Never mark task passed if verification fails
```

---

## Contributing

P0G is open-source. We welcome:
- Bug reports
- Feature requests
- Documentation improvements
- New agent prompts and skills

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📜 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

Made with ❤️ by Albert C [@yz9yt](https://x.com/yz9yt)
