#!/usr/bin/env bash

set -Euo pipefail
source functions.bash
trap 'echo "Error on line $LINENO. Exit code: $?" >&2' ERR

util::assert "$# == 1" "Provide exactly one argument"

if ! str::is_int "${1}"; then
  util::die "Provide number as argument"
fi

number=${1}
number_len=${#number}
sum=0

for ((i = 0; i < number_len; i++)); do
  ((sum += (${number:i:1} ** number_len))) || true
done

if [[ ${sum} -eq ${number} ]]; then
  echo "true"
else
  echo "false"
fi
