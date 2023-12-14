#!/bin/bash

# Sleep to give some time for the drive to mount itself
sleep 60

default_mount="/media/pi"
dest_mount="/mnt/mediadrv"
mkdir -p "$dest_mount"

# Check for valid number of USB storage devices mounted
if [[ $(mount | grep -c "$default_mount") -ne 1 ]]; then
    echo "$(mount)"
    echo "There should only be one USB device connected. Exiting..."
    exit 1
fi

set -e
# Find the /dev path for the drive
device_path=$(mount | awk -v default_mount="$default_mount" '$0 ~ default_mount {print $1}')

# Mount it in the desired location
mount "$device_path" "$dest_mount"
set +e

# Create the TV and Movies directories
mkdir -p "$dest_mount/TV"
mkdir -p "$dest_mount/Movies"

