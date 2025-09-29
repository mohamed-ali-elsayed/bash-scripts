#!/bin/bash
# Backup script: Archives /etc, /home, and /root, then transfers backups to server2:/root/backup/

# Loop through important directories to back up
for dir in /etc /home /root
do
    # Generate timestamp (HH-MM format) for unique backup names
    timestamp=$(date +%H-%M)

    # Extract directory name (e.g., "etc" from "/etc")
    base=$(basename "$dir")

    # Construct archive name
    archive="${base}_backup_${timestamp}.tar"

    # Create a tar archive of the directory
    tar -cf "$archive" "$dir"

    # Verify tar creation was successful
    if [ $? -ne 0 ]; then
        echo "Problem happened while creating archive for $dir"
        exit 99
    fi

    # Ensure archive file exists
    if [ -f "$archive" ]; then
        # Compress archive with xz
        xz "$archive"

        # Send compressed archive to remote server (port 2222)
        scp -P 2222 "${archive}.xz" root@192.168.100.192:/root/backup/

        # Verify file transfer success
        if [ $? -eq 0 ]; then
            # Remove local copy if transfer succeeded
            rm -f "${archive}.xz"
        else
            echo "Transfer did not complete for $dir"
        fi
    else
        echo "There is no archive for $dir"
    fi
done
