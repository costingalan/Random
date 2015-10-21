#!/bin/bash
for PID in $(pgrep "$1"); 
  do 
    grep Private_Dirty /proc/"$PID"/smaps | awk '{sum += $2} END {print sum}';

  done | awk '{sum += $1} END {print sum " KB"}'
