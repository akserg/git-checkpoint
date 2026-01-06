# Issues

This document defines how issues are reported, labeled, and handled in git-checkpoint.

The goal is to keep issues actionable, traceable, and aligned with the project principles.

---

## Purpose

Issues are used to:

- Report bugs
- Propose enhancements
- Discuss design changes
- Track implementation work

Issues are not used for:
- General Git questions
- Support for unrelated tools
- Feature requests that bypass project principles

---

## Issue categories

Every issue must fall into one of the following categories.

### Bug

A defect that causes incorrect behavior.

Examples:
- Guardrails not enforced
- Rollback performs unexpected operation
- TUI leaves repository in an invalid state

---

### Enhancement

A change that improves usability, safety, or clarity without altering core principles.

Examples:
- Better diff preview
- Improved error messages
- Additional TUI navigation shortcuts

---

### Feature

A new capability that expands the tool.

Examples:
- New CLI command
- New integration
- New guardrail type

Features must align with the roadmap.

---

### Documentation

Issues related to missing, incorrect, or unclear documentation.

Examples:
- Incomplete workflow description
- Missing CLI examples
- Outdated configuration reference

---

### Discussion

Design or architectural discussions that may or may not result in changes.

Examples:
- Guardrail policy debate
- CLI UX trade-offs
- TUI layout alternatives

---

## Issue requirements

All issues must include:

- Clear title
- Category (bug, enhancement, feature, documentation, discussion)
- Description of the problem or proposal
- Expected behavior or outcome

Issues missing required information may be closed.

---

## Bug report guidelines

Bug reports should include:

- Tool version or commit hash
- Operating system
- Git version
- Exact command(s) executed
- Actual behavior
- Expected behavior

If possible, include:
- Minimal reproduction steps
- Relevant configuration
- Relevant output or logs

---

## Feature request guidelines

Feature requests must describe:

- The problem being solved
- Why existing workflows are insufficient
- Proposed behavior
- Impact on safety and guardrails

Requests that introduce:
- Hidden automation
- Implicit destructive behavior
- Provider lock-in

will be rejected.

---

## Documentation issues

Documentation issues should specify:

- File name
- Section
- What is unclear or incorrect
- Suggested correction (if possible)

---

## Labels

Recommended labels:

```

bug
enhancement
feature
documentation
discussion
guardrails
tui
cli
config
integration
breaking-change

```

Labels may be adjusted during triage.

---

## Triage process

Issues are triaged based on:

1. Safety impact
2. Correctness impact
3. Alignment with roadmap
4. Maintenance cost

Safety-related issues take priority.

---

## Resolution expectations

When an issue is resolved:

- The behavior change must be documented
- Relevant docs must be updated
- Breaking changes must be clearly noted

Issues may be closed without merge if:
- The proposal violates project principles
- The issue is out of scope
- The problem cannot be reproduced

---

## Automation

Automation may be used for:

- Label assignment
- Stale issue marking
- Template enforcement

Automation must not:
- Close issues silently
- Override human judgment

