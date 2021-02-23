#!/usr/bin/env bash

set -euo pipefail
source functions.bash

sentence=$(str::trim "${1-}")

if [[ "${sentence}" =~ \?$ && ! "${sentence}" =~ [a-z] && "${sentence}" =~ [A-Z] ]]; then
  # yell a question at him
  echo "Calm down, I know what I'm doing!"
elif [[ "${sentence}" =~ \?$ ]]; then
  # Ask him a question
  echo "Sure."
elif [[ ! "${sentence}" =~ [a-z] && "${sentence}" =~ [A-Z] ]]; then
  # YELL AT HIM
  echo "Whoa, chill out!"
elif [[ ! "${sentence}" =~ [A-Za-z0-9] ]]; then
  # Address him without actually saying anything
  echo "Fine. Be that way!"
else
  # Anything else
  echo "Whatever."
fi
