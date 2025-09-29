#!/bin/bash
# Script: Backup a MySQL/MariaDB database and compress the backup
# Works for both MariaDB and MySQL since both use mysqldump

read -p "Enter the User (default root): " user
if [[ -z "$user" ]]; then
    user="root"
fi 

# Ask for the MariaDB password (input hidden for security)
read -s -p "Enter the Password: " password
echo " "

# Ask the user to enter the database name (default: company)
read -p "Enter the Database (default company): " database
if [[ -z "$database" ]]; then
    database="company"
fi 

# Set backup filename with the current date
backup=database_backup_$(date +%F)

# Ensure the backup directory exists
mkdir -p /Backup/database

# Take the backup using mysqldump
mysqldump -u "$user" -p"$password" "$database" > /Backup/database/"$backup"

# Verify backup was created
if [[ -f /Backup/database/"$backup" ]]; then 
    echo "Backup taken successfully"
else
    echo "XXX Wrong inputs XXX"
fi

# Compress the backup using tar and gzip
tar -czf /Backup/database/"$backup".tar.gz /Backup/database/"$backup"

# Verify compression success
if [[ -f /Backup/database/"$backup".tar.gz" ]]; then
    echo "Compressed successfully"

    # Remove the uncompressed backup file
    rm -f /Backup/database/"$backup"
fi
