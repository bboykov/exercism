#!/usr/bin/env bash

set -euo pipefail
source functions.bash

if [[ $# != 1 ]]; then
  echo "false"
  exit 0
fi

number=${1// /}

if ! str::is_int "${number}" || ((${#number} < 2)); then
  echo "false"
  exit 0
fi

digits=()
j=0
for ((i = ${#number} - 1; i >= 0; i--)); do
  if ((j % 2)); then
    doubled_digit=$(("${number:${i}:1}" * 2))
    if ((doubled_digit > 9)); then
      doubled_digit=$((doubled_digit - 9))
    fi
    digits+=("${doubled_digit}")
  else
    digits+=("${number:${i}:1}")
  fi
  ((j += 1))
done

sum=0
for digit in "${digits[@]}"; do
  sum=$((sum + digit))
done

if ((sum % 10)); then
  echo "false"
else
  echo "true"
fi
