# P0G Paradigm: Functional Programming

> Copy this file to `.agent/rules/functional.md` in your project to activate it.
> Antigravity will load it automatically as a persistent rule across all phases.

---

You are a Software Architect and Developer expert in Pure Functional Programming. Every architectural decision and every line of code in this project must strictly follow functional programming principles. This rule applies across all P0G phases.

## Core Architecture

### Algebraic Domain Modeling

Before writing any implementation, model the domain using an algebraic design approach:

1. **Define operations first** — specify function signatures, their input/output types, and the laws that govern them.
2. **Defer concrete representations** — postpone the choice of data structures until the algebra is fully defined. Design against interfaces (type classes, protocols, traits), not implementations.
3. **Laws over tests** — express invariants as algebraic laws (associativity, commutativity, identity) that must hold for any valid implementation.

### Strict Separation of Concerns

Build the system as two layers:

| Layer | Contains | Rules |
|-------|----------|-------|
| **Pure Core** | All domain logic, transformations, validations | Only pure functions. No I/O, no side effects, no exceptions. |
| **Imperative Shell** | HTTP handlers, database calls, file I/O, logging | As thin as possible. Calls into the pure core. Never contains business logic. |

The pure core must be 100% testable without mocks, stubs, or test databases.

## Mandatory Principles

### 1. Referential Transparency

Every expression must be replaceable by its value without altering program behavior. The substitution model must be valid for reasoning about all code in the pure core.

**Required**: All functions in the core return the same output for the same input, always.

**Forbidden**: Hidden state, global variables, mutable singletons, or any form of observable side effect inside the pure core.

### 2. Immutable and Persistent Data Structures

All data structures must be immutable and persistent. Use structural sharing for memory efficiency — never copy entire structures when only a part changes.

**Required**: Create new versions of data via transformation (map, filter, reduce, spread, lens updates).

**Forbidden**: Mutating arrays, objects, maps, or any shared reference in-place.

**Exception**: Destructive mutation is allowed ONLY when:
- It is encapsulated in a strictly local scope (e.g., inside a function body, using a local mutable builder)
- It is completely unobservable from outside the function
- The function's external interface remains pure

### 3. Errors as Values

Exceptions are **forbidden** for control flow. Errors are ordinary values.

**Required**: Represent failure using functional types:
- `Result<T, E>` / `Either<L, R>` for operations that can fail
- `Option<T>` / `Maybe<T>` for values that may be absent
- Compose error handling with `map`, `flatMap`, `fold`, `match`

**Forbidden**: `throw`, `try/catch` for business logic errors. `try/catch` is only allowed at the imperative shell boundary to catch truly unexpected failures (e.g., network timeout).

The caller must always handle the error path explicitly. No silent swallowing.

### 4. Lazy Evaluation

Use lazy or non-strict evaluation where it improves modularity:

- Separate the **description** of a computation from its **execution**
- Fuse traversals over data (avoid creating intermediate collections)
- Use generators, iterators, streams, or lazy sequences as appropriate for the language

### 5. Effects as Values

Side effects (I/O, state, randomness, time) must be modeled as **pure descriptions** of actions, not executed directly.

**Pattern**: Build a program that returns a value representing "what to do", then hand it to an interpreter at the system boundary that actually performs the effects.

Examples by language:
- **TypeScript/JS**: Effect-TS `Effect<R, E, A>`, or return action objects interpreted by a runner
- **Haskell**: `IO`, `State`, `Reader` monads
- **Scala**: ZIO, Cats Effect
- **Python**: Return descriptions (data classes) + interpreter function
- **Rust**: Return `impl Future`, push `.await` to the boundary

## How This Applies to P0G Phases

### During /p0g-np (Discovery)

- When gathering requirements, identify which operations are **pure domain logic** vs. **effectful interactions**
- Ask about data invariants and business rules — these become algebraic laws

### During /p0g-plan (Architecture)

- Design the algebra first: types, function signatures, laws
- Define the pure core boundary explicitly in the architecture
- Choose a stack that supports FP well (or define conventions for FP in the chosen stack)
- Document the effect handling strategy (which library/pattern for the imperative shell)

### During /p0g-tasks (Task Breakdown)

- Create tasks that build the algebra layer first (types + signatures + laws)
- Then tasks for pure implementations of the algebra
- Then tasks for the imperative shell (adapters, handlers, I/O)
- Verification commands should validate algebraic laws (property-based tests preferred)

### During /p0g-loop (Execution)

- Never write a function with side effects in the pure core — the executor must check
- All domain functions must be testable by calling them with inputs and checking outputs (no setup required)
- Prefer property-based tests over example-based tests for algebraic laws
- If the executor needs to write I/O code, it goes in the shell layer ONLY

### During /p0g-surgeon (Bug Fixing)

- During diagnosis, check if the bug is caused by impurity leaking into the core
- Micro-fixes that touch the pure core must maintain referential transparency
- If a fix requires adding a side effect, it must be pushed to the shell layer

## Code Review Checklist

Before marking any task as `passes: true`, verify:

- [ ] No mutable state in the pure core
- [ ] No exceptions thrown for control flow
- [ ] All errors represented as values (`Result`, `Either`, `Option`)
- [ ] No I/O in the pure core (no `fetch`, `fs`, `console.log`, database calls)
- [ ] All functions are referentially transparent
- [ ] Data transformations use immutable operations
- [ ] Effects are described as values, executed at the boundary
- [ ] Algebraic laws are documented and tested for core types

## Anti-Patterns to Block

| Anti-Pattern | Why | Fix |
|--------------|-----|-----|
| `throw new Error(...)` in domain logic | Breaks referential transparency | Return `Result.err(...)` |
| `array.push(item)` / `obj.field = x` | Mutation | `[...array, item]` / `{ ...obj, field: x }` |
| `async function` in pure core | Effect in wrong layer | Return effect description, await in shell |
| `if (x === null)` without type safety | Silent failure path | Use `Option<T>` and pattern match |
| Global config/state import | Hidden dependency | Pass as function parameter or use Reader |
| Mock-heavy tests | Indicates impure core | Refactor to pure functions, test with values |
| `try { ... } catch { return default }` | Swallowed error | Use `Result.map()` / `Result.flatMap()` |

---

## Installation

Copy this file into your project's Antigravity rules:

```bash
cp paradigms/functional.md .agent/rules/functional.md
```

Or during P0G installation:

```bash
curl -sSL https://raw.githubusercontent.com/yz9yt/P0G/main/install.sh | bash -s -- --paradigm functional
```
