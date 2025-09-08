#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
ansible -i inventory.ini webservers -m ping
