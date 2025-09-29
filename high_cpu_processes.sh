#!/bin/bash
# Script: Display processes consuming more than 1% CPU

# Show USER header line OR processes where CPU usage ($3) >= 1
ps aux | awk '$3 >= 1 || $1 == "USER" {print $1, $2, $3, $11}'
