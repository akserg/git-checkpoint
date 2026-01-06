# Guardrails

This document defines guardrails enforced by git-checkpoint.

Guardrails are safety rules designed to prevent destructive or irreversible operations
during checkpoint-driven workflows.

They do not replace Git.
They constrain how Git is used.

---

## Purpose

Guardrails exist to:

- Prevent accidental data loss
- Protect shared and critical branches
- Make destructive actions explicit
- Encourage deliberate decision-making
- Keep humans in control of outcomes

---

## Scope

Guardrails apply to:

- Checkpoint creation
- Rollback operations
- Merge operations
- File and path modifications

Guardrails are enforced by the tool, not by Git itself.

---

## Branch protection

### Protected branches

Protected branches are branches where destructive operations are restricted.

Typical protected branches:
```

main
release/*
hotfix/*

```

Default rules:
- Hard rollback is not allowed
- Force reset is not allowed
- Destructive operations require explicit confirmation or are blocked entirely

---

### Non-protected branches

Examples:
```

checkpoint/*
feature/*
experiment/*

```

Default rules:
- Hard rollback is allowed
- History rewriting is allowed
- Experimental checkpoints are expected

---

## Rollback guardrails

### Hard rollback

Hard rollback (`reset --hard`) is:

- Allowed on non-protected branches
- Disallowed on protected branches by default

Before execution:
- The tool must display the target commit
- The tool must show affected commits
- User confirmation is required

---

### Revert rollback

Revert rollback (`git revert`) is:

- Allowed on all branches
- Preferred on protected branches
- Preserves commit history

Used when:
- History must remain intact
- The branch is shared
- Changes were already published

---

## Checkpoint guardrails

### Empty checkpoints

- Creating a checkpoint with no changes is disallowed
- The tool must report a clean working tree

---

### Large diffs

If a checkpoint exceeds configured thresholds:
- Number of files changed
- Total lines added/removed

The tool should:
- Display a warning
- Require explicit confirmation

Large checkpoints are discouraged but not forbidden.

---

## Path protection

Certain paths may be marked as protected.

Examples:
```

ProjectSettings/
Packages/manifest.json
.github/

```

Rules:
- Modifying protected paths triggers a warning
- Destructive operations on protected paths require confirmation
- Optional hard block unless `--force` is used

---

## Merge guardrails

### Merge prerequisites

Before merging:
- Working tree must be clean
- Current branch must not be protected
- Merge target must be explicitly specified

---

### Merge strategy

Recommended defaults:
- Non-fast-forward merges (`--no-ff`)
- No automatic squash unless explicitly requested

The tool should not:
- Automatically merge without user intent
- Hide merge strategy details

---

## Destructive action confirmation

For destructive operations, the tool must:

- Clearly state what will happen
- Identify the branch and commit
- Require explicit user confirmation

Silent destructive actions are not allowed.

---

## Automation boundaries

Guardrails define clear limits for automation.

Automated tools may:
- Create checkpoints
- Suggest rollback targets
- Prepare merges

Automated tools must not:
- Perform destructive actions without confirmation
- Override protected branch rules
- Bypass guardrails

---

## Configuration

Guardrails may be customized via configuration.

Configurable aspects:
- Protected branches
- Protected paths
- Diff size thresholds
- Default rollback strategy

Defaults should prioritize safety over convenience.

---

## Failure behavior

If guardrails block an operation:
- No changes are made
- The repository remains unchanged
- A clear explanation is shown

Guardrails must fail safe.
