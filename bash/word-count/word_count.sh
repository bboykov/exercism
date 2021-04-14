#!/usr/bin/env bash

set -euo pipefail

die() {
  echo "$*" >&2
  exit 1
}

main() {
  (($# == 1)) || die "The script takes only one argument"

  local phrase_string=${1,,}
  phrase_string=${phrase_string//,/ }
  phrase_string=$(echo -e ${phrase_string}|tr '\n' ' ')
  phrase_string=${phrase_string//[[:punct:]]/ }


  declare -A word_count_array

  read -r -a phrase_array <<<"${phrase_string}"

  # declare -p phrase_array # debug

  for word in "${phrase_array[@]}"; do
    # echo "${word}" # debug
    word_count_array["${word}"]=$((${word_count_array["${word}"]-0} + 1))
  done

  # declare -p word_count_array # debug

  for word in "${!word_count_array[@]}"; do
    echo "${word}: ${word_count_array["${word}"]}"
  done

}

main "$@"
