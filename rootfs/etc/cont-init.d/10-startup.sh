#!/usr/bin/with-contenv bashio
set -e

bashio::log.info "startup: writing attachments config and ensuring script is executable"

mkdir -p /etc
> /etc/usbip-client.conf
if bashio::config.has_value 'attachments'; then
  for item in $(bashio::config 'attachments' | jq -r '.[]'); do
    echo "$item" >> /etc/usbip-client.conf
  done
fi

if [ -f /usr/local/bin/simple-usbip-client.sh ] && [ ! -x /usr/local/bin/simple-usbip-client.sh ]; then
  chmod +x /usr/local/bin/simple-usbip-client.sh
  bashio::log.info "startup: made /usr/local/bin/simple-usbip-client.sh executable"
fi
