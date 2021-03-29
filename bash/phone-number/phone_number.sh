#!/usr/bin/env bash

input_number=${1//[^[:digit:]]/}


if ((${#input_number} < 10)) || ((${input_number:(-10):1} < 2 )) || ((${input_number:(-7):1} < 2 )); then
  echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9" >&2
  exit 1
fi

if ((${#input_number} != 10)); then
  if ((${#input_number} != 11)) || ((${input_number:(-11):1} != 1)); then
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9" >&2
    exit 1
  fi
  input_number=${input_number:(-10)}
fi

echo "${input_number}"
