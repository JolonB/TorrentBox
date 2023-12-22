#!/bin/bash

# Sleep to give some time for the drive to mount itself
sleep 30

# Check for valid number of USB storage devices mounted
#if [[ $(mount | grep -c "$default_mount") -ne 1 ]]; then
#    echo "$(mount)"
#    echo "There should only be one USB device connected. Exiting..."
#    exit 1
#fi

# Check if drive is mounted
mount_point="/mnt/mediadrv"
if ( findmnt --mountpoint $mount_point ); then
  # Create the TV and Movies directories, if they haven't already been
  mkdir -p "$mount_point/TV"
  mkdir -p "$mount_point/Movies"
  # Set the drive permissions
  chmod 777 $mount_point -R
else
  # Kill qBittorrent. We don't want to download anything
  pkill qbittorrent-nox
fi


