---
name: cloudflare-sites
description: How static sites and small web apps are built, checked, hosted, and deployed on Cloudflare Workers with static assets. Use when creating a site or app, adding an app or subdomain, writing wrangler config, setting headers and caching, handling fonts and images, wiring CI, or deciding what is public, unlisted, or excluded from the deploy.
---

# Cloudflare sites

One project per subdomain, config in the repo, a build that can prove it is
current, and a link check that proves nothing is broken.

## Rules

### MUST
- Give each app its own folder or repo, its own Cloudflare project, and its own subdomain. Never put an app's files at the repository root.
- Use Workers with static assets, not Pages. Commit `wrangler.jsonc`. The dashboard is not the source of truth.
- Keep an `.assetsignore` as the publish denylist. Agent tooling such as `.claude/`, `.agents/`, lockfiles for skills, sources, and docs never ship to the public site.
- Provide `check`, `test`, and `build` scripts in `package.json`, a lockfile, and `engines.node` of at least 22.12.
- Make `check` fail when the generated output is stale relative to its sources, and run a link check that resolves every local `src`, `href`, `srcset`, and `url()` to a file in the repo.
- Add a CI job for each app. Merging to the default branch deploys, so CI is the gate.
- Decide visibility per page. Public pages go in `sitemap.xml`. Client editions, prototypes, and demos are unlisted: disallowed in `robots.txt` and left out of the sitemap.
- Set `_headers`: `no-cache` for HTML, the sitemap, and the manifest; `max-age=31536000, immutable` for fonts and vendored assets; about seven days for images.
- Self-host fonts in `fonts/`. When a brand specifies a system font, load a metric-compatible webfont so it cannot silently fall back.
- Update the architecture doc's tables and the link checker's skip list when adding an app, in the same PR.

### SHOULD
- Build with a small script, not a bundler, when the site is static HTML: assemble from source plus partials with include markers, copy images, inject the favicon, print a file and byte count.
- Clear the contents of the output directory rather than removing it, because the dev server holds a handle on it.
- Render share images and PNG icons from the site's own fonts and photos with a script, so they match the page.
- Size images for the slot they fill, serve WebP or AVIF, and keep originals in a `source-photos/` folder outside the publish set.
- Use lower-case kebab-case filenames with no spaces.
- Set `not_found_handling` to a real 404 page, use explicit proxied DNS records rather than a wildcard, and turn observability on.
- Record hosting decisions as ADRs under `docs/decisions/`, numbered, with Context, Decision, and Consequences. Never edit an accepted ADR. Write a new one.

### NEVER
- Configure a project only in the dashboard.
- Ship the agent skill folders, lockfiles, or source docs to the public site.
- Let a red deploy check pass by disabling it.

## How to apply

1. Create the app folder with `wrangler.jsonc`, `.assetsignore`, `package.json` scripts, and a lockfile.
2. Write the build script and the `--check` mode.
3. Add the link check and the CI job.
4. Add `robots.txt`, `sitemap.xml`, and `_headers`.
5. Update `ARCHITECTURE.md` tables and the root `.assetsignore` and skip lists.
6. Open the PR. Confirm the preview URL from the Cloudflare bot. After merge, confirm the live subdomain.
7. Run the `seo-launch-checklist` before calling it launched.

## Examples

Good `.assetsignore`:

```text
.claude/
.agents/
skills-lock.json
docs/
scripts/
*.src.html
partials/
```

Bad: no `.assetsignore`, so the design-taste skills and source photos are served at public URLs.

## Rationale

The owner's sites deploy within a minute of merge and serve real clients, so the repo has to be the whole truth about hosting, and the checks have to catch a stale build or a dead link before the merge. Sources: `docs/ADDING-AN-APP.md`, `docs/ARCHITECTURE.md`, `docs/decisions/`, `_headers`, and `scripts/check-links.py` in andar-deck-live, and `build.mjs` in storagetown-website.

## Related skills

- `seo-launch-checklist` - the pre-launch pass.
- `git-workflow` - the merge-deploys rule.
- `secrets-and-env` - secrets live on the Cloudflare project.
