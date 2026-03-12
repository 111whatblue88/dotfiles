#!/bin/bash

oldInstances=$(pgrep polybar)
for instance in ${oldInstances[@]}; do 
  kill $instance
done

polybarInitPrimary () {

  MONITOR=$1 polybar cmusbar &
  MONITOR=$1 polybar i3bar &
  MONITOR=$1 polybar storagebar &
  MONITOR=$1 polybar hardwarebar &
  MONITOR=$1 polybar softwarebar &
  sleep 2
  MONITOR=$1 polybar textbar &
}
polybarInitMinimal () {
  MONITOR=$1 polybar textbar &
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


