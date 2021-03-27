#!/usr/bin/env bash


die() {
  echo "$*" >&2
  exit 1
}


main() {
  (($# == 1)) || die "The script takes only one argument"

  input_string=${1^^}

  declare -A nucleotides_count
  nucleotides_count=(
    [A]="0"
    [C]="0"
    [G]="0"
    [T]="0"
    )

  for ((i=0 ; i<${#input_string};i++));do
    nucleotide=${input_string:$i:1}
    if [[ "${!nucleotides_count[*]}" =~ ${nucleotide} ]];then
      ((nucleotides_count[$nucleotide]+=1))
    else
      die "Invalid nucleotide in strand"
    fi
  done

  printf "A: %s\nC: %s\nG: %s\nT: %s\n" \
    "${nucleotides_count[A]}" \
    "${nucleotides_count[C]}" \
    "${nucleotides_count[G]}" \
    "${nucleotides_count[T]}"

}

main "$@"
