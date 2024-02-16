#!/bin/bash

# A script to run all setup scripts (steps 5 - 15):
sleeptime=8
dt=$( date +%m%d%y_%H%M%S )
resfx="ansible_setup_run_${dt}"

echo "Running now all setup scripts on VMs in inventory file."
echo "Following is a list of VMs in inventory:"
cat inventory
echo ""
read -p "If the VMs in inventory is correct enter Y to continue: " myvar
if [[ ${myvar} != "Y" ]]; then
    echo "Will exit now without doing any work..."
    exit
fi
echo "You selected to continue running the script"
echo "Result of scripts run will be saved to $resfx"

echo "Run of VMs setup at $dt" > $resfx
echo "Inventory of VMs is" >> $resfx
cat inventory >> $resfx
echo "" >> $resfx

for fx in $( ls -1v setup-*yaml ); do
    echo "Will run $fx" >> $resfx
    echo "Will run $fx" now 
    ansible-playbook -i inventory $fx 2>&1 | tee -a $resfx
    echo "" >> $resfx
    echo "Sleeping $sleeptime seconds before running next script"
    sleep $sleeptime 
done

echo "Seupt has finished running, results are in $resfx file"


