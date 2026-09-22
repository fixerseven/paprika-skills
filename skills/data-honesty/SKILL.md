---
name: data-honesty
description: Honesty rules for anything a customer, client, or reader will see. Use when writing decks, websites, proposals, prototypes, demos, reports, or dashboards, when quoting a figure, naming a client, showing example data, or labelling something as shipped, live, or running. Also use when a fact is missing and there is a temptation to fill it in.
---

# Data honesty

Nothing published is a claim the owner cannot stand behind. Honesty outranks
persuasion. A weaker true sentence beats a stronger invented one.

## Rules

### MUST
- Label every claim about status with one of four labels, used literally:

  | Label | Means |
  |-------|-------|
  | **Running today** | In production, in the owner's own operation or a paying client's, right now |
  | **Built for you** | Real, scoped, buildable, and not yet running in anyone's daily operation |
  | **Example data** | Synthetic demonstration data. Every invented figure carries it |
  | **To confirm** | An unconfirmed fact, shown as a visible dashed placeholder |

- Show a prototype as a prototype. Figures in a prototype are fictional and the page says so.
- Where a real fact is missing (a price, a date, an address, a name), use a visibly marked placeholder such as "To confirm".
- Keep a source manifest for client photographs and logos, listing where each came from.
- Underwrite cost and cycle time only. Revenue lift is a consequence, never a promise.
- Concede the hard number before the reader raises it.

### SHOULD
- State the observation instead of the superiority claim. "Most providers here are either developers who never ran a business or consultants who never shipped software. We have done both" beats "no one else combines both".
- Keep client editions, prototypes, and demos unlisted: add them to `robots.txt` and leave them out of `sitemap.xml`.

### NEVER
- Name a client without written permission. An empty client name keeps its visible "To confirm" placeholder. Never an invented name, never a generic like "a Cebu client", never a blank that reads as if the claim had no source.
- Describe a prototype as deployed, or present anything as running that is not running.
- Fabricate a number, count, date, quote, testimonial, award, or line item. If a system cannot measure something, store null and flag it, do not estimate it silently.
- Put invented line items on a reproduction of a real document.
- Drop or soften a label to make a claim land harder.
- Retouch, regenerate, or AI-edit a client's photograph or logo.
- Make an unprovable superiority claim ("the best engineers", "no one else can").

## How to apply

1. Before writing, list every factual claim the piece will make: figures, names, dates, statuses, and quotes.
2. For each, decide which of the four labels applies and whether the source exists. No source means "To confirm" or cut.
3. For any client reference, confirm written permission exists. If not, use the placeholder.
4. In code, when a value cannot be measured (an uncounted drawer, a missing reading), store null and set a flag. Never compute a plausible stand-in.
5. Before declaring done, scan the output for any figure or name that does not carry its label or its source.

## Examples

Good:

```text
Deployment time: 4 minutes (Running today, Andar's own operation)
Client: [To confirm · client name pending written permission]
```

Bad:

```text
Deployment time: under 5 minutes for all our clients
Client: a leading Cebu distributor
```

The bad version turns one measured number into a fleet-wide promise and invents a client description that reads like a source.

## Rationale

The owner's businesses make claims on behalf of real people and real clients, in a market where trust is the differentiator. One invented figure discovered by a buyer undoes every true one. The four labels exist so that nothing has to be softened: a true "Built for you" is a stronger sale than a false "Running today". Sources: `VOICE.md` §5 and §6 in the andar-deck repository, the content rules in `CONTRIBUTING.md` of andar-deck-live, and the "a count is never invented" rule in the Nest POS `CLAUDE.md`.

## Related skills

- `copywriting` - the persuasion rules these honesty rules constrain.
- `no-ai-slop` - prose patterns to remove after the facts are right.
