#!/usr/bin/env bash

invalid () {
  echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9" >&2
  exit 1
}

main(){
  (( $# == 1  )) || exit 1

  local input_number=${1//[^[:digit:]]/}

  (( ${#input_number} == 11 )) && ((${input_number:(-11):1} == 1)) && input_number=${input_number:(-10)}
  (( ${#input_number} != 10 )) && invalid
  ((${input_number:(-10):1} < 2 )) || ((${input_number:(-7):1} < 2 )) && invalid

  echo "${input_number}"
}

main "$@"
