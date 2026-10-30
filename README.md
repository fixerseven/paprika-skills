# Paprika skills

A shared set of rules and guidance that Claude and other AI assistants follow
when working on our projects. Each rule set is a **skill**: a folder with a
`SKILL.md` that says what to do, when it applies, and why.

The repository is both a Claude Code **plugin** (skills load with a
`paprika:` prefix) and a **marketplace** that publishes that plugin, so it can
be pulled into any project with one command. The skill files are plain
Markdown, so other AI tools can read them too.

## Deploy it

Pick the routes that match where you work. Most people want all three.

| Where you work | Route | Covers |
|----------------|-------|--------|
| Claude Code on your own machine | Install once at user scope | Every project on that machine |
| Claude Code on the web (cloud) | Environment setup script | Every session in that environment |
| A shared repo with teammates | Project settings in the repo | Everyone who opens it in a terminal |

**Your machine.** Run once in any Claude Code session:

```text
/plugin marketplace add fixerseven/paprika-skills
/plugin install paprika@paprika-skills
```

Then open `/plugin`, go to the Marketplaces tab, and turn on auto-update for
`paprika-skills` so new skills arrive at session start.

**Cloud sessions.** Cloud sessions ignore plugins turned on in a repo's
settings, so install from the environment instead. On claude.ai, edit the
environment's setup script and add the contents of
[`scripts/cloud-setup.sh`](scripts/cloud-setup.sh):

```bash
claude plugin marketplace add fixerseven/paprika-skills
claude plugin install paprika@paprika-skills
```

The setup script runs before Claude Code starts, so every session in that
environment has the skills, whichever repository it opens.

**A shared repo.** From a clone of this repo, run:

```bash
scripts/add-to-project.sh /path/to/project
```

It adds the marketplace and plugin to the project's `.claude/settings.json`,
keeping any existing settings, and adds a short pointer to its `CLAUDE.md`.
Commit both in the project. Teammates get the skills after they accept the
workspace trust prompt.

**Other AI tools.** The skills are plain Markdown under `skills/<name>/SKILL.md`.
Tools that read Markdown can be pointed at them directly. For Codex and Cursor,
the `skills` installer is designed to pick up this layout (not yet tested here):

```bash
npx skills add fixerseven/paprika-skills
```

**Using them.** Skills load on their own when a task matches their
description. To call one by name, use `/paprika:<skill-name>`, for example
`/paprika:seo-launch-checklist` or `/paprika:watch <video url>`.

## What is in here

| Path | Purpose |
|------|---------|
| `skills/README.md` | Catalog of every skill and when it applies |
| `skills/<name>/SKILL.md` | One skill per folder |
| `templates/SKILL.md` | Starting point for a new skill |
| `intake/` | Log and notes for sources fed in with `/watch` |
| `scripts/validate.sh` | Checks frontmatter, naming, rule tags, and the catalog |
| `scripts/cloud-setup.sh` | Setup-script lines for a cloud environment |
| `scripts/add-to-project.sh` | Turns the plugin on in another repo |
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

The plugin manifest deliberately has no `version` field. Claude Code then
uses the commit hash to detect updates, so every push to the default branch
is a new version. To pull it into an installed session:

```text
claude plugin update paprika@paprika-skills
/reload-plugins
```
