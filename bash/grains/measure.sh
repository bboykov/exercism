#!/usr/bin/env bash
# Based on https://askubuntu.com/questions/915132/measure-performance-of-a-fast-bash-script

set -euo pipefail

measure() {
  local script=$1
  shift
  local arguments=("$@")

  command time \
    -f "${script} ${arguments[*]}\t\tElapsed: %E \tUser: %U \tSystem: %S \tMemory: %M" \
    bash "${script}" "${arguments[@]}" 1>/dev/null
}

measure grains.sh 1
measure grains.sh 2
measure grains.sh 3
measure grains.sh 4
measure grains.sh 16
measure grains.sh 32
measure grains.sh 64
measure grains.sh total
