#!/bin/bash

echo " "
echo "######################################"
echo "# WOOF -> Resize physical volume:    #"
echo "######################################"
pvresize /dev/vda2

echo " "
echo "######################################"
echo "# WOOF -> Extending logical volume:  #"
echo "######################################"
lvextend -l +100%FREE /dev/mapper/VolGroup00-LogVol00

echo " "
echo "######################################"
echo "# WOOF -> Resizing filesystem:       #"
echo "######################################"
resize2fs /dev/mapper/VolGroup00-LogVol00

echo " "
echo "######################################"
echo "# WOOF -> Stopping firewall:         #"
echo "######################################"
service iptables stop

echo " "
echo "######################################"
echo "# WOOF -> Initialize VM:             #"
echo "######################################"
puppet apply ../manifests/init_vm.pp

echo " "
echo "######################################"
echo "# WOOF -> Done                       #"
echo "######################################"

