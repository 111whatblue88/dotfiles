#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"

themes=()
for i in "${DOTFILES_ROOT}/dotfiles"/*; do
  themes+=("$i")
done

foundTheme="false"

for theme in ${themes[@]}; do
  if [ "${theme##*/}" = "$1" ]; then
    foundTheme="true"
    break 
  fi
done

if [ $foundTheme = "false" ]; then
  echo -e "${RED}theme \"$1\" not found, exiting...${RESET}"
  exit
fi

if ! [ -e ${DOTFILES_ROOT}/info ]; then
  mkdir ${DOTFILES_ROOT}/info
  touch ${DOTFILES_ROOT}/info/activeTheme.txt
fi

echo "$1" > "${DOTFILES_ROOT}/info/activeTheme.txt"

ACTIVE_THEME="$(cat ${DOTFILES_ROOT}/info/activeTheme.txt)"

echo -e "\e[32m\"$ACTIVE_THEME\" chosen, starting dotfile copy\e[0m"

echo -e "\e[32mrunning font copy script\e[0m"
$DOTFILES_ROOT/scripts/installFonts.sh

echo -e "\e[32mrunning tmux install script\e[0m"
$DOTFILES_ROOT/scripts/installTmux.sh

echo -e "\e[32mrunning zsh install script\e[0m"
$DOTFILES_ROOT/scripts/installZsh.sh

echo -e "\e[32mrunning config copy script\e[0m"
$DOTFILES_ROOT/scripts/installConfigs.sh

echo -e "\e[32m\"$ACTIVE_THEME\" theme installation complete\e[0m"


