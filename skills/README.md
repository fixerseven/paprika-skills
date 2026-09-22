# Skill catalog

Every skill in the Paprika set, one row each. Keep this table in sync with
the `skills/` directory. `scripts/validate.sh` checks that they match.

| Skill | Covers | Use when |
|-------|--------|----------|
| [ai-session-policy](ai-session-policy/SKILL.md) | Standing rules for AI sessions: model split for planning versus building, complete output, ask instead of assume, parallel sessions, reference rules rather than restate | At the start of any session and when delegating to subagents |
| [backend-conventions](backend-conventions/SKILL.md) | Server-side rules: validation, public ids, soft delete, attribution, transactions, side effects after commit, one copy of every rule, money and time, migrations, logging, config | Writing backend code, schemas, migrations, jobs, or scripts |
| [cloudflare-sites](cloudflare-sites/SKILL.md) | Building, checking, and deploying static sites and small apps on Cloudflare Workers: one project per subdomain, wrangler in repo, assetsignore, build and link checks, headers, fonts, visibility | Creating or deploying a site or app, adding a subdomain, or setting headers and caching |
| [copywriting](copywriting/SKILL.md) | Marketing and sales copy: headlines, CTAs, landing pages, product pages, ads | Writing or reviewing copy meant to make a reader buy, sign up, or act |
| [data-honesty](data-honesty/SKILL.md) | The four honesty labels, no invented figures or names, client permission, prototypes shown as prototypes, null instead of estimates | Anything a customer or reader will see, quoting a figure, naming a client, showing example data, or marking something as live |
| [design-direction](design-direction/SKILL.md) | DESIGN.md as law, direction over filters, honesty over everything, measured contrast, kill list, motion and type rules, the finish gate, self-critique with screenshots | Before any visual or interface work and before declaring it done |
| [git-workflow](git-workflow/SKILL.md) | Branches, sentence-form commits, PR template, checks before push, red check is yours, merge commits, revert by PR | Creating branches, committing, opening or reviewing PRs, merging, or reverting |
| [no-ai-slop](no-ai-slop/SKILL.md) | Editing prose to remove AI-sounding patterns while keeping the writer's voice; detecting those patterns. Imported from [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop), see its `UPSTREAM.md` | A draft needs to read clearer, more direct, or less AI-sounding, or the user asks whether text reads as AI |
| [plan-then-build](plan-then-build/SKILL.md) | Spec, then plan, then build, then self-review rounds, then handoff. Build only what was asked, extend rather than rebuild, ask instead of assume, versioning | Starting a feature or milestone, finishing a round, or when tempted to add something unasked |
| [project-docs](project-docs/SKILL.md) | The standard doc set and what each holds: CLAUDE.md, PRODUCT.md, DESIGN.md, VOICE.md, HANDOFF.md, NEXT.md, ARCHITECTURE.md, SPEC.md, ADRs, dated specs and plans | Starting a project, recording a decision, or when a doc has drifted from the code |
| [secrets-and-env](secrets-and-env/SKILL.md) | Secrets on the host never in the repo, .env.example as documentation, single config module, verify without printing | Adding a credential or env var, deploying, or when output might contain a secret |
| [seo-launch-checklist](seo-launch-checklist/SKILL.md) | Pre-deploy checklist so a site can be found in Google and by AI crawlers | Before deploying a public site, or when a site is not showing up in search |
| [skill-authoring](skill-authoring/SKILL.md) | Format and process for adding rules to this repo, including importing third-party skills | The user dictates rules or asks to create, edit, or copy a skill |

## Planned

Topics the user has mentioned but that are not written up yet. Remove a row
once its skill exists.

| Topic | Notes |
|-------|-------|
| Brand voice template | `VOICE.md` in andar-deck is written to be copied per brand. A skill could define the template (what it is, who for, register, banned terms, commitments, honesty labels) for new brands. Needs the owner to confirm the general parts. |
| Code style per language | Owner repos show strict TypeScript with no `any`, camelCase files with dotted suffixes, British spelling in identifiers, snake_case Python modules with one concern each, comments that explain why. Needs confirmation before it becomes rules. |
| Testing conventions | pytest and vitest, colocated tests, migration-graph test first in CI, design-token lint-as-test, money path always covered. Partly in `backend-conventions`; a dedicated skill needs the owner's view on coverage expectations. |
| Frontend design tokens | pepper-board fails the build on arbitrary Tailwind values and off-palette colours. Could become a rule for every app with a design system. |
| Vendored third-party skills | andar-deck and andar-deck-live carry antislop, hallmark, no-slop-ui, stop-slop, avoid-ai-design, and thirteen taste skills pinned by hash. Decide which travel with this plugin. |
| Mobile app conventions | numero (Flutter) is the only mobile repo so far. Too little to generalise yet. |
