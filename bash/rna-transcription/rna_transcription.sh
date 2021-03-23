#!/usr/bin/env bash


using_strings() {
  local input_string=$1

  local dna_strand_map="GCTA"
  local rna_strand_map="CGAU"
  local output_string=""

  for (( i=0 ; i < ${#input_string} ; i++ )); do
    input_char="${input_string:$i:1}"

    if [[ ! "${dna_strand_map}" == *"${input_char}"* ]]; then
      echo "Invalid nucleotide detected."
      exit 1
    fi

    for (( j=0 ; j < ${#dna_strand_map} ; j++)); do
      if [[ "${input_char}" == "${dna_strand_map:$j:1}" ]]; then
        output_string+="${rna_strand_map:j:1}"
      fi
    done
  done

  echo "${output_string}"

}

using_assosiative_array(){
  local input_string=$1
  local output_string=""

  declare -A strand_map

  strand_map=(
    [G]="C"
    [C]="G"
    [T]="A"
    [A]="U"
    )

  for (( i=0 ; i < ${#input_string} ; i++ )); do
    input_char="${input_string:$i:1}"

    if [[ ! "${!strand_map[*]}" == *"${input_char}"* ]]; then
      echo "Invalid nucleotide detected."
      exit 1
    else
      output_string+="${strand_map[${input_char}]}"
    fi

  done

  echo "${output_string}"

}

# using_strings "$@"
using_assosiative_array "$@"
