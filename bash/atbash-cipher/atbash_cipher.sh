#!/usr/bin/env bash

set -euo pipefail

latin_alphabet="abcdefghijklmnopqrstuvwxyz"

die() {
  echo "$*" >&2
  exit 1
}

encode() {
  local string=$1
  local encoded_string=""
  local letter_counter=0

  for ((i = 0; i < ${#string}; i++)); do

    for ((letter_position = 0; letter_position < ${#latin_alphabet}; letter_position++)); do
      plain_letter=${string:$i:1}
      if [[ ! ${plain_letter} =~ [[:alpha:]] ]]; then
        encoded_letter="${plain_letter}"
      elif [[ ${plain_letter} == "${latin_alphabet:$letter_position:1}" ]]; then
        encoded_letter="${latin_alphabet:((-$letter_position - 1)):1}"
      fi
    done

    if ((letter_counter == 5)); then
      encoded_string="${encoded_string} "
      letter_counter=0
    fi

    encoded_string="${encoded_string}${encoded_letter}"
    ((letter_counter += 1))
  done

  echo "${encoded_string}"

}

decode() {
  local string=$1
  local decoded_string=""

  for ((i = 0; i < ${#string}; i++)); do

    for ((letter_position = 0; letter_position < ${#latin_alphabet}; letter_position++)); do
      encoded_letter=${string:$i:1}
      if [[ ! ${encoded_letter} =~ [[:alpha:]] ]]; then
        decoded_letter="${encoded_letter}"
      elif [[ ${encoded_letter} == "${latin_alphabet:$letter_position:1}" ]]; then
        decoded_letter="${latin_alphabet:((-$letter_position - 1)):1}"
      fi
    done

    decoded_string="${decoded_string}${decoded_letter}"
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
