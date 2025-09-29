#!/bin/bash
# Script: Check if critical services are enabled, and enable them if disabled

# List of critical services to check
for i in sshd.service httpd.service crond.service chronyd.service firewalld.service
do
    # Get service status: returns "enabled" or "disabled"
    status="$(systemctl is-enabled $i)"

    if [[ "$status" == "enabled" ]]; then
        echo "$i is enabled"
    else
        echo "$i is disabled ... enabling it now"

        # Enable the service and start it immediately
        systemctl enable --now $i
    fi
done
