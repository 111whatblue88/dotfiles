#!/bin/bash

oldInstances=$(pgrep polybar)
for instance in ${oldInstances[@]}; do 
  kill $instance
done

polybarInitPrimary () {

  MONITOR=$1 polybar mainbar &
}
polybarInitMinimal () {
  MONITOR=$1 polybar mainbar &
}

numMonitors=$(polybar -m | wc -l | awk '{print $1}')
monitors=($(xrandr | grep -w connected | awk '{print $1}'))

if [[ $numMonitors = "1" ]]; then 
  polybarInitPrimary ${monitors[0]}
  exit
fi

primaryMonitor=$(xrandr | grep -w primary | awk '{print $1}')

for monitor in ${monitors[@]}; do

  if [[ $monitor = $primaryMonitor ]]; then 
    polybarInitPrimary $monitor
    continue 
  fi

  polybarInitMinimal $monitor

done


