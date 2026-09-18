# Paprika skills

A shared set of rules and guidance that Claude and other AI assistants follow
when working on our projects. Each rule set is a **skill**: a folder with a
`SKILL.md` that says what to do, when it applies, and why.

The repository is both a Claude Code **plugin** (skills load with a
`paprika:` prefix) and a **marketplace** that publishes that plugin, so it can
be pulled into any project with one command. The skill files are plain
Markdown, so other AI tools can read them too.

## Use it in a project

**Claude Code, via the marketplace (recommended):**

```text
/plugin marketplace add fixerseven/paprika-skills
/plugin install paprika@paprika-skills
```

Skills then appear as `/paprika:<skill-name>` and load automatically when a
task matches their description.

**Claude Code, for one session without installing:**

```bash
claude --plugin-dir /path/to/paprika-skills
```

**Any project, as a git submodule** (works for tools that just read Markdown):

```bash
git submodule add https://github.com/fixerseven/paprika-skills .claude/skills/paprika
```

**Pin it in a project's `CLAUDE.md`** so the assistant knows the rules apply:

```markdown
Follow the Paprika skills. Read `.claude/skills/paprika/skills/README.md`
for the catalog and load the relevant skill before starting work.
```

## What is in here

| Path | Purpose |
|------|---------|
| `skills/README.md` | Catalog of every skill and when it applies |
| `skills/<name>/SKILL.md` | One skill per folder |
| `templates/SKILL.md` | Starting point for a new skill |
| `scripts/validate.sh` | Checks frontmatter, naming, rule tags, and the catalog |
| `.claude-plugin/plugin.json` | Plugin manifest |
| `.claude-plugin/marketplace.json` | Marketplace manifest |
| `CLAUDE.md` | Instructions for an AI working inside this repo |

## Rule strength

Rules use RFC 2119 words so nothing is left to tone:

| Tag | Meaning |
|-----|---------|
| MUST | Always. Not skipped without the user saying so. |
| SHOULD | Strong default. Deviate only with a stated reason. |
| MAY | Allowed, sometimes helpful. |
| NEVER | Hard prohibition. |

## Adding a skill

1. Copy `templates/SKILL.md` to `skills/<kebab-name>/SKILL.md`.
2. Fill in the frontmatter, rules, examples, and rationale.
3. Add a row to `skills/README.md`.
4. Run `scripts/validate.sh` and `claude plugin validate .`.
5. Commit.

The `skill-authoring` skill has the full process, including how to turn
conversational rules into skill files.

## Versioning

Bump `version` in `.claude-plugin/plugin.json` when skills change in a way
users of the plugin should pick up. Claude Code uses that version to detect
updates.
