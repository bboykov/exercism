#!/usr/bin/env bash

set -euo pipefail

chess_squares_number=$1
chess_squares_count="64"
chess_squares_grains=()

if [[ "${chess_squares_number}" == "total" ]]; then
  total_sum=0
elif [[ $((chess_squares_number)) -lt 1 || $((chess_squares_number)) -gt 64 ]]; then
  echo "Error: invalid input"
  exit 1
fi

chess_squares_grains[0]=1

for ((i = 0; i < chess_squares_count; i++)); do
  next_square="$(echo "${chess_squares_grains[i]} + ${chess_squares_grains[i]}"| bc)"
  chess_squares_grains[$i+1]="${next_square}"
done

if [[ "${chess_squares_number}" == 'total' ]];then
  for ((i = 0; i < chess_squares_count; i++)); do
    total_sum=$(echo $total_sum + "${chess_squares_grains[i]}"|bc)
  done
  echo "${total_sum}"
else
  echo "${chess_squares_grains[${chess_squares_number}-1]}"
fi
