#!/bin/bash

polybar i3bar &
polybar storagebar &
polybar hardwarebar &

polybar cmusbar &
polybar softwarebar & 

sleep 0.5
polybar textbar &
