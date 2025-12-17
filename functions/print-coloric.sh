#!/usr/bin/env bash

set -e

local color=$1
shift
local text="$*"

case $color in
    red)    echo -e "\033[0;31mi -> $text\033[0m";;
    green)  echo -e "\033[0;32m -> $text\033[0m";;
    yellow) echo -e "\033[0;33m -> $text\033[0m";;
    black)  echo -e " \033[0;30m -> $text\033[0m";;
    blue)   echo -e "\033[0;34m -> $text\033[0m";;
    magenta) echo -e "\033[0;35 -> $text\033[0m";;
    cyan)   echo -e  "\033[0;36 -> $text\033[0m";;
    wghite) echo -e  "\033[0;37 -> $text\033[0m";;
    *) echo -e "-> $text";;
esac



