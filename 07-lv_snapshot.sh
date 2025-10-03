#!/bin/bash

# Description: Creates and mounts a snapshot of a logical volume.
# Note: This script is intended to be scheduled manually using `at` or cron.

snap_size="5G"
original_logical_volume="/dev/vg2025/logical-volume-1"
snap_logical_volume_name="snap_$(date +%F)"
mount_point="/mnt/$snap_logical_volume_name"

# Create mount point if it doesn't exist
if [[ ! -d "$mount_point" ]]; then
    mkdir -p "$mount_point"
fi

# Create snapshot
lvcreate -L "$snap_size" -n "$snap_logical_volume_name" -s "$original_logical_volume"

# Mount snapshot
mount "/dev/vg2025/$snap_logical_volume_name" "$mount_point"

echo "Snapshot $snap_logical_volume_name created and mounted at $mount_point"

# Scheduling hint (example for one-time run):
# at 12:00 AM Thu -f /path/to/lv_snapshot.sh
