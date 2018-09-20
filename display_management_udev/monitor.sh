#!/bin/bash
# miguel.ortiz

#Wait to kernel to get the new devices
sleep 5 
#Set the screen
export DISPLAY=:0

# identify the device | mortiz
device=$(xrandr |grep "^DP.* connected" |awk '{print $1}')
 
#
#echo ${#device[@]}
xrandr --output $device --auto --output eDP1 --mode 1366x768 --rate 60.06 --same-as $device



