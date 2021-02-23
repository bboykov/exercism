#!/usr/bin/env bash

set -euo pipefail

_usage() {
  echo "Usage: error_handling.sh <person>"
}

_die() {
  _usage
  exit 1
}

if [[ ${#} -eq 0 || ${2:-and} != 'and' ]]; then
  _die
fi

echo "Hello, $*"
