#!/usr/bin/env bash

set -euo pipefail

string=${1^^}

for letter in {A..Z}; do
  if [[ ! "${string}"  =~ ${letter} ]]; then
    echo false
    exit 0
  fi
done

echo true
