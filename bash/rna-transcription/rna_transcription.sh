#!/usr/bin/env bash

input_string=$1

dna_strand_map="GCTA"
rna_strand_map="CGAU"
output_string=""

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
