#!/bin/bash
FREE_MEM=$(free -m|awk '/^Mem:/{print $7}')

#Minimum available memory limit, MB
THRESHOLD=350

#Checks for low memory.
if [ $FREE_MEM -lt $THRESHOLD ];then
   # TOTAL_MEM=$(free -m|awk '/^Mem:/{print $2}')
   # FREE_MEM_PERCENT=$(($FREE_MEM * 100 / $TOTAL_MEM))
   # AVAILABLE_MEM=$(free -m|awk '/^Mem:/{print $4}')
   # AVAILABLE_MEM_PERCENT=$(($AVAILABLE_MEM * 100 / $TOTAL_MEM))

   echo $FREE_MEM 'mb'

   # notify-send "Low free memory" "$FREE_MEM" -u critical
else
   echo ''
fi;
