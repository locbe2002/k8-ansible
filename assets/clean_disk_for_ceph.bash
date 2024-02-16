#!/bin/bash

DISK="/dev/sda3"

echo "########################################################"
echo "WARNING: Clearing all data from disk: $DISK !!!"
echo "Will sleep here for 10 seconds so you can hit CTRL-C"
echo "to cancel this operation."
echo "########################################################"

sleep 10
#sgdisk --zap-all $DISK //zvi.k: This ones get stuck some times
dd if=/dev/zero of="$DISK" bs=1M count=100 oflag=direct,dsync
partprobe $DISK

