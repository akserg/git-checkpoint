# Configuration

This document describes the configuration format used by git-checkpoint.

Configuration is optional.
If no configuration is present, safe defaults are used.

---

## Configuration file

The tool looks for a configuration file in the repository root:

```

.git-checkpoint.yaml

````

Alternative names are not supported.

---

## Configuration goals

- Define safety policies
- Customize guardrails
- Control defaults without hiding Git behavior
- Remain readable and explicit

Configuration must not:
- Enable silent destructive actions
- Override protected branch rules implicitly
- Hide Git semantics

---

## Example configuration

```yaml
version: 1

branches:
  protected:
    - main
    - release/*
    - hotfix/*

paths:
  protected:
    - ProjectSettings/
    - Packages/manifest.json
    - .github/

checkpoints:
  prefix: "checkpoint:"
  autoTag: false
  tagFormat: "cp-%02d"

rollback:
  defaultStrategy: hard
  allowHardOnProtected: false
  requireConfirmation: true

merge:
  defaultStrategy: no-ff
  allowSquash: true
  requireCleanTree: true

diff:
  warnFilesChanged: 20
  warnLinesChanged: 500

tui:
  showNonCheckpointCommits: false
  confirmDestructiveActions: true

integrations:
  github:
    enabled: false
  jira:
    enabled: false
````

---

## Configuration reference

### version

```yaml
version: 1
```

Required.

Used for future compatibility.
Unsupported versions must fail explicitly.

---

## branches

### branches.protected

```yaml
branches:
  protected:
    - main
    - release/*
```

Defines protected branches.

Rules:

* Hard rollback is disallowed
* History rewriting is disallowed
* Destructive actions require confirmation or are blocked

Wildcard patterns are supported.

---

## paths

### paths.protected

```yaml
paths:
  protected:
    - ProjectSettings/
    - Packages/manifest.json
```

Defines protected paths.

Behavior:

* Modifying protected paths triggers warnings
* Destructive operations require confirmation
* May be blocked unless `--force` is used

Paths may be directories or files.

---

## checkpoints

### checkpoints.prefix

```yaml
checkpoints:
  prefix: "checkpoint:"
```

Commit message prefix used to identify checkpoints.

Only commits with this prefix are treated as checkpoints by default.

---

### checkpoints.autoTag

```yaml
autoTag: false
```

If enabled:

* Automatically tags checkpoints
* Tags are lightweight

Disabled by default.

---

### checkpoints.tagFormat

```yaml
tagFormat: "cp-%02d"
```

Defines the tag naming format when auto-tagging is enabled.

---

## rollback

### rollback.defaultStrategy

```yaml
rollback:
  defaultStrategy: hard
```

Possible values:

* `hard`
* `revert`

Applied only on non-protected branches.

---

### rollback.allowHardOnProtected

```yaml
allowHardOnProtected: false
```

If false:

* Hard rollback is blocked on protected branches

---

### rollback.requireConfirmation

```yaml
requireConfirmation: true
```

If true:

* All rollback actions require explicit confirmation

---

## merge

### merge.defaultStrategy

```yaml
merge:
  defaultStrategy: no-ff
```

Possible values:

* `no-ff`
* `ff`
* `squash`

---

### merge.allowSquash

```yaml
allowSquash: true
```

Controls whether squash merges are permitted.

---

### merge.requireCleanTree

```yaml
requireCleanTree: true
```

If true:

* Merge is blocked when working tree is dirty

---

## diff

### diff.warnFilesChanged

```yaml
warnFilesChanged: 20
```

Displays a warning if a checkpoint modifies more than the specified number of files.

---

### diff.warnLinesChanged

```yaml
warnLinesChanged: 500
```

Displays a warning if a checkpoint modifies more than the specified number of lines.

---

## tui

### tui.showNonCheckpointCommits

```yaml
showNonCheckpointCommits: false
```

Controls visibility of non-checkpoint commits in the TUI.

---

### tui.confirmDestructiveActions

```yaml
confirmDestructiveActions: true
```

If true:

* All destructive actions in the TUI require confirmation

---

## integrations

Integrations are optional and disabled by default.

### integrations.github

```yaml
github:
  enabled: false
```

Requires `gh` CLI to be available.

---

### integrations.jira

```yaml
jira:
  enabled: false
```

Requires Jira credentials to be configured externally.

---

## Validation rules

* Unknown keys must produce warnings
* Invalid values must fail explicitly
* Missing optional sections use defaults
* Missing required fields must fail

---

## Defaults

If no configuration file is present:

* Only non-protected branches allow hard rollback
* No paths are protected
* Checkpoint prefix is `checkpoint:`
* TUI hides non-checkpoint commits
