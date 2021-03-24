#!/usr/bin/env bash

sort_external_and_compare() {
  local subject=${1}
  local anagram_candidates=${2}

  declare -a anagram_list

  subject_letters_sorted=$(echo "${subject}" | grep -o . | sort | tr -d "\n")
  for word in ${anagram_candidates}; do
    if [[ ! "${word,,}" == "${subject,,}" ]]; then
      word_letters_sorted=$(echo "${word}" | grep -o . | sort | tr -d "\n")
      if [[ "${word_letters_sorted,,}" == "${subject_letters_sorted,,}" ]]; then
        anagram_list+=("${word}")
      fi
    fi
  done

  echo "${anagram_list[*]}"

}

sort_external_and_compare "$@"
