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

read -p "do you want to configure monitor layout?(Y/N)" monitorYNRaw
monitorYN=$(echo "$monitorYNRaw" | tr '[:upper:]' '[:lower:]')
if [ $monitorYN = "y" ] || [ $monitorYN = "yes" ]; then 
  echo -e "\e[32mrunning monitor setup script\e[0m"
  $DOTFILES_ROOT/scripts/monitor.sh
fi

echo -e "\e[32mrunning font copy script\e[0m"
$DOTFILES_ROOT/scripts/installFonts.sh

echo -e "\e[32mrunning tmux install script\e[0m"
$DOTFILES_ROOT/scripts/installTmux.sh

echo -e "\e[32mrunning zsh install script\e[0m"
$DOTFILES_ROOT/scripts/installZsh.sh

echo -e "\e[32mrunning config copy script\e[0m"
$DOTFILES_ROOT/scripts/installConfigs.sh

if [ $monitorYN = "y" ] || [ $monitorYN = "yes" ]; then 
  echo -e "adding monitor script start line to i3 config to run at startup"

  echo " " >> "$HOME/.config/i3/config"
  echo "# this was added automatically by the rei-dotfiles installer" >> "$HOME/.config/i3/config"
  echo "exec --no-startup-id $HOME/monitorSetup.sh" >> "$HOME/.config/i3/config"
fi

echo -e "\e[32m\"$ACTIVE_THEME\" theme installation complete\e[0m"


