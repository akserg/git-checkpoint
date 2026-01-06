# Contributing

This document describes how to contribute to git-checkpoint.

The project prioritizes clarity, safety, and explicit control over convenience or automation.

---

## Scope of contributions

Contributions are welcome in the following areas:

- Core checkpoint workflow
- Guardrails and safety policies
- Terminal UI (TUI)
- CLI commands and flags
- Documentation
- Integrations (GitHub, Jira, CI tools)

Out of scope by default:
- Git replacements
- Heavy abstraction layers
- Provider-specific AI logic
- Background automation without user control

---

## Design principles

All contributions must follow these principles:

- Git remains the source of truth
- No hidden or implicit destructive actions
- Human intent must always be explicit
- Safety over convenience
- Minimal dependencies
- Terminal-first UX

If a change violates these principles, it will not be accepted.

---

## Repository structure

```

git-checkpoint/
├─ cmd/            # CLI entry points
├─ tui/            # Terminal UI
├─ scripts/        # Shell-based implementation
├─ aliases/        # git alias snippets
├─ integrations/   # Optional external integrations
├─ docs/           # Documentation
└─ examples/       # Example configs

```

Contributors should respect existing boundaries between components.

---

## Development workflow

1. Fork the repository
2. Create a feature branch
3. Make small, focused changes
4. Add or update documentation if behavior changes
5. Submit a pull request

Recommended branch naming:
```

feature/<short-description>
fix/<short-description>
docs/<short-description>

```

---

## Commit guidelines

Commits should be:

- Small and focused
- Clearly described
- Logically scoped

Avoid:
- Large, mixed commits
- Reformat-only commits without justification
- Bundling unrelated changes

Checkpoint-style commits are acceptable during development,
but pull requests should present a clean, reviewable history.

---

## Pull request requirements

Every pull request must:

- Describe the problem being solved
- Explain the chosen approach
- State any behavior changes
- Reference related issues (if applicable)

Pull requests may be rejected if:
- They introduce unsafe defaults
- They bypass guardrails
- They reduce transparency
- They add unnecessary complexity

---

## Guardrails changes

Changes to guardrails require extra scrutiny.

When modifying guardrails:
- Clearly explain the motivation
- Describe impact on safety
- Document new behavior in `docs/guardrails.md`

Guardrails should be additive or configurable, not silently weakened.

---

## TUI contributions

For TUI changes:
- Prefer keyboard-driven interactions
- Avoid modal overload
- Keep destructive actions explicit
- Document new keybindings in `docs/tui.md`

Visual changes must not obscure critical information.

---

## Integrations

Integrations must be optional.

Rules:
- No hard dependency on external services
- Feature detection over configuration assumptions
- Fail gracefully when integrations are unavailable

Integrations should live under `integrations/`.

---

## Configuration changes

If a change introduces or modifies configuration:
- Update example config files
- Document defaults and fallback behavior
- Avoid breaking existing configs

Backward compatibility is preferred.

---

## Testing expectations

At minimum:
- Manual testing of affected workflows
- Verification on protected and non-protected branches
- Confirmation that failures do not leave the repo in a broken state

Automated tests are welcome but not required for every contribution.

---

## Documentation

Documentation changes are first-class contributions.

If behavior changes, documentation must be updated in the same PR.

Avoid:
- Marketing language
- Buzzwords
- Vague descriptions

Documentation should describe behavior, not intent.

---

## Code of conduct

Contributors are expected to communicate professionally and respectfully.

Technical disagreement is acceptable.
Personal attacks are not.
