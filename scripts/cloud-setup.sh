#!/usr/bin/env bash
# Install the Paprika skills into a Claude Code cloud environment.
#
# Paste the two commands below (or this whole file) into the environment's
# setup script on claude.ai. Setup scripts run before Claude Code starts, so
# every session in that environment loads the skills, whatever repo it opens.
# Repo-level .claude/settings.json plugins do NOT install in cloud sessions;
# this is the route that works there.
set -u
claude plugin marketplace add fixerseven/paprika-skills >/dev/null 2>&1 \
  || claude plugin marketplace update paprika-skills >/dev/null 2>&1 || true
claude plugin install paprika@paprika-skills >/dev/null 2>&1 || true
