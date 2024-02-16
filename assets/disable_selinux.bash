#!/bin/bash

res=$( grep "^SELINUX=enforcing$" /etc/selinux/config )
if [[ ${#res} -gt 0 ]]; then
   echo "Will disable selinux..."
   cp /etc/selinux/config /etc/selinux/config.bkp
   cat /etc/selinux/config.bkp | sed 's/^SELINUX=enforcing$/#&\
SELINUX=disabled/' > /etc/selinux/config

else

res=$( grep "^SELINUX=permissive$" /etc/selinux/config )
if [[ ${#res} -gt 0 ]]; then
   echo "Will disable selinux..."
   cp /etc/selinux/config /etc/selinux/config.bkp
   cat /etc/selinux/config.bkp | sed 's/^SELINUX=permissive$/#&\
SELINUX=disabled/' > /etc/selinux/config
fi 

fi
