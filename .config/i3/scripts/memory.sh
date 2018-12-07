#!/bin/bash

#Checks for low memory.

TOTAL_MEM=$(free -m|awk '/^Mem:/{print $2}')
FREE_MEM=$(free -m|awk '/^Mem:/{print $7}')
FREE_MEM_PERCENT=$(($FREE_MEM * 100 / $TOTAL_MEM))
AVAILABLE_MEM=$(free -m|awk '/^Mem:/{print $4}')
AVAILABLE_MEM_PERCENT=$(($AVAILABLE_MEM * 100 / $TOTAL_MEM))

#Minimum available memory limit, MB
THRESHOLD=300

# echo $AVAILABLE_MEM_PERCENT

if [ $FREE_MEM -lt $THRESHOLD ];then
      # echo $AVAILABLE_MEM

      notify-send "Low free memory" "$AVAILABLE_MEM\mb ($AVAILABLE_MEM_PERCENT\%) - available \n $FREE_MEM\mb ($FREE_MEM_PERCENT\%) - free" -u critical
# else
      # echo ''
fi;
