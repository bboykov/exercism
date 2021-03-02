#!/usr/bin/env bash

set -euo pipefail

die() {
  echo "$*" >&2
  exit 1
}

increment_wins() {
  local team=$1
  local increment=$2
  win["${team}"]=$((${win["${team}"]-0} + increment))
}

increment_loss() {
  local team=$1
  local increment=$2
  loss["${team}"]=$((${loss["${team}"]-0} + increment))
}

increment_matches_played() {
  local team=$1
  local increment=$2
  matches_played["${team}"]=$((${matches_played["${team}"]-0} + increment))
}

increment_points() {
  local team=$1
  local increment=$2
  points["${team}"]=$((${points["${team}"]-0} + increment))
}

increment_draw() {
  local team=$1
  local increment=$2
  draw["${team}"]=$((${draw["${team}"]-0} + increment))
}

main() {
  (($# == 1 || $# == 0)) || die "None or one file as argument"
  (($# == 1)) && [[ ! -f ${1} ]] && die "File not found"

  declare -A win loss draw matches_played points

  while IFS=';' read -r team1 team2 score; do
    case "${score}" in
      win)
        increment_wins "${team1}" 1
        increment_loss "${team1}" 0

        increment_wins "${team2}" 0
        increment_loss "${team2}" 1

        increment_matches_played "${team1}" 1
        increment_matches_played "${team2}" 1

        increment_draw "${team1}" 0
        increment_draw "${team2}" 0

        increment_points "${team1}" 3
        increment_points "${team2}" 0

        ;;
      loss)
        increment_wins "${team1}" 0
        increment_loss "${team1}" 1

        increment_wins "${team2}" 1
        increment_loss "${team2}" 0

        increment_draw "${team1}" 0
        increment_draw "${team2}" 0

        increment_matches_played "${team1}" 1
        increment_matches_played "${team2}" 1

        increment_points "${team1}" 0
        increment_points "${team2}" 3

        ;;

      draw)
        increment_wins "${team1}" 0
        increment_loss "${team1}" 0

        increment_wins "${team2}" 0
        increment_loss "${team2}" 0

        increment_draw "${team1}" 1
        increment_draw "${team2}" 1

        increment_matches_played "${team1}" 1
        increment_matches_played "${team2}" 1

        increment_points "${team1}" 1
        increment_points "${team2}" 1

        ;;
    esac
  done <"${1:-/dev/stdin}"

  header="%-30s |%3s |%3s |%3s |%3s |%3s\n"
  # shellcheck disable=SC2059
  printf "${header}" "Team" "MP" "W" "D" "L" "P"
  for key in "${!points[@]}"; do
    # shellcheck disable=SC2059
    printf "${header}" \
      "${key}" \
      "${matches_played[$key]}" \
      "${win[$key]}" \
      "${draw[$key]}" \
      "${loss[$key]}" \
      "${points[$key]}"

  done |
    sort -t\| -k6,6nr -k1

}

main "$@"
