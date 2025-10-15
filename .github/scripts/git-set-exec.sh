#!/usr/bin/env bash
set -euo pipefail

# List of files that must be executable in the repo
files=(
  ".github/scripts/bump-version.sh"
  ".github/scripts/git-set-exec.sh"
  "rootfs/usr/local/bin/simple-usbip-client.sh"
  "rootfs/etc/cont-init.d/10-startup.sh"
  "rootfs/etc/services.d/usbip/run"
  "rootfs/etc/services.d/usbip/finish"
)

changed=0

for f in "${files[@]}"; do
  if [ -f "$f" ]; then
    # set executable bit in the index
    git update-index --add --chmod=+x "$f" >/dev/null 2>&1 || true
    changed=1
  fi
done

if [ "$changed" -eq 1 ]; then
  git add "${files[@]}" || true
  if ! git diff --staged --quiet; then
    git commit -m "chore: set executable bits for scripts [skip ci]" || true
    git push origin HEAD:master || true
  fi
fi
