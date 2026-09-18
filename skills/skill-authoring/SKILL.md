---
name: skill-authoring
description: How to add, edit, and organize skills in the Paprika skill set. Use when the user dictates rules, conventions, preferences, or guidance they want AIs to follow in future projects, or asks to create, update, split, or review a skill in this repository.
---

# Skill authoring

This skill turns rules and suggestions the user gives in conversation into
durable, reusable skill files in this repository.

## Rules

### MUST
- Every skill lives at `skills/<name>/SKILL.md` with YAML frontmatter containing `name` and `description`.
- `name` is kebab-case, matches its directory name, and is 64 characters or fewer.
- `description` says what the skill covers AND when to use it, in one or two sentences, with the trigger words a task would contain.
- Each rule is tagged with exactly one strength: MUST, SHOULD, MAY, or NEVER, and is stated as a single testable sentence.
- Run `scripts/validate.sh` before committing and fix every reported problem.
- Update `skills/README.md` (the catalog) whenever a skill is added, renamed, or removed.

### SHOULD
- One skill covers one topic. Split a skill that mixes unrelated concerns.
- Keep SKILL.md under about 300 lines. Move long reference material into a sibling file and link it.
- Write rules as observable behavior, not intent. "Run the test suite before pushing" beats "care about quality".
- Include at least one good and one bad example when a rule is easy to misread.
- Record the reason behind a rule in the Rationale section so an AI can extrapolate to unlisted cases.

### MAY
- Add `paths:` to the frontmatter when a skill only applies to certain file types.
- Add supporting files such as `reference.md`, `examples.md`, or `scripts/` next to SKILL.md.

### NEVER
- Put rules in the README instead of a skill. The README explains the repo; skills carry the rules.
- Weaken a MUST to a SHOULD without the user's agreement.
- Include secrets, credentials, internal hostnames, or personal data in a skill.

## How to apply

When the user gives you rules or guidance:

1. **Capture verbatim first.** Restate each rule back in one line so nothing is lost or reinterpreted.
2. **Classify.** For each rule decide the strength (MUST, SHOULD, MAY, NEVER) from the user's wording. "Always" and "never" map to MUST and NEVER. "Prefer", "ideally", and "usually" map to SHOULD. "You can" maps to MAY. Ask only when the wording is genuinely ambiguous.
3. **Find the home.** Read `skills/README.md`. If an existing skill covers the topic, add the rule there. Otherwise create a new skill from `templates/SKILL.md`.
4. **Write it.** Fill in the template. Keep the description specific enough that the skill loads for the right tasks and not for unrelated ones.
5. **Validate.** Run:

   ```bash
   scripts/validate.sh
   claude plugin validate .
   ```

6. **Catalog.** Add or update the row in `skills/README.md`.
7. **Commit.** One commit per skill or per coherent batch of rule changes, with a message that names the skill.

## Examples

Good description:

```yaml
description: Git commit and branch conventions for this team. Use when committing, writing commit messages, naming branches, or opening pull requests.
```

Bad description:

```yaml
description: Git stuff.
```

The bad version gives no trigger words, so the skill will load at the wrong times or not at all.

## Rationale

Skills are only useful if they load at the right moment and are unambiguous
once loaded. A precise description handles the first problem. Strength tags
and testable sentences handle the second. The catalog keeps the set
discoverable as it grows.

## Related skills

- All other skills in this repository follow the format defined here.
