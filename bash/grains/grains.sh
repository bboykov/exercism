#!/usr/bin/env bash

set -euo pipefail

bc_calc() {
  bc <<<"$@"
}

calc() {
  bc_calc "$@"
}

### This my initial solution for the exersice
brute_force_add_calc() {
  local input_argument=$1
  local total=false

  if [[ "${input_argument}" == "total" ]]; then
    total=true
    total_sum=0
    chess_square_number="64"
  elif [[ $((input_argument)) -lt 1 || $((input_argument)) -gt 64 ]]; then
    echo "Error: invalid input"
    exit 1
  else
    local chess_square_number="${input_argument}"
  fi

  chess_squares_grains[0]=1

  for ((i = 0; i < chess_square_number; i++)); do
    next_square="$(calc ${chess_squares_grains[i]} + ${chess_squares_grains[i]})"
    chess_squares_grains[$i + 1]="${next_square}"
  done

  if ${total}; then
    for ((i = 0; i < chess_square_number; i++)); do
      total_sum="$(calc ${total_sum} + "${chess_squares_grains[i]}")"
    done
    echo "${total_sum}"
  else
    echo "${chess_squares_grains[${chess_square_number} - 1]}"
  fi
}

### After some reading I did the next solution
### https://en.wikipedia.org/wiki/Wheat_and_chessboard_problem
### https://exercism.io/blog/coding-intentionally-in-bash-grains
direct_calc() {
  local input_argument=$1

  if [[ "${input_argument}" == "total" ]]; then
    chess_square_number="64"
    result=$(calc "2^${chess_square_number}-1")
    echo ${result}
  elif [[ $((input_argument)) -lt 1 || $((input_argument)) -gt 64 ]]; then
    echo "Error: invalid input"
    exit 1
  else
    current_grains=1
    for ((i = 0; i < input_argument-1; i++)); do
      current_grains=$(calc "${current_grains} * 2" )
    done
    echo ${current_grains}
  fi

}

# brute_force_add_calc "$@"

# Result from "bash measure.sh"
# grains.sh 1             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3284
# grains.sh 2             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3340
# grains.sh 3             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3388
# grains.sh 4             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3420
# grains.sh 16            Elapsed: 0:00.02        User: 0.02      System: 0.00    Memory: 3444
# grains.sh 32            Elapsed: 0:00.05        User: 0.04      System: 0.01    Memory: 3460
# grains.sh 64            Elapsed: 0:00.11        User: 0.09      System: 0.02    Memory: 3492
# grains.sh total         Elapsed: 0:00.21        User: 0.19      System: 0.03    Memory: 3500

direct_calc "$@"

# Result from "bash measure.sh"
# grains.sh 1             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3408
# grains.sh 2             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3384
# grains.sh 3             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3212
# grains.sh 4             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3280
# grains.sh 16            Elapsed: 0:00.02        User: 0.02      System: 0.00    Memory: 3448
# grains.sh 32            Elapsed: 0:00.05        User: 0.04      System: 0.01    Memory: 3216
# grains.sh 64            Elapsed: 0:00.10        User: 0.09      System: 0.02    Memory: 3464
# grains.sh total         Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3532
