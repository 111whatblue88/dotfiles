#!/bin/bash

width=35
sleep_time=0.2
padding="   "   # space between loops

last_info=""

while true; do
    info=$(cmus-remote -Q 2>/dev/null)

    if [ $? -ne 0 ]; then
        echo "[cmus not running]"
        sleep 2
        continue
    fi

    status=$(echo "$info" | grep "^status " | cut -d' ' -f2)
    artist=$(echo "$info" | grep "^tag artist " | cut -d' ' -f3-)
    title=$(echo "$info"  | grep "^tag title "  | cut -d' ' -f3-)

    if [ -z "$artist" ] && [ -z "$title" ]; then
        text="[nothing playing]"
    else
        text="($status) $artist - $title"
    fi

    # Only rebuild scroll if song changed
    if [ "$text" != "$last_info" ]; then
        last_info="$text"

        # Build seamless loop
        scroll_text="$text$padding$text$padding"

        len=${#scroll_text}
        pos=0
    fi

    # Output one frame
    printf "%s\n" "${scroll_text:pos:width}"

    # Advance position
    pos=$(( (pos + 1) % len ))

    sleep "$sleep_time"
done


