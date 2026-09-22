---
name: ai-session-policy
description: Standing instructions for how AI sessions work on the owner's projects. Model choice for planning versus building, complete output with no placeholders, when to ask instead of assume, running several sessions side by side, and how rules are referenced rather than copied. Use at the start of any session and whenever delegating work to subagents.
---

# AI session policy

The owner runs many AI sessions across many repositories. These rules keep
them consistent with each other and with the owner's intent.

## Rules

### MUST
- Use the most capable model available for planning, ideation, and orchestration. Delegate the building, such as writing HTML, CSS, and JS, long documents, and mechanical edits, to subagents on a cheaper model.
- Produce complete output. No placeholder comments, no "rest of the code here", no truncated files. If output must be split across messages, say where the split is and continue cleanly.
- Read the repo's `CLAUDE.md`, `HANDOFF.md`, and the relevant spec section before doing anything.
- When a decision is not covered by the docs, add it to the Open decisions list and ask the owner. Do not pick an answer silently.
- Reference the single source of a rule rather than restating it. `VOICE.md` and `DESIGN.md` are read in full, not summarised into another file.
- Leave the repository in a state the next session can pick up: docs updated, handoff written, branch pushed.

### SHOULD
- Expect other sessions to be running on the same repository at the same time. Use fixed ports from the repo's launch config, work on your own branch, and do not assume the working tree is yours alone.
- Sign commits with the co-author trailer the harness provides, so the history shows which sessions did what.
- Name memories and concept notes so a later session can find them by name.

### NEVER
- Widen the task on your own. Do what was asked, note what else you saw, and stop.
- Guess an owner decision to avoid asking. A wrong guess costs a rebuild.
- Silently violate a documented rule because a filter or a preference disagrees with it. Change the doc in the same commit and say why, or follow the doc.

## How to apply

1. Read `CLAUDE.md`, `HANDOFF.md`, and the spec.
2. Plan with the capable model. Write the plan down per `plan-then-build`.
3. Delegate build tasks to subagents with a complete brief: goal, files, constraints, and what done looks like.
4. Review the subagents' output yourself before committing it.
5. Ask about anything undecided. Record the answer in the docs.
6. Update the handoff and push.

## Examples

Good delegation brief:

```text
Build the Members import preview table in app/static/js/members.js.
Read DESIGN.md first. Dry-run rows come from POST /api/members/import.
Show action, matched_by, and the row. Done when the 4 actions render
with the design tokens and the existing tests still pass.
```

Bad:

```text
Make the import UI nice.
```

## Rationale

The owner has stated the model split as a standing instruction, and the repositories show the pattern in practice: long planning commits from one model, mechanical build commits from another, and several launch configurations for parallel sessions. Sources: the model policy section of `CLAUDE.md` in andar-deck, `.claude/launch.json` in nest-pos-project, and the full-output skill installed in andar-deck-live.

## Related skills

- `plan-then-build` - the loop each session runs.
- `project-docs` - where to record decisions and handoffs.
