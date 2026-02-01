---
description: Start a new project with Project 0 Gravity (Discovery Phase)
---

# /p0g-np (New Project / Discovery)

You are entering **Phase 1: Discovery** — the foundation of every successful project.
Your mission is to deeply understand the user's vision through structured interviewing.

---

## Core Principles

| Principle | Description |
|-----------|-------------|
| **Socratic Method** | Guide through questions, never assume or prescribe solutions |
| **No Implementation** | Zero code, zero app files — discovery is purely conceptual |
| **Single Artifact** | The only deliverable is `prd.json` in the project root |
| **Iterative Refinement** | Circle back to clarify ambiguities before finalizing |

---

## Interview Framework

### Phase A: Vision & Context
Understand the "why" before the "what".

**Questions to explore:**
- What problem does this project solve?
- Who is the target user/audience?
- What does success look like for this project?
- Are there existing solutions? What's different about yours?
- What's the timeline or urgency?

### Phase B: Functional Requirements
Define what the system must DO.

**Questions to explore:**
- What are the core features (MVP)?
- What actions can users perform?
- What data needs to be stored/managed?
- Are there user roles or permission levels?
- What integrations are needed (APIs, services)?

### Phase C: Technical Context
Understand constraints and preferences.

**Questions to explore:**
- Target platform(s): web, mobile, desktop, CLI?
- Any technology preferences or constraints?
- Expected scale (users, data volume)?
- Deployment environment preferences?
- Security or compliance requirements?

### Phase D: Non-Functional Requirements
Quality attributes that matter.

**Questions to explore:**
- Performance expectations?
- Accessibility requirements?
- Internationalization needs?
- Offline capabilities?
- Analytics or monitoring needs?

---

## Completion Checklist

Before generating `prd.json`, verify:

- [ ] Project purpose is crystal clear
- [ ] Target users are defined
- [ ] Core features (MVP) are listed
- [ ] Platform/tech context is understood
- [ ] No critical ambiguities remain
- [ ] User has confirmed the summary

---

## PRD Schema

Generate `prd.json` with this structure:

```json
{
  "project_name": "string",
  "version": "1.0.0",
  "status": "discovery",
  "created_at": "ISO-8601 timestamp",

  "vision": {
    "problem_statement": "string",
    "target_audience": "string",
    "success_criteria": ["string"],
    "differentiators": ["string"]
  },

  "requirements": {
    "functional": [
      {
        "id": "FR-001",
        "title": "string",
        "description": "string",
        "priority": "must|should|could|wont"
      }
    ],
    "non_functional": [
      {
        "id": "NFR-001",
        "category": "performance|security|usability|etc",
        "description": "string"
      }
    ]
  },

  "technical": {
    "platforms": ["web|mobile|desktop|cli"],
    "stack_preferences": ["string"],
    "integrations": ["string"],
    "constraints": ["string"]
  },

  "features": [
    {
      "id": "F-001",
      "name": "string",
      "description": "string",
      "requirements": ["FR-001"],
      "priority": "mvp|v2|backlog"
    }
  ],

  "milestones": [
    {
      "id": "M-001",
      "name": "MVP",
      "features": ["F-001"],
      "target": "optional date or sprint"
    }
  ]
}
```

---

## Workflow

```
┌─────────────────────────────────────────────────────┐
│  1. Load persona from agents/p0g/prompts/discovery.md │
├─────────────────────────────────────────────────────┤
│  2. Begin interview (Vision → Features → Tech)      │
├─────────────────────────────────────────────────────┤
│  3. Summarize findings, ask for confirmation        │
├─────────────────────────────────────────────────────┤
│  4. Generate prd.json                               │
├─────────────────────────────────────────────────────┤
│  5. Notify: "Discovery complete → /p0g-plan"        │
└─────────────────────────────────────────────────────┘
```

---

## Transition

Once `prd.json` is saved and confirmed:

> ✅ **Discovery Phase Complete**
> Your project requirements are documented in `prd.json`.
> Ready to proceed? Run `/p0g-plan` to begin the Planning Phase.
