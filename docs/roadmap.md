# Roadmap

This document outlines the planned evolution of git-checkpoint.

The roadmap prioritizes correctness, safety, and usability over feature count.
Each phase is usable on its own.

---

## Guiding principles

- Ship usable increments
- Preserve Git transparency
- Avoid breaking workflows
- Prefer opt-in features
- Keep human control explicit

---

## Phase 0 — Foundation

Goal: establish a stable conceptual and documentation baseline.

Status:
- Completed

Scope:
- Core workflow definition
- Guardrails policy
- CLI specification
- TUI specification
- Configuration schema
- Contribution guidelines

Outcome:
- Clear, implementation-ready specifications
- No code yet

---

## Phase 1 — Shell-based implementation

Goal: provide a minimal, working tool using shell scripts.

Scope:
- `scripts/git-checkpoint` engine
- Commands:
  - checkpoint
  - rollback
  - merge
  - status
- Guardrails:
  - protected branches
  - hard rollback restrictions
- Minimal configuration parsing
- Exit codes and error handling

Out of scope:
- TUI
- Integrations
- Advanced diff analysis

Outcome:
- Usable tool for daily work
- Reference behavior for later implementations

---

## Phase 2 — Git aliases

Goal: reduce friction and improve discoverability.

Scope:
- `.gitconfig` alias snippets
- Aliases mapped to shell engine
- Documentation for setup and usage

Constraints:
- Aliases must not contain logic
- Behavior must be identical to shell commands

Outcome:
- Zero-install entry point
- Easy onboarding for individual developers

---

## Phase 3 — Standalone CLI (Go or Node)

Goal: replace shell implementation with a robust CLI.

Scope:
- Single binary or package
- Full command set:
  - checkpoint
  - rollback
  - merge
  - view
  - config
- Configuration validation
- Structured error handling
- Improved diff inspection

Out of scope:
- Integrations
- TUI extensions

Outcome:
- Stable CLI suitable for teams and CI
- Foundation for TUI and integrations

---

## Phase 4 — Interactive TUI

Goal: enable fast, controlled checkpoint management.

Scope:
- Checkpoint list view
- Diff preview
- Rollback, revert, branch, and merge actions
- Confirmation flows
- Keyboard-driven navigation

Constraints:
- No hidden actions
- No background automation
- Explicit confirmations for destructive actions

Outcome:
- Primary interface for interactive use
- Reduced reliance on raw Git commands

---

## Phase 5 — Guardrails expansion

Goal: strengthen safety and policy enforcement.

Scope:
- Protected paths enforcement
- Diff size warnings
- Configurable thresholds
- Improved messaging and diagnostics

Outcome:
- Safer workflows on large or shared repositories

---

## Phase 6 — Integrations (optional)

Goal: integrate with external developer tooling without coupling.

Scope:
- GitHub integration via `gh` CLI
  - PR creation
  - PR status indicators
- Jira integration (optional)
  - Issue linking
- CI compatibility

Constraints:
- Integrations must be optional
- No hard dependencies
- Graceful degradation

Outcome:
- Better visibility and traceability
- No lock-in

---

## Phase 7 — Extensibility and polish

Goal: make the tool adaptable and maintainable.

Scope:
- Plugin-style integration hooks
- Custom guardrails
- TUI customization
- Documentation refinements
- Performance tuning

Outcome:
- Long-term sustainability
- Community contributions

---

## Non-goals (explicit)

The following are not planned:

- Replacing Git
- Background agents or daemons
- Automatic merges without review
- Provider-specific AI features
- GUI applications

---

## Release philosophy

- Prefer frequent, small releases
- Backward compatibility when possible
- Breaking changes require documentation and migration notes
