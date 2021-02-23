#!/usr/bin/env bash

set -Euo pipefail
trap 'echo "Error on line $LINENO. Exit code: $?" >&2' ERR

die() {
  echo "$*" >&2
  exit 1
}

main() {
  (($# == 1)) || die "Usage: acronym.sh <string>"

  local string=$1
  local acronym=""

  ### Remove alpha chars
  string="${string//[^[:alpha:]- ]/}"

  IFS=' -' read -r -a phrase_words <<< "${string}"

  for word in "${phrase_words[@]}"; do
    acronym+="${word:0:1}"
  done

  echo "${acronym^^}"

}

main "$@"
