#!/usr/bin/env bash

set -euo pipefail

die() {
  echo "$*" >&2
  exit 1
}

equilateral() {
  local side_a=$1
  local side_b=$2
  local side_c=$3

  if (($(bc <<<"${side_a} == ${side_b}"))) &&
    (($(bc <<<"${side_b} == ${side_c}"))); then
    echo "true"
  else
    echo "false"
  fi
}

isosceles() {
  local side_a=$1
  local side_b=$2
  local side_c=$3

  if (($(bc <<<"${side_a} == ${side_b}"))) ||
    (($(bc <<<"${side_b} == ${side_c}"))) ||
    (($(bc <<<"${side_a} == ${side_c}"))); then
    echo "true"
  else
    echo "false"
  fi
}

scalene() {
  local side_a=$1
  local side_b=$2
  local side_c=$3

  if (($(bc <<<"${side_a} != ${side_b}"))) &&
    (($(bc <<<"${side_b} != ${side_c}"))) &&
    (($(bc <<<"${side_a} != ${side_c}"))); then
    echo "true"
  else
    echo "false"
  fi
}

main() {
  if [[ $# -ne 4 ]]; then
    die "The script takes exactly three arguments"
  fi

  local mode=$1
  local side_a=$2
  local side_b=$3
  local side_c=$4

  for side in "${side_a}" "${side_b}" "${side_c}"; do
    if (($(bc <<<"${side} == 0"))); then
      echo "false"
      exit 0
    fi
  done

  if (($(bc <<<"${side_a} + ${side_b} < ${side_c}"))) ||
    (($(bc <<<"${side_a} + ${side_c} < ${side_b}"))) ||
    (($(bc <<<"${side_c} + ${side_b} < ${side_a}"))); then
    echo "false"
    exit 0
  fi

  case "${mode}" in
    equilateral | isosceles | scalene)
      "${mode}" "${side_a}" "${side_b}" "${side_c}"
      ;;
    *)
      die "Unknown mode"
      ;;
  esac

}

main "$@"
