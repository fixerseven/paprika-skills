---
name: secrets-and-env
description: How secrets, API keys, tokens, and environment configuration are handled. Use when adding a credential, environment variable, or config value, writing a .env file, deploying, debugging authentication, or when a command or log might print a secret.
---

# Secrets and environment

Secrets live on the host, never in the repository, and never in output.

## Rules

### MUST
- Set secrets on the hosting platform (Cloudflare, Railway, Vercel, Docker secrets), not in files that are committed.
- Keep a committed `.env.example` listing every variable the app reads, with placeholder values and a one-line comment on where each comes from.
- Keep `.env`, `.env.local`, `secrets/`, and similar paths in `.gitignore`. Check before the first commit that adds any of them.
- Read configuration from the environment in one place and fail fast with a clear message when a required variable is missing.
- When verifying credentials, report present or missing and whether the credential works, without printing its value.

### SHOULD
- Provide a `check:env` style script that validates required variables without echoing them.
- Use a hash comparison such as `hmac.compare_digest` for any inbound shared secret or webhook token.
- Scope tokens to the least permission the task needs and note the scope in `.env.example`.

### NEVER
- Commit a secret, token, password, or private key, including in comments, fixtures, docs, screenshots, or PR descriptions.
- Print a secret to a log, terminal, error message, or chat reply.
- Paste a secret into a prompt or a generated document. Refer to where it lives instead.
- Hard-code a credential as a fallback default in code.

## How to apply

1. Add the variable name to `.env.example` with a placeholder and a comment on its source.
2. Read it through the app's single config module.
3. Set the real value on the host and in the local ignored env file.
4. Run the env check script. Confirm it reports the variable as present without showing it.
5. If a secret was ever committed, treat it as leaked: rotate it, then scrub the history.

## Examples

Good `.env.example` entry:

```text
# Telegram bot token from @BotFather; scope: send messages to the ops group
TELEGRAM_BOT_TOKEN=
```

Bad:

```text
TELEGRAM_BOT_TOKEN=7213...real token here
```

## Rationale

The repositories deploy automatically on merge and are worked on by several AI sessions, so a committed secret spreads into clones, logs, and transcripts within minutes. Sources: ground rule 3 in `CONTRIBUTING.md` of andar-deck-live, the deployment checklist in its PR template, and the credential check script in framecap.

## Related skills

- `git-workflow` - the PR checklist that asks about secrets.
