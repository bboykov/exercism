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

  echo "${converted_char}"

}

encode() {
  local string=$1
  local encoded_string=""
  local char_counter=0

  for ((i = 0; i < ${#string}; i++)); do

    encoded_char=$(transpose_char "${string:$i:1}")

    if ((char_counter == 5)); then
      encoded_string="${encoded_string} "
      char_counter=0
    fi

    encoded_string="${encoded_string}${encoded_char}"
    ((char_counter += 1))
  done

  echo "${encoded_string}"
}

decode() {
  local string=$1
  local decoded_string=""

  for ((i = 0; i < ${#string}; i++)); do

    decoded_char=$(transpose_char "${string:$i:1}")

    decoded_string="${decoded_string}${decoded_char}"
  done

  echo "${decoded_string}"
}

main() {
  if [[ $# -ne 2 ]]; then
    die "The script takes exactly two arguments"
  fi

  local mode=$1
  local raw_string=${2}
  local string

  raw_string="${raw_string,,}"
  raw_string="${raw_string// /}"
  raw_string=$(echo "$raw_string" | tr -d '[:punct:]')

  string="${raw_string}"

  case "${mode}" in
    encode | decode)
      "${mode}" "${string}"
      ;;
    *)
      die "Unknown mode"
      ;;
  esac

}

main "$@"
