#!/bin/bash
# Script to log top 5 CPU and Memory consuming processes
# Logs are saved under /var/log/cpu_report.log and /var/log/memory_report.log

# ---------------- CPU Report ----------------
echo "$(date)" >> /var/log/cpu_report.log
echo "USER  %CPU  COMMAND" >> /var/log/cpu_report.log
ps aux | tail -n+2 | sort -k3,3 -nr | awk '{ print $1, $3, $11 }' | head -n 5 >> /var/log/cpu_report.log
echo "-------------------------------------------------" >> /var/log/cpu_report.log

# ---------------- Memory Report ----------------
echo "$(date)" >> /var/log/memory_report.log
echo "USER  %MEM  COMMAND" >> /var/log/memory_report.log
ps aux | tail -n+2 | sort -k4,4 -nr | awk '{ print $1, $4, $11 }' | head -n 5 >> /var/log/memory_report.log
echo "-------------------------------------------------" >> /var/log/memory_report.log

# Schedule example (every 30 minutes), add this line to crontab file using (crontab -e) command
# */30 * * * * bash /root/10-system_resource_report.sh
