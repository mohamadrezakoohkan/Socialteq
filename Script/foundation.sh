#!/bin/sh 

GREEN="`tput setaf 2`"
CYAN="`tput setaf 6`"
RED="`tput setaf 196`"
BOLD="`tput bold`"
NORMAL="`tput sgr0`"
STEP=0

print() {
    STEP=$((STEP + 1))
    echo ${CYAN}${BOLD}[${STEP}]${GREEN} $1${NORMAL};
}