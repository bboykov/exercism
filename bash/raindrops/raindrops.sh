#!/usr/bin/env bash

set -uo pipefail
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR

source functions.bash

is_factor_of() {
  local -i number=$1
  local -i factor=$2

  ((number % factor == 0))

}

main() {
  if [[ $# -ne 1 ]]; then
    util::die "Only one parameter is required."
  fi

  local -i number=$1
  local number_sound=""
  local sounds=(
    [3]="Pling"
    [5]="Plang"
    [7]="Plong"
  )

  for factor in "${!sounds[@]}"; do

    if is_factor_of "${number}" "${factor}"; then
      number_sound+="${sounds[factor]}"
    fi

  done

  echo "${number_sound:-$number}"

}

main "$@"
