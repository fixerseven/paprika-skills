---
name: project-docs
description: The standard set of project documents and what each one holds, including CLAUDE.md, PRODUCT.md, DESIGN.md, VOICE.md, HANDOFF.md, ARCHITECTURE.md, SPEC.md, and README.md. Use when starting a project, when asked to document a decision or a change, when a rule needs a home, or when a doc has drifted from what the code does.
---

# Project docs

Every project carries the same small set of documents. Each has one job, each
is the single source for its subject, and each describes reality.

## Rules

### MUST
- Keep one document per subject and reference it from elsewhere. Never restate a rule in a second file. Two divergent statements of a rule is the failure this set exists to prevent.
- Keep docs describing reality. A rule that no longer describes what the repo does gets "fixed" by someone deleting the wrong file. Rewrite the rule instead.
- Change the doc in the same commit as the change it describes. Deployment changes update the architecture doc or README. Design direction changes update `DESIGN.md`. Product decisions update `PRODUCT.md`.
- Record decisions with who made them and when: "per Nath, 2026-07-23".
- Record things deliberately not built, with the reason, so the next session does not build them.
- Keep an "Open decisions (ask before assuming)" list in `CLAUDE.md` and add to it rather than guessing.

### SHOULD
- Use these files with these jobs:

  | File | Job |
  |------|-----|
  | `README.md` | How to run it. A "read first" table pointing at the docs below. An explicit "out of scope" section. |
  | `CLAUDE.md` or `AGENTS.md` | Instructions for AI sessions. Sections: What this is, Stack, Hard rules (do not violate), Build order with a running changelog of shipped versions, Conventions, Open decisions. |
  | `PRODUCT.md` | Product truth: positioning, users, purpose, capabilities and constraints, commitments, principles. A PR that contradicts a confirmed decision here needs the decision changed first. |
  | `docs/SPEC.md` | Numbered product spec, referenced by section number from `CLAUDE.md` and commits. |
  | `DESIGN.md` | Visual language: colours, typography, layout, elevation, shapes, components, do's and don'ts. Law for any visual work. |
  | `VOICE.md` | How the brand talks: positioning, register, banned terms, honesty labels. Copied verbatim into every project for that brand. |
  | `ARCHITECTURE.md` | How it is built, hosted, and deployed. Changes in the same PR as any deployment change. |
  | `HANDOFF.md` | Written for the next AI session. Dated. Tables of merged PRs, in-flight work, not-started items, and decisions waiting on the owner. In some app repos it is instead the operational notes and open items for one feature domain. |
  | `NEXT.md` | The sequenced work queue, meant to go stale quickly. Dated "where we are", the idea that orders everything, Track A (only the owner can do these) and Track B (code, in order) with sizes and done stamps. |
  | `PLAN.md` | The full product and technical plan in numbered sections: why it exists and what it cannot do, UX, pipeline, data model, sync, roadmap, risks. |
  | `DESIGN-BRIEF.md` | Pre-build design spec: job and audience, chosen direction, screen inventory, the flows that matter, tokens, components, states, UX copy, accessibility, "open decisions, do not invent these", anti-goals. |
  | `docs/decisions/NNNN-*.md` | Architecture decision records: Context, Decision, Consequences. Never edited once accepted. |
  | `docs/superpowers/specs/` and `plans/` | Dated design specs and implementation plans, written before code. See `plan-then-build`. |
  | `00-README.md`, `01-FEATURE-SHEET.md`, `02-DEV-PREP-PLAN.md`, `03-COMPETITOR-RESEARCH.md` | Numbered pre-build research set for a new product. The `00` file is the index with a dated status line and the blocking decisions. |

- Write comments in code the same way: explain why and name the failure mode or trade-off, not what the line does.
- Keep `.env.example` as a teaching document with a comment per variable.
- End every doc with its open items: "Still owed before launch", "Open items", or "Open decisions, do not invent these".
- Keep `PRODUCT.md` to the canonical headings so tooling can validate it: Platform, Stack, Users, Product Purpose, Positioning, Operating Context, Capabilities and Constraints, Brand Commitments, Evidence on Hand, Product Principles, Accessibility and Inclusion, Open Decisions.

### NEVER
- Let `CLAUDE.md` grow a second copy of `VOICE.md` or `DESIGN.md` rules. Point at them.
- Leave a decision only in chat. If it changes what gets built, it goes in a doc.

## How to apply

1. When a rule, decision, or fact comes up, find its home in the table above.
2. If the home does not exist yet, create it from the structure listed.
3. Write the entry, dated and attributed.
4. Grep the other docs for older statements of the same thing and replace them with a reference.

## Examples

Good `CLAUDE.md` entry:

```text
The recurring-template engine is deliberately not built: compliance deadlines are
out of scope (Nath, 2026-09-04), and that was its only justification. Revisit only
if the team says they keep forgetting a repeat.
```

Bad:

```text
TODO: maybe add recurring tasks later
```

## Rationale

The owner runs several AI sessions in parallel across many repositories. Sessions do not share memory, so the docs are the memory. A doc that lies or is duplicated costs a session the time to discover which copy is right, or worse, the session trusts the wrong one. Sources: the `CLAUDE.md` files in nest-pos-project and andar-deck, `VOICE.md` §7, `CONTRIBUTING.md` ground rule 4, and the README and `product/` ledger in pepper-board.

## Related skills

- `plan-then-build` - the spec and plan docs in detail.
- `git-workflow` - which doc changes in the same PR.
