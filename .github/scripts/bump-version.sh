#!/usr/bin/env bash
set -euo pipefail

CFG=config.yaml
CHANGELOG=CHANGELOG.md

current=$(grep -E '^version:' "$CFG" | head -n1 | sed -E 's/version:[[:space:]]*"(.*)"/\1/' || true)
if [ -z "$current" ]; then
  echo "No version found in $CFG"
  exit 0
fi

IFS='.' read -r major minor patch <<< "$current"
patch=$((patch + 1))
new="${major}.${minor}.${patch}"

perl -0777 -pe "s/version:[ \t]*\"[0-9]+\\.[0-9]+\\.[0-9]+\"/version: \"${new}\"/s" -i "$CFG"

date=$(date -u +"%Y-%m-%d")
entry="## ${new} - ${date}\n\n- Auto bumped version on push to master\n\n"
if [ -f "$CHANGELOG" ]; then
  ( printf '%s\n' "$entry"; cat "$CHANGELOG" ) > "$CHANGELOG.tmp" && mv "$CHANGELOG.tmp" "$CHANGELOG"
else
  printf '%s\n' "$entry" > "$CHANGELOG"
fi

echo "Bumped version: $current -> $new"
