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

echo "${themes[$((themeChoice-1))]##*/}" > "${DOTFILES_ROOT}/info/activeTheme.txt"

echo -e "${GREEN}preparing theme install...${RESET}"
echo "removing old assets folder..."
rm -rf "${HOME}/.config/assets"

echo -e "starting installation of ${BLUE}${themes[$((themeChoice-1))]##*/}${RESET}"

THEMEDIR="${themes[$((themeChoice-1))]}"
configs=("${themes[$((themeChoice-1))]}"/.config/*)

for dir in "${configs[@]}"; do
	echo -e "copying ${BLUE}${dir##*/}${RESET}..."
	mkdir -p "${HOME}/.config/${dir##*/}"
	cp -rv "${THEMEDIR}/.config/${dir##*/}"/* "${HOME}/.config/${dir##*/}"
done

echo -e "${GREEN}starting configs reload${RESET}"

echo -e "restarting i3..."
i3-msg restart >/dev/null
echo -e "reloading background image..."
feh --bg-fill "${HOME}/.config/assets"/*.jpg
echo -e "restarting polybar..."
pkill polybar
"${HOME}/.config/polybar/start.sh" >/dev/null 2>/dev/null
echo -e "restarting picom..."
pkill picom
wait 1
picom &

echo -e "${GREEN}finished installing configs${RESET}"
