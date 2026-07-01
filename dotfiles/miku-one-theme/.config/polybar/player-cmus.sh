#!/bin/sh

info_string="cmus not running"

updateInfo () {

	if info=$(cmus-remote -Q 2> /dev/null); then
		status=$(echo "$info" | grep -v "set " | grep -v "tag " | grep "status " | cut -d ' ' -f 2)

		if [ "$status" = "playing" ] || [ "$status" = "paused" ] || [ "$status" = "stopped" ]; then
			title=$(echo "$info" | grep -v 'set ' | grep " title " | cut -d ' ' -f 3-)
			artist=$(echo "$info" | grep -v 'set ' | grep " artist " | cut -d ' ' -f 3-)
			position=$(echo "$info" | grep -v "set " | grep -v "tag " | grep "position " | cut -d ' ' -f 2)
			duration=$(echo "$info" | grep -v "set " | grep -v "tag " | grep "duration " | cut -d ' ' -f 2)

			if [ "$artist" ] || [ "$title" ]; then

				info_string="$artist - $title"

				if [ "$status" = "playing" ]; then
					info_string="(playing) $info_string"
				elif [ "$status" = "paused" ]; then
					info_string="(paused) $info_string"
				elif [ "$status" = "stopped" ]; then
					info_string="(stopped) $info_string"
				else
					info_string="cmus error"
				fi
			else
				info_string="no title or artist for this song"
			fi
		else
			info_string="no title or artist for this song"
		fi
	else
		info_string="cmus not running"
	fi


}

while true; do

	updateInfo

  end=${#info_string}
  echo $info_string
  echo $end
  if [[ end -lt 40 ]]; then
    echo "$info_string"
    continue
  fi

  echo "fkldsfk"

	text="$info_string"
	info_string="$info_string $info_string"
	end=${#text}
	text="$info_string"


	for (( i = 0; i < "${#text}"; i++ )); do
		if [[ $i -eq ${end} ]]; then
			i=0
		fi
		echo "${text:$i:${end}}"
		sleep 0.4
		updateInfo
		info_string="$info_string $info_string"
		if [[ $info_string != $text ]]; then
			break
		fi
	done
done

