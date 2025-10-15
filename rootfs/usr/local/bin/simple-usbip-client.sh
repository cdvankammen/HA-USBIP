#!/usr/bin/env bash
set -euo pipefail

log() { printf '%s %s\n' "$(date -Is)" "$*"; }

CONF=/etc/usbip-client.conf

if ! command -v usbip >/dev/null 2>&1; then
  log "ERROR: usbip not found; install usbip first"
  exit 1
fi

log "Current imported devices (usbip port):"
usbip port || true

if [ ! -f "$CONF" ]; then
  log "No config at $CONF; nothing to attach"
  exit 0
fi

while IFS= read -r line || [ -n "$line" ]; do
  line="${line%%#*}"
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"
  [ -z "$line" ] && continue

  host="${line%% *}"
  busid="${line#* }"
  host_only="${host%%:*}"

  log "Attaching ${busid} from ${host_only}"
  if usbip attach -r "${host_only}" -b "${busid}"; then
    log "Attached ${busid} from ${host_only}"
  else
    log "Failed to attach ${busid} from ${host_only}"
  fi
done < "$CONF"

log "Done"
