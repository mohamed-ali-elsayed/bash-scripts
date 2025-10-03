#!/bin/bash
# Script to find zombie processes and kill their parent process

# Get the PID of the first zombie process
Z_PID=$(ps aux | grep defunct | grep -v grep | awk '{ print $2 }')

# Get the parent PID of the zombie process
Z_PPID=$(ps lax | awk -v zpid="$Z_PID" '$3 == zpid { print $4 }')

# Kill the parent process to remove the zombie
kill -9 "$Z_PPID"
