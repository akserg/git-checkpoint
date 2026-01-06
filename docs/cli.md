# Command Line Interface (CLI)

This document defines the command-line interface for git-checkpoint.

The CLI provides explicit commands for checkpoint-driven workflows while preserving
standard Git semantics and safety guarantees.

---

## Invocation

The CLI may be invoked as:

```

git-checkpoint <command> [options]

```

When installed with git aliases, commands may also be available as:

```

git checkpoint
git rollback
git mergecp
git viewcp

```

Aliases are convenience wrappers and must not change behavior.

---

## Commands overview

```

checkpoint     Create a checkpoint commit
rollback       Restore or revert to a checkpoint
merge          Merge a branch with guardrails
view           Launch interactive TUI
status         Show checkpoint-related status
config         Validate and display configuration
help           Show help

```

---

## checkpoint

Create a new checkpoint commit.

### Usage

```

git-checkpoint checkpoint [-m <message>] [--tag] [--force]

```

### Behavior

- Stages all modified files
- Creates a commit with the configured checkpoint prefix
- Fails if the working tree is clean
- Respects protected path rules unless `--force` is used

### Options

```

-m, --message <text>     Commit message (without prefix)
--tag                    Create a tag for the checkpoint
--force                  Allow protected path modifications

```

### Exit codes

```

0  Success
1  No changes to checkpoint
2  Guardrail violation

```

---

## rollback

Rollback to a selected checkpoint.

### Usage

```

git-checkpoint rollback <commit|tag> [--hard|--revert] [--force]

```

### Behavior

- Default strategy is taken from configuration
- Strategy may be overridden via flags
- Destructive actions require confirmation

### Options

```

--hard                   Perform hard rollback (reset --hard)
--revert                 Perform revert rollback
--force                  Override guardrails (if allowed)

```

### Exit codes

```

0  Success
1  Invalid target
2  Guardrail violation
3  Operation cancelled

```

---

## merge

Merge the current branch into a target branch.

### Usage

```

git-checkpoint merge <target-branch> [--no-ff|--ff|--squash]

```

### Behavior

- Requires clean working tree
- Displays merge strategy before execution
- Uses configured default strategy unless overridden

### Options

```

--no-ff                  Force non-fast-forward merge
--ff                     Allow fast-forward merge
--squash                 Squash commits before merging

```

### Exit codes

```

0  Success
1  Merge conflict
2  Guardrail violation

```

---

## view

Launch the interactive terminal UI.

### Usage

```

git-checkpoint view

```

### Behavior

- Opens checkpoint browser
- No side effects until an action is confirmed

### Exit codes

```

0  Normal exit

```

---

## status

Display checkpoint-related status information.

### Usage

```

git-checkpoint status

```

### Output

- Current branch
- Protected status
- Number of checkpoints
- Dirty / clean working tree

### Exit codes

```

0  Success

```

---

## config

Validate and display configuration.

### Usage

```

git-checkpoint config [--print]

```

### Behavior

- Validates configuration file
- Displays errors or warnings
- Optionally prints resolved configuration

### Options

```

--print                  Print resolved configuration

```

### Exit codes

```

0  Valid configuration
1  Invalid configuration

```

---

## help

Display help information.

### Usage

```

git-checkpoint help [command]

```

---

## Error handling

- Errors must be printed to stderr
- Messages must be actionable and explicit
- No command may leave the repository in an intermediate state

---

## Output conventions

- Human-readable by default
- No color required, but allowed
- Stable output format for scripting is encouraged but optional

---

## Automation considerations

The CLI is designed to be:

- Scriptable
- Predictable
- Safe by default

Commands must not:
- Prompt unexpectedly in non-interactive contexts
- Perform destructive actions without confirmation
