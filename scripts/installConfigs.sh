#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"

echo -e "${GREEN}starting configs installation${RESET}"

while true; do
	count=0
	themes=()
	for i in "${DOTFILES_ROOT}/dotfiles"/*; do
		((count++))
		themes+=("$i")
		echo -e "[#${BLUE}${count}${RESET}]: ${i##*/}"
	done

	read -p "choose a theme(1-$count): " themeChoice
	if [[ "$themeChoice" -gt 0 && "$themeChoice" -le "$count" ]]; then
		break
	else
		echo -e "${RED}invalid${RESET} choice, please pick a number between 1 and $count"
	fi

done

echo -e "starting install of ${BLUE}${themes[$((themeChoice-1))]##*/}${RESET}"

THEMEDIR="${themes[$((themeChoice-1))]}"
configs=("${themes[$((themeChoice-1))]}"/.config/*)

for dir in "${configs[@]}"; do
	echo "copying ${dir##*/}..."
	mkdir -p "${HOME}/.config/${dir##*/}"
	cp -v "${THEMEDIR}/.config/${dir##*/}"/* "${HOME}/.config/${dir##*/}"
done

echo -e "${GREEN}finished installing configs${RESET}"
