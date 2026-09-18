---
name: seo-launch-checklist
description: Pre-deploy SEO checklist so a website or web app can be found in Google and by AI crawlers. Use before deploying or launching any site, landing page, or web app, or when the user asks why their site does not show up in search, or asks for sitemap, robots.txt, meta tags, canonical tags, schema markup, llms.txt, or Core Web Vitals work.
---

# SEO launch checklist

A site nobody can find is a site nobody uses. Run this checklist before every
deploy of a public site, and re-run it when pages are added or restructured.

## Rules

### MUST
Before deploying a public site, confirm each of these:

1. **sitemap.xml** exists, lists every indexable page, and is referenced from robots.txt.
2. **robots.txt** exists, allows crawling of public pages, and blocks only what should stay private.
3. **No stray noindex tags.** Remove `noindex` meta tags and `X-Robots-Tag: noindex` headers from pages that should be found. Framework and staging defaults often leave these on.
4. **Canonical tags** on every page point to the one URL that should rank, so duplicates and query-string variants do not split ranking.
5. **Meta titles** on every page: unique, specific, under about 60 characters.
6. **Meta descriptions** on every page: unique, specific, under about 155 characters.
7. **One H1 per page**, stating what the page is about.
8. **Header hierarchy** is in order: H1, then H2s, then H3s under those, with no skipped levels.
9. **Alt text** on every meaningful image, describing its content. Decorative images get an empty alt attribute.
10. **Schema markup** (JSON-LD structured data) for the page type: Organization, Product, Article, FAQ, or whatever fits.
11. **Internal links** connect pages so every page is reachable from another page, not only from the sitemap.
12. **No broken links.** Crawl the site and fix or remove every 404 and redirect chain.
13. **Compressed images.** Serve modern formats such as WebP or AVIF, sized to how they are displayed.
14. **Core Web Vitals** pass: Largest Contentful Paint, Interaction to Next Paint, and Cumulative Layout Shift within Google's thresholds.
15. **Mobile responsiveness.** Every page renders and works on a phone-width viewport.
16. **HTTPS enforced.** All HTTP requests redirect to HTTPS and no mixed content loads.
17. **Clean URL slugs.** Lowercase, hyphen-separated, descriptive words. No IDs, hashes, or session parameters in public URLs.
18. **llms.txt** at the site root describing the site for AI crawlers and agents.

### SHOULD
19. **Backlink strategy.** Have a plan for how other sites will link here: directories, partners, launch posts, guest content. This is ongoing work that starts at launch, not a one-time deploy step.

### NEVER
- Deploy a public site with `noindex` left on by default.
- Mark a checklist item done without checking the live or preview build. Config that looks right in source can still be dropped by the build.

## How to apply

1. Build the site to a preview or staging URL.
2. Go through the MUST list in order and record pass or fail for each item against the built output, not the source.
3. For any failure, fix it and re-check. Use the site's own tooling for generated files such as sitemaps rather than hand-writing them when a generator exists.
4. Run a crawler or link checker over the whole preview to catch broken links and missing metadata across every page, not only the home page.
5. Run a Core Web Vitals check (for example Lighthouse or PageSpeed Insights) on the key pages.
6. Report the checklist with each item's status to the user before deploying.
7. After deploy, submit the sitemap to Google Search Console and start the backlink plan.

## Examples

Good report:

```text
SEO launch checklist for preview build
 1. sitemap.xml         pass  (42 URLs, linked from robots.txt)
 2. robots.txt          pass
 3. noindex removed     FAIL  /pricing still sends X-Robots-Tag: noindex -> fixed in next build
 ...
```

Bad report:

```text
SEO looks good, ready to deploy.
```

The bad version gives the user nothing to verify.

## Rationale

Most of these items are cheap at launch and expensive to discover months
later when the site has no traffic. Framework defaults, staging settings,
and AI-generated scaffolds routinely ship with noindex on, no sitemap, no
metadata, and broken header structure. Checking the built output, item by
item, is the only reliable way to catch that.

## Related skills

- `copywriting` - meta titles, descriptions, and H1s are copy too. Make them specific.
