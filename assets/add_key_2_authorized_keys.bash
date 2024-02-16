#!/bin/bash

if [[ ${#1} -eq 0 ]]; then
   echo "Usage: Command publicKey user"
   exit
fi

keyfx=$1
user=$2
sshdir="/home/${user}/.ssh"
lx=$( cat $keyfx )
klen=300

if [[ ! -d $sshdir ]]; then
   mkdir $sshdir
   chmod 700 $sshdir
fi

for item in $lx ; do
   let zlen=${#item}
   if [[ $zlen -gt $keylen ]] ; then
      if [[ -f ${sshdir}/authorized_keys ]]; then
         let res=$( grep $item ${sshdir}/authorized_keys | wc -l | awk '{print $1}')
         if [[ $res -eq 0 ]]; then
            echo $lx >> ${sshdir}/authorized_keys
            exit
         fi
      else
         echo $lx > ${sshdir}/authorized_keys 
      fi
   fi
done

chown ${user}:${user} ${sshdir}/authorized_keys
chmod 400 ${sshdir}/authorized_keys

