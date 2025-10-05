#!/bin/bash
# Script to back up all users home directories under /home and keeps backups for 7 days only

# Get a list of all user directories in /home
list_of_users=$(ls /home)

# Loop through each user
for i in $list_of_users
do
    # Create the backup directory for the user if it doesn't exist
    if [[ ! -d /backups/users/$i ]]; then
        mkdir -p /backups/users/$i
    fi

    # Set the backup filename with date
    backup_name="${i}_home_$(date +%F).tar.gz"

    # Create and compress the archive
    tar -czf /backups/users/"$i"/"$backup_name" /home/"$i"

    # Remove backups older than 7 days
    find /backups/users/"$i" -type f -name "*.tar.gz" -mtime +7 -exec rm -f {} \;

done
