#!/usr/bin/env bash

set -uo pipefail

exit_on_error() {
  local status=$?
  echo "$0: Error on line $LINENO: $BASH_COMMAND"
  exit ${status}
}
trap exit_on_error ERR

die() {
  echo "$*" >&2
  exit 1
}

main() {
  (($# == 2)) || die "Usage: hamming.sh <string1> <string2>"
  ((${#1} == ${#2})) || die "left and right strands must be of equal length"

  strands_a=$1
  strands_b=$2
  difference=0

  for ((i = 0; i < ${#strands_a}; i++)); do
    if [[ "${strands_a:i:1}" != "${strands_b:i:1}" ]]; then
      ((difference++))
    fi
  done

  echo "${difference}"

}

main "$@"
