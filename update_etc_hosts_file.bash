#!/bin/bash

lablistfx=$1 
if [[ "$1" == "" ]]; then
    lablistfx=/root/docker_k8s/scripts/
fi

dt=$( date +%m%d%y_%H%M%S )
myip=$( ip addr | sed -n '/2: ens/,/inet 10/p' | grep inet | awk '{print $2}' )

cp /etc/hosts /etc/hosts.bkp.${dt}

res=$( grep ANSIBLE /etc/hosts )
if [[ ${#res} -eq 0 ]]; then
    grep -v ${myip} $lablistfx | awk -F, '{ print $1,$2,$3}' 
fi
