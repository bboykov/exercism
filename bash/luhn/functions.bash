#!/usr/bin/env bash

shopt -s extglob

#######################################
# Description:
#   Check that the parameter is a valid integer
#
# Usage:
#   str::is_int 5 ; is_5_int_out=$? ; echo $is_5_int_out
# Globals:
#   None
# Arguments:
#   - String to inspect
# Outputs:
#   Returns true or false
#######################################
str::is_int() { [[ $1 == ?([-+])+([[:digit:]]) ]]; }
str::is_float() {
  [[ $1 == ?([-+])+([[:digit:]])?(.*([[:digit:]])) ]] ||
    [[ $1 == ?([-+])*([[:digit:]]).+([[:digit:]]) ]]
}
