#!/usr/bin/env bash
set -euo pipefail

# Files that must be executable in the repo index
files=(
  ".github/scripts/bump-version.sh"
  ".github/scripts/git-set-exec.sh"
  "rootfs/usr/local/bin/simple-usbip-client.sh"
  "rootfs/etc/cont-init.d/10-startup.sh"
  "rootfs/etc/cont-init.d/create_devices.sh"
  "rootfs/etc/services.d/usbip/run"
  "rootfs/etc/services.d/usbip/finish"
)

changed=0
for f in "${files[@]}"; do
  if [ -f "$f" ]; then
    git update-index --add --chmod=+x "$f" >/dev/null 2>&1 || true
    changed=1
  fi
done

if [ "$changed" -eq 1 ]; then
  git add "${files[@]}" || true
  if ! git diff --staged --quiet; then
    git commit -m "chore: set executable bits for scripts [skip ci]" || true
    git push origin HEAD:main || git push origin HEAD:master || true
  fi
fi
