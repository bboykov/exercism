#!/usr/bin/env bash

set -euo pipefail

die() {
  echo "$*" >&2
  exit 1
}

square_of_sum() {
  number=$1
  sum=0
  for ((i = 1; i < number + 1; i++)); do
    ((sum += i))
  done

  echo "$((sum ** 2))"
}

sum_of_squares() {
  number=$1

  sum=0
  for ((i = 1; i < number + 1; i++)); do
    powed="$((i ** 2))"
    ((sum += powed))
  done

  echo "${sum}"
}

difference() {
  number=$1
  sum_of_squares_result="$(sum_of_squares "${number}")"
  square_of_sum_result="$(square_of_sum "${number}")"

  echo $((square_of_sum_result - sum_of_squares_result))
}

main() {
  if [[ $# -ne 2 ]]; then
    die "The script takes exactly two arguments"
  fi

  mode=$1
  number=$2

  case "${mode}" in
    square_of_sum)
      square_of_sum "${number}"
      ;;
    sum_of_squares)
      sum_of_squares "${number}"
      ;;
    difference)
      difference "${number}"
      ;;
    *)
      die "Unknown mode"
      ;;
  esac

}

main "$@"
