#!/usr/bin/env bash

set -euo pipefail

bc_calc() {
  bc <<<"$@"
}

calc() {
  # The idea behind having calc and bc_cal was to be able to swap between
  # different calc methods, like bc and bash only. Later droped the idea of
  # implemening bash only calculation. Bash cannot easly handle with big
  # numbers and that is why I decided to use
  # "bc" to do the calcolations
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
    echo "${result}"
  elif [[ $((input_argument)) -lt 1 || $((input_argument)) -gt 64 ]]; then
    echo "Error: invalid input"
    exit 1
  else
    current_grains=1
    for ((i = 0; i < input_argument - 1; i++)); do
      current_grains=$(calc "${current_grains} * 2")
    done
    echo "${current_grains}"
  fi
}

calc_2() {
  square=$1
  mode=$2

  case "${mode}" in
    total) bc <<<"2^${square}-1" ;;
    square_sum) bc <<<"2^(${square}-1)" ;;
    *) echo "Error: invalid input"; exit 1 ;;
  esac

}

### After reading some more and exporing other solutions I did the next solution
all_with_direct_calc() {
  local input_argument=$1

  if [[ "${input_argument}" == "total" ]]; then
    calc_2 64 total
  elif [[ $((input_argument)) -lt 1 || $((input_argument)) -gt 64 ]]; then
    echo "Error: invalid input"
    exit 1
  else
    calc_2 "${input_argument}" square_sum
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

# Comment:
# The brute_force_add_calc was the most intuitive solution that came to my
# mind. My very first solution was to calculate all values in an array and call
# out the requested square or total. This is slow. Calculating just to the
# requested square is better, but the bigger the number becomes slower, and the
# total takes the longest time.

# direct_calc "$@"

# Result from "bash measure.sh"
# grains.sh 1             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3408
# grains.sh 2             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3384
# grains.sh 3             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3212
# grains.sh 4             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3280
# grains.sh 16            Elapsed: 0:00.02        User: 0.02      System: 0.00    Memory: 3448
# grains.sh 32            Elapsed: 0:00.05        User: 0.04      System: 0.01    Memory: 3216
# grains.sh 64            Elapsed: 0:00.10        User: 0.09      System: 0.02    Memory: 3464
# grains.sh total         Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3532

# Comment:
# The direct_calc solution is much better when calculating the total. But still
# calculating for a given square gets slower with bigger square number. This is
# because I use loop and bc to brute calculate the result.

all_with_direct_calc "$@"

# Result from "bash measure.sh"
# grains.sh 1             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3400
# grains.sh 2             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3528
# grains.sh 3             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3240
# grains.sh 4             Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3312
# grains.sh 16            Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3388
# grains.sh 32            Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3380
# grains.sh 64            Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3568
# grains.sh total         Elapsed: 0:00.00        User: 0.00      System: 0.00    Memory: 3344

# Comment:
# The all_with_direct_calc is the best solution I can think of. After looking
# at the community solutions I saw how to do direct calculation for a given
# square as well. I decided to drop the calc func beause it gives little value
# just calling bc. calc_2 clears things and gives the option to calculate total
# or square grains sum for any square.
