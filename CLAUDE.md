# Working in paprika-skills

This repository holds reusable skills: rules and guidance for AI assistants
working on the owner's projects. Your job here is to turn what the user tells
you into well-formed skill files.

## Before you change anything

- Read `skills/README.md` for the current catalog.
- Load the `skill-authoring` skill (`skills/skill-authoring/SKILL.md`). It
  defines the format and the intake process. Follow it.

## Intake process, in short

1. Restate each rule the user gives you in one line so they can correct it.
2. Tag each with MUST, SHOULD, MAY, or NEVER based on their wording.
3. Add it to the existing skill that covers the topic, or create a new one
   from `templates/SKILL.md`.
4. Add or update the catalog row in `skills/README.md`.
5. Run `scripts/validate.sh` and `claude plugin validate .` and fix anything
   reported.
6. Commit with a message that names the skill.

If the user mentions a topic but does not give enough to write rules yet, add
it to the **Planned** table in `skills/README.md` instead of inventing rules.

## Conventions

- Skill folders are kebab-case and match the `name` in their frontmatter.
- One skill per topic. Split rather than grow a catch-all.
- Never put rules in `README.md`. It explains the repo; skills hold the rules.
- Never include secrets, credentials, hostnames, or personal data in a skill.
- Do not add a `version` field to `.claude-plugin/plugin.json`. Claude Code
  uses the commit hash for update detection, so every push is a new version.
