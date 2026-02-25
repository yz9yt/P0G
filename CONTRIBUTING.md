# Contributing to P0G

Thank you for your interest in contributing to **Project 0 Gravity**! This document provides guidelines for contributing to the P0G methodology and tooling.

---

## How to Contribute

### Reporting Bugs

Found a bug? Open an issue with:
- **Description**: What went wrong
- **Steps to Reproduce**: Exact steps to trigger the issue
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happened
- **Environment**: Antigravity version, OS, model used

### Suggesting Features

Have an idea? Open an issue with:
- **Use Case**: What problem does it solve?
- **Proposed Solution**: How would it work?
- **Alternatives**: Other approaches considered

### Areas for Contribution

| Area | Examples |
|------|----------|
| **Workflows** | Improve `/p0g-np`, `/p0g-plan`, `/p0g-tasks`, `/p0g-loop`, `/p0g-surgeon` |
| **Agent Prompts** | Refine prompts in `agents/p0g/prompts/` for better guidance |
| **Paradigms** | Add new paradigm templates in `paradigms/` (e.g., OOP, DDD, reactive) |
| **Skills** | Add new safety or automation skills in `agents/p0g/skills/` |
| **Installer** | Improve `install.sh` for more platforms or package managers |

---

## Project Structure

```
P0G/
├── .agent/workflows/         # Slash commands — the core P0G phases
│   ├── p0g-np.md             # /p0g-np: Discovery (Phase 1)
│   ├── p0g-plan.md           # /p0g-plan: Architecture (Phase 2)
│   ├── p0g-tasks.md          # /p0g-tasks: Task breakdown (Phase 3)
│   ├── p0g-loop.md           # /p0g-loop: Execution (Phase 4)
│   └── p0g-surgeon.md        # /p0g-surgeon: Reactive bug fixer
│
├── agents/p0g/
│   ├── prompts/              # Agent personalities loaded by workflows
│   │   ├── discovery.md      # Socratic interviewer
│   │   ├── architect.md      # Technical designer
│   │   ├── tasker.md         # Task decomposer
│   │   ├── executor.md       # Implementation engineer
│   │   └── surgeon.md        # Problem decomposer & micro-fixer
│   └── skills/
│       └── SKILL.md          # Backup/rollback/recovery commands
│
├── paradigms/                # Optional architectural rule templates
│   └── functional.md         # Functional programming paradigm
│
├── .p0g/                     # Safety infrastructure (backup dirs)
├── install.sh                # One-liner installer (macOS + Linux)
├── AGENTS.md                 # Agent guidelines and learned patterns
├── prd.json                  # P0G's own project definition
├── progress.txt              # Execution log
├── README.md                 # Main documentation
├── CONTRIBUTING.md           # This file
└── LICENSE                   # MIT
```

---

## Development Process

1. **Fork** the repository
2. **Create a branch**: `git checkout -b feature/your-feature-name`
3. **Make changes** — follow the guidelines below
4. **Test**: Run through a P0G workflow with your changes
5. **Commit**: Use the commit format below
6. **Submit PR**: Use the PR template below

### Code Style

| File Type | Rules |
|-----------|-------|
| Workflows (`.agent/workflows/`) | Markdown with clear sections, frontmatter with `description:` |
| Agent Prompts (`agents/p0g/prompts/`) | Clear, actionable English. Tables for rules. Anti-patterns section. |
| Paradigms (`paradigms/`) | Must include: principles, per-phase instructions, code review checklist |
| Scripts (`install.sh`) | POSIX-compliant bash. Works on macOS and Linux. |
| JSON (`prd.json`) | Follow existing schema |

### Workflow File Format

Every workflow file must have:

```markdown
---
description: Short description shown in autocomplete
---

# /p0g-command-name (Title)

> One-line summary of what this phase does.

## Recommended Model

> **Model** · Thinking Level: **Level**
> Why this model/level is recommended.

## [Rest of workflow...]
```

### Paradigm File Format

Every paradigm file must include:

1. Installation instructions at the top
2. Core principles as mandatory rules
3. Per-phase instructions (how it applies to `/p0g-np`, `/p0g-plan`, `/p0g-tasks`, `/p0g-loop`, `/p0g-surgeon`)
4. Code review checklist
5. Anti-patterns table

### Commit Messages

Format: `<type>: <short description>`

Types: `feat`, `fix`, `docs`, `refactor`, `chore`

```
feat: Add OOP paradigm template

Adds paradigms/oop.md with SOLID principles, dependency injection
patterns, and per-phase instructions for P0G workflows.
```

---

## Pull Request Template

```markdown
## Description
Brief description of changes.

## Type of Change
- [ ] New workflow or workflow improvement
- [ ] New or refined agent prompt
- [ ] New paradigm template
- [ ] Installer improvement
- [ ] Documentation update
- [ ] Bug fix

## Testing
How was this tested? (e.g., "Ran full P0G cycle on a test project")

## Checklist
- [ ] Follows existing file format and style
- [ ] Tested with Antigravity
- [ ] Documentation updated (README, AGENTS.md if needed)
- [ ] No breaking changes to existing workflows
```

---

## Community

- Be respectful and constructive
- Check existing issues before opening new ones
- Contributors are credited in release notes

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
