#!/usr/bin/env bash

input_number=$1

die() {
  echo "$*" >&2
  exit 1
}

if [[ $# -ne 1 ]]; then
  die "The script takes exactly one argument"
elif ((input_number < 1)); then
  die "Error: Only positive numbers are allowed"
fi

counter=0

while ((input_number != 1)); do
  if ((input_number % 2)); then
    input_number=$((input_number * 3 + 1))
  else
    input_number=$((input_number / 2))
  fi
  ((counter++))
done

echo ${counter}
