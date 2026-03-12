#!/bin/bash 

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
ACTIVE_THEME="$(cat ${DOTFILES_ROOT}/info/activeTheme.txt)"

echo -e "${GREEN}fetching monitors...${RESET}"

monitors=($(xrandr | grep -w connected | awk '{print $1}'))

for monitor in "${monitors[@]}"; do
  echo -e "${BLUE}found connected monitor: $monitor${RESET}"
done

while true; do
	count=0
	themes=()
	for monitor in $monitors; do
		((count++))
		themes+=("$i")
		echo -e "[#${BLUE}${count}${RESET}]: ${monitor}"
	done

	read -p "choose a main monitor(1-$count): " monitorChoice
	if [[ "$monitorChoice" -gt 0 && "$monitorChoice" -le "$count" ]]; then
		break
	else
		echo -e "${RED}invalid${RESET} choice, please pick a number between 1 and $count"
	fi
done

mainMonitor=${monitors[$monitorChoice-1]}

for monitor in $monitors; do

  if [ $monitor = $mainMonitor ]; then
    continue
  fi

  while true; do 
    echo -e "Where should this monitor go in relation to $mainMonitor?: $monitor"
    echo -e "[#1]: Left"
    echo -e "[#2]: Right"
    echo -e "[#3]: Do not use"

    read -p "choose an option(1-$count): " placementChoice
    if [[ "$monitorChoice" -gt 0 && "$monitorChoice" -le 3 ]]; then
      break
    else
      echo -e "${RED}invalid${RESET} choice, please pick a number between 1 and 3"
    fi

    case $placementChoice in 
      "1")
        xrandr --output $monitorChoice --mode 1920x1080 --output $monitor --mode 1920x1080 --left-of $monitorChoice
        ;;

      "2")
        xrandr --output $monitorChoice --mode 1920x1080 --output $monitor --mode 1920x1080 --right-of $monitorChoice
        ;;

      "3")
        ;;
    esac

  done

done




