#!/usr/bin/env bash
# Turn the Paprika skills on for everyone who opens a project in a terminal.
#
# Usage: scripts/add-to-project.sh /path/to/project
#
# Merges the marketplace and plugin into the project's .claude/settings.json
# (existing keys are kept) and adds a short pointer to its CLAUDE.md. Review
# the diff in the project, then commit it there. Teammates get the plugin
# after they accept the workspace trust prompt. Cloud sessions ignore these
# settings; use scripts/cloud-setup.sh in the environment for those.
set -euo pipefail
target="${1:?usage: add-to-project.sh /path/to/project}"
[ -d "$target" ] || { echo "no such directory: $target" >&2; exit 1; }
mkdir -p "$target/.claude"

python3 -I - "$target/.claude/settings.json" <<'PY'
import json, pathlib, sys
p = pathlib.Path(sys.argv[1])
d = json.loads(p.read_text()) if p.exists() and p.read_text().strip() else {}
d.setdefault("extraKnownMarketplaces", {})["paprika-skills"] = {
    "source": {"source": "github", "repo": "fixerseven/paprika-skills"},
    "autoUpdate": True,
}
d.setdefault("enabledPlugins", {})["paprika@paprika-skills"] = True
p.write_text(json.dumps(d, indent=2) + "\n")
print(f"updated {p}")
PY

md="$target/CLAUDE.md"
if ! grep -q "Paprika skills" "$md" 2>/dev/null; then
  cat >> "$md" <<'MD'

## Paprika skills

This project follows the Paprika skills (plugin `paprika@paprika-skills`,
source https://github.com/fixerseven/paprika-skills). Load the relevant skill
before starting work. Project rules in this file win where they are more
specific.
MD
  echo "added pointer to $md"
else
  echo "$md already points at the Paprika skills"
fi
