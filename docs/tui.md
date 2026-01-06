# Terminal UI (TUI)

This document describes the interactive terminal UI provided by git-checkpoint.

The TUI is designed for fast inspection and deliberate control of checkpoint-driven workflows
directly from the terminal.

---

## Goals

- Provide a clear overview of checkpoints
- Make rollback and recovery explicit
- Enable fast inspection of diffs
- Reduce reliance on raw Git commands
- Preserve full user control

---

## Entry points

The TUI is invoked via:

```

git-checkpoint view

```

or via git alias:

```

git viewcp

```

---

## Layout

The TUI is split into three primary panels.

### 1. Checkpoint list (left)

Displays a chronological list of checkpoint commits.

Information shown per entry:
- Short commit hash
- Commit message
- Timestamp
- Branch indicator

Only commits matching the configured checkpoint prefix are shown by default.

---

### 2. Diff preview (right)

Displays the diff for the selected checkpoint.

Capabilities:
- File list view
- Unified diff view
- Scrollable content
- Syntax-aware highlighting (where possible)

The diff panel updates as selection changes.

---

### 3. Status bar (bottom)

Displays:
- Current branch
- Selected commit
- Pending action (if any)
- Contextual hints

---

## Navigation

### Basic movement

Keybindings:
```

j / Down    Move selection down
k / Up      Move selection up
h / Left    Focus previous panel
l / Right   Focus next panel

```

---

### Scrolling

```

Ctrl+d      Scroll down half-page
Ctrl+u      Scroll up half-page
g           Jump to top
G           Jump to bottom

```

---

## Actions

All actions are explicit and require user intent.

### Create checkpoint

`c`

- Prompts for commit message
- Creates a new checkpoint commit
- Fails if working tree is clean

---

### Hard rollback

`r`

- Rolls back current branch to selected checkpoint
- Only allowed on non-protected branches
- Requires confirmation

---

### Revert rollback

`v`

- Creates a revert commit for the selected checkpoint
- Allowed on all branches
- Preserves history

---

### Tag checkpoint

`t`

- Assigns a lightweight tag to selected checkpoint
- Tag format is configurable

---

### Branch from checkpoint

`b`

- Creates a new branch from selected checkpoint
- Switches to the new branch after creation

---

### Merge branch

`m`

- Merges current branch into a selected target branch
- Displays merge strategy before execution
- Requires confirmation

---

## Confirmation flow

Destructive actions trigger a confirmation dialog.

Confirmation dialog must display:
- Action type
- Target branch
- Target commit
- Consequences

Actions are aborted unless explicitly confirmed.

---

## Filtering and search

### Filter checkpoints

`/`

- Filter by commit message
- Filter by author
- Filter by date range

---

### Toggle non-checkpoint commits

`F`

- Toggle visibility of non-checkpoint commits
- Disabled by default

---

## Protected context indicators

The TUI must visually indicate:

- Protected branches
- Protected paths (when visible in diff)
- Disallowed actions

Indicators must be subtle and non-intrusive.

---

## Error handling

On error:
- Display a clear message
- Preserve current selection
- Do not exit the TUI unless necessary

Errors must not leave the repository in an intermediate state.

---

## Extensibility

The TUI should be designed to allow:

- Additional panels
- Custom keybindings
- Integration indicators (e.g., GitHub PR status)

Extensibility must not compromise core usability.

---

## Exit

`q`

- Exit the TUI without side effects
