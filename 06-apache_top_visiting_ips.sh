#!/bin/bash
# Script: Find the top 5 most frequent visitor IPs from Apache access log
# Default log path: /var/log/httpd/access.log (RHEL/CentOS)
# For Ubuntu/Debian, use: /var/log/apache2/access.log

LOG_FILE="/var/log/httpd/access.log"

# Check if log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Extract and display the top 5 most visited IPs with their counts
echo "Top 5 most visited IPs:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5
