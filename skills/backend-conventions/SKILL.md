---
name: backend-conventions
description: Server-side conventions for data, APIs, migrations, logging, config, and side effects. Use when writing backend code, designing a schema, adding a migration, handling money or time, sending a notification, logging, reading configuration, or writing a script that touches the database.
---

# Backend conventions

Data is never lost, every change is attributable, side effects happen after
the commit, and there is one copy of every rule.

## Rules

### MUST
- Validate every input at the boundary with a schema (Zod, pydantic, or the framework's equivalent).
- Never expose internal database ids in API responses, URLs, or frontend code. Use a public id.
- Soft delete or deactivate anything referenced by history. Products, staff, and promos used by past sales are deactivated, never deleted. Historical receipts and reports must never break.
- Record who and when on every mutation: user id and timestamp. Destructive actions such as voids require a reason.
- Use a transaction for any multi-step write.
- Fire external side effects such as notifications, webhooks, and emails after the commit, so an outage costs the message, not the record.
- Keep one copy of every business rule. Gates and predicates are shared functions that every entry point (HTTP API, webhook, CLI script) calls. A second entry point is a thinner UI over the same rules, never a side door.
- Store money as integers in the smallest unit, with an explicit currency. Format only at the edge.
- Make the timezone explicit everywhere a date matters. Sessions can cross midnight, so state which date a record belongs to.
- Store null and set a flag when a value cannot be measured. Never compute a plausible stand-in.
- One migration per schema change, with a descriptive slug. Never edit an existing migration. Enforce a single migration head with a test.
- Use a module-scoped logger. Never `console.log` or bare `print` in application code.
- Read configuration from one module that validates the environment. Optional features degrade cleanly when their key is unset.
- Answer inbound webhooks with success for anything except a bad secret, and dedupe retries by the provider's update id, so a poison update is never redelivered forever.
- Never read the database during app construction or job registration without a guard. Migrations run before the tables exist.

### SHOULD
- Put database queries in repository modules, one per entity, and keep routers thin.
- Extract pure decision functions from handlers and unit-test them separately.
- Keep a seed script with realistic demo data for local development, and make deploys skip any demo credentials.
- Keep one-off operations in `scripts/`, calling shared code in the app package.
- Turn down noisy third-party loggers and log exceptions with context, then degrade gracefully where the product allows.
- Rate-limit public endpoints and treat any user-supplied URL as hostile: scheme allowlist, public-address check per hop, redirect cap, byte and time caps.

### NEVER
- Hard delete a record that a receipt, report, or audit trail references.
- Let a background job or notification call block the user's request path. Batch and schedule instead.
- Duplicate an aggregate or metric in two places. Add it to the shared module and read it from both surfaces.

## How to apply

1. Before writing a handler, name the shared predicate it should call. If it does not exist, create it once.
2. Write the migration first, with a slug that says what changed.
3. Validate input, check authorisation, write inside a transaction, record attribution.
4. Queue side effects to run after commit.
5. Add or extend the test for the money path or the rule you touched.

## Examples

Good:

```python
with db.session.begin():
    sale = create_sale(items, user_id=current_user.id)
send_after_commit(lambda: telegram.notify(sale))
```

Bad:

```python
telegram.notify(sale)   # fires before commit; a Telegram outage now fails the sale
db.session.commit()
```

## Rationale

These systems handle cash, receipts, and attendance for real businesses, and are extended by many AI sessions over time. Rules that exist in one place survive that. Side effects after commit keep the money path safe from third-party outages. Sources: `AGENTS.md` in pepper-board (validation, public ids, soft deletes, transactions, logger), the hard rules and v1.23 to v1.29 entries in the Nest POS `CLAUDE.md`, and the SSRF work in pepper-board's shared package.

## Related skills

- `secrets-and-env` - configuration and credentials.
- `data-honesty` - the null-not-invented rule from the product side.
