#!/usr/bin/env bash

set -e

local color=$1
shift
local text="$*"

case $color in
    red)    echo -e "\033[0;31mi -> $text\033[0m";;
    green)  echo -e "\033[0;32m -> $text\033[0m";;
    yellow) echo -e "\033[0;33m -> $text\033[0m";;
    *) echo -e "-> $text";;
esac

