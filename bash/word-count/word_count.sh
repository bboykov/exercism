#!/usr/bin/env bash
# I coun't solve this one. The only solution that I found it worked with GNU
# bash, version 5.1.0(1)-release (x86_64-apple-darwin19.6.0):
# https://exercism.io/tracks/bash/exercises/word-count/solutions/92d0a175e53841a6aadd197cf217a62f

set -euo pipefail
shopt -s extglob # Enable extended glob

die() {
  echo "$*" >&2
  exit 1
}

main() {
  (($# == 1)) || die "The script takes only one argument"

  local -l phrase_string=${1//\\n/ }
  phrase_string=${phrase_string//[^\'[:alnum:]]/ }

  declare -A word_count_array

  read -r -a phrase_array <<<"${phrase_string}"

  # declare -p phrase_array # debug

  for word in "${phrase_array[@]}"; do
    # echo "${word}" # debug
    word="${word##+(\')}" # Remove all leading apostrophes. Won't work without extglob
    word="${word%%+(\')}" # Remove all trailing apostrophes. Won't work without extglob
    word_count_array["${word}"]=$((${word_count_array["${word}"]-0} + 1))
  done

  # declare -p word_count_array # debug

  for word in "${!word_count_array[@]}"; do
    echo "${word}: ${word_count_array["${word}"]}"
  done

}

main "$@"
