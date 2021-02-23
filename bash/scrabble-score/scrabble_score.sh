#!/usr/bin/env bash

set -euo pipefail

word=${1^^}
word_len=${#1}
score=0

if [[ "${word}" =~ [[:alpha:]] ]]; then

  for ((i = 0; i < word_len; i++)); do
    char="${word:i:1}"
    case ${char} in
      A | E | I | O | U | L | N | R | S | T)
        score=$((score + 1))
        ;;
      D | G)
        score=$((score + 2))
        ;;
      B | C | M | P)
        score=$((score + 3))
        ;;
      F | H | V | W | Y)
        score=$((score + 4))
        ;;
      K)
        score=$((score + 5))
        ;;
      J | X)
        score=$((score + 8))
        ;;
      Q | Z)
        score=$((score + 10))
        ;;
    esac
  done

fi

echo ${score}
