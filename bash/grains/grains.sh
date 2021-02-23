#!/usr/bin/env bash

set -euo pipefail

chess_squares_count="64"
chess_squares_grains=()

chess_squares_grains[0]=1

for ((i = 1; i <= chess_squares_count; i++)); do
  chess_squares_grains[i]=$(chess_squares_grains[i-1] * i)


done

declare -p chess_squares_grains
