---
name: git-workflow
description: Branch, commit, pull request, CI, merge, and revert conventions for the owner's repositories. Use when creating a branch, writing a commit message, opening or reviewing a pull request, handling a failing check, merging, deploying, or reverting.
---

# Git workflow

The default branch is production. Everything reaches it through a small,
reviewed, green pull request, and the history reads as the changelog.

## Rules

### MUST
- Treat the default branch as production. Merging deploys.
- Make every change a pull request, including your own. Nothing lands on the default branch except through a PR with green checks.
- Branch from the default branch and name the branch for the change in kebab-case: `homepage-share-image`, `fix-worker-deploy`. Delete it after merging.
- Follow the repo's existing commit prefix convention. Some repos use conventional commits with a scope (`feat(web):`, `fix(api):`, `docs:`, `perf:`), others use plain sentences. Match what `git log` shows.
- Write the subject as a sentence that describes the resulting behaviour, not the activity: "the board never polls mid-drag" beats "update polling". Lowercase after any prefix, no trailing period.
- Put the why in the body when the diff does not make it obvious: what was wrong, the mechanism, how it was verified, and the test count when tests changed.
- Make one change per commit. Small and single-purpose beats large and mixed.
- Run the repo's checks before pushing: lint, typecheck, tests, build, and any link or build-freshness check the repo defines.
- Fill in the PR template: what and why, how it was verified, and what it changes about deployment.
- Fix a red check yourself. Do not merge around it.
- When a change alters how something is deployed, update the architecture doc or README in the same PR.
- Check the change against the repo's `PRODUCT.md` before opening a PR. A PR that contradicts a confirmed decision there needs that decision changed first.
- Merge with a merge commit, then confirm the deploy on the live URL.
- Revert with a new PR that reverts the merge commit (`git revert -m 1 <sha>`).

### SHOULD
- Keep the subject under about 72 characters. Longer is accepted when the sentence needs it.
- Name branches `feat/<topic>`, `fix/<topic>`, `perf/<topic>`, or `claude/<topic>` for AI-driven work, matching the repo's existing pattern.
- After implementing, do a self-review pass and commit the findings as their own commit: "Fix round 1: local dates, money record links, touch targets".
- When working from a plan doc, amend it in git as the work runs: "docs: add Task 3", then the feature commit, then "docs: record Task 3 execution and what it found".
- Include screenshots in the PR for any UI change.
- Link the related issue or conversation.
- Keep the version tag in the commit subject when the repo versions releases, for example "Merge fix/ssrf-dns-pinning: vetted-address fetches (v1.16.1)".

### NEVER
- Force-push the default branch or rewrite history on someone else's branch.
- Disable, skip, or quarantine a test to get a check green.
- Put a secret, token, or credential in code, config, a commit, a PR, or a comment.
- Push an empty commit or close and reopen a PR to re-trigger CI.

## How to apply

1. `git switch -c <change-name>` from an up-to-date default branch.
2. Make the change. Commit in sentences, one change per commit.
3. Run the repo's checks. Fix everything before pushing.
4. Push and open a PR using the template. Add screenshots for UI.
5. Wait for every check. If one is red, fix it and push again.
6. Merge with a merge commit. Confirm the deploy. Delete the branch.

## Examples

Good commit subjects, one from each convention:

```text
fix(web): keep the colour popover open and the client dot steady
Send the presence ping after commit so an outage costs the message, not the drawer
```

Bad commit subject:

```text
fix stuff
```

Good branch names: `advisories-power-title`, `day-report-early-close-backfill`.

## Rationale

Merging deploys within a minute on these repos, so the PR is the last gate before customers see the change. Sentence-form commits make the history usable as a changelog, and one change per commit makes a revert surgical. Sources: `CONTRIBUTING.md` in andar-deck-live, the PR templates in pepper-board and andar-deck-live, and the commit history of pepper-board, nest-pos-project, and household-bot.

## Related skills

- `secrets-and-env` - the secrets rule in full.
- `project-docs` - which doc changes in the same PR.
