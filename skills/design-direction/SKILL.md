---
name: design-direction
description: The owner's rules for visual and interface work and for how design filters, taste skills, and DESIGN.md relate. Use before building or editing any page, screen, deck, component, motion, or layout, before running an anti-slop or design-audit skill, and before declaring visual work done.
---

# Design direction

`DESIGN.md` is law. Direction outranks filters. Honesty outranks everything.
Accessibility is computed, not asserted. Nothing is done until the finish gate passes.

## Rules

### MUST
- Read `DESIGN.md`, `PRODUCT.md`, and `VOICE.md` before any visual work. If the direction needs a rule changed, change `DESIGN.md` in the same commit and say why. Never silently violate it.
- Treat a filter or audit finding against a documented `DESIGN.md` decision as a named override, not a bug. If the decision is not written down yet, write it into `DESIGN.md` first.
- Record `DESIGN.md` from the built page, not from aspiration: colour tokens with measured contrast ratios, type scale, components, motion, and a "still owed before launch" list.
- Compute contrast, never assert it. Floors sit above WCAG AA: body text at least 5.3:1, primary ink at least 12:1. Record the numbers in the token table.
- Use sentence case everywhere. No tracked all-caps chrome. The wordmark is the only exception.
- Keep line lengths at 60 to 70 characters and use dramatic scale contrast between display and caption type.
- Keep content readable at rest. Motion never has to finish before the page can be read. `prefers-reduced-motion` gets a complete, instant experience.
- Allow at most one scroll-driven setpiece per page. Everything else is calm. Never trap the wheel, and the scrollbar tells the truth.
- Run the finish gate before saying done:
  1. Honesty pass per `data-honesty`.
  2. Anti-slop delivery checks as pass or fail with evidence per item.
  3. Contrast computed for every text and surface pair.
  4. Keyboard walk, reduced motion, scripting off, 420px width, no horizontal overflow, zero console errors.
  5. Prose scored with the installed prose filter. Under threshold means revise.
- Screenshot your own work at 1600×900 and 420×900 and critique it for at least two rounds before returning it.

### SHOULD
- Route filters by surface. Marketing pages and decks get the full anti-slop set plus a design audit. Product screens get the restrained UI filter, the accessibility filter, and the mobile layout filter. Prose gets the voice file plus one prose filter. Never load two copy filters at once.
- Pre-answer any setup wizard a vendored skill has. Never ask the owner a skill's setup questions.
- Sketch several named directions as full-page SVG comps before building, pick one as canon, and keep the rejected ones in the repo under `.impeccable/sketches/`.
- Use one house entrance curve and a short stagger. Use tabular numerals so figures do not reflow.
- Adopt perceptual defaults by name in `DESIGN.md`: disabled at 40 percent, hover lightness shift of at least 8 percent, 44×44 touch targets, 2px focus ring. Overrides are listed by name.
- Ship single self-contained HTML for static pages, with no external JS libraries and self-hosted fonts.

### NEVER
- Same-size icon, heading, text cards as page structure. Nested cards. Tracked uppercase eyebrows. Decorative section numbers. Sparklines or progress rings as decoration. Rotated stamps.
- Parallax, bounce or overshoot, draw-on animation, or any motion that blocks reading.
- Gradients and heavy shadows as a default. Round everything by default.
- Describe a colour as accessible without the ratio next to it.
- Commit or push from inside a design subagent. The orchestrating session reviews and commits.

## How to apply

1. Read the three docs. Note every documented decision a filter is likely to flag.
2. Write the concept in five lines before touching code: the one idea, the type move, the motion (if any), the palette, and what is deliberately absent.
3. Build. Keep the page readable with scripting off.
4. Run the finish gate. Fix every fail.
5. Screenshot, critique, revise, twice.
6. Update `DESIGN.md` with anything you decided, with measurements.

## Examples

Good `DESIGN.md` colour row:

```text
| ink      | #0E0C0B | on paper 14.2:1 | body text, headings |
```

Bad:

```text
Dark text on light background, accessible.
```

## Rationale

The owner has installed a dozen third-party anti-slop and taste skills and then written a gate that arbitrates between them, because filters applied blindly "fix" deliberate decisions and flatten the work. The gate, the measured `DESIGN.md`, and the kill list are the owner's own rules. Sources: `andar-design-gate` and `design-director.md` in andar-deck, `DESIGN.md` in andar-deck and storagetown-website, and the `.impeccable/sketches/` folder in storagetown-website.

## Related skills

- `data-honesty` - the honesty pass in the finish gate.
- `no-ai-slop` and `copywriting` - the prose side.
- `project-docs` - where `DESIGN.md` lives and what it holds.
