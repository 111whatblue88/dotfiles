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
	for monitor in ${monitors[@]}; do
		((count++))
		themes+=("$i")
		echo -e "[#${BLUE}${count}${RESET}]: ${monitor}"
	done

	read -p "choose a primary monitor(1-$count): " monitorChoice
	if [[ "$monitorChoice" -gt 0 && "$monitorChoice" -le "$count" ]]; then
		break
	else
		echo -e "${RED}invalid${RESET} choice, please pick a number between 1 and $count"
	fi
done

mainMonitor=${monitors[$monitorChoice-1]}
echo "$mainMonitor primary" >> "$DOTFILES_ROOT/info/monitorInfo.txt"
echo >> "$DOTFILES_ROOT/info/monitorInfo.txt"

# set up xrandr monitor script
setupFile="$HOME/monitorStartup.sh"
echo -e "${GREEN}creating monitor startup script${RESET}"
echo "#!/bin/bash" > "$setupFile"
chmod +x "$setupFile"

echo "# this was added automatically by the elo's dotfiles installer" >> $setupFile
echo "# sets refresh rate to really high number, as xrandr lowers it to the nearest supported, stupid way ik hehehe" >> $setupFile

echo  "xrandr --output $mainMonitor --mode 1920x1080 --rate 1000 --primary" >> $setupFile

echo -e "${BLUE}created $setupFile$RESET"

# setup monitor layout

for monitor in ${monitors[@]}; do

  if [ $monitor = $mainMonitor ]; then
    continue
  fi

	count=0
	themes=()
	for monitor in ${monitors[@]}; do
		((count++))
		echo -e "[#${BLUE}${count}${RESET}]: ${monitor}"
	done

	read -p "which monitor to relate placement to?(1-$count): " monitorChoice
	if [[ "$monitorChoice" -gt 0 && "$monitorChoice" -le "$count" ]]; then
		break
	else
		echo -e "${RED}invalid${RESET} choice, please pick a number between 1 and $count"
	fi

  echo "[#1]: left"
  echo "[#2]: right"
  echo "[#3]: up"
  echo "[#4]: down"
  echo "[#5]: do not use"

  read -p "where to put $monitor in relation to $monitorChoice?(1-5): " monitorPlacement

  case "$monitorPlacement" in

    "1") 
      echo "xrandr --output $monitor --mode 1920x1080 --rate 1000 --left-of $monitorChoice" >> $setupFile
    ;;
    "2") 
      echo "xrandr --output $monitor --mode 1920x1080 --rate 1000 --right-of $monitorChoice" >> $setupFile
    ;;
    "3") 
      echo "xrandr --output $monitor --mode 1920x1080 --rate 1000 --above $monitorChoice" >> $setupFile
    ;;
    "4")
      echo "xrandr --output $monitor --mode 1920x1080 --rate 1000 --below $monitorChoice" >> $setupFile
    ;;
    "5") 
      continue
    ;;
  esac

done

echo -e "${GREEN}monitor setup complete$RESET"



