---
name: plan-then-build
description: The working loop for features and milestones. Spec, then plan, then build, then self-review rounds, then handoff update, then pull request. Use when starting a feature, milestone, or non-trivial change, when tempted to add something nobody asked for, when a decision is unclear, or when finishing a round of work.
---

# Plan, then build

Write the design down before the code. Build only what was asked. Review your
own work before anyone else does. Leave the next session a handoff.

## Rules

### MUST
- Read the spec (`docs/SPEC.md` or `PRODUCT.md`) and `CLAUDE.md` before starting any milestone.
- For any non-trivial feature, write a dated design spec at `docs/superpowers/specs/YYYY-MM-DD-<slug>-design.md`, then an implementation plan at `docs/superpowers/plans/YYYY-MM-DD-<slug>.md`, then code. Commit them in that order.
- Structure the plan as: Goal, Architecture, Tech stack, Global constraints, target version, then numbered tasks with checkboxes. Justify any naming deviation inline.
- Build only what was asked. A feature nobody asked to use is not built, even when it seems obviously useful. Record the deliberate non-build with the reason and date.
- Extend the existing surface rather than build a parallel one. New panels go inside an existing tab. Ask before adding a new top-level surface.
- When a decision is missing, add it to the Open decisions list and ask. Do not assume.
- After implementing, do at least one self-review round against the spec. Commit fixes as "Fix round N: ..." listing the findings.
- Update `HANDOFF.md` at the end of every round: merged PRs with version and what they did, in-flight items, not-started items, decisions waiting on the owner.
- Keep a single version source of truth in code. Semver: major is a phase gate, minor is a milestone, patch is a fix. Put the version in the release commit subject and show it in the UI footer.

### SHOULD
- End the plan with a "Self-review against the spec" section and fill it in when done.
- State the test count in the commit body when tests changed: "266 tests passing (35 new)".
- Pull forward small slices from later milestones when they unblock real use, and say so in `CLAUDE.md`.

### NEVER
- Start code before the plan exists for anything bigger than a bug fix.
- Fork a second copy of shared logic for a script or a new entry point. Lift the core into the app package and call it from both.
- Rebuild something that exists because it is easier than reading it.

## How to apply

1. Read `CLAUDE.md`, the spec section for this milestone, and the latest `HANDOFF.md`.
2. Write the spec doc. Commit: "docs: <feature> design spec".
3. Write the plan doc with numbered tasks. Commit: "docs: <feature> implementation plan".
4. Work the tasks in order, ticking checkboxes, one change per commit.
5. Self-review against the spec. Fix and commit the round.
6. Update `HANDOFF.md` and the changelog entry in `CLAUDE.md`. Bump the version.
7. Open the PR per `git-workflow`.

## Examples

Good plan header:

```text
# 2026-09-01 Task board, slice 1
Goal: a shared to-do list for the team, not project management.
Target version: v1.22.0
Global constraints: one tasks table, status open -> done | cancelled only.
- [ ] 1. Migration: tasks + task_events
- [ ] 2. Gates as shared predicates in tasks.py
```

Bad:

```text
Let's add a task board. I'll figure out the schema as I go.
```

## Rationale

The owner's repositories show the same sequence in their commit history: spec, plan, code by layer, docs. Plans written first catch scope creep and let a later session pick up mid-feature. Self-review rounds are cheaper than a reviewer's round trip. Sources: `docs/superpowers/` in pepper-board, nest-pos-project, and household-bot, the "Build order" and "deliberately not built" entries in the Nest POS `CLAUDE.md`, and its `app/version.py`.

## Related skills

- `project-docs` - where each doc lives.
- `git-workflow` - commits and PRs.
