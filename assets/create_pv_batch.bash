#!/bin/bash

#app=app-001
tmplt=3.create-pv.yaml.TMPLT
tmpfx=create-pv.tmp.yaml.$$
pv_sizes="1~6 2~6 5~6 10~5"
sz=1
remdir=/root/docker_k8s/storage
cd ${remdir}
nlist="ip-100-66-19-207.eu-west-1.compute.internal~app-001 ip-100-66-20-21.eu-west-1.compute.internal~app-002 ip-100-66-22-6.eu-west-1.compute.internal~app-003 ip-100-66-19-164.eu-west-1.compute.internal~app-004 ip-100-66-18-214.eu-west-1.compute.internal~app-005"
#nlist="ip-100-66-20-21.eu-west-1.compute.internal~app-002 ip-100-66-22-6.eu-west-1.compute.internal~app-003 ip-100-66-19-164.eu-west-1.compute.internal~app-004"
#nlist="ip-100-66-19-164.eu-west-1.compute.internal~app-004 ip-100-66-18-214.eu-west-1.compute.internal~app-005"
for znodefull in $( echo $nlist ); do
   for fpv in $( echo $pv_sizes ); do
      sz=$( echo $fpv | cut -d~ -f1)
      cnt=$( echo $fpv | cut -d~ -f2)
      let idx=1
      znode=$( echo $znodefull | cut -d~ -f1 )
      app=$( echo $znodefull | cut -d~ -f2 )
      while [[ ${idx} -lt ${cnt} ]]; do
         zname="${app}-${sz}g-${idx}"
         echo "Creating pv $app on node $znodefull"
         cat $tmplt | sed "s/ZNAME/${zname}/" | sed "s/ZSIZE/${sz}/" | sed "s/ZNODE/${znode}/" > $tmpfx
         sleep 1
         kubectl create -f $tmpfx
         let idx=${idx}+1
      done
   done
done


