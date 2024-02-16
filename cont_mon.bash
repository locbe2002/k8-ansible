#!/bin/bash

basefx1=dmsg
basefx2=ipaddr
SLEEPTIME=180
MAXLOOP=300
let cnt=1
while [[ $cnt -lt $MAXLOOP ]]; do
    dt=$( date +%m%d%y_%H%M%S )
    echo "Running loop $cnt for: $dt"
    fx1="${basefx1}_${dt}"
    fx2="${basefx2}_${dt}"
    dmesg >> $fx1
    ip addr > $fx2
    let cnt=${cnt}+1
    sleep $SLEEPTIME
done


