# HA-USBIP — USB/IP Client Home Assistant Add-on

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

![Project Maintenance][maintenance-shield]

Minimal Home Assistant add-on that acts as a USB/IP client. It connects to an existing USB/IP server and attaches configured remote USB devices so they become available to Home Assistant.

## Features

- Attach configured remote USB devices via USB/IP.
- Simple configuration: list host and busid pairs.
- Configurable log levels for easier troubleshooting.
- Lightweight init and s6 service to manage attachments.

## Installation

1. In Home Assistant go to Supervisor → Add-on Store → ⋮ → Repositories and add this repository URL:
   - https://github.com/cdvankammen/HA-USBIP
2. Install the "HA-USBIP" add-on.
3. Configure options (see Configuration below).
4. Disable protection mode if required by your setup.
5. Start the add-on.

## Configuration

Options exposed in the add-on (config.yaml):

- `attachments` (array) — list of strings in the form `"host[:port] busid"`. Example: `"192.168.1.13 1-1.2"`.
- `log_level` (string) — one of `trace`, `debug`, `info`, `notice`, `warning`, `error`, `fatal`. Default: `info`.

Example configuration:
```yaml
attachments:
  - "192.168.1.13 1-1.2"
  - "192.168.1.14 1-1.3"
log_level: info
