#!/usr/bin/env bash
# Validate every skill in skills/ and the catalog that lists them.
# Usage: scripts/validate.sh
set -u

cd "$(dirname "$0")/.." || exit 1

errors=0
fail() { echo "ERROR: $*" >&2; errors=$((errors + 1)); }

catalog="skills/README.md"
[ -f "$catalog" ] || fail "missing $catalog"

for dir in skills/*/; do
  name="${dir%/}"; name="${name#skills/}"
  file="$dir/SKILL.md"

  [ -f "$file" ] || { fail "$dir has no SKILL.md"; continue; }

  # Directory name: kebab-case, max 64 chars.
  if ! [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
    fail "$name: directory name must be kebab-case (lowercase letters, digits, hyphens)"
  fi
  [ "${#name}" -le 64 ] || fail "$name: directory name longer than 64 characters"

  # Frontmatter: first line is ---, a closing --- follows.
  first="$(head -n 1 "$file")"
  [ "$first" = "---" ] || { fail "$name: SKILL.md must start with '---' frontmatter"; continue; }
  front="$(awk 'NR==1{next} /^---$/{exit} {print}' "$file")"

  fm_name="$(printf '%s\n' "$front" | sed -n 's/^name:[[:space:]]*//p' | head -n1)"
  fm_desc="$(printf '%s\n' "$front" | sed -n 's/^description:[[:space:]]*//p' | head -n1)"

  [ -n "$fm_name" ] || fail "$name: frontmatter missing 'name'"
  [ "$fm_name" = "$name" ] || [ -z "$fm_name" ] || fail "$name: frontmatter name '$fm_name' does not match directory"
  [ -n "$fm_desc" ] || fail "$name: frontmatter missing 'description'"
  [ "${#fm_desc}" -ge 40 ] || fail "$name: description is too short to be a useful trigger (under 40 chars)"
  [ "${#fm_desc}" -le 1024 ] || fail "$name: description longer than 1024 characters"

  # Body should carry at least one strength-tagged rule. Imported skills
  # (marked by UPSTREAM.md) keep their upstream format and are exempt.
  if [ -f "$dir/UPSTREAM.md" ]; then
    grep -q '^| Source ' "$dir/UPSTREAM.md" || fail "$name: UPSTREAM.md is missing the Source row"
    grep -q '^| License ' "$dir/UPSTREAM.md" || fail "$name: UPSTREAM.md is missing the License row"
  elif ! grep -Eq '^### (MUST|SHOULD|MAY|NEVER)$' "$file"; then
    fail "$name: no '### MUST/SHOULD/MAY/NEVER' rule sections found"
  fi

  # Placeholder text left over from the template.
  if grep -q 'skill-name-here' "$file"; then
    fail "$name: template placeholder 'skill-name-here' still present"
  fi

  # Catalog row present.
  if [ -f "$catalog" ] && ! grep -q "\[$name\]($name/SKILL.md)" "$catalog"; then
    fail "$name: not listed in $catalog"
  fi

  # Size guidance.
  lines="$(wc -l < "$file")"
  [ "$lines" -le 400 ] || echo "WARN: $name: SKILL.md is $lines lines; consider moving reference material to a sibling file" >&2
done

# Catalog rows that point at missing skills.
if [ -f "$catalog" ]; then
  while read -r linked; do
    [ -d "skills/$linked" ] || fail "catalog lists '$linked' but skills/$linked does not exist"
  done < <(grep -o '\[[a-z0-9-]*\]([a-z0-9-]*/SKILL.md)' "$catalog" | sed 's/^\[\([^]]*\)\].*/\1/')
fi

if [ "$errors" -gt 0 ]; then
  echo "$errors problem(s) found." >&2
  exit 1
fi
echo "All skills valid."
