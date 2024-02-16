#!/bin/bash

for mp in $(mount | grep kubelet | awk '{print $3}'); do
   umount $mp
done
