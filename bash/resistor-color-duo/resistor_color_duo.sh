#!/usr/bin/env bash

declare -A RESISTOR_COLORS

readonly RESISTOR_COLORS=(
  [black]="0"
  [brown]="1"
  [red]="2"
  [orange]="3"
  [yellow]="4"
  [green]="5"
  [blue]="6"
  [violet]="7"
  [grey]="8"
  [white]="9"
)

validate_color() {
  local color=${1}

  for value in "${!RESISTOR_COLORS[@]}"; do
    if [[ "${value}" == "${color}" ]]; then
      return 0
    fi

  done

  return 1

}

main() {

  local validate_color_1
  local validate_color_2

  if [[ "$#" -lt 2 ]]; then
    echo "invalid colors" >&2
    exit 1
  fi

  validate_color "${1}"
  validate_color_1=$?

  validate_color "${2}"
  validate_color_2=$?

  if [[ ${validate_color_1} -ne 0 || ${validate_color_2} -ne 0 ]]; then
    echo "invalid color" >&2
    exit 1
  fi

  color_1="${RESISTOR_COLORS[${1}]}"
  color_2="${RESISTOR_COLORS[${2}]}"

  echo "${color_1}${color_2}"

}

main "$@"
