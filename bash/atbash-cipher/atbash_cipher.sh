#!/usr/bin/env bash

set -euo pipefail

die() {
  echo "$*" >&2
  exit 1
}

transpose_char() {
  local alphabet="abcdefghijklmnopqrstuvwxyz"
  local char=$1

  for ((char_position = 0; char_position < ${#alphabet}; char_position++)); do
    if [[ ! ${char} =~ [[:alpha:]] ]]; then
      char_transposed="${char}"
    elif [[ ${char} == "${alphabet:$char_position:1}" ]]; then
      char_transposed="${alphabet:((-$char_position - 1)):1}"
    fi
  done

  echo "${char_transposed}"

}

transpose_string() {
  local mode=$1
  local string=$2
  local transpose_string=""
  local char_counter=0

  local alphabet="abcdefghijklmnopqrstuvwxyz"

  for ((i = 0; i < ${#string}; i++)); do
    transpose_char="${string:$i:1}"

    for ((char_position = 0; char_position < ${#alphabet}; char_position++)); do
      if [[ ! ${transpose_char} =~ [[:alpha:]] ]]; then
        char_transposed="${transpose_char}"
      elif [[ ${transpose_char} == "${alphabet:$char_position:1}" ]]; then
        char_transposed="${alphabet:((-$char_position - 1)):1}"
      fi
    done

    if ((char_counter == 5)); then
      transpose_string+=" "
      char_counter=1
    elif [[ "${mode}" == "encode" ]]; then
      ((char_counter += 1))
    fi

    transpose_string+="${char_transposed}"

  done

  echo "${transpose_string}"
}

main() {
  if [[ $# -ne 2 ]]; then
    die "The script takes exactly two arguments"
  fi

  local mode=$1
  local raw_string=${2//[^[:alnum:]]/}
  local string

  string="${raw_string,,}"

  case "${mode}" in
    encode | decode)
      transpose_string "${mode}" "${string}"
      ;;
    *)
      die "Unknown mode"
      ;;
  esac

}

main "$@"
