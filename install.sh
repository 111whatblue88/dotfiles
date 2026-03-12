#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"

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

ACTIVE_THEME="$(cat ${DOTFILES_ROOT}/info/activeTheme.txt)"

echo -e "\e[32m\"$ACTIVE_THEME\" chosen, starting dotfile copy\e[0m"

echo -e "\e[32mrunning pacman install from install list\e[0m"
sudo pacman -S --needed - < $DOTFILES_ROOT/scripts/pacmanInstallList.txt

echo -e "\e[32mrunning font copy script\e[0m"
$DOTFILES_ROOT/scripts/installFonts.sh

echo -e "\e[32mrunning tmux install script\e[0m"
$DOTFILES_ROOT/scripts/installTmux.sh

echo -e "\e[32mrunning zsh install script\e[0m"
$DOTFILES_ROOT/scripts/installZsh.sh

echo -e "\e[32mrunning config copy script\e[0m"
$DOTFILES_ROOT/scripts/installConfigs.sh

echo -e "\e[32m\"$ACTIVE_THEME\" theme installation complete\e[0m"

zsh

