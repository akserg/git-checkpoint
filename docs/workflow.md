# Workflow

This document describes the checkpoint-driven workflow promoted by git-checkpoint.

The workflow is designed to make iterative development safer and more controllable,
especially when changes are frequent, automated, or partially delegated to tools.

---

## Core principles

- Work happens on dedicated branches
- Progress is recorded as checkpoints
- Rollback is cheap and intentional
- Merge is explicit and reviewed
- Git remains the source of truth

---

## Basic flow

1. Create a task branch
2. Make small changes
3. Create checkpoints frequently
4. Inspect diffs and history
5. Roll back when needed
6. Merge when satisfied
7. Clean up temporary artifacts

---

## Branching model

### Task branches

All work starts on a task branch.

Recommended naming:
```

checkpoint/<task-id>
feature/<task-id>
experiment/<task-id>

```

Protected branches (example):
```

main
release/*

```

Hard rollback is disabled on protected branches by default.

---

## Creating checkpoints

A checkpoint is a temporary safety point represented by a Git commit.

Characteristics:
- Small, incremental
- May be incomplete or experimental
- Not intended as final project history

Typical usage:
- After a logical step
- Before risky changes
- Before delegating work to automation
- After automation completes a step

Checkpoints should be cheap to create and cheap to discard.

---

## Inspecting checkpoints

Before continuing or merging, inspect checkpoints:

- Review commit messages
- Inspect diffs
- Identify the last known good state

The interactive TUI is intended for:
- Browsing checkpoint history
- Previewing diffs
- Selecting rollback targets

---

## Rollback

Rollback restores a previous state.

There are two rollback strategies:

### Hard rollback

- Resets branch state to a selected checkpoint
- Discards all later commits

Intended for:
- Task branches
- Experimental work
- Automated changes

Not allowed on protected branches by default.

---

### Revert rollback

- Creates a new commit that reverses changes
- Preserves history

Intended for:
- Shared branches
- Protected branches
- Situations where history must remain intact

---

## Selective recovery

It is possible to recover specific files from a checkpoint:

- Restore a single file
- Restore a subset of files
- Manually apply parts of a diff

This is useful when only part of a change is incorrect.

---

## Guardrails

Guardrails prevent destructive operations.

Typical guardrails:
- Disallow hard rollback on protected branches
- Warn on large diffs
- Warn when protected paths are modified
- Require confirmation for destructive actions

Guardrails are enforced by the tool, not by Git itself.

---

## Merging

Merging is a deliberate action.

Recommended practices:
- Merge only from a clean, inspected state
- Prefer non-fast-forward merges to preserve context
- Avoid merging experimental checkpoints directly

After merging:
- Delete task branches
- Remove temporary tags
- Clean up local state

---

## Failure recovery

If a workflow is interrupted:
- The repository remains in a valid Git state
- All checkpoints remain accessible
- Work can resume from the last checkpoint

No special recovery steps are required beyond standard Git operations.

---

## When not to use checkpoints

Checkpoint-driven workflow is not intended for:
- Final release commits
- Long-lived historical branches
- Situations where commit history must be pristine

In those cases, standard Git practices apply.
