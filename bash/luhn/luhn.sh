#!/usr/bin/env bash

set -euo pipefail
source functions.bash

if [[ $# != 1 ]]; then
  echo "false"
  exit 0
fi

number=${1// /}

if ((${#number} < 2)) || ! str::is_int "${number}"; then
  echo "false"
  exit 0
fi

# echo "${number}"

digits=()
j=0
for ((i = ${#number} - 1; i >= 0; i--)); do
  # echo "${number:${i}:1}"
  if ((j % 2)); then
    # echo "${number:${i}:1}"
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

# declare -p digits

sum=0
for digit in "${digits[@]}"; do
  sum=$((sum + digit))
done

# echo "${sum}"

# echo "$((sum % 10))"

if ((sum % 10)); then
  echo "false"
else
  echo "true"
fi
