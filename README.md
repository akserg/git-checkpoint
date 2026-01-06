# git-checkpoint

A terminal-first, checkpoint-driven workflow for Git — with rollback, guardrails, and an interactive TUI.  
AI-friendly, human-controlled.

## What it is

git-checkpoint is a thin layer on top of Git that makes iterative work safer by encouraging frequent checkpoints and deliberate rollback.

It does not replace Git.  
It formalizes a workflow around it.

## Core ideas

- Checkpoints are temporary safety points, not permanent history
- Rollback is a first-class operation
- Guardrails prevent destructive actions on protected branches
- Humans stay in control of final outcomes
- Works with or without AI-assisted tools

## Features

- Explicit checkpoint creation
- Fast rollback (hard reset or revert, depending on policy)
- Interactive terminal UI for browsing and managing checkpoints
- Branch and path guardrails
- Optional integrations (GitHub, Jira, etc.)
- Multiple usage levels:
  - git aliases
  - shell scripts
  - standalone CLI

## Non-goals

- Replacing Git workflows
- Hiding Git concepts
- Automatic merging without review
- Tying the tool to any specific AI provider

## Status

Early development.

Interfaces and workflows may change.

## License

MIT
