#!/bin/bash

myhost=$( hostname )
case $myhost in
ip-100-66-19-207.eu-west-1.compute.internal )
  app=app-001 ;;
ip-100-66-20-21.eu-west-1.compute.internal )
  app=app-002 ;;
ip-100-66-22-6.eu-west-1.compute.internal )
  app=app-003 ;;
ip-100-66-19-164.eu-west-1.compute.internal )
  app=app-004 ;;
ip-100-66-18-214.eu-west-1.compute.internal )
  app=app-005 ;;
esac

bd=/pv
mkdir -p $bd
chmod 777 $bd

#pv_sizes="1~10 2~10 5~10 10~6"
pv_sizes="1~6 2~6 5~6 10~5"

mkdir -p $bd 
for pvsize in $( echo $pv_sizes ); do
    echo $pvsize
    sz=$( echo $pvsize | cut -d~ -f1 )
    let nummloop=$( echo $pvsize | cut -d~ -f2 )
    let idx=1
    while [[ ${idx} -lt ${nummloop} ]]; do
      dx="${bd}/${app}-${sz}g-${idx}"
      echo "Will creae dir: $dx"
      mkdir $dx
      let idx=${idx}+1
    done
done 

chmod -R 777 $bd
