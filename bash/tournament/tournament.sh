#!/usr/bin/env bash

set -euo pipefail

die() {
  echo "$*" >&2
  exit 1
}

init_team() {
  # Stop if the team is already defined or empty.
  [[ -z $1 || -v 'teams[$1]' ]] && return

  teams["$1"]=1
  win["$1"]=0 draw["$1"]=0 loss["$1"]=0
}

row () {
  printf '%-30s | %2s | %2s | %2s | %2s | %2s\n' "$@"
}

main() {
  (($# == 1 || $# == 0)) || die "None or one file as argument"
  (($# == 1)) && [[ ! -f ${1} ]] && die "File not found"

  declare -A win draw loss teams

  while IFS=';' read -r home away score; do
    init_team "${home}"
    init_team "${away}"
    case "${score}" in
      win)
        ((win[$home]+=1, loss[$away]+=1))
        ;;
      loss)
        ((win[$away]+=1, loss[$home]+=1))
        ;;
      draw)
        ((draw[$home]+=1, draw[$away]+=1))
        ;;
      *) ;;
    esac
  done <"${1:-/dev/stdin}"

  row "Team" MP W D L P

  for team in "${!teams[@]}"; do
    matches=$(( win[$team] + draw[$team] + loss[$team] ))
    points=$(( 3 * win[$team] + draw[$team] ))
    row "$team" \
      $matches \
      "${win[$team]}" \
      "${draw[$team]}" \
      "${loss[$team]}" \
      $points
  done | sort -t"|" -k6,6nr -k1,1

}

main "$@"
