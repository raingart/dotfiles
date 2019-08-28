#!/bin/bash
FREE_MEM=$(free -m|awk '/^Mem:/{print $7}')

#Minimum available memory limit, MB
THRESHOLD=400

#Checks for low memory.
if [ $FREE_MEM -lt $THRESHOLD ];then
   TOTAL_MEM=$(free -m|awk '/^Mem:/{print $2}')
   FREE_MEM_PERCENT=$(($FREE_MEM * 100 / $TOTAL_MEM))
   AVAILABLE_MEM=$(free -m|awk '/^Mem:/{print $4}')
   AVAILABLE_MEM_PERCENT=$(($AVAILABLE_MEM * 100 / $TOTAL_MEM))

   echo $AVAILABLE_MEM 'mb'

   notify-send "Low free memory" "$AVAILABLE_MEM\mb ($AVAILABLE_MEM_PERCENT\%) - available \n $FREE_MEM\mb ($FREE_MEM_PERCENT\%) - free" -u critical
else
   echo ''
fi;
