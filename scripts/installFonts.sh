#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
ACTIVE_THEME="$(cat ${DOTFILES_ROOT}/info/activeTheme.txt)"

echo -e "\e[32mstarting font copy for \"$ACTIVE_THEME\" theme\e[0m"

if [ -z "$(ls $DOTFILES_ROOT/dotfiles/$ACTIVE_THEME/.fonts/ 2>/dev/null)" ]; then
  echo -e "\e[31mno font files found for \"$ACTIVE_THEME\" theme, ending font copy\e[0m"
  exit
fi

mkdir -p ~/.fonts
cp -v $DOTFILES_ROOT/dotfiles/$ACTIVE_THEME/.fonts/*.ttf ~/.fonts
echo -e "\e[32mfont copy complete\e[0m"

