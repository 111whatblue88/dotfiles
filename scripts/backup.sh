#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
ACTIVE_THEME="$(cat ${DOTFILES_ROOT}/info/activeTheme.txt)"

echo -e "${GREEN}backing up old dotfiles${RESET}"

BACKUPDIR="$DOTFILES_ROOT/backup"
configs=(~/.config/*)

for dir in "${configs[@]}"; do
	echo -e "copying ${BLUE}${dir##*/}${RESET}..."
	cp -rv "~/.config/${dir##*/}" "${BACKUPDIR}"
done



